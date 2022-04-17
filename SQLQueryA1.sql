create database Spotify;
use Spotify;


create table Artists(
Id int primary key identity,
Name nvarchar(50),
PopularReleases nvarchar(50)
)


create table Albums(
Id int primary key identity,
Name nvarchar(50),
ArtistId int references Artists (Id)
)


create table Musics(
Id int primary key identity,
Name nvarchar(50),
TotalSecond float,
ListenerCount int,
AlbumId int references Albums (Id)
)
alter table Musics 
add IsDeleted bit

insert into Artists values ('Pop Smoke', 'Dior'), ('Lil Tjay' , 'Zoo York') 
insert into Albums values ('Meet the Woo', 1) , ('True 2 Myself' ,2)
insert into Musics values ('War' , 3.26 , 70000000, 1) , ('In My Head' , 3.17 , 6500000, 2)


select from * Artists 
select from * Albums 
select from * Musics


-- Query 1 :

create view GetMusicInfo
as
select m.name 'Music Name' , m.TotalSecond,  ar.name 'Artist Name' , al.name 'Album Name'
from Artists as ar
join Albums as al on ar.Id = al.ArtistId 
join Musics as m on  al.Id = m.AlbumId

select * from GetMusicInfo


-- Query 2 :

create view GetAlbumInfo
as
select count(m.name) 'Music Count', al.name 'Album Name'
from Musics as m
join Albums as al on m.AlbumId = al.Id
group by al.name


select  * from GetAlbumInfo


-- Query 3 :

create procedure GetMusicInfos ( @ ListenerCount int , @ Search nvarchar)
as
select m.name 'Music Name' , m.TotalSecond 'Total Second', al.name 'Album Name ' , ar.name ' Artist Name'  
from Artists as Ar
join Albums as al on ar.AlbumId = al.Id
join Musics as m on al.MusicId = m.Id
where ListenrCount > @ListenerCount And (@Search, M.Name) > 0

exec GetMusicInfos 70000000 , 'asdfg'


-- Query 4 :

create trigger DeletedMusics
on Musics
instead of delete
as
begin
	Update Musics set IsDeleted = 1 where Id = (Select Id from deleted Musics)
end

