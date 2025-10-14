1. BULK INSERT nima va nima uchun ishlatiladi?

BULK INSERT – buyrug‘i ma’lumotlarni fayldan (odatda .txt, .csv) jadvalga katta hajmda tezda import qilish uchun ishlatiladi.

2. SQL Server'ga import qilinadigan 4 ta fayl formatlari:

.csv (Comma Separated Values)

.txt (Plain Text)

.xls / .xlsx (Excel files)

.xml (Extensible Markup Language)

3. Products jadvalini yaratish:
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

4. 3 ta yozuv qo‘shish:
INSERT INTO Products (ProductID, ProductName, Price)
VALUES
(1, 'Mouse', 25.50),
(2, 'Keyboard', 45.00),
(3, 'Monitor', 150.00);

5. NULL va NOT NULL farqi:

NULL – qiymat yo‘qligini bildiradi.

NOT NULL – ustunga qiymat majburiy kiritilishi kerakligini bildiradi.

6. ProductName ustuniga UNIQUE constraint qo‘shish:
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

7. Komment yozish (SQL query ichida):
-- Bu so‘rov barcha mahsulotlarni chiqaradi
SELECT * FROM Products;

8. Products jadvaliga CategoryID ustunini qo‘shish:
ALTER TABLE Products
ADD CategoryID INT;

9. Categories jadvalini yaratish (PK va UNIQUE bilan):
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

10. IDENTITY ustunining vazifasi:

IDENTITY ustun SQL Server'da avtomatik raqam berish uchun ishlatiladi. Misol:
ProductID INT IDENTITY(1,1) – bu ProductID 1 dan boshlanadi va har safar 1 ga oshadi.

🟠 MEDIUM-LEVEL TASKS (10 ta topshiriq)
1. BULK INSERT orqali .txt fayldan ma’lumot import qilish:
BULK INSERT Products
FROM 'C:\Data\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);


💡 Fayl yo‘lini va formatini moslashtiring (masalan .csv, agar ustunlar vergul bilan ajratilgan bo‘lsa).

2. Products jadvalida FOREIGN KEY qo‘shish:
ALTER TABLE Products
ADD CONSTRAINT FK_Category
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);

3. PRIMARY KEY va UNIQUE KEY farqi:
PRIMARY KEY	UNIQUE KEY
Bitta ustunga yoki bir nechta ustunga qo‘llanadi	Faqat noyob bo‘lishi uchun
NULL qiymat bo‘lmaydi	Bitta ustunda bitta NULL ruxsat
Jadvalda faqat bitta bo‘ladi	Ko‘p bo‘lishi mumkin
4. Price > 0 bo‘lishi uchun CHECK constraint:
ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

5. Stock (INT, NOT NULL) ustunini qo‘shish:
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

6. ISNULL yordamida NULL qiymatlarni 0 bilan almashtirish:
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;

7. FOREIGN KEY constraint’ning vazifasi:

Foreign Key boshqa jadvaldagi ustun bilan bog‘lanishni ta’minlaydi. U ma’lumotlar yaxlitligini saqlaydi va referensial yaxlitlikni ta’minlaydi.

🔴 HARD-LEVEL TASKS (10 ta topshiriq)
1. Customers jadvalini yaratish (CHECK bilan Age >= 18):
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Age INT CHECK (Age >= 18)
);

2. IDENTITY ustunli jadval (100 dan boshlanib, 10 qadam):
CREATE TABLE CustomIDs (
    ID INT IDENTITY(100, 10) PRIMARY KEY,
    Name VARCHAR(50)
);

3. OrderDetails jadvali uchun KOMPOZIT PRIMARY KEY:
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);

4. COALESCE va ISNULL farqi va misollar:
Funksiya	Ta’rif	Misol
ISNULL()	Faqat 2 qiymat qabul qiladi	ISNULL(Price, 0)
COALESCE()	N ta qiymat qabul qiladi, birinchi NOT NULL ni qaytaradi	COALESCE(Discount, Bonus, 0)
-- Misol:
SELECT COALESCE(NULL, NULL, 10) AS FirstNotNull;
SELECT ISNULL(NULL, 0) AS ReplaceWithZero;

5. Employees jadvali: PRIMARY KEY (EmpID), UNIQUE (Email):
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100) UNIQUE
);

6. FOREIGN KEY yaratish: ON DELETE/UPDATE CASCADE bilan:
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
