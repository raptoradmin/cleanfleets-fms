Imports OfficeOpenXml
Imports OfficeOpenXml.Style
Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.IO
Imports Telerik.Web.UI
Public Class report_opacity_testing_results
    Inherits BaseWebForm

    Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)

    ' Added on 12/17/2019 for the purpose of letting the user export a PSIP Report for all the vehicles.

    Dim ID_And_Name_DataTable As New DataTable()

    ' End of what was added on 12/17/2019.

    ' Added on 1/24/2020 to facilitate custom columns in the PSIP Report - Sam 

    Dim columnList As New List(Of String)({"Location", "Unit No.", "VIN", "License Plate",
                                         "Vehicle Make", "Engine Manufacturer", "Engine Model Year", "DECS Level",
                                         "Pass/Fail", "Test Avg (%)", "Date Tested", "Tester", "Mileage"})
    Dim MIN_DATE As DateTime = New Date(1990, 1, 1)
    Dim MAX_DATE = New Date(2099, 12, 31) ' Should this just be the current date? -Sam --TODO

    ' Generates a series of checkbox controls based on the columnList variable
    Private Sub generateCheckboxes()
        'Codes for A1 Metals -> on road -> on road
        'Profile: 55
        'Terminal: 1156
        'Fleet: 1643

        'Do a short query to get the columns being used  - seems to cause performance issues
        'Dim dt As DataTable = New DataTable()
        'Using conn As New SqlConnection(connectionString)
        '           Using adapter As New SqlDataAdapter("EXEC ReportOpacityTestingResults @IDProfileAccount, @IDProfileTerminal, @IDProfileFleet, @FromDate, @ThroughDate", conn)
        '              adapter.SelectCommand.Parameters.AddWithValue("@IDProfileAccount", 55)
        '             adapter.SelectCommand.Parameters.AddWithValue("@IDProfileTerminal", 1156)
        '            adapter.SelectCommand.Parameters.AddWithValue("@IDProfileFleet", 1643)
        '           adapter.SelectCommand.Parameters.AddWithValue("@FromDate", DBNull.value)
        '          adapter.SelectCommand.Parameters.AddWithValue("@ThroughDate", DBNull.value)
        '         adapter.Fill(dt)
        '    End Using
        'End Using

        Dim count As Integer = 0
        For Each col In columnList
            Dim checkbox As CheckBox = New CheckBox()
            checkbox.ID = col
            checkbox.Text = col
            checkbox.Checked = True
            ColumnPanel.Controls.Add(checkbox)
            count = count + 1
            If (count Mod 3) = 0 Then
                ColumnPanel.Controls.Add(New HtmlGenericControl("br"))
            End If

        Next
    End Sub

    'Generates custom reporting checkboxes when the column panel is loaded
    Private Sub ColumnPanel_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        generateCheckboxes()
    End Sub
    ' End of custom PSIP reporting additions 







    Protected Sub ddl_Account_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)

        ' Added by Andrew on 12/17/2019 for the purpose of letting the user select all PSIP records.

        If (ddl_Account.SelectedItem.Text <> "Select All Vehicles") Then

            Dim IDProfileAccount As Integer = Convert.ToInt32(ddl_Account.SelectedValue.ToString())

            fillTerminals(IDProfileAccount)

        ElseIf (ddl_Account.SelectedItem.Text = "Select All Vehicles") Then

            Dim Sql_Conn As New SqlConnection(connectionString)

            If Sql_Conn.State = ConnectionState.Closed Then

                Sql_Conn.Open()

            End If

            Dim Sql_Adapter = New SqlDataAdapter("SELECT CF_Profile_Account.IDProfileAccount, CF_Profile_Account.AccountName, CF_Profile_Terminal.IDProfileTerminal, CF_Profile_Terminal.TerminalName, CF_Profile_Fleet.IDProfileFleet, CF_Profile_Fleet.FleetName FROM CF_Profile_Fleet INNER JOIN CF_Profile_Terminal On CF_Profile_Terminal.IDProfileTerminal = CF_Profile_Fleet.IDProfileTerminal INNER JOIN CF_Profile_Account On CF_Profile_Account.IDProfileAccount = CF_Profile_Terminal.IDProfileAccount", Sql_Conn)

            Sql_Adapter.Fill(ID_And_Name_DataTable)

            ' RecordsButton.Text = ID_And_Name_DataTable.Rows(4).Item("IDProfileFleet")

            ' RecordsButton.Text = ID_And_Name_DataTable.Rows.Count.ToString()

            ' (SELECT CF_Profile_Terminal.IDProfileAccount FROM CF_Vehicles INNER JOIN CF_Profile_Fleet ON CF_Profile_Fleet.IDProfileFleet = CF_Vehicles.IDProfileFleet INNER JOIN CF_Profile_Terminal ON CF_Profile_Terminal.IDProfileTerminal = CF_Profile_Fleet.IDProfileTerminal WHERE CF_Vehicles.IDVehicles = @FINALIDVEHICLES

        End If

        ' Added by Andrew on 11/12/2019 for the purpose of letting the user select all PSIP records.

        ' fillFleets(IDProfileAccount)

        ' End of what was added by Andrew
    End Sub

    Protected Sub ddl_Terminal_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)

        ' Added by Andrew on 11/12/2019 for the purpose of letting the user select all PSIP records.

        ' Dim Temp_ddl_Account As DropDownList = CType(FindControl("ddl_Account"), DropDownList)

        'If Temp_ddl_Account.SelectedValue = -1 Then

        '    Dim IDProfileTerminal As Integer = -1
        '    fillFleets(IDProfileTerminal)

        'Else

        ' End of what was added by Andrew on 11/12/2019.

        Dim IDProfileTerminal As Integer = Convert.ToInt32(ddl_Terminal.SelectedValue.ToString())
        fillFleets(IDProfileTerminal)

        ' Added by Andrew on 11/12/2019 for the purpose of letting the user select all PSIP records.

        ' End If

        ' End of what was added by Andrew on 11/12/2019.
    End Sub


    Protected Sub fillTerminals(IDProfileAccount As Integer)
        If IDProfileAccount > 0 Then

            Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)

            Dim adapter As New SqlDataAdapter("SELECT IDProfileTerminal, TerminalName FROM [CF_Profile_Terminal] WHERE ([IDProfileAccount] = @IDProfileAccount) ORDER BY [TerminalName]", connection)
            adapter.SelectCommand.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)

            Dim dt As New DataTable()
            adapter.Fill(dt)

            ddl_Terminal.DataTextField = "TerminalName"
            ddl_Terminal.DataValueField = "IDProfileTerminal"
            ddl_Terminal.DataSource = dt
            ddl_Terminal.DataBind()
            ddl_Terminal.Items.Insert(0, New ListItem("- Select Terminal -", "0"))

            ' Added by Andrew on 11/12/2019 to try and export all PSIP records.

            'ElseIf (IDProfileAccount = -1) Then

            '    Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)

            '    Dim adapter As New SqlDataAdapter("SELECT IDProfileTerminal, TerminalName FROM [CF_Profile_Terminal] ORDER BY [TerminalName]", connection)

            '    Dim dt As New DataTable()
            '    adapter.Fill(dt)

            '    ddl_Terminal.DataTextField = "TerminalName"
            '    ddl_Terminal.DataValueField = "IDProfileTerminal"
            '    ddl_Terminal.DataSource = dt
            '    ddl_Terminal.DataBind()
            '    ddl_Terminal.Items.Insert(0, New ListItem("- Select Terminal -", "0"))

            ' End of what was added by Andrew.

        Else
            ddl_Terminal.Items.Clear()
        End If
    End Sub


    Protected Sub fillFleets(IDProfileTerminal As Integer)
        If IDProfileTerminal > 0 Then
            Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)

            Dim adapter As New SqlDataAdapter("SELECT IDProfileFleet, FleetName FROM [CF_Profile_Fleet] WHERE ([IDProfileTerminal] = @IDProfileTerminal)", connection)
            adapter.SelectCommand.Parameters.AddWithValue("@IDProfileTerminal", IDProfileTerminal)

            Dim dt As New DataTable()
            adapter.Fill(dt)

            ddl_Fleet.DataTextField = "FleetName"
            ddl_Fleet.DataValueField = "IDProfileFleet"
            ddl_Fleet.DataSource = dt
            ddl_Fleet.DataBind()
            ddl_Fleet.Items.Insert(0, New ListItem("- Select Fleet -", "0"))

            ' Added by Andrew on 11/12/2019 to try and export all PSIP records.

            'ElseIf (IDProfileTerminal = -1) Then

            '    Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)

            '    Dim adapter As New SqlDataAdapter("SELECT IDProfileFleet, FleetName FROM [CF_Profile_Fleet]", connection)

            '    Dim dt As New DataTable()
            '    adapter.Fill(dt)

            '    ddl_Fleet.DataTextField = "FleetName"
            '    ddl_Fleet.DataValueField = "IDProfileFleet"
            '    ddl_Fleet.DataSource = dt
            '    ddl_Fleet.DataBind()
            '    ddl_Fleet.Items.Insert(0, New ListItem("- Select Fleet -", "0"))

            ' End of what was added by Andrew.

        Else
            ddl_Fleet.Items.Clear()
        End If
    End Sub

    Private Function opacity_reporting_procedure(ByVal IDProfileAccount, ByVal IDProfileTerminal, ByVal IDProfileFleet, ByVal FromDate, ByVal ThroughDate) As DataTable
        ' DataTable to store results
        Dim dt As New DataTable()

        ' Fetch data using the ReportOpacityTestingResults procedure in the database

        Using conn As New SqlConnection(connectionString)
            Using adapter As New SqlDataAdapter("EXEC ReportOpacityTestingResults @IDProfileAccount, @IDProfileTerminal, @IDProfileFleet, @FromDate, @ThroughDate", conn)
                adapter.SelectCommand.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
                adapter.SelectCommand.Parameters.AddWithValue("@IDProfileTerminal", IDProfileTerminal)
                adapter.SelectCommand.Parameters.AddWithValue("@IDProfileFleet", IDProfileFleet)
                If FromDate > MIN_DATE Then
                    adapter.SelectCommand.Parameters.AddWithValue("@FromDate", FromDate)
                Else
                    adapter.SelectCommand.Parameters.AddWithValue("@FromDate", DBNull.Value)
                End If
                If ThroughDate < MAX_DATE Then
                    adapter.SelectCommand.Parameters.AddWithValue("@ThroughDate", ThroughDate)
                Else
                    adapter.SelectCommand.Parameters.AddWithValue("@ThroughDate", DBNull.Value)
                End If
                adapter.Fill(dt)
            End Using
        End Using
        Return dt
    End Function
    Private Sub filterReport(ByRef dt As DataTable)
        ' Added by Sam 1/23 to test out selective reporting
        For Each c As Control In ColumnPanel.Controls
            Dim check As CheckBox = TryCast(c, CheckBox)
            If check IsNot Nothing Then
                If check.Checked <> True Then
                    dt.Columns.Remove(check.ID)
                End If
            End If
        Next
        ' End Sam
    End Sub
    Protected Sub btn_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Report.Click
        If Page.IsValid() Then

            ' Added conditional statement for the purpose of allowing the user to generate a PSIP Report showing all the records; Andrew - 12/17/2019.

            If (ddl_Account.SelectedItem.Text <> "Select All Vehicles") Then
                ' Get dates, set to MIN_DATE and MAX_DATE if there's any errors
                Dim FromDate As DateTime = MIN_DATE
                Dim ThroughDate As DateTime = MAX_DATE
                Dim columnHeaderRow As Integer = 0
                If DateTime.TryParse(Me.FromDate.Text, FromDate) = False Then
                    FromDate = MIN_DATE
                End If
                If DateTime.TryParse(Me.ThroughDate.Text, ThroughDate) = False Then
                    ThroughDate = MAX_DATE
                End If
                ' Get all the ID numbers
                Dim IDProfileFleet As Integer = 0
                Integer.TryParse(ddl_Fleet.SelectedValue, IDProfileFleet)

                Dim IDProfileTerminal As Integer = 0
                Integer.TryParse(ddl_Terminal.SelectedValue, IDProfileTerminal)

                Dim IDProfileAccount As Integer = CInt(ddl_Account.SelectedValue)
                Dim AccountListItem As ListItem = ddl_Account.SelectedItem

                Dim FleetListItem As ListItem = Nothing
                FleetListItem = ddl_Fleet.SelectedItem

                Dim TerminalListItem As ListItem = Nothing
                TerminalListItem = ddl_Terminal.SelectedItem

                ' Setup the name of the file to be downloaded
                Dim Filename As String = AccountListItem.Text & If(IDProfileTerminal > 0, "-" & TerminalListItem.Text, "") & If(IDProfileFleet > 0, "-" & FleetListItem.Text, "") & "_"
                Filename = Filename.Replace(",", "")

                ' Fetch data using the ReportOpacityTestingResults procedure in the database
                Dim dt As DataTable = opacity_reporting_procedure(IDProfileAccount, IDProfileTerminal, IDProfileFleet, FromDate, ThroughDate)

                If dt.Rows.Count = 0 Then
                    Messages.Text = "No records found"
                    Return
                End If

                'Adjust report based on column checkboxes
                filterReport(dt)



                ' Add headers
                'Dim newFile As New FileInfo(filepath)
                Using package As New ExcelPackage()
                    Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("PSIP Test Results")
                    'fill header information
                    Dim row As Integer = 1
                    Using range As ExcelRange = worksheet.Cells("A" & row)
                        range.Value = "PSIP Test Results"
                        range.Style.Font.Size = 16
                        range.Style.Font.Bold = True
                    End Using
                    row += 1
                    worksheet.Cells("A" & row).Value = String.Format("Report Date: {0:d}", DateTime.Now())
                    row += 1
                    worksheet.Cells("A" & row).Value = String.Format("Account: {0}", AccountListItem.Text)
                    row += 1
                    If IDProfileTerminal > 0 Then
                        worksheet.Cells("A" & row).Value = String.Format("Terminal: {0}", TerminalListItem.Text)
                        row += 1
                    End If
                    If IDProfileFleet > 0 Then
                        worksheet.Cells("A" & row).Value = String.Format("Fleet: {0}", FleetListItem.Text)
                        row += 1
                    End If
                    If FromDate > MIN_DATE Then
                        worksheet.Cells("A" & row).Value = String.Format("From Date: {0:d}", FromDate)
                        row += 1
                    End If
                    If ThroughDate < MAX_DATE Then
                        worksheet.Cells("A" & row).Value = String.Format("Through Date: {0:d}", ThroughDate)
                        row += 1
                    End If
                    row += 1 ' extra space between header and content



                    'fill cells with data from table and format
                    columnHeaderRow = row
                    worksheet.Cells("A" & row).LoadFromDataTable(dt, True)
                    Using range As ExcelRange = worksheet.Cells(row, 1, row, dt.Columns.Count)
                        range.Style.Font.Bold = True
                        range.Style.Border.Bottom.Style = ExcelBorderStyle.Thin
                        'range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
                    End Using
                    For i = 1 To dt.Columns.Count
                        Dim columnTitle As String
                        columnTitle = worksheet.Cells(row, i).Value
                        If String.Format(" {0} ", columnTitle) Like "* Date *" Then
                            With worksheet.Column(i)
                                .Style.Numberformat.Format = "mm/dd/yyyy"
                                'dim colFromHex as Color = System.Drawing.ColorTranslator.FromHtml("#B7DEE8")
                                '.Style.Fill.PatternType = Style.ExcelFillStyle.Solid
                                '.Style.fill.backgroundcolor.SetColor(colFromHex)
                            End With
                        End If
                        If String.Format(" {0} ", columnTitle) Like "* Mileage *" Then
                            With worksheet.Column(i)
                                .Style.Numberformat.Format = "#,##0"
                            End With
                        End If
                    Next
                    'Using range As ExcelRange = worksheet.Cells(1, 1, dt.Rows.Count + 2, dt.Columns.Count)
                    '	range.Style.Border.Top.Style = ExcelBorderStyle.Thin
                    '	range.Style.Border.Bottom.Style = ExcelBorderStyle.Thin
                    '	range.Style.Border.Left.Style = ExcelBorderStyle.Thin
                    '	range.Style.Border.Right.Style = ExcelBorderStyle.Thin
                    'End Using

                    worksheet.Cells.AutoFitColumns(0)
                    ' set image
                    Dim logo = Image.FromFile(Server.MapPath("~/includes/reports_console/cflogowings.jpg"))
                    Dim picture = worksheet.Drawings.AddPicture("CleanFleets.Net", logo)
                    picture.From.Column = 4
                    picture.From.Row = 0
                    Dim scale As Double = 0.35
                    picture.SetSize(logo.Width * scale, logo.Height * scale)

                    ' page layout settings
                    With worksheet.PrinterSettings
                        .RepeatRows = New ExcelAddress(String.Format("'{1}'!${0}:${0}", columnHeaderRow, worksheet.Name))
                        .Orientation = eOrientation.Landscape
                        .FitToPage = True
                        .FitToHeight = 999
                        .FitToWidth = 1
                        .TopMargin = 0.5
                        .BottomMargin = 0.75
                        .LeftMargin = 0.5
                        .RightMargin = 0.5
                    End With

                    ' header and footers
                    With worksheet.HeaderFooter
                        .differentFirst = False
                        .FirstFooter.LeftAlignedText = String.Format("PSIP Test Results{0}{1:d}", vbCrLf, DateTime.Now())
                        .FirstFooter.RightAlignedText = String.Format("Page {0} of {1}", ExcelHeaderFooter.PageNumber, ExcelHeaderFooter.NumberOfPages)
                        .EvenFooter.LeftAlignedText = .FirstFooter.LeftAlignedText
                        .EvenFooter.RightAlignedText = .FirstFooter.RightAlignedText
                        .OddFooter.LeftAlignedText = .FirstFooter.LeftAlignedText
                        .OddFooter.RightAlignedText = .FirstFooter.RightAlignedText
                    End With


                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                    Response.AddHeader("content-disposition", String.Format("attachment;  filename={0}OpacityTestingResults.xlsx", Filename))
                    'Dim stream As MemoryStream = New MemoryStream(package.GetAsByteArray())
                    'Response.OutputStream.Write(stream.ToArray(), 0, stream.ToArray().Length)
                    package.SaveAs(Response.OutputStream)
                    Response.Flush()
                    ' Response.Close() ' originally was response.close, but on slow connections, it sends s RST packet to client -> file won't download
                    'Response.End() ' then I tried resposne.end(). This works, but it's not recommended.
                    Response.SuppressContent = True
                    Context.ApplicationInstance.CompleteRequest()
                End Using

            ElseIf (ddl_Account.SelectedItem.Text = "Select All Vehicles") Then
                Dim FromDate As DateTime = MIN_DATE
                Dim ThroughDate As DateTime = MAX_DATE
                Dim columnHeaderRow As Integer = 0
                If DateTime.TryParse(Me.FromDate.Text, FromDate) = False Then
                    FromDate = MIN_DATE
                End If
                If DateTime.TryParse(Me.ThroughDate.Text, ThroughDate) = False Then
                    ThroughDate = MAX_DATE
                End If

                'Added Sql_Row to cycle through all records in the datatable storing the 1233 Fleets; Andrew - 12/17/2019.

                Dim Filename As String = "All_Records_" & FromDate & "_" & ThroughDate

                Dim Sql_Conn As New SqlConnection(connectionString)

                If Sql_Conn.State = ConnectionState.Closed Then

                    Sql_Conn.Open()

                End If

                Dim Sql_Adapter = New SqlDataAdapter(
                    "SELECT CF_Profile_Account.IDProfileAccount, 
                    CF_Profile_Account.AccountName, 
                    CF_Profile_Terminal.IDProfileTerminal, 
                    CF_Profile_Terminal.TerminalName, 
                    CF_Profile_Fleet.IDProfileFleet, 
                    CF_Profile_Fleet.FleetName 
                    FROM 
                    CF_Profile_Fleet 
                    INNER JOIN CF_Profile_Terminal On CF_Profile_Terminal.IDProfileTerminal = CF_Profile_Fleet.IDProfileTerminal 
                    INNER JOIN CF_Profile_Account On CF_Profile_Account.IDProfileAccount = CF_Profile_Terminal.IDProfileAccount", Sql_Conn)

                Sql_Adapter.Fill(ID_And_Name_DataTable)

                ' RecordsButton.Text = ID_And_Name_DataTable.Rows(4).Item("IDProfileAccount").ToString()

                ' If(String.IsNullOrWhiteSpace(Caption), "Untitled", Caption)

                'Dim TempRow As DataRow

                'For Each TempRow In ID_And_Name_DataTable.Rows

                '    RecordsButton.Text = If(String.IsNullOrWhiteSpace(TempRow.Item("IDProfileAccount")), "There is Nothing", TempRow.Item("IDProfileAccount"))

                'Next

                Using package As New ExcelPackage()
                    Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("PSIP Test Results")
                    'fill header information
                    Dim row As Integer = 1
                    Using range As ExcelRange = worksheet.Cells("A" & row)
                        range.Value = "PSIP Test Results"
                        range.Style.Font.Size = 16
                        range.Style.Font.Bold = True
                    End Using
                    row += 1

                    worksheet.Cells("A" & row).Value = String.Format("Report Date: {0:d}", DateTime.Now())
                    row += 1

                    If FromDate > MIN_DATE Then
                        worksheet.Cells("A" & row).Value = String.Format("From Date: {0:d}", FromDate)
                        row += 1
                    End If

                    If ThroughDate < MAX_DATE Then
                        worksheet.Cells("A" & row).Value = String.Format("Through Date: {0:d}", ThroughDate)
                        row += 1
                    End If
                    row += 1 ' extra space between header and content

                    Dim IDProfileAccount As Integer
                    Dim IDProfileTerminal As Integer
                    Dim IDProfileFleet As Integer

                    Dim ProfileAccountNameString As String
                    ProfileAccountNameString = vbNullString

                    Dim dt As New DataTable()

                    ' I am going to comment out the connection string shown below and manually enter a connection string with a timeout property set; Andrew - 12/19/2019.

                    Dim ManualConnectionString As String
                    ManualConnectionString = ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString

                    Using conn As New SqlConnection(ManualConnectionString)

                        'IDProfileAccount = ID_And_Name_DataTable.Rows(4).Item("IDProfileAccount")
                        'IDProfileTerminal = ID_And_Name_DataTable.Rows(4).Item("IDProfileTerminal")
                        'IDProfileFleet = ID_And_Name_DataTable.Rows(4).Item("IDProfileFleet")

                        'Using adapter As New SqlDataAdapter("EXEC ReportOpacityTestingResults @IDProfileAccount, @IDProfileTerminal, @IDProfileFleet, @FromDate, @ThroughDate", conn)
                        '    adapter.SelectCommand.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
                        '    adapter.SelectCommand.Parameters.AddWithValue("@IDProfileTerminal", IDProfileTerminal)
                        '    adapter.SelectCommand.Parameters.AddWithValue("@IDProfileFleet", IDProfileFleet)
                        '    If FromDate > MIN_DATE Then
                        '        adapter.SelectCommand.Parameters.AddWithValue("@FromDate", FromDate)
                        '    Else
                        '        adapter.SelectCommand.Parameters.AddWithValue("@FromDate", DBNull.Value)
                        '    End If
                        '    If ThroughDate < MAX_DATE Then
                        '        adapter.SelectCommand.Parameters.AddWithValue("@ThroughDate", ThroughDate)
                        '    Else
                        '        adapter.SelectCommand.Parameters.AddWithValue("@ThroughDate", DBNull.Value)
                        '    End If
                        '    adapter.Fill(dt)
                        'End Using
                        Dim count = 1
                        For j = 1 To ID_And_Name_DataTable.Rows.Count

                            Dim temp_dt As New DataTable()

                            IDProfileAccount = ID_And_Name_DataTable.Rows(j - 1).Item("IDProfileAccount")
                            IDProfileTerminal = ID_And_Name_DataTable.Rows(j - 1).Item("IDProfileTerminal")
                            IDProfileFleet = ID_And_Name_DataTable.Rows(j - 1).Item("IDProfileFleet")

                            Using adapter As New SqlDataAdapter("EXEC ReportOpacityTestingResults @IDProfileAccount, @IDProfileTerminal, @IDProfileFleet, @FromDate, @ThroughDate", conn)

                                ' I am setting the "SelectCommand.CommandTimeout" to around 1000, meaning 1000 seconds; Andrew - 12/19/2019.

                                adapter.SelectCommand.CommandTimeout = 1000

                                adapter.SelectCommand.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
                                adapter.SelectCommand.Parameters.AddWithValue("@IDProfileTerminal", IDProfileTerminal)
                                adapter.SelectCommand.Parameters.AddWithValue("@IDProfileFleet", IDProfileFleet)
                                If FromDate > MIN_DATE Then
                                    adapter.SelectCommand.Parameters.AddWithValue("@FromDate", FromDate)
                                Else
                                    adapter.SelectCommand.Parameters.AddWithValue("@FromDate", DBNull.Value)
                                End If
                                If ThroughDate < MAX_DATE Then
                                    adapter.SelectCommand.Parameters.AddWithValue("@ThroughDate", ThroughDate)
                                Else
                                    adapter.SelectCommand.Parameters.AddWithValue("@ThroughDate", DBNull.Value)
                                End If
                                adapter.Fill(temp_dt)
                            End Using

                            For n = 1 To temp_dt.Rows.Count

                                ProfileAccountNameString = ProfileAccountNameString & ID_And_Name_DataTable.Rows(j - 1).Item("AccountName") & "?"

                            Next

                            dt.Merge(temp_dt)
                            Debug.WriteLine("Finished iteration " & count)
                            count += 1

                        Next

                    End Using
                    If dt.Rows.Count = 0 Then
                        Messages.Text = "No records found"
                        Return
                    End If
                    filterReport(dt)

                    ' I am adding the a Loop to append the "AccountName" to each value in the "Location" column; Andrew - 12/19/2019.

                    Dim previous_position = 0

                    For m = 1 To dt.Rows.Count

                        dt.Rows(m - 1).SetField("Location", Mid(ProfileAccountNameString, previous_position + 1, InStr(previous_position + 1, ProfileAccountNameString, "?") - previous_position - 1) & "/" & dt.Rows(m - 1).Item("Location").ToString())

                        previous_position = InStr(previous_position + 1, ProfileAccountNameString, "?")

                    Next

                    ' RecordsButton.Text = dt.Rows(5).Item("Location")

                    ' End of what was added by Andrew on 12/19/2019.

                    'fill cells with data from table
                    columnHeaderRow = row
                    worksheet.Cells("A" & row).LoadFromDataTable(dt, True)
                    Using range As ExcelRange = worksheet.Cells(row, 1, row, dt.Columns.Count)
                        range.Style.Font.Bold = True
                        range.Style.Border.Bottom.Style = ExcelBorderStyle.Thin
                        'range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
                    End Using
                    For i = 1 To dt.Columns.Count
                        Dim columnTitle As String
                        columnTitle = worksheet.Cells(row, i).Value
                        If String.Format(" {0} ", columnTitle) Like "* Date *" Then
                            With worksheet.Column(i)
                                .Style.Numberformat.Format = "mm/dd/yyyy"
                                'dim colFromHex as Color = System.Drawing.ColorTranslator.FromHtml("#B7DEE8")
                                '.Style.Fill.PatternType = Style.ExcelFillStyle.Solid
                                '.Style.fill.backgroundcolor.SetColor(colFromHex)
                            End With
                        End If
                        If String.Format(" {0} ", columnTitle) Like "* Mileage *" Then
                            With worksheet.Column(i)
                                .Style.Numberformat.Format = "#,##0"
                            End With
                        End If
                    Next
                    'Using range As ExcelRange = worksheet.Cells(1, 1, dt.Rows.Count + 2, dt.Columns.Count)
                    '	range.Style.Border.Top.Style = ExcelBorderStyle.Thin
                    '	range.Style.Border.Bottom.Style = ExcelBorderStyle.Thin
                    '	range.Style.Border.Left.Style = ExcelBorderStyle.Thin
                    '	range.Style.Border.Right.Style = ExcelBorderStyle.Thin
                    'End Using

                    worksheet.Cells.AutoFitColumns(0)

                    ' I am adding the a Loop to append the "AccountName" to each value in the "Location" column; Andrew - 12/19/2019.

                    'For 

                    ' End of what was added by Andrew on 12/19/2019.

                    ' set image
                    Dim logo = Image.FromFile(Server.MapPath("~/includes/reports_console/cflogowings.jpg"))
                    Dim picture = worksheet.Drawings.AddPicture("CleanFleets.Net", logo)
                    picture.From.Column = 4
                    picture.From.Row = 0
                    Dim scale As Double = 0.35
                    picture.SetSize(logo.Width * scale, logo.Height * scale)

                    ' page layout settings
                    With worksheet.PrinterSettings
                        .RepeatRows = New ExcelAddress(String.Format("'{1}'!${0}:${0}", columnHeaderRow, worksheet.Name))
                        .Orientation = eOrientation.Landscape
                        .FitToPage = True
                        .FitToHeight = 999
                        .FitToWidth = 1
                        .TopMargin = 0.5
                        .BottomMargin = 0.75
                        .LeftMargin = 0.5
                        .RightMargin = 0.5
                    End With

                    ' header and footers
                    With worksheet.HeaderFooter
                        .differentFirst = False
                        .FirstFooter.LeftAlignedText = String.Format("PSIP Test Results{0}{1:d}", vbCrLf, DateTime.Now())
                        .FirstFooter.RightAlignedText = String.Format("Page {0} of {1}", ExcelHeaderFooter.PageNumber, ExcelHeaderFooter.NumberOfPages)
                        .EvenFooter.LeftAlignedText = .FirstFooter.LeftAlignedText
                        .EvenFooter.RightAlignedText = .FirstFooter.RightAlignedText
                        .OddFooter.LeftAlignedText = .FirstFooter.LeftAlignedText
                        .OddFooter.RightAlignedText = .FirstFooter.RightAlignedText
                    End With


                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                    Response.AddHeader("content-disposition", String.Format("attachment;  filename={0}OpacityTestingResults.xlsx", Filename))
                    'Dim stream As MemoryStream = New MemoryStream(package.GetAsByteArray())
                    'Response.OutputStream.Write(stream.ToArray(), 0, stream.ToArray().Length)
                    package.SaveAs(Response.OutputStream)
                    Response.Flush()
                    ' Response.Close() ' originally was response.close, but on slow connections, it sends s RST packet to client -> file won't download
                    'Response.End() ' then I tried resposne.end(). This works, but it's not recommended.
                    Response.SuppressContent = True
                    Context.ApplicationInstance.CompleteRequest()

                End Using

            End If

        End If

    End Sub


    Sub cf_ddl_Validate(sender As Object, args As ServerValidateEventArgs)
        Dim value As Integer
        args.IsValid = True
        If args.IsValid Then args.IsValid = (Integer.TryParse(args.Value, value) AndAlso value > 0) ' Or value = -1 --> Added by Andrew on 11/12/2019 to try to export all PSIP records.
    End Sub

End Class
