CREATE TABLE [dbo].[CF_Menu_Console] (
    [DataFieldID]          INT           IDENTITY (1, 1) NOT NULL,
    [DataFieldParentID]    INT           NULL,
    [DataTextField]        VARCHAR (100) NULL,
    [DataNavigateUrlField] VARCHAR (100) NULL,
    [ImageURL]             VARCHAR (100) NULL,
    CONSTRAINT [PK_CF_Menu_Console_1] PRIMARY KEY CLUSTERED ([DataFieldID] ASC)
);

