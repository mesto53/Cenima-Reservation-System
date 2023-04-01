Create procedure viewMovies
as 
	begin transaction
	select * from Movie
go

Create procedure viewSeats
as 
	begin transaction
	select * from Seat
go

Create procedure viewCinemaHall
as 
	begin transaction
	select * from CinemaHall
go

Create procedure viewClients
as 
	begin transaction
	select * from Client
go


Create procedure viewShowTime
as 
	begin transaction
	select * from Showtime
go





create procedure bookseat
@cid int,@sid int,@shid int
as
	Begin transaction
	update Seat
	set clientId = @cid
	where clientId is null and seatId = @sid and showId = @shid
go

create procedure cancelBooking
@cid int,@sid int,@shid int
as
	Begin transaction
	update Seat
	set clientId = null
	where clientId is null and seatId = @sid and showId = @shid
go


Create procedure fillAdmin
as 
begin transaction
	insert into Admin values(1,'pass')
go


Create procedure fillCinemaHall
@nam varchar(20),@total int
as 
begin transaction
	insert into CinemaHall values(@nam,@total)
go


Create procedure fillClient
@fname varchar(20),@lname varchar(20),@pass varchar(20),@nb int
as
begin transaction
	declare @i int
	set @i = 4000
	if (0 in (select count(*) from Client))
		begin
		insert into Client values(@i,@fname,@lname,@pass,@nb)
		end
	else 
		begin
		set @i=1+(select clientId from Client)
		insert into Client values(@i,@fname,@lname,@pass,@nb)
	end
go



Create procedure fillSeat
@shId int
as
begin transaction
	declare @i int
	declare @j int
	set @i = (select c.start from CinemaHall c,Showtime s where s.showId = @shId and c.hallName = s.hallName)
	set @j = @i+ (select c.totalSeats from CinemaHall c,Showtime s where c.hallName = s.hallName and s.showId = @shId)
	while @i < @j
	begin
		insert into Seat values (@i,null,@shId)
		set @i = @i+1
	end
go




Create procedure fillShowTime
@movId int,@hName varchar(20),@sDate date  ,@stDate time,@eDate time 
as
begin transaction
	declare @i int
	set @i = 2000
	if (0 in (select count(*) from Showtime))
		begin
		insert into Showtime values(@i,@movId,@hName,@sDate,@stDate,@eDate)
		exec fillSeat @i
		end
	else 
		begin
		if 1=(select checking(@hName,@sDate,@sDate,@eDate) from Showtime)
			begin
				set @i = 1+(select showId from Showtime)
				insert into Showtime values(@i,@movId,@hName,@sDate,@stDate,@eDate)
				exec fillSeat @i
			end
		end
go



create procedure fillMovie
@t varchar(30) ,@d varchar(1024),@dat date,@g varchar(30)
as
declare @i int
set @i = 1000
	if (0 in (select count(*) from Movie))
		begin
		insert into Movie values(@i,@t,@d,@dat,@g)
		end
	else
		begin
		set @i=1+(select movieId from Movie)
		insert into Movie values(@i,@t,@d,@dat,@g)
		end
go


create procedure searchPhoneNb
@id int , @nb varchar(20) out
as
	begin
	select phone into nb
		from Client
	where clientId = @id
	end
go


create procedure countRes
@uid int
as
	begin
	select count(*)
	from Seat
	where clientId = @uid
end
go


--function
create function checking(@nam varchar(20),@d date,@st,@en time)
returns integer
begin
	declare cur cursor for
		select startDate,endDate from Showtime where hallName= @nam and date = @d
		declare @s time, @e time
open cur
	FETCH NEXT FROM cur  INTO @s,@e
	while @@FETCH_STATUS =0
		begin
			if (@st >= @s and @st <= @e) or (@st<=@s and @en >= @e) or @en <= @st
			begin
				close cur
				return 0
			end
		close cur
		end
	return 1
end
go


begin transaction
	update Seat set clientId = null where clientId=cid
	delete from Client where clientId =cid
end
go

--privilages
create LOGIN abou with password = '123'
Create user rabih for LOGIN abou

create role admin

grant all privileges on Movie to admin
grant all privileges on Showtime to admin
grant update(clientId) on Seat to admin
grant all privileges on Admin to admin
grant all privileges on CinemaHall to admin
grant select(phone) on Client to admin

grant admin to rabih