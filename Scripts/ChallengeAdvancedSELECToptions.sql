--Advanced SELECT options. Summarize sales per year by using a Common Table Expression (CTE).
--CTE allows to break the queries we need to write down into sections 
--Create a report showing the total sales per year
WITH cte AS(
SELECT STRFTIME('%Y', soldDate) AS SoldYear,
       salesAmount
FROM sales
)
SELECT SoldYear,
       FORMAT("$%.2f", sum(salesAmount)) AS AnnualSales
FROM cte
GROUP BY soldYear
ORDER BY soldYear;


--Display the amount of sales for each employee by month for 2021. Solution in 3 steps.
--1. start with a query to get the needed data
SELECT emp.firstName,
       emp.lastName,
       DATE(soldDate) AS SoldYear,
       s.salesAmount
FROM sales AS s
INNER JOIN employee AS emp
ON s.employeeId = emp.employeeId
WHERE s.soldDate BETWEEN '2021-01-01' AND '2021-12-31';


--2. implement case statements (select specific data) for each month
SELECT emp.firstName,
       emp.lastName,
       CASE WHEN STRFTIME('%m', soldDate) = '01' THEN salesAmount END AS JanSales,
       CASE WHEN STRFTIME('%m', soldDate) = '02' THEN salesAmount END AS FebSales,
       CASE WHEN STRFTIME('%m', soldDate) = '03' THEN salesAmount END AS MarSales,
       CASE WHEN STRFTIME('%m', soldDate) = '04' THEN salesAmount END AS AprSales,
       CASE WHEN STRFTIME('%m', soldDate) = '05' THEN salesAmount END AS MaySales,
       CASE WHEN STRFTIME('%m', soldDate) = '06' THEN salesAmount END AS JunSales,
       CASE WHEN STRFTIME('%m', soldDate) = '07' THEN salesAmount END AS JulSales,
       CASE WHEN STRFTIME('%m', soldDate) = '08' THEN salesAmount END AS AvgSales,
       CASE WHEN STRFTIME('%m', soldDate) = '09' THEN salesAmount END AS SeptSales,
       CASE WHEN STRFTIME('%m', soldDate) = '10' THEN salesAmount END AS OctSales,
       CASE WHEN STRFTIME('%m', soldDate) = '11' THEN salesAmount END AS NovSales,
       CASE WHEN STRFTIME('%m', soldDate) = '12' THEN salesAmount END AS DecSales
FROM sales AS s
INNER JOIN employee AS emp
ON s.employeeId = emp.employeeId
WHERE s.soldDate BETWEEN '2021-01-01' AND '2021-12-31'
ORDER BY emp.lastName, emp.firstName;


--3. instead of having multiple rows for each employee, group the data by employee name and SUM
SELECT emp.firstName,
       emp.lastName,
       SUM(CASE WHEN STRFTIME('%m', soldDate) = '01' THEN salesAmount END) AS JanSales,
       SUM(CASE WHEN STRFTIME('%m', soldDate) = '02' THEN salesAmount END) AS FebSales,
       SUM(CASE WHEN STRFTIME('%m', soldDate) = '03' THEN salesAmount END) AS MarSales,
       SUM(CASE WHEN STRFTIME('%m', soldDate) = '04' THEN salesAmount END) AS AprSales,
       SUM(CASE WHEN STRFTIME('%m', soldDate) = '05' THEN salesAmount END) AS MaySales,
       SUM(CASE WHEN STRFTIME('%m', soldDate) = '06' THEN salesAmount END) AS JunSales,
       SUM(CASE WHEN STRFTIME('%m', soldDate) = '07' THEN salesAmount END) AS JulSales,
       SUM(CASE WHEN STRFTIME('%m', soldDate) = '08' THEN salesAmount END) AS AvgSales,
       SUM(CASE WHEN STRFTIME('%m', soldDate) = '09' THEN salesAmount END) AS SeptSales,
       SUM(CASE WHEN STRFTIME('%m', soldDate) = '10' THEN salesAmount END) AS OctSales,
       SUM(CASE WHEN STRFTIME('%m', soldDate) = '11' THEN salesAmount END) AS NovSales,
       SUM(CASE WHEN STRFTIME('%m', soldDate) = '12' THEN salesAmount END) AS DecSales
FROM sales AS s
INNER JOIN employee AS emp
ON s.employeeId = emp.employeeId
WHERE s.soldDate BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY emp.firstName, emp.lastName
ORDER BY emp.lastName, emp.firstName;


--Subquery - split complicated SQL into smaller pieces
--Find all sales where the car purchased was electric. Solution with JOIN
SELECT soldDate,
       salesAmount,
       inventory.colour,
       inventory.year
FROM sales
JOIN inventory
ON sales.inventoryId = inventory.inventoryId
INNER JOIN model
ON model.modelId = inventory.modelId
WHERE EngineType = 'Electric';


--Find all sales where the car purchased was electric. Solution with Subquery
SELECT soldDate,
       salesAmount,
       inventory.colour,
       inventory.year
FROM sales
INNER JOIN inventory
ON sales.inventoryId = inventory.inventoryId
WHERE inventory.modelId IN (
 SELECT modelId
 FROM model
 WHERE EngineType = 'Electric'
);
