Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Data.OleDb
Imports System.IO
Imports System.Collections.Generic
Imports Telerik.Web.UI
Imports System.Text.RegularExpressions
Imports Inspironix
Public Class _08_Engine_Model_Year_Replacement_Schedule
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Request.QueryString("Export") = "true" Then
            ExportFromQuerystring()
        End If
        If Not Page.IsPostBack Then

        End If
    End Sub

    Protected Sub ddl_Account_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileAccount As Integer = Convert.ToInt32(ddl_Account.selectedValue.toString())
        fillTerminals(IDProfileAccount)
        fillFleets(0)
    End Sub

    Protected Sub ddl_Terminal_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileTerminal As Integer = Convert.ToInt32(ddl_Terminal.selectedValue.toString())
        fillFleets(IDProfileTerminal)
    End Sub


    Protected Sub fillTerminals(IDProfileAccount As Integer)
        If IDProfileAccount > 0 Then
            Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)

            Dim adapter As New SqlDataAdapter("SELECT * FROM [CF_Profile_Terminal] WHERE ([IDProfileAccount] = @IDProfileAccount) ORDER BY [TerminalName]", connection)
            adapter.SelectCommand.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)

            Dim dt As New DataTable()
            adapter.Fill(dt)

            ddl_Terminal.DataTextField = "TerminalName"
            ddl_Terminal.DataValueField = "IDProfileTerminal"
            ddl_Terminal.DataSource = dt
            ddl_Terminal.DataBind()
            ddl_Terminal.Items.Insert(0, New ListItem("- Select Terminal -", "0"))
        Else
            ddl_Terminal.items.clear()
        End If
    End Sub


    Protected Sub fillFleets(IDProfileTerminal As Integer)
        If IDProfileTerminal > 0 Then
            Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)

            Dim adapter As New SqlDataAdapter("SELECT * FROM [CF_Profile_Fleet] WHERE ([IDProfileTerminal] = @IDProfileTerminal)", connection)
            adapter.SelectCommand.Parameters.AddWithValue("@IDProfileTerminal", IDProfileTerminal)

            Dim dt As New DataTable()
            adapter.Fill(dt)

            ddl_Fleet.DataTextField = "FleetName"
            ddl_Fleet.DataValueField = "IDProfileFleet"
            ddl_Fleet.DataSource = dt
            ddl_Fleet.DataBind()
            ddl_Fleet.Items.Insert(0, New ListItem("- Select Fleet -", "0"))
        Else
            ddl_Fleet.items.clear()
        End If
    End Sub


    Protected Sub ExportFromQuerystring()
        Dim filespec As String
        Dim IDProfileFleet As Integer
        Dim IDProfileTerminal As Integer
        Dim IDProfileAccount As Integer
        Dim IDEngineReplacementScheduleClass As Integer
        Integer.TryParse(Request.QueryString("IDProfileFleet"), IDProfileFleet)
        Integer.TryParse(Request.QueryString("IDProfileTerminal"), IDProfileTerminal)
        Integer.TryParse(Request.QueryString("IDProfileAccount"), IDProfileAccount)
        Integer.TryParse(Request.QueryString("IDEngineReplacementScheduleClass"), IDEngineReplacementScheduleClass)

        filespec = createEngineModelYearReplacementSchedule(IDProfileFleet, IDProfileTerminal, IDProfileAccount, IDEngineReplacementScheduleClass)
        Dim fi As New FileInfo(filespec)
        Response.ClearHeaders()
        Response.ClearContent()
        If filespec Like "*.xls" Then
            Response.ContentType = "application/vnd.ms-excel"
        ElseIf filespec Like "*.pdf" Then
            Response.ContentType = "application/pdf"
        End If
        Response.AddHeader("Content-Length", fi.Length)
        Response.AppendHeader("Content-Disposition", "attachment; filename=" & fi.Name)
        Using fs As New FileStream(filespec, FileMode.Open)

            Dim buffer(100 * 1024) As Byte
            Dim readed As Integer = 0

            Do
                readed = fs.Read(buffer, 0, buffer.Length)
                Response.OutputStream.Write(buffer, 0, readed)
                Response.Flush()
            Loop While readed > 0

            Response.End()
        End Using
    End Sub


    Protected Sub btn_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Report.Click
        If Page.IsValid() Then
            Dim filespec As String
            Dim IDProfileFleet As Integer
            Dim IDProfileTerminal As Integer
            Dim IDProfileAccount As Integer
            Integer.TryParse(ddl_Fleet.selectedValue, IDProfileFleet)
            Integer.TryParse(ddl_Terminal.selectedValue, IDProfileTerminal)
            Integer.TryParse(ddl_Account.selectedValue, IDProfileAccount)
            filespec = createEngineModelYearReplacementSchedule(IDProfileFleet, IDProfileTerminal, IDProfileAccount, ddl_EngineReplacementScheduleClass.selectedValue)
            Dim fi As New FileInfo(filespec)
            Response.ClearHeaders()
            Response.ClearContent()
            If filespec Like "*.xls" Then
                Response.ContentType = "application/vnd.ms-excel"
            ElseIf filespec Like "*.pdf" Then
                Response.ContentType = "application/pdf"
            End If
            Response.AddHeader("Content-Length", fi.Length)
            Response.AppendHeader("Content-Disposition", "attachment; filename=" & fi.Name)
            Using fs As New FileStream(filespec, FileMode.Open)

                Dim buffer(100 * 1024) As Byte
                Dim readed As Integer = 0

                Do
                    readed = fs.Read(buffer, 0, buffer.Length)
                    Response.OutputStream.Write(buffer, 0, readed)
                    Response.Flush()
                Loop While readed > 0

                Response.End()
            End Using

            'Dim windowManager As New RadWindowManager()
            'Dim RadWindow As New RadWindow()
            'RadWindow.NavigateUrl = "bluereport_fleet_display.aspx?Query=Fleet&IDProfileFleet=" & ddl_Fleet.selectedValue
            'RadWindow.ID = "RadWindow1"
            'RadWindow.VisibleOnPageLoad = True
            'RadWindow.Height = 400
            'RadWindow.Width = 850
            'RadWindow.Modal = True
            'windowManager.Windows.Add(RadWindow)
            'Me.mainForm.Controls.Add(RadWindow)
        End If
    End Sub


    Protected Sub ddl_Fleet_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) 'Handles RadComboBox3.SelectedIndexChanged

        'Session("IDProfileFLeet") = RadComboBox3.SelectedValue

    End Sub


    Sub cf_ddl_Validate(sender As Object, args As ServerValidateEventArgs)
        Dim value As Integer
        args.IsValid = True
        'if args.isValid then args.IsValid = ( Integer.tryParse(ddl_Account.selectedValue, value) andAlso value > 0) 
        'if args.isValid then args.IsValid = ( Integer.tryParse(ddl_Terminal.selectedValue, value) andAlso value > 0) 
        If args.IsValid Then args.IsValid = (Integer.TryParse(args.Value, value) AndAlso value > 0)
    End Sub

    Protected Function createEngineModelYearReplacementSchedule(IDProfileFleet As Integer, IDProfileTerminal As Integer, IDProfileAccount As Integer, IDEngineReplacementScheduleClass As Integer) As String
        ' depending on the option, we may need to open one of three files
        ' = Nothing added by Sam 2/20 to fix warnings --WARNING
        Dim TemplateFileSpec = Nothing
        Dim ComplianceYearRowNumber As Integer = Nothing
        Dim EngineModelYearColumn As String = Nothing
        Dim AccountBACTOption As String = Nothing
        Dim VehicleWeightClass As String = Nothing
        Dim ReportParametersCell As String = Nothing
        Dim ReportDateCell As String = Nothing
        Dim ATFName As String = Nothing
        Dim login As String = Nothing
        login = Membership.GetUser().UserName
        Dim filename As String = String.Format("{0}_engine_model_year_replacement_schedule_{1:yyyyMMdd-HHmmss}.pdf", login, DateTime.Now())
        Dim PathSpec = Server.MapPath("reports\")
        Dim objReader As SqlDataReader = Nothing
        Dim terminalReader As SqlDataReader = Nothing
        Dim UserID As Guid = Nothing
        Dim MemUser As MembershipUser = Nothing
        MemUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey
        ' set a default printer
        Dim search As System.Management.ManagementObjectSearcher = Nothing
        Dim results As System.Management.ManagementObjectCollection = Nothing
        search = New System.Management.ManagementObjectSearcher("select * from win32_printer")
        results = search.Get()
        For Each printer As System.Management.ManagementObject In results
            'System.Diagnostics.Debug.WriteLine(printer["Name"]);
            Dim result As Object = printer.InvokeMethod("SetDefaultPrinter", Nothing)
            Dim settings As System.Drawing.Printing.PrinterSettings = New System.Drawing.Printing.PrinterSettings()
            Exit For
        Next

        ' launch excel
        Dim oExcel As Object = CreateObject("Excel.Application")

        ' get records into cursor
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim conn2 As New SqlConnection(connectionString)
        Dim comm2 As New SqlCommand("EXECUTE [dbo].[GetUserTerminals] @IDProfileContact, @IDProfileAccount, @Result", conn2)
        Dim comm As New SqlCommand("SELECT IDProfileContact FROM CF_Profile_Contact WHERE UserID = @UserId", conn)
        comm.Parameters.Add("@UserId", UserID)
        comm.Connection.Open()
        Dim IDProfileContact = comm.ExecuteScalar()
        comm.Connection.Close()
        comm = New SqlCommand("SELECT [dbo].[GetIDOptionListRecordValue](@IDEngineReplacementScheduleClass) AS GVWClassStr, " &
          "[dbo].[GetIDOptionListRecordValue](Accounts.IDClass78BACTReplacementSchedule) AS Class78BACTReplacementSchedule, " &
          "CASE WHEN @IDProfileFleet > 0 THEN RTRIM(Accounts.AccountName) + ' / ' + RTRIM(TerminalName) + ' / ' + RTRIM(FleetName)  " &
          " WHEN @IDProfileTerminal > 0 THEN RTRIM(Accounts.AccountName) + ' / ' + RTRIM(TerminalName) " &
          " WHEN @IDProfileAccount > 0 THEN RTRIM(Accounts.AccountName) " &
          " ELSE '' " &
          " END AS ATFName " &
          "FROM CF_Profile_Fleet Fleets " &
          "INNER JOIN CF_Profile_Terminal Terminals ON Fleets.IDProfileTerminal = Terminals.IDProfileTerminal " &
          "INNER JOIN CF_Profile_Account Accounts ON Terminals.IDProfileAccount = Accounts.IDProfileAccount " &
          "WHERE ISNULL(@IDProfileFleet,0) IN (0, Fleets.IDProfileFleet) " &
          "AND ISNULL(@IDProfileTerminal,0) IN (0, Terminals.IDProfileTerminal) " &
          "AND ISNULL(@IDProfileAccount,0) IN (0, Accounts.IDProfileAccount)" &
          "AND [dbo].[GetTerminalPermission](Terminals.IDProfileTerminal, @UserId) IN ('A','B')", conn)
        comm.Parameters.Add("@IDEngineReplacementScheduleClass", IDEngineReplacementScheduleClass)
        comm.Parameters.Add("@IDProfileFleet", IDProfileFleet)
        comm.Parameters.Add("@IDProfileTerminal", IDProfileTerminal)
        comm.Parameters.Add("@IDProfileAccount", IDProfileAccount)
        comm.Parameters.Add("@UserId", UserID)

        comm.Connection.Open()
        objReader = comm.ExecuteReader()
        If objReader.Read() Then
            VehicleWeightClass = objReader("GVWClassStr")
            AccountBACTOption = DB.replaceNullStr(objReader("Class78BACTReplacementSchedule"), "OPTION1").toUpper()
            ATFName = "Account: " & DB.replaceNullStr(objReader("ATFName"), "") & " " & vbCrLf
            comm2.Parameters.Add("@IDProfileContact", IDProfileContact)
            comm2.Parameters.Add("@IDProfileAccount", IDProfileAccount)
            Dim result As String = Nothing
            comm2.Parameters.Add("@Result", result)
            comm2.Parameters("@Result").Direction = ParameterDirection.Output
            comm2.Parameters("@Result").Size = 40
            comm2.Connection.Open()
            terminalReader = comm2.ExecuteReader()
        Else
            Response.Redirect("../../cf_console/default.aspx?MessageStr=No%20vehicles%20to%20display%20for%20the%20selected%20report")
            'throw new Exception("Record not found IDProfileAccount:" & IDProfileAccount & " IDProfileTerminal:" & IDProfileTerminal & " IDProfileFleet:" & IDProfileFleet)
        End If
        objReader.Close()
        comm.Connection.Close()

        comm = New SqlCommand("EXECUTE QueryEMYRS @IDProfileFleet, @IDProfileTerminal, @IDProfileAccount, @VehicleWeightClass, @UserId", conn) '319, '7-8'/*
        comm.Parameters.AddWithValue("@IDProfileFleet", IDProfileFleet)
        comm.Parameters.AddWithValue("@IDProfileTerminal", IDProfileTerminal)
        comm.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
        comm.Parameters.AddWithValue("@VehicleWeightClass", VehicleWeightClass)
        comm.Parameters.AddWithValue("@UserId", UserID)
        comm.Connection.Open()
        objReader = comm.ExecuteReader()

        Dim EMYComplianceCells As New Dictionary(Of String, String)

        '10/08/2012 IR: Since some model years share the same column they needed to be under the same key value in EMYComplianceCells
        'Had to change key values and mapping of model year to key value.
        If VehicleWeightClass = "4-6" Then
            TemplateFileSpec = Server.MapPath("templates\Class 4-6 Engine Model Year Replacement Schedule.xls")
            ComplianceYearRowNumber = 5
            EngineModelYearColumn = "B"
            ReportParametersCell = "B3"
            ReportDateCell = "B4"
            '			EMYComplianceCells("1993") = "F9"  '"F7"
            '			EMYComplianceCells("1994") = "F9"  '"G8"
            '			EMYComplianceCells("1995") = "F9"  '"G8"
            '			EMYComplianceCells("1996") = "G9" '"C9"
            '			EMYComplianceCells("1997") = "H9" '"C9"
            '			EMYComplianceCells("1998") = "I9" '"C9"
            '			EMYComplianceCells("1999") = "J9" '"C9"
            '			EMYComplianceCells("2000") = "K9" '"D10"
            '			EMYComplianceCells("2001") = "K9" '"D10"
            '			EMYComplianceCells("2002") = "K9" '"D10"
            '			EMYComplianceCells("2003") = "K9" '"D10"
            '			EMYComplianceCells("2004") = "L9" '"D10"
            '			EMYComplianceCells("2005") = "L9" '"E11"
            '			EMYComplianceCells("2006") = "L9" '"E11"
            '			EMYComplianceCells("2007") = "N9" '"N12"
            '			EMYComplianceCells("2008") = "N9" '"N12"
            '			EMYComplianceCells("2009") = "N9" '"N12"

            EMYComplianceCells("9395") = "F9"
            EMYComplianceCells("1996") = "G9"
            EMYComplianceCells("1997") = "H9"
            EMYComplianceCells("1998") = "I9"
            EMYComplianceCells("1999") = "J9"
            EMYComplianceCells("0003") = "K9"
            EMYComplianceCells("0406") = "L9"
            EMYComplianceCells("0709") = "N9"

        ElseIf VehicleWeightClass = "7-8" Then '[CF_Profile_Account].[IDClass78BACTReplacementSchedule]
            If AccountBACTOption = "OPTION1" Then
                TemplateFileSpec = Server.MapPath("templates\Class 7-8 Engine Model Year Replacement Schedule Option 1.xls")
                ComplianceYearRowNumber = 5
                EngineModelYearColumn = "B"
                ReportParametersCell = "B3"
                ReportDateCell = "B4"
                EMYComplianceCells("1993") = "F9"  '"F7"
                '				EMYComplianceCells("1994") = "G9"  '"G8"
                '				EMYComplianceCells("1995") = "G9"  '"G8"
                '				EMYComplianceCells("1996") = "C9" '"C9"
                '				EMYComplianceCells("1997") = "C9" '"C9"
                '				EMYComplianceCells("1998") = "C9" '"C9"
                '				EMYComplianceCells("1999") = "C9" '"C9"
                '				EMYComplianceCells("2000") = "D9" '"D10"
                '				EMYComplianceCells("2001") = "D9" '"D10"
                '				EMYComplianceCells("2002") = "D9" '"D10"
                '				EMYComplianceCells("2003") = "D9" '"D10"
                '				EMYComplianceCells("2004") = "D9" '"D10"
                '				EMYComplianceCells("2005") = "E9" '"E11"
                '				EMYComplianceCells("2006") = "E9" '"E11"
                '				EMYComplianceCells("2007") = "N9" '"N12"
                '				EMYComplianceCells("2008") = "N9" '"N12"
                '				EMYComplianceCells("2009") = "N9" '"N12"

                EMYComplianceCells("9495") = "G9"
                EMYComplianceCells("9699") = "C9"
                EMYComplianceCells("0004") = "D9"
                EMYComplianceCells("0506") = "E9"
                EMYComplianceCells("0709") = "N9"



            ElseIf AccountBACTOption = "OPTION2" Then
                TemplateFileSpec = Server.MapPath("templates\Class 7-8 Engine Model Year Replacement Schedule Option 2.xls")
                ComplianceYearRowNumber = 5
                EngineModelYearColumn = "B"
                ReportParametersCell = "B3"
                ReportDateCell = "B4"
                EMYComplianceCells("1993") = "C9" '"D7"
                '				EMYComplianceCells("1994") = "E9" '"E8"
                '				EMYComplianceCells("1995") = "E9" '"E8"
                '				EMYComplianceCells("1996") = "E9" '"E8"
                '				EMYComplianceCells("1997") = "E9" '"E8"
                '				EMYComplianceCells("1998") = "E9" '"E8"
                '				EMYComplianceCells("1999") = "E9" '"E8"
                '				EMYComplianceCells("2000") = "G9" '"F14"
                '				EMYComplianceCells("2001") = "G9" '"F14"
                '				EMYComplianceCells("2002") = "G9" '"F14"
                '				EMYComplianceCells("2003") = "D9" '"D17"
                '				EMYComplianceCells("2004") = "D9" '"D17"
                '				EMYComplianceCells("2005") = "F9" '"E19"
                '				EMYComplianceCells("2006") = "F9" '"E19"
                '				EMYComplianceCells("2007") = "P9" '"O21"
                '				EMYComplianceCells("2008") = "P9" '"O21"
                '				EMYComplianceCells("2009") = "P9" '"O21"

                EMYComplianceCells("9499") = "E9"
                EMYComplianceCells("0002") = "G9"
                EMYComplianceCells("0304") = "D9"
                EMYComplianceCells("0506") = "F9"
                EMYComplianceCells("0709") = "P9"
            End If
        Else
            Throw New ArgumentException("Invalid Vehicle Weight Class")
        End If



        Try
            With oExcel
                ' open workbook
                .DisplayAlerts = False
                .Workbooks.Open(TemplateFileSpec)
                .Sheets("Summary").Select
                ATFName = ATFName & "Terminals:"
                While terminalReader.Read()
                    If Not terminalReader("PermissionLevel") = "G" Then
                        ATFName = ATFName & " " & terminalReader("TerminalName") & ","
                    End If
                End While
                comm2.Connection.Close()
                terminalReader.Close()
                .Rows("3:3").rowHeight = 33
                Dim newATFName = ATFName.Remove(ATFName.Length() - 1, 1).Insert(ATFName.Length() - 1, " ")
                .Range(ReportParametersCell).value = newATFName
                .Range(ReportDateCell).value = "Report Date: " & DateTime.Now.ToString("M/d/yyy")

                .Sheets("Unit Schedule").Select
                .Rows("3:3").rowHeight = 33
                .Range("A3").value = newATFName
                ' from sheet one, store the column name into a hashtable as (columnName, columnNumber)
                .Sheets("Unit Schedule").Select
                While objReader.Read()

                    Dim EngineModelYear As String = objReader("EngineModelYear")
                    Dim intEngineModelYear As Integer
                    Integer.TryParse(EngineModelYear, intEngineModelYear)
                    '10/08/2012 IR: Had to change the check here to ignore vehicles older than 1993 or newer than 2010
                    If intEngineModelYear < 1993 OrElse intEngineModelYear > 2009 Then
                        Continue While
                    End If

                    'if CStr(.Range(EMYComplianceCells(EngineModelYear)).value) > "" then
                    '	.Range(EMYComplianceCells(EngineModelYear)).value = .Range(EMYComplianceCells(EngineModelYear)).value & ", " '& chr(10)
                    'end if
                    'dim CellText as string = .Range(EMYComplianceCells(EngineModelYear)).value & objReader("UnitNoStr").replace(chr(10),"")
                    'dim unitNumbers as string() = cellText.split(",")
                    'cellText = ""
                    'for i = 0 to unitNumbers.length -1
                    '	cellText &= unitNumbers(i).trim() & ", "
                    '	if i mod 3 = 2 then
                    '		cellText &= chr(10)
                    '	end if
                    'next
                    'if cellText.endsWith(chr(10)) then
                    '	cellText = LEFT(cellText, cellText.length -1)
                    'end if
                    'if cellText.endsWith(", ") then
                    '	cellText = LEFT(cellText, cellText.length -2)
                    'end if
                    Dim cellText As String = objReader("UnitNoStr")
                    For Each unitNo As String In cellText.Split(New [Char]() {CChar(",")})
                        Dim cell As String = getCellAndIncrement(EngineModelYear, VehicleWeightClass, AccountBACTOption, EMYComplianceCells)
                        .Range(cell).value = unitNo.Replace(",", "")
                        .Range(cell).select
                    Next


                    'dim rowNumber as integer = Regex.replace(EMYComplianceCells(EngineModelYear), "[A-Z]","")
                    '.Rows(rowNumber & ":" & rowNumber).EntireRow.AutoFit()
                    '.Rows(rowNumber & ":" & rowNumber).rowHeight = Math.Max(12 * (cellText.split(chr(10)).length),18.75)
                    'if .Rows(rowNumber & ":" & rowNumber).rowHeight > 100 then ' MG - excel likes to cut just the bottom of the text off for tall rows.  give it a little extra white space
                    '	.Rows(rowNumber & ":" & rowNumber).rowHeight += 12
                    'end if
                    'With .Selection
                    '	.HorizontalAlignment = -4131 'xlLeft
                    '	.VerticalAlignment = -4160 'xlCenter
                    '	.Font.Bold = false
                    '	.Font.Size = 9
                    'End With

                    ' resize all rows
                    'dim cellText as string = .Range(EMYComplianceCells(EngineModelYear)).value
                    '					dim lineCount as integer = cellText.split(chr(10)).length - 1
                    '					dim iEngineModelYear as integer
                    '					if Integer.tryParse(EngineModelYear, iEngineModelYear) then
                    '						dim firstRowNumber as integer = CInt(Regex.Replace(EMYComplianceCells(EngineModelYear), "[A-Za-z]",""))
                    '						dim lastRowNumber as integer
                    '						if EMYComplianceCells.containsKey(iEngineModelYear+1) then
                    '							dim nextCell as string = EMYComplianceCells(iEngineModelYear+1)
                    '							lastRowNumber = CInt(Regex.Replace(nextCell, "[A-Za-z]","")) - 1 ' next cell, up one row
                    '						else
                    '							lastRowNumber = firstRowNumber
                    '						end if
                    '						.Rows(firstRowNumber  & ":" & lastRowNumber).select
                    '						'.Selection.rowHeight = 20
                    '					end if


                End While
                'Response.end()


                'dim schemaTable as DataTable = objReader.GetSchemaTable()

                'while objReader.read()
                '					
                '					for i as integer = 0 to objReader.FieldCount -1
                '						if columns.containsKey(objReader.GetName(i)) then
                '							if IsDbNull(objReader(i)) then
                '								' do nothing
                '							else
                '								dim cellFormat as string = .Range(columns(objReader.GetName(i))  & row).NumberFormat 
                '								if (cellFormat = "@" orElse cellFormat = "General") andAlso Double.tryParse(objReader(i), nothing) then
                '									.Range(columns(objReader.GetName(i))  & row).value = "'" & objReader(i)
                '								else
                '									.Range(columns(objReader.GetName(i))  & row).value = objReader(i)
                '								end if
                '							end if
                '						end if
                '					next
                '					row += 1
                '				end while

                ' save Excel file as report
                Try
                    createPDF(.ActiveWorkbook, Path.Combine(PathSpec, filename))
                Catch exc As NotSupportedException
                    filename = filename.Replace(".pdf", ".xls")
                    .ActiveWorkbook.SaveAs(Path.Combine(PathSpec, filename))
                Finally
                    .ActiveWorkbook.close(SaveChanges:=False)
                End Try


                '
                '.Visible = True
            End With
        Finally
            objReader.Close()
            conn.Close()
            If oExcel IsNot Nothing Then

                oExcel.Quit()
                'oExcel.dispose()
                oExcel = Nothing
            End If

        End Try
        Return Path.Combine(PathSpec, filename)
        ' return path or byte[]?
    End Function

    '10/08/2012 IR: Fixed logical errors in code used to select the appropriate cell for the next vehicle. Since some model years shared the same column
    'they needed to be under the same key value in EMYComplianceCells. Had to change key values and mapping of model year to key value.
    Private Function getCellAndIncrement(ByVal EngineModelYear As String, ByVal VehicleWeightClass As String, ByVal AccountBACTOption As String, ByRef EMYComplianceCells As Dictionary(Of String, String)) As String
        Dim key As String = Nothing
        Dim intModelYear As Integer = Nothing
        Integer.TryParse(EngineModelYear, intModelYear)
        Select Case VehicleWeightClass
            Case "4-6"
                Select Case intModelYear
                    Case 1993 To 1995
                        key = "9395"
                    Case 1996 To 1999
                        key = EngineModelYear
                    Case 2000 To 2003
                        key = "0003"
                    Case 2004 To 2006
                        key = "0406"
                    Case 2007 To 2009
                        key = "0709"
                End Select
            Case "7-8"
                If Trim(AccountBACTOption) = "OPTION1" Then
                    Select Case intModelYear
                        Case 1993
                            key = "1993"
                        Case 1994 To 1995
                            key = "9495"
                        Case 1996 To 1999
                            key = "9699"
                        Case 2000 To 2004
                            key = "0004"
                        Case 2005 To 2006
                            key = "0506"
                        Case 2007 To 2009
                            key = "0709"
                    End Select
                ElseIf Trim(AccountBACTOption) = "OPTION2" Then
                    Select Case intModelYear
                        Case 1993
                            key = "1993"
                        Case 1994 To 1999
                            key = "9499"
                        Case 2000 To 2002
                            key = "0002"
                        Case 2003 To 2004
                            key = "0304"
                        Case 2005 To 2006
                            key = "0506"
                        Case 2007 To 2009
                            key = "0709"
                    End Select
                End If
            Case Else
                Throw New ArgumentException("Invalid Vehicle Weight Class")
        End Select

        Dim cell As String = EMYComplianceCells(key)
        Dim rowNumber As Integer = Regex.Replace(cell, "[A-Z]", "")
        Dim columnLetter As String = Regex.Replace(cell, "[0-9]", "")
        Dim nextCell = columnLetter & (rowNumber + 1)
        EMYComplianceCells(key) = nextCell

        Return cell
    End Function

    Private Function GetColumnLetter(ColumnNumber As Integer) As String
        Dim columnLetter As String
        If ColumnNumber <= 26 Then
            ' Columns A-Z
            columnLetter = Chr(ColumnNumber + 64)
        Else
            ' MG 1/20/2012 - Was using ColumnNumber-1, but that was returning @Z instead of AA for ColumnNumber = 26
            columnLetter = Chr(Int((ColumnNumber - 1) / 26) + 64) &
                              Chr(((ColumnNumber - 1) Mod 26) + 65)
        End If

        Return columnLetter
    End Function

    Private Function GetColumnNumber(ColumnLetter As String) As Integer
        Dim ColumnNumber As Integer
        ColumnLetter = ColumnLetter.Trim().ToUpper()
        If String.IsNullOrEmpty(ColumnLetter) OrElse Not Regex.IsMatch(ColumnLetter, "^[A-Z]{1,2}$") Then
            Throw New ArgumentException("Invalid ColumnLetter " & ColumnLetter)
        End If
        If ColumnLetter.Length = 1 Then
            ColumnNumber = Asc(ColumnLetter) - 64
        Else
            ColumnNumber = (Asc(ColumnLetter.Substring(0, 1)) - 64) * 26 + GetColumnNumber(ColumnLetter.Substring(1, 1))
        End If

        Return ColumnNumber
    End Function

    Private Function createPDF(Workbook As Object, Filespec As String) As String
        'Dim FileFormatStr As String  --WARNINGS commented out by due to not being used Sam 2/20
        Dim exportPDFPath As String
        exportPDFPath = Path.Combine(System.Environment.GetFolderPath(Environment.SpecialFolder.CommonProgramFiles),
          "Microsoft Shared\Office" & CInt(Workbook.Application.Version) & "\EXP_PDF.dll")
        If File.Exists(exportPDFPath) Then
            'XlFixedFormatType.xlTypePDF = 0
            'XlFixedFormatQuality.xlQualityStandard = 0

            Workbook.ExportAsFixedFormat(Type:=0, Filename:=Filespec, Quality:=0, IncludeDocProperties:=True,
              IgnorePrintAreas:=False, OpenAfterPublish:=False)

            Return Filespec
        Else
            Throw New NotSupportedException("Microsoft SendToPDF for Excel is not installed on this server or using wrong Excel installation. Could not find dependent file '" & exportPDFPath & "'")
        End If

    End Function
End Class


