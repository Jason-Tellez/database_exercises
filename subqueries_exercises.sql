USE employees;

# 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT *
FROM employees
WHERE hire_date = (
		SELECT hire_date
		FROM employees
		WHERE emp_no = 101010
)
AND emp_no IN (
		SELECT emp_no
		FROM salaries
		WHERE to_date > NOW()
);
	
	
# 2. Find all the titles ever held by all current employees with the first name Aamod.
SELECT DISTINCT Title
FROM titles
WHERE emp_no IN (
		SELECT emp_no
		FROM employees
		WHERE first_name = 'Aamod'
		AND emp_no IN (
				SELECT emp_no
				FROM dept_emp
				WHERE to_date > NOW()
	)
)
ORDER BY Title;					#All the titles ever held by all current employees named Aamod are
					#Senior Staff, Staff, Engineer, Technique Leader, Senior Engineer, and Assistant Engineer
	

# 3 How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT COUNT(*)
FROM employees
WHERE emp_no NOT IN (						#shows people in the list that are not currently employed
		SELECT emp_no
		FROM dept_emp
		WHERE to_date > NOW()					#to_date may
);						#59900 people are former employees
	
	
# 4. Find all the current department managers that are female. List their names in a comment in your code.
SELECT CONCAT(first_name, ' ', last_name) AS 'Manager Name', Gender
FROM employees
WHERE emp_no IN (
		SELECT emp_no
		FROM dept_manager
		WHERE to_date > NOW()
)
AND gender = 'F';						##Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil
	
	
# 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT *
FROM employees
WHERE employees.emp_no IN (
		SELECT salaries.emp_no
		FROM salaries
		WHERE salary > (
				SELECT AVG(salary)
				FROM salaries
		)
		AND salaries.to_date > NOW()
);
	
	
# 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

SELECT COUNT(*) AS No_of_emp
FROM dept_emp
WHERE emp_no IN (
		SELECT emp_no
		FROM salaries
		WHERE salary >= 
		(
				SELECT MAX(salary) - STD(salary)
				FROM salaries
		) 
		AND salary < (
				SELECT MAX(salary)
				FROM salaries
		) 
		AND to_date > NOW()
);					
	
SELECT CONCAT((87 / COUNT(*) * 100), '%') AS Percentage
FROM dept_emp
WHERE to_date > NOW();				#0.0167% of all employees are currently with one standard deviation of the highest salary


#Bonus
# B1. Find all the department names that currently have female managers.
SELECT d.dept_name
FROM dept_manager AS dm
JOIN departments as d
		ON d.dept_no = dm.dept_no
WHERE to_date > NOW()
AND emp_no IN (
		SELECT emp_no
		FROM employees
		WHERE gender LIKE 'F'
);								#Finance, HR, Development, Research	
	
	
# B2. Find the first and last name of the employee with the highest salary.
SELECT first_name, last_name
FROM employees
WHERE emp_no = (
		SELECT emp_no
	   FROM salaries
	    WHERE salary = (
	    		SELECT MAX(salary)
	    		FROM salaries)
);						#Tokuyasu Pesch


# B3. Find the department name that the employee with the highest salary works in.
SELECT dept_name
FROM departments
WHERE dept_no LIKE (
		SELECT dept_no
	   FROM dept_emp
		WHERE emp_no = (
			SELECT emp_no
			FROM salaries
	    	  WHERE salary = (
	    			SELECT MAX(salary)
	    			FROM salaries
	    		)
	     )
);					#Sales