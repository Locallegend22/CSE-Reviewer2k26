<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Database Setup - CSE Reviewer 2k26</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: #f8f9fa;
        }
        .card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 { color: #1a73e8; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: 600; }
        input {
            width: 100%;
            padding: 10px;
            border: 1px solid #dadce0;
            border-radius: 5px;
            box-sizing: border-box;
        }
        button {
            background: #1a73e8;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover { background: #1557b0; }
        .success { color: #34a853; }
        .error { color: #ea4335; }
        .info { background: #e8f0fe; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="card">
        <h1>Database Setup</h1>
        
        <div class="info">
            <strong>Instructions:</strong><br>
            1. Make sure MySQL is running on your computer.<br>
            2. Enter your MySQL username and password.<br>
            3. Click "Setup Database" to create the database and tables.
        </div>

        <form method="post">
            <div class="form-group">
                <label>MySQL Username:</label>
                <input type="text" name="username" value="root" required>
            </div>
            <div class="form-group">
                <label>MySQL Password:</label>
                <input type="password" name="password" placeholder="Enter password if any">
            </div>
            <button type="submit" name="setup">Setup Database</button>
        </form>

        <?php
        if (isset($_POST['setup'])) {
            $username = $_POST['username'];
            $password = $_POST['password'];
            
            try {
                $pdo = new PDO("mysql:host=localhost", $username, $password);
                $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                
                $sql = file_get_contents('database.sql');
                $statements = array_filter(array_map('trim', explode(';', $sql)));
                
                $pdo->exec("CREATE DATABASE IF NOT EXISTS cse_reviewer");
                $pdo->exec("USE cse_reviewer");
                
                foreach ($statements as $statement) {
                    if (!empty($statement) && stripos($statement, 'CREATE DATABASE') === false) {
                        try {
                            $pdo->exec($statement);
                        } catch (Exception $e) {
                            // Skip if table already exists
                        }
                    }
                }
                
                echo '<p class="success" style="margin-top:20px;"><strong>Setup Complete!</strong></p>';
                echo '<p>Database "cse_reviewer" has been created with sample questions.</p>';
                echo '<p>You can now open <a href="index.html">index.html</a> to start using the reviewer.</p>';
                
            } catch (PDOException $e) {
                echo '<p class="error" style="margin-top:20px;"><strong>Error:</strong> ' . htmlspecialchars($e->getMessage()) . '</p>';
            }
        }
        ?>
    </div>
</body>
</html>
