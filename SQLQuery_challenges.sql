/*creating database*/
CREATE DATABASE EmployeeDetails;
/*creating employee table*/
CREATE TABLE employee(
    employee_name VARCHAR(40),
    salary INT
);
/*adding details to the table*/
INSERT INTO employee (employee_name, salary, employee_id)
VALUES ('Philip',19000, 1),
        ('Joan', 24900, 2),
        ('Mustapha', 33000, 3),
        ('Ester', 22000, 4),
        ('Jonathan', 25000, 5),
        ('Caleb', 38000, 6),
        ('JB', 14440, 7),
        ('Lucky', 27600, 8),
        ('Eugine', 65000, 9),
        ('Nicholas', 46000, 10),
        ('Dancun', 40000, 11)

/*checking if the table has the details*/
SELECT * FROM employee 
ORDER BY salary;

/*Write an SQL query to get the third-highest salary of an employee from employee_table?*/
Select TOP 1 salary
from (
    SELECT DISTINCT TOP 3 salary
    from employee 
    ORDER BY salary DESC
    ) AS temp
    ORDER BY salary

/* i find this much easier for every to understand as compared to the one above*/
select min(salary) from employee
where salary in (select DISTINCT top(3) salary from employee order by salary desc)

/*creating a sales table*/
CREATE TABLE sales(
    employee_id int,
    weekSales VARCHAR (255),
    PRIMARY KEY(employee_id)
    
)
/*altering table*/
ALTER TABLE employee
ADD employee_id INT,
    FOREIGN KEY(employee_id) REFERENCES sales(employee_id)

/* inserting into sales*/
INSERT INTO sales (employee_id, weekSales)
VALUES (1, 'sales'),
      (2, 'no sales'),
      (3, 'sales'),
      (4, 'no sales'),
      (5, 'sales'),
      (6, 'no sales'),
      (7, 'sales'),
      (8, 'sales'),
      (9, 'no sales'),
      (10, 'no sales'),
      (11, 'sales')
/*checking if columns have anything*/
select * from sales
/*Write a query to fetch all employees who made no sales*/ /*&*/
/*this displayed all no sales*/
-- Paginate your results such that you only show 3 records at a time
SELECT sales.employee_id, employee.employee_name , employee.salary, sales.weekSales
FROM employee
left JOIN sales on sales.employee_id = employee.employee_id
WHERE sales.weekSales = 'no sales'
ORDER BY employee_id
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY


DECLARE @I INT=2
DECLARE @PRIME INT=0
DECLARE @OUT TABLE (NUM INT)
WHILE @I<=1000
BEGIN
     DECLARE @J INT = @I-1
     SET @PRIME=1
     WHILE @J>1
     BEGIN 
         IF @I % @J=0
         BEGIN
             SET @PRIME=0
         END
         SET @J=@J-1
     END    
     IF @PRIME=1
     BEGIN  
         INSERT @OUT VALUES (@I)
     END
     SET @I=@I+1 
END
SELECT * FROM @OUT


-- 4.Group By, Having Clause – Assuming you have Customers table; with columns 
-- CustomerID, CustomerName, ContactName, Address, City, PostalCode and Country. 
-- Write a query to list the number of customers in each country; 
-- only include countries with more than 3 customers
CREATE TABLE customers (
    CustomerID INT, CustomerName VARCHAR(255), 
    ContactName VARCHAR(255), Address VARCHAR(255),
    City VARCHAR(100), PostalCode VARCHAR(150), Country VARCHAR(50)
)

INSERT INTO customers (CustomerID, CustomerName,ContactName, Address,City, PostalCode, Country)
 VALUES (1, 'Joe', 'Joseph', 'kanisa51', 'Eldoret', 51, 'Kenya'),
        (2, 'Jane', 'Jane', 'kanairo', 'Nairobi', 21, 'Kenya'),
  (3, 'Juliet', 'Juliet', 'amma', 'dodoma', 12, 'Tanzania'),
  (4, 'Jamie', 'James','kamp', 'Kampala', 51, 'Uganda'),
  (5, 'Julia', 'J', 'Julia1', 'kisumu', 111, 'Kenya'),
  (6, 'Milly', 'Mildred', 'Nyc', 'Nyeri', 51, 'Angola'),
  (7, 'Jona', 'Jonathan', 'kamaye', 'Mombasa', 001, 'Kenya'),
  (8, 'Joan', 'Joan', 'kanis1', 'Maputo', 51, 'Mozambique'),
  (9, 'jb', 'JoMaina', 'kania11', 'Eldoret', 51,'nambia'),
  (10, 'wakadinali', 'munga', 'ronagi', 'nairobi', 51, 'Kenya'),
  (11, 'Cal', 'caleb', 'kanisa51', 'Eldoret', 51,'somalia')

SELECT count(CustomerID)NoOfCustomers,Country from customers
GROUP BY Country HAVING count(CustomerID) >= 3
