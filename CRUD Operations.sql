SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS [Full Name]
  FROM Employees
  WHERE Salary  IN (25000, 14000, 12500,23600)

  SELECT FirstName , LastName
  FROM Employees
  WHERE ManagerID IS NULL

   SELECT FirstName , LastName, Salary
  FROM Employees
  WHERE Salary > 50000
  ORDER BY Salary DESC

     SELECT TOP(5) FirstName , LastName
  FROM Employees
  ORDER BY Salary DESC

   SELECT  FirstName , LastName
     FROM Employees
		WHERE DepartmentID != 4

--		•	First by salary in decreasing order
--•	Then by first name alphabetically
--•	Then by last name descending
--•	Then by middle name alphabetically

  SELECT *
	FROM Employees
		ORDER BY Salary DESC, FirstName ASC , LastName DESC, MiddleName ASC
CREATE VIEW _EmployeesSalaries AS

SELECT FirstName, LastName, Salary
FROM Employees

GO

SELECT * FROM Employees



CREATE VIEW V_EmployeeNameJobTitle AS
SELECT FirstName + ' ' + ISNULL(MiddleName,'')
 + ' ' + LastName AS [Full Name], [JobTitle]
FROM Employees


SELECT TOP(10) ProjectID, [Name], [Description], StartDate,[EndDate]
FROM Projects
ORDER BY StartDate ASC, [Name] ASC


SELECT FirstName, LastName, HireDate
FROM Employees
ORDER BY HireDate DESC

SELECT * FROM Employees

--Increase Salary with 12 %

SELECT *
FROM Employees
ORDER BY JobTitle

UPDATE Employees
SET Salary *= 1.12
WHERE DepartmentID IN (1,2,4,11)


SELECT Salary
FROM Employees

SELECT TOP(30) CountryName,[Population]
FROM Countries
WHERE ContinentCode = 'EU'
ORDER BY [Population] DESC, CountryName ASC



SELECT * 
FROM Countries


-- CurrencyCode EUR / Not Euro  >>> sort in ASC

SELECT CountryName, CountryCode,
CASE 
	WHEN CurrencyCode = 'EUR' THEN 'Euro'
	ELSE 'Not Euro'
	END AS Currency
FROM Countries
ORDER BY CountryName ASC

SELECT [Name]
FROM Characters
ORDER BY [Name] ASC
