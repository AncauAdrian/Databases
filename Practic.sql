USE Practic
GO


create table TypesOfFireworks(
Tid int primary key,
Name varchar(50),
Description varchar(150))


create table FireworkProduct(
Fid int primary key,
Tid int foreign key references TypesOfFireworks(Tid),
Name varchar(50),
Duration int,
Color varchar(50))


create table Supplier(
Sid int primary key,
Name varchar(50),
Turnover int)

create table SuppliersAndProducts(
Sid int foreign key references Supplier(Sid),
Fid int foreign key references FireworkProduct(Fid),
Price int,
CONSTRAINT pk_SupppliersAndProducts primary key(Sid, Fid))

create table Event(
Eid int primary key,
Name varchar(50),
TimeDate date)

create table EventProductList(
Eid int foreign key references Event(Eid),
Fid int foreign key references FireworkProduct(Fid),
StartTime time,
CONSTRAINT pk_EventProductList primary key(Eid, Fid))

insert into TypesOfFireworks values (1, 'Firecrackers', 'Explodes and makes loud noises')
insert into TypesOfFireworks values (2, 'Smoke Bombs', 'Make a lot of smoke')
insert into TypesOfFireworks values (3, 'Ground Spinners', 'Spins a lot and shines')
insert into TypesOfFireworks values (4, 'Missiles and Rockets', 'The good stuff')


insert into FireworkProduct values (1, 1, 'Black Cats', 2, 'Blue')
insert into FireworkProduct values (2, 1, 'M-80', 3, 'Red and Blue')
insert into FireworkProduct values (3, 1, 'Lady Fingers', 2, 'Red')
insert into FireworkProduct values (4, 2, 'The Nazi', 15, 'Black')
insert into FireworkProduct values (5, 3, 'The carousel', 5, 'Yellow')
insert into FireworkProduct values (6, 4, 'The Apollo', 5, 'Green')
insert into FireworkProduct values (7, 4, 'The Explorer', 5, 'Green and Red')


insert into Supplier values (1, 'Firework Inc.', 100)
insert into Supplier values (2, 'Poppers Lmt.', 150)
insert into Supplier values (3, 'Boom Co.', 190)

insert into SuppliersAndProducts values (1, 1, 20)
insert into SuppliersAndProducts values (1, 2, 30)
insert into SuppliersAndProducts values (2, 3, 25)
insert into SuppliersAndProducts values (1, 4, 30)
insert into SuppliersAndProducts values (3, 5, 50)
insert into SuppliersAndProducts values (3, 6, 60)
insert into SuppliersAndProducts values (3, 7, 70)


insert into Event values (1, 'New Years Eve', '20200101')
insert into Event values (2, '1st of December', '20201201')

insert into EventProductList(Eid, Fid) values (1, 1)
insert into EventProductList(Eid, Fid) values (1, 2)
insert into EventProductList(Eid, Fid) values (1, 3)
insert into EventProductList(Eid, Fid) values (1, 4)
insert into EventProductList(Eid, Fid) values (1, 5)
insert into EventProductList(Eid, Fid) values (1, 6)
insert into EventProductList(Eid, Fid) values (1, 7)


insert into EventProductList(Eid, Fid) values (2, 1)
insert into EventProductList(Eid, Fid) values (2, 4)
insert into EventProductList(Eid, Fid) values (2, 5)
insert into EventProductList(Eid, Fid) values (2, 7)



go
create procedure AddProduct @supplierid int, @productid int, @price int as
	declare @counter int
	--set @counter = ( select COUNT(*) from SuppliersAndProducts where Sid = 1 and Fid = 1)

	select @counter = count(*) from SuppliersAndProducts where Sid = @supplierid and Fid = @productid
	print @counter

	if @counter = 0
	begin
		insert into SuppliersAndProducts values (@supplierid, @productid, @price)
	end
	else
	begin
		update SuppliersAndProducts set Price = @price where Sid = @supplierid and Fid = @productid
	end
go

execute AddProduct 1, 1, 9999
select * from SuppliersAndProducts
execute AddProduct 1, 1, 20

insert into FireworkProduct values (8, 4, 'TEST', 999, 'TEST')
select * from FireworkProduct
select COUNT(*) from SuppliersAndProducts where Sid = 1 and Fid = 8
execute AddProduct 1, 8, 200
select * from SuppliersAndProducts
delete from SuppliersAndProducts where Sid = 1 and Fid = 8
delete from FireworkProduct where Fid = 8


go
create view view_Event as
SELECT dbo.Event.Name
FROM  dbo.Event INNER JOIN
dbo.EventProductList ON dbo.Event.Eid = dbo.EventProductList.Eid INNER JOIN
dbo.FireworkProduct ON dbo.EventProductList.Fid = dbo.FireworkProduct.Fid
group by Event.Name
having count(Event.Name) = (select COUNT(*) from FireworkProduct)

go

select * from view_Event
