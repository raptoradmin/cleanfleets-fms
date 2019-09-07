CREATE TABLE [dbo].[CF_UserTerminals] (
    [IDUserTerminals]   INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IDProfileTerminal] INT              NOT NULL,
    [UserId]            UNIQUEIDENTIFIER NOT NULL,
    [PermissionLevel]   CHAR (1)         NOT NULL,
    PRIMARY KEY NONCLUSTERED ([IDUserTerminals] ASC)
);

