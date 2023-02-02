CONNECTING TO SQL SERVER
--ServerType = Database Engine
--ServerNaME = (local) or 127.0.0.1 or (./)
--Authentication=Windows or SQLServer If SQL server(Login and Password)
--SSMS is a client tool and not the server by itself
--Developer Machine(client) connects to SQL Server using SSMS

-- .MDF file - Data File(Contains actual Data)
-- .LDF - Transaction Log File(used to recover the database)

--Change db name
Alter Database Sample2 Modify Name = Sample3
sp_renameDB 'Sample3','Sample4'

--drop a database
--You cannot drop a database if users are connected change database in single use mode and drop
Alter Database DatabaseName Set SINGLE_USER With Rollback Immediate

--you can't drop db if it is currently in Use
Drop database Sample3

Keys
--Referencing primary key and foreign key
--A foreign key in one table points to  a primary key of another table --prevents invalid data from being posted into the table

ALTER Table [tblPerson] add constraint tblPerson_GenderID_FK
Foreign key (GenderID) references tblGender (ID)

--Adding a default constraint
--Altering an existing column to add a default constraint

--If other users are connected to the database, u need to put the db into single user mode. then drop the db
--With rollback immediate option, will rollback all incomplete transaction and close connection to the database.
--System databases cannot be dropped.
Alter database DatabaseName SET SINGLE_USER With Rollback Immediate

--Altering an existing column to add a default contraint.
ALTER TABLE(TABLE_NAME)
ADD CONSTRAINT(CONSTRAINT_NAME)
DEFAULT (DEFAULT_VALUE) FOR (EXISTING_COLUMN_NAME)

--Adding a new column, with default value, to an existing table
--Dafault constraint is only considered if you dont suppy a value
ALTER TABLE(TABLE_NAME)
ADD(COLUMN_NAME)(DATA_TYPE)(NULL|NOT NULL)
CONSTRAINT(CONSTANT_NAME) DEFAULT (DEFAULT_VALUE)

-------Example Add constraint---------
Alter table tblPerson 
Add Constraint CK_tblPerson_Age CHECK (Age > 0 and Age < 150)

--Dropping a constraint
ALTER TABLE(TABLE_NAME)
DROP CONSTRAINT(CONSTRAINT_NAME)

------Example drop constraint-----
Alter Table tblPerson 
Drop Constraint CK_tblPerson_Age

--cascading referential integrity constraint allow to define the actions MSSQL Server should take when a users attempts 
--to delete or update a key to which an existing foreign key exists
/*OPTIONS
1. No Action
This is the default behaviour. No action specifies that if an attempt is made to delete or update a row with a key referenced 
by foreign keys in existing rows in other tables, an error is raised and the delete or update is rolled back
2. Cascade
Specifies that if an attempt is made to delete or update a row with a key referenced by foreign keys in existing rows or
tables, all rows containing those foreign keys are also deleted or updated
3. Set NULL
Specifies that if an attempt is made to delete or update a row with a key referenced by foreign keys in existing rows in other tables
all rows containing those foreign keys are set to NULL
4. SET DEFAULT 
Specifies that if an attempt is made to delete or update a row with a key referenced by foreign keys in existing rows in other tables
all rows containing those foreign keys are set to DEFAULT*/

/*CHECK CONSTRAINT
-Used to limit the range of the values, that can be entered for a column

Genral formula
ALTER TABLE {TABLE_NAME}
ADD CONSTRAINT {CONSTRAINT_NAME} CHECK (BOOLEAN_EXPRESSION)

DROP CONSTRAINT
ALTER TABLE TBLPERSON
DROP CONSTRAINT CK_TBLPERSON_AGE
*/

--IDENTITY -------
--Allows a column values to be automatically calculated ie  incremented
-----EXAMPLE IDENTITY ON Allows insert in an identity column-----
SET IDENTITY INSERT tblPerson1 ON 
--can be turned off using 
SET IDENTITY INSERT tblPerson1 OFF
DBCC Command -- Is used to reset the identity column value.
DBCC  CHECKIDENT ('tblPerson1',RESEED,0) --DBCC = Database connsistency check command

--Retrieve last generated identity value--
use SCOPE_IDENTITY() --sql server built in function1
--Note: You can use @@IDENTITY and IDENT_CURRENT('TableName')
--Difference
SCOPE_IDENTITY() --same session and  same scope
@@IDENTITY --same session across any scope
IDENT_CURRENT('TableName') --Specific table across any session and any scope.

