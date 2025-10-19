###--🟢 EASY-LEVEL TASKS

1️⃣ Top 5 employees

SELECT TOP 5 * 
FROM Employees;


2️⃣ Unique Category values

SELECT DISTINCT Category 
FROM Products;


3️⃣ Products with Price > 100

SELECT * 
FROM Products
WHERE Price > 100;


4️⃣ Customers whose FirstName starts with 'A'

SELECT * 
FROM Customers
WHERE FirstName LIKE 'A%';


5️⃣ Products ordered by Price ascending

SELECT * 
FROM Products
ORDER BY Price ASC;


6️⃣ Employees with Salary >= 60000 and DepartmentName = 'HR'

SELECT * 
FROM Employees
WHERE Salary >= 60000 AND DepartmentName = 'HR';


7️⃣ Replace NULL Email with default text using ISNULL

SELECT EmployeeID, FirstName, LastName,
       ISNULL(Email, 'noemail@example.com') AS Email
FROM Employees;


8️⃣ Products with Price BETWEEN 50 AND 100

SELECT * 
FROM Products
WHERE Price BETWEEN 50 AND 100;


9️⃣ DISTINCT on two columns (Category, ProductName)

SELECT DISTINCT Category, ProductName
FROM Products;


🔟 Same as #9, but ordered by ProductName DESC

SELECT DISTINCT Category, ProductName
FROM Products
ORDER BY ProductName DESC;

###🟠 MEDIUM-LEVEL TASKS

1️⃣ Top 10 products by Price DESC

SELECT TOP 10 * 
FROM Products
ORDER BY Price DESC;


2️⃣ COALESCE First non-NULL value (FirstName or LastName)

SELECT EmployeeID,
       COALESCE(FirstName, LastName) AS Name
FROM Employees;


3️⃣ Distinct Category and Price from Products

SELECT DISTINCT Category, Price
FROM Products;


4️⃣ Employees age between 30-40 OR Department = Marketing

SELECT * 
FROM Employees
WHERE (Age BETWEEN 30 AND 40) OR DepartmentName = 'Marketing';


5️⃣ OFFSET-FETCH (rows 11 to 20) by Salary DESC

SELECT * 
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;


6️⃣ Products with Price <= 1000 AND StockQuantity > 50 sorted by Stock asc

SELECT * 
FROM Products
WHERE Price <= 1000 AND StockQuantity > 50
ORDER BY StockQuantity ASC;


7️⃣ Products whose name contains 'e'

SELECT * 
FROM Products
WHERE ProductName LIKE '%e%';


8️⃣ Employees working in HR, IT, or Finance

SELECT * 
FROM Employees
WHERE DepartmentName IN ('HR', 'IT', 'Finance');


9️⃣ Customers ordered by City (ASC), PostalCode (DESC)

SELECT * 
FROM Customers
ORDER BY City ASC, PostalCode DESC;

###🔴 HARD-LEVEL TASKS

1️⃣ Top 5 products with highest sales (by SaleAmount)

SELECT TOP 5 ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID
ORDER BY TotalSales DESC;


2️⃣ Combine FirstName and LastName into FullName

SELECT EmployeeID,
       (COALESCE(FirstName, '') + ' ' + COALESCE(LastName, '')) AS FullName,
       DepartmentName, Salary
FROM Employees;


3️⃣ Distinct Category, ProductName, Price where Price > 50

SELECT DISTINCT Category, ProductName, Price
FROM Products
WHERE Price > 50;


4️⃣ Products priced less than 10% of average price

SELECT * 
FROM Products
WHERE Price < (SELECT AVG(Price) * 0.1 FROM Products);


5️⃣ Employees age < 30 and department in HR or IT

SELECT * 
FROM Employees
WHERE Age < 30 AND DepartmentName IN ('HR', 'IT');


6️⃣ Customers with '@gmail.com' in Email

SELECT * 
FROM Customers
WHERE Email LIKE '%@gmail.com%';


7️⃣ Employees whose salary > ALL in Sales department

SELECT * 
FROM Employees
WHERE Salary > ALL (
    SELECT Salary 
    FROM Employees 
    WHERE DepartmentName = 'Sales'
);


8️⃣ Orders in the last 180 days (use BETWEEN + GETDATE())

SELECT * 
FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();
