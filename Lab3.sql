use Lab1
go


create procedure V1 as
	alter table Driver alter column Age smallint
go

create procedure R1 as
	alter table Driver
	alter column Age integer
go

create procedure V2 as
	alter table InsuranceBroker add PhoneNr varchar(11)
go

create procedure R2 as
	alter table InsuranceBroker drop column PhoneNr
go

create procedure V3 as
	alter table Driver add constraint df_Driver default 18 for Age
go

create procedure R3 as
	alter table Driver drop Constraint df_Driver
go

create procedure V4 as
	create table Ticket(
	Tid int not null,
	Amount int,
	Constraint pk_Ticket primary key(Tid))
go

create procedure R4 as
	alter table Ticket drop constraint pk_Ticket;
	drop table Ticket;
go

create procedure V5 as
	alter table InsuranceBroker add constraint uq_Driver unique(PhoneNr)
go

create procedure R5 as
	alter table InsuranceBroker drop constraint uq_Driver
go

create procedure V6 as
	alter table Ticket add VIN varchar(50) not null;
	alter table Ticket add constraint fk_Ticket foreign key(VIN) references Vehicle(VIN)
go

create procedure R6 as
	alter table Ticket drop constraint fk_Ticket
	alter table Ticket drop column VIN
go

create procedure V7 as
	create table Mechanic(
	Mid int not null,
	Name varchar(50),
	constraint pk_Mechanic primary key(Mid))
go

create procedure R7 as
	drop table Mechanic
go


create table Version(
Verid int not null,
VersionNr int,
constraint pk_Version primary key(Verid))

insert into Version values(1, 0)
go


create procedure Main @version int as
	if @version > 7 or @version < 0
	begin
		raiserror(N'Invalid version %d', 10, 1, @version);
		return
	end

	declare @curversion int = (select VersionNr from Version)
	if @version = @curversion
	begin
		raiserror(N'Already at version %d', 10, 1, @version);
		return
	end
		

	declare @s varchar(50)

	if @version < @curversion
	begin
		while @version < @curversion
		begin 
			set @s = 'R' + Convert(varchar, @curversion)
			execute @s
			print 'Executing ' + @s
			set @curversion = @curversion - 1
		end
		update Version
		set VersionNr = @curversion
		where Verid = 1
		print 'Curent verion: ' + Convert(varchar, @curversion)
	end
	else
	begin
		while @version > @curversion
		begin 
			set @curversion = @curversion + 1
			set @s = 'V' + Convert(varchar, @curversion)
			execute @s
			print 'Executing ' + @s
		end
		update Version
		set VersionNr = @curversion
		where Verid = 1

		print 'Curent verion: ' + Convert(varchar, @curversion)
	end
go

execute Main 0
execute Main 7
execute Main 10
execute Main -1

select * from Version
select * from Driver

update Version
set VersionNr = 0
where Verid = 1