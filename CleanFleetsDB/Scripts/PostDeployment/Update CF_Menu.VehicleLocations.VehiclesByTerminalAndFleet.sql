UPDATE [CleanFleets].[dbo].[CF_Menu_Console]
   SET [DataNavigateUrlField] = '~/includes/reports_console/VehiclesByFleet.aspx'
   --,[DataTextField] = 'Vehicles by Terminal and Fleet'
WHERE DataTextField = 'Account Sites'
GO