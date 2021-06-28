##Q1
USE employees;
SELECT *
from employees;

##Q2
SELECT *
FROM employees
WHERE first_name in ('Irena', 'Vidya', 'Maya');
#709 employees have either one of these names

##Q3
SELECT *
FROM employees
WHERE (first_name = 'Irena' 
	OR first_name = 'Vidya'
	OR first_name = 'Maya');
#709 employees

##Q4
SELECT *
FROM employees
WHERE gender = 'M'
	AND (first_name = 'Irena' 
	OR first_name = 'Vidya'
	OR first_name = 'Maya');
#441 employees are male and also have any one of these names

##Q5
SELECT *
FROM employees
WHERE last_name LIKE 'E%';
#7330 emplyees' names begin with 'e'

##Q6
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
	OR last_name LIKE '%E';
#30723 employees' names begin or end with 'e'
#23393 employees' last names end with and 'e' but don't start with 'e'

##Q7
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
	AND last_name LIKE '%E';
#899 emnployees' names begin and end with 'e'
#24292 employees' names end with 'e'

##Q8
SELECT *
FROM employees
WHERE hire_date LIKE '199%';
#135214 employees hired in the 90s

##Q9
SELECT *
FROM employees
WHERE birth_date LIKE '%-12-25';
#842 employees were born on Christmas

##Q10
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%-12-25';
#employees were born on Christmas and hired in the 90s

##Q11
SELECT *
FROM employees
WHERE last_name LIKE '%q%';
#1873 employees have a 'q' in their last name

##Q12
SELECT *
FROM employees
WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%';
#547 employees have 'q' in their last name but don't have 'qu'