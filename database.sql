-- Civil Service Exam Reviewer Database
-- Run this SQL to create the database and tables

CREATE DATABASE IF NOT EXISTS cse_reviewer;
USE cse_reviewer;

-- Categories table
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    is_professional BOOLEAN DEFAULT FALSE,
    language VARCHAR(50) DEFAULT 'English'
);

-- Questions table
CREATE TABLE IF NOT EXISTS questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    question_text TEXT NOT NULL,
    option_a VARCHAR(500) NOT NULL,
    option_b VARCHAR(500) NOT NULL,
    option_c VARCHAR(500) NOT NULL,
    option_d VARCHAR(500) NOT NULL,
    correct_answer CHAR(1) NOT NULL,
    explanation TEXT,
    difficulty ENUM('easy', 'medium', 'hard') DEFAULT 'medium',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Insert categories based on the provided topics
INSERT INTO categories (name, description, is_professional, language) VALUES
-- Philippine Constitution
('Philippine Constitution', 'Questions about the 1987 Philippine Constitution', FALSE, 'English'),
-- Code of Conduct
('Code of Conduct and Ethics (R.A. 6713)', 'Code of Conduct and Ethical Standards for Public Officials and Employees', FALSE, 'English'),
-- Peace and Human Rights
('Peace and Human Rights Issues', 'Peace and Human Rights Issues and Concepts', FALSE, 'English'),
-- Environment Management
('Environment Management and Protection', 'Environment Management and Protection', FALSE, 'English'),
-- Verbal Ability - English
('Verbal Ability - Word Meaning', 'Understanding word meanings in English', FALSE, 'English'),
('Verbal Ability - Sentence Completion', 'Fill in the blank sentences', FALSE, 'English'),
('Verbal Ability - Error Recognition', 'Identify grammatical errors', FALSE, 'English'),
('Verbal Ability - Sentence Structure', 'Sentence structure and grammar', FALSE, 'English'),
('Verbal Ability - Paragraph Organization', 'Organize paragraphs logically', FALSE, 'English'),
('Verbal Ability - Reading Comprehension', 'Understand and analyze passages', FALSE, 'English'),
-- Verbal Ability - Filipino
('Verbal Ability - Word Meaning (Filipino)', 'Understanding word meanings in Filipino', FALSE, 'Filipino'),
('Verbal Ability - Sentence Completion (Filipino)', 'Fill in the blank sentences in Filipino', FALSE, 'Filipino'),
('Verbal Ability - Error Recognition (Filipino)', 'Identify grammatical errors in Filipino', FALSE, 'Filipino'),
('Verbal Ability - Reading Comprehension (Filipino)', 'Understand Filipino passages', FALSE, 'Filipino'),
-- Numerical Ability
('Numerical Ability - Basic Operations', 'Basic mathematical operations', FALSE, 'English'),
('Numerical Ability - Number Sequence', 'Number sequence and patterns', FALSE, 'English'),
('Numerical Ability - Word Problems', 'Math word problems', FALSE, 'English'),
-- Professional Only
('Analytical Ability - Word Analogy', 'Word analogy and relationships', TRUE, 'English'),
('Analytical Ability - Symbolic Logic', 'Symbolic logic and abstract reasoning', TRUE, 'English'),
('Analytical Ability - Identifying Assumptions', 'Identifying assumptions and drawing conclusions', TRUE, 'English'),
('Analytical Ability - Data Interpretation', 'Charts, graphs, and data interpretation', TRUE, 'English');

-- Sample Questions for Philippine Constitution
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(1, 'What is the fundamental law of the Philippines?', 'Commonwealth Act No. 1', '1987 Constitution', '1973 Constitution', 'Executive Order No. 1', 'B', 'The 1987 Constitution is the current fundamental law of the Philippines.', 'easy'),
(1, 'Who is the head of the Executive Branch in the Philippines?', 'President', 'Vice President', 'Speaker of the House', 'Chief Justice', 'A', 'The President is the head of the Executive Branch.', 'easy'),
(1, 'How many senators are there in the Philippine Senate?', '24', '12', '30', '50', 'A', 'There are 24 senators in the Philippine Senate.', 'easy'),
(1, 'What is the principle that states that the state cannot deprive a person of life, liberty, or property without due process?', 'Equal Protection', 'Due Process', 'Police Power', 'Eminent Domain', 'B', 'Due Process requires fair procedures before deprivation of rights.', 'medium'),
(1, 'The Philippines adopts what form of government?', 'Parliamentary', 'Presidential', 'Federal', 'Monarchical', 'B', 'The Philippines adopts a presidential system of government.', 'easy');

