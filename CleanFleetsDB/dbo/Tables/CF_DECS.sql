CREATE TABLE [dbo].[CF_DECS] (
    [IDDECS]               UNIQUEIDENTIFIER NOT NULL,
    [IDModifiedUser]       UNIQUEIDENTIFIER NULL,
    [EnterDate]            DATETIME         CONSTRAINT [DF_CF_DECs_EnterDate] DEFAULT (getdate()) NULL,
    [ModifiedDate]         DATETIME         NULL,
    [IDProfileAccount]     INT              NULL,
    [IDEngines]            UNIQUEIDENTIFIER NULL,
    [SerialNo]             VARCHAR (50)     NULL,
    [DECSName]             VARCHAR (50)     NULL,
    [IDDECSManufacturer]   INT              CONSTRAINT [DF_CF_DECS_IDDECSManufacturer] DEFAULT ((0)) NULL,
    [IDDECSLevel]          INT              CONSTRAINT [DF_CF_DECS_IDDECSLevel] DEFAULT ((0)) NULL,
    [DECSModelNo]          VARCHAR (50)     NULL,
    [DECSInstallationDate] DATETIME         NULL,
    [Notes]                VARCHAR (MAX)    NULL,
    [NotesCF]              VARCHAR (MAX)    NULL,
    CONSTRAINT [PK_CF_DECS_1] PRIMARY KEY CLUSTERED ([IDDECS] ASC),
    CONSTRAINT [FK_CF_DECS_CF_Engines] FOREIGN KEY ([IDEngines]) REFERENCES [dbo].[CF_Engines] ([IDEngines]) ON DELETE CASCADE
);

