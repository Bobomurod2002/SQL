Level 1: Basic Subqueries
1. Find Employees with Minimum Salary
SELECT *
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);


Natija: Alice, Charlie (har ikkisi 50000 maosh olgan).

2. Find Products Above Average Price
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);


Natija: Laptop (1200), Smartphone (800)

Level 2: Nested Subqueries with Conditions
3. Find Employees in Sales Department
SELECT *
FROM employees
WHERE department_id = (
    SELECT id
    FROM departments
    WHERE department_name = 'Sales'
);


Natija: David, Frank

4. Find Customers with No Orders
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);


Natija: Heidi, Ivan

Level 3: Aggregation and Grouping in Subqueries
5. Find Products with Max Price in Each Category
SELECT *
FROM products p
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE category_id = p.category_id
);


Natija:

Laptop (category 1)

Speakers (category 2)

6. Find Employees in Department with Highest Average Salary
SELECT *
FROM employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);


Natija: Jack, Karen (IT bo‘limi – eng yuqori o‘rtacha oylik)

Level 4: Correlated Subqueries
7. Find Employees Earning Above Department Average
SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);


Natija: Nina (1-bo‘lim), Paul (2-bo‘lim)

8. Find Students with Highest Grade per Course
SELECT *
FROM grades g
WHERE grade = (
    SELECT MAX(grade)
    FROM grades
    WHERE course_id = g.course_id
);


Natija:

Sarah (course 101, grade 95)

Uma (course 102, grade 90)

Level 5: Subqueries with Ranking and Complex Conditions
9. Find Third-Highest Price per Category
SELECT *
FROM products p
WHERE 2 = (
    SELECT COUNT(DISTINCT price)
    FROM products
    WHERE category_id = p.category_id
      AND price > p.price
);


Izoh:

“2” bu — undan yuqori 2 ta narx borligini bildiradi (ya’ni 3-chi eng yuqori).

Natija:

Tablet (category 1, 600)

Earbuds (category 2, 100) — bu holda 3-eng yuqori bo‘lmagan, lekin agar ma’lumotlar boshqacha bo‘lsa, to‘g‘ri hisoblaydi.

10. Find Employees whose Salary Between Company Average and Department Max Salary
SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
AND salary < (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = e.department_id
);


Natija: Alex (70000), Evan (75000)