-- Sample Questions for Code of Conduct (R.A. 6713)
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(2, 'What does R.A. 6713 stand for?', 'Republic Act 6713', 'Code of Conduct and Ethical Standards for Public Officials and Employees', 'Both A and B', 'None of the above', 'B', 'R.A. 6713 is formally known as the Code of Conduct and Ethical Standards for Public Officials and Employees.', 'easy'),
(2, 'Which of the following is NOT a core principle under R.A. 6713?', 'Transparency', 'Integrity', 'Partiality', 'Professionalism', 'C', 'The core principles are transparency, integrity, and professionalism. Partiality is not listed.', 'medium'),
(2, 'Public officials should act with transparency in all their transactions. What does this mean?', 'Hide information', 'Make information accessible', 'Only share with friends', 'Keep records private', 'B', 'Transparency means making information accessible to the public.', 'easy'),
(2, 'What is the penalty for violation of R.A. 6713?', 'Verbal warning', 'Suspension', 'Dismissal and perpetual disqualification', 'Community service', 'C', 'Violations may result in dismissal and perpetual disqualification from public service.', 'medium'),
(2, 'A public official receives a gift from a supplier. What should the official do?', 'Accept it', 'Decline and report', 'Share with colleagues', 'Keep it for later', 'B', 'Public officials should decline gifts and report such incidents.', 'medium');

-- Sample Questions for Peace and Human Rights
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(3, 'What is the Universal Declaration of Human Rights?', 'A treaty', 'A declaration adopted by the UN', 'A law', 'A constitution', 'B', 'The UDHR is a declaration adopted by the United Nations in 1948.', 'easy'),
(3, 'Which right is considered a fundamental human right?', 'Right to education', 'Right to free food', 'Right to luxury', 'Right to fame', 'A', 'The right to education is a fundamental human right.', 'easy'),
(3, 'What is peace education?', 'Military training', 'Learning about conflict resolution and non-violence', 'History class', 'Physical education', 'B', 'Peace education focuses on conflict resolution and non-violence.', 'easy'),
(3, 'What does the term "human rights" refer to?', 'Privileges for the rich', 'Basic rights inherent to all humans', 'Government benefits only', 'Special rights for certain groups', 'B', 'Human rights are basic rights inherent to all human beings.', 'easy'),
(3, 'Which organization is primarily responsible for promoting human rights globally?', 'World Bank', 'United Nations', 'NATO', 'WTO', 'B', 'The United Nations is primarily responsible for promoting human rights globally.', 'easy');

-- Sample Questions for Environment Management
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(4, 'What is the primary cause of climate change?', 'Natural disasters', 'Human activities', 'Animal migration', 'Ocean currents', 'B', 'Human activities are the primary cause of climate change.', 'easy'),
(4, 'What does the 3R principle stand for?', 'Reduce, Reuse, Recycle', 'Respect, Reuse, Repeat', 'Reduce, Replace, Recycle', 'Review, Reuse, Reduce', 'A', 'The 3R principle stands for Reduce, Reuse, and Recycle.', 'easy'),
(4, 'Which gas is primarily responsible for the greenhouse effect?', 'Oxygen', 'Nitrogen', 'Carbon dioxide', 'Hydrogen', 'C', 'Carbon dioxide is the primary greenhouse gas.', 'easy'),
(4, 'What is biodiversity?', 'Population growth', 'Variety of life forms', 'Climate change', 'Pollution', 'B', 'Biodiversity refers to the variety of life forms on Earth.', 'easy'),
(4, 'What is sustainable development?', 'Rapid industrialization', 'Meeting present needs without compromising future generations', 'Unlimited resource use', 'Economic decline', 'B', 'Sustainable development meets present needs without compromising future generations.', 'medium');

