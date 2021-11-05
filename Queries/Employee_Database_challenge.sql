-- DELIVERABLE 1: The Number of Retiring Employees by Title
-- Retrieve the emp_no, first_name, and last_name columns from the Employees table
SELECT emp_no,
	first_name,
	last_name
FROM employees;

-- Retrieve the title, from_date, and to_date columns from the Titles table
SELECT title,
	from_date,
	to_date
FROM titles;

-- Join both tables on the primary key to create a new table. 
-- Filter for employees who were born between 1952 and 1955 and order by the emp_no.
SELECT e.emp_no,
     e.first_name,
	 e.last_name,
	 t.title,
	 t.from_date,
	 t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Check the table
SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title

INTO unique_titles
FROM retirement_titles AS rt
ORDER BY emp_no ASC, to_date DESC;

-- Check the table
SELECT * FROM unique_titles;

-- Retrieve the number of employees by their most recent job title who are about to retire into a Retiring Titles table
SELECT COUNT(title) as count,
	title
INTO retiring_titles
FROM unique_titles

-- Group the table by title, then sort the count column in descending order.
GROUP BY title
ORDER BY count DESC

-- Check the table
SELECT * FROM retiring_titles;

-- DELIVERABLE 2: The Employees Eligible for the Mentorship Program
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e

INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no

LEFT JOIN titles as t
ON e.emp_no = t.emp_no

WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

-- Check the table
SELECT * FROM mentorship_eligibility
