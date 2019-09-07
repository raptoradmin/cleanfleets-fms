


CREATE VIEW [dbo].[CFV_Vehicles]
AS
SELECT     CAST(dbo.CF_Vehicles.IDVehicles AS NVarChar(36)) AS IDVehicles, dbo.CF_Vehicles.IDModifiedUser, dbo.CF_Vehicles.EnterDate, dbo.CF_Vehicles.ModifiedDate, 
                      dbo.CF_Profile_Account.IDProfileAccount, dbo.CF_Profile_Account.AccountName, dbo.CF_Profile_Terminal.IDProfileTerminal, dbo.CF_Profile_Terminal.TerminalName, 
                      dbo.CF_Profile_Fleet.IDProfileFleet, dbo.CF_Profile_Fleet.FleetName, dbo.CF_Vehicles.IDEquipmentType,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List
                            WHERE      (dbo.CF_Vehicles.IDEquipmentType = IDOptionList)) AS EquipmentType, dbo.CF_Vehicles.IDEquipmentCategory,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_1
                            WHERE      (dbo.CF_Vehicles.IDEquipmentCategory = IDOptionList)) AS EquipmentCategory, dbo.CF_Vehicles.IDVehicleStatus,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_2
                            WHERE      (dbo.CF_Vehicles.IDVehicleStatus = IDOptionList)) AS VehicleStatus, dbo.CF_Vehicles.IDCARBGroup,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_3
                            WHERE      (dbo.CF_Vehicles.IDCARBGroup = IDOptionList)) AS CARBGroup, dbo.CF_Vehicles.IDChassisMake,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_4
                            WHERE      (dbo.CF_Vehicles.IDChassisMake = IDOptionList)) AS ChassisMake, dbo.CF_Vehicles.IDChassisModelYear,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_5
                            WHERE      (dbo.CF_Vehicles.IDChassisModelYear = IDOptionList)) AS ChassisModelYear,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_6
                            WHERE      (dbo.CF_Vehicles.IDSpecialProvision = IDOptionList)) AS SpecialProvision, dbo.CF_Vehicles.IDSpecialProvision, dbo.CF_Vehicles.LicensePlateState, 
                          
                      dbo.CF_Vehicles.LicensePlateNo, dbo.CF_Vehicles.ChassisVIN, dbo.CF_Vehicles.UnitNo, dbo.CF_Vehicles.Description, dbo.CF_Vehicles.AnnualMiles, 
                      dbo.CF_Vehicles.AnnualHours, dbo.CF_Vehicles.ActualMiles, dbo.CF_Vehicles.ActualHours, dbo.CF_Vehicles.GrossVehicleWeight,
                      (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS _WeightDefinition
                            WHERE      (dbo.CF_Vehicles.IDWeightDefinition = IDOptionList)) AS WeightDefinition,
                      dbo.CF_Vehicles.PlannedComplianceDate, dbo.CF_Vehicles.ActualComplianceDate, dbo.CF_Vehicles.BackupStatusDate, dbo.CF_Vehicles.RetireStatusDate, 
                      dbo.CF_Vehicles.Notes, dbo.CF_Vehicles.NotesCF, dbo.CF_Vehicles.EstReplacementCost, dbo.CF_Vehicles.PlannedRetirementDate, 
                      dbo.CF_Vehicles.ActualRetirementDate, dbo.CF_Vehicles.ChassisModel, ISNULL(dbo.CF_Vehicles.ActualInServiceDate, dbo.CF_Vehicles.EstimatedInServiceDate) 
                      AS InServiceDate, dbo.CF_Vehicles.ActualInServiceDate, dbo.CF_Vehicles.EstimatedInServiceDate, dbo.CF_Vehicles.LastOpacityTestDate
FROM         dbo.CF_Profile_Terminal INNER JOIN
                      dbo.CF_Profile_Account ON dbo.CF_Profile_Terminal.IDProfileAccount = dbo.CF_Profile_Account.IDProfileAccount INNER JOIN
                      dbo.CF_Profile_Fleet ON dbo.CF_Profile_Terminal.IDProfileTerminal = dbo.CF_Profile_Fleet.IDProfileTerminal INNER JOIN
                      dbo.CF_Vehicles ON dbo.CF_Profile_Fleet.IDProfileFleet = dbo.CF_Vehicles.IDProfileFleet



