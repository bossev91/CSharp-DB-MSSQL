-- 1.	Employee Address

SELECT TOP(5) EmployeeID,JobTitle, [Employees].AddressID, [Addresses].AddressText
FROM Employees
JOIN [Addresses] On Addresses.AddressID = [Employees].AddressID
ORDER BY [Employees].AddressID
 
--2. 2.	Addresses with Towns

SELECT TOP(50) e.FirstName, e.LastName, t.[Name], a.AddressText FROM Employees e
JOIN [Addresses] a ON a.AddressID = e.AddressID
JOIN [Towns] t ON t.TownID = a.TownID
ORDER BY FirstName ASC, LastName ASC


--3.	Sales Employee

--Sorted by EmployeeID in ascending order. Select only employees from "Sales" department.

SELECT e.EmployeeID, e.FirstName, e.LastName, d.Name FROM Employees e
JOIN [Departments] d ON d.DepartmentID = e.DepartmentID
WHERE e.DepartmentID = 3
ORDER BY d.DepartmentID ASC

-- 4 4.	Employee Departments


SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.Name FROM Employees e
JOIN [Departments] d ON d.DepartmentID = e.DepartmentID
WHERE e.Salary > 15000
ORDER BY d.DepartmentID ASC

-- 5.	Employees Without Project


SELECT TOP(3) e.EmployeeID, e.FirstName FROM Employees e
LEFT JOIN [EmployeesProjects] ep ON ep.EmployeeID = e.EmployeeID
WHERE ep.EmployeeID IS NULL
ORDER BY e.EmployeeID ASC

-- 6.	Employees Hired After

SELECT e.FirstName, e.LastName, e.HireDate, d.Name FROM Employees e
JOIN [Departments] d ON d.DepartmentID = e.DepartmentID
WHERE HireDate > '1.1.1999' AND d.DepartmentID = 3 OR d.DepartmentID = 10
ORDER BY e.HireDate ASC

-- 7.	Employees with Project

SELECT TOP(5) e.EmployeeID, e.FirstName, p.Name FROM Employees e
JOIN EmployeesProjects ep ON ep.EmployeeID = e.EmployeeID
JOIN Projects p ON p.ProjectID = ep.ProjectID
WHERE p.StartDate > 2002-13-08 AND p.EndDate IS NULL
ORDER BY e.EmployeeID ASC

--8.	Employee 24

SELECT e.EmployeeID, e.FirstName ,
CASE
WHEN DATEPART(YEAR, p.StartDate) >= 2005 THEN NULL
ELSE p.Name
END AS ProjectName
FROM Employees e
JOIN EmployeesProjects ep ON ep.EmployeeID = e.EmployeeID
JOIN Projects p ON p.ProjectID = ep.ProjectID
WHERE e.EmployeeID = 24

--9. 9.	Employee Manager

SELECT e.EmployeeID, e.FirstName,e.ManagerID, m.FirstName AS ManagerName FROM Employees e
RIGHT JOIN Employees m ON m.EmployeeID = e.ManagerID
WHERE e.ManagerID = 3 OR e.ManagerID = 7
ORDER BY e.EmployeeID ASC

-- 10. Employee Summary

SELECT TOP(50)e.EmployeeID, e.FirstName + ' ' + e.LastName 
AS EmployeeName, m.FirstName + ' ' + m.LastName 
AS ManagerName, dep.Name AS DepartmentName
FROM Employees e
JOIN Employees m ON m.EmployeeID = e.ManagerID
JOIN Departments dep ON dep.DepartmentID = e.DepartmentID
ORDER BY e.EmployeeID ASC


--11. Min Average Salary

SELECT TOP(1) AVG(Salary) AS MinAverageSalary
FROM Employees e
JOIN Departments dep ON dep.DepartmentID = e.DepartmentID
Group BY e.DepartmentID
ORDER BY MinAverageSalary ASC

--12 Highest Peaks in Bulgaria

SELECT mc.CountryCode,m.MountainRange, p.PeakName, p.Elevation
FROM MountainsCountries mc
JOIN Mountains m ON m.Id = mc.MountainId
JOIN Peaks p ON p.MountainId = m.Id
WHERE p.Elevation > 2835 AND mc.CountryCode = 'BG'
ORDER BY Elevation DESC

--13  Count Mountian Ranges

--BG , US , RU
SELECT mc.CountryCode , COUNT(mc.CountryCode) AS MountainRanges FROM MountainsCountries mc
JOIN Mountains m ON m.Id = mc.MountainId
WHERE mc.CountryCode IN ('BG', 'US', 'RU')--= 'BG' OR mc.CountryCode = 'US' OR mc.CountryCode = 'RU'
GROUP BY mc.CountryCode
ORDER BY MountainRanges DESC


-- 14. Countries with Rivers

SELECT TOP(5) cou.CountryName, rv.RiverName FROM Countries cou
LEFT JOIN CountriesRivers cr ON cr.CountryCode = cou.CountryCode
LEFT JOIN Rivers rv ON rv.Id = cr.RiverId
WHERE ContinentCode = 'AF'  -- its possible abstraction here
ORDER BY cou.CountryName


-- 15. TODO !!!

-- 16. Highest Peak and Longest River by Country

SELECT TOP(5)cn.CountryName,MAX (pk.Elevation) AS HighestPeakElevation
, MAX(rv.Length) AS LongestRiverLenght
FROM Countries cn
FULL OUTER JOIN CountriesRivers cr ON cr.CountryCode = cn.CountryCode
FULL OUTER JOIN Rivers rv ON rv.Id = cr.RiverId
FULL OUTER JOIN MountainsCountries mc ON mc.CountryCode = cn.CountryCode
FULL OUTER JOIN Mountains mn ON mn.Id = mc.MountainId
FULL OUTER JOIN Peaks pk ON pk.MountainId = mn.Id
GROUP BY CountryName
ORDER BY    HighestPeakElevation DESC, 
			LongestRiverLenght DESC,
			cn.CountryName ASC
-- 18 TODO






