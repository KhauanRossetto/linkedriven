
-- Questão 01
SELECT * FROM companies
LIMIT 5;

-- Questão 02
SELECT * FROM companies
WHERE name = 'Driven';

-- Questão 03
INSERT INTO companies (name, image_url)
VALUES ('Apple', 'http://dummyimage.com/200x100.png/000000/ffffff');

-- Questão 04
DELETE FROM companies
WHERE name = 'Apple';

-- Questão 05
UPDATE companies
SET name = 'Google'
WHERE name = 'Gogle';

-- Questão 06
UPDATE jobs
SET salary = 1500
WHERE id = 1;

-- Questão 07
INSERT INTO experiences (user_id, company_id, role_id, start_date, end_date)
SELECT u.id, c.id, r.id, CURRENT_DATE, NULL
FROM users u
JOIN companies c ON c.name = 'Nubank'
JOIN roles r ON r.name = 'CTO'
WHERE u.name = 'Kelly';

-- Questão 08
DELETE FROM applicants
WHERE user_id = (SELECT id FROM users WHERE name = 'Kelly')
AND job_id = (
  SELECT j.id
  FROM jobs j
  JOIN companies c ON c.id = j.company_id
  JOIN roles r ON r.id = j.role_id
  WHERE c.name = 'Carrefour' AND r.name = 'Engenheiro de Software Pleno'
);

-- Questão 09
SELECT id, description, salary
FROM jobs
ORDER BY salary DESC
LIMIT 3;

-- Questão 10
SELECT j.id, c.name AS company_name, j.salary
FROM jobs j
JOIN companies c ON c.id = j.company_id
ORDER BY j.salary ASC
LIMIT 1;

-- Questão 11
SELECT u.id, u.name, ci.name AS city
FROM users u
JOIN cities ci ON ci.id = u.city_id
WHERE ci.name = 'Rio de Janeiro';

-- Questão 12
SELECT t.id, t.message,
       writer.name AS writer,
       recipient.name AS recipient
FROM testimonials t
JOIN users writer ON writer.id = t.writer_id
JOIN users recipient ON recipient.id = t.recipient_id;

-- Questão 13
SELECT e.id, u.name, c.name AS course, s.name AS schools, e.end_date
FROM educations e
JOIN users u ON u.id = e.user_id
JOIN courses c ON c.id = e.course_id
JOIN schools s ON s.id = e.school_id
WHERE e.user_id = 5 AND e.status = 'finished';

-- Questão 14
SELECT e.user_id AS id, u.name, r.name AS role, c.name AS company, e.start_date
FROM experiences e
JOIN users u ON u.id = e.user_id
JOIN companies c ON c.id = e.company_id
JOIN roles r ON r.id = e.role_id
WHERE e.user_id = 10 AND e.end_date IS NOT NULL;

-- Questão 15
SELECT s.id, s.name AS school, c.name AS course, co.name AS company, r.name AS roles
FROM applicants a
JOIN jobs j ON j.id = a.job_id
JOIN roles r ON r.id = j.role_id
JOIN companies co ON co.id = j.company_id
JOIN educations e ON e.user_id = a.user_id
JOIN schools s ON s.id = e.school_id
JOIN courses c ON c.id = e.course_id
WHERE co.id = 1 AND r.name = 'Engenheiro de Software Pleno' AND j.active = true;

-- Questão 16
SELECT COUNT(*) AS current_experiences
FROM experiences
WHERE end_date IS NULL;

-- Questão 17
SELECT u.id, u.name, COUNT(e.id) AS educations
FROM users u
JOIN educations e ON e.user_id = u.id
GROUP BY u.id, u.name
ORDER BY educations DESC;

-- Questão 18
SELECT u.name AS writer, COUNT(t.id) AS testimonialCount
FROM testimonials t
JOIN users u ON u.id = t.writer_id
WHERE u.id = 9
GROUP BY u.name;

-- Questão 19
SELECT MAX(j.salary) AS maximum_salary, r.name AS role
FROM jobs j
JOIN roles r ON r.id = j.role_id
WHERE j.active = true
GROUP BY r.name
ORDER BY maximum_salary;

-- Questão 20
SELECT s.name AS school, c.name AS course, COUNT(*) AS student_count
FROM educations e
JOIN schools s ON s.id = e.school_id
JOIN courses c ON c.id = e.course_id
WHERE e.status = 'finished'
GROUP BY s.name, c.name
ORDER BY student_count DESC
LIMIT 3;
