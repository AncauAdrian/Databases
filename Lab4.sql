use Lab1
go


insert into Tables values ('Person')
insert into Tables values ('Vehicle')
insert into Tables values ('Driver')
insert into Tables values ('DrivenBy')

select * from Tables

insert into Views values ('View_Vehicles')
insert into Views values ('View_Vehicles_And_Drivers')
insert into Views values ('View_Persons_And_Vehicles')

select * from Views

insert into Tests values ('delete_table')
insert into Tests values ('insert_table')
insert into Tests values ('select_view')

select * from Tests

insert into TestTables values (2, 1, 100, 1)
insert into TestTables values (2, 2, 100, 2)
insert into TestTables values (2, 3, 100, 3)
insert into TestTables values (2, 4, 100, 4)
insert into TestTables values (1, 4, 100, 5)
insert into TestTables values (1, 3, 100, 6)
insert into TestTables values (1, 2, 100, 7)
insert into TestTables values (1, 1, 100, 8)

select * from TestTables


insert into TestViews values (3, 1)
insert into TestViews values (3, 2)
insert into TestViews values (3, 3)

select * from TestViews



-- Testing
DECLARE @NoOFRows int
DECLARE @n int
DECLARE @t1 VARCHAR(50)
DECLARE @t2 VARCHAR(50)
DECLARE @t3 VARCHAR(50)

SELECT TOP 1 @NoOfRows = NoOfRows FROM dbo.TestTables WHERE TestID = 2 AND TableID = 1
SET @n = 1

DECLARE @d1 DATETIME
DECLARE @d2 DATETIME
DECLARE @d3 DATETIME
SET @d1 = GETDATE()

WHILE @n<@NoOfRows
BEGIN

	SET @t1 = 'Name' + CONVERT (VARCHAR(5), @n)
	SET @t2 = 'Surname' + CONVERT (VARCHAR(5), @n)

	INSERT INTO Person values (@n + 1000, @t1, @t2)

	SET @t1 = 'VIN' + CONVERT (VARCHAR(5), @n)
	SET @t2 = 'Make' + CONVERT (VARCHAR(5), @n)
	SET @t3 = 'Model' + CONVERT (VARCHAR(5), @n)
	INSERT INTO Vehicle Values(@t1, @n + 1000, @t2, @t3)

	SET @t2 = 'Name' + CONVERT (VARCHAR(5), @n)
	INSERT INTO Driver Values(@n + 100, 18, @t2)

	INSERT INTO DrivenBY Values(@t1, @n + 100)

	SET @n=@n+1
END


SET @n = @NoOFRows - 1
WHILE @n>0
BEGIN

    DELETE FROM DrivenBy where Did = @n + 100

	DELETE FROM Driver where Did = @n + 100

	DELETE FROM Vehicle where CNP = @n + 1000

	DELETE FROM Person where CNP = @n + 1000

	SET @n=@n-1
END

SET @d2=GETDATE()

declare @v1s DATETIME
declare @v1f DATETIME
declare @v2s DATETIME
declare @v2f DATETIME
declare @v3s DATETIME
declare @v3f DATETIME

set @v1s=GETDATE()
select * from View_Vehicles
set @v1f=GETDATE()

set @v2s=GETDATE()
select * from View_Persons_And_Vehicles
set @v2f=GETDATE()

set @v3s=GETDATE()
select * from View_Vehicles_And_Drivers
set @v3f=GETDATE()

SET @d3=GETDATE()

Print DATEDIFF(ms, @d1, @d3)

insert into TestRuns values ('Tested insert and delete x' + CONVERT (VARCHAR(5), @NoOFRows) + ' and views', @d1, @d3)

declare @id int
select @id = MAX(TestRunID) from TestRuns

insert into TestRunTables values(@id, 1, @d1, @d2)
insert into TestRunTables values(@id, 2, @d1, @d2)
insert into TestRunTables values(@id, 3, @d1, @d2)
insert into TestRunTables values(@id, 4, @d1, @d2)

insert into TestRunViews values (@id, 1, @v1s, @v1f)
insert into TestRunViews values (@id, 2, @v2s, @v2f)
insert into TestRunViews values (@id, 3, @v3s, @v3f)


select * from TestRuns

select * from TestRunTables
select * from TestRunViews