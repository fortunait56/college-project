PRAGMA foreigh_keys;
PRAGMA foreigh_keys = ON;
PRAGMA foreigh_keys = OFF;



DROP TABLE sex;

CREATE TABLE sex (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name CHAR(1) NOT NULL
);

INSERT INTO sex (name) VALUES 
	('M'),
	('F');

SELECT * FROM  sex;







DROP TABLE positions;

CREATE TABLE positions (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(40) NOT NULL 
);

DELETE FROM positions WHERE id > 5;
INSERT INTO positions (name) VALUES 
	('Povar'),
	('Prepod'),
	('Zav Old'),
	('Buh'),
	('Gl Buh');
SELECT  * FROM positions p ;




CREATE TABLE employees (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	fio VARCHAR(100) NOT NULL,
	b_day DATE,
	sex_id INTEGER REFERENCES sex (id),
	position_id INTEGER REFERENCES positions (id)
);

INSERT INTO employees (fio, b_day, sex_id, position_id) VALUES
	('IVANOV II',  '2001-01-01', 1, 2),
	('IVANOVA VI', '2001-02-02', 2, 2),
	('GAVRILOV GG', '2002-01-01', 1, 2),
	('SIDOROVA SS', '2001-03-03', 2, 1),
	('PETROVA PP', '2000-11-11', 2, 4),
	('GALKIN GG', '2000-12-12', 1, 5);

SELECT * FROM employees e ;

SELECT * FROM employees e WHERE position_id = 2;






CREATE TABLE student_groups (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name CHAR(18) NOT NULL,
	kurator_id INTEGER REFERENCES employees (id)
);

INSERT INTO student_groups (name, kurator_id) VALUES 
	('ToIP-439', 1),
	('ToIP-429', NULL),
	('ToIP-219', 2),
	('ToIP-139', 3);

SELECT * FROM student_groups sg ;








CREATE TABLE students (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	fio VARCHAR(100) NOT NULL,
	b_day DATE,
	sex_id INTEGER REFERENCES sex (id),
	student_group_id INTEGER REFERENCES student_groups (id)
);

INSERT INTO students (fio, b_day, sex_id, student_group_id) VALUES 
	('Vasia', '2001-01-01', 1, 1),
	('Vera', '2001-02-02', 2, 1),
	('Kolia', '2001-03-03', 1, 2),
	('Dima', '2001-04-04', 1, 3),
	('Tolia', '2001-05-05', 1, 4);

INSERT INTO students (fio, b_day, sex_id, student_group_id) VALUES 
	('Gena', '2003-03-03', 1, NULL);

UPDATE students SET
	student_group_id = 4
WHERE id = 6
;


SELECT * FROM students s ;

SELECT -- *
	s.id AS s_id, s.fio AS s_fio, s.b_day AS s_bd,
	sx.name AS s_sx,
	sg.name AS s_group
FROM students s 
	JOIN sex sx					 ON s.sex_id = sx.id
	LEFT JOIN student_groups sg  ON s.student_group_id = sg.id
--WHERE
--		s_group = 'ToIP-439'
-- AND s_sx = 'F'
ORDER BY s_bd DESC
;


CREATE TABLE hobby_groups (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(40) NOT NULL,
	rukovoditel_id INTEGER REFERENCES employees (id),
	cost DECIMAL(12,2)
);


INSERT INTO hobby_groups (name, rukovoditel_id, cost) VALUES 
('Programming', 1, 0.0),
('Volleyball', 6, 0.0),
('Hokey', 3, 0.0),
('Patchworking', 4, 1500.00),
('Biology', 5, 0.0);


SELECT * FROM hobby_groups;


CREATE TABLE students_hobby_groups (
	student_id INTEGER REFERENCES students (id),
	hobby_group_id INTEGER REFERENCES hobby_groups (id),
	enrol_date DATA, 
--
	PRIMARY KEY (student_id, hobby_group_id)
);

INSERT INTO students_hobby_groups (student_id, hobby_group_id, enrol_date) VALUES 
	(1, 1, '2026-09-01'),
	(1, 2, '2026-09-02'),
	(2, 1, '2026-09-11'),
	(2, 5, '2026-09-14'),
	(5, 3, '2026-09-21');

SELECT * FROM students_hobby_groups;


SELECT --*
	s.fio AS s_fio, sg.name AS s_group,
	hg.name AS hg_name, shg.enrol_date, 
	e.fio AS hg_ruk
FROM students_hobby_groups shg 
	JOIN students s ON shg.hobby_group_id = s.id 
	JOIN hobby_groups hg ON shg.hobby_group_id = hg.id 
	JOIN student_groups sg ON s.student_group_id = sg.id
	JOIN employees e ON hg.rukovoditel_id = e.id 
WHERE hg_name = 'Programming'
ORDER BY s_fio
;







	
