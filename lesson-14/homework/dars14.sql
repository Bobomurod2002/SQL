EASY TASKS
1. Split Name by comma into two columns (TestMultipleColumns)

Vazifa: Name ustunidagi qiymat "John,Smith" shaklida bo‘lsa, uni ikkita ustunga — Name va Surname — ajratish.

SELECT 
    LEFT(Name, CHARINDEX(',', Name) - 1) AS Name,
    SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)) AS Surname
FROM TestMultipleColumns;


🧩 Tushuntirish:

CHARINDEX(',', Name) → vergul joylashgan indeksni topadi.

LEFT(... -1) → vergulgacha bo‘lgan qismni oladi.

SUBSTRING(... +1, LEN(Name)) → verguldan keyingi qismni oladi.

2. Find strings containing % character (TestPercent)
SELECT *
FROM TestPercent
WHERE ColumnName LIKE '%[%]%';


🧩 % belgisi wildcard bo‘lgani uchun, uni [] ichiga olish kerak.
'%[%]%' degani – “ichida % belgisi mavjud bo‘lgan” degani.

3. Split string based on dot (Splitter)
SELECT 
    PARSENAME(REPLACE(YourColumn, '.', '.'), 3) AS Part1,
    PARSENAME(REPLACE(YourColumn, '.', '.'), 2) AS Part2,
    PARSENAME(REPLACE(YourColumn, '.', '.'), 1) AS Part3
FROM Splitter;


🧩 PARSENAME() funksiyasi . bilan ajratilgan qiymatlarni oxiridan boshlab tartiblaydi (odatda server.database.schema.table uchun ishlatiladi).

4. Find rows with more than two dots (testDots)
SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;


🧩 Tushuntirish:

LEN(Vals) → uzunlik.

REPLACE(Vals, '.', '') → nuqtalarni olib tashlaydi.

Farq → nechta nuqta borligini ko‘rsatadi.

> 2 → ikki tadan ko‘p bo‘lsa, shu qator chiqadi.

5. Count number of spaces (CountSpaces)
SELECT 
    LEN(ColumnName) - LEN(REPLACE(ColumnName, ' ', '')) AS SpaceCount
FROM CountSpaces;

6. Employees earning more than their managers (Employee)
SELECT 
    e.EmployeeID, e.FirstName, e.LastName, e.Salary, 
    m.FirstName AS ManagerFirstName, m.Salary AS ManagerSalary
FROM Employees e
JOIN Employees m ON e.ManagerID = m.EmployeeID
WHERE e.Salary > m.Salary;

7. Employees working 10–15 years (Employees)
SELECT 
    EmployeeID, FirstName, LastName, HireDate,
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) BETWEEN 10 AND 15;

🟡 MEDIUM TASKS
1. Higher temperature than previous day (weather)
SELECT w1.Id
FROM Weather w1
JOIN Weather w2 ON DATEDIFF(DAY, w2.RecordDate, w1.RecordDate) = 1
WHERE w1.Temperature > w2.Temperature;

2. First login date for each player (Activity)
SELECT 
    PlayerID, 
    MIN(LoginDate) AS FirstLoginDate
FROM Activity
GROUP BY PlayerID;

3. Return the 3rd item from list (fruits)
SELECT 
    value AS ThirdItem
FROM STRING_SPLIT((SELECT FruitsList FROM fruits), ',')
WHERE ordinal = 3; -- SQL Server 2022+


🧩 Agar eski versiya bo‘lsa, CTE bilan:

WITH Split AS (
    SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn, value
    FROM STRING_SPLIT((SELECT FruitsList FROM fruits), ',')
)
SELECT value AS ThirdItem FROM Split WHERE rn = 3;

4. Determine Employment Stage (Employees)
SELECT 
    EmployeeID, FirstName, LastName, HireDate,
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsWorked,
    CASE
        WHEN DATEDIFF(YEAR, HireDate, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, HireDate, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
        WHEN DATEDIFF(YEAR, HireDate, GETDATE()) BETWEEN 5 AND 10 THEN 'Mid-Level'
        WHEN DATEDIFF(YEAR, HireDate, GETDATE()) BETWEEN 10 AND 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS EmploymentStage
FROM Employees;

5. Extract integer value at the start (GetIntegers)
SELECT 
    LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'X') - 1) AS IntegerPart
FROM GetIntegers;


🧩 PATINDEX('%[^0-9]%', Vals + 'X') → birinchi raqam bo‘lmagan belgini topadi.

🔴 DIFFICULT TASKS
1. Swap the first two letters in comma-separated string (MultipleVals)
SELECT 
    STUFF(
        STUFF(Vals, 1, 1, SUBSTRING(Vals, CHARINDEX(',', Vals) + 1, 1)),
        CHARINDEX(',', Vals) + 1, 1, LEFT(Vals, 1)
    ) AS Swapped
FROM MultipleVals;


🧩 STUFF() belgilarni o‘rnini almashtirish uchun ishlatiladi.

2. Convert each character into a row (sdgfhsdgfhs@121313131)
WITH Split AS (
    SELECT 
        SUBSTRING(ColumnName, number, 1) AS CharValue
    FROM master..spt_values
    WHERE type='P' AND number BETWEEN 1 AND LEN(ColumnName)
)
SELECT CharValue FROM Split;

3. First logged device per player (Activity)
SELECT 
    a.PlayerID, a.Device
FROM Activity a
JOIN (
    SELECT PlayerID, MIN(EventDate) AS FirstLogin
    FROM Activity
    GROUP BY PlayerID
) f ON a.PlayerID = f.PlayerID AND a.EventDate = f.FirstLogin;

4. Separate integers and characters into two columns (rtcfvty34redt)
SELECT
    LEFT(Vals, PATINDEX('%[0-9]%', Vals + 'X') - 1) AS Characters,
    SUBSTRING(Vals, PATINDEX('%[0-9]%', Vals + 'X'), LEN(Vals)) AS Integers
FROM rtcfvty34redt;
