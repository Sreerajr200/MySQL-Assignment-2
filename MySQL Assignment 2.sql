/* USE employee;
show tables;
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Software Development'),
(2, 'Marketing'),
(3, 'Data Science'),
(4, 'Human Resources'),
(5, 'Product Management'),
(6, 'Content Creation'),
(7, 'Finance'),
(8, 'Design'),
(9, 'Research and Development'),
(10, 'Customer Support'),
(11, 'Business Development'),
(12, 'IT'),
(13, 'Operations');
--
show tables; 
select * from departments;
select * from location;
INSERT INTO location (location_name) VALUES
('Chennai'),
('Bangalore'),
('Hyderabad'),
('Pune');
*/
select * from employees;

-- 1. Distinct Values: ⦿ a query to retrieve distinct salaries from the Employees table.
select distinct salary from employees;

-- 2. Alias (AS): ⦿ Provide aliases for the "age" and "salary" columns as "Employee_Age" and "Employee_Salary", respectively.
select age as Employee_Age, salary as Employee_Salary from employees;

-- 3. Where Clause & Operators:
-- 	Retrieve employees with a salary greater than ₹50000 and hired before 2016-01-01.
select * from employees 
where salary > 50000
and hire_date < '2016-01-01';

-- Find the employee whose designation is missing and fill it with "Data Scientist".
select * from employees where designation is null;
update employees set designation = 'Data Scientist' 
where employee_id in 
( select employee_id from 
(SELECT employee_id
        FROM Employees
        WHERE designation IS NULL) as MissingEmployees
) ;

-- Sorting and Grouping Data:
-- 1. ORDER BY: ⦿ Find employees sorted by department ID in ascending order and salary in descending order.
select * from employees order by department_id, salary desc;

-- 2. LIMIT: ⦿ Display the first 5 employees hired in the year 2018.
select * from employees where hire_date >= '2018-01-01' order by hire_date limit 5;

-- 3. Aggregate Functions:
-- Calculate the sum of all salaries in the Finance department.
select sum(e.salary) as Total_Salary_For_Finance from employees e 
join departments d on e.department_id = d.department_id
where d.department_name = 'Finance';

-- Find the minimum age among all employees.
select min(age) as Minimum_Age from employees;

-- 4. GROUP BY:
-- List the maximum salary for each location.
select * from employees;
select * from location;

select location_name, max(salary) as Maximum_Salary from employees e 
join location l on e.location_id = l.location_id
group by location_name;

-- Calculate the average salary for each designation containing the word 'Analyst'.
select designation as Designation, avg(salary) as Average_Salary from employees
where designation like '%Analyst%'
group by designation order by 1;

-- 5. HAVING:
-- ⦿ Find departments with less than 3 employees.
select department_name, count(employee_id) as Count_Of_Employees from employees e
join departments d on e.department_id = d.department_id
group by department_name
having count(employee_id) < 3
;

-- Find locations with female employees whose average age is below 30.
select location_name, avg(age) from employees e join location l 
on e.location_id = l.location_id
where e.gender = 'F'
group by location_name
having avg(age) < 30
;

select * from employees;

-- Joins:
-- 1. Inner Join:
-- ⦿ List employee names, their designations, and department names where employees are assigned to a department.

select employee_name, designation, department_name from employees e join departments d
on e.department_id = d.department_id;

-- 2. Left Join: ⦿ List all departments along with the total number of employees in each
-- department, including departments with no employees.
select department_name, count(employee_id) from departments d left join employees e
on d.department_id = e.department_id
group by department_name;

-- 3. Right Join: ⦿ Display all locations along with the names of employees assigned to each
-- location. If no employees are assigned to a location, display NULL for employee name.
select location_name, employee_name from employees e right join location l
on e.location_id = l.location_id;

