CREATE TABLE [dbo].[CF_AccountDefaultModules] (
    [IDAccountDefaultModules] INT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IDProfileAccount]        INT      NULL,
    [IDDefaultModule]         INT      NULL,
    [IsDisplayed]             CHAR (1) NULL,
    CONSTRAINT [PK_CF_AccountDefaultModules] PRIMARY KEY CLUSTERED ([IDAccountDefaultModules] ASC)
);

