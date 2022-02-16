use antiquitylab
go

--a. modify the type of a column; 

  ALTER TABLE Employee
  ALTER COLUMN remuneration INT;

  ALTER TABLE Employee
  ALTER COLUMN remuneration DECIMAL(12,2);

    select * from Employee

--Place each script in a stored procedure

CREATE PROCEDURE RemunerationTypeInt AS
  ALTER TABLE Employee
  ALTER COLUMN remuneration INT;
GO

CREATE PROCEDURE RemunerationTypeDecimal AS
  ALTER TABLE Employee
  ALTER COLUMN remuneration DECIMAL(12,2);
 GO

 EXEC RemunerationTypeDecimal

 --b. add / remove a column;

 --add a column to the table Antiquity
 ALTER TABLE Antiquity
 ADD antiquity_country INT;

 --and drop it
 ALTER TABLE Antiquity
 DROP COLUMN antiquity_country

 --turn it into procedures

 CREATE PROCEDURE AddColumnAntiquity AS
	ALTER TABLE Antiquity
	ADD antiquity_country INT;
 GO

 CREATE PROCEDURE DropColumnAntiquity AS
	ALTER TABLE Antiquity
	DROP COLUMN antiquity_country
 GO

 EXEC AddColumnAntiquity
 EXEC DropColumnAntiquity

 SELECT * FROM Antiquity

 --c. add / remove a DEFAULT constraint;
 --for table Antiquity, the default value for item availability is 1

ALTER TABLE Antiquity
ADD CONSTRAINT set_av
DEFAULT 1 FOR item_availability;

--and drop it

ALTER TABLE Antiquity
DROP CONSTRAINT set_av

GO

 --turn it into procedures
CREATE PROCEDURE AddAntiquityDefault AS
	ALTER TABLE Antiquity
	ADD CONSTRAINT set_av
	DEFAULT 1 FOR item_availability;
GO

CREATE PROCEDURE RemoveAntiquityDefault AS	
	ALTER TABLE Antiquity
	DROP CONSTRAINT set_av
GO

EXEC AddAntiquityDefault
EXEC RemoveAntiquityDefault


--g. create/drop a table

CREATE TABLE EmployeeCV(
  employee_id VARCHAR(10),
  cv_id VARCHAR(10),
  cv_summary VARCHAR(500)
  --CONSTRAINT PK_EmployeeCV PRIMARY KEY(employee_id, cv_id)
  );


  DROP TABLE EmployeeCV
  GO

  --turn it into a procedure
  
  CREATE PROCEDURE CreateEmployeeCVTable AS
	CREATE TABLE EmployeeCV(
	 employee_id CHAR(10) NOT NULL,
	cv_id VARCHAR(10) NOT NULL,
	cv_summary VARCHAR(500)
	 --CONSTRAINT PK_EmployeeCV PRIMARY KEY(employee_id, cv_id)
	 );
  GO

  CREATE PROCEDURE DropTableEmployeeCV AS
     DROP TABLE EmployeeCV
  GO 

  EXEC CreateEmployeeCVTable
  EXEC DropTableEmployeeCV

  
--d. add / remove a primary key;

ALTER TABLE EmployeeCV
DROP CONSTRAINT PK_EmployeeCV

ALTER TABLE EmployeeCV
ADD CONSTRAINT PK_EmployeeCV PRIMARY KEY(employee_id, cv_id)

GO

--turn it into a procedure
CREATE PROCEDURE AddPK AS
	ALTER TABLE EmployeeCV
	ADD CONSTRAINT PK_EmployeeCV PRIMARY KEY(employee_id, cv_id)
GO

CREATE PROCEDURE RemovePK AS
	ALTER TABLE EmployeeCV
	DROP CONSTRAINT PK_EmployeeCV
GO

EXEC AddPK
EXEC RemovePK


--e. add / remove a candidate key;


-- add unique constraint on Shift table
	ALTER TABLE Shifts
	ADD CONSTRAINT ShiftsCandidateKey UNIQUE (shift_day, start_hour, end_hour);

    ALTER TABLE Shifts
	DROP CONSTRAINT ShiftsCandidateKey

	GO

	--turn it into a procedure

CREATE PROCEDURE AddCandidateKey AS
	ALTER TABLE Shifts
	ADD CONSTRAINT ShiftsCandidateKey UNIQUE (shift_day, start_hour, end_hour);
GO

CREATE PROCEDURE RemoveCandidateKey AS
    ALTER TABLE Shifts
	DROP CONSTRAINT ShiftsCandidateKey
GO

EXEC AddCandidateKey
EXEC RemoveCandidateKey

--f. add / remove a foreign key;

ALTER TABLE EmployeeCV
ADD CONSTRAINT FK_EmployeeCV FOREIGN KEY(employee_id) REFERENCES Employee(employee_id);

ALTER TABLE EmployeeCV
DROP CONSTRAINT FK_EmployeeCV

GO

--turn it into procedures
CREATE PROCEDURE AddFK AS
	ALTER TABLE EmployeeCV
	ADD CONSTRAINT FK_EmployeeCV FOREIGN KEY(employee_id) REFERENCES Employee(employee_id);
GO

CREATE PROCEDURE RemoveFK AS
	ALTER TABLE EmployeeCV
	DROP CONSTRAINT FK_EmployeeCV
GO

EXEC AddFK
EXEC RemoveFK


--Create a new table that holds the current version of the database schema. Simplifying assumption: the version is an integer number.
CREATE PROCEDURE CreateVersionTable AS
CREATE TABLE VersionsHistory(
    versionId INT PRIMARY KEY IDENTITY,
    CurrentVersion INT)
GO

INSERT INTO VersionsHistory(CurrentVersion)
VALUES (0)


