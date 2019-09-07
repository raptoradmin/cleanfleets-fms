CREATE VIEW [dbo].[CFV_QE_Estimate_Totals]
AS
SELECT        dbo.CF_QE_Estimate.IDQEAccount, SUM(dbo.CF_QE_Estimate.QuantityVehicles * dbo.CF_QE_Estimate.EstReplacementCost) AS ReplacementCost, 
                         SUM(dbo.CF_QE_Estimate.QuantityVehicles * dbo.CF_QE_Estimate.EstRetrofitCost) AS RetrofitCost, dbo.CF_QE_Account.AccountName
FROM            dbo.CF_QE_Estimate INNER JOIN
                         dbo.CF_QE_Account ON dbo.CF_QE_Estimate.IDQEAccount = dbo.CF_QE_Account.IDAccount
GROUP BY dbo.CF_QE_Estimate.IDQEAccount, dbo.CF_QE_Account.AccountName
