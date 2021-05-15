--1. Table schema for departments and import data
CREATE TABLE departments (
	dept_no VARCHAR(20) NOT NULL,
	dept_name VARCHAR(30) NOT NULL
);

-- Run a query to view the data
SELECT *
FROM departments

---------------------------------------------------------


--2. Table schema for dept_emp and import data
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(30) NOT NULL
);

-- Run a query to view the data
SELECT *
FROM dept_emp

----------------------------------------------------------

--3. Table schema for dept_manager and import data
CREATE TABLE dept_manager (
	dept_no VARCHAR(20) NOT NULL,
	emp_no INT NOT NULL
);

-- Run a query to view the data
SELECT *
FROM dept_manager

--------------------------------------------------------

--4. Table schema for dept_emp and import data
CREATE TABLE employees (
	emp_no INT NOT NULL,
	emp_title_id VARCHAR(10) NOT NULL,
	birth_date VARCHAR(30) NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date VARCHAR NOT NULL
);

-- Run a query to view the data
SELECT *
FROM employees

--------------------------------------------------------

--5. Table schema for salaries and import data
CREATE TABLE salaries (
	emp_no VARCHAR(20) NOT NULL,
	salary INT NOT NULL
);

-- Run a query to view the data
SELECT *
FROM salaries

--------------------------------------------------------

--6. Table schema for titles and import data
CREATE TABLE titles (
	title_id VARCHAR(20) NOT NULL,
	title VARCHAR(30) NOT NULL
);

-- Run a query to view the data
SELECT *
FROM titles

