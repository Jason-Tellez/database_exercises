#1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department.
#Update the table so that full name column contains the correct data
#Remove the first_name and last_name columns from the table.
#What is another way you could have ended up with this same table?
USE employees;
CREATE TEMPORARY TABLE germain_1468.employees_with_departments AS
SELECT first_name, last_name, dept_name
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no);

#	Adding a columnn named full_name to the table that will hold the each employees full name.
ALTER TABLE germain_1468.employees_with_departments ADD full_name VARCHAR(31);

#	Filling the full_name column to hold each employees whole name
UPDATE germain_1468.employees_with_departments SET full_name = concat(first_name, ' ', last_name);

#	Dropping both the first_name column and the last_name column
ALTER TABLE germain_1468.employees_with_departments DROP first_name;
ALTER TABLE germain_1468.employees_with_departments DROP last_name;

#	A simpler way to get the same the same result is to use the same CONCAT function in the SELECT field and while still selecting department name.


# 2. Create a temporary table based on the payment table from the sakila database. 
#Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.;

USE sakila;
CREATE TEMPORARY TABLE germain_1468.payment_in_cents AS
SELECT *
FROM payment;

# Modify amount datatype to increase total number of figures each values can hold
ALTER TABLE germain_1468.payment_in_cents MODIFY amount DECIMAL(10,2);

# Multiply each value by 100 to represent cents
UPDATE germain_1468.payment_in_cents SET amount = amount * 100;

# Change datatype to INT
ALTER TABLE germain_1468.payment_in_cents MODIFY amount INT;


# 3. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?
USE employees;
CREATE TABLE germain_1468.salary_comparison AS		#This table will hold all info
SELECT dept_name, AVG(salary) AS current_avg
FROM dept_emp
JOIN departments USING(dept_no)
JOIN salaries USING(emp_no)
WHERE salaries.to_date > NOW()
GROUP BY dept_name;

#ZSCORE
#This table holds std dev and avg of historical salaries
#Components to calculate zscore
use employees;
CREATE TABLE germain_1468.hist_info AS
SELECT AVG(salary) AS hist_avg, std(salary) AS hist_std
FROM salaries;

use germain_1468;

ALTER TABLE salary_comparison ADD hist_avg float(10,2);		#Create columns in main table that will hold zscore's elements and the zscore column
ALTER TABLE salary_comparison ADD hist_std float(10,2);
ALTER TABLE salary_comparison ADD zscore float(10,2);

UPDATE salary_comparison SET hist_avg = (SELECT hist_avg FROM hist_info);		#Updating empty columns with relevant data
UPDATE salary_comparison SET hist_std = (SELECT hist_std FROM hist_info);
UPDATE salary_comparison set zscore = (current_avg - hist_avg) / hist_std;		#Final zscore column with relevant data

select *
FROM salary_comparison;

#In terms of salary, Sales is the best department to work for since it has the highest average salary as well as the highest zscore. This means that the average sales person's salary has increased from the historical average salary more than any any other department.
#The worst department to work for would be HR, since it has the lowest average salary and has hardly increased from the historic average salaryg