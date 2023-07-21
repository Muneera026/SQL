CREATE DATABASE Employee;
USE Employee;

-- Create EmployeeDetails table
CREATE TABLE EmployeeDetails (
    EmpId INT PRIMARY KEY,
    FullName VARCHAR(100),
    ManagerId INT,
    DateOfJoining DATE,
    City VARCHAR(50)
);

-- Create EmployeeSalary table
CREATE TABLE EmployeeSalary (
    EmpId INT,
    Project VARCHAR(100),
    Salary DECIMAL(10, 2),
    FOREIGN KEY (EmpId) REFERENCES EmployeeDetails(EmpId)
);

-- Insert data into EmployeeDetails table

INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId, DateOfJoining, City)
VALUES
    (1, 'John', NULL, '2020-05-15', 'Bangalore'),
    (2, 'Smith', 1, '2019-12-01', 'Delhi'),
    (3, 'Michael', 1, '2022-02-10', 'Chennai'),
    (4, 'Sarah', 2, '2021-09-03', 'Pune'),
    (5, 'David', 3, '2023-01-20', 'Hydrabad');
-------------------------------------------------------------------------------------------------------

-- Insert data into EmployeeSalary table

INSERT INTO EmployeeSalary (EmpId, Project, Salary)
VALUES
    (1, 'Project A', 75000),
    (2, 'Project B', 85000),
    (3, 'Project C', 70000),
    (4, 'Project D', 80000),
    (5, 'Project E', 90000);
-------------------------------------------------------------------------------------------------------
    
-- 1)SQL Query to fetch records that are present in one table but not in another table

SELECT *FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary);
------    OR   ------
SELECT EmployeeDetails.* FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId
WHERE EmployeeSalary.EmpId IS NULL;
-------------------------------------------------------------------------------------------------------

-- 2)SQL query to fetch all the employees who are not working on any project.

SELECT * FROM EmployeeDetails
WHERE NOT EXISTS (SELECT 1 FROM EmployeeSalary WHERE EmployeeDetails.EmpId = EmployeeSalary.EmpId);
-------------------------------------------------------------------------------------------------------

-- 3)SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.

SELECT * FROM EmployeeDetails
WHERE EXTRACT(YEAR FROM DateOfJoining) = 2020;
-------------------------------------------------------------------------------------------------------

-- 4)Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.
SELECT EmployeeDetails.* FROM EmployeeDetails
INNER JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId;
------    OR   ------
SELECT * FROM EmployeeDetails
WHERE EXISTS (SELECT 1 FROM EmployeeSalary WHERE EmployeeDetails.EmpId = EmployeeSalary.EmpId);
-------------------------------------------------------------------------------------------------------

-- 5)Write an SQL query to fetch a project-wise count of employees.
SELECT Project, COUNT(EmpId) AS EmployeeCount
FROM EmployeeSalary GROUP BY Project;
-------------------------------------------------------------------------------------------------------

-- 6)Fetch employee names and salaries even if the salary value is not present for the employee.
SELECT EmployeeDetails.FullName, EmployeeSalary.Salary FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId;
-------------------------------------------------------------------------------------------------------

-- 7)Write an SQL query to fetch all the Employees who are also managers.
SELECT e1.* FROM EmployeeDetails e1
INNER JOIN EmployeeDetails e2 ON e1.EmpId = e2.ManagerId;
-------------------------------------------------------------------------------------------------------

-- 8)Write an SQL query to fetch duplicate records from EmployeeDetails.
SELECT FullName, COUNT(*) AS DuplicateCount
FROM EmployeeDetails GROUP BY FullName HAVING COUNT(*) > 1;
-------------------------------------------------------------------------------------------------------

-- 9)Write an SQL query to fetch only odd rows from the table.
SELECT * FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum
  FROM EmployeeDetails) AS Subquery
WHERE RowNum % 2 = 1;
-------------------------------------------------------------------------------------------------------

-- 10)Write a query to find the 3rd highest salary from a table without top or limit keyword.
SELECT DISTINCT Salary
FROM EmployeeSalary e1
WHERE 3 = (
    SELECT COUNT(DISTINCT Salary)
    FROM EmployeeSalary e2
    WHERE e2.Salary >= e1.Salary
);


