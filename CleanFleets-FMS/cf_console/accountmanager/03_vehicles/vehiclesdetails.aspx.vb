Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Data.OleDb
Imports System.Collections.Generic
Imports WebSupergoo.ABCpdf7
Imports WebSupergoo.ABCpdf7.Objects
Imports WebSupergoo.ABCpdf7.Atoms
Imports System.IO
Imports Inspironix
Imports System.Globalization
Public Class vehiclesdetails1
    Inherits BaseWebForm

    '*********************************************************************************************************************
    'Page Events
    '*********************************************************************************************************************

    Dim GVW As String
    Dim chassisVIN As String
    Dim engineModelYear As String
    Dim qs As String = String.Empty
    Public GVWMessage As String

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender

        Dim rg_Vehicles As RadGrid = CType(FindControlIterative(Page, "rg_Engines"), RadGrid)
        If rg_Vehicles.SelectedIndexes.Count = 0 Then
            rg_Vehicles.SelectedIndexes.Add(0)
        End If

        Dim rg_VehiclesFiles As RadGrid = CType(FindControlIterative(Page, "rg_EnginesFiles"), RadGrid)
        If rg_VehiclesFiles.SelectedIndexes.Count = 0 Then
            rg_VehiclesFiles.SelectedIndexes.Add(0)
        End If

        Dim connectionString1 As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn1 As New SqlConnection(connectionString1)
        Dim comm1 As New SqlCommand("SELECT RTRIM(ISNULL(GrossVehicleWeight, '')) As GrossVehicleWeight FROM CF_Vehicles WHERE IDVehicles = @IDVehicles", conn1)
        comm1.Connection.Open()
        comm1.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = New Guid(Request.QueryString("IDVehicles"))
        GVW = comm1.ExecuteScalar
        If Not GVW > "" Then
            btn_DoorStickerReport.Enabled = False
            GVWMessage = "No Gross Vehicle Weight found, Door Sticker report is unavailable."
        Else
            btn_DoorStickerReport.Enabled = True
            GVWMessage = ""
        End If
        conn1.Close()

        If Not String.IsNullOrWhiteSpace(qs) Then LaunchPopup()
    End Sub




    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim IDVehicles As String = Request.QueryString("IDVehicles")
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim queryString As String = "SELECT IDVehicles, UnitNo, ChassisVIN FROM CF_Vehicles WHERE IDVehicles = @IDVehicles"

        Using myConnection As New SqlConnection(connectionString)
            Dim myCommand As New SqlCommand(queryString, myConnection)
            myConnection.Open()
            myCommand.Parameters.AddWithValue("@IDVehicles", IDVehicles)
            Dim MyReader As SqlDataReader = myCommand.ExecuteReader
            MyReader.Read()
            rmp_lbl_VUN.Text = If(IsDBNull(MyReader("UnitNo")), "", MyReader("UnitNo"))
            rmp_lbl_VIN.Text = MyReader("ChassisVIN")
            rmp_lbl_VUN0.Text = If(IsDBNull(MyReader("UnitNo")), "", MyReader("UnitNo"))
            rmp_lbl_VIN0.Text = MyReader("ChassisVIN")
            rmp_lbl_VUN1.Text = If(IsDBNull(MyReader("UnitNo")), "", MyReader("UnitNo"))
            rmp_lbl_VIN1.Text = MyReader("ChassisVIN")
            myConnection.Close()
        End Using

        rg_EngineFiles.MasterTableView.Rebind()

        Dim IDVehicle As New Guid(Request.QueryString("IDVehicles"))

        Dim connectionString1 As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn1 As New SqlConnection(connectionString)
        Dim comm1 As New SqlCommand("SELECT * FROM CF_Engines WHERE IDVehicles = @IDVehicles", conn1)
        comm1.Connection.Open()

        comm1.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicle

        Dim myDataAdapter As New SqlDataAdapter(comm1)
        Dim myDataSet As New DataSet
        Dim dtData As New DataTable
        myDataAdapter.Fill(myDataSet)
        'comm1 = New SqlCommand("SELECT RTRIM(ISNULL(GrossVehicleWeight, '')) As GrossVehicleWeight FROM CF_Vehicles WHERE IDVehicles = @IDVehicles", conn1)
        '		comm1.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicle
        '		GVW = comm1.ExecuteScalar
        '		if not GVW > "" then
        '			btn_DoorStickerReport.Enabled = false
        '			GVWMessage = "No Gross Vehicle Weight found, Door Sticker report is unavailable."
        '		else
        '			GVWMessage = ""
        '		end if
        conn1.Close()

        hf_rg_EnginesIDSelectedEngine.Value = "00000000-0000-0000-0000-000000000000"
        hf_rg_EnginesFilesIDEngines.Value = "00000000-0000-0000-0000-000000000000"

        If (Me.ViewState("EnginesID") IsNot Nothing) Then
            hf_rg_EnginesIDSelectedEngine.Value = Me.ViewState("EnginesID")
            hf_rg_EnginesFilesIDEngines.Value = Me.ViewState("EnginesID")
        Else
            If myDataSet.Tables.Count > 0 Then
                If myDataSet.Tables(0).Rows.Count > 0 Then
                    Dim IDEngine = myDataSet.Tables(0).Rows(0).Item("IDEngines")
                    Dim IDEngines = IDEngine.ToString

                    hf_rg_EnginesIDSelectedEngine.Value = IDEngines
                    hf_rg_EnginesFilesIDEngines.Value = IDEngines
                End If
            End If
        End If
    End Sub

    '*********************************************************************************************************************
    'Add Images Events
    '*********************************************************************************************************************


    Protected Sub btn_AddVehicleImage_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_AddVehicleImage.Click

        Dim IDProfilefleet As String = Request.QueryString("IDProfilefleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDVehicles As String = Request.QueryString("IDVehicles")

        qs = "IDProfilefleet=" & IDProfilefleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicles & "&t=vi"
    End Sub


    Protected Sub btn_AddEngineImage_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_AddEngineImage.Click

        Dim IDEngines As String = hf_rg_EnginesFilesIDEngines.Value

        qs = "IDEngines=" & IDEngines & "&t=ei"

    End Sub

    Protected Sub Btn_AddDECSImage_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_AddDECSImage.Click

        Dim IDEngine As String = hf_rg_EnginesFilesIDEngines.Value
        Dim IDEngines As New Guid(IDEngine)

        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CF_DECS WHERE IDEngines = @IDEngines", conn)
        comm.Connection.Open()

        comm.Parameters.Add("@IDEngines", SqlDbType.UniqueIdentifier).Value = IDEngines

        Dim myDataAdapter As New SqlDataAdapter(comm)
        Dim myDataSet As New DataSet
        Dim dtData As New DataTable
        Dim dtRow As DataRow
        myDataAdapter.Fill(myDataSet)
        conn.Close()

        For Each dtRow In myDataSet.Tables(0).Rows

            Session("IDDECS") = dtRow.Item("IDDECS")

        Next
        qs = "IDEngines=" & IDEngine & "&IDDECS=" & Session("IDDECS").ToString() & "&t=di"
    End Sub

    Private Sub LaunchPopup()

        Dim url As String = String.Format("../../../includes/uploadmanager/uploadmanager.aspx?{0}", qs)

        Dim sb As New StringBuilder()
        sb.Append("<script language='javascript'>(function () { ")
        sb.Append("window.open('")
        sb.Append(url)
        sb.Append("', 'CustomPopUp', 'width=800, height=850, menubar=yes, resizable=yes'); }());")
        sb.Append("</script>")
        ScriptManager.RegisterStartupScript(Me, Me.[GetType](), "@@@@MyPopUpScript", sb.ToString(), False)

        qs = String.Empty

    End Sub

    '*********************************************************************************************************************
    'Add Files Events
    '*********************************************************************************************************************


    Protected Sub btn_AddVehicleFile_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_AddVehicleFile.Click

        Dim IDProfilefleet As String = Request.QueryString("IDProfilefleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDVehicles As String = Request.QueryString("IDVehicles")

        qs = "IDProfilefleet=" & IDProfilefleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicles & "&t=vf"
    End Sub


    Protected Sub btn_AddEngineFile_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_AddEngineFile.Click

        Dim IDProfilefleet As String = Request.QueryString("IDProfilefleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDEngines As String = hf_rg_EnginesFilesIDEngines.Value
        Dim sbScript As New StringBuilder()

        qs = "IDProfilefleet=" & IDProfilefleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDEngines=" & IDEngines & "&t=ef"
    End Sub


    Protected Sub btn_AddDECSFile_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_AddDECSFile.Click

        Dim IDProfilefleet As String = Request.QueryString("IDProfilefleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDEngines As String = hf_rg_EnginesFilesIDEngines.Value
        Dim IDDEC As HiddenField = CType(FindControlIterative(Page, "hf_IDDECS"), HiddenField)

        qs = "IDProfilefleet=" & IDProfilefleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDEngines=" & IDEngines & "&IDDECS=" & IDDEC.Value.ToString() & "&t=df"
    End Sub



    Protected Sub btn_BasicReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_BasicReport.Click

        Dim IDVehicles As String = Request.QueryString("IDVehicles")
        Dim IDProfilefleet As String = Request.QueryString("IDProfilefleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDEngine As HiddenField = CType(fv_EngineDetails.FindControl("hf_IDEngines"), HiddenField)
        Dim IDEngines As String = If(IDEngine Is Nothing, "", IDEngine.Value)

        If Not Request("hf_IDDECS") = "" Then
            Dim IDDEC As HiddenField = CType(lv_DECSDetails.FindControl("hf_IDDECS"), HiddenField)
            Dim IDDECS As String = IDDEC.Value

        Else
            Dim IDDECS As String = 0
            Dim sbScript As New StringBuilder()

            sbScript.Append("<script language='javascript'>")
            sbScript.Append("window.open('")
            sbScript.Append("../../../includes/reports_console/bluereport.aspx?IDProfilefleet=" & IDProfilefleet & "&IDVehicles=" & IDVehicles & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDEngines=" & IDEngines & "&IDDECS=" & IDDECS)
            sbScript.Append("', 'CustomPopUp',")
            sbScript.Append("'width=800, height=600, scrollbars=yes, menubar=yes, resizable=yes');<")
            sbScript.Append("/script>")

            ' Use ScriptManager to register the script
            ScriptManager.RegisterStartupScript(Me, Me.[GetType](), "@@@@MyPopUpScript", sbScript.ToString(), False)
        End If
    End Sub

    Protected Sub btn_DoorStickerReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_DoorStickerReport.Click
        Dim connStr As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim SQLStr As String = "SELECT dbo.GetVehicleWeightClass(@IDVehicles)"
        Dim IDVehicles As String = Request.QueryString("IDVehicles")
        Dim weightClass As String
        Dim conn As New SqlConnection(connStr)
        Dim myCommand As New SqlCommand(SQLStr, conn)
        Dim HtmlUrl As String
        Dim FileName As String
        Dim SmallFileSpec As String
        Dim fileSpec As String
        Dim myReader As SqlDataReader

        conn.Open()
        myCommand.Parameters.AddWithValue("@IDVehicles", IDVehicles)
        weightClass = myCommand.ExecuteScalar

        SQLStr = "SELECT ChassisVIN, GrossVehicleWeight, MAX(dbo.GetIDOptionListRecordValue(CF_Engines.IDModelYear)) As EngineModelYear " &
          "FROM CF_Vehicles INNER JOIN CF_Engines ON CF_Vehicles.IDVehicles = CF_Engines.IDVehicles WHERE CF_Vehicles.IDVehicles = @IDVehicles GROUP BY dbo.GetIDOptionListRecordValue(CF_Engines.IDModelYear), ChassisVIN, GrossVehicleWeight"
        myCommand = New SqlCommand(SQLStr, conn)
        myCommand.Parameters.AddWithValue("@IDVehicles", IDVehicles)
        myReader = myCommand.ExecuteReader
        If myReader.Read() Then
            GVW = DB.RNS(myReader("GrossVehicleWeight"))
            chassisVIN = DB.RNS(myReader("ChassisVIN"))
            engineModelYear = DB.RNS(myReader("EngineModelYear"))
        End If
        conn.Close()

        Dim dirName = "../../../Reports/DoorStickers/"
        If Not Directory.Exists(Server.MapPath(dirName)) Then
            Directory.CreateDirectory(Server.MapPath(dirName))
        End If
        FileName = "Vehicle_" & IDVehicles & "_" & DateTime.Now.ToShortDateString.Replace("/", "") & ".pdf"
        SmallFileSpec = dirName & FileName
        fileSpec = Server.MapPath(SmallFileSpec)
        HtmlUrl = getFullURL("../../../09_Door_Sticker_Report.aspx?IDVehicles=" & IDVehicles & "&WeightClass=" & weightClass)
        CreateHtmlUrl2PdfReport(HtmlUrl, fileSpec, SmallFileSpec)
    End Sub

    Sub CreateHtmlUrl2PdfReport(ByVal HtmlUrl As String, ByVal FileSpec As String, ByVal SmallFileSpec As String)
        Dim Report As New Doc
        Dim pageID As Long
        Dim DateValue As DateTime = DateTime.Now()
        Dim PageCount As Integer
        Dim LandscapePageCount As Integer
        Dim Header As XRect()
        Dim height As Double
        Dim landscapeF As Boolean = True
        Dim PageDimensions As New XRect
        Dim PrintableArea As New XRect

        PageDimensions = Page_Dimensions(landscapeF)
        PrintableArea = Printable_Area(landscapeF)

        Report.HtmlOptions.PageCacheClear()
        Report.HtmlOptions.PageCacheEnabled = False
        Report.HtmlOptions.AddTags = True

        Report.MediaBox.String = PageDimensions.ToString

        Report.Page = Report.AddPage()
        Report.Rect.String = PrintableArea.String

        '		Report.AddTags = True
        pageID = Report.AddImageUrl(HtmlUrl & "&ticks=" & Now.Ticks())
        'Report.SetInfo(pageID, /Rotate, 90)
        Header = Report.HtmlOptions.GetTagRects(pageID)

        Dim firstPageID = pageID

        While Report.Chainable(pageID)

            Try
                If Header IsNot Nothing AndAlso Header.Length > 0 Then
                    Dim top As Double = Report.Rect.Bottom
                    Dim bottom As Double = Report.Rect.Top
                    For i As Integer = 0 To Header.Length - 1
                        top = Math.Max(top, Header(i).Top)
                        bottom = Math.Min(bottom, Header(i).Bottom)
                    Next
                    height = top - bottom
                End If
            Catch ex As Exception
                Throw New ArgumentException("Error in HTML Generation: ", ex)
            End Try
            'MaxHeight = Math.Max(height, MaxHeight)
            Report.Page = Report.AddPage()
            Report.Rect.String = PrintableArea.String
            Report.Rect.Top = Report.Rect.Top - height - 1 '- toPoints(0.08) 
            pageID = Report.AddImageToChain(pageID)

        End While
        LandscapePageCount = Report.PageCount
        landscapeF = False
        PageDimensions = Page_Dimensions(landscapeF)
        PrintableArea = Printable_Area(landscapeF)
        Report.MediaBox.String = PageDimensions.ToString
        Report.Page = Report.AddPage()
        Report.Rect.String = PrintableArea.ToString
        'pageID = Report.AddImageUrl()
        While Report.Chainable(pageID)

            Try
                If Header IsNot Nothing AndAlso Header.Length > 0 Then
                    Dim top As Double = Report.Rect.Bottom
                    Dim bottom As Double = Report.Rect.Top
                    For i As Integer = 0 To Header.Length - 1
                        top = Math.Max(top, Header(i).Top)
                        bottom = Math.Min(bottom, Header(i).Bottom)
                    Next
                    height = top - bottom
                End If
            Catch ex As Exception
                Throw New ArgumentException("Error in HTML Generation: ", ex)
            End Try
            'MaxHeight = Math.Max(height, MaxHeight)
            Report.Page = Report.AddPage()
            Report.Rect.String = PrintableArea.String
            Report.Rect.Top = Report.Rect.Top - height - 1 '- toPoints(0.08) 
            pageID = Report.AddImageToChain(pageID)

        End While

        Report.Page = Report.AddPage()
        Report.Rect.String = PrintableArea.ToString
        'pageID = Report.AddImageUrl()
        While Report.Chainable(pageID)

            Try
                If Header IsNot Nothing AndAlso Header.Length > 0 Then
                    Dim top As Double = Report.Rect.Bottom
                    Dim bottom As Double = Report.Rect.Top
                    For i As Integer = 0 To Header.Length - 1
                        top = Math.Max(top, Header(i).Top)
                        bottom = Math.Min(bottom, Header(i).Bottom)
                    Next
                    height = top - bottom
                End If
            Catch ex As Exception
                Throw New ArgumentException("Error in HTML Generation: ", ex)
            End Try
            'MaxHeight = Math.Max(height, MaxHeight)
            Report.Page = Report.AddPage()
            Report.Rect.String = PrintableArea.String
            Report.Rect.Top = Report.Rect.Top - height - 1 '- toPoints(0.08) 
            pageID = Report.AddImageToChain(pageID)

        End While
        For i As Integer = 1 To Report.PageCount
            If i <= LandscapePageCount Then
                landscapeF = True
            Else
                landscapeF = False
            End If
            Report.Rect.String = (Page_Number_Area(landscapeF)).String

            Report.PageNumber = i
            Dim theF1 As Integer = Report.AddFont("Arial")
            Report.Font = theF1
            Report.HPos = 1 ' right align
            Report.AddText("Page " & i & " of " & Report.PageCount)

            Report.Rect.String = (Left_Footer_Area(landscapeF)).String
            Report.HPos = 0
            Report.AddText("VIN: " & chassisVIN & vbCrLf)
            Report.AddText("GVWR: " & GVW & vbCrLf)
            Report.AddText("Engine Model Year: " & engineModelYear & vbCrLf)

            Report.Rect.String = (Right_Footer_Area(landscapeF)).String
            Report.AddText("Report Date: " & DateTime.Now.ToShortDateString() & vbCrLf)
            'Report.Flatten()
            PageCount = i
        Next

        Try
            Report.Save(FileSpec)
        Catch exc As Exception
            Throw New Exception("Cannot Save PDF", exc)
        End Try

        Dim filename = Path.GetFileName(FileSpec)
        Dim attachmentHeader = String.Format("attachment; filename={0}", filename)
        Response.Clear()
        Response.AddHeader("content-disposition", attachmentHeader)
        Response.ContentType = "application/pdf"
        Response.WriteFile(FileSpec)
        Response.End()
    End Sub

    Private Function toPoints(ByVal inchesValue As Double) As Double
        Return (inchesValue * 72)
    End Function

    Private Function toInches(ByVal pointsValue As Double) As Double
        Return (pointsValue / 72)
    End Function

    Private Function getFullURL(ByVal scriptURL As String) As String
        Dim URL As String
        If Request.ServerVariables("SERVER_PORT_SECURE") = 1 Then
            URL = "https://"
        Else
            URL = "http://"
        End If
        URL &= Request.ServerVariables("SERVER_NAME")
        If Request.ServerVariables("SERVER_NAME") = "server01" Then
            URL &= ":3393"
        End If

        URL &= Request.ServerVariables("URL").Replace(System.IO.Path.GetFileName(Request.FilePath), "")
        URL &= scriptURL
        Return URL
    End Function

    Private Function Page_Dimensions(ByVal landscape As Boolean) As XRect
        Dim xr As New XRect
        If landscape Then
            With xr
                .Left = 0
                .Bottom = 0
                .Top = toPoints(8.5)
                .Right = toPoints(11)
            End With
        Else
            With xr
                .Left = 0
                .Bottom = 0
                .Top = toPoints(11)
                .Right = toPoints(8.5)
            End With
        End If
        Return xr
    End Function

    Private Function Printable_Area(ByVal landscape As Boolean) As XRect
        Dim xr As New XRect
        If landscape Then
            With xr
                .Left = toPoints(0.65)
                .Bottom = toPoints(0.77)
                .Top = toPoints(8.49)
                .Right = toPoints(10.5)
            End With
        Else
            With xr
                .Left = toPoints(0.65)
                .Bottom = toPoints(0.75)
                .Top = toPoints(10.75)
                .Right = toPoints(8)
            End With
        End If
        Return xr
    End Function

    Private Function Page_Number_Area(ByVal landscape As Boolean) As XRect
        Dim xr As New XRect
        If landscape Then
            With xr
                .Left = toPoints(5)
                .Bottom = toPoints(0.5)
                .Top = toPoints(0.65)
                .Right = toPoints(6)
            End With
        Else
            With xr
                .Left = toPoints(3.75)
                .Bottom = toPoints(0.5)
                .Top = toPoints(0.65)
                .Right = toPoints(4.75)
            End With
        End If
        Return xr
    End Function

    Private Function Left_Footer_Area(ByVal landscape As Boolean) As XRect
        Dim xr As New XRect
        With xr
            .Left = toPoints(0.65)
            .Bottom = toPoints(0.2)
            .Top = toPoints(0.77)
            .Right = toPoints(3)
        End With
        Return xr
    End Function

    Private Function Right_Footer_Area(ByVal landscape As Boolean) As XRect
        Dim xr As New XRect
        If landscape Then
            With xr
                .Left = toPoints(8.5)
                .Bottom = toPoints(0.2)
                .Top = toPoints(0.75)
                .Right = toPoints(10.5)
            End With
        Else
            With xr
                .Left = toPoints(6)
                .Bottom = toPoints(0.2)
                .Top = toPoints(0.75)
                .Right = toPoints(8)
            End With
        End If
        Return xr
    End Function

    '*********************************************************************************************************************
    'Add Files Events
    '*********************************************************************************************************************



    Protected Sub sds_CFV_Vehicles_fv_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles sds_CFV_Vehicles_fv.Updating

        Dim UserID As String
        Dim MemUser As MembershipUser
        MemUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey.ToString()

        If MemUser Is Nothing Then
            e.Cancel = True
        Else
            e.Command.Parameters("@IDModifiedUser").Value = UserID.ToString()
            e.Command.Parameters("@ModifiedDate").Value = DateTime.Now
        End If

    End Sub


    Protected Sub sds_CFV_Engines_fv_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles sds_CFV_Engines_fv.Updating

        Dim UserID As String
        Dim MemUser As MembershipUser
        MemUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey.ToString()

        If MemUser Is Nothing Then
            e.Cancel = True
        Else
            e.Command.Parameters("@IDModifiedUser").Value = UserID.ToString()
            e.Command.Parameters("@ModifiedDate").Value = DateTime.Now
        End If

    End Sub



    '*********************************************************************************************************************
    'Button Click Add Events
    '*********************************************************************************************************************

    Protected Sub btn_AddEngine_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_AddEngine.Click

        Dim IDProfileFleet As String = Request.QueryString("IDProfileFleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDVehicles As String = Request.QueryString("IDVehicles")
        If IDProfileFleet IsNot Nothing Then
            Response.Redirect("enginesadd.aspx?IDProfileFleet=" & IDProfileFleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicles)
        End If

    End Sub


    Protected Sub btn_AddDECs_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim IDProfileFleet As String = Request.QueryString("IDProfileFleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDVehicles As String = Request.QueryString("IDVehicles")
        Dim IDEngine As HiddenField = CType(fv_EngineDetails.FindControl("hf_IDEngines"), HiddenField)
        Dim IDEngines As String = IDEngine.Value
        If IDVehicles IsNot Nothing Then
            Response.Redirect("DECsadd.aspx?IDProfileFleet=" & IDProfileFleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicles & "&IDEngines=" & IDEngines)
        End If

    End Sub




    '*********************************************************************************************************************
    'Button Click Delete Events
    '*********************************************************************************************************************

    Protected Sub btn_DeleteVehicle_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim IDProfileFleet As String = Request.QueryString("IDProfileFleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDVehicles As String = Request.QueryString("IDVehicles")
        If IDProfileFleet IsNot Nothing Then
            Response.Redirect("vehiclesdel.aspx?IDProfileFleet=" & IDProfileFleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicles)
        End If

    End Sub


    Protected Sub btn_DeleteEngine_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim IDProfileFleet As String = Request.QueryString("IDProfileFleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDVehicles As String = Request.QueryString("IDVehicles")
        If IDProfileFleet IsNot Nothing Then
            Response.Redirect("vehiclesdel.aspx?IDProfileFleet=" & IDProfileFleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicles)
        End If

    End Sub



    '*********************************************************************************************************************
    'Button Click Transfer Events
    '*********************************************************************************************************************

    Protected Sub btn_TransferVehicle_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim IDProfileFleet As String = Request.QueryString("IDProfileFleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDVehicles As String = Request.QueryString("IDVehicles")
        If IDProfileFleet IsNot Nothing Then
            Response.Redirect("vehiclestransfer.aspx?IDProfileFleet=" & IDProfileFleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicles)
        End If

    End Sub



    '*********************************************************************************************************************
    'Button Click Detach Events
    '*********************************************************************************************************************


    Protected Sub btn_DetachEngine_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim IDVehicles As String = Request.QueryString("IDVehicles")
        Dim IDEngine As HiddenField = CType(fv_EngineDetails.FindControl("hf_IDEngines"), HiddenField)
        Dim IDEngines As String = IDEngine.Value

        Response.Redirect("../04_engines/engine_detach.aspx?IDProfileFleet=" & "&IDVehicles=" & IDVehicles & "&IDEngines=" & IDEngines)

    End Sub


    Protected Sub btn_DetachDECs_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim IDEngine As HiddenField = CType(fv_EngineDetails.FindControl("hf_IDEngines"), HiddenField)
        Dim IDEngines As String = IDEngine.Value
        'Dim IDDEC As HiddenField = CType(lv_DECSDetails.FindControl("hf_IDDECS"), HiddenField)
        'Dim IDDEC As HiddenField = CType(FindControlIterative(Page, "hf_IDDECS"), HiddenField)
        'Dim IDDECs As String = IDDEC.Value
        Dim IDDECs As String
        Dim myButton As Button = CType(sender, Button)
        IDDECs = myButton.CommandArgument

        Response.Redirect("../05_DECs/DECs_detach.aspx?IDDECS=" & IDDECs & "&IDEngines=" & IDEngines)

    End Sub




    '*********************************************************************************************************************
    'Button Click Attach Events
    '*********************************************************************************************************************


    Protected Sub btn_AttachEngine_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_AttachEngine.Click

        Dim IDProfilefleet As String = Request.QueryString("IDProfilefleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDVehicles As String = Request.QueryString("IDVehicles")

        Response.Redirect("../04_engines/engine_attach.aspx?IDProfileFleet=" & IDProfilefleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicles)

    End Sub



    Protected Sub btn_AttachDECs_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim IDProfileFleet As String = Request.QueryString("IDProfileFleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDVehicles As String = Request.QueryString("IDVehicles")
        Dim IDEngine As HiddenField = CType(fv_EngineDetails.FindControl("hf_IDEngines"), HiddenField)
        Dim IDEngines As String = IDEngine.Value

        Response.Redirect("../05_DECs/DECs_attach.aspx?IDProfileFleet=" & IDProfileFleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicles & "&IDEngines=" & IDEngines)

    End Sub



    '*********************************************************************************************************************
    'Form View Updating Events
    '*********************************************************************************************************************

    Protected Sub sds_CFV_DECs_lv_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles sds_CFV_DECs_lv.Updating

        Dim UserID As String
        Dim MemUser As MembershipUser
        MemUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey.ToString()

        If MemUser Is Nothing Then
            e.Cancel = True
        Else
            e.Command.Parameters("@IDModifiedUser").Value = UserID.ToString()
            e.Command.Parameters("@ModifiedDate").Value = DateTime.Now
        End If

    End Sub





    '*********************************************************************************************************************
    'Grid Pre-Render Events
    '*********************************************************************************************************************

    Protected Sub rg_VehicleImages_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rg_VehicleImages.PreRender

        rg_VehicleImages.MasterTableView.Rebind()

    End Sub

    Protected Sub rg_VehicleFiles_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rg_VehicleFiles.PreRender

        rg_VehicleFiles.MasterTableView.Rebind()

    End Sub

    Protected Sub rg_EngineImages_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rg_EngineImages.PreRender

        rg_EngineImages.MasterTableView.Rebind()

    End Sub

    Protected Sub rg_EngineFiles_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rg_EngineFiles.PreRender

        rg_EngineFiles.MasterTableView.Rebind()

    End Sub

    Protected Sub rg_DECSImages_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rg_DECSImages.PreRender

        rg_DECSImages.MasterTableView.Rebind()

    End Sub

    Protected Sub rg_DECsFiles_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rg_DECsFiles.PreRender

        rg_DECsFiles.MasterTableView.Rebind()

    End Sub




    '*********************************************************************************************************************
    'Grid Item Created Events
    '*********************************************************************************************************************

    Protected Sub rg_VehicleImages_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles rg_VehicleImages.ItemCreated

        If TypeOf e.Item Is GridDataItem Then
            Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
            Dim deleteBtn As LinkButton = DirectCast(item.FindControl("AutoGeneratedDeleteButton"), LinkButton)
            deleteBtn.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this image?')")
        End If

    End Sub


    Protected Sub rg_VehicleFiles_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles rg_VehicleFiles.ItemCreated

        If TypeOf e.Item Is GridDataItem Then
            Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
            Dim deleteBtn As LinkButton = DirectCast(item.FindControl("AutoGeneratedDeleteButton"), LinkButton)
            deleteBtn.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this file?')")
        End If

    End Sub


    Protected Sub rg_EngineImages_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles rg_EngineImages.ItemCreated

        If TypeOf e.Item Is GridDataItem Then
            Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
            Dim deleteBtn As LinkButton = DirectCast(item.FindControl("AutoGeneratedDeleteButton"), LinkButton)
            deleteBtn.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this image?')")
        End If

    End Sub


    Protected Sub rg_EngineFiles_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles rg_EngineFiles.ItemCreated

        If TypeOf e.Item Is GridDataItem Then
            Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
            Dim deleteBtn As LinkButton = DirectCast(item.FindControl("AutoGeneratedDeleteButton"), LinkButton)
            deleteBtn.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this file?')")
        End If

    End Sub


    Protected Sub rg_DECSImages_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles rg_DECSImages.ItemCreated

        If TypeOf e.Item Is GridDataItem Then
            Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
            Dim deleteBtn As LinkButton = DirectCast(item.FindControl("AutoGeneratedDeleteButton"), LinkButton)
            deleteBtn.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this image?')")
        End If

    End Sub


    Protected Sub rg_DECsFiles_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles rg_DECsFiles.ItemCreated

        If TypeOf e.Item Is GridDataItem Then
            Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
            Dim deleteBtn As LinkButton = DirectCast(item.FindControl("AutoGeneratedDeleteButton"), LinkButton)
            deleteBtn.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this file?')")
        End If

    End Sub


    Protected Sub rgd_LogOpacityTests_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles rgd_LogOpacityTests.ItemCreated

        If TypeOf e.Item Is GridDataItem Then
            Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
            Dim deleteBtn As LinkButton = DirectCast(item.FindControl("AutoGeneratedDeleteButton"), LinkButton)
            deleteBtn.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this log record?')")
        End If

    End Sub

    Protected Sub rgd_LogMileage_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles rgd_LogMileage.ItemCreated

        If TypeOf e.Item Is GridDataItem Then
            Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
            Dim deleteBtn As LinkButton = DirectCast(item.FindControl("AutoGeneratedDeleteButton"), LinkButton)
            deleteBtn.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this log record?')")
        End If

    End Sub


    Protected Sub rgd_LogHours_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles rgd_LogHours.ItemCreated

        If TypeOf e.Item Is GridDataItem Then
            Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
            Dim deleteBtn As LinkButton = DirectCast(item.FindControl("AutoGeneratedDeleteButton"), LinkButton)
            deleteBtn.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this log record?')")
        End If

    End Sub



    ''*********************************************************************************************************************
    ''Begin setting IDEngine Value for rg_EnginesFiles
    ''*********************************************************************************************************************

    Protected Sub rg_EnginesFiles_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles rg_EnginesFiles.DataBound

        Dim IDEngine As String = hf_rg_EnginesIDSelectedEngine.Value

        If IDEngine <> "" Then

            Dim IDEngines = New Guid(IDEngine)

            Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ToString)
            cn.Open()
            Dim SqlCmd As SqlCommand
            SqlCmd = New SqlCommand("SELECT [IDDECS] FROM [CF_DECS] WHERE IDEngines = @IDEngines", cn)

            SqlCmd.Parameters.Add("@IDEngines", SqlDbType.UniqueIdentifier).Value = IDEngines

            Dim IDDECS As Guid = SqlCmd.ExecuteScalar()

            Dim ID = IDDECS.ToString

            'Label1.Text = ID

            If IDDECS = Guid.Empty Then '"00000000-0000-0000-0000-000000000000" Then

                btn_AddDECSFile.Visible = False
                btn_AddDECSImage.Visible = False
            Else
                btn_AddDECSFile.Visible = True
                btn_AddDECSImage.Visible = True

            End If

            cn.Close()

        ElseIf IDEngine = "" Then

            btn_AddDECSFile.Visible = False
            btn_AddDECSImage.Visible = False
            btn_AddEngineFile.Visible = False
            btn_AddEngineImage.Visible = False
        End If

    End Sub


    Protected Sub rg_EnginesFiles_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rg_EnginesFiles.SelectedIndexChanged

        Dim IDEngines As String = rg_EnginesFiles.SelectedItems(0).OwnerTableView.DataKeyValues(rg_EnginesFiles.SelectedItems(0).ItemIndex)("IDEngines").ToString
        Dim IDEngine = New Guid(IDEngines)

        Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ToString)
        cn.Open()
        Dim SqlCmd As SqlCommand
        SqlCmd = New SqlCommand("SELECT [IDDECS] FROM [CF_DECS] WHERE IDEngines = @IDEngines", cn)

        SqlCmd.Parameters.Add("@IDEngines", SqlDbType.UniqueIdentifier).Value = IDEngine

        Dim Value As Guid = SqlCmd.ExecuteScalar()

        Dim ID = Value.ToString

        'Label1.Text = ID

        If ID = "00000000-0000-0000-0000-000000000000" Then

            btn_AddDECSFile.Visible = False
            btn_AddDECSImage.Visible = False
        Else
            btn_AddDECSFile.Visible = True
            btn_AddDECSImage.Visible = True

        End If

        cn.Close()


        hf_rg_EnginesFilesIDEngines.Value = IDEngines
        Me.ViewState("EnginesID") = IDEngines
    End Sub



    ''*********************************************************************************************************************
    ''End setting IDEngine Value for rg_EnginesFiles
    ''*********************************************************************************************************************




    '*********************************************************************************************************************
    'Radio Button Checked Changed Events - Set Default Image
    '*********************************************************************************************************************

    Protected Sub rbt_VehicleImage_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim item As GridDataItem = DirectCast(TryCast(sender, RadioButton).NamingContainer, GridDataItem)
        Dim rdBtn As RadioButton = TryCast(sender, RadioButton)
        Dim IDImages As Guid = item.OwnerTableView.DataKeyValues(item.ItemIndex)("IDImages")
        Dim IDVehicles As New Guid(Request.QueryString("IDVehicles"))


        If rdBtn.Checked = True Then

            Dim sql As String
            Dim strConnString As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
            sql = "UPDATE CF_Images SET DefaultImage = @Value WHERE IDVehicles = @IDVehicles"
            Dim connection As New SqlConnection(strConnString)
            Dim command As New SqlCommand(sql, connection)

            command.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicles
            command.Parameters.Add("@Value", SqlDbType.Int).Value = "0"
            command.Connection.Open()
            command.ExecuteNonQuery()
            command.Connection.Close()

            Dim sql1 As String
            Dim strConnString1 As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
            sql1 = "UPDATE CF_Images SET DefaultImage = @Value WHERE IDVehicles = @IDVehicles AND IDImages = @IDImages"
            Dim connection1 As New SqlConnection(strConnString1)
            Dim command1 As New SqlCommand(sql1, connection1)

            command1.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicles
            command1.Parameters.Add("@Value", SqlDbType.Int).Value = "1"
            command1.Parameters.Add("@IDImages", SqlDbType.UniqueIdentifier).Value = IDImages
            command1.Connection.Open()
            command1.ExecuteNonQuery()
            command1.Connection.Close()
            fv_VehicleImage.DataBind()
        Else

        End If

    End Sub


    Protected Sub rbt_EngineImage_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)

        'Dim IDEngine As HiddenField = CType(fvw_IDEngines.FindControl("hf_IDEnginesImage"), HiddenField)
        'Dim IDEngines As String = IDEngine.Value

        Dim IDEngine As String = hf_rg_EnginesFilesIDEngines.Value
        Dim IDEngines As New Guid(IDEngine)


        Dim item As GridDataItem = DirectCast(TryCast(sender, RadioButton).NamingContainer, GridDataItem)
        Dim rdBtn As RadioButton = TryCast(sender, RadioButton)
        Dim IDImages As Guid = item.OwnerTableView.DataKeyValues(item.ItemIndex)("IDImages")
        'Dim IDVehicles As New Guid(Request.QueryString("IDVehicles"))

        If rdBtn.Checked = True Then

            Dim sql As String
            Dim strConnString As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
            sql = "UPDATE CF_Images SET DefaultImage = @Value WHERE IDEngines = @IDEngines AND IDDECS IS NULL"
            Dim connection As New SqlConnection(strConnString)
            Dim command As New SqlCommand(sql, connection)

            command.Parameters.Add("@Value", SqlDbType.Int).Value = "0"
            'command.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicles
            command.Parameters.Add("@IDEngines", SqlDbType.UniqueIdentifier).Value = IDEngines

            command.Connection.Open()
            command.ExecuteNonQuery()
            command.Connection.Close()



            Dim sql1 As String
            Dim strConnString1 As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
            sql1 = "UPDATE CF_Images SET DefaultImage = @Value WHERE IDImages = @IDImages"
            Dim connection1 As New SqlConnection(strConnString1)
            Dim command1 As New SqlCommand(sql1, connection1)

            command1.Parameters.Add("@Value", SqlDbType.Int).Value = "1"
            command1.Parameters.Add("@IDImages", SqlDbType.UniqueIdentifier).Value = IDImages
            command1.Connection.Open()
            command1.ExecuteNonQuery()
            command1.Connection.Close()

            fv_EngineImage.DataBind()

        Else

        End If


    End Sub



    Protected Sub rbt_DECSImage_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim IDEngine As String = hf_rg_EnginesFilesIDEngines.Value
        Dim IDEngines As New Guid(IDEngine)

        sds_ImagesDECs.DataBind()
        fvw_IDDECS.DataBind()

        Dim item As GridDataItem = DirectCast(TryCast(sender, RadioButton).NamingContainer, GridDataItem)
        Dim rdBtn As RadioButton = TryCast(sender, RadioButton)

        Dim hf_IDDEC As HiddenField = CType(fvw_IDDECS.FindControl("hf_IDDECSImage"), HiddenField)
        Dim IDDEC As String = hf_IDDEC.Value
        Dim IDDECS As New Guid(IDDEC)


        Dim IDImages As Guid = item.OwnerTableView.DataKeyValues(item.ItemIndex)("IDImages")


        If rdBtn.Checked = True Then

            Dim sql As String
            Dim strConnString As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
            sql = "UPDATE CF_Images SET DefaultImage = @Value WHERE IDDECS = @IDDECS AND IDEngines = @IDEngines"
            Dim connection As New SqlConnection(strConnString)
            Dim command As New SqlCommand(sql, connection)

            command.Parameters.Add("@Value", SqlDbType.Int).Value = "0"
            command.Parameters.Add("@IDDECS", SqlDbType.UniqueIdentifier).Value = IDDECS
            command.Parameters.Add("@IDEngines", SqlDbType.UniqueIdentifier).Value = IDEngines
            command.Connection.Open()
            command.ExecuteNonQuery()
            command.Connection.Close()

            Dim sql1 As String
            Dim strConnString1 As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
            sql1 = "UPDATE CF_Images SET DefaultImage = @Value WHERE IDImages = @IDImages AND IDEngines = @IDEngines"
            Dim connection1 As New SqlConnection(strConnString1)
            Dim command1 As New SqlCommand(sql1, connection1)

            command1.Parameters.Add("@Value", SqlDbType.Int).Value = "1"
            command1.Parameters.Add("@IDImages", SqlDbType.UniqueIdentifier).Value = IDImages
            command1.Parameters.Add("@IDEngines", SqlDbType.UniqueIdentifier).Value = IDEngines

            command1.Connection.Open()
            command1.ExecuteNonQuery()
            command1.Connection.Close()

            fv_DECSImage.DataBind()


        Else

        End If

    End Sub


    ''*********************************************************************************************************************
    ''Begin setting IDEngine Value for rg_Engines
    ''*********************************************************************************************************************




    Protected Sub rg_Engines_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rg_Engines.SelectedIndexChanged

        hf_rg_EnginesIDSelectedEngine.Value = rg_Engines.SelectedItems(0).OwnerTableView.DataKeyValues(rg_Engines.SelectedItems(0).ItemIndex)("IDEngines")
        hf_rg_EnginesFilesIDEngines.Value = rg_Engines.SelectedItems(0).OwnerTableView.DataKeyValues(rg_Engines.SelectedItems(0).ItemIndex)("IDEngines")
        Me.ViewState("EnginesID") = hf_rg_EnginesIDSelectedEngine.Value
    End Sub

    ''*********************************************************************************************************************
    ''End setting IDEngine Value for rg_Engines
    ''*********************************************************************************************************************


    ''*********************************************************************************************************************
    ''Prevent adding DECS if Engine already has associated DECS
    ''*********************************************************************************************************************

    Protected Sub fv_EngineDetails_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles fv_EngineDetails.DataBound

        Dim IDEngine As String = hf_rg_EnginesIDSelectedEngine.Value

        If IDEngine = "00000000-0000-0000-0000-000000000000" Then

            Dim btn_AddDECs As Button = CType(fv_EngineDetails.FindControl("btn_AddDECs"), Button)
            Dim btn_AttachDECS As Button = CType(fv_EngineDetails.FindControl("btn_AttachDECS"), Button)

            If btn_AddDECs IsNot Nothing Then
                btn_AddDECs.Visible = False
            End If
            If btn_AttachDECS IsNot Nothing Then
                btn_AttachDECS.Visible = False
            End If

            'ElseIf (Not Request("hf_rg_EnginesIDSelectedEngine") = "") Then
        Else


            Dim IDEngines = New Guid(IDEngine)
            Dim btn_AddDECs As Button = CType(fv_EngineDetails.FindControl("btn_AddDECs"), Button)
            Dim btn_AttachDECS As Button = CType(fv_EngineDetails.FindControl("btn_AttachDECS"), Button)

            Dim connectionString1 As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
            Dim conn1 As New SqlConnection(connectionString1)
            Dim comm1 As New SqlCommand("SELECT COUNT(*) FROM CF_DECS WHERE IDEngines = @IDEngines", conn1)
            comm1.Connection.Open()

            comm1.Parameters.Add("@IDEngines", SqlDbType.UniqueIdentifier).Value = IDEngines

            Dim strReturn As String = comm1.ExecuteScalar()

            If fv_EngineDetails.CurrentMode = FormViewMode.ReadOnly Then


                If Convert.ToInt32(strReturn) > 0 Then

                    btn_AddDECs.Visible = False
                    btn_AttachDECS.Visible = False

                Else
                    btn_AddDECs.Visible = True
                    btn_AttachDECS.Visible = True

                End If

            End If

        End If

    End Sub



    ''*********************************************************************************************************************
    '' MG 11/21/2011 Prevent DataBinding problems if make value is not in the selected list
    ''*********************************************************************************************************************

    Protected Sub PreventErrorOnbinding(ByVal sender As Object, ByVal e As EventArgs)
        ' if the selected option is no longer in the list, it'll throw problems.  This will set the value to the first item in the select list (should be "Select")
        Dim theDropDownList As DropDownList = CType(sender, DropDownList)
        RemoveHandler theDropDownList.DataBinding, AddressOf Me.PreventErrorOnbinding
        theDropDownList.AppendDataBoundItems = True
        If theDropDownList.Items.Count > 1 Then

            Dim firstLi As ListItem = theDropDownList.Items(0)
            theDropDownList.Items.Clear()
            theDropDownList.Items.Add(firstLi)
        Else

        End If

        Try
            theDropDownList.DataBind()
            ' bug where we're binding this twice and I can't control one of the bindings
        Catch exc As ArgumentOutOfRangeException

            theDropDownList.SelectedValue = theDropDownList.Items(0).Value

        End Try

        AddHandler theDropDownList.DataBinding, AddressOf Me.PreventErrorOnbinding
    End Sub


    ' MG 11/22/2011 - Check that the VIN is unique before creating record
    Sub UniqueVINValidator(ByVal sender As Object, ByVal args As ServerValidateEventArgs)
        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection, strsqlvalidate As String
        Dim IDVehicles As New Guid(Request.QueryString("IDVehicles"))

        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim currentUserId As Guid = CType(currentUser.ProviderUserKey, Guid)
        Dim count As Integer = 0

        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        conn = New SqlConnection(strconnection)

        strsqlvalidate = "SELECT COUNT(*) FROM CF_Vehicles WHERE UPPER(RTRIM(ChassisVIN)) = UPPER(RTRIM(@ChassisVIN)) AND UPPER(RTRIM(ChassisVIN)) > '' " &
          " AND (CF_Vehicles.IDVehicles <> @IDVehicles OR @IDVehicles IS NULL)"
        cmd = New SqlCommand(strsqlvalidate, conn)
        cmd.Parameters.Add("@ChassisVIN", SqlDbType.VarChar, 50).Value = args.Value
        If Request.QueryString("IDVehicles") > "" Then
            cmd.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicles
        Else
            cmd.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = DBNull.Value
        End If
        cmd.Connection.Open()
        count = cmd.ExecuteScalar()
        cmd.Connection.Close()

        args.IsValid = (count = 0)
    End Sub


    ' MG 11/22/2011 - Check that the License Plate Number is unique before creating record
    Sub UniqueLicensePlateNoValidator(ByVal sender As Object, ByVal args As ServerValidateEventArgs)
        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection, strsqlvalidate As String
        Dim IDVehicles As New Guid(Request.QueryString("IDVehicles"))
        Dim LicensePlateState As String = ""
        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim currentUserId As Guid = CType(currentUser.ProviderUserKey, Guid)
        Dim count As Integer = 0

        LicensePlateState = CType(Me.fv_CFV_Vehicles.FindControl("ddl_LicensePlateState"), DropDownList).SelectedItem.Value

        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        conn = New SqlConnection(strconnection)

        strsqlvalidate = "SELECT COUNT(*) FROM CF_Vehicles WHERE UPPER(RTRIM(LicensePlateNo)) = UPPER(RTRIM(@LicensePlateNo)) " &
          " AND UPPER(RTRIM(LicensePlateState)) = UPPER(RTRIM(@LicensePlateState)) " &
          " AND UPPER(RTRIM(LicensePlateNo)) > '' " &
          " AND (CF_Vehicles.IDVehicles <> @IDVehicles OR @IDVehicles IS NULL)"
        cmd = New SqlCommand(strsqlvalidate, conn)
        cmd.Parameters.Add("@LicensePlateNo", SqlDbType.VarChar, 50).Value = args.Value
        cmd.Parameters.Add("@LicensePlateState", SqlDbType.VarChar, 2).Value = LicensePlateState
        If Request.QueryString("IDVehicles") > "" Then
            cmd.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicles
        Else
            cmd.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = DBNull.Value
        End If
        cmd.Connection.Open()
        count = cmd.ExecuteScalar()
        cmd.Connection.Close()

        args.IsValid = (count = 0)
    End Sub

    Protected Sub UniqueEngineSerialNumValidator(ByVal sender As Object, ByVal args As ServerValidateEventArgs)
        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection, strsqlvalidate As String

        'Response.write(me.hf_IDEngines.value)
        'Response.End()
        Dim IDEngines As New Guid(CType(Me.fv_EngineDetails.FindControl("hf_IDEngines"), HiddenField).Value)

        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim currentUserId As Guid = CType(currentUser.ProviderUserKey, Guid)
        Dim count As Integer = 0

        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        conn = New SqlConnection(strconnection)

        strsqlvalidate = "SELECT COUNT(*) FROM CF_Engines WHERE UPPER(RTRIM(SerialNum)) = UPPER(RTRIM(@SerialNum)) AND UPPER(RTRIM(SerialNum)) > '' " &
           " AND (CF_Engines.IDEngines <> @IDEngines OR @IDEngines IS NULL)"
        cmd = New SqlCommand(strsqlvalidate, conn)
        cmd.Parameters.Add("@SerialNum", SqlDbType.VarChar, 50).Value = args.Value
        If Request.QueryString("IDVehicles") > "" Then
            cmd.Parameters.Add("@IDEngines", SqlDbType.UniqueIdentifier).Value = IDEngines
        Else
            cmd.Parameters.Add("@IDEngines", SqlDbType.UniqueIdentifier).Value = DBNull.Value
        End If
        cmd.Connection.Open()
        count = cmd.ExecuteScalar()
        cmd.Connection.Close()
        Response.Write(count)
        'Response.End()
        args.IsValid = (count = 0)
    End Sub

    ' MG 12/14/2011 - there were problems finding hf_IDDECS control on page (different tab maybe?), so I use this function to find it instead
    Public Shared Function FindControlIterative(ByVal myRoot As Control, ByVal myIDOfControlToFind As String) As Control
        Dim myRootControl As Control = New Control
        myRootControl = myRoot
        Dim setOfChildControls As LinkedList(Of Control) = New LinkedList(Of Control)

        Do While (myRootControl IsNot Nothing)
            If myRootControl.ID = myIDOfControlToFind Then
                Return myRootControl
            End If
            For Each childControl As Control In myRootControl.Controls
                If childControl.ID = myIDOfControlToFind Then
                    Return childControl
                End If
                If childControl.HasControls() Then
                    setOfChildControls.AddLast(childControl)
                End If
            Next
            myRootControl = setOfChildControls.First.Value
            setOfChildControls.Remove(myRootControl)
        Loop
        Return Nothing

    End Function

    Public Sub fv_CFV_Vehicles_ItemUpdated(ByVal sender As Object, ByVal e As FormViewUpdatedEventArgs) Handles fv_CFV_Vehicles.ItemUpdated
        RefreshVehicleMileage(Nothing, Nothing)
        RefreshVehicleHours(Nothing, Nothing)
        RefreshWeightDefinition(Nothing, Nothing)
    End Sub


    Public Sub RefreshVehicleMileage(ByVal source As Object, ByVal e As Object) 'Handles rgd_LogMileage.ItemCreated, rgd_LogMileage.ItemDeleted, rgd_LogMileage.ItemUpdated
        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection As String
        Dim IDVehicles As New Guid(Request.QueryString("IDVehicles"))


        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        conn = New SqlConnection(strconnection)

        cmd = New SqlCommand("EXECUTE UpdateVehicleMileage @IDVehicles", conn)
        If Request.QueryString("IDVehicles") > "" Then
            cmd.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicles
        Else
            cmd.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = DBNull.Value
        End If
        cmd.Connection.Open()
        cmd.ExecuteNonQuery()
        cmd.Connection.Close()

        CType(FindControlIterative(Page, "fv_CFV_Vehicles"), FormView).DataBind()
    End Sub


    Public Sub RefreshVehicleHours(ByVal source As Object, ByVal e As Object) 'Handles rgd_LogMileage.ItemCreated, rgd_LogMileage.ItemDeleted, rgd_LogMileage.ItemUpdated
        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection As String
        Dim IDVehicles As New Guid(Request.QueryString("IDVehicles"))


        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        conn = New SqlConnection(strconnection)

        cmd = New SqlCommand("EXECUTE UpdateVehicleHours @IDVehicles", conn)
        If Request.QueryString("IDVehicles") > "" Then
            cmd.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicles
        Else
            cmd.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = DBNull.Value
        End If
        cmd.Connection.Open()
        cmd.ExecuteNonQuery()
        cmd.Connection.Close()

        CType(FindControlIterative(Page, "fv_CFV_Vehicles"), FormView).DataBind()
    End Sub

    Public Function RefreshWeightDefinition(ByVal source As Object, ByVal e As Object)
        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection As String
        Dim IDVehicles As New Guid(Request.QueryString("IDVehicles"))

        Dim GVWRstr As String = CType(Me.fv_CFV_Vehicles.FindControl("tbx_GrossVehicleWeight"), TextBox).Text
        Dim GVWR As Integer
        Dim IDWeightDefinition = 0
        Dim IDRuleCode As Integer = 0
        Dim RuleCode As String = ""

        If Integer.TryParse(CType(Me.fv_CFV_Vehicles.FindControl("ddl_CARBGroup"), DropDownList).SelectedItem.Value, IDRuleCode) Then
            RuleCode = CType(Me.fv_CFV_Vehicles.FindControl("ddl_CARBGroup"), DropDownList).SelectedItem.Text
        End If

        If Integer.TryParse(GVWRstr, NumberStyles.AllowThousands, CultureInfo.CurrentCulture, GVWR) Then
            If RuleCode = "On Road" Then
                If GVWR > 14000 AndAlso GVWR <= 26000 Then ' WeightDefinition should be Lighter Vehicle
                    IDWeightDefinition = getWeightDefinitionID("LighterVehicle")
                ElseIf GVWR > 26000 Then
                    IDWeightDefinition = getWeightDefinitionID("HeavierVehicle")
                End If
            End If
        End If


        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        conn = New SqlConnection(strconnection)

        cmd = New SqlCommand("UPDATE CF_Vehicles SET [IDWeightDefinition] = @IDWeightDefinition WHERE [IDVehicles] = @IDVehicles", conn)
        cmd.Parameters.Add("@IDWeightDefinition", SqlDbType.Int).Value = IDWeightDefinition
        cmd.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicles
        cmd.Connection.Open()
        cmd.ExecuteNonQuery()
        cmd.Connection.Close()

        CType(FindControlIterative(Page, "fv_CFV_Vehicles"), FormView).DataBind()
    End Function


    Private Function getWeightDefinitionID(ByVal recordValue As String) As Integer
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        Dim idWeightDefinition As Integer
        Dim sqlStr = "SELECT IDOptionList " &
            "FROM CF_Option_List " &
            "WHERE RecordValue = @RecordValue AND OptionName = @OptionName"
        comm = New SqlCommand(sqlStr, conn)
        comm.Connection.Open()
        comm.Parameters.AddWithValue("@RecordValue", recordValue)
        comm.Parameters.AddWithValue("@OptionName", "WeightDefinition")

        idWeightDefinition = comm.ExecuteScalar()
        If idWeightDefinition = 0 AndAlso recordValue > "" Then
            Throw New ArgumentException("Record value '" & recordValue & "' not found in DB")
        End If

        comm.Connection.Close()

        Return idWeightDefinition
    End Function

End Class




