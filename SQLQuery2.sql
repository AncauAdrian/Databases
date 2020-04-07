use Faculty1
go

insert into Groups(Gid,Nofs) values (921, 24),(911,28)
insert into Groups(Gid) values (925),(927),(924)
insert into Students  values (1,'Ana','Maria',924)
insert into Students  values (2,'Andrei','Hulea',9999) -- integrity constraint

-- if sid is identity
insert into Students(Name,Surname,Gid) values ('Ioana','Baciu',921)



update Groups
set Nofs = 10
where Gid = 911

update Students
set Name = 'test', Gid = 911
where Surname like 'B%'or Mark in (7,8,10)

update Students
set Name = 'Marcel', Mark = 10
where Mark is not null and Mark between 5 and 9

-- delete everything from groups
delete
from Groups

delete
from Students
where Name like 'A%'

delete 
from Students
where Mark < 5

select * from Students