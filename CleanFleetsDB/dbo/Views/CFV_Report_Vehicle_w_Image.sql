


CREATE VIEW [dbo].[CFV_Report_Vehicle_w_Image]
AS
SELECT     TOP (100) PERCENT dbo.CF_Vehicles.IDVehicles, ISNULL(dbo.CFV_Images_Default.Image, '~/images/1pix.gif') AS Expr1, dbo.CF_Profile_Account.AccountName, 
                      dbo.CF_Profile_Terminal.TerminalName, dbo.CF_Profile_Fleet.FleetName, dbo.CF_Vehicles.UnitNo, dbo.CF_Vehicles.ChassisVIN, 
                      dbo.CF_Vehicles.GrossVehicleWeight,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_5
                            WHERE      (dbo.CF_Vehicles.IDChassisModelYear = IDOptionList)) AS ChassisModelYear,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List
                            WHERE      (dbo.CF_Profile_Fleet.IDRuleCode = IDOptionList)) AS RuleCode,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_3
                            WHERE      (dbo.CF_Vehicles.IDCARBGroup = IDOptionList)) AS CARBGroup, dbo.CF_Vehicles.IDCARBGroup, dbo.CF_Vehicles.PlannedComplianceDate, 
                          (SELECT	DisplayValue
							FROM		dbo.CF_Option_List
							WHERE		dbo.CF_Vehicles.IDWeightDefinition = IDOptionList) AS WeightDefinition,
						  (SELECT	DisplayValue
							FROM		dbo.CF_Option_List
							WHERE		dbo.CF_Vehicles.IDSpecialProvision = IDOptionList) AS SpecialProvision,
                      dbo.CF_Vehicles.BackupStatusDate, dbo.CF_Vehicles.ActualComplianceDate, dbo.CF_Vehicles.RetireStatusDate, dbo.CFV_Images_Default.IDImages, 
                      ISNULL(dbo.CFV_Images_Default.Image, '~/images/noimage.gif') AS Image, dbo.CF_Profile_Fleet.IDProfileFleet,
                          (SELECT dbo.GetIDOptionListRecordValue(dbo.CF_Vehicles.IDVehicleStatus) AS VehicleStatus) AS VehicleStatus
FROM         dbo.CF_Vehicles INNER JOIN
                      dbo.CF_Profile_Account INNER JOIN
                      dbo.CF_Profile_Terminal ON dbo.CF_Profile_Account.IDProfileAccount = dbo.CF_Profile_Terminal.IDProfileAccount INNER JOIN
                      dbo.CF_Profile_Fleet ON dbo.CF_Profile_Fleet.IDProfileTerminal = dbo.CF_Profile_Terminal.IDProfileTerminal ON 
                      dbo.CF_Vehicles.IDProfileFleet = dbo.CF_Profile_Fleet.IDProfileFleet LEFT OUTER JOIN
                      dbo.CFV_Images_Default ON dbo.CF_Vehicles.IDVehicles = dbo.CFV_Images_Default.IDVehicles



