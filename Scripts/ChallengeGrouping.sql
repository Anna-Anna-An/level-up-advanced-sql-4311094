--GROUPING
--How many cars have been sold per employee?
SELECT emp.employeeId, emp.firstName, emp.lastName, COUNT(*) AS NumbOfCarsSold
FROM employee AS emp
INNER JOIN sales AS s
        ON emp.employeeId = s.employeeId
GROUP BY emp.employeeId, emp.firstName, emp.lastName
ORDER BY NumbOfCarsSold DESC;


--Find the least and most expensive car sold by each employee this year
SELECT emp.employeeId,
       emp.firstName, 
       emp.lastName,  
       MIN(s.salesAmount) AS MinSalesAmount, 
       MAX(s.salesAmount) AS MaxSalesAmount,
       DATE(s.soldDate) AS CurrentYear, 
       emp.title
FROM employee AS emp
INNER JOIN sales AS s
ON emp.employeeId = s.employeeId
WHERE title = 'Sales Person'
  AND s.soldDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY emp.employeeId, emp.firstName, emp.lastName;