use Lab5
go


CREATE TABLE Students(-- Ta
Sid INT PRIMARY KEY IDENTITY, -- aid
Name VARCHAR(50),
Age INT, -- a2
MajorId INT UNIQUE)

CREATE TABLE Exams(-- Tb
Pid INT PRIMARY KEY IDENTITY, -- bid
Subject VARCHAR(50),
Teacher VARCHAR(50),
Mark INT) --b2

CREATE TABLE Distributions(-- Tc
Did INT PRIMARY KEY IDENTITY, -- cid
Cid INT FOREIGN KEY REFERENCES Students(Sid), -- aid
Pid INT FOREIGN KEY REFERENCES Exams(Pid) -- bid
)


insert into Students values ('Adrian', 18, 1)
insert into Students values ('Cristi', 20, 2)
insert into Students values ('Andrei', 19, 3)
insert into Students values ('Gheorghe', 21, 4)
insert into Students values ('Ioan', 18, 5)
insert into Students values ('Alexandru', 18, 6)
insert into Students values ('Andreea', 19, 7)

insert into Exams values ('Math', 'Stefan', 10)
insert into Exams values ('English', 'Andreea', 8)
insert into Exams values ('English', 'Andreea', 5)
insert into Exams values ('Math', 'Stefan', 3)
insert into Exams values ('Math', 'Stefan', 4)
insert into Exams values ('Computer Science', 'Mihai', 9)
insert into Exams values ('Biology', 'Raluca', 7)
insert into Exams values ('Math', 'Stefan', 5)
insert into Exams values ('Math', 'Stefan', 6)
insert into Exams values ('Computer Science', 'Mihai', 10)

insert into Distributions values (1, 1)
insert into Distributions values (1, 2)
insert into Distributions values (2, 3)
insert into Distributions values (2, 4)
insert into Distributions values (3, 5)
insert into Distributions values (4, 6)
insert into Distributions values (4, 7)
insert into Distributions values (5, 8)
insert into Distributions values (6, 9)
insert into Distributions values (7, 10)

select * from Students
select * from Exams
select * from Distributions

-- this is where the fun begins


IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'N_idx_Subject')
 DROP INDEX N_idx_Subject ON Exams;
GO

select * from Students order by Sid			-- clustered index scan, Sid primary key
select * from Students order by MajorId		-- non clustered index scan
select * from Students order by Age			-- non clustered index scan

-- clustered index scan / key lookup
select * from Exams order by Mark

-- clustered index seek
select * from Exams where Pid > 5

-- Create a nonclustered index called N_idx_Subject on the Presents table using the Color column.
CREATE NONCLUSTERED INDEX N_idx_Subject ON Exams(Subject);
GO

select * from Students order by Sid			-- clustered index scan, Sid primary key
select * from Students order by MajorId		-- non clustered index scan
select * from Students order by Age			-- non clustered index scan
select * from sys.indexes
select name from sys.indexes




IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'N_idx_Mark')
 DROP INDEX N_idx_Mark ON Exams;
GO

-- Create a nonclustered index called N_idx_Price on the Presents table using the Price column.
CREATE NONCLUSTERED INDEX N_idx_Mark ON Exams(Mark);
GO



----------------------- CERINTA A ----------------

-- clustered index scan
select * from Exams where Mark = 10

-- clustered index seek
select * from Exams where Pid > 1

-- index seek non-clustered
select Mark from Exams where Mark > 5

-- index scan non-clustered
select Mark from Exams


DROP INDEX N_idx_Mark ON Exams;

------------- CERINTA B ------------

select e.Subject, e.Mark -- cost 0.003293
from Exams e
where e.Mark > 5


CREATE NONCLUSTERED INDEX N_idx_Exam ON Exams(Mark, Subject);
GO

select e.Subject, e.Mark   -- cost 0.003125
from Exams e
where e.Mark > 5


DROP INDEX N_idx_Exam on Exams
------------ CERINTA C --------------

create view test
as
	select s.Name, s.Age, e.Teacher, e.Subject, e.Mark
	from Students s INNER JOIN Distributions d ON s.Sid=s.Sid
	INNER JOIN Exams e ON e.Pid=e.Pid
	Where Age BETWEEN 18 and 20 OR Mark>5
go

-- usually we apply indexes on fields used by where or order by/group by
-- in this case we apply on Name

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'N_idx_Name')
 DROP INDEX N_idx_Name ON Students;
GO

select * from test    --- 0.0120428

CREATE NONCLUSTERED INDEX N_idx_Name ON Students(Name, Age);
GO

select * from test    --- 0.000418







EXEC sp_helpindex 'Students'







-- check the indexes (nonclustered) for the database used
SELECT TableName = t.name, IndexName = ind.name, IndexId = ind.index_id, ColumnId = ic.index_column_id,
 ColumnName = col.name, ind.*, ic.*, col.*
FROM sys.indexes ind
INNER JOIN sys.index_columns ic ON ind.object_id = ic.object_id and ind.index_id = ic.index_id
INNER JOIN sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id
INNER JOIN sys.tables t ON ind.object_id = t.object_id
WHERE ind.is_primary_key = 0 AND ind.is_unique = 0 AND ind.is_unique_constraint = 0
 AND t.is_ms_shipped = 0
ORDER BY t.name, ind.name, ind.index_id, ic.index_column_id;

-- all the indexes from table Students
select i2.name, i1.user_scans, i1.user_seeks, i1.user_updates,i1.last_user_scan,i1.last_user_seek,
i1.last_user_update
from sys.dm_db_index_usage_stats i1
inner join sys.indexes i2 on i1.index_id = i2.index_id
where i1.object_id = OBJECT_ID('Students') and i1.object_id = i2.object_id