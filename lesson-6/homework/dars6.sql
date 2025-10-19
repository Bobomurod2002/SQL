🧩 Puzzle 1: Ikki ustun bo‘yicha takrorlarni olib tashlash
🎯 Maqsad:

(a,b) va (b,a) bir xil deb qaraladi. Natijada har bir juftlikdan faqat bittasi chiqsin.

✅ Yechim 1 (CASE bilan tartiblab DISTINCT olish):
SELECT DISTINCT 
       CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
       CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;

✅ Yechim 2 (UNION bilan):
SELECT DISTINCT col1, col2 FROM InputTbl
WHERE col1 < col2
UNION
SELECT DISTINCT col2, col1 FROM InputTbl
WHERE col2 < col1;

🧩 Puzzle 2: Barcha qiymatlari 0 bo‘lgan qatorni ko‘rsatmaslik
🎯 Maqsad:

(0,0,0,0) qatordan tashqari hammasi chiqsin.

✅ Yechim:
SELECT *
FROM TestMultipleZero
WHERE COALESCE(A,0) + COALESCE(B,0) + COALESCE(C,0) + COALESCE(D,0) <> 0;

🧩 Puzzle 3: ID raqami toq bo‘lganlarni topish
✅ Yechim:
SELECT * 
FROM section1
WHERE id % 2 = 1;

🧩 Puzzle 4: Eng kichik ID ga ega shaxs
✅ Yechim:
SELECT TOP 1 *
FROM section1
ORDER BY id ASC;


Yoki qisqaroq:

SELECT * FROM section1 WHERE id = (SELECT MIN(id) FROM section1);

🧩 Puzzle 5: Eng katta ID ga ega shaxs
✅ Yechim:
SELECT TOP 1 *
FROM section1
ORDER BY id DESC;

🧩 Puzzle 6: Ismi “b” bilan boshlanadiganlar
✅ Yechim:
SELECT *
FROM section1
WHERE name LIKE 'b%';

🧩 Puzzle 7: Underscore _ belgisi mavjud kodlar
🎯 Maqsad:

_ belgisi literal sifatida bo‘lsin, wildcard emas.
Buning uchun ESCAPE belgisi ishlatiladi (\ belgisi yordamida).

✅ Yechim:
SELECT *
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';
