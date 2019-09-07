CREATE VIEW [dbo].[CFV_Import_Vehicles]
AS
SELECT        TOP (100) PERCENT CAST
                             ((SELECT        IDProfileAccount
                                 FROM            dbo.CF_Profile_Account
                                 WHERE        (AccountName = dbo.CF_Import.Account)) AS INT) AS IDProfileAccount, Account,
                             (SELECT        IDProfileTerminal
                               FROM            dbo.CFV_A_T_Names AS CFV_A_T_Names_1
                               WHERE        (TerminalName = dbo.CF_Import.Terminal) AND (AccountName = dbo.CF_Import.Account)) AS IDProfileTerminal, Terminal, CAST
                             ((SELECT        IDProfileFleet
                                 FROM            dbo.CFV_A_T_F_Names AS CFV_A_T_F_Names_1
                                 WHERE        (FleetName = dbo.CF_Import.Fleet) AND (TerminalName = dbo.CF_Import.Terminal) AND (AccountName = dbo.CF_Import.Account)) AS INT) 
                         AS IDProfileFleet, Fleet, CAST(UnitNo AS VarChar(50)) AS UnitNo, CAST(LicensePlateNo AS VarChar(50)) AS LicensePlateNo, CAST(ChassisVIN AS VarChar(50)) 
                         AS ChassisVIN, EquipmentType,
                             (SELECT        IDOptionList
                               FROM            dbo.CF_Option_List
                               WHERE        (DisplayValue = dbo.CF_Import.EquipmentType)) AS IDEquipmentType, EquipmentCategory,
                             (SELECT        IDOptionList
                               FROM            dbo.CF_Option_List AS CF_Option_List_1
                               WHERE        (DisplayValue = dbo.CF_Import.EquipmentType)) AS IDEquipmentCategory, VehicleStatus,
                             (SELECT        IDOptionList
                               FROM            dbo.CF_Option_List AS CF_Option_List_2
                               WHERE        (DisplayValue = dbo.CF_Import.VehicleStatus) AND (OptionName LIKE '%VehicleStatus%')) AS IDVehicleStatus, CARBGroup,
                             (SELECT        IDOptionList
                               FROM            dbo.CF_Option_List AS CF_Option_List_3
                               WHERE        (DisplayValue = dbo.CF_Import.CARBGroup)) AS IDCARBGroup, ChassisMake,
                             (SELECT        IDOptionList
                               FROM            dbo.CF_Option_List AS CF_Option_List_4
                               WHERE        (DisplayValue = dbo.CF_Import.ChassisMake) AND (OptionName LIKE '%ChassisMake%')) AS IDChassisMake, ChassisModelYear,
                             (SELECT        IDOptionList
                               FROM            dbo.CF_Option_List AS CF_Option_List_5
                               WHERE        (DisplayValue = dbo.CF_Import.ChassisModelYear) AND (OptionName LIKE '%Year%')) AS IDChassisModelYear, 
                         CAST(AnnualMiles AS VarChar(50)) AS AnnualMiles, CAST(AnnualHours AS VarChar(50)) AS AnnualHours, CAST(ActualMiles AS VarChar(50)) AS ActualMiles, 
                         CAST(ActualHours AS VarChar(50)) AS ActualHours, CAST(GrossVehicleWeight AS VarChar(50)) AS GrossVehicleWeight, PlannedComplianceDate, 
                         ActualComplianceDate, BackupStatusDate, RetireStatusDate, EstReplacementCost, PlannedRetirementDate, ActualRetirementDate
FROM            dbo.CF_Import
ORDER BY Terminal
