-- CREATE AND IMPORT THE TABLE FIRST
-- 1. Departments Table
CREATE TABLE departments (
    dept_no VARCHAR(10) NOT NULL,
    dept_name VARCHAR(255) 
);

-- 2. Employees Table
CREATE TABLE employees (
    emp_no INT NOT NULL,
    emp_title VARCHAR(225) ,
    birth_date DATE ,
    first_name VARCHAR(255) ,
    last_name VARCHAR(255),
    sex VARCHAR(10) ,
    hire_date DATE
);

-- 3. Salaries Table
CREATE TABLE salaries (
    emp_no INT,
    salary INT
);

-- 4. Title Table
CREATE TABLE title (
    title_id VARCHAR(10) NOT NULL,
    title VARCHAR(225)
);

-- 5. Dept_Emp Table
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no VARCHAR(10)
    );

-- 6. Dept_Manager Table
CREATE TABLE dept_manager (
    dept_no VARCHAR(10),
    emp_no INT
    );

--MAKE THE COLUMNS UNIQUE, SPECIFY THE PRIMARY KEYS AND FOREIGN KEYS

--remove duplicate of emp_no in employees table
WITH DuplicateCTE AS (
    SELECT emp_no,
           ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY emp_no) AS RowNumber
    FROM employees
)
DELETE FROM employees
WHERE (emp_no, 1) IN (SELECT emp_no, RowNumber FROM DuplicateCTE WHERE RowNumber > 1);

-- set emp_no as the primary key in employees table
ALTER TABLE employees
ADD PRIMARY KEY (emp_no);

--Use emp_no as Foreign Key in dept_emp Table:
ALTER TABLE dept_emp
ADD CONSTRAINT fk_dept_emp_emp_no
FOREIGN KEY (emp_no)
REFERENCES employees(emp_no);

--Use emp_no as Foreign Key in dept_manager Table:
ALTER TABLE dept_manager
ADD CONSTRAINT fk_dept_manager_emp_no
FOREIGN KEY (emp_no)
REFERENCES employees(emp_no);

--Use emp_no as Foreign Key in salaries Table:
ALTER TABLE salaries
ADD CONSTRAINT fk_salaries_emp_no
FOREIGN KEY (emp_no)
REFERENCES employees(emp_no);

--Remove duplicate from dept_no column from departments table
WITH DuplicateCTE AS (
    SELECT dept_no,
           ROW_NUMBER() OVER (PARTITION BY dept_no ORDER BY dept_no) AS RowNumber
    FROM departments
)
DELETE FROM departments
WHERE (dept_no, 1) IN (SELECT dept_no, RowNumber FROM DuplicateCTE WHERE RowNumber > 1);

-- set dept_no column as the primary key in departments table
ALTER TABLE departments
ADD PRIMARY KEY (dept_no);

--Add dept_no as a Foreign Key to dept_emp Table
ALTER TABLE dept_emp
ADD CONSTRAINT fk_dept_emp_dept_no
FOREIGN KEY (dept_no)
REFERENCES departments(dept_no);

--Add dept_no as a Foreign Key to dept_manager Table:
ALTER TABLE dept_manager
ADD CONSTRAINT fk_dept_manager_dept_no
FOREIGN KEY (dept_no)
REFERENCES departments(dept_no);

--Add Primary Key to title Table:
ALTER TABLE title
ADD PRIMARY KEY (title_id);

--Add Foreign Key to employees Table:
ALTER TABLE employees
ADD CONSTRAINT fk_employees_emp_title
FOREIGN KEY (emp_title)
REFERENCES title(title_id);


--DATA ANALYSIS 

-- 1. List the employee number, last name, first name, sex, and salary of 
--each employee
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
ORDER BY e.emp_no;


-- 2. The first name, last name, and hire date for the employees who were
--hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986
ORDER BY hire_date;

-- 3. List the manager of each department along with their department number,
--department name, employee number, last name, and first name
SELECT
    d.dept_no,
    d.dept_name,
    m.emp_no AS employee_number,
    m.last_name AS last_name,
    m.first_name AS first_name
FROM
    departments d
JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
JOIN
    employees m ON dm.emp_no = m.emp_no;
	
-- 4. Department number for each employee along with that employee’s employee 
--number, last name, first name, and department name
SELECT
    e.emp_no,
    e.last_name,
    e.first_name,
    de.dept_no,
    d.dept_name
FROM
    employees e
JOIN
    dept_emp de ON e.emp_no = de.emp_no
JOIN
    departments d ON de.dept_no = d.dept_no;

-- 5. First name, last name, and sex of each employee whose first name
--is Hercules and whose last name begins with the letter B
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee 
--number, last name, and first name
SELECT
    e.emp_no,
    e.last_name,
    e.first_name
FROM
    employees e
JOIN
    dept_emp de ON e.emp_no = de.emp_no
JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    d.dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, including
--their employee number, last name, first name, and department name 
SELECT
    e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM
    employees e
JOIN
    dept_emp de ON e.emp_no = de.emp_no
JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    d.dept_name IN ('Sales', 'Development');

-- 8. List the frequency counts, in descending order, of all the employee
--last names (that is, how many employees share each last name)
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;
