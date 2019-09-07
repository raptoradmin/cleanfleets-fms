CREATE TABLE [dbo].[CF_Files] (
    [IDFile]            UNIQUEIDENTIFIER NOT NULL,
    [EnterDate]         DATETIME         CONSTRAINT [DF_CF_Files_EnterDate] DEFAULT (getdate()) NULL,
    [IDModifiedUser]    UNIQUEIDENTIFIER NULL,
    [ModifiedDate]      DATETIME         NULL,
    [IDDocumentType]    INT              NULL,
    [Title]             VARCHAR (50)     NULL,
    [FileName]          VARCHAR (500)    NULL,
    [FileSize]          VARCHAR (50)     NULL,
    [FilePath]          VARCHAR (500)    CONSTRAINT [DF_CF_Files_FilePath] DEFAULT ('~/includes/filemanager/files/') NULL,
    [IDProfileAccount]  INT              NULL,
    [IDProfileTerminal] INT              NULL,
    [IDProfileFleet]    INT              NULL,
    [IDVehicles]        UNIQUEIDENTIFIER NULL,
    [IDEngines]         UNIQUEIDENTIFIER NULL,
    [IDDECS]            UNIQUEIDENTIFIER NULL,
    [Notes]             VARCHAR (MAX)    NULL,
    CONSTRAINT [PK_CF_Files] PRIMARY KEY CLUSTERED ([IDFile] ASC)
);

