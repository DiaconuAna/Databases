create database antiquitylab
go
use antiquitylab
go

CREATE TABLE Employee
( employee_id CHAR(10),
  first_name CHAR(10),
  last_name CHAR(10),
  remuneration DECIMAL(12,2),
  PRIMARY KEY(employee_id))

  select * from Employee


CREATE TABLE Shifts
( shift_id CHAR(10),
  shift_day CHAR(10),
  start_hour TINYINT,
  end_hour TINYINT,
  PRIMARY KEY(shift_id))

  select * from Shifts


  -- creating a m:n relationship between Employee and Shifts through EmployeeSchedule

  CREATE TABLE EmployeeSchedule
  ( schedule_id CHAR(10),
    employee_id CHAR(10),
	shift_id CHAR(10),
	PRIMARY KEY(schedule_id, employee_id, shift_id),
	FOREIGN KEY(employee_id) REFERENCES Employee(employee_id),
	FOREIGN KEY(shift_id) REFERENCES Shifts(shift_id))

	select * from EmployeeSchedule

	--

CREATE TABLE Country
( country_id INT,
  country_name CHAR(10),
  PRIMARY KEY(country_id))

  --add a country foreign key to employee
  --ALTER TABLE MovieCast
--ADD CONSTRAINT FK_MovieCast_Actor FOREIGN KEY(aid) REFERENCES Actor(aid)
  
    ALTER TABLE Employee
	ADD country_id INT

	ALTER TABLE Employee
	ADD CONSTRAINT FK_Employee_Country FOREIGN KEY(country_id) REFERENCES Country(country_id)

	ALTER TABLE Employee
	DROP FK_Employee_Country

	ALTER TABLE Employee
	DROP COLUMN country_id



  CREATE TABLE Client(
  client_id CHAR(10),
  first_name CHAR(10),
  last_name CHAR(10),
  PRIMARY KEY(client_id))


  -- atype_id is a unique id that stands for a type such as clothes, furniture, books, coins, toys, cosmetics
  -- type description is a brief description of the type
CREATE TABLE AntiquityType
( atype_id INT,
  type_description VARCHAR(100),
  PRIMARY KEY(atype_id)
 )

-- 
  -- history_id is a unique id that stands for a historical period such as the interbelic period, Victorian times, Tudor times etc
  -- history_details is a brief description of why that historical period  was associated to an antiquity
 CREATE TABLE AntiquityHistory
 ( history_id INT,
   history_details VARCHAR(100),
   PRIMARY KEY(history_id))

 --  

-- an antiquity is uniquely defined by its id
CREATE TABLE Antiquity
( antiquity_id CHAR(10),
  history_id  INT,
  anttype_id INT,
  antiquity_price DECIMAL(5,2),
  item_availability BIT
  PRIMARY KEY (antiquity_id),
  FOREIGN KEY (history_id) REFERENCES AntiquityHistory(history_id),
  FOREIGN KEY (anttype_id) REFERENCES AntiquityType(atype_id))

  select * from Antiquity

  -- a purchase may contain more antiquities, but an antiquity is linked to only one purchase


  CREATE TABLE Purchase
  ( purchase_id CHAR(10),
    client_id CHAR(10),
	employee_id CHAR(10),
	purchase_date DATE,
	purchase_value DECIMAL(5,2),
	purchase_currency MONEY,
	PRIMARY KEY(purchase_id, employee_id, purchase_date),
	FOREIGN KEY (client_id) REFERENCES Client(client_id),
	FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),--)
	)

	ALTER TABLE Purchase
	ALTER COLUMN purchase_currency CHAR(10);

	 CREATE TABLE AntiquityPurchase 
  ( purchase_id CHAR(10),
    antiquity_id CHAR(10),
	employee_id CHAR(10),
	purchase_date DATE,

	PRIMARY KEY(purchase_id, antiquity_id, employee_id, purchase_date),
	FOREIGN KEY (antiquity_id) REFERENCES Antiquity(antiquity_id),
	FOREIGN KEY (purchase_id, employee_id, purchase_date) REFERENCES Purchase(purchase_id, employee_id, purchase_date)
	 ON DELETE CASCADE
     ON UPDATE CASCADE)

	SELECT * FROM Purchase


	CREATE TABLE Provider
	( provider_id CHAR(10),
	  provider_detaills CHAR(100),
	  provider_name CHAR(100),
	  provider_country_id INT
	  PRIMARY KEY (provider_id),
	  FOREIGN KEY(provider_country_id) REFERENCES Country(country_id))



	  CREATE TABLE ProviderOrder
	  ( order_id CHAR(10),
	    provider_id CHAR(10),
		order_value MONEY,
		date_delivered DATE,
		date_received DATE,
		PRIMARY KEY(order_id),
		FOREIGN KEY(provider_id) REFERENCES Provider(provider_id))

		
	ALTER TABLE ProviderOrder
	ALTER COLUMN order_value DECIMAL(10,2);


		CREATE TABLE AntiquityOrder(
		antiquity_id CHAR(10),
		order_id CHAR(10),
		PRIMARY KEY(antiquity_id, order_id),
		FOREIGN KEY(antiquity_id) REFERENCES Antiquity(antiquity_id),
		FOREIGN KEY(order_id) REFERENCES ProviderOrder(order_id))


	DROP TABLE Antiquity
	DROP TABLE Purchase
	DROP TABLE AntiquityPurchase
	DROP TABLE AntiquityHistory
	DROP TABLE AntiquityType
	DROP TABLE ProviderOrder
	DROP TABLE AntiquityOrder
	DROP TABLE EmployeeSchedule

	--Assignment 2--
	--insert data – for at least 4 tables; 
	--at least one statement should violate referential integrity constraints;