--Inner join returns only the matching rows between both the tables.
--non matching rows are eliminated
--INNER JOIN returns only the matching rows between both the tables. Non matching 
--tables are eliminated

--Innerjoin
SELECT Name, Gender, Salary, DepartmentName
 from tblEmployee
innerjoin tblDepartment 
ON tblEmployee.DepartmentId = tblDepartment.ID

--left join returns all the matching rows plus non-matching rows
--from the left of the table
SELECT Name, Gender, Salary, DepartmentName
 from tblEmployee
left join tblDepartment 
ON tblEmployee.DepartmentId = tblDepartment.ID

--right join returns all the matching rows plus non-matching rows
--from the right of the table
SELECT Name, Gender, Salary, DepartmentName
 from tblEmployee
right join tblDepartment 
ON tblEmployee.DepartmentId = tblDepartment.ID

--FULL JOIN returns all rows from the left and right tables including the non matching rows
SELECT Name, Gender, Salary, DepartmentName
 from tblEmployee
FULL outer join tblDepartment 
ON tblEmployee.DepartmentId = tblDepartment.ID

--Cross join produces the Cartesian product of the 2 tables involved in the join
SELECT Name, Gender, Salary, DepartmentName
 from tblEmployee
 CROSS JOIN tblDepartment
 
 --JOIN SYNTAX
 SELECT COLUMNLIST
 FROM LEFTTABLE
 JOINTYPE RIGHTTABLE
 ON JOINCONDITION
 
 --CROSS JOIN-Returns cartesian product of the table involved in a join
 --INNER JOIN-Returns only the matching rows. Non matching rows are eliminated
 --LEFT JOIN-Returns all the amtching rows + non matching rows from the left table
 --RIGHT JOIN-Returns all the matching rows + non matching rows from the right table
 --FULL JOIN--Returns all rows from both tables including non-matching rows
 --use is null to select non matching rows
 
 --SELF JOIN JOINS TABLE TO ITSELFT
 SELECT E.Name as Employee, M.Name as Manager
From tblEmployee E
INNER JOIN tblEmployee M
ON E.ManagerID = M.EmployeeID

--CROSS JOIN does not have an on clause....It is the number of rows in the first table multiplied by the number of rows in the second table

/*It can be classified under any type of
JOIN
1. INNER,
2. OUTER(Left, Right, Full)
3. CROSS Joins */
 
 --IDENTITY
 /*if a column is marked as an identity column, then the values for this column are automatically 
 generated, when you insert a new row onto the table
 seed and increment values are optional*/
 Create table tblPerson
 (
  PersonId int identity(1,1) Primary Key,
  Name nvarchar(20)
 )
 /*To explicitly supply value for an identity,
 1. First turn On identity insert-SET Identity_insert tbl_Person    ON
 2.  In the insert query, specify the column list
 insert into tblPerson (PersonId, Name) values(2, 'John')

 ---If you have deleted all rows in a table, an you want to reset the identity column, value
 use DBCC CHECK IDENT command

Reset identity column
 DBCC CHECKIDENT('tblPerson', RESEED, 0)
 
 -->Retrieving identity Column Values
--How to get the last generated identity column vaue
--Difference between SCOPE_IDENTITY(). @@Identity and IDENT_CURRENT('TableName') */
--NOTE you can also use @@IDENTITY and IDENT_CURRENT('TableName')
select SCOPE_IDENTITY() --Current user session.
SELECT @@IDENTITY --Current user session.
select IDENT_CURRENT('Test2') --Any session for Test2 table
--Difference:
/*SCOPE_IDENTITY - Same session and the same SCOPE_IDENTITY
@@IDENTITY - Same session and across anyscope
IDENT_CURRENT(TableName) - Specific table across any session and scope.
*/

/* We use UNIQUE constraint to enforce uniqueness of a column i.e the column shouldnt 
allow any duplicate values. We can add a Unique constraint thru the designer
or using a query.

To create the unique key using a query */
Alter Table Table_Name
Add Constraint Constraint_Name Unique(Column_Name)

--Dropping  a constraint
Alter Table tblPerson 
Drop constraint UQ_tblPerson_Email

--Both Primary key and unique key are used to enforce, the uniqueness of a column
--so when do you choose one over the other
A table can have only one primary key. if you want to enforce uniqueness on 2 or more
columns, then we use unique key constraint.

