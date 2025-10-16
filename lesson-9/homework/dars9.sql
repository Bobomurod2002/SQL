🟢 EASY LEVEL (10 ta)
1. Products × Suppliers — barcha kombinatsiyalar
SELECT P.ProductName, S.SupplierName
FROM Products P
CROSS JOIN Suppliers S;

2. Departments × Employees — barcha kombinatsiyalar
SELECT D.DepartmentName, E.Name AS EmployeeName
FROM Departments D
CROSS JOIN Employees E;

3. Products va Suppliers — faqat haqiqatan ta’minlaydiganlar
SELECT S.SupplierName, P.ProductName
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID;

4. Orders va Customers — mijoz nomi va buyurtma ID
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID;

5. Courses × Students — barcha kombinatsiyalar
SELECT S.Name AS StudentName, C.CourseName
FROM Students S
CROSS JOIN Courses C;

6. Products va Orders — ProductID bo‘yicha mos
SELECT P.ProductName, O.OrderID
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID;

7. Departments va Employees — DepartmentID mos
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

8. Students va Enrollments — student nomi va kurs ID
SELECT S.Name AS StudentName, E.CourseID
FROM Students S
INNER JOIN Enrollments E ON S.StudentID = E.StudentID;

9. Payments va Orders — mos keluvchi to‘lovlar
SELECT O.OrderID, P.PaymentID, P.Amount
FROM Orders O
INNER JOIN Payments P ON O.OrderID = P.OrderID;

10. Orders va Products — narxi 100 dan yuqori bo‘lgan
SELECT O.OrderID, P.ProductName, P.Price
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID
WHERE P.Price > 100;

🟡 MEDIUM LEVEL (10 ta)
1. Employee va Department — ID’lar teng emas (mismatched)
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID <> D.DepartmentID;

2. Orders va Products — Quantity > StockQuantity
SELECT O.OrderID, P.ProductName, O.Quantity, P.StockQuantity
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID
WHERE O.Quantity > P.StockQuantity;

3. Customers va Sales — (bizda Sales jadvali yo‘q, Orders orqali o‘rinbosar qilamiz)
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, O.ProductID
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.TotalAmount >= 500;

4. Courses, Enrollments, Students — ishtirok etayotganlar
SELECT S.Name AS StudentName, C.CourseName
FROM Enrollments E
INNER JOIN Students S ON E.StudentID = S.StudentID
INNER JOIN Courses C ON E.CourseID = C.CourseID;

5. Products, Suppliers — nomida “Tech” bor
SELECT P.ProductName, S.SupplierName
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE S.SupplierName LIKE '%Tech%';

6. Orders, Payments — to‘lov < umumiy summa
SELECT O.OrderID, O.TotalAmount, P.Amount
FROM Orders O
INNER JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.Amount < O.TotalAmount;

7. Employees va Departments — har xodimning bo‘lim nomi
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

8. Products, Categories — Electronics yoki Furniture
SELECT P.ProductName, C.CategoryName
FROM Products P
INNER JOIN Categories C ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics', 'Furniture');

9. Sales, Customers — (Orders orqali, mamlakat USA)
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID, O.TotalAmount
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.Country = 'USA';

10. Orders, Customers — Germaniyadan va summasi > 100
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID, O.TotalAmount
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.Country = 'Germany' AND O.TotalAmount > 100;

🔴 HARD LEVEL (5 ta)
1. Employees — har xil bo‘limdagi juftliklar
SELECT E1.Name AS Employee1, E2.Name AS Employee2
FROM Employees E1
INNER JOIN Employees E2 
    ON E1.EmployeeID <> E2.EmployeeID
   AND E1.DepartmentID <> E2.DepartmentID;

2. Payments, Orders, Products — noto‘g‘ri (Amount ≠ Quantity×Price)
SELECT P.PaymentID, P.Amount, O.Quantity, PR.Price,
       (O.Quantity * PR.Price) AS ExpectedTotal
FROM Payments P
INNER JOIN Orders O ON P.OrderID = O.OrderID
INNER JOIN Products PR ON O.ProductID = PR.ProductID
WHERE P.Amount <> (O.Quantity * PR.Price);

3. Students — hech bir kursga yozilmagan
SELECT S.Name
FROM Students S
LEFT JOIN Enrollments E ON S.StudentID = E.StudentID
WHERE E.StudentID IS NULL;


(LEFT JOIN bo‘ldi, lekin bu yagona yo‘l — INNER JOIN bilan bu topilmaydi)

4. Employees — menejer bo‘lgan, lekin o‘zidan kam oladigan
SELECT M.Name AS ManagerName, E.Name AS EmployeeName, 
       M.Salary AS ManagerSalary, E.Salary AS EmployeeSalary
FROM Employees E
INNER JOIN Employees M ON E.ManagerID = M.EmployeeID
WHERE M.Salary <= E.Salary;

5. Orders, Payments, Customers — to‘lovsiz buyurtma qilgan mijozlar
SELECT DISTINCT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.OrderID IS NULL;

