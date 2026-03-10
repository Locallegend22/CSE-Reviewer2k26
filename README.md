# CSE Reviewer 2k26

A comprehensive Civil Service Exam Reviewer application built with PHP, MySQL, HTML, CSS, and JavaScript.

## Requirements

- Web Server (Apache/Nginx/XAMPP/WAMP)
- PHP 7.4 or higher
- MySQL 5.7 or higher
- Web Browser

## Installation

### Option 1: Using XAMPP/WAMP

1. Install XAMPP or WAMP on your computer.
2. Start Apache and MySQL services.
3. Copy all files to the `htdocs` (XAMPP) or `www` (WAMP) folder.
4. Open your browser and navigate to: `http://localhost/cse-reviewer2k26/setup.php`
5. Enter your MySQL credentials and click "Setup Database".
6. After setup, access the reviewer at: `http://localhost/cse-reviewer2k26/index.html`

### Option 2: Manual Database Setup

1. Open phpMyAdmin or MySQL Workbench.
2. Create a new database named `cse_reviewer`.
3. Import the `database.sql` file.
4. Update `db.php` with your MySQL credentials:
   ```php
   $username = 'your_username';
   $password = 'your_password';
   ```
5. Open `index.html` in your browser.

## Topics Covered

### Civil Service Level (Subprofessional)
- Philippine Constitution
- Code of Conduct and Ethical Standards (R.A. 6713)
- Peace and Human Rights Issues
- Environment Management and Protection
- Verbal Ability (English)
  - Word Meaning
  - Sentence Completion
  - Error Recognition
  - Sentence Structure
  - Paragraph Organization
  - Reading Comprehension
- Verbal Ability (Filipino)
  - Word Meaning
  - Sentence Completion
  - Error Recognition
  - Reading Comprehension
- Numerical Ability
  - Basic Operations
  - Number Sequence
  - Word Problems

### Professional Level Only
- Analytical Ability
  - Word Analogy
  - Symbolic Logic/Abstract Reasoning
  - Identifying Assumptions and Drawing Conclusions
  - Data Interpretation

## Features

- Browse questions by category
- Practice quizzes with multiple questions
- Immediate feedback with explanations
- Progress tracking
- Responsive design (works on mobile)
- Filter by exam type (CS/Professional)

## File Structure

```
CSE-Reviewer2k26/
├── index.html       # Main application
├── api.php          # Backend API
├── db.php           # Database connection
├── setup.php        # Database setup wizard
├── database.sql     # Database schema and seed data
└── README.md        # This file
```

## License

This project is for educational purposes only.
