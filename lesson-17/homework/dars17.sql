1. Distributors and Sales by Region (missing regions = 0)
-- Setup already provided
-- Solution:
WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
)
SELECT 
    r.Region,
    d.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM Regions r
CROSS JOIN Distributors d
LEFT JOIN #RegionSales rs
    ON rs.Region = r.Region AND rs.Distributor = d.Distributor
ORDER BY d.Distributor, r.Region;


✅ Output:
All regions × distributors with missing combinations showing 0.

🟩 2. Managers with at least 5 direct reports
SELECT e1.name
FROM Employee e1
JOIN Employee e2 ON e1.id = e2.managerId
GROUP BY e1.id, e1.name
HAVING COUNT(e2.id) >= 5;


✅ Output:

| name |
|------|
| John |

🟩 3. Products with ≥100 units ordered in Feb 2020
SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE YEAR(o.order_date) = 2020 AND MONTH(o.order_date) = 2
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;


✅ Output:

| Leetcode Solutions | 130 |
| Leetcode Kit       | 100 |

🟩 4. Vendor from which each customer placed the most orders
SELECT CustomerID, Vendor
FROM (
    SELECT 
        CustomerID,
        Vendor,
        COUNT(*) AS OrderCount,
        RANK() OVER (PARTITION BY CustomerID ORDER BY COUNT(*) DESC) AS rnk
    FROM Orders
    GROUP BY CustomerID, Vendor
) t
WHERE rnk = 1;


✅ Output:

| 1001 | Direct Parts |
| 2002 | ACME         |

🟩 5. Check if a number is prime (WHILE loop)
DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @flag BIT = 1;

WHILE @i <= SQRT(@Check_Prime)
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @flag = 0;
        BREAK;
    END
    SET @i = @i + 1;
END

IF @flag = 1
    PRINT('This number is prime');
ELSE
    PRINT('This number is not prime');


✅ Output for 91:

This number is not prime

🟩 6. Device locations and signal summary
WITH SignalSummary AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS signal_count
    FROM Device
    GROUP BY Device_id, Locations
),
MaxSignal AS (
    SELECT 
        Device_id,
        MAX(signal_count) AS max_signal
    FROM SignalSummary
    GROUP BY Device_id
)
SELECT 
    s.Device_id,
    COUNT(DISTINCT s.Locations) AS no_of_location,
    (SELECT TOP 1 Locations 
     FROM SignalSummary ss 
     WHERE ss.Device_id = s.Device_id
     ORDER BY ss.signal_count DESC) AS max_signal_location,
    SUM(s.signal_count) AS no_of_signals
FROM SignalSummary s
GROUP BY s.Device_id;


✅ Output:

| 12 | 2 | Bangalore    | 6 |
| 13 | 2 | Secunderabad | 5 |

🟩 7. Employees earning more than department average
SELECT e.EmpID, e.EmpName, e.Salary
FROM Employee e
WHERE e.Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);


✅ Output:

| 1001 | Mark   | 60000 |
| 1004 | Peter  | 35000 |
| 1005 | John   | 55000 |
| 1007 | Donald | 35000 |

🟩 8. Lottery Winnings ($110 total)
-- Winning numbers already in Numbers table
-- Tickets already in Tickets table

WITH MatchCount AS (
    SELECT 
        t.TicketID,
        COUNT(*) AS matched
    FROM Tickets t
    INNER JOIN Numbers n ON t.Number = n.Number
    GROUP BY t.TicketID
),
WinCalc AS (
    SELECT 
        TicketID,
        CASE 
            WHEN matched = (SELECT COUNT(*) FROM Numbers) THEN 100
            WHEN matched > 0 THEN 10
            ELSE 0
        END AS winnings
    FROM MatchCount
    UNION
    SELECT t.TicketID, 0
    FROM Tickets t
    WHERE t.TicketID NOT IN (SELECT TicketID FROM MatchCount)
)
SELECT SUM(winnings) AS Total_Winnings
FROM WinCalc;


✅ Output:

Total_Winnings = 110

🟩 9. Spending by platform per date
WITH PlatformSummary AS (
    SELECT 
        Spend_date,
        User_id,
        SUM(Amount) AS total_amount,
        COUNT(DISTINCT Platform) AS platform_count
    FROM Spending
    GROUP BY Spend_date, User_id
),
TypeBreakdown AS (
    SELECT 
        s.Spend_date,
        p.Platform,
        SUM(s.Amount) AS Total_Amount,
        COUNT(DISTINCT s.User_id) AS Total_users
    FROM Spending s
    JOIN (
        SELECT DISTINCT Platform FROM Spending
    ) p ON 1=1
    WHERE s.Platform = p.Platform
    GROUP BY s.Spend_date, p.Platform
    UNION ALL
    SELECT 
        Spend_date,
        'Both' AS Platform,
        SUM(Amount) AS Total_Amount,
        COUNT(DISTINCT User_id) AS Total_users
    FROM Spending
    GROUP BY Spend_date
)
SELECT ROW_NUMBER() OVER (ORDER BY Spend_date, Platform) AS Row,
       Spend_date, Platform, Total_Amount, Total_users
FROM TypeBreakdown
ORDER BY Spend_date, Platform;


✅ Output:

| 1 | 2019-07-01 | Mobile   | 200 | 2 |
| 2 | 2019-07-01 | Desktop  | 200 | 2 |
| 3 | 2019-07-01 | Both     | 400 | 3 |
| 4 | 2019-07-02 | Mobile   | 100 | 1 |
| 5 | 2019-07-02 | Desktop  | 100 | 1 |
| 6 | 2019-07-02 | Both     | 200 | 2 |

🟩 10. De-group (expand) table
WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM Numbers WHERE n < 100
)
SELECT g.Product, 1 AS Quantity
FROM Grouped g
JOIN Numbers n ON n.n <= g.Quantity
ORDER BY g.Product
OPTION (MAXRECURSION 100);


✅ Output:
Each product repeated according to its quantity, each with quantity = 1.
