Create Temporary Table – Monthly Sales

🧩 Goal: Create a temp table with total quantity and total revenue for each product sold this month.

-- Step 1: Create temp table
DROP TABLE IF EXISTS #MonthlySales;

SELECT 
    s.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
INTO #MonthlySales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE MONTH(s.SaleDate) = MONTH(GETDATE())
  AND YEAR(s.SaleDate) = YEAR(GETDATE())
GROUP BY s.ProductID;

-- View results
SELECT * FROM #MonthlySales;


✅ Output Columns:
ProductID | TotalQuantity | TotalRevenue

2️⃣ Create View – Product Sales Summary

🧩 Goal: Show product info and total quantity sold (all time).

CREATE VIEW vw_ProductSalesSummary AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    ISNULL(SUM(s.Quantity), 0) AS TotalQuantitySold
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category;


✅ Output:
ProductID | ProductName | Category | TotalQuantitySold

3️⃣ Scalar Function – Total Revenue for Product

🧩 Goal: Return total revenue for a given product ID.

CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18,2);

    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;

    RETURN ISNULL(@TotalRevenue, 0);
END;


✅ Usage Example:

SELECT dbo.fn_GetTotalRevenueForProduct(1) AS TotalRevenue;

4️⃣ Table-Valued Function – Sales by Category

🧩 Goal: Show all products, total quantity, total revenue for given category.

CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);


✅ Usage Example:

SELECT * FROM dbo.fn_GetSalesByCategory('Electronics');

5️⃣ Function – Check if a Number is Prime

🧩 Goal: Return 'Yes' if number is prime, 'No' otherwise.

CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(10)
AS
BEGIN
    IF @Number < 2 RETURN 'No';

    DECLARE @i INT = 2;

    WHILE @i <= SQRT(@Number)
    BEGIN
        IF @Number % @i = 0 RETURN 'No';
        SET @i = @i + 1;
    END

    RETURN 'Yes';
END;


✅ Usage Example:

SELECT dbo.fn_IsPrime(7);  -- Returns 'Yes'

6️⃣ Table-Valued Function – Numbers Between Two Integers

🧩 Goal: Return a table listing all integers between @Start and @End.

CREATE FUNCTION fn_GetNumbersBetween(@Start INT, @End INT)
RETURNS @Numbers TABLE (Number INT)
AS
BEGIN
    DECLARE @i INT = @Start;

    WHILE @i <= @End
    BEGIN
        INSERT INTO @Numbers VALUES (@i);
        SET @i = @i + 1;
    END

    RETURN;
END;


✅ Usage Example:

SELECT * FROM dbo.fn_GetNumbersBetween(3, 8);

7️⃣ Get Nth Highest Distinct Salary

🧩 Goal: Return Nth highest distinct salary.

CREATE FUNCTION getNthHighestSalary(@N INT)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;

    SELECT @Result = MIN(salary)
    FROM (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        OFFSET (@N - 1) ROWS FETCH NEXT 1 ROWS ONLY
    ) AS Temp;

    RETURN @Result;
END;


✅ Usage Example:

SELECT dbo.getNthHighestSalary(2) AS HighestNSalary;

8️⃣ Find Person with Most Friends

🧩 Goal: Return ID and number of friends.

SELECT TOP 1 id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id FROM RequestAccepted
) AS AllFriends
GROUP BY id
ORDER BY COUNT(*) DESC;


✅ Expected Output:

| id | num |
|----|-----|
| 3  | 3   |

9️⃣ View – Customer Order Summary

🧩 Goal: Return customer order summary with totals and last order date.

CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;


✅ Output:
customer_id | name | total_orders | total_amount | last_order_date

🔟 Fill in Missing Gaps

🧩 Goal: Fill down last known non-null value.

SELECT 
    g.RowNumber,
    FIRST_VALUE(g.TestCase) OVER (
        ORDER BY g.RowNumber
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Workflow
FROM Gaps g;


✅ Expected Output:

RowNumber	Workflow
1	Alpha
2	Alpha
3	Alpha
4	Alpha
5	Bravo
6	Bravo
7	Bravo
8	Bravo
9	Bravo
10	Charlie
11	Charlie
12	Charlie
