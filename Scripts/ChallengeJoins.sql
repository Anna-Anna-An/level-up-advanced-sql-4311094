-- Create a list of employees and their immediate managers.

SELECT emp.firstName, 
       emp.lastName, 
       emp.title, 
       mng.firstName AS ManagerFirstName, 
       mng.lastName AS ManagerLastName
FROM employee AS emp
INNER JOIN employee AS mng
        ON emp.managerID = mng.employeeID;


--Get a list of salespeople with zero sales
SELECT emp.firstName, emp.lastName, emp.title, emp.startDate, s.salesAmount
FROM employee AS emp
LEFT JOIN sales AS s
       ON emp.employeeId = s.employeeId
WHERE emp.title = 'Sales Person' 
  AND s.salesAmount IS NULL;


  --List all customers and their sales, even if some data is gone.
SELECT cust.firstName, cust.lastName, cust.email, s.salesAmount, s.soldDate 
FROM customer AS cust
INNER JOIN sales AS s
        ON cust.customerId = s.customerId
UNION
-- UNION with customers who  have no sales
SELECT cust.firstName, cust.lastName, cust.email, s.salesAmount, s.soldDate 
FROM customer AS cust
LEFT JOIN sales AS s
       ON cust.customerId = s.customerId
WHERE s.salesId IS NULL
UNION
--UNION with sales missing customer data
SELECT cust.firstName, cust.lastName, cust.email, s.salesAmount, s.soldDate 
FROM sales AS s
LEFT JOIN customer AS cust
       ON cust.customerId = s.customerId
WHERE cust.customerId IS NULL;
