CREATE view schedule as
select 
	s.hallName as hallName,
	s.showDate as showDate,
	s.startDate as startDate,
	s.endDate as endDate
	from Showtime  s join movie m
	on
	s.movieID = m .movieId;
go

CREATE view movietimes as
select 
	s.movieId as movieId,
	s.showDate as showDate,
	s.startDate as startDate,
	s.endDate as endDate
	from Showtime  s
