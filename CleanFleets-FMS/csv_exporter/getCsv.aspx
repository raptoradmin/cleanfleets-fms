<%@ Page Language="VB" %>

<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Web.Security.Roles" %>
<%@ Import Namespace="System.Web.Security.Membership" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.IO.Text" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Globalization" %>


<script runat="server">

	Dim UserID As Guid
	Dim MemUser As MembershipUser
	Dim IDProfileAccount As String
	Dim ProfileName As String
	Dim userName As String
	
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		Dim authHeader = Page.Request.Headers("Authorization")
		Dim credentials = parseAuthHeader(authHeader)
		
		userName = credentials(0)
		
		Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim queryString As String = "SELECT IDProfileAccount, UserId, Account FROM CFV_Profile_Contact WHERE UserName = @UserName"

        Using myConnection As New SqlConnection(connectionString)
			Dim myCommand As New SqlCommand(queryString, myConnection)
			myConnection.Open()
			myCommand.Parameters.AddWithValue("@UserName", userName)
			Dim MyReader As SqlDataReader = myCommand.ExecuteReader
			If MyReader.Read() Then
				IDProfileAccount = if(isDbNull(MyReader("IDProfileAccount")), "", MyReader("IDProfileAccount"))
				ProfileName = if(isDbNull(MyReader("Account")),"",MyReader("Account"))
				UserID = MyReader("UserId")
			End If
			myConnection.Close()
        End Using
		
		If Not IDProfileAccount Is Nothing Then
			buildCSV()
		End If
    End Sub
	
	
	Private Function parseAuthHeader(authHeader As [String]) As [String]()
		' Check this is a Basic Auth header
		If authHeader Is Nothing OrElse authHeader.Length = 0 OrElse Not authHeader.StartsWith("Basic") Then
			Return Nothing
		End If
	
		' Pull out the Credentials with are seperated by ':' and Base64 encoded
		Dim base64Credentials As String = authHeader.Substring(6)
		Dim credentials As String() = Encoding.ASCII.GetString(Convert.FromBase64String(base64Credentials)).Split(New Char() {":"C})
	
		If credentials.Length <> 2 OrElse String.IsNullOrEmpty(credentials(0)) OrElse String.IsNullOrEmpty(credentials(0)) Then
			Return Nothing
		End If
	
		' Okay this is the credentials
		Return credentials
	End Function

    Private Sub buildCSV()
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim SQLStr As String = "VehiclesByCarbGroupForCSVExport"

        Dim strBuilder As New StringBuilder
		Dim columnList As New List(Of String)

        Using myConnection As New SqlConnection(connectionString)
            Dim myCommand As New SqlCommand(SQLStr, myConnection)
			myCommand.CommandType = CommandType.StoredProcedure
            myConnection.Open()
            myCommand.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
            myCommand.Parameters.AddWithValue("@UserId", UserID)

            Dim MyReader As SqlDataReader = myCommand.ExecuteReader
            Dim schema = MyReader.GetSchemaTable()
            
			For i = 0 To schema.Rows.Count - 1
				strBuilder.Append("""" & sanitizeCSVField(schema.Rows(i)("ColumnName")) & """")
				columnList.Add(schema.Rows(i)("ColumnName"))				

				If i <> schema.Rows.Count - 1 Then
					strBuilder.Append(",")
				End If
			Next
			
			
			strBuilder.Append(Environment.NewLine)
			
			Dim stringToAdd As String
			
            While MyReader.Read()
				For i = 0 To columnList.Count - 1
					Dim columnName = columnList(i)
					stringToAdd = sanitizeCSVField(MyReader(columnName))
					stringToAdd = tryParseScientificNotation(stringToAdd)
					strBuilder.Append("""" & stringToAdd & """")
					If i <> columnList.Count - 1 Then
						strBuilder.Append(",")
					End If	
				Next
				
				strBuilder.Append(Environment.NewLine)
            End While

            myConnection.Close()
        End Using
		
		Dim byteArray = Encoding.ASCII.GetBytes(strBuilder.ToString())
		Dim mstream = New MemoryStream(byteArray)
		
		Response.Clear()
		Response.ContentType = "text/csv"
		Response.AddHeader("content-disposition", "attachment; filename=" & ProfileName & "_vehicles.csv")
		Response.BinaryWrite(byteArray)
		Response.End()
		
        'Return New Content(strBuilder.ToString(), "text/csv")
    End Sub
	
	
	'	Take care of any formatting that would break CSV format.
	'	Escapes " chars by replacing them with ""
	'	Removes any /r and /n chars
	Private Function sanitizeCSVField(ByVal csvField As Object) As String
		Dim origValue As String
		Dim origChars As Char()
		Dim strBuilder As New StringBuilder
		origValue = csvField.ToString()
		origChars = origValue.ToCharArray()
		
		For Each c As Char in origChars
			'Since VB might not be clear here, this is checking if c is a single " character
			If c = """"C Then
				strBuilder.Append(""""C)
				strBuilder.Append(c)
				' adds "" to the string builder (" characters are escaped by a second " character)
			Else If c = Chr(&H0A) Then	
				' don't add anything for \n
			Else If c = Chr(&H0D) Then
				' don't add anything for \r
			Else
				strBuilder.Append(c)
			End If
		Next	
		
		Return strBuilder.ToString()
	End Function
	
	
	'	Some fields end up stored in scientific notation if they get
	'	exported, saved in Excel, and reimported. This attempts to parse
	'	those values and return a regular number string.
	'	I think if you open the exported CSV in Excel, it will turn them back
	'	into scientific notation though...
	Private Function tryParseScientificNotation(ByVal tryToParseThis) As String
		If String.IsNullOrEmpty(tryToParseThis) Then
			return tryToParseThis
		End If
		
		Dim curCulture = CultureInfo.CurrentCulture
		Dim dec As Decimal
		Dim retString As String
		
		Response.Write(tryToParseThis & " is ")
		
		If (Decimal.TryParse(tryToParseThis, System.Globalization.NumberStyles.AllowExponent, curCulture, dec)) Then
			retString = dec.ToString()
		Else
			retString = tryToParseThis
		End If
		
		Return retString
	End Function


</script>