--what is the differnce between Primary Key constraint and Unique key constraint
1. A table can have only one primary key but more than one unique key
2. Primary key does not allow nulls, where as unique key allows one null
 
Create unique key constraint
 Alter table Test1
Add constraint UQ_TblTest1_Value Unique(Value)

--Drop constraint
Drop constraint UQ_TblTest1_Value

--Group by is mostly used by the aggregate function.
--Example
select Gender, city, SUM(Salary) as Totalsalary, Count(ID) AS [Total Employees]
from tblEmployee Group by Gender, City

--Having clause should come after group by
-- Cmd for restoring Database from a script
sqlcmd -S myServer\instanceName -i C:\myScript.sql

--select statement for names that starts with certain letters eg MST
select * from tblPerson where Name Like '[MST]%'

aggregate 

--Database scripting restoring data
sqlcmd -S SGL-RMS-DR -U sa -P password -i C:\script.sql

--Three ways to Replace null values in sql server
 ISNULL() Function, CASE Statement & COALESCE() Function

--ISNULL
 SELECT E.Name as Employee, ISNULL(M.Name, 'No Manager') as Manager
From tbl_Employees E
Left JOIN tbl_Employees M
ON E.ManagerID = M.EmployeeID

--COALESCE --used to return first non null value
  SELECT E.Name as Employee, COALESCE(M.Name, 'No Manager') as Manager
  From tbl_Employees E
Left JOIN tbl_Employees M
ON E.ManagerID = M.EmployeeID

--CASE
SELECT E.Name as Employee, 
  CASE 
  WHEN M.Name IS NULL THEN 'No Manager' ELSE M.Name
  END
  as Manager
From tbl_Employees E
Left JOIN tbl_Employees M
ON E.ManagerID = M.EmployeeID

/*UNION and UNION ALL operators in SQL Server, are used to combine the result-set of 
two or more select queries

--> For union to work, datatypes, number of columns and order of the columns in the select 
statement should be the same
--> UNION removes duplicates whereas UNION ALL does not
-->NB Estimated query execution plan -CTRL + L
-->Sorting results of UNION or UNION ALL ORDER BY clause should be only used on the last SELECT statement in the UNION Query*/
--UNION--
SELECT Id, Name, Email FROM tblIndiaCustomers
UNION
SELECT Id, Name, Email FROM tblUkCustomers

--UNION ALL--
SELECT Id, Name, Email FROM tblIndiaCustomers
UNION ALL
SELECT Id, Name, Email FROM tblUkCustomers 
ORDER BY Name

--STORED PROCEDURE--
--Getting the text of your store procedure

sp_helptext Name-of-your-procedure
--example--
sp_helptext spGetEmployees --Displays the content of this procedure

--STORED PROCEDURE--
--to chnage sp defination we use ALTER key word--
--TO encrpt a sp use WITH ENCRYPTION
--You can't view the content of a sp that is encrypted--
ALTER PROCEDURE spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@City nvarchar(255)
WITH ENCRYPTION
AS
BEGIN
SELECT Name, Gender, City FROM tblEmployee where Gender = @Gender and City = @City
END

--Execute stored procedure with output.
Declare @TotalCount int
Execute spGetEmployeeCountByGender 'Male', @TotalCount out
Print @TotalCount

Declare @EmployeeTotal int
Execute spGetEmployeeCountByGender @EmployeeCount = @EmployeeTotal OUT, @Gender = 'Male'
Print @EmployeeTotal

--To DELETE Stored Procedure, we use Keyword
DROP Proc procedurename

SP_HELP procedure_name --view info about the stored procedure eg parameter name, data types
SP_HELP --can be used with any database object like tables, views, sp, triggers etc
--Alternatively you can use ALT + F1 when the name of the object is highlighted.
sp_depends procedure_name --view dependancies of the stored procedure, tables etc


--Stored procedure with output parameters--
create proc spGetNameById1
@Id int,
@Name nvarchar(20) output
as
Begin
	select @Name = Name from tblEmployee where Id = @Id
End

--Executing the procedure spGetNameById1
Declare @Name nvarchar(20)
Execute spGetNameById1 9, @Name Out
Print 'NAME = ' + @Name

--Return Status value
---Only Integer Datatype
---Only one value
---Use to convey success or failure

--Output Parameters
---Any Datatype
---More than Value
---Use to return values like name, count etc



























 
 
 
 
 
 


