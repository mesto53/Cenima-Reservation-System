
--ADMIN TABLE--
create table Admin (
   adminId      integer not null,
   password		varchar(30)	null,
   --key constraints
   primary key(adminId)
)
go


--CLIENT TABLE--
create table Client (
   clientId      integer not null,
   name         varchar(30) null,
   address      varchar(30) null,
   phone        varchar(20) null,
   email        varchar(30) null,
   -- key constraints 
   primary key (clientId)
)
go

--MOVIE TABLE--
create table Movie (
   movieId      integer     not null,
   title	    varchar(30)  null,
   description  varchar(1024)  null,
   releaseDate	date	 null,
   genre		varchar(30) null,
   -- key constraints 
   primary key (movieId)
)
go

--CINEMAHALL--
create table CinemaHall(
	hallName	varchar(20)		not null,
	totalSeats	integer		null,
	start		integer null,
	--key constraints
	primary key(hallName)
)
go


--ShowTime--
create table Showtime (
   showId        char(10)     not null,
   movieId       integer     not null,
   hallName      varchar(20)  not null,
   showDate      date    null,
   startDate	time null,
   endDate		time null,
   -- key constraints 
   primary key (showId),
   foreign key (movieId)  
	references Movie(movieId),
	foreign key (hallName) references CinemaHall(hallName)
)
go



--SEAT TABLE--
create table Seat (
   seatId       integer not null,
   clientId       integer not null,
   showId       char(10)  not null,
   -- key constraints 
   primary key (seatId,showId),
   foreign key (showId) 
   references Showtime(showId),
   foreign key (clientId)
   references Client(clientId)
)
go

