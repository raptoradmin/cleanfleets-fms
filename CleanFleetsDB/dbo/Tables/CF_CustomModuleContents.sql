CREATE TABLE [dbo].[CF_CustomModuleContents] (
    [IDCustomModuleContents] INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IDCustomModule]         INT              NULL,
    [IDFile]                 UNIQUEIDENTIFIER NULL,
    [IDType]                 INT              NULL,
    CONSTRAINT [PK_CF_CustomModuleContents] PRIMARY KEY CLUSTERED ([IDCustomModuleContents] ASC)
);

