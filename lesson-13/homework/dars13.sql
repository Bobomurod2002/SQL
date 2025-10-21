Easy-level Tasks
1️⃣ 100-Steven King formatida chiqaring

Izoh: emp_id, first_name, last_name ni birlashtiramiz.

SELECT 
    CAST(emp_id AS VARCHAR(10)) + '-' + first_name + ' ' + last_name AS Result
FROM employees;

2️⃣ phone_number ichidagi '124' ni '999' ga almashtirish

Izoh: REPLACE() funksiyasi bilan substring almashtiriladi.

UPDATE employees
SET phone_number = REPLACE(phone_number, '124', '999');

3️⃣ Ismi ‘A’, ‘J’, yoki ‘M’ bilan boshlanuvchilarni va ismi uzunligini chiqaring
SELECT 
    first_name AS FirstName,
    LEN(first_name) AS NameLength
FROM employees
WHERE first_name LIKE 'A%' OR first_name LIKE 'J%' OR first_name LIKE 'M%'
ORDER BY first_name;

4️⃣ Har bir manager_id bo‘yicha umumiy salary
SELECT 
    manager_id,
    SUM(salary) AS TotalSalary
FROM employees
GROUP BY manager_id;

5️⃣ TestMax jadvalida Max1, Max2, Max3 ustunlar ichidan eng kattasini topish
SELECT 
    year,
    GREATEST(Max1, Max2, Max3) AS HighestValue
FROM TestMax;


Agar GREATEST() SQL Server versiyangizda ishlamasa, CASE bilan:

SELECT 
    year,
    CASE 
        WHEN Max1 >= Max2 AND Max1 >= Max3 THEN Max1
        WHEN Max2 >= Max1 AND Max2 >= Max3 THEN Max2
        ELSE Max3
    END AS HighestValue
FROM TestMax;

6️⃣ Toq movie_id va description = “boring” bo‘lmagan filmlar
SELECT *
FROM cinema
WHERE movie_id % 2 = 1
  AND description NOT LIKE '%boring%';

7️⃣ Id=0 satrni oxirida chiqarish (bitta ORDER BY bilan)
SELECT *
FROM SingleOrder
ORDER BY CASE WHEN Id = 0 THEN 1 ELSE 0 END, Id;

8️⃣ Birinchi NULL bo‘lmagan qiymatni tanlash

Izoh: SQL Server’da COALESCE() funksiyasi ishlatiladi.

SELECT 
    COALESCE(col1, col2, col3, col4) AS FirstNonNull
FROM person;

🟡 Medium-level Tasks
1️⃣ FullName ni 3 qismga ajratish (First, Middle, Last)
SELECT 
    PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS FirstName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS MiddleName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS LastName
FROM Students;


Eslatma: bu usul 3 qismli ism (masalan: John Michael Smith) uchun ishlaydi.

2️⃣ Kaliforniyaga buyurtma qilgan mijozlarning Texasga yetkazilgan buyurtmalarini ko‘rsatish
SELECT *
FROM Orders
WHERE customer_id IN (
    SELECT customer_id 
    FROM Orders 
    WHERE delivery_state = 'California'
)
AND delivery_state = 'Texas';

3️⃣ Qiymatlarni group concatenate qilish

(SQL Server’da STRING_AGG() yordamida)

SELECT STRING_AGG(ValueColumn, ', ') AS ConcatenatedValues
FROM DMLTable;

4️⃣ Ism va familiyani birlashtirganda “a” harfi kamida 3 marta bo‘lgan xodimlar
SELECT 
    first_name + ' ' + last_name AS FullName
FROM employees
WHERE LEN(REPLACE(LOWER(first_name + last_name), 'a', '')) <= 
      LEN(first_name + last_name) - 3;

5️⃣ Har bir bo‘limdagi xodimlar soni va 3 yildan ortiq ishlaganlar foizi
SELECT 
    department_id,
    COUNT(*) AS TotalEmployees,
    100.0 * SUM(CASE WHEN DATEDIFF(YEAR, hire_date, GETDATE()) > 3 THEN 1 ELSE 0 END) / COUNT(*) AS PercentOver3Years
FROM employees
GROUP BY department_id;

🔴 Difficult-level Tasks
1️⃣ Har bir satrni o‘zidan oldingi satrlar yig‘indisi bilan almashtirish

Izoh: SUM() OVER(ORDER BY ...) — “running total” usuli.

SELECT 
    student_id,
    SUM(value) OVER (ORDER BY student_id ROWS UNBOUNDED PRECEDING) AS CumulativeSum
FROM Students;

2️⃣ Tug‘ilgan kuni bir xil bo‘lgan talabalarni topish
SELECT s1.student_id, s1.student_name, s1.birth_date
FROM Student s1
JOIN Student s2
  ON s1.birth_date = s2.birth_date
 AND s1.student_id <> s2.student_id
ORDER BY s1.birth_date;

3️⃣ Bir xil o‘yinchilar juftligi uchun umumiy ball
SELECT 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;

4️⃣ 'tf56sd#%OqH' satridan belgilarni turlarga ajratish

SQL Server’da belgilarni TRANSLATE, REPLACE, va PATINDEX bilan ajratish mumkin.
Quyidagi misol bitta qatordagi belgilarni toifalarga bo‘ladi:

WITH T AS (
    SELECT 'tf56sd#%OqH' AS Str
)
SELECT 
    STRING_AGG(value, '') AS LowercaseLetters,
    STRING_AGG(UPPERCASE, '') AS UppercaseLetters,
    STRING_AGG(NUMS, '') AS Numbers,
    STRING_AGG(OTHERS, '') AS Others
FROM (
    SELECT 
        CASE WHEN value LIKE '[a-z]' THEN value END AS LowercaseLetters,
        CASE WHEN value LIKE '[A-Z]' THEN value END AS UppercaseLetters,
        CASE WHEN value LIKE '[0-9]' THEN value END AS Numbers,
        CASE WHEN value LIKE '[^a-zA-Z0-9]' THEN value END AS Others
    FROM STRING_SPLIT('tf56sd#%OqH', '')
) AS X;
