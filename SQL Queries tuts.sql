CONNECTING TO SQL SERVER
--ServerType = Database Engine
--ServerNaME = (local) or 127.0.0.1 or (./)
--Authentication=Windows or SQLServer If SQL server(Login and Password)
--SSMS is a client tool and not the server by itself
--Developer Machine(client) connects to SQL Server using SSMS

--Change db name
Alter Database Sample2 Modify Name = Sample3
sp_renameDB 'Sample3','Sample4'

--drop a database
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

ALTER TABLE(TABLE_NAME)
ADD CONSTRAINT(CONSTRAINT_NAME)
DEFAULT (DEFAULT_VALUE) FOR (EXISTING_COLUMN_NAME)

--Adding a new column, with default value, to an existing table
ALTER TABLE(TABLE_NAME)
ADD(COLUMN_NAME)(DATA_TYPE)(NULL|NOT NULL)
CONSTRAINT(CONSTANT_NAME) DEFAULT (DEFAULT_VALUE)

--Dropping a constraint
ALTER TABLE(TABLE_NAME)
DROP CONSTRAINT(CONSTRAINT_NAME)

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
 
 --SELF JOIN
 
 
 
 
 


