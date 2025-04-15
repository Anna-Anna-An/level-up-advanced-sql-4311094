--Windowing functions can be used to partition query results for analysis.
--Get a list of sales people and rank the car models they've sold the most of. Solution in 3 steps.
--JOIN the tables to get the necessary data
SELECT emp.firstName, 
       emp.lastName, 
       s.salesId,
       m.model
FROM sales AS s
INNER JOIN employee AS emp
ON s.employeeId = emp.employeeId
INNER JOIN inventory AS inv
ON s.inventoryId = inv.inventoryId
INNER JOIN model AS m
ON inv.modelId = m.modelId;


--apply the grouping
SELECT emp.firstName, 
       emp.lastName, 
       m.model,
       COUNT(model) AS NumberSold
FROM sales AS s
INNER JOIN employee AS emp
ON s.employeeId = emp.employeeId
INNER JOIN inventory AS inv
ON s.inventoryId = inv.inventoryId
INNER JOIN model AS m
ON inv.modelId = m.modelId
GROUP BY emp.firstName, emp.lastName, m.model;


--add in the windowing function
SELECT emp.firstName, 
       emp.lastName, 
       m.model,
       COUNT(model) AS NumberSold, 
       RANK() OVER (PARTITION BY s.employeeId
              ORDER BY COUNT(model) DESC) AS Rank
FROM sales AS s
INNER JOIN employee AS emp
ON s.employeeId = emp.employeeId
INNER JOIN inventory AS inv
ON s.inventoryId = inv.inventoryId
INNER JOIN model AS m
ON inv.modelId = m.modelId
GROUP BY emp.firstName, emp.lastName, m.model;
