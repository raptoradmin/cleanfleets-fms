


CREATE VIEW [dbo].[CFV_Report_Vehicle]
AS
SELECT     TOP (100) PERCENT dbo.CF_Vehicles.IDVehicles, dbo.CF_Profile_Account.AccountName, dbo.CF_Profile_Terminal.TerminalName, dbo.CF_Profile_Fleet.FleetName, 
                      dbo.CF_Vehicles.UnitNo, dbo.CF_Vehicles.ChassisVIN, dbo.CF_Vehicles.GrossVehicleWeight, 
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_6
                            WHERE      (dbo.CF_Vehicles.IDSpecialProvision = IDOptionList)) AS SpecialProvision,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_5
                            WHERE      (dbo.CF_Vehicles.IDChassisModelYear = IDOptionList)) AS ChassisModelYear,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS _RuleCode
                            WHERE      (dbo.CF_Profile_Fleet.IDRuleCode = IDOptionList)) AS RuleCode,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_3
                            WHERE      (dbo.CF_Vehicles.IDCARBGroup = IDOptionList)) AS CARBGroup,
                          (SELECT	DisplayValue
							FROM		dbo.CF_Option_List AS _WeightDefinition
							WHERE		dbo.CF_Vehicles.IDWeightDefinition = IDOptionList) AS WeightDefinition,
                             dbo.CF_Vehicles.IDCARBGroup, ISNULL(dbo.CF_Vehicles.ActualInServiceDate, 
                      dbo.CF_Vehicles.EstimatedInServiceDate) AS InServiceDate, dbo.CF_Vehicles.PlannedComplianceDate, dbo.CF_Vehicles.BackupStatusDate, 
                      dbo.CF_Vehicles.ActualComplianceDate, dbo.CF_Vehicles.RetireStatusDate, dbo.CF_Vehicles.IDChassisModelYear,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_3
                            WHERE      (dbo.CF_Vehicles.IDChassisModelYear = IDOptionList)) AS Year, dbo.CF_Profile_Fleet.IDProfileFleet,
                          (SELECT     dbo.GetIDOptionListRecordValue(dbo.CF_Vehicles.IDVehicleStatus) AS VehicleStatus) AS VehicleStatus
FROM         dbo.CF_Vehicles INNER JOIN
                      dbo.CF_Profile_Account INNER JOIN
                      dbo.CF_Profile_Terminal ON dbo.CF_Profile_Account.IDProfileAccount = dbo.CF_Profile_Terminal.IDProfileAccount INNER JOIN
                      dbo.CF_Profile_Fleet ON dbo.CF_Profile_Fleet.IDProfileTerminal = dbo.CF_Profile_Terminal.IDProfileTerminal ON 
                      dbo.CF_Vehicles.IDProfileFleet = dbo.CF_Profile_Fleet.IDProfileFleet
ORDER BY dbo.CF_Vehicles.IDVehicles



