🟢 EASY LEVEL TASKS (7 ta)
1. Orders after 2022

Return: OrderID, CustomerName, OrderDate
Tables: Orders, Customers

SELECT 
    o.OrderID,
    c.CustomerName,
    o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) > 2022;


🟢 Izoh: JOIN bilan buyurtmani bergan mijoz topiladi, YEAR() orqali faqat 2022-yildan keyin berilganlar olinadi.

2. Employees in Sales or Marketing

Return: EmployeeName, DepartmentName

SELECT 
    e.EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing');


🟢 Izoh: IN operatori bir nechta qiymatni solishtirish uchun ishlatiladi.

3. Max salary by department

Return: DepartmentName, MaxSalary

SELECT 
    d.DepartmentName,
    MAX(e.Salary) AS MaxSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;


🟢 Izoh: GROUP BY — har bir bo‘lim bo‘yicha guruhlaydi, MAX() esa eng katta oylikni topadi.

4. USA customers with 2023 orders

Return: CustomerName, OrderID, OrderDate

SELECT 
    c.CustomerName,
    o.OrderID,
    o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' 
  AND YEAR(o.OrderDate) = 2023;


🟢 Izoh: Ikkita shart qo‘yilgan — mamlakat USA va buyurtma yili 2023.

5. Total orders per customer

Return: CustomerName, TotalOrders

SELECT 
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;


🟢 Izoh: LEFT JOIN — buyurtmasi bo‘lmasa ham mijoz chiqadi. COUNT() — nechta buyurtma berganini sanaydi.

6. Products from certain suppliers

Return: ProductName, SupplierName

SELECT 
    p.ProductName,
    s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies', 'Clothing Mart');


🟢 Izoh: Faqat shu ikkita yetkazib beruvchiga tegishli mahsulotlar olinadi.

7. Most recent order per customer

Return: CustomerName, MostRecentOrderDate

SELECT 
    c.CustomerName,
    MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;


🟢 Izoh: MAX(OrderDate) eng so‘nggi buyurtma sanasini topadi. LEFT JOIN — buyurtmasi yo‘q mijozlarni ham ko‘rsatadi.

🟠 MEDIUM LEVEL TASKS (6 ta)
1. Orders > 500

Return: CustomerName, OrderTotal

SELECT 
    c.CustomerName,
    o.OrderTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderTotal > 500;

2. Sales in 2022 or amount > 400

Return: ProductName, SaleDate, SaleAmount

SELECT 
    p.ProductName,
    s.SaleDate,
    s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2022 
   OR s.SaleAmount > 400;

3. Total sales amount per product

Return: ProductName, TotalSalesAmount

SELECT 
    p.ProductName,
    SUM(s.SaleAmount) AS TotalSalesAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName;


🟢 Izoh: Har bir mahsulot uchun jami sotuv summasi hisoblanadi (SUM()).

4. HR employees with salary > 60000

Return: EmployeeName, DepartmentName, Salary

SELECT 
    e.EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'HR' 
  AND e.Salary > 60000;

5. Sold in 2023 with stock > 100

Return: ProductName, SaleDate, StockQuantity

SELECT 
    p.ProductName,
    s.SaleDate,
    p.StockQuantity
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2023 
  AND p.StockQuantity > 100;

6. Sales dept or hired after 2020

Return: EmployeeName, DepartmentName, HireDate

SELECT 
    e.EmployeeName,
    d.DepartmentName,
    e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' 
   OR YEAR(e.HireDate) > 2020;

🔴 HARD LEVEL TASKS (7 ta)
1. USA customers with address starting with digits

Return: CustomerName, OrderID, Address, OrderDate

SELECT 
    c.CustomerName,
    o.OrderID,
    c.Address,
    o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'
  AND c.Address LIKE '[0-9][0-9][0-9][0-9]%';


🟢 Izoh: LIKE '[0-9][0-9][0-9][0-9]%' — manzil 4 raqam bilan boshlanishini bildiradi.

2. Electronics or sale > 350

Return: ProductName, Category, SaleAmount

SELECT 
    p.ProductName,
    p.Category,
    s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE p.Category = 'Electronics' 
   OR s.SaleAmount > 350;

3. Product count per category

Return: CategoryName, ProductCount

SELECT 
    c.CategoryName,
    COUNT(p.ProductID) AS ProductCount
FROM Categories c
LEFT JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;


🟢 Izoh: LEFT JOIN orqali mahsulot yo‘q toifalar ham chiqadi.

4. Los Angeles orders > 300

Return: CustomerName, City, OrderID, Amount

SELECT 
    c.CustomerName,
    c.City,
    o.OrderID,
    o.Amount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City = 'Los Angeles' 
  AND o.Amount > 300;

5. HR or Finance or name has ≥4 vowels

Return: EmployeeName, DepartmentName

SELECT 
    e.EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('HR', 'Finance')
   OR LEN(e.EmployeeName) - LEN(REPLACE(LOWER(e.EmployeeName), 'a', '')) 
     + LEN(e.EmployeeName) - LEN(REPLACE(LOWER(e.EmployeeName), 'e', '')) 
     + LEN(e.EmployeeName) - LEN(REPLACE(LOWER(e.EmployeeName), 'i', '')) 
     + LEN(e.EmployeeName) - LEN(REPLACE(LOWER(e.EmployeeName), 'o', '')) 
     + LEN(e.EmployeeName) - LEN(REPLACE(LOWER(e.EmployeeName), 'u', '')) >= 4;


🟢 Izoh: Bu ifoda ismda nechta unli harf (a, e, i, o, u) borligini sanaydi.

6. Sales or Marketing with salary > 60000

Return: EmployeeName, DepartmentName, Salary

SELECT 
    e.EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing')
  AND e.Salary > 60000;
