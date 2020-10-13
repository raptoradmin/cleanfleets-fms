Imports OfficeOpenXml
Imports OfficeOpenXml.Style
Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.IO
Imports Telerik.Web.UI
Public Class report_opacity_testing
    Inherits BaseWebForm
    Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)

    Protected Sub ddl_Account_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileAccount As Integer = Convert.ToInt32(ddl_Account.SelectedValue.ToString())
        fillTerminals(IDProfileAccount)
        fillFleets(0)
    End Sub

    Protected Sub ddl_Terminal_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileTerminal As Integer = Convert.ToInt32(ddl_Terminal.SelectedValue.ToString())
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
            ddl_Terminal.Items.Clear()
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
            ddl_Fleet.Items.Clear()
        End If
    End Sub


    Protected Sub btn_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Report.Click
        If Page.IsValid() Then
            Dim IDProfileFleet As Integer = CInt(ddl_Fleet.SelectedValue)
            Dim IDProfileTerminal As Integer = CInt(ddl_Terminal.SelectedValue)
            Dim AccountListItem As ListItem = ddl_Account.SelectedItem
            Dim FleetListItem As ListItem = ddl_Fleet.SelectedItem
            Dim TerminalListItem As ListItem = ddl_Terminal.SelectedItem
            Dim Filename As String = AccountListItem.Text & "-" & TerminalListItem.Text & IIf(IDProfileFleet > 0, "-" & FleetListItem.Text, "") & "_"
            Dim dt As New DataTable()
            Using conn As New SqlConnection(connectionString)
                Using adapter As New SqlDataAdapter("EXEC [ReportOpacityTesting] @IDProfileTerminal, @IDProfileFleet", conn)
                    adapter.SelectCommand.Parameters.AddWithValue("@IDProfileTerminal", IDProfileTerminal)
                    adapter.SelectCommand.Parameters.AddWithValue("@IDProfileFleet", IDProfileFleet)
                    adapter.Fill(dt)
                End Using
            End Using

            If dt.Rows.Count = 0 Then
                Messages.Text = "No records found"
                Return
            End If

            'Dim newFile As New FileInfo(filepath)
            Using package As New ExcelPackage()
                Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("OpacityTesting")
                'fill header information
                Dim row As Integer = 1
                Using range As ExcelRange = worksheet.Cells("A" & row)
                    range.Value = String.Format("{0} {1} Field Report", AccountListItem.Text, TerminalListItem.Text)
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
                'if FromDate > MIN_DATE
                '	worksheet.Cells("A" & row).Value =  String.format("From Date: {0:d}", FromDate)
                '	row += 1
                'end if
                'if ThroughDate < MAX_DATE
                '	worksheet.Cells("A" & row).Value =  String.format("Through Date: {0:d}", ThroughDate)
                '	row += 1
                'end if
                row += 1 ' extra space between header and content

                'fill cells with data from table
                worksheet.Cells("A" & row).LoadFromDataTable(dt, True)
                Using range As ExcelRange = worksheet.Cells(row, 1, row, dt.Columns.Count)
                    range.Style.Font.Bold = True
                    'range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
                End Using
                Using range As ExcelRange = worksheet.Cells(row, 1, dt.Rows.Count + row, dt.Columns.Count)
                    range.Style.Border.Top.Style = ExcelBorderStyle.Thin
                    range.Style.Border.Bottom.Style = ExcelBorderStyle.Thin
                    range.Style.Border.Left.Style = ExcelBorderStyle.Thin
                    range.Style.Border.Right.Style = ExcelBorderStyle.Thin
                    range.Style.Font.Size = 14
                    range.Style.Font.Bold = True
                End Using

                worksheet.Cells.AutoFitColumns(0)
                For i = 2 To dt.Columns.Count
                    worksheet.Column(i).Width += 1
                Next


                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                Response.AddHeader("content-disposition", String.Format("attachment;  filename={0}OpacityTestingExport.xlsx", Filename))
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
    End Sub


    Sub cf_ddl_Validate(sender As Object, args As ServerValidateEventArgs)
        Dim value As Integer
        args.IsValid = True
        If args.IsValid Then args.IsValid = (Integer.TryParse(args.Value, value) AndAlso value > 0)
    End Sub

End Class
