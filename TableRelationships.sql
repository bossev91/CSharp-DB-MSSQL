CREATE DATABASE Relations2
USE Relations2

-- Create one to one relationship 

CREATE TABLE Passports
(
  PassportID INT PRIMARY KEY IDENTITY(101,1),
  PassportNumber VARCHAR(8) 
)

INSERT INTO Passports VALUES
(
'N34FG21B'
)
INSERT INTO Passports VALUES
(
'K65LO4R7'
)
INSERT INTO Passports VALUES
(
'ZE657QP2'
)


CREATE TABLE Persons
(
 PersonID INT PRIMARY KEY IDENTITY,
 FirstName VARCHAR(50),
 Salary DECIMAL(15,2),
 PassportID INT FOREIGN KEY REFERENCES Passports(PassportID) UNIQUE
)

INSERT INTO Persons (FirstName,Salary,PassportID)
VALUES

 ('Roberto', 43300.00, 102),
 ('Tom' , 56100.00, 103),
 ('Yana', 60200.00, 101)

 SELECT * FROM Persons

 -- Problem 2.	One-To-Many Relationship

 CREATE TABLE Manufacturers
 (
  ManufacturerID INT PRIMARY KEY IDENTITY,
  [Name] VARCHAR(30) NOT NULL,
  EstablishedOn DATE
 )

 INSERT INTO Manufacturers([Name], EstablishedOn) VALUES
   ('BMW', '07/03/1916'),
   ('Tesla', '01/01/2003'),
   ('Lada', '01/05/1966')

CREATE TABLE Models
(
  ModelID INT PRIMARY KEY IDENTITY(101,1),
  [Name] VARCHAR(30) NOT NULL,
  ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Models([Name], ManufacturerID) VALUES
('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova ', 3)


SELECT Models.[Name], Manufacturers.[Name] FROM Models
JOIN Manufacturers
ON Models.ManufacturerID = Manufacturers.ManufacturerID


-- Problem 3.	Many-To-Many Relationship

CREATE TABLE Students
(
  StudentID INT PRIMARY KEY IDENTITY,
  [Name] VARCHAR(30) -- Possible to be NULL
)

INSERT INTO Students([Name]) VALUES
('Mila'),
('Toni'),
('Ron')

CREATE TABLE Exams
(
  ExamID INT PRIMARY KEY IDENTITY(101,1),
  [Name] VARCHAR(30) NOT NULL
)

INSERT INTO Exams([Name]) VALUES
('SpringMVC'),
('Neo4j'),
('Oracle 11g')

CREATE TABLE StudentsExams
(
  StudentID  INT FOREIGN KEY REFERENCES Students(StudentID),
  ExamID INT FOREIGN KEY REFERENCES Exams(ExamID),
  PRIMARY KEY(StudentID, ExamID)  
)

INSERT INTO StudentsExams(StudentID,ExamID) VALUES
(1, 101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103)



SELECT Students.[Name], Exams.Name FROM Students
JOIN Exams
ON Students.StudentID = Students.StudentID

-- Problem 4.	Self-Referencing 

CREATE TABLE Teachers
(
   TeacherID INT PRIMARY KEY IDENTITY(101,1),
   [Name] VARCHAR(20),
   ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)

INSERT INTO Teachers([Name],ManagerID) VALUES
('John	',NULL ),
('Maya	',106  ),
('Silvia',106  ),
('Ted	',105  ),
('Mark	',101  ),
('Greta	',101  )


--Problem 5.	Online Store Database

CREATE TABLE Cities
(
  CityID INT PRIMARY KEY,
  [Name] VARCHAR(50)
)

CREATE TABLE Customers
(
  CustomerID INT PRIMARY KEY,
  [Name] VARCHAR(50),
  Birthday DATE,
  CityID INT FOREIGN KEY REFERENCES Cities(CityID)
)

CREATE TABLE Orders
(
   OrderID INT PRIMARY KEY,
   CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
)

CREATE TABLE ItemTypes
(
  ItemTypeID INT PRIMARY KEY,
  [Name] VARCHAR(50)
)

CREATE TABLE Items
(
  ItemID INT PRIMARY KEY,
  [NAME] VARCHAR(50),
  ItemTypeID INT FOREIGN KEY REFERENCES ItemTypes(itemTypeID)
)

CREATE TABLE OrderItems
(
   OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
   ItemID INT FOREIGN KEY REFERENCES Items(ItemID)
   PRIMARY KEY(OrderID, ItemID)
)

--Problem 6.	University Database

CREATE TABLE Subjects
(
  SubjectID INT PRIMARY KEY,
  SubjectName VARCHAR(50)
)

CREATE TABLE Majors
(
  MajorID INT PRIMARY KEY,
  [Name] VARCHAR(50)
)

CREATE TABLE Students
(
  StudentID INT PRIMARY KEY,
  StudentNumber INT,
  StudentName VARCHAR(50),
  MajorID INT FOREIGN KEY REFERENCES Majors(MajorID)
)

CREATE TABLE Agenda
(
  StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
  SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID)
  PRIMARY KEY (StudentID, SubjectID)
)

CREATE TABLE Payments
(
 PaymentID INT PRIMARY KEY,
 PaymentDate DATE,
 PaymentAmount DECIMAL(15,2),
 StudentID INT FOREIGN KEY REFERENCES Students(StudentID)
)

--Problem 9.	*Peaks in Rila

SELECT Mountains.MountainRange, Peaks.PeakName, Peaks.Elevation
FROM Mountains
JOIN Peaks
ON Mountains.Id = 17
WHERE Peaks.MountainId = 17
ORDER BY Peaks.Elevation DESC

