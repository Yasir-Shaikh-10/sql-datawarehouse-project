/*
====================================================================
Create Database and Schema
====================================================================
Script Purpose:
    This script creates a new databse named 'DataWarehosue' after checking if it already exists.
    If the databse exists, it is dropeed and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.

Warning:
    Running this script will drop the enetire 'DtaaWarehouse' database if it exists.
    All the data in the database will be permanently deleted. Proceed with caution
    and ensure you have the proper backups before running this script.
*/


use master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse
END;
GO

-- create the 'DataWarehouse' database
create database DataWarehouse;
GO
  
use DataWarehouse;
GO

-- create Schemas
create schema bronze;
GO
create schema silver;
GO
create schema gold;
GO
