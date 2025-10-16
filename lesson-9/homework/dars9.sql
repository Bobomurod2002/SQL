Let's start with the Easy-Level tasks (first 5 as examples) based on your provided tables.
1. Using Products and Suppliers tables:

List all combinations of product names and supplier names.

This is a Cartesian product, which can be done with CROSS JOIN or simply JOIN without ON clause (not recommended but possible).

SELECT P.ProductName, S.SupplierName
FROM Products P
CROSS JOIN Suppliers S;

2. Using Departments and Employees tables:

Get all combinations of departments and employees.

Also a Cartesian product:

SELECT D.DepartmentName, E.Name
FROM Departments D
CROSS JOIN Employees E;

3. Using Products and Suppliers tables:

List only the combinations where the supplier actually supplies the product. Return supplier name and product name.

Assuming there is a relation via SupplierID in Products (which is typical), use INNER JOIN:

SELECT S.SupplierName, P.ProductName
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID;

4. Using Orders and Customers tables:

List customer names and their orders ID.

Customer name is from Customers table, orders from Orders table, linked by CustomerID:

SELECT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID;

5. Using Courses and Students tables:

Get all combinations of students and courses.

Assuming no direct relationship, this is a Cartesian product:

SELECT S.StudentName, C.CourseName
FROM Students S
CROSS JOIN Courses C;

Here are the solutions for the easy-level 10 tasks:

1. Using Products, Suppliers table — List only the combinations where the supplier actually supplies the product. Return supplier name and product name.
SELECT s.SupplierName, p.ProductName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID;

2. Using Orders, Customers table — List customer names and their orders ID.
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, o.OrderID
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID;

3. Using Products, Orders table — Get product names and orders where product IDs match.
SELECT p.ProductName, o.OrderID
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID;

4. Using Departments, Employees table — List employees whose DepartmentID matches the department.
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

5. Using Students, Enrollments table — List student names and their enrolled course IDs.
SELECT s.Name AS StudentName, e.CourseID
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID;

6. Using Payments, Orders table — List all orders that have matching payments.
SELECT o.OrderID
FROM Orders o
INNER JOIN Payments p ON o.OrderID = p.OrderID;

7. Using Orders, Products table — Show orders where product price is more than 100.
SELECT o.OrderID, p.ProductName, p.Price
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE p.Price > 100;

8. Using Products, Suppliers table — List all combinations of product names and supplier names.
SELECT p.ProductName, s.SupplierName
FROM Products p
CROSS JOIN Suppliers s;

9. Using Departments, Employees table — Get all combinations of departments and employees.
SELECT d.DepartmentName, e.Name AS EmployeeName
FROM Departments d
CROSS JOIN Employees e;

10. Using Courses, Students table — Get all combinations of students and courses.
SELECT c.CourseName, s.Name AS StudentName
FROM Courses c
CROSS JOIN Students s;

