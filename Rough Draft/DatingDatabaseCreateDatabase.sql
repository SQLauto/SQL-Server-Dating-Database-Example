/*
Kenneth Adair
www.cslearner.com

This is the SQL Server code to create a database.
10/20/14
While coding I found errors in my ERD.  I noted the errors in the comments.
I finished primary keys but i still need to set up foreign keys.  
Additionally

*/

--Create database
USE Master

--Delete the database if it exists, used to reset the database if I make mistakes
IF EXISTS (SELECT * FROM master..sysdatabases
					WHERE NAME = 'Dating_Database_Example')
DROP DATABASE Dating_Database_Example

--GO is like a pause button, it tells the software to go until this point, stop, and then keep going.  
GO

--Creates a new database named "Dating_Database_Example"
CREATE DATABASE Dating_Database_Example --Creating goes off the model database

--This is the location where the database will be made
ON PRIMARY
(Name = 'Dating_Database_Example',
FileName = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Dating_Database_Example.mdf',
--file path on local machine

--This is how large the database itself will be.  
Size = 4MB,
Maxsize = 6MB,
Filegrowth = 500KB)

LOG ON
(Name = 'FARMS_Adair_Log',
FileName = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Dating_Database_Example.ldf', --log file
--A log files tracks changes in the database
Size = 2MB,
Maxsize = 4MB,
Filegrowth = 500KB)

GO

--This code tells my SQL Server file to use the "Dating_Database_Example" for the following code
USE Dating_Database_Example 

GO


--How to create a Table
--Here's a template of how to make a table
/*
CREATE TABLE TABLENAME
(
PrimaryKeyColumn	variableType	NOT NULL	IDENTITY(1,1),
ColumnName			variableType	NOT NULL,
ColumnName2			variableType	NULL
)
*/

--ERASE AttractivePersonPhone from ERD since it's in there twice
CREATE TABLE ATTRACTIVEPERSON
(
--Primary Key
AttractivePersonID			smallint	NOT NULL	IDENTITY(1,1),
--Name
AttractivePersonFirstName	varchar(20)	NOT NULL,
AttractivePersonLastName	varchar(20)	NOT NULL,
--Address
AttractivePersonAddress1	varchar(30)	NOT NULL,
AttractivePersonAddress2	varchar(20)	NULL,
AttractivePersonCity		varchar(20)	NOT NULL,
AttractivePersonState		char(2)		NULL,
AttractivePersonPostalCode	char(10)	NOT NULL,
AttractivePersonCountry		varchar(20)	NULL,
--Phone
AttractivePersonPhoneNumber	varchar(20)	NOT NULL,
--Email
AttractivePersonEmail		varchar(30)	NULL,
--Comments and special notes
AttractivePersonComments	varchar(200)	NULL
)

--Update ERD so that Foreign Keys aren't nullable
--Update ERD so foreign keys are at the top rather than the bottom
CREATE TABLE HOTDATE
(
--Primary Key
HotDateID				smallint		NOT NULL	IDENTITY(1,1),
--foreign keys
AttractivePersonID		smallint		NOT NULL,
ActivityID				smallint		NOT NULL,
--The day of the Date
HotDateDayOfOccassion	smalldatetime	NOT NULL,
--Comments and special Notes
HotDateComments			varchar(200)	NULL
)

CREATE TABLE ACTIVITY
(
--Primary Key
ActivityID			smallint	NOT NULL	IDENTITY(1,1),
--Name
ActivityName		varchar(100)	NOT NULL,
--Address
ActivityAddress1	varchar(30)	NOT NULL,
ActivityAddress2	varchar(30)	NULL,
ActivityCity		varchar(20)	NOT NULL,
ActivityState		char(2)		NULL,
ActivityPostalCode	char(10)	NOT NULL,
ActivityCountry		varchar(20)	NULL,
--Phone
ActivityPhone		varchar(20)	NOT NULL,
--Email
ActivityEmail		varchar(30)	NULL,
--Comments and special notes
ActivityCost		smallmoney	NOT NULL
)

--Update the ERD so the foreign keys aren't nullable
CREATE TABLE ROMANTICMEAL
(
RomanticMealID	smallint	NOT NULL	IDENTITY(1,1),
HotDateID		smallint	NOT NULL,
ComboMealID		smallint	NOT NULL
)

--Update the ERD so that the name of the table is COMBOMEAL rather than MEAL
--Update the ERD so the Foreign key is towards the top rather than bottom
--Update the ERD so that the comment section is beneath the cost section
CREATE TABLE COMBOMEAL
(
--Primary Key
ComboMealID			smallint		NOT NULL	IDENTITY(1,1),
--Foreign Key
RestaurantID		smallint		NOT NULL,
--Information about combo meals
ComboMealName		varchar(20)		NOT NULL,
ComboMealMainItem	varchar(20)		NOT NULL,
ComboMealSideItem	varchar(20)		NULL,
ComboMealDrink		varchar(20)		NULL,
--Cost of the combo, used to calculate costs of dates
ComboMealCost		smallmoney		NULL,
--Comments and special notes
ComboMealComments	varchar(200)	NULL
)

--Update ERD so RestaurantName is varchar(200) rather than varchar(max)
CREATE TABLE RESTAURANT
(
--Primary Key
RestaurantID			smallint	NOT NULL	IDENTITY(1,1),
--Name
RestaurantName		varchar(100)	NOT NULL,
--Address
RestaurantAddress1	varchar(30)	NOT NULL,
RestaurantAddress2	varchar(30)	NULL,
RestaurantCity		varchar(20)	NOT NULL,
RestaurantState		char(2)		NULL,
RestaurantPostalCode	char(10)	NOT NULL,
RestaurantCountry		varchar(20)	NULL,
--Phone
RestaurantPhone		varchar(20)	NULL,
--Comments and special notes
RestaurantComments		varchar(200)	NULL
)

--I have now created all the tables on my ERD, next I need to setup primary keys

--CREATE PRIMARY KEYS
--HERE'S MY TEMPLATE
/*
ALTER TABLE Table_Name
ADD CONSTRAINT Name_Of_Constraint
PRIMARY KEY (Primary_Key_Name)
*/

ALTER TABLE ATTRACTIVEPERSON
ADD CONSTRAINT Attractive_Person_Primary_Key_Constraint
PRIMARY KEY (AttractivePersonID)

ALTER TABLE HOTDATE
ADD CONSTRAINT Hot_Date_Primary_Key_Constraint
PRIMARY KEY (HotDateID)

ALTER TABLE ACTIVITY
ADD CONSTRAINT Activity_Primary_Key_Constraint
PRIMARY KEY (ActivityID)

ALTER TABLE ROMANTICMEAL
ADD CONSTRAINT Romantic_Meal_Primary_Key_Constraint
PRIMARY KEY (RomanticMealID)

ALTER TABLE COMBOMEAL
ADD CONSTRAINT Combo_Meal_Primary_Key_Constraint
PRIMARY KEY (ComboMealID)

ALTER TABLE RESTAURANT
ADD CONSTRAINT Restaurant_Primary_Key_Constraint
PRIMARY KEY (RestaurantID)

--CREATE FOREIGN KEYS
--Here's my template
/*
ALTER TABLE Table_Name
ADD CONSTRAINT Name_Of_Constraint
FOREIGN KEY (Foreign_Key_Column_Name) REFERENCES Foreign_Table_Name(Foreign_Key_Column_Name)
ON UPDATE CASCADE
ON DELETE CASCADE
*/