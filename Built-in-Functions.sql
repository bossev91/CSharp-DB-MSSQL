-- Task 1 - Find by first name start with
USE SoftUni

SELECT FirstName, LastName 
FROM Employees
WHERE FirstName LIKE 'SA%'

-- Task 2 - Find by last name contains
SELECT FirstName, LastName 
	FROM Employees
    WHERE LastName LIKE '%ei%'

-- Task 3 - find by Departments and HireYear

SELECT FirstName FROM Employees
WHERE 
(
DepartmentID IN (3,10) 
)
AND
(
 HireDate between '1995/01/01' and '2005/12/31'
)

--  Problem 4.	Find All Employees Except Engineers


SELECT FirstName, LastName FROM Employees
WHERE [JobTitle] NOT LIKE '%Engineer%'

-- Problem 5.	Find Towns with Name Length
SELECT [Name] FROM Towns
WHERE LEN([Name]) = 5 OR LEN([Name]) = 6
ORDER BY [Name] ASC

--Problem 6.	 Find Towns Starting With

SELECT TownID, [Name] FROM Towns
WHERE [Name] LIKE '[MKBE]%'
ORDER BY [Name] ASC

--Problem 7.	 Find Towns Not Starting With

SELECT TownID, [Name] FROM Towns
WHERE [Name] LIKE '[^RBD]%'
ORDER BY [Name] ASC

--Problem 8.	Create View Employees Hired After 2000 Year

CREATE VIEW [V_EmployeesHiredAfter2000] AS
SELECT FirstName, LastName FROM Employees
WHERE
HireDate > '2001' --- DATEPART(YEAR, HireDate) > 2000 !!!

--Problem 9.	Length of Last Name

SELECT FirstName, LastName FROM Employees
WHERE LEN(LastName) = 5

-- PROBLEM 10.		Rank Employees by Salary

SELECT EmployeeID, FirstName, LastName, Salary , DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS Rank
 FROM Employees
 WHERE Salary BETWEEN 10000 AND 50000
 ORDER BY Salary DESC

 --Problem 11.	Find All Employees with Rank 2 *
SELECT * FROM (SELECT EmployeeID, FirstName, LastName, Salary , DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS Ranked
 FROM Employees
 WHERE Salary BETWEEN 10000 AND 50000 )
 AS RESULT
 WHERE Ranked = 2
 ORDER BY Salary DESC

 -- Problem 12.	Countries Holding ‘A’ 3 or More Times

SELECT CountryName, IsoCode FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY IsoCode

-- Problem 13.	 Mix of Peak and River Names

SELECT PeakName, RiverName, LOWER(LEFT(PeakName, LEN(PeakName) - 1)) + LOWER(RiverName) AS Mix FROM Peaks, Rivers
WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1) 
ORDER BY Mix ASC
--WHERE LEFT(PeakName, 1) = 

SELECT LEFT(PeakName, 5) , LEN(PeakName) - 1 as LENGHTS FROM Peaks

--Problem 14.	Games from 2011 and 2012 year

SELECT TOP(50) Name, FORMAT([Start], 'yyyy-MM-dd') AS [Start] FROM Games
WHERE DATEPART (YEAR, [Start]) BETWEEN 2011 AND 2012
ORDER BY [Start] , [Name]

--Problem 15. User Email Providers

SELECT Username ,RIGHT(Email, LEN(Email) - CHARINDEX('@', Email)) AS Email FROM Users
ORDER BY [Email] ASC , Username ASC

-- Problem 16.	 Get Users with IPAdress Like Pattern

SELECT Username, IpAddress FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username

-- Problem 17.	 Show All Games with Duration and Part of the Day

-- Duration , Name , Start
SELECT [Name],
CASE
WHEN DATEPART(HOUR,[Start]) >= 0 AND DATEPART(HOUR,[Start]) < 12 THEN 'Morning'
WHEN DATEPART(HOUR,[Start]) >= 12 AND DATEPART(HOUR,[Start]) < 18 THEN 'Afternoon'
WHEN DATEPART(HOUR,[Start]) >= 18 AND DATEPART(HOUR,[Start]) < 24 THEN 'Evening'
END AS [Part of the day],
CASE
WHEN Duration <= 3 THEN 'Extra Short'
WHEN Duration BETWEEN 4 and 6 THEN 'Short'
WHEN Duration > 6 THEN 'Long'
ELSE 'Extra Long'
END AS [Duration]
FROM Games
ORDER BY [Name], Duration

-- PROBLEM 18

USE Diablo
	CREATE TABLE Orders
	(
	 Id INT PRIMARY KEY IDENTITY,
	 ProductName VARCHAR(50),
	 OrderDate DATETIME
	)

	INSERT INTO Orders (ProductName, OrderDate) VALUES
('Butter' , '2016-09-19 00:00:00.000'),
('Milk' , '2016-09-30 00:00:00.000'),
('Cheese'  , '2016-09-04 00:00:00.000'),
('Bread' , '2015-12-20 00:00:00.000'),
('Tomatoes'  , '2015-12-30 00:00:00.000')

SELECT ProductName, OrderDate, DATEADD(DAY, 3, OrderDate) AS [Pay Due], DATEADD(MONTH, 1, OrderDate) AS [Deliver Due]
FROM Orders
				


	
-- Problem 19.	 People Table

CREATE TABLE People
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50),
	Birthdate DATETIME
)
	
SELECT * FROM People	

INSERT INTO People([Name], Birthdate) VALUES
('Victor', '2000-12-07 00:00:00.000'),
('Steven',	'1992-09-10 00:00:00.000'),
('Stephen',	'1910-09-19 00:00:00.000'),
( 'John',  '2010-01-06 00:00:00.000')

SELECT Id, [Name] , DATEDIFF(YEAR, Birthdate, GETDATE()) AS [Age in Years],
					DATEDIFF(MONTH, Birthdate, GETDATE()) AS [Age in Months],
					DATEDIFF(DAY, Birthdate, GETDATE()) AS [Age in Days],
					DATEDIFF(MINUTE, Birthdate, GETDATE()) AS [Age in Minutes]


FROM People
