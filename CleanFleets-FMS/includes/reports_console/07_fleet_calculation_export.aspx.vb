Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Data.OleDb
Imports System.IO
Imports System.Collections.Generic
Imports Telerik.Web.UI
Imports Ionic.Zip
Imports Microsoft.Office.Interop.Excel
Imports System.Management
Imports Inspironix
Public Class _07_fleet_calculation_export
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            ' possible it was called via querystring
            If Request.QueryString("Export") = "true" Then
                Dim possibleWorksheets As New List(Of Worksheet) ' worksheet Name, format for PDF filespec
                Dim worksheetsToPdf As New List(Of Worksheet)
                possibleWorksheets.Add(New Worksheet("Phase-In Wksht", "Phase-In Worksheet.pdf"))
                possibleWorksheets.Add(New Worksheet("STB Phase-In Fleet Plan", "STB Phase-In Worksheet.pdf"))
                possibleWorksheets.Add(New Worksheet("LowMileageConst", "Low Mileage Construction Worksheet.pdf"))
                possibleWorksheets.Add(New Worksheet("NOX EXEMPT", "NOx Exempt Worksheet.pdf"))
                If Request.QueryString("worksheet").ToLower() = "all" Then
                    worksheetsToPdf.AddRange(possibleWorksheets)
                Else
                    For Each ws As Worksheet In possibleWorksheets
                        If Request.QueryString("worksheet").Replace(" ", "").ToLower() Like "*" & ws.WorksheetTitle.Replace(" ", "").ToLower() & "*" Then
                            worksheetsToPdf.Add(ws)
                        End If
                    Next
                End If
                Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
                Dim conn As New SqlConnection(connectionString)
                Dim RuleCode As String
                Dim selectSQL = "SELECT IDOptionList FROM CF_Option_List WHERE OptionName='RuleCode' AND RecordValue = 'On Road'"
                Dim comm As New SqlCommand(selectSQL, conn)
                comm.Connection.Open()
                RuleCode = comm.ExecuteScalar()
                CreateAndSendPDF(Request.QueryString("IDProfileAccount"), 0, 0, RuleCode, worksheetsToPdf)
            End If
        End If
    End Sub

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

            Dim dt As New System.Data.DataTable()
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

            Dim dt As New System.Data.DataTable()
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


    Protected Sub btn_Report_Excel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Report_Excel.Click
        If Page.IsValid() Then
            Dim IDfleet As Integer
            Dim IDProfileTerminal As Integer
            Dim IDProfileAccount As Integer
            Dim filespec As String
            Dim IDRuleCode As String = String.Empty

            Integer.TryParse(ddl_Fleet.SelectedValue, IDfleet)
            Integer.TryParse(ddl_Terminal.SelectedValue, IDProfileTerminal)
            Integer.TryParse(ddl_Account.SelectedValue, IDProfileAccount)

            Dim item As ListItem
            For Each item In ddl_RuleCode.Items
                If item.Selected Then
                    IDRuleCode &= item.Value & ","
                End If
            Next
            Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
            Dim conn As New SqlConnection(connectionString)

            Dim selectSQL As String
            selectSQL = "SELECT dbo.CommaWrap(@IDRuleCode)"
            Dim comm As New SqlCommand(selectSQL, conn)
            comm.Parameters.AddWithValue("@IDRuleCode", IDRuleCode)
            comm.Connection.Open()
            IDRuleCode = comm.ExecuteScalar()
            comm.Connection.Close()
            filespec = createFleetCalculationExport(IDProfileAccount, IDProfileTerminal, IDfleet, IDRuleCode)
            Dim fi As New FileInfo(filespec)
            Response.ClearHeaders()
            Response.ClearContent()
            Response.ContentType = "application/vnd.ms-excel"
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
        End If
    End Sub


    Private Class Worksheet
        Private _PDFFileSpec As String
        Public WorksheetTitle As String
        Public ZippedPDFFileName As String

        Public ReadOnly Property PDFFileSpec As String
            Get
                Return _PDFFileSpec
            End Get
        End Property

        Public Sub New()

        End Sub

        Public Sub New(WorksheetTitle As String, ZippedPDFFileName As String)
            Me.WorksheetTitle = WorksheetTitle
            Me.ZippedPDFFileName = ZippedPDFFileName
        End Sub

        Public Sub addToZipFile(ByRef zip As Ionic.Zip.ZipFile)
            Dim ze As ZipEntry = zip.AddFile(Me._PDFFileSpec)
            ze.FileName = Me.ZippedPDFFileName
        End Sub

        Public Function createPDF(ByRef workbook As Object) As Boolean

            'Dim FileFormatStr As String
            Dim exportPDFPath As String
            Me._PDFFileSpec = System.IO.Path.GetTempFileName()
            Dim oldPDFFileSpec As String = Me._PDFFileSpec
            Me._PDFFileSpec = Path.ChangeExtension(Me._PDFFileSpec, ".pdf")
            'File.move(oldPDFFileSpec, me._PDFFileSpec)
            File.Delete(oldPDFFileSpec)


            exportPDFPath = Path.Combine(System.Environment.GetFolderPath(Environment.SpecialFolder.CommonProgramFiles),
              "Microsoft Shared\Office" & CInt(workbook.Application.Version) & "\EXP_PDF.dll")
            If File.Exists(exportPDFPath) Then
                ' select the right workbook
                If workbook.Sheets(Me.WorksheetTitle).select Then
                    'XlFixedFormatType.xlTypePDF = 0
                    'XlFixedFormatQuality.xlQualityStandard = 0
                    Try

                        workbook.ActiveSheet.ExportAsFixedFormat(Type:=0, Filename:=Me._PDFFileSpec, Quality:=0, IncludeDocProperties:=True,
                          IgnorePrintAreas:=False, OpenAfterPublish:=False)
                        Return True
                    Catch exc As Exception
                        ' rundll32 printui.dll,PrintUIEntry /y /q /n "Microsoft XPS Document Writer"
                        'dim p as new System.Diagnostics.Process()
                        'p.startInfo.UseShellExecute = true
                        ''p.startInfo.UseShellExecute = false
                        'p.startInfo.filename = "cmd"
                        'p.startInfo.arguments = "rundll32 printui.dll,PrintUIEntry /y /q /n ""Microsoft XPS Document Writer"""
                        ''p.startInfo.filename = "rundll32 "
                        ''p.startInfo.arguments = "printui.dll,PrintUIEntry /y /q /n ""Microsoft XPS Document Writer"""
                        ''p.startInfo.redirectStandardOutput = true
                        'p.start()
                        'p.WaitForExit
                        '.Response.write(p.StandardOutput.ReadToEnd() & "<br><br>")

                        HttpContext.Current.Response.Write(Me._PDFFileSpec & " ")
                        HttpContext.Current.Response.Write(exc.ToString())
                        HttpContext.Current.Response.End()
                    End Try
                End If
            Else
                'abcpdf?
                Throw New NotSupportedException("Microsoft SendToPDF for Excel is not installed on this server or using wrong Excel installation. Could not find dependent file '" & exportPDFPath & "'")
            End If
            Return False
        End Function
    End Class

    Protected Sub btn_Report_PDF_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Report_PDF.Click
        If Page.IsValid() Then
            Dim IDfleet As Integer
            Dim IDProfileTerminal As Integer
            Dim IDProfileAccount As Integer
            Dim IDRuleCode As String = String.Empty


            Integer.TryParse(ddl_Fleet.SelectedValue, IDfleet)
            Integer.TryParse(ddl_Terminal.SelectedValue, IDProfileTerminal)
            Integer.TryParse(ddl_Account.SelectedValue, IDProfileAccount)

            Dim item As ListItem
            For Each item In ddl_RuleCode.Items
                If item.Selected Then
                    IDRuleCode &= item.Value & ","
                End If
            Next
            Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
            Dim conn As New SqlConnection(connectionString)

            Dim selectSQL As String
            selectSQL = "SELECT dbo.CommaWrap(@IDRuleCode)"
            Dim comm As New SqlCommand(selectSQL, conn)
            comm.Parameters.AddWithValue("@IDRuleCode", IDRuleCode)
            comm.Connection.Open()
            IDRuleCode = comm.ExecuteScalar()
            comm.Connection.Close()
            CreateAndSendPDF(IDProfileAccount, IDProfileTerminal, IDfleet, IDRuleCode)
        End If
    End Sub

    Private Sub CreateAndSendPDF(IDProfileAccount As Integer, IDProfileTerminal As Integer, IDFleet As Integer, IDRuleCode As String, Optional WorkSheetsToPDF As List(Of Worksheet) = Nothing)
        Dim filespec As String
        Dim downloadFileName As String = ""
        Dim login As String
        login = Membership.GetUser().UserName
        downloadFileName = login & "_fleet_calculation_" & DateTime.Now().ToString("yyyyMMdd-HHmmss") & ".zip"

        filespec = createFleetCalculationExport(IDProfileAccount, IDProfileTerminal, IDFleet, IDRuleCode)
        '10/15/2012 IR: REMOVE THIS COMMENT TO CIRCUMVENT THE PDF GENERATION***********************************
        '		dim fi as new FileInfo(filespec)
        '		Response.ClearHeaders()
        '		Response.ClearContent()
        '		Response.ContentType = "application/vnd.ms-excel"
        '		Response.AddHeader("Content-Length", fi.length)
        '		Response.AppendHeader("Content-Disposition", "attachment; filename=" & fi.name)
        '		using fs as  new FileStream(filespec, FileMode.Open)
        '			
        '			dim buffer(100*1024) as byte
        '			dim readed as integer = 0
        '				
        '			do 
        '				readed = fs.Read(buffer, 0, buffer.length)
        '				response.OutputStream.Write(buffer, 0, readed)
        '				response.Flush()
        '			loop while readed > 0
        '			
        '			Response.End()
        '		end using
        '******************************************************************************************************
        ' open the workbook
        If WorkSheetsToPDF Is Nothing OrElse WorkSheetsToPDF.Count = 0 Then
            WorkSheetsToPDF = New List(Of Worksheet) ' worksheet Name, format for PDF filespec
            WorkSheetsToPDF.Add(New Worksheet("Phase-In Wksht", "Phase-In Worksheet.pdf"))
            WorkSheetsToPDF.Add(New Worksheet("STB Phase-In Fleet Plan", "STB Phase-In Worksheet.pdf"))
            WorkSheetsToPDF.Add(New Worksheet("LowMileageConst", "Low Mileage Construction Worksheet.pdf"))
            WorkSheetsToPDF.Add(New Worksheet("NOX EXEMPT", "NOx Exempt Worksheet.pdf"))
        End If
        Dim zip As New ZipFile()
        'zip.CompressionLevel = ZipFile.CompressionLevel.BestSpeed

        Dim search As System.Management.ManagementObjectSearcher
        Dim results As System.Management.ManagementObjectCollection
        search = New System.Management.ManagementObjectSearcher("select * from win32_printer")
        results = search.Get()
        For Each printer As System.Management.ManagementObject In results
            'System.Diagnostics.Debug.WriteLine(printer["Name"]);
            Dim result As Object = printer.InvokeMethod("SetDefaultPrinter", Nothing)
            Dim settings As System.Drawing.Printing.PrinterSettings = New System.Drawing.Printing.PrinterSettings()
            Exit For
        Next


        Dim oExcel As Object = CreateObject("Excel.Application")
        Dim wb As Object
        Try
            oExcel.DisplayAlerts = False
            ' open workbook
            wb = oExcel.Workbooks.Open(filespec)
            ' create the pdfs
            For Each w As Worksheet In WorkSheetsToPDF
                If w.createPDF(wb) Then
                    If WorkSheetsToPDF.Count > 1 Then
                        w.addToZipFile(zip)
                    End If
                End If
            Next


        Finally
            If Not wb Is Nothing Then
                wb.Close(SaveChanges:=False)
                wb = Nothing
            End If
            If oExcel IsNot Nothing Then

                oExcel.Quit()
                'oExcel.dispose()
                oExcel = Nothing
            End If

            GC.Collect()
            GC.WaitForPendingFinalizers()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        ' send the zip file down the pipe
        Response.Clear()
        If WorkSheetsToPDF.Count > 1 Then
            Response.ContentType = "application/zip"
            Response.AddHeader("Content-Disposition", "filename=" & downloadFileName)
            zip.Save(Response.OutputStream)
        Else
            Response.ContentType = "application/excel"
            Response.AddHeader("Content-Disposition", "filename=" & WorkSheetsToPDF(0).ZippedPDFFileName)
            Response.TransmitFile(WorkSheetsToPDF(0).PDFFileSpec)
        End If
        Response.End()

    End Sub


    Protected Sub ddl_Fleet_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) 'Handles RadComboBox3.SelectedIndexChanged

        'Session("IDProfileFLeet") = RadComboBox3.SelectedValue

    End Sub


    Sub cf_ddl_Validate(sender As Object, args As ServerValidateEventArgs)
        Dim value As Integer
        args.IsValid = True
        'if args.isValid then args.IsValid = ( Integer.tryParse(ddl_Account.selectedValue, value) andAlso value > 0) 
        'if args.isValid then args.IsValid = ( Integer.tryParse(ddl_Terminal.selectedValue, value) andAlso value > 0) 
        If args.IsValid Then args.IsValid = (Integer.TryParse(args.Value, value)) 'andAlso value > 0 ) 
    End Sub

    Protected Function createFleetCalculationExport(IDProfileAccount As Integer, IDProfileTerminal As Integer, IDProfileFleet As Integer, IDRuleCode As String) As String
        Dim TemplateFileSpec = Server.MapPath("templates\STB Phase-In Template.xls")
        Dim login As String
        login = Membership.GetUser().UserName
        Dim UserID As Guid
        Dim MemUser As MembershipUser
        MemUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey
        Dim filename As String = login & "_fleet_calculation_" & DateTime.Now().ToString("yyyyMMdd-HHmmss") & ".xls"
        Dim PathSpec = Server.MapPath("reports\")
        ' launch excel
        Dim oExcel As Object = CreateObject("Excel.Application")

        ' get records into cursor
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim objReader As SqlDataReader
        Dim selectSQL As String
        If IDProfileTerminal > 0 Then
            '			Response.write("IDProfileTerminal: " & IDProfileTerminal & " IDProfileFleet: " & IDProfileFleet & " IDRuleCode: " & IDRuleCode & " IDProfileAccount: " & IDProfileAccount)
            '			Response.end()
            selectSQL = "SELECT * FROM [CFV_Report_Vehicles_Details] WHERE  @IDProfileFleet IN (0, IDProfileFleet) " &
                "AND @IDProfileTerminal IN (0, IDProfileTerminal) " &
              "AND dbo.CSVLike(@IDRuleCode, IDRuleCode) = 1"
            If IDProfileAccount > 0 Then
                selectSQL &= "AND IDProfileAccount = @IDProfileAccount "
            End If
            Dim comm As New SqlCommand(selectSQL, conn)
            comm.Parameters.Add("@IDProfileFleet", IDProfileFleet)
            comm.Parameters.Add("@IDProfileTerminal", IDProfileTerminal)
            comm.Parameters.Add("@IDRuleCode", IDRuleCode)
            If IDProfileAccount > 0 Then
                comm.Parameters.Add("@IDProfileAccount", IDProfileAccount)
            End If
            'comm.Parameters.Add("@UserId", UserID)
            comm.Connection.Open()
            objReader = comm.ExecuteReader()
        Else
            Dim IDProfileContact As Integer
            Integer.TryParse(Request.QueryString("IDProfileContact"), IDProfileContact)
            If IDProfileContact > 0 Then
                Dim conn2 As New SqlConnection(connectionString)
                Dim comm2 As New SqlCommand("EXECUTE [dbo].[GetUserTerminals] @IDProfileContact, @IDProfileAccount, @Result", conn2)
                Dim terminalReader As SqlDataReader
                comm2.Parameters.Add("@IDProfileContact", IDProfileContact)
                comm2.Parameters.Add("@IDProfileAccount", IDProfileAccount)
                Dim result As String
                comm2.Parameters.Add("@Result", result)
                comm2.Parameters("@Result").Direction = ParameterDirection.Output
                comm2.Parameters("@Result").Size = 40
                comm2.Connection.Open()
                terminalReader = comm2.ExecuteReader()
                selectSQL = "SELECT * FROM [CFV_Report_Vehicles_Details] WHERE  @IDProfileFleet IN (0, IDProfileFleet) " &
                  "AND IDProfileTerminal IN (0"
                While terminalReader.Read()
                    If Not terminalReader("PermissionLevel") = "G" Then
                        selectSQL &= ", " & terminalReader("IDProfileTerminal")
                        'terminalCount += 1
                    End If
                End While
                '10/15/2012 IR: Added filtering by the IDRuleCode
                selectSQL &= ") AND IDRuleCode = @IDRuleCode "
                If IDProfileAccount > 0 Then
                    selectSQL &= "AND IDProfileAccount = @IDProfileAccount"
                End If
                'selectSQL & = ") AND IDProfileAccount = @IDProfileAccount"
            Else
                selectSQL = "SELECT * FROM [CFV_Report_Vehicles_Details] WHERE  @IDProfileFleet IN (0, IDProfileFleet) AND dbo.CSVLike(@IDRuleCode, IDRuleCode) = 1"
                If IDProfileAccount > 0 Then
                    selectSQL &= "AND IDProfileAccount = @IDProfileAccount"
                End If
            End If
            Dim comm As New SqlCommand(selectSQL, conn)
            comm.Parameters.AddWithValue("@IDProfileFleet", IDProfileFleet)
            comm.Parameters.AddWithValue("@IDRuleCode", IDRuleCode)
            If IDProfileAccount > 0 Then
                comm.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
            End If
            comm.Connection.Open()
            objReader = comm.ExecuteReader()
        End If

        Try
            With oExcel
                ' open workbook
                .Visible = False
                .DisplayAlerts = False
                .Workbooks.Open(TemplateFileSpec)
                .Sheets("Sheet1").Select

                ' from sheet one, store the column name into a hashtable as (columnName, columnNumber)
                Dim columns As New Dictionary(Of String, Integer)
                Dim cellFormats As New Dictionary(Of Integer, String)
                For c As Integer = 0 To .ActiveSheet.UsedRange.Columns.Count - 1
                    'columns(.Cells(1,c).value.trim()) = GetColumnLetter(c) ' header row
                    columns(.Cells(1, c + 1).value.trim()) = c ' header row
                    '10/15/2012 IR: Was getting the number format from the header row should be from the first data row
                    'cellFormats(c) = .Range(GetColumnLetter(c+1) & 1).NumberFormat
                    cellFormats(c) = .Range(GetColumnLetter(c + 1) & 2).NumberFormat
                Next

                ' insert records
                Dim row As Integer = 2
                Dim schemaTable As System.Data.DataTable = objReader.GetSchemaTable()

                While objReader.Read()
                    Dim rowArray(1, columns.Count) As Object
                    For i As Integer = 0 To objReader.FieldCount - 1
                        If columns.ContainsKey(objReader.GetName(i)) Then
                            If IsDBNull(objReader(i)) Then
                                ' do nothing
                                rowArray(0, columns(objReader.GetName(i))) = Nothing
                            Else

                                'dim cellFormat as string = .Range(GetColumnLetter(columns(objReader.GetName(i))+1)  & row).NumberFormat 
                                Dim cellFormat = cellFormats(columns(objReader.GetName(i)))
                                If (cellFormat = "@" OrElse cellFormat = "General") AndAlso Double.TryParse(objReader(i), Nothing) Then
                                    '.Range(columns(objReader.GetName(i))  & row).value = "'" & objReader(i)
                                    rowArray(0, columns(objReader.GetName(i))) = "'" & objReader(i)
                                Else
                                    rowArray(0, columns(objReader.GetName(i))) = DB.RNS(objReader(i))
                                End If
                                'response.write("Column: " & objReader.GetName(i) & " " & rowArray(0, columns(objReader.GetName(i))) & " " & cellFormat & "<br/>")
                            End If
                        End If
                    Next
                    For i As Integer = 0 To rowArray.GetLength(1) - 1
                        'HttpContext.current.Response.write(rowArray(1,i) & " " )
                    Next
                    'HttpContext.current.Response.write("<br>")
                    Dim objRange = .Range("A" & row, "A" & row)
                    objRange = objRange.Resize(rowArray.GetLength(0), rowArray.GetLength(1))
                    objRange.value = rowArray
                    row += 1
                End While
                objReader.Close()
                'Response.End()

                ' save Excel file as report
                .ActiveWorkbook.SaveAs(Path.Combine(PathSpec, filename))
                .ActiveWorkbook.close()
                '.Visible = True
            End With
        Finally
            objReader.Close()
            If oExcel IsNot Nothing Then
                oExcel.Quit()
                'oExcel.dispose()
                oExcel = Nothing
            End If

        End Try
        Return Path.Combine(PathSpec, filename)
        ' return path or byte[]?
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

End Class


