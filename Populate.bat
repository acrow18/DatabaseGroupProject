REM Must change user!!!

REM create format file
bcp johnkeller.Movies.Theater format nul -f Theater.fmt -S "(localdb)\MSSQLLocalDb" -c -T

REM populate table
bcp johnkeller.Movie.Theater in "C:\<full path>\TheaterData.csv" -S "(localdb)\MSSQLLocalDb" -T -f Theater.fmt -h "CHECK_CONSTRAINTS"


REM create format file
bcp johnkeller.Movies.ShowingRoom format nul -f ShowingRoom.fmt -S "(localdb)\MSSQLLocalDb" -c -T

REM populate table
bcp johnkeller.Movie.ShowingRoom in "C:\<full path>\ShowingRoomData.csv" -S "(localdb)\MSSQLLocalDb" -T -f ShowingRoom.fmt -h "CHECK_CONSTRAINTS"


REM create format file
bcp johnkeller.Movies.MovieDetails format nul -f MovieDetails.fmt -S "(localdb)\MSSQLLocalDb" -c -T

REM populate table
bcp johnkeller.Movie.MovieDetails in "C:\<full path>\MovieData.csv" -S "(localdb)\MSSQLLocalDb" -T -f MovieDetails.fmt -h "CHECK_CONSTRAINTS"


REM create format file
bcp johnkeller.Movies.ShowingMovie format nul -f ShowingMovie.fmt -S "(localdb)\MSSQLLocalDb" -c -T

REM populate table
bcp johnkeller.Movie.ShowingMovie in "C:\<full path>\ShowingMovieData.csv" -S "(localdb)\MSSQLLocalDb" -T -f ShowingMovie.fmt -h "CHECK_CONSTRAINTS"

