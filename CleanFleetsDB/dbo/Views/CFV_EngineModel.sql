CREATE VIEW [dbo].[CFV_EngineModel]
AS
SELECT        EngineModel
FROM            dbo.CF_Engines
UNION
SELECT        DisplayValue AS EngineModel
FROM            dbo.CF_Option_List
WHERE        dbo.CF_Option_List.OptionName = 'EngineModel'