-- Sample Questions for Verbal Ability - Word Meaning
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(5, 'Choose the synonym of "benevolent".', 'Cruel', 'Kind', 'Indifferent', 'Angry', 'B', 'Benevolent means kind and generous.', 'easy'),
(5, 'What is the antonym of "precise"?', 'Exact', 'Accurate', 'Vague', 'Careful', 'C', 'Vague is the opposite of precise.', 'easy'),
(5, 'The word "ephemeral" means:', 'Permanent', 'Lasting for a short time', 'Ancient', 'Beautiful', 'B', 'Ephemeral means lasting for a very short time.', 'medium'),
(5, 'What does "ambiguous" mean?', 'Clear', 'Uncertain or unclear', 'Important', 'Urgent', 'B', 'Ambiguous means open to more than one interpretation.', 'medium'),
(5, 'A "pragmatic" person is someone who:', 'Dreams a lot', 'Deals with things practically', 'Is always happy', 'Works slowly', 'B', 'A pragmatic person deals with things in a practical way.', 'medium');

-- Sample Questions for Sentence Completion
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(6, 'The scientist made a ___ discovery that changed our understanding of physics.', 'remarkable', 'boring', 'small', 'useless', 'A', 'Remarkable fits the context of an important scientific discovery.', 'easy'),
(6, 'Because of the heavy rain, the game was ___.', 'canceled', 'played', 'extended', 'started', 'A', 'The game was canceled due to heavy rain.', 'easy'),
(6, 'The student studied ___ to pass the exam.', 'lazily', 'hard', 'rarely', 'never', 'B', 'Studying hard is necessary to pass an exam.', 'easy'),
(6, 'Despite his ___ attempts, he could not solve the puzzle.', 'numerous', 'few', 'no', 'lazy', 'A', 'Numerous attempts suggests many tries were made.', 'medium'),
(6, 'The mountain was so ___ that few climbers reached the summit.', 'easy', 'accessible', 'formidable', 'small', 'C', 'Formidable means intimidating or difficult to overcome.', 'medium');

-- Sample Questions for Error Recognition
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(7, 'Find the error: "She go to school every day."', 'She', 'go', 'to school', 'every day', 'B', 'The correct form is "goes" for third person singular.', 'easy'),
(7, 'Find the error: "There is many reasons for this."', 'There', 'is', 'many reasons', 'for this', 'B', 'Use "are" with plural nouns like "reasons".', 'easy'),
(7, 'Find the error: "Me and him are friends."', 'Me', 'and', 'him', 'are friends', 'A', 'The correct form is "He and I" (subjective case).', 'medium'),
(7, 'Find the error: "The book is интересный."', 'The book', 'is', 'interesting', 'интересный', 'C', 'Use English words in English sentences.', 'easy'),
(7, 'Find the error: "She dont know the answer."', 'She', 'dont', 'know', 'the answer', 'B', 'The correct form is does not for third person singular.', 'easy');

-- Sample Questions for Sentence Structure
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(8, 'Which sentence has correct structure?', 'She quickly ran to store the.', 'She ran to the store quickly.', 'Quickly she ran to store.', 'Ran she to store quickly.', 'B', 'The correct order is subject + verb + object + adverb.', 'easy'),
(8, 'Choose the correctly punctuated sentence:', 'Lets eat grandma', 'Lets eat, grandma', 'Lets eat grandma.', 'Let us eat grandma', 'B', 'The apostrophe in lets and comma make it correct.', 'medium'),
(8, 'Which is a compound sentence?', 'The cat sat on the mat.', 'The cat sat on the mat and slept.', 'Because the cat was tired.', 'Running quickly.', 'B', 'A compound sentence has two independent clauses joined by "and".', 'medium'),
(8, 'Identify the simple sentence:', 'I like reading and writing.', 'Because I was tired, I went home.', 'She is smart but lazy.', 'While studying, I heard a noise.', 'A', 'A simple sentence has one subject and one verb phrase.', 'easy'),
(8, 'What type of sentence is: "Close the door!"', 'Declarative', 'Interrogative', 'Imperative', 'Exclamatory', 'C', 'An imperative gives a command or request.', 'easy');

