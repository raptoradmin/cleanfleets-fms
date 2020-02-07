Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports Inspironix

Namespace CF.Modules

Public Class DefaultModule
	Implements GenericModule

	Private accountID as String
	Private contactID as String
	Private isDisplayedValue as Boolean
	Private moduleData as DataTable
	
	Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
	Private SQLStr as String
	
	Public Enum ModuleType
		ComplianceCertification
		FleetSummary
		OpacityTest
		EngineModelYearReplacementSchedule
		STBPhaseInOption
		LowMileageConstruction
		NOxExempt
	End Enum
	
	Public Sub New(ByVal accountID as String, ByVal contactID as String, moduleType As DefaultModule.ModuleType)
		Me.accountID = accountID.Trim()
		Me.contactID = contactID.Trim()
		'moduleData = new DataTable()
		Dim recordValue as String = Nothing
		Select Case moduleType
            Case ModuleType.ComplianceCertification
				recordValue = "ComplianceCertification"
                buildComplianceCertification()
			Case ModuleType.FleetSummary
				recordValue = "FleetSummary"
				buildFleetSummary()
			Case ModuleType.OpacityTest
				recordValue = "OpacityTests"
				buildOpacityTest()
			Case ModuleType.EngineModelYearReplacementSchedule
				recordValue = "EngineModelYearReplacementSchedule"
				buildEngineModelYearReplacementSchedule()
			Case ModuleType.STBPhaseInOption
				recordValue = "STBPhaseInOption"
				buildSTBPhaseInOption()
			Case ModuleType.LowMileageConstruction
				recordValue = "LowMileageConstruction"
				buildLowMileageConstruction()
			Case ModuleType.NOxExempt
				recordValue = "NOxExempt"
				buildNOxExempt()
			Case Else
				'error, default operation, no-op?
		End Select
		
		isDisplayedValue = getIsDisplayed(recordValue)
		
	End Sub
	
	Private Function getIsDisplayed(ByVal recordValue as String) As Boolean
		SQLStr = 	"SELECT IsDisplayed " & _
					"FROM [CF_AccountDefaultModules] " & _
					"INNER JOIN [CF_Option_List] ON IDDefaultModule =  IDOptionList " & _
					"WHERE IDProfileAccount = @IDAccount AND RecordValue = @recordValue AND OptionName = 'DefaultModule'"
		Dim result as String
		Using myConnection As New SqlConnection(connectionString)
			myConnection.Open()
			Dim command As New SqlCommand(SQLStr, myConnection)
            command.Parameters.Add("@IDAccount", accountID)
			command.Parameters.Add("@recordValue", recordValue)
			Dim MyReader As SqlDataReader = command.ExecuteReader
            if MyReader.Read() then
				result = MyReader("IsDisplayed")
			Else
				result = "N"
			end if
			           	
			
			myConnection.Close()
		End Using
		
		If result.ToUpper().Trim() = "Y" Then
			Return True
		Else
			Return False
		End If
		return result
	End Function
	
	Private Sub buildComplianceCertification()
		moduleData = new DataTable("Compliance Certification")
		SQLStr = 	"SELECT FileName, FilePath, Title FROM [CFV_Files_Account_Public] " & _
					"WHERE [IDProfileAccount] = @IDProfileAccount " & _
					"AND UPPER(RTRIM(ISNULL(DocumentTypeRecordValue,''))) = 'COMPLIANCECERTIFICATE' " & _
					"UNION " & _
					"SELECT F.FileName, F.FilePath, T.TerminalName + ' - ' + F.Title AS Title " & _
					"FROM CF_Files F " & _
					"LEFT JOIN CF_Profile_Terminal T ON F.IDProfileTerminal = T.IDProfileTerminal " & _
					"LEFT JOIN CF_Option_List O ON F.IDDocumentType = O.IDOptionList " & _
					"LEFT JOIN CF_Profile_Contact C ON C.IDProfileAccount = F.IDProfileAccount " & _
					"LEFT JOIN CF_UserTerminals P ON P.UserId = C.UserID AND P.IDProfileTerminal = T.IDProfileTerminal " & _
					"WHERE F.[IDProfileAccount] = @IDProfileAccount " & _
					"AND C.IDProfileContact = @IDProfileContact " & _
					"AND F.IDProfileTerminal IS NOT NULL " & _
					"AND RTRIM(ISNULL(O.OptionName, 'DocumentType')) = 'DocumentType'  " & _
					"AND UPPER(RTRIM(ISNULL(O.RecordValue,''))) = 'COMPLIANCECERTIFICATE'  " & _
					"AND P.PermissionLevel LIKE '[AB]' " & _
					"ORDER BY Title"
		Using myConnection As New SqlConnection(connectionString)
			myConnection.Open()
			Dim command As New SqlCommand(SQLStr, myConnection)
            command.Parameters.Add("@IDProfileAccount", accountID)
			command.Parameters.Add("@IDProfileContact", contactID)
			Using dataAdapter as New SqlDataAdapter()
				dataAdapter.SelectCommand = command
				dataAdapter.Fill(moduleData)
			End Using            	
			
			myConnection.Close()
		End Using
	End Sub
	
	Private Sub buildFleetSummary()
		moduleData = new DataTable("Fleet Summary")
		SQLStr =	"SELECT FileName, FilePath, Title FROM [CFV_Files_Account_Public] " & _
					"WHERE [IDProfileAccount] = @IDProfileAccount " & _
					"AND UPPER(RTRIM(ISNULL(DocumentTypeRecordValue,''))) = 'FLEETSUMMARY' " & _
					"UNION " & _
					"SELECT FileName, FilePath, T.TerminalName + ' - ' + F.Title AS Title " & _
					"FROM CF_Files F " & _
					"LEFT JOIN CF_Profile_Terminal T ON F.IDProfileTerminal = T.IDProfileTerminal " & _
					"LEFT JOIN CF_Option_List O ON F.IDDocumentType = O.IDOptionList " & _
					"LEFT JOIN CF_Profile_Contact C ON C.IDProfileAccount = F.IDProfileAccount " & _ 
					"LEFT JOIN CF_UserTerminals P ON P.UserId = C.UserID AND P.IDProfileTerminal = T.IDProfileTerminal " & _
					"WHERE F.[IDProfileAccount] = @IDProfileAccount " & _
					"AND C.IDProfileContact = @IDProfileContact " & _
					"AND F.IDProfileTerminal IS NOT NULL " & _
					"AND RTRIM(ISNULL(O.OptionName, 'DocumentType')) = 'DocumentType'  " & _
					"AND UPPER(RTRIM(ISNULL(O.RecordValue,''))) = 'FLEETSUMMARY'  " & _
					"AND P.PermissionLevel LIKE '[AB]' " & _
					"ORDER BY Title"
		Using myConnection As New SqlConnection(connectionString)
			myConnection.Open()
			Dim command As New SqlCommand(SQLStr, myConnection)
            command.Parameters.Add("@IDProfileAccount", accountID)
			command.Parameters.Add("@IDProfileContact", contactID)
			Using dataAdapter as New SqlDataAdapter()
				dataAdapter.SelectCommand = command
				dataAdapter.Fill(moduleData)
			End Using            	
			
			myConnection.Close()
		End Using
	End Sub
	
	Private Sub buildOpacityTest()
		moduleData = new DataTable("Opacity Tests")
		SQLStr = 	"SELECT FileName, FilePath, Title FROM [CFV_Files_Account_Public] " & _
					"WHERE [IDProfileAccount] = @IDProfileAccount " & _
					"AND UPPER(RTRIM(ISNULL(DocumentTypeRecordValue,''))) = 'OPACITYTESTS' " & _
					"UNION " & _
					"SELECT FileName, FilePath, T.TerminalName + ' - ' + F.Title AS Title " & _
					"FROM CF_Files F " & _
					"LEFT JOIN CF_Profile_Terminal T ON F.IDProfileTerminal = T.IDProfileTerminal " & _
					"LEFT JOIN CF_Option_List O ON F.IDDocumentType = O.IDOptionList " & _
					"LEFT JOIN CF_Profile_Contact C ON C.IDProfileAccount = F.IDProfileAccount " & _
					"LEFT JOIN CF_UserTerminals P ON P.UserId = C.UserID AND P.IDProfileTerminal = T.IDProfileTerminal " & _
					"WHERE F.[IDProfileAccount] = @IDProfileAccount " & _
					"AND C.IDProfileContact = @IDProfileContact " & _
					"AND F.IDProfileTerminal IS NOT NULL " & _
					"AND RTRIM(ISNULL(O.OptionName, 'DocumentType')) = 'DocumentType'  " & _
					"AND UPPER(RTRIM(ISNULL(O.RecordValue,''))) = 'OPACITYTESTS' " & _
					"AND P.PermissionLevel LIKE '[AB]' " & _
					"ORDER BY Title"
		Using myConnection As New SqlConnection(connectionString)
			myConnection.Open()
			Dim command As New SqlCommand(SQLStr, myConnection)
            command.Parameters.Add("@IDProfileAccount", accountID)
			command.Parameters.Add("@IDProfileContact", contactID)
			Using dataAdapter as New SqlDataAdapter()
				dataAdapter.SelectCommand = command
				dataAdapter.Fill(moduleData)
			End Using            	
			
			myConnection.Close()
		End Using
	End Sub
	
	
	Private Sub buildEngineModelYearReplacementSchedule()
		moduleData = new DataTable("Engine Model Year Replacement Schedule")
		SQLStr = 	"SELECT '~/includes/reports_console/08_Engine_Model_Year_Replacement_Schedule.aspx?Export=true&Worksheet=All&IDProfileAccount=' + " & _
					"LTRIM(STR(@IDProfileAccount)) + '&IDEngineReplacementScheduleClass=' + LTRIM(STR(IDOptionList)) AS URL, DisplayValue AS Title  " & _
					"FROM CF_Option_List " & _
					"WHERE UPPER(RTRIM(ISNULL(OptionName,''))) = UPPER('EngineReplacementScheduleClass') " & _
					"ORDER BY DisplayValue"
		Using myConnection As New SqlConnection(connectionString)
			myConnection.Open()
			Dim command As New SqlCommand(SQLStr, myConnection)
            command.Parameters.Add("@IDProfileAccount", accountID)

			Using dataAdapter as New SqlDataAdapter()
				dataAdapter.SelectCommand = command
				dataAdapter.Fill(moduleData)
			End Using            	
			
			myConnection.Close()
		End Using
	End Sub
	
	Private Sub buildSTBPhaseInOption()
	
		Dim reportURL = "~/includes/reports_console/07_fleet_calculation_export.aspx?Export=true&Worksheet=STBPhase-InFleetPlan&IDProfileAccount=" & _
			accountID & "&IDProfileContact=" & contactID
		
		moduleData = new DataTable("STB Phase In Option")
		moduleData.Columns.Add("URL")
		Dim newRow = moduleData.NewRow()
		newRow("URL") = reportURL
		moduleData.Rows.Add(newRow)
	End Sub
	
	Private Sub buildLowMileageConstruction()
		Dim reportURL = "~/includes/reports_console/07_fleet_calculation_export.aspx?Export=true&Worksheet=LowMileageConst&IDProfileAccount= " & _
			accountID & "&IDProfileContact=" & contactID
		
		moduleData = new DataTable("Low Mileage Construction")
		moduleData.Columns.Add("URL")
		Dim newRow = moduleData.NewRow()
		newRow("URL") = reportURL
		moduleData.Rows.Add(newRow)
	End Sub
	
	Private Sub buildNOxExempt()
		moduleData = new DataTable("NOx Exempt")
		SQLStr = "SELECT '~/includes/reports_console/07_fleet_calculation_export.aspx?Export=true&Worksheet=NOxExempt&IDProfileAccount=' + " & _
				 "LTRIM(STR(@IDProfileAccount)) + '&IDProfileContact=' + LTRIM(STR(@IDProfileContact)) + '&IDEngineReplacementScheduleClass=' + " & _
				 "LTRIM(STR(IDOptionList)) AS URL, " & _
				 "DisplayValue AS Title " & _
				 "FROM CF_Option_List " & _
				 "WHERE UPPER(RTRIM(ISNULL(OptionName,''))) = UPPER('EngineReplacementScheduleClass') " & _
				 "ORDER BY DisplayValue"
		
		Using myConnection As New SqlConnection(connectionString)
			myConnection.Open()
			Dim command As New SqlCommand(SQLStr, myConnection)
            command.Parameters.Add("@IDProfileAccount", accountID)
			command.Parameters.Add("@IDProfileContact", contactID)

			Using dataAdapter as New SqlDataAdapter()
				dataAdapter.SelectCommand = command
				dataAdapter.Fill(moduleData)
			End Using            	
			
			myConnection.Close()
		End Using
	End Sub
	
	
	Public Function getDataTable() As DataTable
		Return moduleData
	End Function
	
	Public Function isDisplayed() As Boolean
		Return isDisplayedValue
	End Function
	
	
End Class

End Namespace