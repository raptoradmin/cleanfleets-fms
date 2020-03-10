Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Public Class _06_vehicles_detailed_by_CARB1
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Loadaccounts()
            fillTerminals(0)
            fillFleets(0)
        End If
    End Sub


    Protected Sub ddl_CARBGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDOptionList As Integer = Convert.ToInt32(ddl_CARBGroup.selectedValue.toString())
        'fillFleets(IDProfileTerminal)
    End Sub

    Protected Sub ddl_RuleCode_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDOptionList As Integer = Convert.ToInt32(ddl_RuleCode.selectedValue.toString())
    End Sub


    '	Protected Sub fillFleets(IDProfileTerminal as integer)
    '		if IDProfileTerminal > 0 then
    '			Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
    '	
    '			Dim adapter As New SqlDataAdapter("SELECT * FROM [CF_Profile_Fleet] WHERE ([IDProfileTerminal] = @IDProfileTerminal)", connection)
    '			adapter.SelectCommand.Parameters.AddWithValue("@IDProfileTerminal", IDProfileTerminal)
    '	
    '			Dim dt As New DataTable()
    '			adapter.Fill(dt)
    '	
    '			ddl_Fleet.DataTextField = "FleetName"
    '			ddl_Fleet.DataValueField = "IDProfileFleet"
    '			ddl_Fleet.DataSource = dt
    '			ddl_Fleet.DataBind()
    '			ddl_Fleet.Items.Insert(0, New ListItem("- Select Fleet -","0"))
    '		else
    '			ddl_Fleet.items.clear()
    '		end if
    '	End Sub

    Protected Sub ddl_Account_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileAccount As Integer = Convert.ToInt32(ddl_Account.selectedValue.toString())
        fillTerminals(IDProfileAccount)
        fillFleets(0)
    End Sub

    Protected Sub ddl_Terminal_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileTerminal As Integer = Convert.ToInt32(ddl_Terminal.selectedValue.toString())
        fillFleets(IDProfileTerminal)
    End Sub

    Protected Sub ddl_Fleet_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) 'Handles RadComboBox3.SelectedIndexChanged

        'Session("IDProfileFLeet") = RadComboBox3.SelectedValue

    End Sub

    Protected Sub btn_Query_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Query.Click
        Dim IDProfileAccount As Integer = Convert.ToInt32(ddl_Account.selectedValue.toString())
        'rg_Terminals.DataSource = sds_Vehicles
        rg_Terminals.Rebind()
        rg_Terminals.visible = True
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
            ddl_Terminal.Items.Insert(0, New ListItem("", "0"))
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
            ddl_Fleet.Items.Insert(0, New ListItem("", "0"))
        End If
    End Sub

    Protected Sub rg_Terminals_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles rg_Terminals.ItemCommand
        If e.CommandName = Telerik.Web.UI.RadGrid.ExportToCsvCommandName Then
            'rg_Terminals.DataSource = ""
            rg_Terminals.Rebind()
            rg_Terminals.visible = True
            rg_Terminals.ExportSettings.ExportOnlyData = False
        Else
            rg_Terminals.visible = True
        End If

    End Sub

    Protected Sub rg_Terminals_OnLoad(ByVal o As Object, ByVal e As EventArgs) Handles rg_Terminals.Load
        Dim IDOptionList As Integer
        Dim visibleF As Boolean = False
        'visibleF = visibleF andAlso (Integer.tryParse(ddl_CARBGroup.selectedValue.toString, IDOptionList) andAlso IDOptionList > 0)
        visibleF = (Integer.TryParse(ddl_Account.selectedValue.toString, IDOptionList) AndAlso visibleF AndAlso IDOptionList > -1)
        rg_Terminals.visible = visibleF
    End Sub

    Protected Sub rg_Terminals_ItemCreated(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rg_Terminals.ItemCreated
        If TypeOf e.Item Is GridCommandItem Then
            e.Item.FindControl("InitInsertButton").Parent.Visible = False
        End If

    End Sub

End Class
