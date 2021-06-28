USE employees;
SELECT *
FROM titles;
SELECT *
FROM employees;

#2
SELECT DISTINCT title
FROM titles;
#There are 7 unitque titles

#3
SELECT last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;

#4
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY first_name, last_name;

#5
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%' 
	AND last_name NOT LIKE '%qu%';
#Unique last names are Chleq, Lindqvist, and Qiwen

#6
SELECT last_name, COUNT(*) AS number_of_employees
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
#Chleq 189, Lindqvist 190, Qiwen 168

#7 Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names
SELECT first_name, gender, COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender, first_name;

#8 Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
SELECT 
	LOWER(
	
		CONCAT(
		
			SUBSTR(first_name, 1, 1),
			SUBSTR(last_name, 1, 4),
			'_',
			SUBSTR(birth_date, 6, 2),
			SUBSTR(birth_date, 3, 2)
			
			)
			
		) AS username,
		
	COUNT(
	
		LOWER(
		
			CONCAT(
			
				SUBSTR(first_name, 1, 1),
				SUBSTR(last_name, 1, 4), 
				'_',
				SUBSTR(birth_date, 6, 2),
				SUBSTR(birth_date, 3, 2)
				
				)
				
			)
			
		) AS total_usernames
FROM employees
GROUP BY username
HAVING COUNT(*) > 1;
#There are 285872 unique usernames
#Of the unique usernames, 13251 belong to multiple employees
