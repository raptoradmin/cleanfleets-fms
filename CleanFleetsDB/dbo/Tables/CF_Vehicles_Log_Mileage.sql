CREATE TABLE [dbo].[CF_Vehicles_Log_Mileage] (
    [IDMileageLog]   UNIQUEIDENTIFIER CONSTRAINT [DF_CF_Vehicles_Log_Mileage_IDMileageLog] DEFAULT (newid()) NOT NULL,
    [IDVehicles]     UNIQUEIDENTIFIER NULL,
    [EnterDate]      DATETIME         CONSTRAINT [DF_CF_Vehicles_Log_Mileage_EnterDate] DEFAULT (getdate()) NULL,
    [IDModifiedUser] UNIQUEIDENTIFIER NULL,
    [ModifiedDate]   DATETIME         NULL,
    [Mileage]        INT              NULL,
    [MileageDate]    DATETIME         NULL,
    [Notes]          VARCHAR (MAX)    NULL,
    CONSTRAINT [PK_CF_Vehicles_Log_Mileage] PRIMARY KEY CLUSTERED ([IDMileageLog] ASC)
);

