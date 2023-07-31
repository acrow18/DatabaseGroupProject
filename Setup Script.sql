USE [MovieAppDatabase]; -- Your database here.

/*********************
 * Drop Tables
 *********************/

IF SCHEMA_ID(N'Movies') IS NULL
   EXEC(N'CREATE SCHEMA [Movies];');
GO

--DROP TABLE IF EXISTS Movies.Theater;
--DROP TABLE IF EXISTS Movies.ShowingRoom;
--DROP TABLE IF EXISTS Movies.ShowingMovie;
--DROP TABLE IF EXISTS Movies.MovieDetails;
--DROP TABLE IF EXISTS Movies.MovieReview /* NOT SURE ABOUT THIS ONE */
DROP TABLE IF EXISTS Movies.ShowingMovie;
DROP TABLE IF EXISTS Movies.MovieDetails;
DROP TABLE IF EXISTS Movies.ShowingRoom;
DROP TABLE IF EXISTS Movies.Theater;
GO

/******************
 * Create Tables
 ******************/

CREATE TABLE Movies.Theater
(
   TheaterID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
   TheaterName NVARCHAR(64) NOT NULL UNIQUE,
   Zipcode INT NOT NULL,
   Street NVARCHAR(64) NOT NULL,
   [State] NVARCHAR(64) NOT NULL,
);

CREATE TABLE Movies.ShowingRoom
(
   RoomID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
   TheaterID INT NOT NULL FOREIGN KEY
      REFERENCES Movies.Theater(TheaterID),
   Capacity INT NOT NULL
);

CREATE TABLE Movies.MovieDetails
(
   MovieDetailsID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
   MovieName NVARCHAR(1024) NOT NULL,
   Review NVARCHAR(1024) NOT NULL,
   [Description] NVARCHAR(1024) NOT NULL,
   Studio NVARCHAR(64) NOT NULL,
   MPAARating NVARCHAR(64) NOT NULL,
   Genre NVARCHAR(64) NOT NULL,
);

CREATE TABLE Movies.ShowingMovie
(
   MovieID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
   RoomID INT NOT NULL FOREIGN KEY
      REFERENCES Movies.ShowingRoom(RoomID),
	MovieDetailsID INT NOT NULL FOREIGN KEY
		REFERENCES Movies.MovieDetails(MovieDetailsID),
   TicketPrice DECIMAL(4,2) NOT NULL,
   TicketsSold INT NOT NULL,
   StartTime DATETIME UNIQUE,
   EndTime DATETIME UNIQUE, 

   UNIQUE(StartTime, EndTime)
);


