use Lab1
go

insert into Person values (1960720191453, 'Sergiu', 'Muntean')
insert into Person values (1910905405482, 'Andrei', 'Adam')
insert into Person values (5010514341824, 'Ionut', 'Basescu')
insert into Person values (2950818163870, 'Ana', 'Palinca')
insert into Person values (2840616410541, 'Diana', 'Apolzan')
insert into Person values (2870530110906, 'Maria', 'Hulea')
insert into Person values (1900218522996, 'Alexandru', 'Adam')
insert into Person values (1881003177030, 'Gheorghe', 'Muntean')
insert into Person values (1960525252078, 'Adrian', 'Nastase')
insert into Person values (6010330152028, 'Ana', 'Hulea')
insert into Person values (1851020030227, 'Ionut', 'Basescu')
insert into Person values (222, 'Delete', 'Me')
insert into Person values (223, 'Delete', 'Me')
insert into Person values (1, 'Update', 'Me')


insert into Vehicle values ('2FMDK3JC6ABB50129', 1960720191453, 'Ford', 'Edge')
insert into Vehicle values ('JH4DB1540NS801082', 1910905405482, 'Acura', 'Integra')
insert into Vehicle values ('1B7HF13Y2WJ198530', 1910905405482, 'Dodge Ram', '1500')
insert into Vehicle values ('1GTGK24R0XR710695', 1881003177030, 'GMC', 'Sierra')
insert into Vehicle values ('WAUJT58E13A290950', 1881003177030, 'Audi', 'A4')
insert into Vehicle values ('WAUAH74F09N027460', 2840616410541, 'Audi', 'A6')
insert into Vehicle values ('WVWRA01G8KW294974', 1960525252078, 'Volkswagen', 'Jetta')
insert into Vehicle values ('YV1612TB6F2303047', 1910905405482, 'Volvo', 'S60')
insert into Vehicle values ('YV1612TCXF2299318', 1960525252078, 'Volvo', 'S60')
--insert into Vehicle values ('Integrity Violation', 99, 'Invalid', 'CNP')
insert into Vehicle(VIN,CNP,Make) values ('Delete', 1960720191453, 'Volvo')
insert into Vehicle values ('YV1TS92D731311297', 2950818163870, 'Update', 'S80')

update Person
set Name = 'The Government', Surname = ''
where CNP between 0 AND 5

delete from Person
where CNP = 222 OR Name = 'Delete'

update Vehicle
set Make = 'Volvo'
where Make = 'Update' and Model is not null

delete from Vehicle
where VIN = 'Delete' and Model is null


select * from Person
select * from Vehicle

insert into Registration values ('1B7HF13Y2WJ198530', 'CJ01POP')
insert into Registration values ('WAUAH74F09N027460', 'AB99CAN')
insert into Registration values ('1GTGK24R0XR710695', 'MM57SUA')
insert into Registration values ('WVWRA01G8KW294974', 'B565AAA')
insert into Registration values ('YV1612TCXF2299318', 'CJ95BAC')
insert into Registration values ('JH4DB1540NS801082', 'AB30DRI')

update Registration
set RegNumber = 'None'
where VIN = 'JH4DB1540NS801082'


insert into VehicleIdBook(VIN,color,HP) values ('1B7HF13Y2WJ198530', 'red', 350)
insert into VehicleIdBook(VIN,color,HP) values ('WAUAH74F09N027460', 'white', 200)
insert into VehicleIdBook(VIN,color,HP) values ('1GTGK24R0XR710695', 'black', 300)
insert into VehicleIdBook(VIN,color,HP) values ('WVWRA01G8KW294974', 'red', 150)
insert into VehicleIdBook(VIN,color,HP) values ('YV1612TCXF2299318', 'red', 170)
insert into VehicleIdBook(VIN,color,HP) values ('JH4DB1540NS801082', 'blue', 70)

update VehicleIdBook
set color = 'blue'
where HP > 300

delete from VehicleIdBook
where HP <= 100

delete from Registration
where RegNumber = 'None'

select * from Registration
select * from VehicleIdBook

-- select only the vehicles that have the color red or HP greater or equal than 160
select * from VehicleIdBook
where color = 'red'
union
select * from VehicleIdBook
where HP >= 160



-- select the vehicles that are white or have over 300 hp, including duplicates
select * from VehicleIdBook
where color = 'white'
union ALL
select * from VehicleIdBook
where HP >= 300
order by HP

-- Print only the cnp and name of the persons with last name muntean
select P1.CNP, P1.Name
from Person P1
where Surname = 'Muntean'

-- Print the person that the surname starts with M and the Name starts with S
select P1.Surname, P1.Name
from Person P1
where Surname like 'M_%'
intersect
select P2.Surname, P2.Name
from Person P2
where Name like 'S_%'

-- Print the VIN, HP and color of the behicle that is red and has HP => 160
select V1.VIN, V1.HP, V1.color
from VehicleIdBook V1
where HP >= 160
intersect
select V2.VIN, V2.HP, V2.color
from VehicleIdBook V2
where color = 'red'


