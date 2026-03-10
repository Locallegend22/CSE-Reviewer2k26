<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once 'db.php';

$action = $_GET['action'] ?? '';

switch ($action) {
    case 'getCategories':
        getCategories();
        break;
    case 'getQuestions':
        getQuestions();
        break;
    case 'getRandomQuestion':
        getRandomQuestion();
        break;
    case 'getCategoryQuestions':
        getCategoryQuestions();
        break;
    case 'submitAnswer':
        submitAnswer();
        break;
    case 'getStats':
        getStats();
        break;
    default:
        http_response_code(400);
        echo json_encode(['error' => 'Invalid action']);
        break;
}

function getCategories() {
    global $pdo;
    $stmt = $pdo->query("SELECT * FROM categories ORDER BY is_professional, name");
    $categories = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($categories);
}

function getQuestions() {
    global $pdo;
    $categoryId = $_GET['category_id'] ?? null;
    $limit = $_GET['limit'] ?? 20;
    
    if ($categoryId) {
        $stmt = $pdo->prepare("SELECT * FROM questions WHERE category_id = ? ORDER BY RAND() LIMIT ?");
        $stmt->execute([$categoryId, $limit]);
    } else {
        $stmt = $pdo->query("SELECT * FROM questions ORDER BY RAND() LIMIT $limit");
    }
    
    $questions = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach ($questions as &$q) {
        unset($q['correct_answer']);
    }
    
    echo json_encode($questions);
}

function getRandomQuestion() {
    global $pdo;
    $categoryId = $_GET['category_id'] ?? null;
    
    if ($categoryId) {
        $stmt = $pdo->prepare("SELECT * FROM questions WHERE category_id = ? ORDER BY RAND() LIMIT 1");
        $stmt->execute([$categoryId]);
    } else {
        $stmt = $pdo->query("SELECT * FROM questions ORDER BY RAND() LIMIT 1");
    }
    
    $question = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($question) {
        unset($question['correct_answer']);
    }
    
    echo json_encode($question ?: ['error' => 'No question found']);
}

function getCategoryQuestions() {
    global $pdo;
    $categoryId = (int)$_GET['category_id'];
    
    $stmt = $pdo->prepare("SELECT id, question_text, option_a, option_b, option_c, option_d FROM questions WHERE category_id = ? ORDER BY RAND()");
    $stmt->execute([$categoryId]);
    $questions = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode($questions);
}

function submitAnswer() {
    global $pdo;
    $input = json_decode(file_get_contents('php://input'), true);
    
    $questionId = $input['question_id'] ?? null;
    $answer = $input['answer'] ?? null;
    
    if (!$questionId || !$answer) {
        http_response_code(400);
        echo json_encode(['error' => 'Missing question_id or answer']);
        return;
    }
    
    $stmt = $pdo->prepare("SELECT correct_answer, explanation FROM questions WHERE id = ?");
    $stmt->execute([$questionId]);
    $question = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$question) {
        http_response_code(404);
        echo json_encode(['error' => 'Question not found']);
        return;
    }
    
    $isCorrect = strtoupper($answer) === strtoupper($question['correct_answer']);
    
    echo json_encode([
        'correct' => $isCorrect,
        'correct_answer' => $question['correct_answer'],
        'explanation' => $question['explanation']
    ]);
}

function getStats() {
    global $pdo;
    
    $totalQuestions = $pdo->query("SELECT COUNT(*) as count FROM questions")->fetch(PDO::FETCH_ASSOC);
    $totalCategories = $pdo->query("SELECT COUNT(*) as count FROM categories")->fetch(PDO::FETCH_ASSOC);
    
    $categoryStats = $pdo->query("
        SELECT c.name, COUNT(q.id) as question_count 
        FROM categories c 
        LEFT JOIN questions q ON c.id = q.category_id 
        GROUP BY c.id, c.name
    ")->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode([
        'total_questions' => $totalQuestions['count'],
        'total_categories' => $totalCategories['count'],
        'by_category' => $categoryStats
    ]);
}
?>
