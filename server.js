const http = require('http');
const fs = require('fs');
const path = require('path');
const mysql = require('mysql2/promise');

const PORT = 3000;

const db = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '12345',
    database: 'cse_reviewer'
});

const mimeTypes = {
    '.html': 'text/html',
    '.js': 'text/javascript',
    '.css': 'text/css',
    '.json': 'application/json',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.svg': 'image/svg+xml'
};

const server = http.createServer(async (req, res) => {
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
                    const [categories] = await db.query('SELECT * FROM categories ORDER BY is_professional, name');
                    res.writeHead(200, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify(categories));
                    break;

                case 'getQuestions':
                    const categoryId = url.searchParams.get('category_id');
                    const limit = parseInt(url.searchParams.get('limit')) || 20;
                    let questions;
                    if (categoryId) {
                        [questions] = await db.query('SELECT * FROM questions WHERE category_id = ? ORDER BY RAND() LIMIT ?', [categoryId, limit]);
                    } else {
                        [questions] = await db.query('SELECT * FROM questions ORDER BY RAND() LIMIT ?', [limit]);
                    }
                    questions.forEach(q => delete q.correct_answer);
                    res.writeHead(200, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify(questions));
                    break;

                case 'getRandomQuestion':
                    const catId = url.searchParams.get('category_id');
                    let [randQ] = catId 
                        ? await db.query('SELECT * FROM questions WHERE category_id = ? ORDER BY RAND() LIMIT 1', [catId])
                        : await db.query('SELECT * FROM questions ORDER BY RAND() LIMIT 1');
                    if (randQ[0]) delete randQ[0].correct_answer;
                    res.writeHead(200, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify(randQ[0] || { error: 'No question found' }));
                    break;

                case 'getStats':
                    const [totalQ] = await db.query('SELECT COUNT(*) as count FROM questions');
                    const [totalC] = await db.query('SELECT COUNT(*) as count FROM categories');
                    const [catStats] = await db.query(`
                        SELECT c.name, COUNT(q.id) as question_count 
                        FROM categories c 
                        LEFT JOIN questions q ON c.id = q.category_id 
                        GROUP BY c.id, c.name
                    `);
                    res.writeHead(200, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({
                        total_questions: totalQ[0].count,
                        total_categories: totalC[0].count,
                        by_category: catStats
                    }));
                    break;

                case 'submitAnswer':
                    let body = '';
                    for await (const chunk of req) body += chunk;
                    const { question_id, answer } = JSON.parse(body);
                    const [q] = await db.query('SELECT correct_answer, explanation FROM questions WHERE id = ?', [question_id]);
                    if (!q[0]) {
                        res.writeHead(404, { 'Content-Type': 'application/json' });
                        res.end(JSON.stringify({ error: 'Question not found' }));
                        break;
                    }
                    const isCorrect = answer.toUpperCase() === q[0].correct_answer.toUpperCase();
                    res.writeHead(200, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({
                        correct: isCorrect,
                        correct_answer: q[0].correct_answer,
                        explanation: q[0].explanation
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