INSERT INTO Employee(employee_id, first_name, last_name, remuneration)
VALUES ('S1', 'Summer', 'Collins', 1300);

INSERT INTO Employee(employee_id, first_name, last_name, remuneration)
VALUES ('J2', 'John', 'Harper', 1200);

INSERT INTO Employee(employee_id, first_name, last_name, remuneration)
VALUES ('E3', 'Ellie', 'Warren', 1300);

INSERT INTO Employee(employee_id, first_name, last_name, remuneration)
VALUES ('J4', 'Jordan', 'Kane', 1400);

  select * from Employee

 INSERT INTO Shifts(shift_id, shift_day, start_hour, end_hour)
 VALUES('M1','Monday',8,16),('M2', 'Monday',16,24),('M3', 'Monday',0,8),('T1', 'Tuesday',0,6),
('T2', 'Tuesday',6,12),('T3', 'Tuesday',12,18),('T4', 'Tuesday',18,24);

INSERT INTO Shifts(shift_id, shift_day, start_hour, end_hour)
VALUES ('M11', 'Monday',0,6),
('M12', 'Monday',6,12),('M13', 'Monday',12,18),('M14', 'Monday',18,24);

INSERT INTO Shifts(shift_id, shift_day, start_hour, end_hour)
 VALUES ('W1','Wednesday',8,16), ('W2','Wednesday',16,24), ('W3','Wednesday',0,8);

   select * from Shifts

   INSERT INTO EmployeeSchedule(schedule_id, shift_id, employee_id)
   VALUES ('N11', 'W1','S1'),('N31','M3','J2'),('N22','W2','J4'); 

   INSERT INTO EmployeeSchedule(schedule_id, shift_id, employee_id)
   VALUES('N1', 'M2', 'S1'),('N2', 'T4', 'J4'),('N3', 'T3', 'J2');

	 INSERT INTO EmployeeSchedule(schedule_id, shift_id, employee_id)
     VALUES('N2', 'M1', 'E3');
   --violating referential integrity constraints
   

   INSERT INTO EmployeeSchedule(schedule_id, shift_id, employee_id)
   VALUES('N1', 'M4', 'J4');

   	 INSERT INTO EmployeeSchedule(schedule_id, shift_id, employee_id)
	 VALUES ('N4','T3','S1'),('N5','M2','J4');


	select * from EmployeeSchedule

	INSERT INTO Client(client_id, first_name, last_name)
	VALUES('AS1', 'Adelie', 'Sylvestre'),('AD1', 'Kevin', 'Daucourt'),('GF1', 'Gemma', 'Francona'),
	('GF2', 'Gabriel', 'Fausto'),('AB1', 'Ana', 'Ciobanu'),('AS2', 'Alexandru', 'Scarlat');

	select * from Client

	INSERT INTO AntiquityType(atype_id, type_description)
	VALUES (1, 'Postcards'), (2, 'Clocks'),(3, 'Books'),(4, 'Pottery'),
	(5, 'Cameras and lenses'),(6, 'Coins'),(7, 'China sets'),(8, 'Typewriters'),
	(9, 'Perfume bottles'),(10, 'Fountain pens'),(11, 'Furniture'),(12, 'Jewelry'),
	(13, 'Paintings');

	select * from AntiquityType

	INSERT INTO AntiquityHistory(history_id, history_details)
	VALUES(1, 'Victorian (1837 to 1901)');

	UPDATE AntiquityHistory
	SET history_details = 'Victorian (A.D. 1837 to A.D.1901)'
	WHERE history_id = 1;

	INSERT INTO AntiquityHistory(history_id, history_details)
	VALUES(2, 'The European Renaissance (A.D. 1450 to A.D. 1600)');

	INSERT INTO AntiquityHistory(history_id, history_details)
	VALUES(3, 'The Enlightenment (A.D. 1650 to A.D. 1800)');

	INSERT INTO AntiquityHistory(history_id, history_details)
	VALUES(4, 'World War I (A.D. 1914 to A.D. 1918) ');

	INSERT INTO AntiquityHistory(history_id, history_details)
	VALUES(5, 'Interwar period (A.D. 1918 to A.D. 1939)');

	INSERT INTO AntiquityHistory(history_id, history_details)
	VALUES(6, 'World War II (A.D. 1939 to A.D. 1945)');

	INSERT INTO AntiquityHistory(history_id, history_details)
	VALUES(7, 'Age of Imperialism (A.D. 1800 to A.D. 1914)');

	INSERT INTO AntiquityHistory(history_id, history_details)
	VALUES(8, 'Ancient Rome (753 B.C. to A.D. 476) ');
	
	

	-- Adding a NAME field in the Antiquity Table
	ALTER TABLE Antiquity
    ADD antiquity_name VARCHAR(500) 

	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('PV1',1,1,'Victorian Postcard with kids', 1, 1);


	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('EC2',1,13,'Roman coin with engraving', 10, 0);

		select * from Antiquity

	--DELETE FROM Antiquity WHERE antiquity_id='EC2';

	UPDATE Antiquity
	SET history_id = 8, anttype_id = 6
	WHERE anttype_id = 13 AND history_id = 1

	--violating referential constraints - invalid history_id

	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('LC54',16,13,'Lady with cat', 275, 0);

	--violating referential constraints - invalid history_id

	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('RT20',5,8,'Remington Typewriter', 800, 1);

	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('AD1',5 ,3,'Dumas - La Dame aux Camelias, 1939 edition', 15, 1);

	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('EH40',6 ,3,'Hemingway - For Whom the Bell Tolls, 1940 signed edition', 50, 0);

	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('WSH1',6 ,3,'Shakespeare - Tragedies, vol.1, 1944 edition', 20, 1);
	
	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('WSH2',6 ,3,'Shakespeare - Tragedies, vol.2, 1944 edition', 20, 1);

	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('WSH3',6 ,3,'Shakespeare - Comedies, vol.1, 1944 edition', 20, 1);
	
	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('WSH4',6 ,3,'Shakespeare - Comedies, vol.2, 1944 edition', 20, 1);

	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('WSH4',6 ,3,'Shakespeare - Comedies, vol.2, 1944 edition', 20, 1);

	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('RR2',1,12,'Victorian Ruby Ring 14 karat', 100, 1), ('SB3',1,12,'Victorian Silver Brooch', 103, 1),
	('DN32',1,12,'Victorian Fire Opal and Diamond Necklace', 500, 1), ('ER3', 1, 12, 'Victorian Emerald Rose Cut Diamond Ring', 300, 0);

	UPDATE Antiquity
	SET antiquity_price = antiquity_price + 302
	WHERE anttype_id = 12 AND antiquity_price >= 100;

	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('PB1',6 ,9,'German Eau de Cologne', 15, NULL);
	
	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('PB2',5,9,'Murano glass perfume bottle',50, 1);

	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('VH1',7,3,'Hugo - Les Orientales, 1848 edition',120, NULL), ('VH2',7,3,'Hugo - Les Miserables, 1862 edition',240, NULL);

	DELETE 
	FROM Antiquity
	WHERE item_availability IS NULL;

	UPDATE Antiquity
	SET item_availability = 0
	WHERE history_id = 5 AND (antiquity_price >= 15 AND antiquity_price<=100);

	select * from Antiquity

	INSERT INTO Purchase(purchase_id, client_id, employee_id, purchase_date, purchase_value, purchase_currency)
	VALUES('P1', 'GF1', 'J2', '2021-10-11', 40, 'euro');

	--violate referential integrity constraints
	INSERT INTO Purchase(purchase_id, client_id, employee_id, purchase_date, purchase_value, purchase_currency)
	VALUES('P2', 'GF1', 'E2', '2021-10-13', 40, 'euro');

	INSERT INTO Purchase(purchase_id, client_id, employee_id, purchase_date, purchase_value, purchase_currency)
	VALUES('P2', 'GF1', 'E3', '2021-10-13', 40, 'euro');

	INSERT INTO AntiquityPurchase(purchase_id, antiquity_id, employee_id, purchase_date)
	VALUES('P1','WSH1','J2','2021-10-11'), ('P1','WSH2','J2','2021-10-11'),
	      ('P2','WSH3','E3','2021-10-13'), ('P2','WSH4','E3','2021-10-13');

	

	--mark the bought objects as not available using LIKE pattern ("WSH...")

	UPDATE Antiquity
	SET item_availability = 0
	WHERE antiquity_id LIKE 'WSH_';

	INSERT INTO Purchase(purchase_id, client_id, employee_id, purchase_date, purchase_value, purchase_currency)
	VALUES('P3', 'AS2', 'J2', '2021-09-21',800, 'euro');

	INSERT INTO AntiquityPurchase(purchase_id, antiquity_id, employee_id, purchase_date)
	VALUES('P3','RT20','J2','2021-09-21');

	INSERT INTO Purchase(purchase_id, client_id, employee_id, purchase_date, purchase_value, purchase_currency)
	VALUES('P4', 'AD1', 'S1', '2021-09-25',600, 'euro');

	INSERT INTO AntiquityPurchase(purchase_id, antiquity_id, employee_id, purchase_date)
	VALUES('P4','ER3','S1','2021-09-25');

	--UPDATE the prices of the bought items - 804 for the typewriter, 602 for the victorian emerald ring
	UPDATE Antiquity
	SET antiquity_price = antiquity_price + 2
	WHERE antiquity_price BETWEEN 600 AND 800;

	-- mark the typewriter and the emerald ring as bought
	UPDATE Antiquity
	SET item_availability = 0
	WHERE (antiquity_price BETWEEN 600 AND 800) AND antiquity_id NOT IN ('RR2', 'SB3');

	--update all purchases involving employee 'J2' to employee 'J4'
	UPDATE Purchase
	SET employee_id = 'J4'
	WHERE employee_id = 'J2';

	--delete the purchases with values less than 50 and greater than 10 (P1 and P2 in our case)
	DELETE FROM Purchase
	WHERE purchase_value BETWEEN 10 AND 50;

	--populate country
	INSERT INTO Country(country_id, country_name)
	VALUES(1, 'Romania'), (2, 'Germany'), (3, 'France'), (4, 'Russia'), (5, 'England');

	--populate Provider
	INSERT INTO Provider(provider_id, provider_country_id, provider_detaills, provider_name)
    VALUES('J3',3, 'Provider of Victorian antiquitites', 'Jean Poirier'),
	      ('A2',2, 'Provider of rare books', 'Anette Mann'),
		  ('D1',1, 'Provider of coins', 'Dan Sandu');

	 INSERT INTO Provider(provider_id, provider_country_id, provider_detaills, provider_name)
     VALUES ('S3',4, 'Provider of perfume bottles and paintings', 'Sergei Davidov'),
		    ('SM3',4, 'Provider of pottery and furniture', 'Sofia Muravieva'),
		    ('N5',5, 'Provider of typewriters', 'Natasha McKay');

    --delete Providers from a specific country using IN operator
	DELETE FROM Provider
	WHERE provider_country_id IN (4,5);

	--insert in providerorder and antiquityorder tables

	--start with the books - ordering them from Anette Mann
	INSERT INTO ProviderOrder(order_id, provider_id, order_value, date_delivered, date_received)
	VALUES ('O1', 'A2', 15, '2021-08-10', '2021-09-01'), ('O2', 'A2', 50, '2021-09-10', '2021-09-24'),
	('O3', 'A2', 40, '2021-07-10', '2021-07-13'), ('O4', 'A2', 40, '2021-07-15', '2021-07-19');

	INSERT INTO AntiquityOrder(order_id, antiquity_id)
	VALUES('O1','AD1'), ('O2','EH40'), ('O3','WSH1'), ('O3', 'WSH2'), ('O4','WSH3'), ('O4', 'WSH4');
	
	--order the victorian stuff from Jean Poirier
	INSERT INTO  ProviderOrder(order_id, provider_id, order_value, date_delivered, date_received)
	VALUES ('V1', 'J3', 1406, '2021-05-20', '2021-05-31'), ('V2','J3',402,'2021-05-24','2021-06-01'),
	('V3','J3',406,'2021-06-02','2021-06-10');

	INSERT INTO AntiquityOrder(order_id, antiquity_id)
	VALUES('V1','DN32'), ('V1','ER3'), ('V2', 'RR2'), ('V3','SB3'), ('V3','PV1');

	--add another purchase involving employee J4
	INSERT INTO Purchase(purchase_id, client_id, employee_id, purchase_date, purchase_value, purchase_currency)
	VALUES('P5', 'AS1', 'J4', '2021-09-13', 10, 'euro');

	INSERT INTO AntiquityPurchase(purchase_id, antiquity_id, employee_id, purchase_date)
	VALUES('P5','EC2','J4','2021-09-13');

	   
	--distinct clients who bought from employee J4

	SELECT DISTINCT C.client_id, C.first_name, C.last_name
	FROM Client C INNER JOIN Purchase P ON C.client_id = P.client_id
				  INNER JOIN Employee E ON P.employee_id = E.employee_id
				  WHERE (E.employee_id = 'J4');
	
	--a list of available antiquities more expensive than any antiquity sold by employee J4
	--the least expensive antiquity sold by J4 costs 10 euros
	SELECT *
	FROM Antiquity A 
	WHERE A.item_availability = 1 AND (A.antiquity_price > ANY
		(SELECT A1.antiquity_price
	     FROM Antiquity A1 INNER JOIN AntiquityPurchase AP1 ON (AP1.employee_id = 'J4' AND AP1.antiquity_id = A1.antiquity_id)));


    -- rewriting it using MIN as an aggregation operator
	SELECT *
	FROM Antiquity A 
	WHERE A.item_availability = 1 AND A.antiquity_price > 
		(SELECT MIN(A1.antiquity_price)
	     FROM Antiquity A1 INNER JOIN AntiquityPurchase AP1 ON (AP1.employee_id = 'J4' AND AP1.antiquity_id = A1.antiquity_id));

    INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('RC1',8 ,6,'Geta Silver Denarius PONTIF COS Minerva Rome AD 207 - RIC 34b', 70, 0);

	INSERT INTO Purchase(purchase_id, client_id, employee_id, purchase_date, purchase_value, purchase_currency)
	VALUES('P6', 'AS2', 'E3', '2021-09-21',70, 'euro');

	INSERT INTO AntiquityPurchase(purchase_id, antiquity_id, employee_id, purchase_date)
	VALUES('P6','RC1','E3','2021-09-21');

	INSERT INTO ProviderOrder(order_id, provider_id, order_value, date_delivered, date_received)
	VALUES ('C1', 'D1', 80, '2021-08-10', '2021-09-01');

	INSERT INTO AntiquityOrder(order_id, antiquity_id)
	VALUES('C1','EC2'), ('C1','RC1');

    --antiquities more expensive than all the antiquities sold by employee E3, no matter the availability
	--the most expensive antiquity sold by E3 costs 70 euros
	SELECT *
	FROM Antiquity A 
	WHERE A.antiquity_price > ALL
		(SELECT A1.antiquity_price
	     FROM Antiquity A1 INNER JOIN AntiquityPurchase AP1 ON (AP1.employee_id = 'E3' AND AP1.antiquity_id = A1.antiquity_id));

    --rewriting it using MAX as an aggregation operator
	SELECT *
	FROM Antiquity A 
	WHERE A.antiquity_price >
		(SELECT MAX(A1.antiquity_price)
	     FROM Antiquity A1 INNER JOIN AntiquityPurchase AP1 ON (AP1.employee_id = 'E3' AND AP1.antiquity_id = A1.antiquity_id));

    --2 queries with the union operation; use UNION [ALL] and OR;

	--UNION - display all antiquities ordered from Jean Poirier and Dan Sandu
	
	--as we need both antiquity id and provider id, we join them using a right join
	SELECT A.antiquity_id, A.Antiquity_name
	FROM Antiquity A, Provider P
	WHERE A.antiquity_id IN (
		SELECT t.antiquity_id
		FROM (SELECT A1.antiquity_id, P1.provider_id
		 FROM AntiquityOrder A1 RIGHT JOIN ProviderOrder P1 ON A1.order_id = P1.order_id AND P1.provider_id = 'J3')t) 
    UNION
	SELECT A2.antiquity_id, A2.Antiquity_name
	FROM Antiquity A2, Provider P2
	WHERE A2.antiquity_id IN (
		SELECT c.antiquity_id
		FROM (SELECT A1.antiquity_id, P1.provider_id
		 FROM AntiquityOrder A1 RIGHT JOIN ProviderOrder P1 ON A1.order_id = P1.order_id AND P1.provider_id = 'D1')c) 

    --display providers from Russia and France using OR

     SELECT P.provider_name, C.country_name
	 FROM Provider P, Country C
	 WHERE P.provider_country_id = C.country_id AND
	 (C.country_name = 'Russia' OR C.country_name = 'France');

	 -- add an antiquity from ww2 sold by S1
	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('PP3',6 ,10,'1945 Parker Pen', 400, 0);

	INSERT INTO Purchase(purchase_id, client_id, employee_id, purchase_date, purchase_value, purchase_currency)
	VALUES('P7', 'AD1', 'S1', '2021-10-21',400, 'euro');

	INSERT INTO AntiquityPurchase(purchase_id, antiquity_id, employee_id, purchase_date)
	VALUES('P7','PP3','S1','2021-10-21');





	--find employees who have sold products both from WW2 (history_id = 6) and the ancient rome (history_id = 8)
	--intersection using INTERSECT
	--SELECT SA.antiquity_id, SA.antiquity_name, SA.history_id, SA.employee_id
	SELECT DISTINCT SA.employee_id
	FROM (SELECT A.antiquity_id, A.history_id, A.antiquity_name, AP.purchase_id, AP.employee_id
	       FROM Antiquity A, AntiquityPurchase AP
		   WHERE AP.antiquity_id = A.antiquity_id) SA
	WHERE SA.history_id = 6
	INTERSECT
	--SELECT SA1.antiquity_id, SA1.antiquity_name, SA1.history_id, SA1.employee_id
	SELECT DISTINCT SA1.employee_id
	FROM (SELECT A1.antiquity_id, A1.history_id, A1.antiquity_name, AP1.purchase_id, AP1.employee_id
	       FROM Antiquity A1, AntiquityPurchase AP1
		   WHERE AP1.antiquity_id = A1.antiquity_id) SA1
	WHERE SA1.history_id = 8


	--insert one more antiquity order to be shipped in september
	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('RC2',8 ,6,'Hadrian, 117 - 138 AD, AE As, Salus', 40, 0);

	INSERT INTO Purchase(purchase_id, client_id, employee_id, purchase_date, purchase_value, purchase_currency)
	VALUES('P8', 'AS2', 'E3', '2021-09-10',40, 'euro');

	INSERT INTO AntiquityPurchase(purchase_id, antiquity_id, employee_id, purchase_date)
	VALUES('P8','RC2','E3','2021-09-10');

	INSERT INTO ProviderOrder(order_id, provider_id, order_value, date_delivered, date_received)
	VALUES ('C2', 'D1', 40, '2021-09-02', '2021-09-05');

	INSERT INTO AntiquityOrder(order_id, antiquity_id)
	VALUES('C2','RC2');



	--find names providers who delivered orders in August and September
	--intersection using IN
	--RIGHT JOIN to filter providers who have already delivered products
	SELECT P.provider_name
	FROM Provider P RIGHT JOIN ProviderOrder AP
	ON P.provider_id = AP.provider_id
	WHERE ( MONTH(AP.date_delivered) = 8 ) AND
	P.provider_name IN
			(SELECT P1.provider_name
			 FROM Provider P1 RIGHT JOIN ProviderOrder AP1
		     ON P1.provider_id = AP1.provider_id
			 WHERE ( MONTH(AP1.date_delivered) = 9))
	--can I count it also for - queries with the IN operator and a subquery in the WHERE clause ??

	SELECT TOP 10  R.Name, R.Age
