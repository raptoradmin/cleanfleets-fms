Imports OfficeOpenXml
Imports OfficeOpenXml.Style
Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.IO
Imports Telerik.Web.UI
Public Class ClientOpacityTestingResults
    Inherits BaseWebForm

    Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        Dim IDProfileAccount As String = "IDProfileAccount"
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim query As String = "SELECT IDProfileAccount, IDProfileContact, ContactName, Account FROM CFV_Profile_Contact WHERE UserName = @UserName"

        Using myConnection As New SqlConnection(connectionString)
            Dim myCommand As New SqlCommand(query, myConnection)
            myConnection.Open()
            myCommand.Parameters.AddWithValue("@UserName", User.Identity.Name)
            Dim MyReader As SqlDataReader = myCommand.ExecuteReader
            MyReader.Read()
            Session("IDProfileAccount") = MyReader("IDProfileAccount")
            Session("IDProfileContact") = MyReader("IDProfileContact")
            Session("AccountName") = MyReader("Account")

            'lbl_User.Text = If(isDbNull(MyReader("ContactName")), "", MyReader("ContactName"))
            'useridlabel.Text = IIf(IsDBNull(MyReader("Account")), "Account Name: unknown ", "Account Name: " & Session("AccountName"))
            'Label6.Text = "Account ID: " & Session("IDProfileAccount").ToString()
            myConnection.Close()
        End Using

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim IDProfileAccount As Integer = Convert.ToInt32(Session("IDProfileAccount").ToString())

        If Not Page.IsPostBack Then
            fillTerminals(Convert.ToInt32(Session("IDProfileAccount").ToString()))
            fillFleets(0)
        End If

    End Sub

    Protected Sub ddl_Terminal_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileTerminal As Integer = Convert.ToInt32(ddl_Terminal.SelectedValue.ToString())

        'Response.Write("Terminal ID: " & IDProfileTerminal)

        fillFleets(IDProfileTerminal)
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
        Else
            ddl_Terminal.Items.Clear()
        End If
    End Sub

    Protected Sub fillFleets(IDProfileTerminal As Integer)
        'Response.Write("Terminal ID: " & IDProfileTerminal.ToString())
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
        Else
            ddl_Fleet.Items.Clear()
        End If
    End Sub

    Protected Sub btn_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Report.Click
        Dim MIN_DATE As DateTime = New Date(1990, 1, 1)
        Dim MAX_DATE = New Date(2099, 12, 31)

        If Page.IsValid() Then
            Dim IDProfileFleet As Integer = 0
            Integer.TryParse(ddl_Fleet.SelectedValue, IDProfileFleet)
            Dim IDProfileTerminal As Integer = 0
            Integer.TryParse(ddl_Terminal.SelectedValue, IDProfileTerminal)
            Dim IDProfileAccount As Integer = CInt(Session("IDProfileAccount").ToString()) 'CInt(ddl_Account.SelectedValue)

            'Response.Write("Account Name: " & Session("AccountName").ToString())

            Dim AccountName As String = Session("AccountName").ToString()
            Dim FleetListItem As ListItem = Nothing
            FleetListItem = ddl_Fleet.SelectedItem
            Dim TerminalListItem As ListItem = Nothing
            TerminalListItem = ddl_Terminal.SelectedItem

            Dim Filename As String = AccountName & If(IDProfileTerminal > 0, "-" & TerminalListItem.Text, "") & If(IDProfileFleet > 0, "-" & FleetListItem.Text, "") & "_"
            Filename = Filename.Replace(",", "")

            Dim FromDate As DateTime = MIN_DATE
            Dim ThroughDate As DateTime = MAX_DATE
            Dim columnHeaderRow As Integer = 0
            If DateTime.TryParse(Me.FromDate.Text, FromDate) = False Then
                FromDate = MIN_DATE
            End If
            If DateTime.TryParse(Me.ThroughDate.Text, ThroughDate) = False Then
                ThroughDate = MAX_DATE
            End If

            Dim dt As New DataTable()
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
            'GOOD TO HERE - Response.Write("<br />" & dt.Rows.Count())
            If dt.Rows.Count = 0 Then
                Messages.Text = "No records found"
                Return
            End If

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
                worksheet.Cells("A" & row).Value = String.Format("Account: {0}", AccountName)
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

                Response.Clear()
                Response.ClearHeaders()
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                Response.AddHeader("content-disposition", String.Format("attachment;  filename={0}OpacityTestingResults.xlsx", Filename))
                'Dim stream As MemoryStream = New MemoryStream(package.GetAsByteArray())
                'Response.OutputStream.Write(stream.ToArray(), 0, stream.ToArray().Length)
                package.SaveAs(Response.OutputStream)
                Response.Flush()
                ' Response.Close() ' originally was response.close, but on slow connections, it sends s RST packet to client -> file won't download
                Response.End() ' then I tried resposne.end(). This works, but it's not recommended.
                'Response.SuppressContent = True
                Context.ApplicationInstance.CompleteRequest()
            End Using
        End If
    End Sub

    Sub cf_ddl_Validate(sender As Object, args As ServerValidateEventArgs)
        Dim value As Integer
        args.IsValid = True
        If args.IsValid Then args.IsValid = (Integer.TryParse(args.Value, value) AndAlso value > 0)
    End Sub

End Class