-- Sample Questions for Paragraph Organization
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(9, 'What is the typical order of a well-organized paragraph?', 'Conclusion, supporting details, topic sentence', 'Topic sentence, supporting details, conclusion', 'Supporting details, topic sentence, conclusion', 'Any order is fine', 'B', 'The typical order is topic sentence first, then supporting details, then conclusion.', 'easy'),
(9, 'What is the main purpose of a topic sentence?', 'To summarize', 'To introduce the main idea', 'To provide examples', 'To conclude', 'B', 'The topic sentence introduces the main idea of the paragraph.', 'easy'),
(9, 'Which sentence would most likely be the conclusion of a paragraph?', 'First, gather all materials.', 'In conclusion, the project was successful.', 'Second, mix the ingredients.', 'Finally, present your findings.', 'B', 'The conclusion summarizes and wraps up the paragraph.', 'easy'),
(9, 'Transitional words like "however" and "therefore" help with:', 'Spelling', 'Paragraph organization and flow', 'Vocabulary', 'Handwriting', 'B', 'Transitional words help organize paragraphs and create flow.', 'easy'),
(9, 'A coherent paragraph should have:', 'Random ideas', 'Ideas that connect logically', 'Many short sentences', 'No clear connection', 'B', 'Coherent paragraphs have ideas that connect logically.', 'easy');

-- Sample Questions for Reading Comprehension
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(10, 'What is the main idea of a passage?', 'The smallest detail', 'The central message or theme', 'The author''s name', 'The number of paragraphs', 'B', 'The main idea is the central message or theme of the passage.', 'easy'),
(10, 'To answer comprehension questions, you should:', 'Guess without reading', 'Read the passage carefully first', 'Only read the questions', 'Skip difficult words', 'B', 'Always read the passage carefully before answering questions.', 'easy'),
(10, 'What is an inference?', 'Something stated directly', 'A conclusion based on evidence', 'A fact', 'A synonym', 'B', 'An inference is a conclusion drawn from evidence in the text.', 'medium'),
(10, 'The author\'s purpose in an informational text is usually to:', 'Entertain', 'Inform or explain', 'Persuade only', 'Confuse the reader', 'B', 'Informational texts aim to inform or explain.', 'easy'),
(10, 'What does "context clue" mean?', 'Looking at a dictionary', 'Using words around an unknown word to understand meaning', 'Asking the teacher', 'Guessing the answer', 'B', 'Context clues are words around an unknown word that help understand meaning.', 'medium');

-- Sample Questions for Filipino - Word Meaning
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(11, 'Ano ang kahulugan ng "masipag"?', 'Tamad', 'Matulungin', 'Masigasig sa Trabaho', 'Walang magawa', 'C', 'Ang masipag ay nangangahulugang masigasig sa paggawa.', 'easy'),
(11, 'Ang salitang "magbubukid" ay nangangahulugang:', 'Manggagawa sa factory', 'Nagtatanim sa bukid', 'Naninirahan sa lungsod', 'Nag-aaral sa paaralan', 'B', 'Ang magbubukid ay taong nagtatanim sa bukid.', 'easy'),
(11, 'Ano ang kasalungat ng "maalinsangan"?', 'Mainit', 'Maligamgam', 'Malamig', 'Mahapdi', 'C', 'Ang malamig ay kabaligtaran ng maalinsangan.', 'easy'),
(11, 'Ang "kagubatan" ay tumutukoy sa:', 'Karagatan', 'Bundok', 'Luwang ng puno', 'Lugar na marami ang puno', 'D', 'Ang kagubatan ay lugar na may maraming puno.', 'easy'),
(11, 'Ano ang kahulugan ng "pagmamahal"?', 'Galit', 'Paglalakbay', 'Pagmamahal ay pagmamahal', 'Paggalaw', 'C', 'Ang pagmamahal ay damdamin ng pagmamahal sa isang tao.', 'easy');

-- Sample Questions for Filipino - Sentence Completion
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(12, 'Si Maria ay ___ sa paaralan.', 'pumasok', 'kumain', 'natulog', 'naglaro', 'A', 'Si Maria ay pumasok sa paaralan ay wasto.', 'easy'),
(12, 'Ang bata ay ___ dahil may bisig siya.', 'umiiyak', 'tumatawa', 'naglalakad', 'natutulog', 'A', 'Ang bata ay umiiyak dahil sa takot.', 'easy'),
(12, 'Dapat tayong ___ sa mga matatanda.', 'magpakita ng galang', 'magtago', 'umalis', 'mag-ingay', 'A', 'Dapat tayong magpakita ng galang sa mga matatanda.', 'easy'),
(12, 'Si Juan ay___ng magaling na doktor.', 'gusto', 'nais', 'maging', 'tulungan', 'C', 'Si Juan ay nais maging doktor.', 'medium'),
(12, 'Ang mga ibon ay ___ sa himpapawid.', 'lumilipad', 'tumutulong', 'nagtatago', 'nakatayo', 'A', 'Ang mga ibon ay lumilipad sa himpapawid.', 'easy');

