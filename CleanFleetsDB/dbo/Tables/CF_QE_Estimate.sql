CREATE TABLE [dbo].[CF_QE_Estimate] (
    [IDEstimateEntry]      INT   IDENTITY (1, 1) NOT NULL,
    [IDQEAccount]          INT   NOT NULL,
    [IDGrossVehicleWeight] INT   NULL,
    [IDChassisModelYear]   INT   NULL,
    [QuantityVehicles]     INT   NULL,
    [EstReplacementCost]   MONEY NULL,
    [EstRetrofitCost]      MONEY NULL,
    CONSTRAINT [PK_CF_QE_Estimate] PRIMARY KEY CLUSTERED ([IDEstimateEntry] ASC)
);

