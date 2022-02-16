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

	 CREATE TABLE AntiquityPurchase 
  ( purchase_id CHAR(10),
    antiquity_id CHAR(10),
	employee_id CHAR(10),
	purchase_date DATE,

	PRIMARY KEY(purchase_id, antiquity_id, employee_id, purchase_date),
	FOREIGN KEY (antiquity_id) REFERENCES Antiquity(antiquity_id),
	FOREIGN KEY (purchase_id, employee_id, purchase_date) REFERENCES Purchase(purchase_id, employee_id, purchase_date))

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
