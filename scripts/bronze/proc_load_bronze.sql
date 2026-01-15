==============================================================================================
Stored procedure: load bronze layer (source -> bronze)
==============================================================================================
Script purpose: 
    This stored procedure loads data into the 'bronze' schema from external csv files,
    it performs the following actions:
    - truncate the bronze table before loading data.
    - uses the 'bulk insert' command to load data from csv files to bromze tables.

Parameters:
    None.
    This stored procedure does not accept any parameter or return values.

Usage example:
    exec bronze.load_bronze;
==============================================================================================

create or alter procedure bronze.bronze_load AS

begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	begin try
		set @batch_start_time = GETDATE();
		print '====================================================='
		print 'loading bronze layer';
		print '=====================================================';

		print '-----------------------------------------------------';
		print 'loading crm tables';
		print '-----------------------------------------------------';

		set @start_time = GETDATE();
		print '>> truncating table: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;
		print '>> inserting data into: bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'C:\Users\ADMIN\Desktop\Data Engineering\1. SQL Data Warehouse (Baraa Youtube)\SQL DW Project\datasets\source_crm\cust_info.csv'
		with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			 );
		set @end_time = GETDATE();
		print '>> load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar ) + ' seconds';
		print '>> --------------';



		set @start_time = GETDATE();
		print '>> truncating table: bronze.crm_prod_info';
		truncate table bronze.crm_prod_info;
		print '>> inserting data into: bronze.crm_prod_info';
		bulk insert bronze.crm_prod_info
		from 'C:\Users\ADMIN\Desktop\Data Engineering\1. SQL Data Warehouse (Baraa Youtube)\SQL DW Project\datasets\source_crm\prd_info.csv'
		with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			 );
		set @end_time = GETDATE();
		print '>> load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar ) + ' seconds';
		print '>> --------------';



		set @start_time = GETDATE();
		print '>> truncating table: bronze.crm_sales_details';
		truncate table bronze.crm_sales_details;
		print '>> inserting data into: bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'C:\Users\ADMIN\Desktop\Data Engineering\1. SQL Data Warehouse (Baraa Youtube)\SQL DW Project\datasets\source_crm\sales_details.csv'
		with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			 );
		set @end_time = GETDATE();
		print '>> load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar ) + ' seconds';
		print '>> --------------';


		print '-----------------------------------------------------';
		print 'loading erp tables';
		print '-----------------------------------------------------';


		set @start_time = GETDATE();
		print '>> truncating table: bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;
		print '>> inserting data into: bronze.erp_cust_az12';
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\ADMIN\Desktop\Data Engineering\1. SQL Data Warehouse (Baraa Youtube)\SQL DW Project\datasets\source_erp\CUST_AZ12.csv'
		with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			 );
		set @end_time = GETDATE();
		print '>> load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar ) + ' seconds';
		print '>> --------------';


		set @start_time = GETDATE();
		print '>> truncating table: bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101;
		print '>> inserting data into: bronze.erp_loc_a101';
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\ADMIN\Desktop\Data Engineering\1. SQL Data Warehouse (Baraa Youtube)\SQL DW Project\datasets\source_erp\LOC_A101.csv'
		with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			 );
		set @end_time = GETDATE();
		print '>> load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar ) + ' seconds';
		print '>> --------------';


		set @start_time = GETDATE();
		print '>> truncating table: bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2;
		print '>> inserting data into: bronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\ADMIN\Desktop\Data Engineering\1. SQL Data Warehouse (Baraa Youtube)\SQL DW Project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			 );
		set @end_time = GETDATE();
		print '>> load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar ) + ' seconds';
		print '>> --------------';


		set @batch_end_time = GETDATE();
		print '=============================================='
		print 'loading bronze layer is completed';
		print '   - total load duartion: ' + cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + ' seconds';
		print '=============================================='
	end try
	begin catch
		print '=============================================='
		print 'error occured during loading bromze layer'
		print 'error message' + error_message();
		print 'error message' + cast(error_number() as nvarchar);
		print 'error message' + cast(error_state() as nvarchar);
		print '=============================================='
	end catch
end

--exec bronze.bronze_load
