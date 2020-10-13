Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.CodeDom
Imports System.Web
Imports System.Security
Imports System.Security.Principal.WindowsIdentity
Imports CF.Modules
Imports CF.Nexus


Public Class _default3
    Inherits BaseWebForm

    Protected ComplianceModule As CF.Modules.DefaultModule
    Protected FleetSummary As CF.Modules.DefaultModule
    Protected OpacityTest As CF.Modules.DefaultModule

    Protected EngineModelReplacementModule As CF.Modules.DefaultModule
    Protected STBPhaseInOption As CF.Modules.DefaultModule
    Protected LowMileageConstruction As CF.Modules.DefaultModule
    Protected NOxExempt As CF.Modules.DefaultModule

    Protected customModules As CF.Modules.CustomModule

    Protected IDProfileAccount As String

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        IDProfileAccount = "IDProfileAccount"
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim queryString As String = "SELECT IDProfileAccount, IDProfileContact, ContactName, Account FROM CFV_Profile_Contact WHERE UserName = @UserName"

        Using myConnection As New SqlConnection(connectionString)
            Dim myCommand As New SqlCommand(queryString, myConnection)
            myConnection.Open()
            myCommand.Parameters.AddWithValue("@UserName", User.Identity.Name)
            Dim MyReader As SqlDataReader = myCommand.ExecuteReader
            MyReader.Read()
            Session("IDProfileAccount") = MyReader("IDProfileAccount")
            Session("IDProfileContact") = MyReader("IDProfileContact")
            lbl_User.Text = If(IsDBNull(MyReader("ContactName")), "", MyReader("ContactName"))
            lbl_Account.Text = If(IsDBNull(MyReader("Account")), "", MyReader("Account"))
            myConnection.Close()
        End Using

        'bindModules()

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        getModules()
        'file modules
        If FleetSummary.isDisplayed() Then
            buildDefaultModuleFileRdg(FleetSummary.getDataTable())
        End If
        If OpacityTest.isDisplayed() Then
            buildDefaultModuleFileRdg(OpacityTest.getDataTable())
        End If
        If ComplianceModule.isDisplayed() Then
            buildDefaultModuleFileRdg(ComplianceModule.getDataTable())
        End If

        If EngineModelReplacementModule.isDisplayed() Then
            buildDefaultModuleReportRdg(EngineModelReplacementModule.getDataTable(), "Title", "Engine Model Year Replacement Schedule for {0} Vehicles")
        End If
        If STBPhaseInOption.isDisplayed() Then
            buildDefaultModuleReportRdg(STBPhaseInOption.getDataTable(), "URL", "STB Phase-In Option Report")
        End If
        If LowMileageConstruction.isDisplayed() Then
            buildDefaultModuleReportRdg(LowMileageConstruction.getDataTable(), "URL", "Low Mileage Construction Report")
        End If
        If NOxExempt.isDisplayed() Then
            buildDefaultModuleReportRdg(NOxExempt.getDataTable(), "Title", "NOx Exempt Report for <br />{0} Vehicles")
        End If

        'report link modules






        buildCustomModuleRdg()
    End Sub


    Private Sub getModules()
        ComplianceModule = New CF.Modules.DefaultModule(Session("IDProfileAccount"), Session("IDProfileContact"), CF.Modules.DefaultModule.ModuleType.ComplianceCertification)
        EngineModelReplacementModule = New CF.Modules.DefaultModule(Session("IDProfileAccount"), Session("IDProfileContact"), CF.Modules.DefaultModule.ModuleType.EngineModelYearReplacementSchedule)
        FleetSummary = New CF.Modules.DefaultModule(Session("IDProfileAccount"), Session("IDProfileContact"), CF.Modules.DefaultModule.ModuleType.FleetSummary)
        OpacityTest = New CF.Modules.DefaultModule(Session("IDProfileAccount"), Session("IDProfileContact"), CF.Modules.DefaultModule.ModuleType.OpacityTest)
        STBPhaseInOption = New CF.Modules.DefaultModule(Session("IDProfileAccount"), Session("IDProfileContact"), CF.Modules.DefaultModule.ModuleType.STBPhaseInOption)
        LowMileageConstruction = New CF.Modules.DefaultModule(Session("IDProfileAccount"), Session("IDProfileContact"), CF.Modules.DefaultModule.ModuleType.LowMileageConstruction)
        NOxExempt = New CF.Modules.DefaultModule(Session("IDProfileAccount"), Session("IDProfileContact"), CF.Modules.DefaultModule.ModuleType.NOxExempt)
    End Sub

    Private Sub bindModules()
        rgd_ComplianceCertification.DataSource = ComplianceModule.getDataTable()
        rgd_FleetSummary.DataSource = FleetSummary.getDataTable()
        rgd_OpacityTests.DataSource = OpacityTest.getDataTable()

        rgd_EngineModelYearReplacementSchedule.DataSource = EngineModelReplacementModule.getDataTable()
        rgd_STBPhaseInOption.DataSource = STBPhaseInOption.getDataTable()
        rgd_NOxExempt.DataSource = NOxExempt.getDataTable()
        rgd_LowMileageConstruction.DataSource = LowMileageConstruction.getDataTable()
    End Sub

    Private Sub buildCustomModuleRdg()
        customModules = New CF.Modules.CustomModule(Session("IDProfileAccount"), Session("IDProfileContact"))

        For Each moduleTable In customModules.getModules()
            Dim rdg = New RadGrid()
            rdg.DataSource = moduleTable
            rdg.AutoGenerateColumns = False
            rdg.CssClass = "tablecenter module"
            rdg.HorizontalAlign = HorizontalAlign.Center
            rdg.Skin = "Default"

            Dim linkColumn As GridHyperLinkColumn
            linkColumn = New GridHyperLinkColumn()
            linkColumn.DataTextFormatString = "{0}"
            linkColumn.DataTextField = "Title"
            linkColumn.DataNavigateUrlFields = New String() {"FilePath", "FileName"}
            linkColumn.DataNavigateUrlFormatString = "{0}/{1}"
            linkColumn.HeaderText = moduleTable.TableName
            rdg.MasterTableView.Columns.Add(linkColumn)
            CustomModulesPlaceHolder.Controls.Add(rdg)
            'newLabel.Text = moduleTable.TableName
        Next
    End Sub

    ' The radgrids for the default modules that contain files
    ' are a bit different than the default modules that contain
    ' reports to links.  They should probably be refactored to 
    ' not require different settings to render.
    Private Sub buildDefaultModuleFileRdg(ByVal moduleTable As DataTable)
        Dim rdg = New RadGrid()
        rdg.DataSource = moduleTable
        rdg.AutoGenerateColumns = False
        rdg.CssClass = "tablecenter module"
        rdg.HorizontalAlign = HorizontalAlign.Center
        rdg.Skin = "Default"

        Dim linkColumn As GridHyperLinkColumn
        linkColumn = New GridHyperLinkColumn()
        linkColumn.DataTextFormatString = "{0}"
        linkColumn.DataTextField = "Title"
        linkColumn.DataNavigateUrlFields = New String() {"FilePath", "FileName"}
        linkColumn.DataNavigateUrlFormatString = "{0}/{1}"
        linkColumn.HeaderText = moduleTable.TableName
        rdg.MasterTableView.Columns.Add(linkColumn)
        CustomModulesPlaceHolder.Controls.Add(rdg)

    End Sub

    Private Sub buildDefaultModuleReportRdg(ByVal moduleTable As DataTable, ByVal dataTextField As String, ByVal dataFormatString As String)
        Dim rdg = New RadGrid()
        rdg.DataSource = moduleTable
        rdg.AutoGenerateColumns = False
        rdg.CssClass = "tablecenter module"
        rdg.HorizontalAlign = HorizontalAlign.Center
        rdg.Skin = "Default"

        Dim linkColumn As GridHyperLinkColumn
        linkColumn = New GridHyperLinkColumn()
        linkColumn.DataTextFormatString = dataFormatString
        linkColumn.DataTextField = dataTextField
        linkColumn.DataNavigateUrlFields = New String() {"URL"}
        linkColumn.DataNavigateUrlFormatString = "{0}"
        linkColumn.HeaderText = moduleTable.TableName
        rdg.MasterTableView.Columns.Add(linkColumn)
        CustomModulesPlaceHolder.Controls.Add(rdg)
    End Sub
End Class