-- Same thing as before but print the vehicles that are red and have hp 150, 170 or 350
select V1.VIN, V1.HP, V1.color
from VehicleIdBook V1
where HP IN (150, 170, 350)
intersect
select V2.VIN, V2.HP, V2.color
from VehicleIdBook V2
where color = 'red'


-- print the vehicles that are not red and have hp 150, 170 or 350
select V1.VIN, V1.HP, V1.color
from VehicleIdBook V1
where HP IN (150, 170, 350)
except
select V2.VIN, V2.HP, V2.color
from VehicleIdBook V2
where color = 'red'


select P.Name, P.Surname, V.Make, V.Model
from Person P, Vehicle V
where P.CNP = V.CNP

-- practically only shows the people who own cars
select * from Vehicle V left outer join Person P ON
V.CNP = P.CNP

-- shows all the people even those who don't own cars
select * from Vehicle V right outer join Person P ON
V.CNP = P.CNP

-- shows all the people even those who don't own cars but places them at the end
select * from Vehicle V full outer join Person P ON
V.CNP = P.CNP

-- practically shows only the registered vehicles with their owners
select * from Vehicle V inner join Person P ON
V.CNP = P.CNP
inner join VehicleIdBook VB on VB.VIN = V.VIN 

-- shows all the vehicles and only people who own vehicles
select * from Vehicle V inner join Person P ON
V.CNP = P.CNP
full outer join VehicleIdBook VB on VB.VIN = V.VIN 

-- shows all the registered vehicles
select v.Make, v.Model
from Vehicle v
where v.VIN in (select v1.Vin from VehicleIdBook v1)


-- shows all the people who have registered cars
select p.Name, p.Surname
from Person p
where p.CNP in (select v.CNP
from Vehicle v
where v.VIN in (select v1.Vin from VehicleIdBook v1))


select v.VIN, v.Make, v.Model
from Vehicle v
where exists (select * from Person p where v.CNP = p.CNP)

-- car owners using exists
select p.Name, p.Surname
from Person p
where exists (select * from Vehicle v where v.CNP = p.CNP)

-- fancy way to select car owners and see the names and cars they own
select A.Name, A.Surname, A.Make, A.Model
from (select V.CNP, P.Name, P.Surname, V.Make, V.Model from Vehicle V left outer join Person P ON
V.CNP = P.CNP) A



select V.Make, V.Model from Vehicle V right outer join Person P ON
V.CNP = P.CNP
group by V.Make, V.Model


select AVG(HP)
from VehicleIdBook


-- How to get car with highest hp per person?

select p.Name, p.Surname
from Person p
where p.CNP in (select v.CNP
from Vehicle v
where exists (select v1.Vin, v1.HP from VehicleIdBook v1 where v.VIN = v1.VIN))



insert into Driver values (1, 20, 'Adrian')
insert into Driver values (2, 25, 'Andrei')
insert into Driver values (3, 45, 'George')
insert into Driver values (4, 18, 'Ioan')
insert into Driver values (5, 33, 'Constantin')
insert into Driver values (6, 21, 'Anca')
insert into Driver values (7, 65, 'Diana')
insert into Driver values (8, 50, 'Iulia')
insert into Driver values (9, 22, 'Tudor')
insert into Driver values (10, 19, 'Andrei')
insert into Driver values (11, 39, 'Adrian')

insert into DrivenBy values ('2FMDK3JC6ABB50129', 1)
insert into DrivenBy values ('1B7HF13Y2WJ198530', 2)
insert into DrivenBy values ('1B7HF13Y2WJ198530', 3)
insert into DrivenBy values ('1B7HF13Y2WJ198530', 4)
insert into DrivenBy values ('WAUAH74F09N027460', 1)
insert into DrivenBy values ('WAUAH74F09N027460', 5)
insert into DrivenBy values ('WAUAH74F09N027460', 6)
insert into DrivenBy values ('WAUAH74F09N027460', 7)
insert into DrivenBy values ('WAUAH74F09N027460', 8)
insert into DrivenBy values ('YV1612TB6F2303047', 9)
insert into DrivenBy values ('1GTGK24R0XR710695', 10)
insert into DrivenBy values ('1GTGK24R0XR710695', 11)
insert into DrivenBy values ('YV1612TB6F2303047', 12)

select * from Driver
select * from DrivenBy order by Did

select MAX(Did) from Driver

delete from Person where Name like 'Name%'

-- select vehicles and their drivers
select db.VIN, D.Did, D.Name, D.Age
from DrivenBy db inner join Driver D
on db.Did = D.Did

-- show vehicles that have drivers and show the average driver age for each one
select db.VIN, AVG(D.Age) as AverageAge
from DrivenBy db inner join Driver D
on db.Did = D.Did
group by db.VIN

-- show vehicles that have drivers and show the average driver age for each one but only those whose average is => 25
select db.VIN, AVG(D.Age) as AverageAge
from DrivenBy db inner join Driver D
on db.Did = D.Did
group by db.VIN
having AVG(D.Age) >= 25


-- View
select * from View_Vehicles
select * from View_Vehicles_And_Drivers
select * from View_Persons_And_Vehicles
