CREATE TABLE [dbo].[CF_Images] (
    [IDImages]       UNIQUEIDENTIFIER NOT NULL,
    [IDModifiedUser] UNIQUEIDENTIFIER NULL,
    [DefaultImage]   BIT              CONSTRAINT [DF_CF_Images_DefaultImage] DEFAULT ((0)) NULL,
    [EnterDate]      DATETIME         CONSTRAINT [DF_CF_Images_EnterDate] DEFAULT (getdate()) NULL,
    [ModifiedDate]   DATETIME         NULL,
    [IDVehicles]     UNIQUEIDENTIFIER NULL,
    [IDEngines]      UNIQUEIDENTIFIER NULL,
    [IDDECS]         UNIQUEIDENTIFIER NULL,
    [Title]          VARCHAR (50)     NULL,
    [FilePath]       VARCHAR (200)    CONSTRAINT [DF_CF_Images_FilePath] DEFAULT ('~/includes/imagemanager/imagefiles') NULL,
    [FileName]       VARCHAR (MAX)    NULL,
    [UserID]         UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_CF_Images] PRIMARY KEY CLUSTERED ([IDImages] ASC)
);