FROM Researchers R
ORDER BY R.Name

	--top 3 most expensive available antiquities ordered descending by price

	SELECT TOP 3 A.antiquity_id, A.antiquity_name, A.antiquity_price
	FROM Antiquity A
	WHERE EXISTS
					( SELECT DISTINCT A1.antiquity_price
					  FROM Antiquity A1
					  WHERE A1.item_availability = 1
					) 
     ORDER BY A.antiquity_price DESC 
	
	--top 3 most requested providers ordered by the number of orders
	--ONE GROUP BY CLAUSE CONTAINING A SUBQUERY IN THE HAVING CLAUSE AND THE AGGREGATION OPERATOR COUNT
	--ALSO USED ORDER BY, TOP AND DISTINCT

	SELECT P.provider_name
	FROM Provider P INNER JOIN(
	SELECT TOP 3 P2.provider_id, COUNT(*) porders
	FROM ProviderOrder P2
	GROUP BY P2.provider_id
	HAVING COUNT(*) IN(
				SELECT DISTINCT TOP 3 COUNT(*) AS orders
				FROM ProviderOrder PO1
				GROUP BY PO1.provider_id
				ORDER BY orders DESC)
	ORDER BY porders DESC) PS ON P.provider_id = PS.provider_id

	--arithmetic expressions in the SELECT clause in at least 3 queries;

	--compute the Christmas Bonus for each employee - 20% of their remuneration
	SELECT E.remuneration, cast(round(20*E.remuneration/100,2) as numeric(10,2)) as ChristmasBonus
	FROM Employee E

    --compute the TVA for purchases made in September (sorted by purchase date)
	SELECT P.purchase_id, P.purchase_date, P.purchase_value, cast(round(P.purchase_value*10/100, 3) as numeric(10,2)) as TVA
	From Purchase P
	WHERE MONTH(P.purchase_date) = 9
	ORDER BY P.purchase_date;

	--compute the prices for the antiquities for Black Friday (45% off) for the available items
	SELECT A.antiquity_id, A.antiquity_name, A.antiquity_price as InitialPrice, cast(round(A.antiquity_price - A.antiquity_price*45/100, 3) as numeric(10,2)) as BlackFridayPrice
	From Antiquity A
	WHERE A.item_availability = 1
	ORDER BY A.antiquity_price;

	--add three books, 2 of which are delivered in october, one in july
	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('JE1',1 ,3,'Charlotte Bronte - Jane Eyre, ', 570, 1);

	INSERT INTO ProviderOrder(order_id, provider_id, order_value, date_delivered, date_received)
	VALUES ('O5', 'A2', 570, '2021-06-02', '2021-07-05');

	INSERT INTO AntiquityOrder(order_id, antiquity_id)
	VALUES('O5','JE1');

	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('WH2',1 ,3,'Wuthering Heights - 1847 edition', 450, 1);

	INSERT INTO ProviderOrder(order_id, provider_id, order_value, date_delivered, date_received)
	VALUES ('O6', 'A2', 450, '2021-09-02', '2021-09-05');

	INSERT INTO AntiquityOrder(order_id, antiquity_id)
	VALUES('O6','WH2');

	INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('GE2',1 ,3,'Great Expectations - 1864 three volumes edition', 700, 1);

	INSERT INTO ProviderOrder(order_id, provider_id, order_value, date_delivered, date_received)
	VALUES ('O7', 'A2', 700, '2021-09-02', '2021-11-05');

	INSERT INTO AntiquityOrder(order_id, antiquity_id)
	VALUES('O7','GE2');

	--LEFT JOIN - see all antiquities and for those who have been ordered from providers, their delivery date and receiving date
	--SELECT A.antiquity_id, A.antiquity_name, PO.date_delivered, PO.date_received
	SELECT *
	FROM Antiquity A LEFT JOIN AntiquityOrder O ON A.antiquity_id = O.antiquity_id
	                 LEFT JOIN ProviderOrder PO ON O.order_id = PO.order_id

	--IN + WHERE subquery + WHERE subquery
	--find books which have been received in september and july

	SELECT A.antiquity_id, A.antiquity_name, A.anttype_id
	FROM Antiquity A
	WHERE A.antiquity_id IN 
	     ( SELECT O1.antiquity_id
		   FROM AntiquityOrder O1
		   WHERE O1.order_id IN
		         (SELECT PO2.order_id--, PO2.date_received
				  FROM ProviderOrder PO2
				  WHERE MONTH(PO2.date_received) IN (7,9))
		   ) AND A.anttype_id = 3
		   

	--difference using EXCEPT   + EXISTS AND WHERE SUBQUERY
	--employees who work on Monday, but don't work on Wednesday

	SELECT E.first_name, E.last_name, E.employee_id
	FROM Employee E
	WHERE EXISTS(
	SELECT ES.employee_id
	FROM EmployeeSchedule ES
	WHERE ES.shift_id IN
	     (SELECT S.shift_id
		  FROM Shifts S
		  WHERE S.shift_day = 'Monday') AND E.employee_id = ES.employee_id)
	EXCEPT
	SELECT  E.first_name, E.last_name, E.employee_id
	FROM Employee E
	WHERE EXISTS(
	SELECT ES.employee_id
	FROM EmployeeSchedule ES
	WHERE ES.shift_id IN
	     (SELECT S.shift_id
		  FROM Shifts S
		  WHERE S.shift_day = 'Wednesday') AND E.employee_id = ES.employee_id)


		  SELECT R.Name
