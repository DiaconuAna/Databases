use antiquitylab
go

-- table Ta(aid,a2,...)

CREATE TABLE FigureSkater(
	SkaterID INT IDENTITY (1,1) NOT NULL,  -- aid
	Name VARCHAR(100),
	Age INT,
	WorldStanding INT UNIQUE, -- a2, integer, unique (candidate key)
	CONSTRAINT PK_FigureSkater PRIMARY KEY(SkaterID)
	)

CREATE TABLE Choreographer(
	ChoreographerID INT IDENTITY (1,1) NOT NULL, -- bid
	Name VARCHAR(100),
	AssignedSkatersNumber INT, -- b2, integer
	CONSTRAINT PK_Choreographer PRIMARY KEY(ChoreographerID)
)

CREATE TABLE Program(
	ProgramID INT IDENTITY (1,1) NOT NULL, -- cid
	SkaterID INT, -- aid
	ChoreographerID INT, -- bid
	CONSTRAINT PK_Program PRIMARY KEY(ProgramID),
	CONSTRAINT FK_SkaterId FOREIGN KEY (SkaterID) REFERENCES FigureSkater(SkaterID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_ChoreographerID FOREIGN KEY(ChoreographerID) REFERENCES Choreographer(ChoreographerID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	)

-- populate Ta - FigureSkaters
INSERT INTO FigureSkater(Name, Age, WorldStanding) VALUES
('Alexandra Trusova', 17, 2), ('Kamila Valieva', 16, 3), ('Anna Scherbakova', 17,1), ('Kaori Sakamoto', 22, 5), ('Aliona Kostornaia', 18, 6),
('Alina Zagitova', 17, 4), ('Mai Mihara', 22, 10), ('Mariah Bell', 18, 7), ('Karen Chen', 20, 8), ('Sofia Akatieva', 16, 9)

INSERT INTO FigureSkater
VALUES ('a',1,11),('b',2,12),('c',3,13),('d',4,14),('e',5,15)

DECLARE @i INT
SET @i = 1

WHILE (@i < 5000)
	BEGIN

	DECLARE @name VARCHAR(100)
	SET @name = ''

	DECLARE @age INT

	DECLARE @stringLength INT
	SET @stringLength = CAST(RAND() * 10 +1 AS INT)

	WHILE @stringLength <> 0
		BEGIN
			SELECT @name = @name + CHAR(CAST(RAND() * 25 + 65 AS INT))
			SET @stringLength = @stringLength - 1
		END

	SET @age = CAST(RAND() * 10 + (@i%50) AS INT)

	INSERT INTO FigureSkater(Name, Age, WorldStanding)
	VALUES (@name, @age, @i)

	SET @i = @i + 1
END

select * from FigureSkater

--  Write queries on Ta such that their execution plans contain the following operators:

-- clustered index scan;
-- performs a scan of the table to retrieve the rows which fulfill the condition
set statistics time on
SELECT *
FROM FigureSkater F
WHERE F.Age < 20
set statistics time off
-- clustered index seek;
-- working directly on the primary key

SELECT *
FROM FigureSkater F
WHERE F.SkaterID > 1400


-- nonclustered index scan;

-- create a non clustered index on columns worldStanding and Name

IF EXISTS (SELECT name FROM sys.indexes WHERE name = 'Index_FS_WorldStandingsName')
	DROP INDEX Index_FS_WorldStandings ON FigureSkater
GO
CREATE NONCLUSTERED INDEX Index_FS_WorldStandingsName ON FigureSkater(WorldStanding, Name)


IF EXISTS (SELECT name FROM sys.indexes WHERE name = 'Index_FS_WorldStanding')
	DROP INDEX Index_FS_WorldStandings ON FigureSkater
GO
CREATE NONCLUSTERED INDEX Index_FS_WorldStanding ON FigureSkater(WorldStanding)

-- retrieve the top 7 skaters

SELECT TOP 7 F.Name, F.WorldStanding
FROM FigureSkater F

-- get the Russian skaters (their names end in 'va') + sorted (because of the Index_FS_WorldStandingsName)
SELECT F.Name, F.WorldStanding
FROM FigureSkater F
WHERE F.Name like '%va'


-- nonclustered index seek;
-- the index is used to pinpoint the records that satisfy the query

-- russian skaters (their names end up in 'va' who are in top 5)
SELECT F.Name, f.WorldStanding
FROM FigureSkater F
WHERE F.Name LIKE '%va' AND F.WorldStanding < 6

-- extract the name and the world standing of the skaters between the 4th and the 9th position
SELECT F.Name, f.WorldStanding
FROM FigureSkater F
WHERE F.WorldStanding > 3 AND F.WorldStanding < 10

-- uses the index Index_FS_WorldStanding
SELECT F.WorldStanding
FROM FigureSkater F
WHERE F.WorldStanding < 10

-- key lookup.
-- appears in the queries where the fields and columns that are involved are not part of a clustered index

-- it scans the table to get the Name and the WorldStanding as they are part of a nonclustered index (Index_FS_WorldStandings)
-- and it retrieves Age by locating it using the SkaterID (which is part of the clustered index) - key lookup
SELECT F.Name, F.Age, F.WorldStanding
FROM FigureSkater F
WHERE F.Age < 20
GROUP BY F.Age, F.WorldStanding, F.Name
ORDER BY F.WorldStanding

-- it performs an indexSeek using the column WorldStanding from Index_FS_WorldStanding 
-- but retrieves the other columns (Name, Age and SkaterID) by performing a key lookup using the clustered index (on column SkaterID)
SELECT *
FROM FigureSkater F
WHERE F.WorldStanding = 10

-- b. Write a query on table Tb with a WHERE clause of the form WHERE b2 = value and analyze its execution plan. 
-- Create a nonclustered index that can speed up the query. Examine the execution plan again

-- populate table Tb - Choreographer

DECLARE @i INT
SET @i = 1

WHILE (@i < 5000)
	BEGIN

	DECLARE @name VARCHAR(100)
	SET @name = ''

	DECLARE @assignedSkaters INT

	DECLARE @stringLength INT
	SET @stringLength = CAST(RAND() * 10 +1 AS INT)

	WHILE @stringLength <> 0
		BEGIN
			SELECT @name = @name + CHAR(CAST(RAND() * 25 + 65 AS INT))
			SET @stringLength = @stringLength - 1
		END

	SET @assignedSkaters = CAST(RAND() * 10 + (@i%50) AS INT)

	INSERT INTO Choreographer(Name, AssignedSkatersNumber)
	VALUES (@name, @assignedSkaters)

	SET @i = @i + 1
	END

SELECT * FROM Choreographer
ORDER BY ChoreographerID

DELETE FROM Choreographer
DELETE FROM FigureSkater

-- without index:  SQL Server Execution Times:
-- CPU time = 0 ms,  elapsed time = 0 ms.

-- with index:  SQL Server Execution Times:
-- CPU time = 0 ms,  elapsed time = 0 ms.

set statistics time on
SELECT C.Name, C.AssignedSkatersNumber
FROM Choreographer C
WHERE C.AssignedSkatersNumber = 5
set statistics time off

-- create a non clustered index on column b2 - AssignedSkatersNumber
IF EXISTS (SELECT name FROM sys.indexes WHERE name = 'Index_CH_AssignedSkaters')
	DROP INDEX Index_CH_AssignedSkaters ON Choreographer
GO
CREATE NONCLUSTERED INDEX Index_CH_AssignedSkaters ON Choreographer(AssignedSkatersNumber) INCLUDE (Name)


-- Create a view that joins at least 2 tables.
-- Check whether existing indexes are helpful; if not, reassess existing indexes / examine the cardinality of the tables.

-- populate table Program
INSERT INTO Program(SkaterID, ChoreographerID)
VALUES (1,271035), (1,271036), (2,271035), (2,271036),(3,271037), (4,271038), (4,271039), (5,271036),
	   (6,271039), (6,271040), (7,271040), (7,271060),(8,271062), (8,271067), (9,271130), (9,271036)

SELECT TOP 1 F.SkaterID
FROM FigureSkater F
ORDER BY F.SkaterID

SELECT TOP 1 C.ChoreographerID
FROM Choreographer C
ORDER BY C.ChoreographerID



	DECLARE @skaterID INT
	SET @skaterID = (SELECT TOP 1 F.SkaterID
					 FROM FigureSkater F
				     ORDER BY F.SkaterID)

	DECLARE @choreoID INT
	SET @choreoID = (SELECT TOP 1 C.ChoreographerID
					 FROM Choreographer C
					 ORDER BY C.ChoreographerID)

	DECLARE @j INT
	SET @j = 1

	WHILE (@j < 5000)
		BEGIN

		INSERT INTO Program(SkaterID, ChoreographerID)
		VALUES(@skaterID, @choreoID)

		SET @skaterID = @skaterID + 1
		SET @choreoID = @choreoID + 1

		SET @j = @j + 1
		END

	

DELETE FROM Program
SELECT * FROM Program
GO

CREATE OR ALTER VIEW ProgramDescription AS
	SELECT F.Name as SkaterName, C.Name as ChoreographerName, P.ProgramID
	FROM FigureSkater F INNER JOIN Program P ON F.SkaterID = P.SkaterID
						INNER JOIN Choreographer C ON P.ChoreographerID = C.ChoreographerID
GO

SELECT * FROM ProgramDescription
GO

CREATE OR ALTER VIEW TopSkatersPrograms AS
	SELECT TOP 10 F.Name as SkaterName, C.Name as ChoreographerName, P.ProgramID, F.WorldStanding
	FROM FigureSkater F INNER JOIN Program P ON F.SkaterID = P.SkaterID
						INNER JOIN Choreographer C ON P.ChoreographerID = C.ChoreographerID
	ORDER BY F.WorldStanding
GO

-- deactivate indexes
ALTER INDEX Index_FS_WorldStandingsName
ON FigureSkater DISABLE

-- re-activate indexes
ALTER INDEX Index_FS_WorldStandingsName
ON FigureSkater REBUILD

SELECT * FROM TopSkatersPrograms
