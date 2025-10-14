1. Employees jadvalini yaratish:
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

2. INSERT INTO yordamida 3 ta yozuv qo‘shish (turli usullar):
-- 1-row (oddiy usul)
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Ali', 6000.00);

-- 1-row (column names without order)
INSERT INTO Employees
VALUES (2, 'Zarina', 5500.00);

-- Multiple-row insert
INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
    (3, 'Bekzod', 4800.00),
    (4, 'Malika', 7200.00);

3. EmpID = 1 bo'lgan xodimning maoshini 7000 ga o‘zgartiring:
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;

4. EmpID = 2 bo‘lgan xodimni o‘chirish:
DELETE FROM Employees
WHERE EmpID = 2;

5. DELETE, TRUNCATE, DROP farqlari (ta’rif):

DELETE – Ma’lumotlarni o‘chiradi, ammo jadvalning tuzilmasi qoladi. WHERE bilan ishlaydi. Rollback mumkin.

TRUNCATE – Barcha yozuvlarni tezda o‘chiradi. WHERE ishlamaydi. Rollback faqat TRANSACTION blokida.

DROP – Jadvallarni yoki boshqa obyektlarni butunlay o‘chiradi (strukturasi ham ketadi).

6. Name ustunini VARCHAR(100) ga o‘zgartirish:
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

7. Yangi Department ustunini qo‘shish:
ALTER TABLE Employees
ADD Department VARCHAR(50);

8. Salary ustunini FLOAT turiga o‘zgartirish:
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

9. Departments jadvalini yaratish:
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

10. Employees jadvalidan barcha yozuvlarni o‘chirish, lekin strukturani saqlash:
TRUNCATE TABLE Employees;

✅ INTERMEDIATE-LEVEL TASKS (6 ta topshiriq)
1. INSERT INTO SELECT bilan Departments jadvaliga 5 ta yozuv qo‘shish:
-- Avval vaqtincha jadval yaratamiz
CREATE TABLE TempDepartments (
    ID INT,
    Name VARCHAR(50)
);

INSERT INTO TempDepartments VALUES 
(1, 'HR'), (2, 'IT'), (3, 'Finance'), (4, 'Sales'), (5, 'Support');

-- Endi asosiy jadvalga SELECT orqali qo‘shamiz
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT ID, Name FROM TempDepartments;

-- Temp jadvalni o‘chirish:
DROP TABLE TempDepartments;

2. Maoshi 5000 dan katta xodimlarga Management bo‘limini yozish:
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

3. Employees jadvalidan barcha yozuvlarni o‘chirish (strukturani saqlab):
TRUNCATE TABLE Employees;

4. Employees jadvalidan Department ustunini olib tashlash:
ALTER TABLE Employees
DROP COLUMN Department;

5. Employees jadvalini StaffMembers deb o‘zgartirish:
EXEC sp_rename 'Employees', 'StaffMembers';

6. Departments jadvalini butunlay o‘chirish:
DROP TABLE Departments;

✅ ADVANCED-LEVEL TASKS (9 ta topshiriq)
1. Products jadvalini yaratish (kamida 5 ustun bilan):
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    CreatedDate DATE
);

2. CHECK constraint qo‘shish (Price > 0 bo‘lsin):
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);

3. StockQuantity ustunini qo‘shish, default 50:
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

4. Category ustunini ProductCategory deb o‘zgartirish:
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

5. 5 ta yozuv qo‘shish:
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, CreatedDate)
VALUES 
(1, 'Laptop', 'Electronics', 1200.00, '2023-01-01'),
(2, 'Mouse', 'Electronics', 25.50, '2023-02-10'),
(3, 'Desk', 'Furniture', 300.00, '2023-03-15'),
(4, 'Chair', 'Furniture', 150.00, '2023-04-20'),
(5, 'Notebook', 'Stationery', 5.00, '2023-05-01');

6. Products jadvalidan Products_Backup nomli nusxa olish (SELECT INTO):
SELECT * INTO Products_Backup
FROM Products;

7. Products jadvalini Inventory deb nomlash:
EXEC sp_rename 'Products', 'Inventory';

8. Price ustunini FLOAT tipiga o‘zgartirish:
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

9. IDENTITY ustuni qo‘shish (ProductCode, 1000 dan, 5 qadam bilan):

👉 SQL Server’da mavjud jadvalga to‘g‘ridan-to‘g‘ri IDENTITY ustuni qo‘shib bo‘lmaydi. Yechim: yangi jadval yaratib, eski ma’lumotlarni ko‘chirish.

-- 1. Yangi jadval yaratamiz
CREATE TABLE Inventory_New (
    ProductCode INT IDENTITY(1000, 5),
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    ProductCategory VARCHAR(50),
    Price FLOAT,
    CreatedDate DATE,
    StockQuantity INT
);

-- 2. Ma’lumotlarni ko‘chiramiz
INSERT INTO Inventory_New (ProductID, ProductName, ProductCategory, Price, CreatedDate, StockQuantity)
SELECT ProductID, ProductName, ProductCategory, Price, CreatedDate, StockQuantity
FROM Inventory;

-- 3. Eski jadvalni o‘chirib, yangi jadvalni qayta nomlaymiz
DROP TABLE Inventory;
EXEC sp_rename 'Inventory_New', 'Inventory';
