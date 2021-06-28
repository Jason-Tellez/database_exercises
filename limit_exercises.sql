USE employees;
SELECT *
FROM employees;

##Q2
SELECT DISTINCT last_name 
FROM employees
ORDER BY last_name
LIMIT 10;

##Q3
SELECT *
FROM employees
WHERE hire_date LIKE '199%' AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5;
#First five employees hire in the 90s: Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup

##Q4
SELECT *
FROM employees
WHERE hire_date LIKE '199%' AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5
OFFSET 50;
#By thinking of LIMIT as an entire page in a book, we can think of OFFSET as a bookmark so that we can continue "reading" at the "page number" we stopped at.
