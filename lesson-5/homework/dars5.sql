---Easy-Level Tasks

1. Alias to rename ProductName column as Name in Products table:

SELECT ProductName AS Name
FROM Products;


2. Alias to rename Customers table as Client:

SELECT *
FROM Customers AS Client;


3. Use UNION to combine ProductName from Products and Products_Discounted:

SELECT ProductName
FROM Products
UNION
SELECT ProductName
FROM Products_Discounted;


4. Find intersection of Products and Products_Discounted using INTERSECT:

SELECT ProductName
FROM Products
INTERSECT
SELECT ProductName
FROM Products_Discounted;


5. Select distinct customer names and their Country:

SELECT DISTINCT FirstName + ' ' + LastName AS CustomerName, Country
FROM Customers;


6. CASE to create conditional column 'High' if Price > 1000 else 'Low' from Products:

SELECT ProductName,
       Price,
       CASE 
           WHEN Price > 1000 THEN 'High'
           ELSE 'Low'
       END AS PriceCategory
FROM Products;


7. IIF to create column 'Yes' if StockQuantity > 100 else 'No' from Products_Discounted:

SELECT ProductName,
       StockQuantity,
       IIF(StockQuantity > 100, 'Yes', 'No') AS StockStatus
FROM Products_Discounted;

Medium-Level Tasks

1. UNION combine ProductName from Products and Products_Discounted (similar to Easy #3):

SELECT ProductName
FROM Products
UNION
SELECT ProductName
FROM Products_Discounted;


2. EXCEPT to find difference between Products and Products_Discounted ProductNames:

SELECT ProductName
FROM Products
EXCEPT
SELECT ProductName
FROM Products_Discounted;


3. IIF to create column 'Expensive' if Price > 1000 else 'Affordable' from Products:

SELECT ProductName,
       Price,
       IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceCategory
FROM Products;


4. Find employees with Age < 25 or Salary > 60000 from Employees table:

Assuming Employees table structure (not provided), example query:

SELECT *
FROM Employees
WHERE Age < 25
   OR Salary > 60000;


5. Update salary of employees: increase by 10% if department is 'HR' or EmployeeID = 5:

Assuming Employees table has Salary, Department, and EmployeeID:

UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'HR'
   OR EmployeeID = 5;

Hard-Level Tasks

1. CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if between 200 and 500, else 'Low Tier' from Sales:

SELECT SaleID, SaleAmount,
       CASE
           WHEN SaleAmount > 500 THEN 'Top Tier'
           WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
           ELSE 'Low Tier'
       END AS SaleTier
FROM Sales;


2. EXCEPT to find CustomerID who placed orders but do not have a record in Sales:

SELECT DISTINCT CustomerID
FROM Orders
EXCEPT
SELECT DISTINCT CustomerID
FROM Sales;


3. CASE statement for discount % based on Quantity in Orders:

Discount:

1 item: 3%

Between 1 and 3 items (exclusive? inclusive? Let's assume inclusive of 3): 5%

Otherwise (more than 3): 7%

SELECT CustomerID,
       Quantity,
       CASE 
           WHEN Quantity = 1 THEN '3%'
           WHEN Quantity BETWEEN 1 AND 3 THEN '5%'
           ELSE '7%'
       END AS DiscountPercentage
FROM Orders;


Note: The "Between 1 and 3 items" overlaps with Quantity=1, so usually we interpret like this:

Quantity = 1 → 3%

Quantity BETWEEN 2 AND 3 → 5%

Quantity > 3 → 7%

Revised:

SELECT CustomerID,
       Quantity,
       CASE 
           WHEN Quantity = 1 THEN '3%'
           WHEN Quantity BETWEEN 2 AND 3 THEN '5%'
           ELSE '7%'
       END AS DiscountPercentage
FROM Orders;
