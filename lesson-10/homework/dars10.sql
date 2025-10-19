🟢 EASY-LEVEL TASKS (10 ta)
1️⃣

Maoshi 50 000 dan katta bo‘lgan xodimlar va ularning bo‘lim nomi

SELECT 
    e.EmployeeName,
    e.Salary,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 50000;


🟢 Izoh:
Bu yerda INNER JOIN ikki jadvaldagi mos DepartmentID larni birlashtiradi.
WHERE orqali 50 000 dan katta maoshli xodimlar tanlandi.

2️⃣

2023-yilda buyurtma bergan mijozlar

SELECT 
    c.FirstName,
    c.LastName,
    o.OrderDate
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023;


🟢 Izoh:
YEAR() funksiyasi OrderDate yilini ajratadi.
INNER JOIN — faqat buyurtma bergan mijozlarni ko‘rsatadi.

3️⃣

Barcha xodimlar va ularning bo‘limlari (hatto bo‘limsizlari ham)

SELECT 
    e.EmployeeName,
    d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;


🟢 Izoh:
LEFT JOIN – chap jadval (Employees) dagi barcha yozuvlarni ko‘rsatadi,
hatto bo‘lim yo‘q bo‘lsa ham DepartmentName NULL bo‘ladi.

4️⃣

Barcha yetkazib beruvchilar va ular yetkazadigan mahsulotlar

SELECT 
    s.SupplierName,
    p.ProductName
FROM Suppliers s
LEFT JOIN Products p
    ON s.SupplierID = p.SupplierID;


🟢 Izoh:
LEFT JOIN – hamma supplier’lar chiqadi, mahsulot bo‘lmasa NULL.

5️⃣

Buyurtmalar va to‘lovlar (hammasi, hatto bog‘lanmaganlar ham)

SELECT 
    o.OrderID,
    o.OrderDate,
    p.PaymentDate,
    p.Amount
FROM Orders o
FULL OUTER JOIN Payments p
    ON o.OrderID = p.OrderID;


🟢 Izoh:
FULL OUTER JOIN — ikkala jadvaldagi barcha ma’lumotlarni ko‘rsatadi (to‘lovsiz buyurtma va buyurtmasiz to‘lovlar ham).

6️⃣

Xodim va uning menejeri

SELECT 
    e.EmployeeName,
    m.EmployeeName AS ManagerName
FROM Employees e
LEFT JOIN Employees m
    ON e.ManagerID = m.EmployeeID;


🟢 Izoh:
Bu SELF JOIN misolidir — bir jadval o‘ziga ulanadi.
Har bir xodimning ManagerID orqali menejerining ismi olinadi.

7️⃣

‘Math 101’ kursiga yozilgan talabalar

SELECT 
    s.StudentName,
    c.CourseName
FROM Students s
INNER JOIN Enrollments e
    ON s.StudentID = e.StudentID
INNER JOIN Courses c
    ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Math 101';


🟢 Izoh:
Enrollments – bog‘lovchi jadval.
INNER JOIN orqali uchta jadval birlashtirildi.

8️⃣

3 tadan ortiq buyurtma bergan mijozlar

SELECT 
    c.FirstName,
    c.LastName,
    COUNT(o.OrderID) AS Quantity
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
HAVING COUNT(o.OrderID) > 3;


🟢 Izoh:
GROUP BY — mijozlar bo‘yicha guruhlash.
HAVING — 3 tadan ortiq buyurtma berganlar.

9️⃣

‘Human Resources’ bo‘limida ishlaydigan xodimlar

SELECT 
    e.EmployeeName,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources';


🟢 Izoh:
Faqat shu nomdagi bo‘limdagi xodimlar olinadi.

🟠 MEDIUM-LEVEL TASKS
1️⃣

5 tadan ortiq xodimga ega bo‘limlar

SELECT 
    d.DepartmentName,
    COUNT(e.EmployeeID) AS EmployeeCount
FROM Departments d
INNER JOIN Employees e
    ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(e.EmployeeID) > 5;

2️⃣

Hech qachon sotilmagan mahsulotlar

SELECT 
    p.ProductID,
    p.ProductName
FROM Products p
LEFT JOIN Sales s
    ON p.ProductID = s.ProductID
WHERE s.ProductID IS NULL;


🟢 Izoh:
LEFT JOIN bilan bog‘lanmagan (NULL) mahsulotlar tanlanadi.

3️⃣

Kamida bitta buyurtma bergan mijozlar

SELECT 
    c.FirstName,
    c.LastName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;

