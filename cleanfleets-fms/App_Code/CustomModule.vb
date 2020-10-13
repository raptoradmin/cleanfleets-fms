Imports System.Data
Imports System.Data.SqlClient
Imports Inspironix
Imports System.Collections.Generic

Namespace CF.Modules
Public Class CustomModule
	Implements GenericModule
	
	Private modules As List(Of DataTable)
	Private connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
	Private SQLStr As String
	Private accountID As String
	Private contactID As String
	'Private moduleID As String
	
	
	Public Sub New(ByVal accountID As String, ByVal contactID As String)
		Me.accountID = accountID
		Me.contactID = contactID
		'Me.moduleID = moduleID
		modules = new List(Of DataTable)
		buildCustomModules()		
	End Sub
	
	
	'need to get list of modules first, iterate through module list, get files per each module
	'otherwise,, it looks like this: 
	'IDCustomModule	IDProfileAccount	ModuleName	IDCustomModuleContents
'		13			19					M1			16
'		14			19					M2			17
'		15			19					M3			18
'		15			19					M3			19
'		15			19					M3			20
'		15			19					M3			21
	
	Private Sub buildCustomModules()
		Dim SQLStr = 	"SELECT IDCustomModule, ModuleName " & _
						"FROM CF_CustomModule " & _
						"WHERE IDProfileAccount = @IDProfileAccount"
		Dim modulesDict as New Dictionary(Of String, String)

		Using myConnection As New SqlConnection(connectionString)
			myConnection.Open()
			Dim command As New SqlCommand(SQLStr, myConnection)
			command.Parameters.Add("@IDProfileAccount", accountID)
			Dim MyReader As SqlDataReader = command.ExecuteReader
			While MyReader.Read()
				modulesDict.add(MyReader("IDCustomModule"), MyReader("ModuleName"))
			End While
			
			myConnection.Close()
		End Using
		
		getModulesContents(modulesDict)
	End Sub
	
	Public Function getModules() As List(Of DataTable)
		return modules
	End Function
	
	
	Private Sub getModulesContents(ByVal modulesDict As Dictionary(Of String, String))
		SQLStr = 	"SELECT FileName, FilePath, Title " & _
					"FROM CF_CustomModuleContents " & _
					"INNER JOIN CFV_Files_Account_Public  " & _
					"  ON CF_CustomModuleContents.IDFile = CFV_Files_Account_Public.IDFile " & _
					"WHERE IDCustomModule = @ModuleID " & _
					"UNION " & _
					"SELECT F.FileName, F.FilePath, T.TerminalName + ' - ' + F.Title AS Title " & _
					"FROM CF_CustomModuleContents " & _
					"INNER JOIN CF_Files F " & _
					"  ON CF_CustomModuleContents.IDFile = F.IDFile " & _
					"INNER JOIN CF_Profile_Terminal T " & _
					"  ON F.IDProfileTerminal = T.IDProfileTerminal " & _
					"INNER JOIN CF_Profile_Contact C " & _
					"  ON C.IDProfileAccount = F.IDProfileAccount " & _
					"INNER JOIN CF_UserTerminals P " & _
					"  ON P.UserId = C.UserID AND P.IDProfileTerminal = T.IDProfileTerminal " & _
					"WHERE F.IDProfileAccount = @IDProfileAccount " & _
					"AND C.IDProfileContact = @IDProfileContact " & _
					"AND CF_CustomModuleContents.IDCustomModule = @moduleID " & _
					"AND F.IDProfileTerminal IS NOT NULL " & _
					"AND P.PermissionLevel LIKE '[AB]' "


		For Each moduleIDName As KeyValuePair(Of String, String) In modulesDict
			Dim moduleID = moduleIDName.Key
			Dim moduleName = moduleIDName.Value
			
			Dim moduleTable = New DataTable(moduleName)
			moduleTable.Columns.Add("Title")
			moduleTable.Columns.Add("FilePath")
			moduleTable.Columns.Add("FileName")
		
			Using myConnection As New SqlConnection(connectionString)
				myConnection.Open()
				Dim command As New SqlCommand(SQLStr, myConnection)
				command.Parameters.Add("@ModuleID", moduleID)
				command.Parameters.Add("@IDProfileAccount", accountID)
				command.Parameters.Add("@IDProfileContact", contactID)
				Dim MyReader As SqlDataReader = command.ExecuteReader
				
				While MyReader.Read()
					Dim newRow = moduleTable.NewRow()
					newRow("Title") = MyReader("Title")
					newRow("FilePath") = MyReader("FilePath")
					newRow("FileName") = MyReader("FileName")
					moduleTable.Rows.Add(newRow)
				End While

				modules.Add(moduleTable)
				
				myConnection.Close()
			End Using
		Next
	End Sub

End Class

End Namespace