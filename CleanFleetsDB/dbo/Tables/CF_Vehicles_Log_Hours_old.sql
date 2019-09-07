CREATE TABLE [dbo].[CF_Vehicles_Log_Hours_old] (
    [IDHoursLog]     INT              IDENTITY (1, 1) NOT NULL,
    [IDVehicles]     INT              NULL,
    [EnterDate]      DATETIME         CONSTRAINT [DF_CF_Vehicles_Log_Hours_EnterDate] DEFAULT (getdate()) NULL,
    [IDModifiedUser] UNIQUEIDENTIFIER NULL,
    [ModifiedDate]   DATETIME         NULL,
    [BeginHours]     DECIMAL (18)     NULL,
    [BeginHoursDate] DATETIME         NULL,
    [EndHours]       DECIMAL (18)     NULL,
    [EndHoursDate]   DATETIME         NULL,
    [Notes]          VARCHAR (MAX)    NULL,
    [NotesCF]        VARCHAR (MAX)    NULL,
    CONSTRAINT [PK_CF_Vehicles_Log_Hours] PRIMARY KEY CLUSTERED ([IDHoursLog] ASC)
);

