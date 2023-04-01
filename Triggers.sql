

CREATE TRIGGER trSeat on Seat
   AFTER  INSERT 
   AS BEGIN 
   declare @numrows int,@numnull int,@errno int,@errmsg varchar(255)
   select @numrows = @@ROWCOUNT
   if @numrows = 0 return
   if UPDATE(clientId)
   begin
		if(select count(*) from client m1, inserted m2 
			where m1.clientId = m2.clientId) != @numrows
				begin
					select @errno = 50002,@errmsg = 'Parent doesnt not exist in "client", can not create child in seat'
						goto error
				end
	end
	return

	error:
	raiserror (@errno,-1,-1,@errmsg)
	rollback transaction
	end
go


	

CREATE TRIGGER trShowtime on Showtime
   AFTER  INSERT 
   AS BEGIN 
   declare @numrows int,@numnull int,@errno int,@errmsg varchar(255)
   select @numrows = @@ROWCOUNT
   if @numrows = 0 return
   if UPDATE(hallName)
   begin
		if(select count(*) from CinemaHall m1, inserted m2 
			where m1.hallName = m2.hallName) != @numrows
				begin
					select @errno = 50002,@errmsg = 'Parent doesnt not exist in "cinemahall", can not create child in showtime'
						goto error
				end
	end
	return

	error:
	raiserror (@errno,-1,-1,@errmsg)
	rollback transaction
	end
go


CREATE TRIGGER trrSeat on seat
   AFTER  UPDATE 
   AS BEGIN 
   declare @numrows int,@numnull int,@errno int,@errmsg varchar(255)
   select @numrows = @@ROWCOUNT
   if @numrows = 0 return
   if UPDATE(showId)
   begin
		if(select count(*) from Showtime m1, inserted m2 
			where m1.showId = m2.showId) != @numrows
				begin
					select @errno = 50002,@errmsg = 'Parent doesnt not exist in "cinemahall", can not create child in showtime'
						goto error
				end
	end
	return

	error:
	raiserror (@errno,-1,-1,@errmsg)
	rollback transaction
	end