-- Sample Questions for Numerical Ability - Basic Operations
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(15, 'What is 256 + 178?', '424', '434', '444', '454', 'B', '256 + 178 = 434', 'easy'),
(15, 'What is 847 - 329?', '518', '528', '508', '538', 'A', '847 - 329 = 518', 'easy'),
(15, 'What is 24 × 15?', '340', '350', '360', '370', 'C', '24 × 15 = 360', 'easy'),
(15, 'What is 144 ÷ 12?', '10', '11', '12', '13', 'C', '144 ÷ 12 = 12', 'easy'),
(15, 'What is 2/5 + 3/5?', '1', '5/10', '1/5', '5/5', 'A', '2/5 + 3/5 = 5/5 = 1', 'medium');

-- Sample Questions for Numerical Ability - Number Sequence
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(16, 'What comes next: 2, 4, 6, 8, ?', '9', '10', '11', '12', 'B', 'This is an arithmetic sequence adding 2 each time.', 'easy'),
(16, 'What comes next: 1, 1, 2, 3, 5, 8, ?', '11', '12', '13', '14', 'C', 'This is the Fibonacci sequence: each number is the sum of the two preceding ones (5+8=13).', 'medium'),
(16, 'What comes next: 3, 6, 12, 24, ?', '36', '42', '48', '54', 'C', 'This is a geometric sequence multiplying by 2 each time (24×2=48).', 'medium'),
(16, 'What comes next: 1, 4, 9, 16, 25, ?', '30', '34', '36', '40', 'C', 'These are perfect squares: 1², 2², 3², 4², 5², 6² = 36', 'medium'),
(16, 'What comes next: 100, 90, 80, 70, ?', '50', '60', '65', '55', 'B', 'This is an arithmetic sequence subtracting 10 each time.', 'easy');

-- Sample Questions for Numerical Ability - Word Problems
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(17, 'A book costs Php 150. How much do 5 books cost?', 'Php 650', 'Php 700', 'Php 750', 'Php 800', 'C', '150 × 5 = Php 750', 'easy'),
(17, 'John has 45 candies. He gives 17 to his friend. How many does he have left?', '28', '27', '29', '26', 'A', '45 - 17 = 28', 'easy'),
(17, 'A factory produces 200 units per day. How many units in 7 days?', '1200', '1400', '1300', '1500', 'B', '200 × 7 = 1400', 'easy'),
(17, 'The ratio of boys to girls is 3:4. If there are 12 boys, how many girls?', '14', '15', '16', '18', 'C', '3:4 = 12:x, so 3x = 48, x = 16', 'medium'),
(17, 'A car travels 240 km in 4 hours. What is its speed?', '50 km/h', '55 km/h', '60 km/h', '65 km/h', 'C', 'Speed = 240 ÷ 4 = 60 km/h', 'medium');

-- Sample Questions for Analytical Ability - Word Analogy (Professional)
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(18, 'Book is to Reading as Fork is to:', 'Knife', 'Eating', 'Kitchen', 'Food', 'B', 'A book is used for reading; a fork is used for eating.', 'easy'),
(18, 'Bird is to Fly as Fish is to:', 'Swim', 'Water', 'Ocean', 'Jump', 'A', 'Birds fly; fish swim.', 'easy'),
(18, 'Hot is to Cold as Light is to:', 'Dark', 'Bright', 'Sun', 'Day', 'A', 'Hot is the opposite of cold; light is the opposite of dark.', 'easy'),
(18, 'Doctor is to Hospital as Teacher is to:', 'Student', 'Classroom', 'Book', 'Pencil', 'B', 'A doctor works in a hospital; a teacher works in a classroom.', 'easy'),
(18, 'Pen is to Write as Needle is to:', 'Thread', 'Sew', 'Cloth', 'Clothing', 'B', 'A pen is used to write; a needle is used to sew.', 'easy');

