const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 3000;

const data = JSON.parse(fs.readFileSync('questions.json', 'utf8'));

const mimeTypes = {
    '.html': 'text/html',
    '.js': 'text/javascript',
    '.css': 'text/css',
    '.json': 'application/json',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.svg': 'image/svg+xml'
};

function shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
}

const server = http.createServer((req, res) => {
    const url = new URL(req.url, `http://localhost:${PORT}`);
    const pathname = url.pathname;

    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

    if (req.method === 'OPTIONS') {
        res.writeHead(200);
        res.end();
        return;
    }

    if (pathname.startsWith('/api')) {
        const action = url.searchParams.get('action');
        
        try {
            switch (action) {
                case 'getCategories':
                    res.writeHead(200, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify(data.categories));
                    break;

                case 'getQuestions':
                    const categoryId = url.searchParams.get('category_id');
                    const limit = parseInt(url.searchParams.get('limit')) || 20;
                    let questions = [...data.questions];
                    
                    if (categoryId) {
                        questions = questions.filter(q => q.category_id === parseInt(categoryId));
                    }
                    
                    questions = shuffleArray(questions).slice(0, limit);
                    questions.forEach(q => delete q.correct_answer);
                    
                    res.writeHead(200, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify(questions));
                    break;

                case 'getRandomQuestion':
                    const catId = url.searchParams.get('category_id');
                    let randQ = [...data.questions];
                    
                    if (catId) {
                        randQ = randQ.filter(q => q.category_id === parseInt(catId));
                    }
                    
                    randQ = shuffleArray(randQ)[0];
                    if (randQ) delete randQ.correct_answer;
                    
                    res.writeHead(200, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify(randQ || { error: 'No question found' }));
                    break;

                case 'getStats':
                    res.writeHead(200, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({
                        total_questions: data.questions.length,
                        total_categories: data.categories.length,
                        by_category: data.categories.map(c => ({
                            name: c.name,
                            question_count: data.questions.filter(q => q.category_id === c.id).length
                        }))
                    }));
                    break;

                case 'submitAnswer':
                    let body = '';
                    for await (const chunk of req) body += chunk;
                    const { question_id, answer } = JSON.parse(body);
                    
                    const q = data.questions.find(q => q.id === question_id);
                    if (!q) {
                        res.writeHead(404, { 'Content-Type': 'application/json' });
                        res.end(JSON.stringify({ error: 'Question not found' }));
                        break;
                    }
                    
                    const isCorrect = answer.toUpperCase() === q.correct_answer.toUpperCase();
                    res.writeHead(200, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({
                        correct: isCorrect,
                        correct_answer: q.correct_answer,
                        explanation: q.explanation
                    }));
                    break;

                default:
                    res.writeHead(400, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({ error: 'Invalid action' }));
            }
        } catch (err) {
            res.writeHead(500, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify({ error: err.message }));
        }
        return;
    }

    let filePath = pathname === '/' ? '/index.html' : pathname;
    filePath = path.join(__dirname, filePath);

    const ext = path.extname(filePath);
    const contentType = mimeTypes[ext] || 'application/octet-stream';

    fs.readFile(filePath, (err, content) => {
        if (err) {
            if (err.code === 'ENOENT') {
                res.writeHead(404);
                res.end('404 Not Found');
            } else {
                res.writeHead(500);
                res.end('500 Internal Server Error');
            }
        } else {
            res.writeHead(200, { 'Content-Type': contentType });
            res.end(content);
        }
    });
});

server.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
