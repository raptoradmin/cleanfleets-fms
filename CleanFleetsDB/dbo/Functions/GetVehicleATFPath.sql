CREATE FUNCTION [dbo].[GetVehicleATFPath](@IDVehicles uniqueidentifier) 
  RETURNS varchar(200)
  AS
  BEGIN
	DECLARE @ATFPath varchar(200)
	
	SELECT @ATFPath = RTRIM(ISNULL(CF_Profile_Account.AccountName,'NO ACCOUNT')) + ' / ' + 
	  RTRIM(ISNULL(CF_Profile_Terminal.TerminalName,'NO TERMINAL')) + ' / ' + 
	  RTRIM(ISNULL(CF_Profile_Fleet.FleetName,'NO FLEET')) + ' / Unit No ' + 
	  RTRIM(ISNULL(CF_Vehicles.UnitNo,'NO UNIT NO'))
	  FROM CF_Vehicles
	  LEFT JOIN CF_Profile_Fleet ON CF_Vehicles.IDProfileFleet = CF_Profile_Fleet.IDProfileFleet
	  LEFT JOIN CF_Profile_Terminal ON CF_Profile_Fleet.IDProfileTerminal = CF_Profile_Terminal.IDProfileTerminal 
	  LEFT JOIN CF_Profile_Account ON CF_Profile_Terminal.IDProfileAccount = CF_Profile_Account.IDProfileAccount
	  WHERE CF_Vehicles.IDVehicles = @IDVehicles
	  
	SELECT @ATFPath = ISNULL(@ATFPath,'Vehicle Not Found')
	RETURN @ATFPath
  END
