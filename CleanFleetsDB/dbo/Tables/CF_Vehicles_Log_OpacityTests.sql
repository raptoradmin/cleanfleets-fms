CREATE TABLE [dbo].[CF_Vehicles_Log_OpacityTests] (
    [IDOpacityTestsLog] UNIQUEIDENTIFIER CONSTRAINT [DF_CF_Vehicles_Log_OpacityTests_IDOpacityTestsLog] DEFAULT (newid()) NOT NULL,
    [IDVehicles]        UNIQUEIDENTIFIER NULL,
    [EnterDate]         DATETIME         NULL,
    [IDModifiedUser]    UNIQUEIDENTIFIER NULL,
    [ModifiedDate]      DATETIME         NULL,
    [TestDate]          DATETIME         NULL,
    [TestedBy]          VARCHAR (50)     NULL,
    [AverageOpacity]    DECIMAL (5, 2)   NULL,
    [TestResult]        CHAR (4)         NULL,
    [RawTestResults]    NVARCHAR (MAX)   NULL,
    [ScannerModel]      VARCHAR (20)     NULL,
    CONSTRAINT [PK_CF_Vehicles_Log_OpacityTests] PRIMARY KEY CLUSTERED ([IDOpacityTestsLog] ASC)
);

