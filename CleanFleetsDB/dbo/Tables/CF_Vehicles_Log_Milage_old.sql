CREATE TABLE [dbo].[CF_Vehicles_Log_Milage_old] (
    [IDMilageLog]     INT              IDENTITY (1, 1) NOT NULL,
    [IDVehicles]      INT              NULL,
    [EnterDate]       DATETIME         CONSTRAINT [DF_CF_Vehicles_Milage_Log_EnterDate] DEFAULT (getdate()) NULL,
    [IDModifiedUser]  UNIQUEIDENTIFIER NULL,
    [ModifiedDate]    DATETIME         NULL,
    [BeginMilage]     DECIMAL (18)     NULL,
    [BeginMilageDate] DATETIME         NULL,
    [EndMilage]       DECIMAL (18)     NULL,
    [EndMilageDate]   DATETIME         NULL,
    [Notes]           VARCHAR (MAX)    NULL,
    [NotesCF]         VARCHAR (MAX)    NULL,
    CONSTRAINT [PK_CF_Vehicles_Milage_Log] PRIMARY KEY CLUSTERED ([IDMilageLog] ASC)
);

