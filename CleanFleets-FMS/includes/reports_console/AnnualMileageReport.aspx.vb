Imports OfficeOpenXml
Imports OfficeOpenXml.Style
Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.IO
Imports Telerik.Web.UI
Imports FMS.ServiceFacade
Imports FMS.Entity.DTO
Imports FMS.Entity.Criteria

Public Class AnnualMileageReport
    Inherits BaseWebForm
    Dim facade As AnnualMileageReportService()

    ' When clicking the Annual Mileage Report link on the CleanFleets site I get thrown an exception stating
    ' the enhancement is trying to access content from the wrong database (CleanFleets instead of CleanFleets-DEV)
    ' Based off that I am going to comment out the line below and replace it with explicitly listing the connection string
    ' and see if it works. This change is made by Andrew on 12/10/2019.

    ' Changing database back to CleanFleets in preparation for a migration from DEV to Production; Andrew - 12/10/2019.
    ' Push made and reverting back; Andrew - 12/10/2019.

    'Dim cnxn As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
    Dim cnxn As String = "Server=tcp:SQL16\CFNET;Database=CleanFleets-DEV;User ID=sa;Password=Cl3anFl33ts1"

    ' End of change made by Andrew on 12/10/2019.

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            FillAccounts()
        End If
    End Sub
    Protected Sub FillAccounts()
        Using facade As New AnnualMileageReportService()
            With ddl_Account
                .DataSource = facade.GetAccountListing()
                .DataTextField = "Value"
                .DataValueField = "Key"
                .DataBind()
            End With
        End Using


    End Sub

    Protected Sub ddl_Account_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileAccount As Integer = Convert.ToInt32(ddl_Account.SelectedValue.ToString())
        FillTerminals(IDProfileAccount)
        FillFleets(0)
    End Sub

    Protected Sub ddl_Terminal_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileTerminal As Integer = Convert.ToInt32(ddl_Terminal.SelectedValue.ToString())
        FillFleets(IDProfileTerminal)
    End Sub

    Protected Sub FillTerminals(IDProfileAccount As Integer)
        If IDProfileAccount > 0 Then

            Using facade As New AnnualMileageReportService()
                With ddl_Terminal
                    .DataSource = facade.GetTerminalListing(IDProfileAccount)
                    .DataTextField = "Value"
                    .DataValueField = "Key"
                    .DataBind()
                    .Items.Insert(0, New ListItem("- Select Terminal -", "0"))
                End With
            End Using
        Else
            ddl_Terminal.Items.Clear()
        End If
    End Sub

    Protected Sub FillFleets(IDProfileTerminal As Integer)
        If IDProfileTerminal > 0 Then
            Using facade As New AnnualMileageReportService()
                With ddl_Fleet
                    .DataSource = facade.GetFleetListing(IDProfileTerminal)
                    .DataTextField = "Value"
                    .DataValueField = "Key"
                    .DataBind()
                    .Items.Insert(0, New ListItem("- Select Fleet -", "0"))
                End With
            End Using
        Else
            ddl_Fleet.Items.Clear()
        End If
    End Sub

    Protected Sub btn_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Report.Click
        'Dim MIN_DATE As DateTime = New Date(1990, 1, 1)
        'Dim MAX_DATE As DateTime = New Date(2099, 1, 1)
        Dim updatedColumnHeaders As Boolean = False
        Dim currentYear As Int16 = DateTime.Now.Year
        Dim lastYear As Int16 = currentYear - 1
        Dim twoYearsAgo As Int16 = currentYear - 2
        Dim columnCount As Int16 = 12

        If Page.IsValid() Then
            Dim FleetId As Integer = 0
            Integer.TryParse(ddl_Fleet.SelectedValue, FleetId)
            Dim TerminalId As Integer = 0
            Integer.TryParse(ddl_Terminal.SelectedValue, TerminalId)
            Dim AccountId As Integer = CInt(ddl_Account.SelectedValue)

            Dim AccountListItem As ListItem = ddl_Account.SelectedItem
            Dim FleetListItem As ListItem = ddl_Fleet.SelectedItem
            Dim TerminalListItem As ListItem = ddl_Terminal.SelectedItem
            Dim columnHeaderRow As Integer = 0

            Dim Filename As String = AccountListItem.Text & If(TerminalId > 0, "-" & TerminalListItem.Text, "") & If(FleetId > 0, "-" & FleetListItem.Text, "") & "_"
            Filename = Filename.Replace(",", "")

            Dim reportData As List(Of AnnualMileageReportDTO)
            Using facade As New AnnualMileageReportService()
                reportData = facade.GetAnnualMileageReportData(New AnnualMileageReportSearchCriteria With {.AccountId = AccountId,
                    .TerminalId = TerminalId,
                    .FleetId = FleetId
                    })
            End Using

            If reportData.Count = 0 Then
                Messages.Text = "No records found"
                Return
            End If

            Using package As New ExcelPackage()
                Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("Annual Mileage Report")
                'fill header information
                Dim row As Integer = 1
                Using range As ExcelRange = worksheet.Cells("A" & row)
                    range.Value = "Annual Mileage Report"
                    range.Style.Font.Size = 16
                    range.Style.Font.Bold = True
                End Using
                row += 1
                worksheet.Cells("A" & row).Value = String.Format("Report Date: {0:d}", DateTime.Now())
                row += 1
                worksheet.Cells("A" & row).Value = String.Format("Account: {0}", AccountListItem.Text)
                row += 1
                If TerminalId > 0 Then
                    worksheet.Cells("A" & row).Value = String.Format("Terminal: {0}", TerminalListItem.Text)
                    row += 1
                End If
                If FleetId > 0 Then
                    worksheet.Cells("A" & row).Value = String.Format("Fleet: {0}", FleetListItem.Text)
                    row += 1
                End If

                row += 1 ' extra space between header and content

                'fill cells with data from reportData
                columnHeaderRow = row

                worksheet.Cells("A" & row).Value = "Location"
                worksheet.Cells("B" & row).Value = "Unit No"
                worksheet.Cells("C" & row).Value = "VIN"
                worksheet.Cells("D" & row).Value = String.Format("{0} Mileage Date", twoYearsAgo.ToString())
                worksheet.Cells("E" & row).Value = String.Format("{0} Mileage", twoYearsAgo.ToString())
                worksheet.Cells("F" & row).Value = String.Format("{0} Mileage Date", lastYear.ToString())
                worksheet.Cells("G" & row).Value = String.Format("{0} Mileage", lastYear.ToString())
                worksheet.Cells("H" & row).Value = String.Format("{0} Mileage Date", currentYear.ToString())
                worksheet.Cells("I" & row).Value = String.Format("{0} Mileage", currentYear.ToString())
                worksheet.Cells("J" & row).Value = String.Format("{0} Miles", twoYearsAgo.ToString())
                worksheet.Cells("K" & row).Value = String.Format("{0} Miles", lastYear.ToString())
                worksheet.Cells("L" & row).Value = "Average Miles"

                row += 1
                worksheet.Cells("A" & row).LoadFromCollection(Of AnnualMileageReportDTO)(reportData, False)

                Using range As ExcelRange = worksheet.Cells(columnHeaderRow, 1, columnHeaderRow, columnCount)
                    range.Style.Font.Bold = True
                    range.Style.Border.Bottom.Style = ExcelBorderStyle.Thin
                End Using

                For i = 1 To columnCount
                    Dim columnTitle As String

                    columnTitle = worksheet.Cells(row, i).Value
                    If String.Format(" {0} ", columnTitle) Like "*Date*" Then
                        With worksheet.Column(i)
                            .Style.Numberformat.Format = "mm/dd/yyyy"
                        End With
                    End If

                    If (String.Format(" {0} ", columnTitle) Like "*Mileage*" OrElse String.Format(" {0} ", columnTitle) Like "*Miles*") Then
                        With worksheet.Column(i)
                            .Style.Numberformat.Format = "#,##0"
                        End With
                    End If
                Next


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
                    .FirstFooter.LeftAlignedText = String.Format("Annual Mileage Report{0}{1:d}", vbCrLf, DateTime.Now())
                    .FirstFooter.RightAlignedText = String.Format("Page {0} of {1}", ExcelHeaderFooter.PageNumber, ExcelHeaderFooter.NumberOfPages)
                    .EvenFooter.LeftAlignedText = .FirstFooter.LeftAlignedText
                    .EvenFooter.RightAlignedText = .FirstFooter.RightAlignedText
                    .OddFooter.LeftAlignedText = .FirstFooter.LeftAlignedText
                    .OddFooter.RightAlignedText = .FirstFooter.RightAlignedText
                End With


                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                Response.AddHeader("content-disposition", String.Format("attachment;  filename={0}AnnualMileageReport.xlsx", Filename))
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
