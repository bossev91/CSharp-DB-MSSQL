-- 1. Records’ Count

SELECT Count(*) AS [Count] FROM WizzardDeposits

-- 2 Longest Magic Wand

SELECT MAX([MagicWandSize]) AS LongestMagicWand FROM WizzardDeposits

-- 3. Longest Magic Wand Per Deposit Groups

SELECT DepositGroup, MAX([MagicWandSize]) AS LongestMagicWand FROM WizzardDeposits
GROUP BY DepositGroup

--4. * Smallest Deposit Group Per Magic Wand Size

-- DepositGroup is Name / MagicWandSize
-- Group by DepositGroup / sort by lowest average wand size

SELECT TOP(2) DepositGroup FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize) ASC

--5. Deposits Sum

SELECT DepositGroup, SUM(DepositAmount) FROM WizzardDeposits
GROUP BY DepositGroup

--6. Deposits Sum for Ollivander Family
--WHERE MagicWandCreator is Ollivander family

SELECT DepositGroup, SUM(DepositAmount) FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup

--7 Deposits Filter

SELECT DepositGroup, SUM(DepositAmount) AS TotalSum FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family' 
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC

-- 8 Deposit Charge
-- FIND MIN DepositCharge for each group
-- DepositGroup , MagicWandCreator , MinDepositCharge - sort by MWC

SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge)
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup

-- 9. Age Groups

SELECT result.AgeGroup, COUNT(result.AgeGroup) 
FROM (
SELECT CASE 
WHEN AGE BETWEEN 0 AND 10 THEN '[0-10]'
WHEN AGE BETWEEN 11 AND 20 THEN '[11-20]'
WHEN AGE BETWEEN 21 AND 30 THEN '[21-30]'
WHEN AGE BETWEEN 31 AND 40 THEN '[31-40]'
WHEN AGE BETWEEN 41 AND 50 THEN '[41-50]'
WHEN AGE BETWEEN 51 AND 60 THEN '[51-60]'
ELSE '[61+]' 
END AS AgeGroup
FROM WizzardDeposits)
AS result
GROUP BY result.AgeGroup


-- 10. First Letter
-- where DepositGroup is Troll Chest
SELECT DISTINCT LEFT(FirstName,1) AS FirstLetter FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY FirstName
ORDER BY FirstLetter ASC

-- 10 Another solution

SELECT LEFT(FirstName,1) AS FirstLetter -- COUNT(*) to check group count
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName,1)

--11. Average Interest 
-- DepositStartDate is YYYY-MM-DD  // DepositInterest , Split by IsDepositExpired , 

SELECT DepositGroup,IsDepositExpired, AVG(DepositInterest) 
FROM WizzardDeposits
WHERE DepositStartDate > '1985-01-01'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired ASC

-- 12 TODO

-- 13. Departments Total Salaries

SELECT DepartmentID, SUM(Salary) AS [MinimumSalary] FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

-- 14. Employees Minimum Salaries
/* DepartmentID have to be 2,5,7 HireDate should be after 2000-01-01
 we need min salary of each department / DeparmentID, MinimumSalary*/

SELECT DepartmentID, MIN(Salary) AS MinimumSalary FROM Employees
WHERE DepartmentID IN (2 ,5 , 7)
GROUP BY DepartmentID
ORDER BY DepartmentID

--15. Employees Average Salaries

SELECT *
INTO NewTable
FROM Employees
WHERE Salary > 30000 

DELETE FROM NewTable
WHERE ManagerID = 42

UPDATE NewTable
SET Salary += 5000
WHERE DepartmentID = 1

SELECT DepartmentID, AVG(Salary) AS AverageSalary FROM NewTable
GROUP BY DepartmentID


-- 16. Employees Maximum Salaries

  SELECT DepartmentID, MAX(Salary) AS MaxSalary FROM Employees
  GROUP BY DepartmentID
  HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

--17. Employees Count Salaries

SELECT COUNT(*) AS [Count]
FROM Employees
WHERE ManagerID IS NULL
