-- Clear any of the tables if they exist
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS titles;

--1. Table schema for departments and import data
CREATE TABLE departments (
	dept_no VARCHAR(20) NOT NULL,
	dept_name VARCHAR(30) NOT NULL,
	PRIMARY KEY(dept_no)
);

-- Run a query to view the data
SELECT *
FROM departments;
--------------------------------------------------------
--2. Table schema for titles and import data
CREATE TABLE titles (
	title_id VARCHAR(20) NOT NULL,
	title VARCHAR(30) NOT NULL,
	PRIMARY KEY(title_id)
);

-- Run a query to view the data
SELECT *
FROM titles;

--------------------------------------------------------

--3. Table schema for dept_emp and import data
CREATE TABLE employees (
	emp_no VARCHAR(10) NOT NULL,
	emp_title_id VARCHAR(10) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex CHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY(emp_no),
	CONSTRAINT FK_title 
		FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
		ON DELETE NO ACTION    
    	ON UPDATE NO ACTION
);

-- Run a query to view the data
SELECT *
FROM employees;

--------------------------------------------------------
--4. Table schema for dept_emp and import data
CREATE TABLE dept_emp (
	emp_no VARCHAR(10) NOT NULL,
	dept_no VARCHAR(20) NOT NULL,
	CONSTRAINT PK_dept_emp 
		PRIMARY KEY (dept_no, emp_no),  -- combines dept_no & emp_no to create a composite primary key
	CONSTRAINT FK_employees 
		FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	CONSTRAINT FK_department 
		FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
		ON DELETE NO ACTION    
    	ON UPDATE NO ACTION
);

-- Run a query to view the data
SELECT *
FROM dept_emp;

----------------------------------------------------------

--5. Table schema for dept_manager and import data
CREATE TABLE dept_manager (
	dept_no VARCHAR(20) NOT NULL,
	emp_no Varchar(20) NOT NULL,
	CONSTRAINT PK_dept_manager 
		PRIMARY KEY (dept_no, emp_no), -- combines dept_no & emp_no to create a composite primary key
	CONSTRAINT FK_department 
		FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
		ON DELETE NO ACTION    
    	ON UPDATE NO ACTION
);

-- Run a query to view the data
SELECT *
FROM dept_manager;

--------------------------------------------------------

--6. Table schema for salaries and import data
CREATE TABLE salaries (
	emp_no VARCHAR(10) NOT NULL,
	salary INT NOT NULL,
	CONSTRAINT PK_emp_salary 
		PRIMARY KEY (emp_no, salary), -- combines emp_no & salary to create a composite primary key
	CONSTRAINT FK_employees 
		FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	    ON DELETE NO ACTION    
    	ON UPDATE NO ACTION
);

-- Run a query to view the data
SELECT *
FROM salaries;

/* 
1. List the following details for each employee: 
employee number, last name, first name, sex, and salary
*/

SELECT 
	employees.emp_no AS "Employee No.", 
	employees.last_name AS "Last Name", 
	employees.first_name AS "First Name", 
	employees.sex  AS "Sex",
	salaries.salary AS "Salary"
FROM employees
RIGHT JOIN salaries 
ON salaries.emp_no = employees.emp_no
ORDER BY "Employee No.";

/*
2. List first name, last name, and hire date 
for employees who were hired in 1986.
*/

SELECT
	employees.first_name AS "First Name", 
	employees.last_name AS "Last Name",
	employees.hire_date AS "Date of Hire"
FROM employees
WHERE hire_date >= '19860101'
	AND hire_date <= '19861231';


/*
3. List the manager of each department with 
the following information: department number, department name, 
the manager's employee number, last name, first name.
*/
SELECT
	departments.dept_no AS "Department No.",
	departments.dept_name AS "Department Name",
	dept_manager.emp_no AS "Manager Employee No.",
	employees.last_name AS "Last Name",
	employees.first_name AS "First Name"
FROM departments
JOIN dept_manager
	ON departments.dept_no = dept_manager.dept_no
JOIN employees
	ON dept_manager.emp_no = employees.emp_no;

/*
4. List the department of each employee with 
the following information: employee number, 
last name, first name, and department name.
*/
SELECT
	employees.emp_no AS "Employee No.",
	employees.last_name AS "Last Name",
	employees.first_name AS "First Name",
	departments.dept_name AS "Department Name"
FROM employees
JOIN dept_emp
	ON employees.emp_no = dept_emp.emp_no
JOIN departments
	ON departments.dept_no = dept_emp.dept_no
ORDER BY "Employee No.";

/*
5. List first name, last name, and sex for employees 
whose first name is "Hercules" and last names begin with "B."
*/
SELECT
	employees.first_name AS "First Name",
	employees.last_name AS "Last Name",
	employees.sex AS "Sex"
FROM employees
WHERE first_name = 'Hercules'
AND SUBSTRING(last_name, 1, 1) = 'B';
	
/*
6. List all employees in the Sales department, 
including their employee number, 
last name, first name, and department name.
*/

SELECT 
	employees.emp_no AS "Employee No.",
	employees.last_name AS "Last Name",
	employees.first_name AS "First Name"
FROM employees
WHERE emp_no IN
	(
	SELECT emp_no
	 FROM dept_emp
	 WHERE dept_no IN
		(
		SELECT departments.dept_no AS "Department Name."
		FROM departments
		WHERE dept_name = 'Sales'
		)
	);

SELECT
	employees.emp_no AS "Employee No.",
	employees.last_name AS "Last Name",
	employees.first_name AS "First Name",
	departments.dept_name AS "Department Name"
FROM 
	(
	SELECT employees.emp_no, last_name, first_name, dept_no
	FROM employees
	INNER JOIN dept_emp
	ON dept_emp.emp_no = employees.emp_no
	)
	AS employees
INNER JOIN departments AS departments
ON employees.dept_no = departments.dept_no
WHERE dept_name = 'Sales';


/*
7. List all employees in the Sales and Development departments, including their 
employee number, last name, first name, and department name.
*/

SELECT
	employees.emp_no AS "Employee No.",
	employees.last_name AS "Last Name",
	employees.first_name AS "First Name",
	departments.dept_name AS "Department Name"
FROM 
	(
	SELECT employees.emp_no, last_name, first_name, dept_no
	FROM employees
	INNER JOIN dept_emp
	ON dept_emp.emp_no = employees.emp_no
	)
	AS employees
INNER JOIN departments 
AS departments
ON employees.dept_no = departments.dept_no
WHERE dept_name = 'Sales'
OR dept_name = 'Development'
ORDER BY "Last Name";


/*
In descending order, list the frequency count of employee last names, 
i.e., how many employees share each last name.
*/

SELECT
	employees.last_name AS "Last Name",
	COUNT(employees.last_name) AS "Frequency Count"
FROM employees
GROUP BY employees.last_name
ORDER BY "Frequency Count" DESC;