-- Sample Questions for Analytical Ability - Symbolic Logic (Professional)
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(19, 'If all roses are flowers, and this is a rose, then:', 'It is a flower', 'It is not a flower', 'It is a daisy', 'It may not be a flower', 'A', 'This is a valid deductive conclusion.', 'medium'),
(19, 'What is the negation of "All students are present"?', 'No students are present', 'Some students are absent', 'All students are absent', 'None of these', 'B', 'The negation of "all" is "some are not".', 'medium'),
(19, 'If A → B and B → C, then:', 'A → C', 'C → A', 'A and C', 'None', 'A', 'This is transitive logic: if A implies B and B implies C, then A implies C.', 'medium'),
(19, 'Which is a valid conclusion from "Some teachers are kind"?', 'All teachers are kind', 'No teachers are kind', 'Some teachers may not be kind', 'Kind people are teachers', 'C', 'Some teachers are kind means at least one is kind, but not all.', 'medium'),
(19, 'If it rains, the ground gets wet. The ground is wet. Therefore:', 'It rained', 'It may have rained', 'It definitely did not rain', 'Cannot be determined', 'D', 'The ground could be wet from other sources.', 'medium');

-- Sample Questions for Analytical Ability - Identifying Assumptions (Professional)
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(20, 'The assumption in "I will pass because I studied hard" is:', 'Hard work guarantees success', 'All who study hard pass', 'Studying hard helps', 'The exam is easy', 'B', 'The argument assumes studying hard always leads to passing.', 'medium'),
(20, 'What assumption is made in "This restaurant must be good - it\'s always full"?', 'Full restaurants are always good', 'People only go to good restaurants', 'The restaurant is always full', 'Good restaurants are always full', 'A', 'The argument assumes that full restaurants are always good.', 'medium'),
(20, 'An argument concludes "We should ban smartphones in school." What is a likely assumption?', 'Students have smartphones', 'Smartphones distract students', 'Banning works', 'All schools ban phones', 'B', 'The argument assumes smartphones are distracting.', 'medium'),
(20, 'What is the main conclusion in: "All mammals breathe. Dogs are mammals. Therefore, dogs breathe."?', 'All mammals breathe', 'Dogs are mammals', 'Dogs breathe', 'None', 'C', 'The main conclusion is that dogs breathe.', 'medium'),
(20, 'If someone argues "You should become a doctor - doctors earn a lot", what is the unstated assumption?', 'You want to earn a lot', 'All doctors earn a lot', 'Money is the only factor', 'Being a doctor is easy', 'B', 'The argument assumes all doctors earn a lot of money.', 'medium');

-- Sample Questions for Analytical Ability - Data Interpretation (Professional)
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(21, 'In a pie chart showing budget: 40% for food, 30% for rent, 20% for savings, 10% for other. What percentage is left after food and rent?', '30%', '70%', '50%', '60%', 'A', '100% - (40% + 30%) = 30%', 'easy'),
(21, 'A bar graph shows sales: Jan-100, Feb-150, Mar-200. What is the trend?', 'Decreasing', 'Increasing', 'Constant', 'Fluctuating', 'B', 'Sales increased from 100 to 150 to 200.', 'easy'),
(21, 'If 25% of 800 students are in Grade 5, how many Grade 5 students?', '100', '200', '150', '250', 'B', '25% of 800 = 800 × 0.25 = 200', 'easy'),
(21, 'A line graph shows temperature rising from 20°C to 30°C in 5 hours. What is the average increase per hour?', '1°C/hour', '2°C/hour', '5°C/hour', '10°C/hour', 'B', '30 - 20 = 10°C over 5 hours = 2°C/hour', 'medium'),
(21, 'In a survey: 300 people chose option A, 200 chose B, 100 chose C. What percentage chose A?', '50%', '33%', '17%', '67%', 'A', '300/600 x 100 = 50%', 'easy');

-- Add more data interpretation questions
INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty) VALUES
(21, 'A table shows: Year 2020 - 500, Year 2021 - 600, Year 2022 - 750. What is the percent increase from 2020 to 2022?', '25%', '50%', '75%', '100%', 'B', 'Increase = 750-500=250. 250/500 × 100 = 50%', 'medium'),
(21, 'In a class of 40 students, 60% are boys. How many are girls?', '16', '20', '24', '10', 'A', 'Girls = 40 x 0.4 = 16', 'easy');
