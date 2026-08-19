 -- Create login and user
CREATE LOGIN [finance_analyst] WITH PASSWORD = 'Finance@2024!Secure';
GO

USE CityRideDB;
CREATE USER [finance_analyst] FOR LOGIN [finance_analyst];

-- Grant read-only access
ALTER ROLE db_datareader ADD MEMBER [finance_analyst];
GO
