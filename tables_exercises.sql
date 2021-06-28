SHOW DATABASES;
USE employees;
SHOW TABLES;
DESCRIBE employees;
#employee number is the only int type
#name and gender columns are string type
#dates are date type
SELECT *
FROM employees;
SELECT *
FROM departments;
#the relationship is that all the employees will be located within a specific department from the departments table
SHOW CREATE TABLE dept_manager;