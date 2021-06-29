								##JOIN EXAMPLE DATABASE##
USE join_example_db;

#2
# join
SELECT *
FROM roles
JOIN users ON users.role_id = roles.id;

SELECT *
FROM users
JOIN roles ON roles.id = users.role_id;

#LEFT JOIN
SELECT *
FROM roles
LEFT JOIN users ON users.role_id = roles.id;

SELECT *
FROM users
LEFT JOIN roles ON roles.id = users.role_id;

#RIGHT JOIN
SELECT *
FROM users
RIGHT JOIN roles ON roles.id = users.role_id;

SELECT *
FROM roles
RIGHT JOIN users ON users.role_id = roles.id;

#3
SELECT role_id, roles.name, COUNT(role_id) AS number_of_users
FROM users
JOIN roles ON roles.id = users.role_id
GROUP BY role_id;




								##EMPLOYEE DATABASE##
USE employees;

#2
SELECT ds.dept_name, concat(first_name, ' ', last_name) as emp_name, dm.emp_no
FROM dept_manager AS dm
JOIN employees AS em
	ON em.emp_no = dm.emp_no
JOIN departments AS ds
	ON ds.dept_no = dm.dept_no
WHERE NOW() < dm.to_date
ORDER BY ds.dept_name;

# 3. Find the name of all departments currently managed by women.
SELECT ds.dept_name, concat(first_name, ' ', last_name) as emp_name, dm.emp_no
FROM dept_manager AS dm
JOIN employees AS em
	ON em.emp_no = dm.emp_no
JOIN departments AS ds
	ON ds.dept_no = dm.dept_no
WHERE NOW() < dm.to_date AND em.`gender` = 'F'
ORDER BY ds.dept_name;

# 4
SELECT Title, COUNT(*) AS COUNT
FROM titles AS t
join dept_emp AS de
	ON de.emp_no = t.emp_no
JOIN departments AS d
	ON de.dept_no = d.dept_no
WHERE t.to_date > NOW()
	AND de.to_date > NOW()
	AND d.dept_name = 'Customer Service'
GROUP BY title
ORDER BY title;

# 5. Find the current salary of all current managers.
SELECT ds.dept_name AS "Department Name", concat(first_name, ' ', last_name) as 'Name', sa.Salary
FROM dept_manager AS dm
JOIN employees AS em
	ON em.emp_no = dm.emp_no
JOIN departments AS ds
	ON ds.dept_no = dm.dept_no
JOIN salaries AS sa
	ON sa.emp_no = dm.emp_no
WHERE NOW() < dm.to_date
	AND NOW() < sa.to_date
ORDER BY ds.dept_name;

# 6. Find the number of current employees in each department.
SELECT dm.dept_no, dept_name, COUNT(dept_name) AS num_employees
FROM dept_emp AS de
JOIN departments AS dm
	ON dm.dept_no = de.dept_no
GROUP BY dept_no, to_date
HAVING NOW() < to_date
ORDER BY dept_no;

# 7. Which department has the highest average salary? Hint: Use current not historic information.
SELECT dept_name, AVG(sa.salary) AS average_salary
FROM dept_emp AS de
JOIN salaries AS sa
	ON sa.emp_no = de.emp_no
JOIN departments AS dpt
	ON dpt.dept_no = de.dept_no
GROUP BY dept_name, sa.to_date
HAVING NOW() < sa.to_date
ORDER BY AVG(sa.salary) DESC
LIMIT 1;

# 8. Who is the highest paid employee in the Marketing department?
SELECT e.first_name, e.last_name
FROM dept_emp AS de

JOIN salaries AS sa
	ON de.emp_no = sa.emp_no
	
JOIN departments as dpt
	ON dpt.dept_no = de.dept_no
	
JOIN employees as e
	ON e.emp_no = de.emp_no
	
WHERE dpt.dept_no LIKE 'd001'
ORDER BY sa.salary DESC
LIMIT 1;

# 9. Which current department manager has the highest salary?
SELECT e.first_name, e.last_name, s.salary, dp.dept_name
FROM dept_manager AS dm
JOIN salaries AS s
	ON s.emp_no = dm.emp_no
JOIN departments AS dp
	ON dp.dept_no = dm.dept_no
JOIN employees AS e
	ON e.emp_no = dm.emp_no
WHERE NOW() < dm.to_date
ORDER BY s.salary DESC
LIMIT 1;

;# 10. Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT 
	DISTINCT e.emp_no, 
	CONCAT(
			e.first_name, 
			' ', 
			e.last_name
		), 
	d.dept_name AS 'Department Name',
	CONCAT(dm1.first_name, ' ', dm1.last_name)
FROM dept_emp AS de
JOIN employees AS e
	ON e.emp_no = de.emp_no
JOIN departments AS d
	ON d.dept_no = de.dept_no
JOIN dept_manager AS dm
	ON dm.dept_no = de.dept_no
JOIN dept_manager AS dm1
	ON dm1.emp_no = emp_no
WHERE NOW() < de.to_date
ORDER BY e.emp_no
LIMIT 20;

# 11 (By Charles)
SELECT 
	t1.dept_name AS 'Department Name',
	t1.salary AS 'Salary',
	CONCAT(first_name,' ', last_name) AS 'Employee Name'
FROM 
	(
	-- Part 1 which builds the base table to employee names, salaries and dept names
	SELECT
		salary, dept_name, first_name, last_name
	FROM
		salaries
	JOIN
		dept_emp 
	USING(emp_no)
	JOIN 
		departments 
	USING(dept_no)
	JOIN 
		employees
	USING(emp_no)
	WHERE 
		dept_emp.to_date >= NOW()
	AND 
		salaries.to_date >= NOW()
	) AS t1 # This is table_1 result created
INNER JOIN
	(
	-- Part 2 builds another table to cross reference the previous part with the calculated max salaries
	SELECT dept_name, MAX(salary) as max_salary
	FROM 
		(
		SELECT
			salary, dept_name, first_name, last_name
		FROM
			salaries
		JOIN
			dept_emp 
		USING(emp_no)
		JOIN 
			departments 
		USING(dept_no)
		JOIN 
			employees
		USING(emp_no)
		WHERE 
			dept_emp.to_date >= NOW()
			AND 
			salaries.to_date >= NOW()
		) as t2
	GROUP BY dept_name
	) AS t2 # This is table_2 result created
	-- Joins both tables based on the dept_name and matches the salary & department name with the max_salary
	ON 
	t1.dept_name = t2.dept_name
	AND
	t1.salary = t2.max_salary
ORDER BY 'Department Name' DESC;