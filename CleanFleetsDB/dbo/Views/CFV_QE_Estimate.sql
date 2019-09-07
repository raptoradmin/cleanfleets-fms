CREATE VIEW [dbo].[CFV_QE_Estimate]
AS
SELECT        IDEstimateEntry, IDQEAccount, IDGrossVehicleWeight,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List AS CF_Option_List_2
                               WHERE        (dbo.CF_QE_Estimate.IDGrossVehicleWeight = IDOptionList)) AS GrossVehicleWeight, IDChassisModelYear,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List AS CF_Option_List_1
                               WHERE        (dbo.CF_QE_Estimate.IDChassisModelYear = IDOptionList)) AS Year, QuantityVehicles, EstReplacementCost, EstRetrofitCost, 
                         QuantityVehicles * EstReplacementCost AS ReplacementCost, QuantityVehicles * EstRetrofitCost AS RetrofitCost
FROM            dbo.CF_QE_Estimate
