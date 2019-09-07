CREATE TABLE [dbo].[CF_CustomModule] (
    [IDCustomModule]   INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IDProfileAccount] INT          NULL,
    [ModuleName]       VARCHAR (60) NULL,
    CONSTRAINT [PK_CF_CustomModule] PRIMARY KEY CLUSTERED ([IDCustomModule] ASC)
);

