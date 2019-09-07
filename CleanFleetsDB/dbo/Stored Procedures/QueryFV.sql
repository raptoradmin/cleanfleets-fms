CREATE PROCEDURE [dbo].[QueryFV] (@IDProfileAccount int, @SearchString as varchar(50)) AS
	SET NOCOUNT ON
	DECLARE @OriginalSearchString varchar(50)
	SELECT @OriginalSearchString = @SearchString
	SELECT @SearchString = UPPER(RTRIM(ISNULL(@SearchString,'%')))
	IF CHARINDEX('%', @SearchString) = 0 AND CHARINDEX('?', @SearchString) = 0 AND CHARINDEX('[', @SearchString) = 0
	BEGIN
		SELECT @SearchString = RTRIM(ISNULL(@SearchString,'')) + '%'
	END
	
	SELECT DISTINCT CF_Vehicles.*, CF_Engines.SerialNum, 
	  CF_Profile_Account.AccountName, CF_Profile_Terminal.TerminalName, CF_Profile_Fleet.FleetName,
	  CF_Profile_Terminal.IDProfileTerminal, CF_Profile_Account.IDProfileAccount,
	  @OriginalSearchString AS OriginalSearchString
	  FROM CF_Vehicles
	  LEFT JOIN CF_Engines ON CF_Vehicles.IDVehicles = CF_Engines.IDVehicles
	  -- AND CF_Engines.SerialNum LIKE @SearchString
	  LEFT JOIN CF_Profile_Fleet ON CF_Vehicles.IDProfileFleet = CF_Profile_Fleet.IDProfileFleet
	  LEFT JOIN CF_Profile_Terminal ON CF_Profile_Fleet.IDProfileTerminal = CF_Profile_Terminal.IDProfileTerminal
	  LEFT JOIN CF_Profile_Account ON CF_Profile_Terminal.IDProfileAccount = CF_Profile_Account.IDProfileAccount
	  WHERE ISNULL(@IDProfileAccount,0) IN (0, CF_Profile_Account.IDProfileAccount)
	  AND (
	   UPPER(CF_Vehicles.LicensePlateNo) LIKE @SearchString
	   OR UPPER(RTRIM(CF_Vehicles.LicensePlateState) + ' ' + RTRIM(CF_Vehicles.LicensePlateNo)) LIKE @SearchString
	   OR UPPER(RTRIM(CF_Vehicles.ChassisVIN)) LIKE @SearchString
	   OR CF_Vehicles.UnitNo LIKE @SearchString
	   OR CF_Engines.SerialNum LIKE @SearchString
	  )
	  ORDER BY CF_Vehicles.ModifiedDate DESC