-- Description: Show the percentage of capacity in a specific movie theater on specific days, ranking them by the most capacity to the least
DECLARE @theaterName NVARCHAR(64);
DECLARE @startTime DATETIME;
--DECLARE @endTime DATETIME;

SET @theaterName = N'47th Street Theater';	-- EXAMPLE
SET @startTime = '4/26/2023 00:00';			-- EXAMPLE
--SET @endTime = @startTime + '23:59:59';

SELECT MD.MovieName, 
	(SM.TicketsSold / SR.Capacity) * 100 AS PercentageCapacity,
	SM.StartTime, SM.EndTime
FROM Movies.Theater T
	INNER JOIN Movies.ShowingRoom SR ON SR.TheaterID = T.TheaterID
	INNER JOIN Movies.ShowingMovie SM ON SM.RoomID = SR.RoomID
	INNER JOIN Movies.MovieDetails MD ON MD.ShowingID = SM.MovieID
WHERE T.TheaterName = @theaterName AND
	SM.StartTime = @startTime
GROUP BY MD.MovieName, SM.TicketsSold, SR.Capacity, SM.StartTime, SM.EndTime
ORDER BY PercentageCapacity DESC;
GO

-- Description: The average sales for movies based on genre at select theaters
DECLARE @theaterName NVARCHAR(64)
SET @theaterName = N'47th Street Theater';

SELECT MD.Genre, 
	AVG(SM.TicketsSold / SM.TicketPrice) AS AverageSales,
	COUNT(TicketsSold) AS TotalTicketsSold,
	COUNT(*) AS NumberOfMovies
FROM Movies.MovieDetails MD
	INNER JOIN Movies.ShowingMovie SM ON SM.MovieID = MD.ShowingID
	INNER JOIN Movies.ShowingRoom SR ON SR.RoomID = SM.RoomID
	INNER JOIN Movies.Theater T ON T.TheaterID = SR.TheaterID
WHERE T.TheaterName = @theaterName
Group BY MD.Genre, SM.TicketsSold, SM.TicketPrice
ORDER BY AverageSales DESC;
GO

-- Description: Worst performing theaters sorted by state
DECLARE @state NVARCHAR(64);

SET @state = N'New York';

SELECT T.TheaterName, T.TheaterID, 
	(SM.TicketPrice * SM.TicketsSold) AS Profit,
	RANK() OVER(
		PARTITION BY TheaterName
		ORDER BY (SM.TicketPrice * SM.TicketsSold) ASC
		) AS Ranking
FROM Movies.Theater T
	INNER JOIN Movies.ShowingRoom SR ON SR.TheaterID = T.TheaterID
	INNER JOIN Movies.ShowingMovie SM ON SM.RoomID = SR.RoomID
WHERE T.[State] = @state
GROUP BY T.TheaterName, T.TheaterID, Sm.TicketPrice, SM.TicketsSold
ORDER BY Ranking DESC

-- Description: Shows the top 10 largest earning movies for a specific theater, ranked from highest earning to least
DECLARE @theaterName NVARCHAR(64)

SET @theaterName =  N'47th Street Theater';

SELECT TOP 10
	MD.MovieName, MD.Genre,
	(SM.TicketPrice * SM.TicketsSold) AS TotalEarnings,
	SM.TicketsSold,
	Rank() OVER (ORDER BY (SM.TicketPrice * SM.TicketsSold) DESC) AS EarningRank
FROM Movies.Theater T
	INNER JOIN Movies.ShowingRoom SR ON SR.TheaterID = T.TheaterID
	INNER JOIN Movies.ShowingMovie SM ON SM.RoomID = SR.RoomID
	INNER JOIN Movies.MovieDetails MD ON MD.ShowingID = SM.MovieID
WHERE T.TheaterName = @theaterName
GROUP BY MD.MovieName, MD.Genre, SM.TicketPrice, SM.TicketsSold
ORDER BY TotalEarnings DESC