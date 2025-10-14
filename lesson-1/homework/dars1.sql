✅ EASY – Oson
1. Quyidagi atamalarga ta'rif bering:

Data (Ma’lumotlar) – Tahlil qilinishi mumkin bo‘lgan xom ma’lumotlar. Masalan, ism, yosh, ID raqam.

Database (Ma’lumotlar bazasi) – Ma’lumotlarni tartibli va xavfsiz saqlash, izlash va boshqarish uchun yaratilgan tizim.

Relational Database (Aloqaviy ma’lumotlar bazasi) – Ma’lumotlarni jadvallar orqali saqlaydigan va ular orasida munosabat o‘rnatishga imkon beruvchi bazadir.

Table (Jadval) – Ma’lumotlar satr (row) va ustunlar (column) ko‘rinishida saqlanadigan tuzilma.

2. SQL Server'ning 5 ta muhim xususiyati:

Ma’lumotlarni saqlash va tez izlash imkoniyati.

Yadro darajasida xavfsizlik (loginlar, ruxsatlar).

Saqlangan protsedura, trigger va funksiyalarni qo‘llab-quvvatlaydi.

Zaxira (backup) va tiklash (restore) funksiyasi mavjud.

Katta hajmdagi ma’lumotlar bilan ishlashga mos keladi (scalability).

3. SQL Server'da mavjud 2 ta autentifikatsiya (authentication) rejimi:

Windows Authentication – Windows foydalanuvchi hisobidan foydalanadi.

SQL Server Authentication – SQL Server uchun maxsus login va parol bilan tizimga kiriladi.

✅ MEDIUM – O‘rta
4. SSMS’da SchoolDB nomli yangi ma’lumotlar bazasini yaratish:
CREATE DATABASE SchoolDB;


Yoki SSMS GUI orqali:

SSMS ni oching

Databases ustiga o‘ng tugma → New Database... → nom kiriting: SchoolDB → OK

5. Students jadvalini yaratish:
USE SchoolDB;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

6. SQL Server, SSMS va SQL o‘rtasidagi farqlar:
Nomi	Ta'rifi
SQL Server	Ma’lumotlar bazasini boshqarish tizimi (DBMS) – ma’lumotlarni saqlash va boshqarish uchun ishlatiladi.
SSMS	SQL Server Management Studio – SQL Server’ni boshqarish uchun GUI interfeys.
SQL	Structured Query Language – ma’lumotlar bazasi bilan ishlash uchun til (so‘rovlar yozish).
✅ HARD – Qiyin
7. SQL komandalarini tushuntiring (DQL, DML, DDL, DCL, TCL):
Kategoriya	To‘liq nomi	Vazifasi	Misol
DQL	Data Query Language	Ma’lumotni olish	SELECT * FROM Students;
DML	Data Manipulation Language	Ma’lumotni o‘zgartirish	INSERT, UPDATE, DELETE
DDL	Data Definition Language	Tuzilma yaratish/o‘zgartirish	CREATE TABLE, ALTER, DROP
DCL	Data Control Language	Ruxsatlarni boshqarish	GRANT, REVOKE
TCL	Transaction Control Language	Transaktsiyalarni boshqarish	BEGIN, COMMIT, ROLLBACK
8. Students jadvaliga 3 ta yozuv qo‘shing:
INSERT INTO Students (StudentID, Name, Age)
VALUES (1, 'Ali', 20),
       (2, 'Zarina', 22),
       (3, 'Bekzod', 19);

9. AdventureWorksDW2022.bak faylini tiklash (restore) qilish bosqichlari:

🔗 Yuklab olish manzili:
https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak

🛠️ SSMS orqali tiklash bosqichlari:

.bak faylni yuqoridagi linkdan yuklab oling.

Uni quyidagi papkaga joylashtiring (odatda):
C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup

SSMS'ni oching va serverga ulaning.

Databases ustiga o‘ng tugma → Restore Database...

Source → Device tanlang → ... tugmasini bosing → Add → .bak faylni tanlang.

Faylni tanlab OK bosing.

Restore opsiyalarini tekshiring (file nomi to‘g‘ri bo‘lishi kerak).

OK tugmasini bosing – restore jarayoni boshlanadi.