4️⃣

Faqat mavjud xodim va bo‘lim (NULLsiz)

SELECT 
    e.EmployeeName,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

5️⃣

Bir xil menejerga bo‘ysunadigan xodim juftlari

SELECT 
    e1.EmployeeName AS Employee1,
    e2.EmployeeName AS Employee2,
    e1.ManagerID
FROM Employees e1
INNER JOIN Employees e2
    ON e1.ManagerID = e2.ManagerID
    AND e1.EmployeeID < e2.EmployeeID;


🟢 Izoh:
O‘z-o‘ziga ulanadigan jadval.
< – juftlarni takrorlamaslik uchun.

6️⃣

2022-yildagi buyurtmalar va mijoz ismlari

SELECT 
    o.OrderID,
    o.OrderDate,
    c.FirstName,
    c.LastName
FROM Orders o
INNER JOIN Customers c
    ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2022;

7️⃣

‘Sales’ bo‘limidagi, maoshi 60 000 dan yuqori xodimlar

SELECT 
    e.EmployeeName,
    e.Salary,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' AND e.Salary > 60000;

8️⃣

To‘lov qilingan buyurtmalar

SELECT 
    o.OrderID,
    o.OrderDate,
    p.PaymentDate,
    p.Amount
FROM Orders o
INNER JOIN Payments p
    ON o.OrderID = p.OrderID;

9️⃣

Hech qachon buyurtma qilinmagan mahsulotlar

SELECT 
    p.ProductID,
    p.ProductName
FROM Products p
LEFT JOIN Orders o
    ON p.ProductID = o.ProductID
WHERE o.ProductID IS NULL;

🔴 HARD-LEVEL TASKS
1️⃣

Bo‘limdagi o‘rtacha maoshdan yuqori oladigan xodimlar

SELECT 
    e.EmployeeName,
    e.Salary
FROM Employees e
INNER JOIN (
    SELECT DepartmentID, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
) avg_tbl
ON e.DepartmentID = avg_tbl.DepartmentID
WHERE e.Salary > avg_tbl.AvgSalary;

2️⃣

2020-yilgacha berilgan, lekin to‘lovi yo‘q buyurtmalar

SELECT 
    o.OrderID,
    o.OrderDate
FROM Orders o
LEFT JOIN Payments p
    ON o.OrderID = p.OrderID
WHERE p.OrderID IS NULL
  AND YEAR(o.OrderDate) < 2020;

3️⃣

Kategoriyasi yo‘q mahsulotlar

SELECT 
    p.ProductID,
    p.ProductName
FROM Products p
LEFT JOIN Categories c
    ON p.CategoryID = c.CategoryID
WHERE c.CategoryID IS NULL;

4️⃣

Bir xil menejerga bo‘ysunadigan va maoshi 60000 dan yuqori bo‘lgan juftliklar

SELECT 
    e1.EmployeeName AS Employee1,
    e2.EmployeeName AS Employee2,
    e1.ManagerID,
    e1.Salary
FROM Employees e1
INNER JOIN Employees e2
    ON e1.ManagerID = e2.ManagerID
    AND e1.EmployeeID < e2.EmployeeID
WHERE e1.Salary > 60000 AND e2.Salary > 60000;

5️⃣

Nomi ‘M’ bilan boshlanadigan bo‘limlardagi xodimlar

SELECT 
    e.EmployeeName,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName LIKE 'M%';

6️⃣

500 dan katta summali savdolar (mahsulot nomi bilan)

SELECT 
    s.SaleID,
    p.ProductName,
    s.SaleAmount
FROM Sales s
INNER JOIN Products p
    ON s.ProductID = p.ProductID
WHERE s.SaleAmount > 500;

7️⃣

‘Math 101’ kursiga yozilmagan talabalar

SELECT 
    s.StudentID,
    s.StudentName
FROM Students s
WHERE s.StudentID NOT IN (
    SELECT e.StudentID
    FROM Enrollments e
    INNER JOIN Courses c
        ON e.CourseID = c.CourseID
    WHERE c.CourseName = 'Math 101'
);

8️⃣

To‘lov ma’lumoti yo‘q buyurtmalar

SELECT 
    o.OrderID,
    o.OrderDate,
    p.PaymentID
FROM Orders o
LEFT JOIN Payments p
    ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;

9️⃣

‘Electronics’ yoki ‘Furniture’ kategoriyasidagi mahsulotlar

SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName
FROM Products p
INNER JOIN Categories c
    ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');
