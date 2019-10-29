-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/Xp9kpz
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

--Data Engineering
--Import CSV files

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);
--Confirm Data
Select * from departments


REATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);
--Confirm Data
Select * from employees


CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);
--Confirm Data
Select * from dept_emp


CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);
--Confirm Data
Select * from dept_manager


CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);
--Confirm Data
Select * from titles


CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);
--Confirm Data
Select * from salaries


ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--Data Analysis
--List the following details of each employee: employee number, last name, first name, gender, and salary.
Select e.emp_no, e.last_name, e.first_name,e.gender, s.salary
From employees e
Join salaries s
ON e.emp_no = s.emp_no;

--List employees who were hired in 1986.
Select e.first_name, e.last_name, e.hire_date, e.gender
From employees e
Where e.hire_date Between '1986-01-01' And '1987-01-01';

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
Select d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name,m.from_date,  m.to_date
From departments d
Join dept_manager m
On d.dept_no = m.dept_no
Join employees e
On e.emp_no = m.emp_no;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e
ON e.emp_no = de.emp_no
JOIN departments d
ON de.dept_no = d.dept_no;

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT e.first_name, e.last_name
FROM employees e
WHERE e.first_name = 'Hercules' 
OR e.last_name LIKE '%B';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e
ON e.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
Where dept_name = 'Sales'

--List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e
ON de.emp_no = e.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'
OR d.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT e.last_name,
COUNT(e.last_name) AS "frequency"
FROM employees e
GROUP BY e.last_name
ORDER BY
COUNT(e.last_name) DESC;


