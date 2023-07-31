SetUp Script creates tables for the database

We manually populated the database by importing the excel files in Microsoft Sql Server Management Studio
All tables can be found in the Data folder
    - We used the import/export wizard in sql to populate the tables
    - Right Click the database in Microsoft Sql Server Management Studio
    - Task -> Import Data
    - Data source: Microsoft Excel
    - Select the table -> Excel Version 2016 -> Next
    - .NET Framework Data Provider for SqlServer
    

Our application is run through Visual Studio 2022.
    - You may have to change the string for the value: SqlConnection con
    - Here is an example: SqlConnection con = new SqlConnection("Data Source=(localdb)\\MSSQLLocalDb;Initial Catalog=MovieAppDb;Integrated Security=True");
    - The file can be found in DatabaseSQLMovieApp