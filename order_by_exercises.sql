##Q1
USE employees;
SELECT *
from employees;

##Q2
SELECT *
FROM employees
WHERE first_name in ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
#First row: Irena Reutenauer
#Last Row: Vidya Simmen

##Q3
SELECT *
FROM employees
WHERE first_name in ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;
#First name: Irena Acton
#Last Row: Vidya Zweizig

##Q4
SELECT *
FROM employees
WHERE first_name in ('Irena', 'Vidya', 'Maya')
ORDER BY last_name,first_name;
#First Row: Irena Acton
#Last Row: Maya Zyda

##Q5
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
	AND last_name LIKE '%E'
ORDER BY emp_no;
#899 employees were returned
#First row: 10021, Ramzi Erde
#Last row: 499648, Tadahiro Erde

##Q6
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
	AND last_name LIKE '%E'
ORDER BY hire_date DESC;
#899 employees returned
#Newest: Teiji Eldridge
#Oldest: Sergi Erde

##Q7
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%-12-25'
ORDER BY birth_date, hire_date DESC;
#362 employees returned
#Oldest employee hired last: Khun Bernini
#Youngest employee hired first: Douadi Pettis