CREATE TABLE ProcedureVersion(
    UpProcedure VARCHAR(100),
	DownProcedure VARCHAR(100),
	CurrentVersion INT
	PRIMARY KEY(CurrentVersion)
	)

--insert the versions into the procedureversion table

--version 1 - modify the type of a column - from Employee - remuneration becomes int
INSERT INTO ProcedureVersion(UpProcedure, DownProcedure, CurrentVersion)
VALUES ('RemunerationTypeInt', 'RemunerationTypeDecimal', 1)

--version 2 - version 1 + add a column in the table antiquity
INSERT INTO ProcedureVersion(UpProcedure, DownProcedure, CurrentVersion)
VALUES ('AddColumnAntiquity', 'DropColumnAntiquity', 2)

--version 3 - version 2 + for table Antiquity, the default value for item availability is 1
INSERT INTO ProcedureVersion(UpProcedure, DownProcedure, CurrentVersion)
VALUES ('AddAntiquityDefault', 'RemoveAntiquityDefault', 3)

--version 4 - version 3 + create the table employee CV
INSERT INTO ProcedureVersion(UpProcedure, DownProcedure, CurrentVersion)
VALUES ('CreateEmployeeCVTable', 'DropTableEmployeeCV', 4)

--version 5 - add a primary key to the table employee CV
INSERT INTO ProcedureVersion(UpProcedure, DownProcedure, CurrentVersion)
VALUES ('AddPK', 'RemovePK', 5)

--version 6 - add a candidate key to the table Shifts 
INSERT INTO ProcedureVersion(UpProcedure, DownProcedure, CurrentVersion)
VALUES ('AddCandidateKey', 'RemoveCandidateKey', 6)

--version 7 - add a foreign key to the table EmployeeCV

INSERT INTO ProcedureVersion(UpProcedure, DownProcedure, CurrentVersion)
VALUES ('AddFK', 'RemoveFK', 7)

SELECT * FROM ProcedureVersion

--Write a stored procedure that receives as a parameter a version number and brings the database to that version.
GO
CREATE PROCEDURE UpdateVersion @VersionNumber INT
AS
	DECLARE @currentVersion INT
	--the current version is the latest stored version in the version history table
	SET @currentVersion = (SELECT TOP 1 VH.CurrentVersion
	                       FROM VersionsHistory VH
						   ORDER BY VH.versionId DESC)

	--insert the new version into the corresponding table

	INSERT INTO VersionsHistory(CurrentVersion)
	VALUES(@VersionNumber)

	DECLARE @N INT
	SET @N = 7 --we have 7 versions

	--here we go up
    IF @currentVersion < @VersionNumber
	BEGIN
	
	DECLARE @UpProc VARCHAR(100)
	DECLARE @cursorVersion INT
	SET @cursorVersion = 0

	DECLARE UpCursor CURSOR FOR
		
		SELECT UpProcedure
		FROM ProcedureVersion

		 PRINT 'new version ' +convert(varchar(3),@VersionNumber)
		 PRINT 'currentVersion : ' + convert(varchar(3),@currentVersion)

		OPEN UpCursor
		
--bring the cursor to the procedures corresponding to the current version
		WHILE @cursorVersion < @currentVersion
		BEGIN
		FETCH UpCursor
		INTO @UpProc
		PRINT 'version ' + convert(varchar(3),@cursorVersion) + ' procedure: ' + @UpProc
		SET @cursorVersion = @cursorVersion + 1
		END

--execute the procedures to go up to the new procedure marked by VersionNumber
		WHILE @cursorVersion < @VersionNumber
		BEGIN
		FETCH UpCursor
		INTO @UpProc
		PRINT 'executing ' + @UpProc
		EXEC @UpProc
		SET @cursorVersion = @cursorVersion + 1
		END

	CLOSE UpCursor
	DEALLOCATE UpCursor

	END
	--here we go down
	
--vrem sa avem o versiune anterioara
	IF @currentVersion > @VersionNumber
	BEGIN

	DECLARE @DownProcedure VARCHAR(100)
	DECLARE @N1 INT
	SET @cursorVersion = @currentVersion

	PRINT 'newVersion ' +convert(varchar(3),@VersionNumber)
	PRINT 'currentVersion : ' + convert(varchar(3),@currentVersion)

	DECLARE UndoCursor SCROLL CURSOR FOR
	SELECT DownProcedure
	FROM ProcedureVersion
	OPEN UndoCursor
    FETCH UndoCursor
	INTO @DownProcedure
		
	WHILE @cursorVersion > @VersionNumber
	
  BEGIN
	SET @N1 = @cursorVersion - @N -1
	--PRINT @N1
--a n1-a procedura incepand de la ultimul rand al tabelului
	FETCH ABSOLUTE @N1 FROM UndoCursor
	INTO  @DownProcedure
	PRINT  'executing - ' + @DownProcedure
	EXEC @DownProcedure
	SET @cursorVersion = @cursorVersion-1
	END
	
	CLOSE UndoCursor
	DEALLOCATE UndoCursor

	END
GO
	
	
INSERT INTO VersionsHistory(CurrentVersion)
VALUES (3)

INSERT INTO VersionsHistory(CurrentVersion)
VALUES (2)

EXEC UpdateVersion 6 
INSERT INTO VersionsHistory(CurrentVersion)
VALUES(6)

INSERT INTO VersionsHistory(CurrentVersion)
VALUES (5)

EXEC UpdateVersion 0
SELECT * FROM ProcedureVersion
INSERT INTO VersionsHistory(CurrentVersion)
VALUES(0)

EXEC UpdateVersion 2

EXEC UpdateVersion 5
EXEC UpdateVersion 1

SELECT * FROM VersionsHistory
DROP TABLE VersionsHistory
EXEC CreateVersionTable
