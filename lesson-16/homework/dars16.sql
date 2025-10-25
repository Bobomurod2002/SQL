EASY TASKS
1️⃣ Create a numbers table using a recursive query from 1 to 1000
WITH Numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1
    FROM Numbers
    WHERE num < 1000
)
SELECT num
FROM Numbers
OPTION (MAXRECURSION 1000);

2️⃣ Total sales per employee (using derived table)

Tables: Sales(employee_id, amount), Employees(id, name)

SELECT e.name, s.total_sales
FROM Employees e
JOIN (
    SELECT employee_id, SUM(amount) AS total_sales
    FROM Sales
    GROUP BY employee_id
) s ON e.id = s.employee_id;

3️⃣ CTE to find the average salary of employees
WITH AvgSalary AS (
    SELECT AVG(salary) AS avg_salary
    FROM Employees
)
SELECT avg_salary FROM AvgSalary;

4️⃣ Derived table to find the highest sales for each product

Tables: Sales(product_id, amount), Products(id, product_name)

SELECT p.product_name, s.max_sale
FROM Products p
JOIN (
    SELECT product_id, MAX(amount) AS max_sale
    FROM Sales
    GROUP BY product_id
) s ON p.id = s.product_id;

5️⃣ Double number each record until < 1,000,000
WITH Doubles AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num * 2
    FROM Doubles
    WHERE num * 2 < 1000000
)
SELECT num
FROM Doubles
OPTION (MAXRECURSION 1000);

6️⃣ CTE to get employees who made more than 5 sales

Tables: Sales(employee_id), Employees(id, name)

WITH SalesCount AS (
    SELECT employee_id, COUNT(*) AS total_sales
    FROM Sales
    GROUP BY employee_id
)
SELECT e.name
FROM Employees e
JOIN SalesCount s ON e.id = s.employee_id
WHERE s.total_sales > 5;

7️⃣ CTE: Products with total sales > $500

Tables: Sales(product_id, amount), Products(id, product_name)

WITH ProductSales AS (
    SELECT product_id, SUM(amount) AS total_sales
    FROM Sales
    GROUP BY product_id
)
SELECT p.product_name, ps.total_sales
FROM Products p
JOIN ProductSales ps ON p.id = ps.product_id
WHERE ps.total_sales > 500;

8️⃣ CTE: Employees with salary above average
WITH AvgSalary AS (
    SELECT AVG(salary) AS avg_salary FROM Employees
)
SELECT *
FROM Employees
WHERE salary > (SELECT avg_salary FROM AvgSalary);

🟧 MEDIUM TASKS
9️⃣ Derived table: Top 5 employees by number of orders

Tables: Employees(id, name), Sales(employee_id)

SELECT TOP 5 e.name, s.order_count
FROM Employees e
JOIN (
    SELECT employee_id, COUNT(*) AS order_count
    FROM Sales
    GROUP BY employee_id
) s ON e.id = s.employee_id
ORDER BY s.order_count DESC;

🔟 Derived table: Sales per product category

Tables: Sales(product_id, amount), Products(id, product_name, category_id)

SELECT p.category_id, SUM(s.amount) AS total_sales
FROM (
    SELECT product_id, SUM(amount) AS amount
    FROM Sales
    GROUP BY product_id
) s
JOIN Products p ON s.product_id = p.id
GROUP BY p.category_id;

11️⃣ Recursive CTE: Factorial for each number (Numbers1 table)

Assume: Numbers1(num) exists.

WITH Factorial AS (
    SELECT num, CAST(num AS BIGINT) AS factorial
    FROM Numbers1
    WHERE num = 1
    UNION ALL
    SELECT n.num, f.factorial * n.num
    FROM Numbers1 n
    JOIN Factorial f ON n.num = f.num + 1
)
SELECT * FROM Factorial
OPTION (MAXRECURSION 1000);

12️⃣ Recursive CTE: Split a string into characters

Example: 'HELLO'

DECLARE @str VARCHAR(100) = 'HELLO';

WITH Split AS (
    SELECT 1 AS position, SUBSTRING(@str, 1, 1) AS character
    UNION ALL
    SELECT position + 1, SUBSTRING(@str, position + 1, 1)
    FROM Split
    WHERE position < LEN(@str)
)
SELECT position, character
FROM Split
OPTION (MAXRECURSION 1000);

13️⃣ CTE: Sales difference current month vs previous

Assume: Sales(sale_date, amount)

WITH MonthlySales AS (
    SELECT 
        YEAR(sale_date) AS yr,
        MONTH(sale_date) AS mn,
        SUM(amount) AS total_sales
    FROM Sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
),
SalesDiff AS (
    SELECT 
        m1.yr,
        m1.mn,
        m1.total_sales - ISNULL(m2.total_sales, 0) AS diff_from_prev
    FROM MonthlySales m1
    LEFT JOIN MonthlySales m2
        ON m1.yr = m2.yr AND m1.mn = m2.mn + 1
)
SELECT * FROM SalesDiff;

14️⃣ Derived table: Employees with quarterly sales > 45000

Assume: Sales(employee_id, amount, sale_date), Employees(id, name)

SELECT e.name, q.quarter_total, q.quarter
FROM Employees e
JOIN (
    SELECT 
        employee_id,
        DATEPART(QUARTER, sale_date) AS quarter,
        SUM(amount) AS quarter_total
    FROM Sales
    GROUP BY employee_id, DATEPART(QUARTER, sale_date)
) q ON e.id = q.employee_id
WHERE q.quarter_total > 45000;
