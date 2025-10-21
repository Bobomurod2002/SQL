1-vazifa: Ikki jadvalni birlashtirish

Vazifa: Person va Address jadvallarini birlashtirib, barcha shaxslar bilan ularning manzillarini (agar mavjud bo‘lsa) chiqaring.
Agar manzili bo‘lmasa → NULL.

SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a
    ON p.personId = a.personId;

2-vazifa: Menejeridan ko‘p maosh olgan xodimlar

Vazifa: Menejeridan ko‘p maosh olgan xodimlarni toping.

SELECT 
    e.name AS Employee
FROM Employee e
JOIN Employee m 
    ON e.managerId = m.id
WHERE e.salary > m.salary;


🟢 Tushuntirish:

O‘zingizga (Employee) va menejer jadvaliga (Employee m) JOIN qilinadi.

Shart: e.salary > m.salary.

3-vazifa: Takroriy email manzillarni topish

Vazifa: Person jadvalidagi bir xil emailni ikki yoki undan ko‘p marta kirgan foydalanuvchilarni aniqlang.

SELECT 
    email AS Email
FROM Person
GROUP BY email
HAVING COUNT(email) > 1;

4-vazifa: Takroriy email manzillarni o‘chirish

Vazifa: Takrorlangan email manzillarni o‘chirib, faqat eng kichik idni saqlang.

DELETE p
FROM Person p
WHERE p.id NOT IN (
    SELECT MIN(id)
    FROM Person
    GROUP BY email
);

5-vazifa: Faqat qiz farzandlari bor ota-onalar

Vazifa: boys jadvalida o‘g‘il bolasi yo‘q, faqat girls jadvalida qiz farzandlari bor ota-onalar.

SELECT DISTINCT g.ParentName
FROM girls g
WHERE g.ParentName NOT IN (
    SELECT DISTINCT b.ParentName
    FROM boys b
);

6-vazifa: 50 dan ortiq og‘irlikdagi buyurtmalar

Vazifa: Sales.Orders jadvalidan har bir mijozning
— og‘irligi 50 dan ortiq bo‘lgan buyurtmalarining jami summasi,
— eng kam og‘irlik qiymatini chiqaring.

SELECT 
    custid,
    SUM(totaldue) AS TotalSalesOver50,
    MIN(weight) AS LeastWeight
FROM Sales.Orders
WHERE weight > 50
GROUP BY custid;

7-vazifa: Carts (Savatchalar)

Vazifa: Cart1 va Cart2dagi mahsulotlarni yonma-yon chiqaring,
ikkisida yo‘q bo‘lganlar NULL bilan ko‘rsatiladi.

SELECT 
    c1.Item AS [Item Cart 1],
    c2.Item AS [Item Cart 2]
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2
    ON c1.Item = c2.Item
ORDER BY 
    ISNULL(c1.Item, c2.Item);

8-vazifa: Hech narsa buyurtma qilmagan mijozlar

Vazifa: Buyurtmasi yo‘q mijozlar (Customers va Orders).

SELECT 
    c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
    ON c.id = o.customerId
WHERE o.customerId IS NULL;

9-vazifa: Talabalar va imtihonlar

Vazifa: Har bir talaba va har bir fan bo‘yicha imtihonda nechta marta qatnashganini chiqaring.

SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
    ON s.student_id = e.student_id 
    AND sub.subject_name = e.subject_name
GROUP BY 
    s.student_id, s.student_name, sub.subject_name
ORDER BY 
    s.student_id, sub.subject_name;
