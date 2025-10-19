🟢 EASY-LEVEL TASKS (Oson darajadagi topshiriqlar)

1️⃣ Using Products table, find the total number of products available in each category.
SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;

2️⃣ Using Products table, get the average price of products in the 'Electronics' category.
SELECT AVG(Price) AS AvgPrice
FROM Products
WHERE Category = 'Electronics';

3️⃣ Using Customers table, list all customers from cities that start with 'L'.
SELECT * 
FROM Customers
WHERE City LIKE 'L%';

4️⃣ Using Products table, get all product names that end with 'er'.
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';

5️⃣ Using Customers table, list all customers from countries ending in 'A'.
SELECT *
FROM Customers
WHERE Country LIKE '%A';

6️⃣ Using Products table, show the highest price among all products.
SELECT MAX(Price) AS HighestPrice
FROM Products;

7️⃣ Using Products table, label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.
SELECT ProductName,
       StockQuantity,
       CASE 
           WHEN StockQuantity < 30 THEN 'Low Stock'
           ELSE 'Sufficient'
       END AS StockStatus
FROM Products;

8️⃣ Using Customers table, find the total number of customers in each country.
 SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;

##Buyurtma qilingan eng kam va eng ko‘p miqdorni toping.

SELECT MIN(Quantity) AS MinQty, MAX(Quantity) AS MaxQty
FROM Orders;

🟡 MEDIUM-LEVEL TASKS (O‘rta darajadagi topshiriqlar)
2023-yil yanvar oyida buyurtma bergan, lekin hisob-fakturasi (invoice) bo‘lmagan mijozlarni toping.

SELECT DISTINCT o.CustomerID
FROM Orders o
WHERE YEAR(o.OrderDate) = 2023 AND MONTH(o.OrderDate) = 1
AND o.CustomerID NOT IN (
    SELECT CustomerID FROM Invoices
);

Ikkala jadvaldagi barcha mahsulot nomlarini takrorlari bilan birlashtiring.

SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;

Ikkala jadvaldagi mahsulotlarni takrorsiz (unique) tarzda birlashtiring.

SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

Har bir yil bo‘yicha o‘rtacha buyurtma summasini toping.

SELECT YEAR(OrderDate) AS OrderYear,
       AVG(TotalAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate);

Narx oralig‘iga qarab mahsulotlarni guruhlang:
‘Low’ — 100 dan kam, ‘Mid’ — 100–500, ‘High’ — 500 dan yuqori.

SELECT ProductName,
       CASE 
           WHEN Price < 100 THEN 'Low'
           WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
           ELSE 'High'
       END AS PriceGroup
FROM Products;

Pivot yordamida yillarni ustunlarga aylantiring (2012, 2013) va natijani yangi jadvalga saqlang.

SELECT *
INTO Population_Each_Year
FROM (
    SELECT district_name, year, population FROM City_Population
) AS SourceTable
PIVOT (
    SUM(population) FOR year IN ([2012], [2013])
) AS PivotTable;

Har bir ProductID bo‘yicha jami savdoni toping.

SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;

Nomi ichida ‘oo’ bo‘lgan mahsulotlarni toping.

SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';

Shahar nomlarini ustunlarga aylantiring va yangi jadvalga yozing.

SELECT *
INTO Population_Each_City
FROM (
    SELECT year, district_name, population FROM City_Population
) AS SourceTable
PIVOT (
    SUM(population) FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS PivotTable;

🔴 HARD-LEVEL TASKS (Murakkab topshiriqlar)
Eng ko‘p xarajat qilgan 3 ta mijozni toping.

SELECT TOP 3 CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

Pivotdan keyingi jadvalni asl holatga (UNPIVOT) qaytaring.

SELECT district_name, year, population
FROM Population_Each_Year
UNPIVOT (
    population FOR year IN ([2012], [2013])
) AS UnpivotTable;

Har bir mahsulot necha marta sotilganini JOIN orqali toping.

SELECT p.ProductName, COUNT(s.SaleID) AS TimesSold
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName;

Shaharlar pivot jadvalini asl holatga qaytaring.

SELECT year, district_name, population
FROM Population_Each_City
UNPIVOT (
    population FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS UnpivotTable;







