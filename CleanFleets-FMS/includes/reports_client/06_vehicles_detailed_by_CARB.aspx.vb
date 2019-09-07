Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Public Class _06_vehicles_detailed_by_CARB
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Loadaccounts()
        End If
        Dim UserID As Guid
        Dim MemUser As MembershipUser
        MemUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey
        sds_Vehicles.SelectParameters("UserId").DefaultValue = UserID.ToString()
    End Sub



    Protected Sub ddl_Account_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        'dim IDProfileAccount as integer = Convert.toInt32(ddl_Account.selectedValue.toString())
        'fillTerminals(IDProfileAccount)
        'fillFleets(0)
    End Sub

    'Protected Sub fillTerminals(IDProfileAccount as integer)
    '		if IDProfileAccount > 0 then 
    '			Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
    '	
    '			Dim adapter As New SqlDataAdapter("SELECT * FROM [CF_Profile_Terminal] WHERE ([IDProfileAccount] = @IDProfileAccount) ORDER BY [TerminalName]", connection)
    '			adapter.SelectCommand.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
    '	
    '			Dim dt As New DataTable()
    '			adapter.Fill(dt)
    '	
    '			ddl_Terminal.DataTextField = "TerminalName"
    '			ddl_Terminal.DataValueField = "IDProfileTerminal"
    '			ddl_Terminal.DataSource = dt
    '			ddl_Terminal.DataBind()
    '			ddl_Terminal.Items.Insert(0, New ListItem("- Select Terminal -","0"))
    '		else
    '			ddl_Terminal.items.clear()
    '		end if
    '	End Sub

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

    Protected Sub ddl_Fleet_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        ' do nothing
    End Sub


    Protected Sub rg_Terminals_OnLoad(ByVal o As Object, ByVal e As EventArgs) Handles rg_Terminals.Load
        Dim IDOptionList As Integer
        'rg_Terminals.visible = (Integer.tryParse(ddl_CARBGroup.selectedValue.toString, IDOptionList) andAlso IDOptionList > 0) 
    End Sub

    Protected Sub rg_Terminals_ItemCreated(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rg_Terminals.ItemCreated
        If TypeOf e.Item Is GridCommandItem Then
            e.Item.FindControl("InitInsertButton").Parent.Visible = False
        End If

    End Sub

End Class
