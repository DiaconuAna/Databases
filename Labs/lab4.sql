use antiquitylab
go

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_Tables

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tables

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_TestRuns

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_TestRuns

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tests

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Tests

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_Views

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Views

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Tables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Tables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRunTables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRunViews]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRuns]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRuns]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestTables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestViews]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Tests]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Tests]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Views]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Views]

GO



CREATE TABLE [Tables] (

	[TableID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunTables] (

	[TestRunID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunViews] (

	[TestRunID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRuns] (

	[TestRunID] [int] IDENTITY (1, 1) NOT NULL ,

	[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,

	[StartAt] [datetime] NULL ,

	[EndAt] [datetime] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestTables] (

	[TestID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[NoOfRows] [int] NOT NULL ,

	[Position] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestViews] (

	[TestID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Tests] (

	[TestID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Views] (

	[ViewID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



ALTER TABLE [Tables] WITH NOCHECK ADD 

	CONSTRAINT [PK_Tables] PRIMARY KEY  CLUSTERED 

	(

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunTables] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRunTables] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID],

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunViews] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRunViews] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID],

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRuns] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRuns] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestTables] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestTables] PRIMARY KEY  CLUSTERED 

	(

		[TestID],

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestViews] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestViews] PRIMARY KEY  CLUSTERED 

	(

		[TestID],

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [Tests] WITH NOCHECK ADD 

	CONSTRAINT [PK_Tests] PRIMARY KEY  CLUSTERED 

	(

		[TestID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [Views] WITH NOCHECK ADD 

	CONSTRAINT [PK_Views] PRIMARY KEY  CLUSTERED 

	(

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunTables] ADD 

	CONSTRAINT [FK_TestRunTables_Tables] FOREIGN KEY 

	(

		[TableID]

	) REFERENCES [Tables] (

		[TableID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestRunTables_TestRuns] FOREIGN KEY 

	(

		[TestRunID]

	) REFERENCES [TestRuns] (

		[TestRunID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestRunViews] ADD 

	CONSTRAINT [FK_TestRunViews_TestRuns] FOREIGN KEY 

	(

		[TestRunID]

	) REFERENCES [TestRuns] (

		[TestRunID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestRunViews_Views] FOREIGN KEY 

	(

		[ViewID]

	) REFERENCES [Views] (

		[ViewID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestTables] ADD 

	CONSTRAINT [FK_TestTables_Tables] FOREIGN KEY 

	(

		[TableID]

	) REFERENCES [Tables] (

		[TableID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestTables_Tests] FOREIGN KEY 

	(

		[TestID]

	) REFERENCES [Tests] (

		[TestID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestViews] ADD 

	CONSTRAINT [FK_TestViews_Tests] FOREIGN KEY 

	(

		[TestID]

	) REFERENCES [Tests] (

		[TestID]

	),

	CONSTRAINT [FK_TestViews_Views] FOREIGN KEY 

	(

		[ViewID]

	) REFERENCES [Views] (

		[ViewID]

	)

GO



--a view with a SELECT statement operating on one table;
-- select only the available items
select * from Antiquity
go

CREATE VIEW viewAntiquityAvailable
AS
	SELECT A.antiquity_id, A.history_id, A.anttype_id, A.antiquity_price, A.antiquity_name
	FROM Antiquity A
	WHERE A.item_availability = 1
go

select * from viewAntiquityAvailable
go

--- a view with a SELECT statement operating on at least 2 tables;
-- view the name of the historical period and the antiquity type for each antiquity
CREATE VIEW viewAntiquityDetails
AS
	SELECT A.antiquity_id, A.antiquity_name, AH.history_details, AT.type_description
	FROM Antiquity A, AntiquityHistory AH, AntiquityType AT
	WHERE A.anttype_id = AT.atype_id AND A.history_id = AH.history_id
GO


-- - a view with a SELECT statement that has a GROUP BY clause and operates on at least 2 tables.
-- antiquities and for those who have been ordered from providers, their delivery date and receiving date

CREATE VIEW viewAntiquityProviders
AS
	SELECT A.antiquity_id, A.antiquity_name, P.provider_name
	FROM (Antiquity A INNER JOIN AntiquityOrder AO ON A.antiquity_id = AO.antiquity_id
					 INNER JOIN ProviderOrder PO ON AO.order_id = PO.order_id
					 INNER JOIN Provider P ON P.provider_id = PO.provider_id)
	GROUP BY P.provider_name, A.antiquity_id, A.antiquity_name
GO

CREATE VIEW viewAntiquityPurchase
AS
	SELECT A.antiquity_id, A.history_id, A.antiquity_name, AP.purchase_id, AP.employee_id
	FROM Antiquity A, AntiquityPurchase AP
	WHERE AP.antiquity_id = A.antiquity_id
	GROUP BY AP.purchase_id, A.history_id, AP.employee_id, A.antiquity_id, A.antiquity_name
GO

select * from viewAntiquityProviders
go

--SELECT COLUMN_NAME, DATA_TYPE 
--FROM INFORMATION_SCHEMA.COLUMNS 
--WHERE TABLE_NAME = 'Antiquity'

--alter column from char to varchar
ALTER TABLE Country
ALTER COLUMN country_name VARCHAR(10)


CREATE TABLE ProviderClone
( provider_id VARCHAR(10) NOT NULL,
  provider_details VARCHAR(100) NOT NULL,
  provider_name VARCHAR(100) NOT NULL,
  provider_country_id INT NOT NULL,
  CONSTRAINT PK_ProviderClone PRIMARY KEY (provider_id),
  CONSTRAINT FK_ProviderClone_CountryID FOREIGN KEY (provider_country_id) REFERENCES Country(country_id)
  ON DELETE CASCADE
)

DROP TABLE ProviderClone

CREATE TABLE ShiftsClone
( shift_id VARCHAR(100) NOT NULL,
  shift_day VARCHAR(100) NOT NULL,
  start_hour INT NOT NULL,
  end_hour INT NOT NULL,
  shift_description VARCHAR(100) NOT NULL,

  CONSTRAINT PK_ShiftsClone PRIMARY KEY (shift_day, start_hour, end_hour)
  )

  drop table ShiftsClone

--procedure to add tables to Tables
-- check if the table has been created
-- check if the table is already in the list

GO

CREATE PROCEDURE addTable @tableName VARCHAR(100)
AS

	--check if the table exists
	DECLARE @tableCount INT
	SET @tableCount=  ( SELECT COUNT(*) FROM sys.tables
	                    WHERE @tableName = name)

	IF @tableCount = 0
	BEGIN
		PRINT 'Table ' + @tableName + ' does not exist in the database'
		RETURN
	END

	--check if the table hasn't been already added
	SET @tableCount = ( SELECT COUNT(*) FROM Tables T
						WHERE @tableName = T.Name)

	IF @tableCount = 1
	BEGIN
		PRINT 'Table ' + @tableName + ' has already been added in the database'
		RETURN
	END

	--insert the table into Tables
	INSERT INTO Tables(Name)
	VALUES (@tableName)
GO


SELECT * FROM Tables

exec addTable 'Country'
exec addTable 'randomtable'
exec addTable 'Country'
exec addTable 'ProvidersClone'

select * from sys.views

GO 
-- do the same for views
CREATE PROCEDURE addViews @viewName VARCHAR(100)
AS

	--check if the view exists
	DECLARE @viewCount INT
	SET @viewCount = (SELECT COUNT(*) FROM sys.views
					  WHERE name = @viewName)

    IF @viewCount = 0
	BEGIN
		PRINT 'View ' + @viewName + ' does not exist in the database'
		RETURN
	END

	--check if the view hasn't been already added
	SET @viewCount = (SELECT COUNT(*) FROM Views V
				      WHERE @viewName = V.Name)

	IF @viewCount = 1
	BEGIN
		PRINT 'View ' + @viewName + ' already exists in the database'
		RETURN
	END

	INSERT INTO Views(Name)
	VALUES (@viewName)

GO

exec addViews 'randomview'
exec addViews 'viewAntiquityAvailable'
exec addViews 'viewAntiquityDetails'
exec addViews 'viewAntiquityAvailable'
exec addViews 'viewAntiquityPurchase'

select * from Views 
go

--create a procedure to add a test to Tests 
-- check if the test you want to add hasn't been added before

CREATE PROCEDURE addTest @testName VARCHAR(100)
AS
	--check if the test hasn't been already added to the database
	DECLARE @testCount INT

	SET @testCount = (SELECT COUNT(*) FROM Tests T
					  WHERE T.Name = @testName)
	IF @testCount = 1
	BEGIN
		PRINT 'Test ' + @testName + 'already exists in the database'
		RETURN
	END

	INSERT INTO Tests(Name)
	VALUES (@testName)
GO

exec addTest 'test1'
exec addTest 'test2'
exec addTest 'test1'

-- add a table to test table
-- checks to be made
-- number of rows > 0
-- position >=0
-- the test name and table name are given as parameters, the ids are obtained within the procedure
go 

CREATE PROCEDURE addTestTable @testName VARCHAR(100), @tableName VARCHAR(100), @rowNumber INT, @position INT
AS
	IF @rowNumber <= 0
		BEGIN
		PRINT 'Number of rows must be a positive number'
		RETURN
		END

	IF @position < 0
		BEGIN
		PRINT 'You cannot have a negative position'
		RETURN
		END

	DECLARE @testID INT, @tableID INT
	DECLARE @testCount INT, @tableCount INT

	SET @tableCount = ( SELECT COUNT(*) FROM Tables T
						WHERE @tableName = T.Name)

	IF @tableCount = 0
		BEGIN
		PRINT 'No table ' + @tableName + ' found'
		RETURN
		END
	ELSE
		BEGIN
		SET @tableID = (SELECT T.TableID FROM Tables T
						WHERE @tableName = T.Name)
		END

	SET @testCount = ( SELECT COUNT(*) FROM Tests T
						WHERE @testName = T.Name)

	IF @testCount = 0
		BEGIN
		PRINT 'No test ' + @testName + ' found'
		RETURN
		END
	ELSE
		BEGIN
		SET @testID = (SELECT T.TestID FROM Tests T
						WHERE @testName = T.Name)
		END

	-- checks done
	INSERT INTO TestTables(TestID, TableID, Position, NoOfRows)
	VALUES (@testID, @tableID, @position, @rowNumber)
GO

SELECT * FROM Tables
SELECT * FROM Tests
SELECT * FROM TestTables

exec addTestTable 'test1', 'Country',10, 0


-- add a view to the test view table
-- the view name is given as a parameter
-- check if the view is among the created views
GO

CREATE PROCEDURE addTestView @viewName VARCHAR(100), @testName VARCHAR(100)
AS
	DECLARE @viewCount INT, @viewID INT
	DECLARE @testCount INT, @testID INT

	SET @viewCount = (SELECT COUNT(*) FROM Views V
					  WHERE @viewName = V.Name)

	IF @viewCount = 0
		BEGIN
		PRINT 'No view ' + @viewName + ' found'
		RETURN
		END
	ELSE
		BEGIN
		SET @viewID = (SELECT V.ViewID from Views V
					   WHERE @viewName = V.Name)
		END
 

	SET @testCount = ( SELECT COUNT(*) FROM Tests T
						WHERE @testName = T.Name)

	IF @testCount = 0
		BEGIN
		PRINT 'No test ' + @testName + ' found'
		RETURN
		END
	ELSE
		BEGIN
		SET @testID = (SELECT T.TestID FROM Tests T
						WHERE @testName = T.Name)
		END

	-- checks done
	INSERT INTO TestViews(ViewID, TestID)
	VALUES (@viewID, @testID)
GO

SELECT * FROM Views
SELECT * FROM TestViews

EXEC addTestView 'viewAntiquityAvailable', 'test1'

-- generate random int value between 1 and 10000

	DECLARE @number INT
	SELECT @number = CAST((RAND() * 10000) AS INT)

	PRINT 'Generated number: ' + cast(@number as varchar(100))


-- generate random varchar
	DECLARE @randstring VARCHAR(100)
	DECLARE @stringLength INT
	SET @randstring = ''
	SET @stringLength = CAST(RAND() * 10 AS INT)
	WHILE @stringLength <> 0
		BEGIN
		SELECT @randstring = @randstring + CHAR(CAST(RAND() * 96 + 32 AS INT))
		SET @stringLength = @stringLength - 1
		END
	PRINT 'Generated string: ' + @randstring

-- extract column names and types from a tabel and generate fitting data for each
GO

CREATE PROCEDURE getTableDetails @tableName VARCHAR(100)
AS
	SELECT COLUMN_NAME, DATA_TYPE 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = @tableName
GO

EXEC getTableDetails 'Country'

GO 

select * from TestTables
select * from Tests
select * from Tables


CREATE PROCEDURE generateTableData2 @tableName VARCHAR(100)
AS

--check if the default primary key exists in the table, if not use a flag to know to add it later
DECLARE @PKFlag INT
SET @PKFlag = 0 -- assume that the default primary key does not exist in the table

DECLARE @PKColumn VARCHAR(100)

--extract the first column which is a foreign key 
SET @PKColumn = (SELECT TOP 1 T.COLUMN_NAME 
FROM( SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE 
	  WHERE TABLE_NAME = @tableName AND CONSTRAINT_NAME LIKE 'PK%')T)

--PRINT 'PK Column in ' + @tableName + ' is: ' + @PKColumn

-- extract its type (int or varchar)
DECLARE @PKType VARCHAR(100)
SET @PKType =(SELECT DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
     TABLE_NAME = @tableName AND 
     COLUMN_NAME = @PKColumn)

	 -- check if the default value (1) is already a value of the int primary key
	 IF @PKType = 'int'
	 BEGIN
	 DECLARE @result TABLE ([rowcount] INT);
	 INSERT INTO @result ([rowcount]) -- insert the result from exec into the result table
		EXEC('IF EXISTS(SELECT ' + @PKColumn +' FROM ' + @tableName + ' WHERE ' + @PKColumn + ' = 1) BEGIN SELECT 1 END ELSE BEGIN SELECT 0 END')
     SET @PKFlag = (SELECT TOP (1) [rowcount] FROM @result);
	 END

	 IF @PKType = 'varchar'
	 BEGIN
		DECLARE @res1 TABLE ([rowcount] INT)
		INSERT INTO @res1([rowcount]) --insert the result from exec into the res1 table
			EXEC('IF EXISTS(SELECT ' + @PKColumn +' FROM ' + @tableName + ' WHERE ' + @PKColumn + ' = ''default'') BEGIN SELECT 1 END ELSE BEGIN SELECT 0 END')
		SET @PKFlag = (SELECT TOP (1) [rowcount] FROM @res1);
	 END


	-- PRINT 'PK FLAG: ' + CAST(@PKFlag as VARCHAR(10))

--use a cursor to iterate through the column and their types
DECLARE ColumnTypeCursor CURSOR FOR
SELECT t.DATA_TYPE, t.COLUMN_NAME
FROM (SELECT COLUMN_NAME, DATA_TYPE 
	  FROM INFORMATION_SCHEMA.COLUMNS 
	  WHERE TABLE_NAME = @tableName) t

DECLARE @colcount INT
SET @colcount = (SELECT COUNT(*) FROM (SELECT COLUMN_NAME, DATA_TYPE 
								 FROM INFORMATION_SCHEMA.COLUMNS 
								 WHERE TABLE_NAME = @tableName) T)

--PRINT 'Column count: ' + CAST(@colcount AS VARCHAR(100))

DECLARE @coltype NVARCHAR(100), @colname VARCHAR(100)
DECLARE @i INT
DECLARE @over INT
DECLARE @PKcheck INT

SET @i = 0
OPEN ColumnTypeCursor

	DECLARE @insertValue VARCHAR(1000)

	SET @insertValue = 'INSERT INTO ' + @tableName + ' VALUES('

WHILE @i < @colcount
	BEGIN

	FETCH ColumnTypeCursor
	INTO @coltype, @colname
	--PRINT 'Current column type: ' + @coltype + ' its name: ' + @colname

	IF @coltype = 'int'

		BEGIN
		DECLARE @number INT
		
		-- if the column is a primary key, check if it contains the default value using PKFlag. if not, insert it else generate a random value
		IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE WHERE TABLE_NAME = @tableName AND CONSTRAINT_NAME LIKE 'PK%' AND COLUMN_NAME = @colname)
			BEGIN
			IF @PKFlag = 1 --the default value exists
				BEGIN
				SELECT @number = CAST((RAND() * 10000) AS INT)
				SET @over = 0
				
				-- check if the generated value for the primary key already exists in the table, if yes generate until a different value is obtained
				WHILE @over = 0
					BEGIN

					DECLARE @res2 TABLE ([rowcount] INT)
					INSERT INTO @res2([rowcount])
					EXEC('IF EXISTS(SELECT ' + @colname +' FROM ' + @tableName + ' WHERE ' + @colname + ' = ' + @number + ') BEGIN SELECT 1 END ELSE BEGIN SELECT 0 END')
					SET @PKcheck = (SELECT TOP (1) [rowcount] FROM @res2);

					--delete it so we will be able to retrieve the value inserted at the next iteration
					DELETE FROM @res2
					WHERE @PKcheck = [rowcount]
					
					-- we found a value that has not been inserted yet as a primary key
					IF @PKcheck = 0
						BEGIN
						SET @over = 1
						END
					ELSE
						BEGIN
						SELECT @number = CAST((RAND() * 10000) AS INT)
						END

					END
				END
			ELSE --if not, we set it			
				BEGIN
				SET @number = 1 -- the default value
				END
			END
		ELSE 
		BEGIN --check if the column it's a foreign key and if yes, assign it the default value
			IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE WHERE TABLE_NAME = @tableName AND CONSTRAINT_NAME LIKE 'FK%' AND COLUMN_NAME = @colname)
			BEGIN
			SET @number = 1
			END
		ELSE
		--IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE WHERE TABLE_NAME = @tableName AND CONSTRAINT_NAME LIKE 'FK%' AND COLUMN_NAME = @colname)
			BEGIN
			
			SELECT @number = CAST((RAND() * 10000) AS INT)
			--PRINT 'Generated number: ' + cast(@number as varchar(100))
			
			END
		END

		--PRINT ' FINAL Generated number: ' + cast(@number as varchar(100))
		SET @insertValue = @insertValue + ' ' + cast(@number as varchar(100))
		END

	IF @coltype = 'varchar'
		BEGIN
		DECLARE @randstring VARCHAR(100)
		DECLARE @stringLength INT

		IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE WHERE TABLE_NAME = @tableName AND CONSTRAINT_NAME LIKE 'PK%' AND COLUMN_NAME = @colname)
		BEGIN
			IF @PKFlag = 1
				BEGIN
					
					SET @randstring = ''
					SET @stringLength = CAST(RAND() * 10 +1 AS INT)
					WHILE @stringLength <> 0
						BEGIN
						SELECT @randstring = @randstring + CHAR(CAST(RAND() * 25 + 65 AS INT))
						SET @stringLength = @stringLength - 1
						END
					--PRINT 'Generated string: ' + @randstring
					
					SET @over = 0
				-- check if the generated value for the primary key already exists in the table, if yes generate until a different value is obtained
					WHILE @over = 0
						BEGIN
					
					--PRINT 'table: ' + @tableName + ' has column: ' + @colname + ' randstring: ' + @randstring
						DECLARE @res3 TABLE ([rowcount] INT)
						
						INSERT INTO @res3([rowcount])
							EXEC('IF EXISTS(SELECT ' + @colname +' FROM ' + @tableName + ' WHERE ' + @colname + ' = ''' + @randstring + ''') BEGIN SELECT 1 END ELSE BEGIN SELECT 0 END')
						
						SET @PKcheck = (SELECT TOP (1) [rowcount] FROM @res3);
						
						DELETE FROM @res3
						WHERE @PKcheck = [rowcount]

					 
						IF @PKcheck = 0
							BEGIN
							SET @over = 1
							END
						ELSE
							BEGIN
							SET @randstring = ''
							SET @stringLength = CAST(RAND() * 10 +1 AS INT)
							
							WHILE @stringLength <> 0
								BEGIN
								SELECT @randstring = @randstring + CHAR(CAST(RAND() * 25 + 65 AS INT))
								SET @stringLength = @stringLength - 1
							END
						END

					END

				END
			ELSE			
				BEGIN
				SET @randstring = 'default'
				END
		END
		ELSE
		BEGIN -- check if the column is a foreign key or not
		IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE WHERE TABLE_NAME = @tableName AND CONSTRAINT_NAME LIKE 'FK%' AND COLUMN_NAME = @colname)
			BEGIN
				SET @randstring = 'default'
			END
		ELSE
			BEGIN
				SET @randstring = ''
				SET @stringLength = CAST(RAND() * 10+1 AS INT)

				WHILE @stringLength <> 0
					BEGIN
					SELECT @randstring = @randstring + CHAR(CAST(RAND() * 25 + 65 AS INT))
					SET @stringLength = @stringLength - 1
					END
				--PRINT 'Generated string: ' + @randstring
			END
		END
			--PRINT 'FINAL Generated string: ' + @randstring

		SET @insertValue = @insertValue + '''' + @randstring + ''''
		END 
		
	IF @i = @colcount - 1
		BEGIN
		SET @insertValue = @insertValue + ')'
		END
	ELSE
	    BEGIN
		SET @insertValue = @insertValue + ','
		END
	SET @i = @i+1
		--PRINT 'TEMP Insert value is: ' + @insertValue

	END
	PRINT 'Insert value is: ' + @insertValue
CLOSE ColumnTypeCursor
DEALLOCATE ColumnTypeCursor
EXEC (@insertValue)
GO

EXEC generateTableData 'Country'
EXEC generateTableData 'ProviderClone'
EXEC generateTableData 'ShiftsClone'

EXEC deleteTableData 'ProviderClone'
EXEC deleteTableData 'Country'
EXEC deleteTableData 'ShiftsClone'

SELECT * FROM ShiftsClone
SELECT * FROM Country
SELECT * FROM ProviderClone

go
CREATE PROCEDURE SelectView @viewName VARCHAR(100)
AS
	DECLARE @selectValue VARCHAR(100)
	DECLARE @viewCount INT

	SET @viewCount = (SELECT COUNT(*) FROM Views V
					  WHERE @viewName = V.Name)

	IF @viewCount = 0
		BEGIN
		PRINT 'No view ' + @viewName + ' found'
		RETURN
		END
	ELSE
		BEGIN
		SET @selectValue = 'SELECT * FROM ' + @viewName
		EXEC(@selectValue)
		END

GO

EXEC SelectView 'viewAntiquityAvailable'
EXEC SelectView 'randomName'
go

CREATE PROCEDURE runTest2 @testName VARCHAR(100) 
AS

	-- find if the test has a valid name and if yes, identify its id from Tests table
	DECLARE @testCount INT
	SET @testCount = (SELECT COUNT(*) FROM Tests T
					  WHERE T.Name = @testName)
	DECLARE @testID INT

	IF @testCount = 0
		BEGIN
		PRINT 'Test ' + @testName + ' does not exist'
		RETURN
		END
	ELSE
		BEGIN
		SET @testID = (SELECT T.TestID FROM Tests T
					   WHERE T.Name = @testName)
		END

	DECLARE @fullStartTime DATETIME2
	DECLARE @fullEndTime DATETIME2

	SET @fullStartTime = SYSDATETIME()
	PRINT 'Test ' + @testName + ' started at: ' + CAST(@fullStartTime as VARCHAR(100))

	-- we insert the data we already have in the TestRun table to get the runTestID for the data we will insert in TestRunTables and TestRunViews
	INSERT INTO TestRuns(Description, StartAt)
	VALUES (@testName, @fullStartTime)

	-- now get the id of the current TestRun
	DECLARE @testRunID INT
	SET @testRunID = CONVERT(INT, (SELECT last_value FROM sys.identity_columns WHERE NAME = 'TestRunID'))

	PRINT 'TestRun: ' + CAST(@testRunID AS VARCHAR(10))

	-- do a delete for all table data
	-- declare a cursor to go through all tables from TestTable that have the testID = our testID

	DECLARE TestTableCursor CURSOR FOR
	SELECT T.TableID, T.NoOfRows, T.Position
	FROM TestTables T
	WHERE T.TestID = @testID
	ORDER BY T.Position 

	DECLARE @tableNumber INT
	DECLARE @i INT
	SET @i = 0
	SET @tableNumber = (SELECT COUNT(*) FROM TestTables T
					    WHERE T.TestID = @testID)

	OPEN TestTableCursor

	DECLARE @tableID INT, @tableName VARCHAR(100)
	DECLARE @rowNumber INT, @position INT

	WHILE @i<@tableNumber 
		BEGIN
		FETCH TestTableCursor
		INTO @tableID, @rowNumber, @position

		--get the table name from Tables table
		SET @tableName = (SELECT T.Name FROM Tables T
						  WHERE T.TableID = @tableID)

		PRINT 'To delete from table: ' + @tableName
		EXEC deleteTableData @tableName
		PRINT 'Deleted from table: ' + @tableName
		SET @i = @i + 1
		END

	CLOSE TestTableCursor
	DEALLOCATE TestTableCursor

	-- insert values in the tables now - based on their reverse deleting order
	DECLARE @insertStartTime DATETIME2
	DECLARE @insertEndTime DATETIME2

	
	DECLARE TestTableCursor CURSOR FOR
	SELECT T.TableID, T.NoOfRows, T.Position
	FROM TestTables T
	WHERE T.TestID = @testID
	ORDER BY T.Position DESC

	SET @i = 0
	DECLARE @j INT
	OPEN TestTableCursor

	
	WHILE @i<@tableNumber 
		BEGIN
		FETCH TestTableCursor
		INTO @tableID, @rowNumber, @position

		--get the table name from Tables table
		SET @tableName = (SELECT T.Name FROM Tables T
						  WHERE T.TableID = @tableID)

		PRINT 'To insert into table: ' + @tableName + ' ' + CAST(@rowNumber AS VARCHAR(10)) + ' rows.'
		
		SET @insertStartTime = SYSDATETIME()
	--PRINT 'Insert test for ' + @testName + ' started at: ' + CAST(@insertStartTime AS VARCHAR(100))


		IF @rowNumber < 0
			BEGIN
			PRINT 'Invalid row number: ' + CAST(@rowNumber AS VARCHAR(10))
			END
		ELSE
			BEGIN
			SET @j = 0
			
			WHILE @j < @rowNumber
				BEGIN
				EXEC generateTableData2 @tableName
				SET @j = @j + 1
				END
			END

		SET @i = @i + 1
		SET @insertEndTime = SYSDATETIME()
	
		-- add the times for insert in the TestRunTables
		INSERT INTO TestRunTables(TestRunID, TableID, StartAt, EndAt)
		VALUES (@testRunID, @tableID, @insertStartTime, @insertEndTime)

		END

	CLOSE TestTableCursor
	DEALLOCATE TestTableCursor

	-- now on to the views
	DECLARE @viewStartTime DATETIME2
	DECLARE @viewEndTime DATETIME2

	DECLARE TestViewCursor CURSOR FOR
	SELECT V.ViewID FROM TestViews V
	WHERE V.TestID = @testID

	DECLARE @viewName VARCHAR(100)
	DECLARE @viewCount INT, @ViewID INT

	SET @viewCount = (SELECT COUNT(*) FROM TestViews WHERE TestID = @testID)
	SET @i = 0

	OPEN TestViewCursor


	WHILE @i < @viewCount
		BEGIN
		FETCH TestViewCursor 
		INTO @ViewID

		SET @viewName = (SELECT TOP 1 V.Name FROM Views V
		                 WHERE V.ViewID = @ViewID)

		PRINT 'Selecting view ' + @viewName + ' with ID: ' + CAST(@ViewID as VARCHAR(10))
		
		SET @viewStartTime = SYSDATETIME()
		
		EXEC SelectView @viewName
		
		SET @viewEndTime = SYSDATETIME()
		SET @i = @i + 1

		-- insert the test results into TestRunViews

		INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt)
		VALUES (@testRunID, @ViewID, @viewStartTime, @viewEndTime)

		END

	CLOSE TestViewCursor
	DEALLOCATE TestViewCursor

	SET @fullEndTime = SYSDATETIME()
	PRINT 'Test ' + @testName + ' ended at: ' + CAST(@fullEndTime AS VARCHAR(100))

	UPDATE TestRuns 
	SET EndAt = @fullEndTime
	WHERE TestRunID = @testRunID
GO

SELECT * FROM Tables
SELECT * FROM Views
SELECT * FROM Tests
SELECT * FROM TestTables
SELECT * FROM TestRuns
SELECT * FROM TestRunTables
SELECT * FROM TestRunViews

exec addTable 'ShiftsClone'
exec addTable 'ProviderClone'

exec addTestTable 'test1', 'Country',10, 2
exec addTestTable 'test1', 'ShiftsClone', 10, 0
exec addTestTable 'test1', 'ProviderClone', 10, 1

exec addTestTable 'test2', 'Country', 100, 2
exec addTestTable 'test2', 'ProviderClone', 50, 1
exec addTestTable 'test2', 'ShiftsClone', 1000,0

exec deleteTableData 'TestTables'

exec addViews 'viewAntiquityProviders'

EXEC runTest 'test1'
EXEC runTest 'test2'

SELECT T.TableID, T.NoOfRows, T.Position
	FROM TestTables T
	WHERE T.TestID = 1
	ORDER BY T.Position 

	EXEC generateTableData 'Country'
EXEC generateTableData 'ProviderClone'
EXEC generateTableData 'ShiftsClone'

EXEC deleteTableData 'ProviderClone'
EXEC deleteTableData 'Country'
EXEC deleteTableData 'ShiftsClone'

SELECT * FROM ShiftsClone
SELECT * FROM Country
SELECT * FROM ProviderClone