FROM Researchers R, AuthorContribution A, Papers P
WHERE R.RID = A.RID AND A.PID = P.PID AND
      P.Conference = 'EDBT' AND A.RID NOT IN
			(SELECT A2.RID
       FROM AuthorContribution A2, Papers P2
       WHERE A2.PID = P2.PID AND P2.Conference = 'IDEAS') 

    --difference with not in
	--clients who bought from Jordan Kane, but not from Ellie Warren
	SELECT P.client_id, C.first_name, C.last_name, P.employee_id
	FROM Purchase P, Client C
	WHERE P.employee_id = 'J4' AND C.client_id = P.client_id AND
	C.client_id NOT IN
	     (SELECT C1.client_id
		  FROM Purchase P1, Client C1
		  WHERE C1.client_id = P1.client_id AND P1.employee_id = 'E3')

		  --INVALID
    --FULL JOIN with 2 m:n relationships (Employee-Shifts; Employee-Clients)
	-- display each employee with their working schedule and the clients who bought from them and what bought from them
	--SELECT C.client_id, C.first_name as ClientFirstName, C.last_name as ClientLastName, P.purchase_id, E.employee_id, 
	SELECT C.client_id, P.purchase_id,E.employee_id, S.shift_id, S.start_hour, S.end_hour
	       --E.first_name as EmployeeFirstName, E.last_name as EmployeeLastName, ES.schedule_id, S.shift_day, S.start_hour, S.end_hour
	FROM Client C RIGHT JOIN Purchase P ON P.client_id = C.client_id --display only clients who bought something
	              FULL JOIN Employee E ON P.employee_id = E.employee_id --to see employees who didn't sell anything
				  FULL JOIN EmployeeSchedule ES ON ES.employee_id = E.employee_id --and the weekly schedule of each employee
				  LEFT JOIN Shifts S ON ES.shift_id = S.shift_id --display only the assigned shifts
	GROUP BY E.employee_id, C.client_id, P.purchase_id,  S.shift_id, S.start_hour, S.end_hour

	--to move from here--

	CREATE TABLE Advertisement
	(adv_id CHAR(10),
	 descr CHAR(100)
	 PRIMARY KEY(adv_id));

	 CREATE TABLE ClientAdvertisement
	 (adv_id CHAR(10),
	  client_id CHAR(10),
	  PRIMARY KEY(adv_id, client_id),
	  FOREIGN KEY(adv_id) REFERENCES Advertisement(adv_id)
	  ON DELETE CASCADE,
	  FOREIGN KEY(client_id) REFERENCES Client(client_id)
	  ON DELETE CASCADE)

	  INSERT INTO Advertisement(adv_id, descr)
	  VALUES('A1', 'All books are 20% OFF!'),
	  ('A2','Once in a lifetime opportunity - get your hands on a Remington typewriter!'),
	  ('A3','Look like Queen Victoria with these authentic Victorian jewelleries.');

	  INSERT INTO Advertisement(adv_id, descr)
	  VALUES('A4','New arrivals! Check out the new fountain pens!');

	  INSERT INTO ClientAdvertisement(adv_id, client_id)
	  VALUES ('A1','GF1'), ('A1','AS2'), ('A3','GF1'),('A2','AB1');
	  
	 --see which clients were convinced by the advertisements to buy something and if yes, from which employee

	 SELECT A.adv_id, A.descr, C.client_id, C.first_name, C.last_name, P.purchase_id, E.employee_id, E.first_name,E.last_name
	 FROM Advertisement A FULL JOIN ClientAdvertisement CA ON A.adv_id = CA.adv_id
	                      RIGHT JOIN Client C ON CA.client_id = C.client_id
						  FULL JOIN Purchase P ON C.client_id = P.client_id
						  RIGHT JOIN Employee E ON E.employee_id = P.employee_id
	 GROUP BY C.client_id, P.purchase_id, E.employee_id, A.adv_id, A.descr, C.first_name, C.last_name, E.first_name, E.last_name 
	

	CREATE TABLE Month(
	month_id INT,
	month_name CHAR(15)
	PRIMARY KEY(month_id)
	)

	INSERT INTO Month(month_id, month_name)
	VALUES (1, 'January'), (2, 'February'), (3, 'March'), (4, 'April'),
	(5, 'May'), (6, 'June'), (7, 'July'), (8, 'August'), (9, 'September'),
	(10, 'October'), (11, 'November'), (12, 'December')

	CREATE TABLE MonthWeek
	(month_id INT,
	 week_id CHAR(10),
	 PRIMARY KEY (week_id, month_id),
	 FOREIGN KEY (month_id) REFERENCES Month(month_id)
	 ON DELETE CASCADE)

	 INSERT INTO MonthWeek(week_id,month_id)
	 VALUES ('W1',7),('W2',7),('W3',7),('W4',7),
	 ('W1',9),('W2',9),('W3',9),('W4',9),
	 ('W1',10),('W2',10),('W3',10),('W4',10);

	 CREATE TABLE MonthWeekShift(
	 shift_id CHAR(10),
	 month_id INT,
	 week_id CHAR(10),
	 PRIMARY KEY (shift_id, month_id, week_id),
	 FOREIGN KEY (week_id, month_id) REFERENCES MonthWeek(week_id, month_id)
	 ON DELETE CASCADE,
	 FOREIGN KEY(shift_id) REFERENCES Shifts(shift_id)
	 ON DELETE CASCADE)

	 --JOIN Employees and Shifts
	 SELECT E.employee_id, S.shift_id
	 FROM Employee E FULL JOIN EmployeeSchedule ES ON E.employee_id = ES.employee_id
	                 FULL JOIN Shifts S ON ES.shift_id = S.shift_id


	INSERT INTO EmployeeSchedule(schedule_id, employee_id, shift_id)
	VALUES('SK1','K4','M11'),('SK2','K4','W3'),('SS1','S2','M13'),('SS2','S2','T3');\

	INSERT INTO MonthWeekShift(shift_id, week_id, month_id)
	VALUES ('M1','W1',9),('M11','W2',9), ('M2','W3',9),('M12','W4',9), ('M2','W1',9),  ('M3','W1',9),
	       ('M1','W3',9), ('M3','W3',9),('M12','W2',9),('M13','W2',9),('M14','W2',9),
		   ('M11','W4',9),('M13','W4',9),('M14','W4',9)

    INSERT INTO MonthWeekShift(shift_id, week_id, month_id)
	VALUES ('T1','W1',9),('T4','W1',9),('T2','W2',9),('T3','W2',9),
		   ('T1','W3',9),('T4','W3',9),('T2','W4',9),('T3','W4',9),
		   ('W1','W1',9),('W3','W1',9),('W2','W2',9),
		   ('W1','W3',9),('W3','W3',9),('W2','W4',9);

	-- add unique constraint on Shift table
	ALTER TABLE Shifts
	ADD CONSTRAINT uniqueshift UNIQUE (shift_day, start_hour, end_hour);

	--repartizarea schimburilor pe luna septembrie 

    SELECT E.employee_id, E.first_name, E.last_name, S.shift_id, S.shift_day, S.start_hour, S.end_hour, MS.week_id, MS.month_id
	FROM Employee E FULL JOIN EmployeeSchedule ES ON E.employee_id = ES.employee_id
	                INNER JOIN Shifts S ON ES.shift_id = S.shift_id
					INNER JOIN MonthWeekShift MS ON S.shift_id = MS.shift_id
					INNER JOIN MonthWeek M ON MS.month_id = M.month_id AND MS.week_id = M.week_id
					WHERE MS.month_id = 9
	GROUP BY E.employee_id, S.shift_id, S.shift_day, S.start_hour, S.end_hour, MS.week_id, MS.month_id, E.first_name, E.last_name
	                

	--display antiquities that are books or jewelry, but are not from WW2
	SELECT  A.antiquity_id, A.antiquity_name, AnT.type_description, AH.history_details
	FROM (Antiquity A INNER JOIN AntiquityType AnT on A.anttype_id = AnT.atype_id
	                  INNER JOIN AntiquityHistory AH on A.history_id = AH.history_id) 
	WHERE (A.anttype_id = 3 or A.anttype_id=12) AND NOT A.history_id=6)
	GROUP BY AnT.type_description, AH.history_details, A.antiquity_name, A.antiquity_id



	  INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	VALUES('DT1' ,6, 12,'1940s US Navy Dogtags', 22, 1);

	INSERT INTO ProviderOrder(order_id, provider_id, order_value, date_delivered, date_received)
	VALUES ('O8', 'A2', 22, '2021-09-13', '2021-09-16');

	INSERT INTO AntiquityOrder(order_id, antiquity_id)
	VALUES('O8', 'DT1');

	--antiquities ordered from Anette Mann (id: A2) or Jean Poiries (id: J3), that are not books
	SELECT A.antiquity_name, AnT.type_description, AH.history_details, P.provider_name
	FROM Antiquity A INNER JOIN AntiquityOrder AO on A.antiquity_id = AO.antiquity_id 
	                 INNER JOIN ProviderOrder PO on AO.order_id = PO.order_id
					 INNER JOIN Provider P on PO.provider_id = P.provider_id
					 INNER JOIN AntiquityType AnT on A.anttype_id = AnT.atype_id
	                 INNER JOIN AntiquityHistory AH on A.history_id = AH.history_id
	WHERE (P.provider_id = 'A2' OR P.provider_id = 'J3') AND NOT A.anttype_id = 3

	--purchases involving Summer Collins and Jordan Kane, that are not taking place during September
	SELECT C.client_id, P.purchase_id, P.purchase_date,E.last_name,	E.first_name
	       --E.first_name as EmployeeFirstName, E.last_name as EmployeeLastName, ES.schedule_id, S.shift_day, S.start_hour, S.end_hour
	FROM Client C INNER JOIN Purchase P ON P.client_id = C.client_id --display only clients who bought something
	              INNER JOIN Employee E ON P.employee_id = E.employee_id --to see employees who didn't sell anything
	WHERE NOT MONTH(P.purchase_date) = 9 AND (E.employee_id = 'S1' OR E.employee_id = 'J4')


    --average value of purchases from employees who have 3 or more purchases
	SELECT E.employee_id, E.last_name, E.first_name, AVG(P.purchase_value) as PurchaseMonthlyAverage
	FROM Purchase P, Employee E
	WHERE P.employee_id = E.employee_id
	GROUP BY E.employee_id, E.last_name, E.first_name
	HAVING COUNT(*)>=3


	INSERT INTO ProviderOrder(order_id, provider_id, order_value, date_delivered, date_received)
	VALUES ('N1', 'N5', 802, '2021-11-01', '2021-11-05');

	INSERT INTO AntiquityOrder(order_id, antiquity_id)
	VALUES('N1', 'RT20');

	--the most expensive order from each provider who delivered more than 2 orders
	SELECT P.provider_id, P.provider_name, MAX(PO.order_value) as OrderValue
	FROM Provider P, ProviderOrder PO
	WHERE P.provider_id = PO.provider_id
	GROUP BY P.provider_id, P.provider_name--, PO.order_id
	HAVING (
		SELECT COUNT(*)
		FROM ProviderOrder PO1
		WHERE PO1.provider_id = P.provider_id) > 2

		SELECT *
