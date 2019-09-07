CREATE TABLE [dbo].[CF_Menu_Client] (
    [DataFieldID]          INT           IDENTITY (1, 1) NOT NULL,
    [DataFieldParentID]    INT           NULL,
    [DataTextField]        VARCHAR (100) NULL,
    [DataNavigateUrlField] VARCHAR (100) NULL,
    [ImageURL]             VARCHAR (100) NULL,
    [Sort]                 VARCHAR (10)  NULL
);

