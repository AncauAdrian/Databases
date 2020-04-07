CREATE DATABASE Faculty1
GO

USE Faculty1
GO


CREATE TABLE Groups(
Gid int primary key,
Nofs int not null)

create table Teachers(
Tid int primary key identity,
Name varchar(50),
DomainOfi varchar(50) default 'Computer Science')

create table Students(
Sid int primary key,
Name varchar(50) not null,
Surname varchar(50),
Gid int foreign key REFERENCES Groups(Gid))

create table Courses(
Sid int foreign key References Students(Sid),
Tid int foreign key References Teachers(Tid),
NameCourse varchar(50),
Date DATE,
NrOfCredits int check(NrOfCredits >= 3 AND NrOfCredits <=7),
CONSTRAINT pk_Courses primary key(Sid, Tid))

create table Cards(
Cid int foreign key references Students(Sid),
EmissionD DATE,
Validated bit,
constraint pk_Cards primary key(Cid))


CREATE DATABASE Lab1
GO

USE Lab1
GO

create table Registration(
VIN varchar(50) foreign key references Vehicle(VIN),
RegNumber varchar(50),
constraint pk_Refistration primary key(VIN))

create table ItpStation(
Sid int primary key,
Name varchar(50))

create table Itp(
VIN varchar(50) foreign key references Vehicle(VIN),
Sid int foreign key references ItpStation(Sid),
ValidUntil date,
constraint pk_Itp primary key(VIN))

create table Roviniete(
VIN varchar(50) foreign key references Vehicle(VIN),
ValidUntil date,
constraint pk_Roviniete primary key(VIN))

create table TaxOwned(
VIN varchar(50) foreign key references Vehicle(VIN),
Tax int,
constraint pk_TaxOwned primary key(VIN))

create table InsuranceBroker(
Iid int primary key,
Name varchar(50))

create table Insurance(
VIN varchar(50) foreign key references Vehicle(VIN),
Iid int foreign key references InsuranceBroker(Iid),
constraint pk_Insurance primary key(VIN))

create table Driver(
Did int primary key,
Age int,
Name varchar(50))

create table DrivenBy(
VIN varchar(50) foreign key References Vehicle(VIN),
Did int foreign key References Driver(Did),
CONSTRAINT pk_DrivenBy primary key(VIN, Did))

create table VehicleIdBook(
VIN varchar(50) foreign key references Registration(VIN),
color varchar(50),
WheelSizes varchar(50),
HP int,
length int,
width int,
height int,
CONSTRAINT pk_VehicleIdBook primary key(VIN))