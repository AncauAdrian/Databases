use Practice
go


create table S(
ID varchar(50) primary key,
A varchar(50),
B varchar(50),
C varchar(300),
D int,
E int,
F int
)

insert into S values ('t1', 'a1', 'b2', 'Şi abia plecă bătrânul... Ce mai freamăt, ce mai zbucium!', 0, 1, 0)
insert into S values ('t2', 'a1', 'b2', 'Codrul clocoti de zgomot şi de arme şi de bucium,', 1, 2, 1)
insert into S values ('t3', 'a1', 'b3', 'Iar la poala lui cea verde mii de capete pletoase,', 0, 3, 0)
insert into S values ('t4', 'a1', 'b3', 'Mii de coifuri lucitoare ies din umbra-ntunecoasă;', 2, 123, -1)
insert into S values ('t5', 'a1', 'b3', 'Călăreţii umplu câmpul şi roiesc după un semn', -1, 4, -1)

SELECT avg(E)
FROM S
group by Fhaving avg(E) < 10