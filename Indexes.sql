create unique index ADMIN_PK on Admin(
adminId ASC)

create unique index CINEMAHALL_PK on CinemaHall(
hallName ASC)

create unique index MOVIE_PK on Movie(
movieId ASC)

create unique index Seat_PK on Seat(
seatId ASC,
showId ASC)

create index BOOK_FK on Seat(
clientId ASC)

create index ASSOCIATES_FK on Seat(
showId ASC)

create unique index SHOW_PK on Showtime(
showId ASC)

create index PLAY_FK on Showtime(
movieId ASC)

create unique index DISPLAY_FK on Showtime(
hallName ASC)

create unique index USER_PK on Client(
clientId ASC)
