CREATE TABLE [dbo].[CF_Vehicles_Log_Hours] (
    [IDHoursLog]     UNIQUEIDENTIFIER CONSTRAINT [DF_CF_Vehicles_Log_Hours_IDHoursLog] DEFAULT (newid()) NOT NULL,
    [IDVehicles]     UNIQUEIDENTIFIER NULL,
    [EnterDate]      DATETIME         CONSTRAINT [DF_CF_Vehicles_Log_Hours_EnterDate_1] DEFAULT (getdate()) NULL,
    [IDModifiedUser] UNIQUEIDENTIFIER NULL,
    [ModifiedDate]   DATETIME         NULL,
    [Hours]          INT              NULL,
    [HoursDate]      DATETIME         NULL,
    [Notes]          VARCHAR (MAX)    NULL,
    CONSTRAINT [PK_CF_Vehicles_Log_Hours_1] PRIMARY KEY CLUSTERED ([IDHoursLog] ASC)
);

