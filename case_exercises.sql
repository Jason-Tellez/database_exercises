USE employees;

# 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
SELECT *,
	IF(to_date > NOW(), TRUE, FALSE) AS is_current_employee
FROM dept_emp;


# 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT first_name, last_name,
		CASE 
				WHEN last_name BETWEEN 'A' AND 'I' THEN 'A-H'
				WHEN last_name BETWEEN 'I' AND 'R' THEN 'I-Q'
				ELSE 'R-Z'
				END AS alpha_group
FROM employees
ORDER BY last_name;						

SELECT first_name, last_name,
		CASE
				WHEN SUBSTR(last_name, 1, 1) IN ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') THEN 'A-H'
				WHEN SUBSTR(last_name, 1, 1) IN ('i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q') THEN 'I-Q'
				WHEN SUBSTR(last_name, 1, 1) IN ('r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z') THEN 'R-Z'
				END AS alpha_group
FROM employees
ORDER BY last_name;


# 3. How many employees (current or previous) were born in each decade?
SELECT IF(birth_date LIKE '195%', '50s', '60s') AS birth_decade, COUNT(*) AS no_of_emp 
FROM employees
GROUP BY birth_decade;


# B. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT CASE
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
		WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
		WHEN dept_name in ('Production', 'Quality Management') THEN 'Prod & QM'
		ELSE dept_name
		END AS dept_group,
		AVG(salary) AS cur_avg_salary
FROM dept_emp AS de
JOIN salaries 
		USING (emp_no)
JOIN departments
		USING (dept_no)
WHERE salaries.to_date > NOW()
GROUP BY dept_no;