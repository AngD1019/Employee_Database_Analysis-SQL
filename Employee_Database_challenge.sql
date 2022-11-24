-- Deliverable 1

-- Create retirement table by titles
CREATE TABLE employees (
	 emp_no INT NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    gender VARCHAR NOT NULL,
    hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR(40) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);

CREATE TABLE retirement_titles (
	emp_no INT NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
	title VARCHAR(40) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);


SELECT emp.emp_no, emp.first_name, emp.last_name,
ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees AS emp
INNER JOIN titles AS ti
ON (ti.emp_no = emp.emp_no) 
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp.emp_no, ti.title DESC;

DROP TABLE employees;

DROP TABLE titles;

DROP TABLE retirement_titles;
DROP TABLE unique_titles;
DROP TABLE retiring_titles;

SELECT * FROM retiring_titles;
SELECT * FROM unique_titles;
SELECT * FROM retirement_titles;
SELECT * FROM employees;
SELECT * FROM titles;



-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp.emp_no) emp.emp_no, emp.first_name, emp.last_name,
ti.title
INTO unique_titles
FROM employees as emp
INNER JOIN titles AS ti
ON (ti.emp_no = emp.emp_no) 
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (ti.to_date = '9999-01-01')
ORDER BY emp.emp_no ASC, ti.to_date DESC;

-- Use Count to determine number of retirement-eligible employees are in each title
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY (title)
ORDER BY count DESC;

SELECT * FROM retiring_titles;

DROP TABLE retiring_titles;

-- Deliverable 2

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp.emp_no) emp.emp_no, emp.first_name, emp.last_name, 
emp.birth_date, de.from_date, de.to_date, ti.title
INTO mentorship_eligibility
FROM employees as emp
INNER JOIN dept_emp AS de
ON (emp.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (emp.emp_no = ti.emp_no) 
WHERE (ti.to_date = '9999-01-01')
AND (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp.emp_no ASC;

DROP TABLE mentorship_eligibility;

Select * FROM retiring_titles;
Select * FROM employees;
Select * FROM unique_titles;
Select * FROM mentorship_eligibility;
Select * FROM titles;
Select * FROM salaries;
Select * FROM departments;
Select * FROM retirement_info;
Select COUNT(*)
FROM retirement_titles
Select COUNT(*)
FROM mentorship_eligibility