FROM Students S
WHERE S.age > ANY ( SELECT S2.age
										FROM Students S2
										WHERE S2.sname = 'Ion')
	--provider orders more expensive that any order delivered in september

	SELECT *
	FROM ProviderOrder PO
	WHERE PO.order_value > ANY 
		( SELECT PO2.order_value
		  FROM ProviderOrder PO2
		  WHERE MONTH(PO2.date_delivered) = 9);

    --rewrite with NOT IN: orders which have a value larger that any order delivered in september
	--aka orders whose value is bigger than the least expensive order in september
	SELECT *
	FROM ProviderOrder PO
	WHERE PO.order_value NOT IN
	(SELECT PO2.order_value
	 FROM ProviderOrder PO2
	 WHERE PO2.order_value <=
		(SELECT MIN(PO3.order_value)
		 FROM ProviderOrder PO3
		 WHERE MONTH(PO3.date_delivered)=9))

	  INSERT INTO Antiquity(antiquity_id, history_id, anttype_id,antiquity_name, antiquity_price, item_availability)
	  VALUES('SV3' ,6, 1,'Soviet Russian Military Postcard', 8, 1),('PT3',7,4, 'Belle Epoque Pottery Tray', 6,1);

	--antiquities cheaper than all roman coins - ALL query
	SELECT *
	FROM Antiquity A
	WHERE A.antiquity_price < ALL
	(SELECT A1.antiquity_price
	 FROM Antiquity A1
	 WHERE A1.anttype_id = 6)

	--rewriting it using IN
	SELECT *
	FROM Antiquity A
	WHERE A.antiquity_price IN
	   (SELECT A1.antiquity_price
	    FROM Antiquity A1
		WHERE A1.antiquity_price <
		  (SELECT MIN(A2.antiquity_price)
		   FROM Antiquity A2
		   WHERE A2.anttype_id = 6))

    select * from MonthWeekShift
	select * from Client
	select * from Purchase 
	select * from AntiquityPurchase
	select * from Antiquity
	select * from AntiquityOrder
	select * from ProviderOrder
	select * from Provider

	select * from Country

	select * from Employee
	select * from EmployeesInStore
	select * from Shifts
	select * from EmployeeSchedule
