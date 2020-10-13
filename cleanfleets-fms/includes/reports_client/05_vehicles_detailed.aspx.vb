Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Public Class _05_vehicles_detailed
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        Dim UserID As Guid
        Dim MemUser As MembershipUser
        MemUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey

        sds_ddl_Terminal.SelectParameters("UserId").DefaultValue = UserID.ToString()

        If Not Page.IsPostBack Then
            'Loadaccounts()
            'fillTerminals(Session("IDProfileAccount"))
        End If

    End Sub

    'Protected Sub Loadaccounts()
    '        Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
    '
    '        Dim adapter As New SqlDataAdapter("SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]", connection)
    '        Dim dt As New DataTable()
    '        adapter.Fill(dt)
    '
    '        RadComboBox1.DataTextField = "AccountName"
    '        RadComboBox1.DataValueField = "IDProfileAccount"
    '        RadComboBox1.DataSource = dt
    '        RadComboBox1.DataBind()
    '        RadComboBox1.Items.Insert(0, New RadComboBoxItem("- Select Account -"))
    '    End Sub
    '
    '    Protected Sub Loadterminals(ByVal IDProfileAccount As String)
    '		if IDProfileAccount > "" then 
    '			Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
    '	
    '			Dim adapter As New SqlDataAdapter("SELECT * FROM [CF_Profile_Terminal] WHERE ([IDProfileAccount] = @IDProfileAccount) ORDER BY [TerminalName]", connection)
    '			adapter.SelectCommand.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
    '	
    '			Dim dt As New DataTable()
    '			adapter.Fill(dt)
    '	
    '			RadComboBox2.DataTextField = "TerminalName"
    '			RadComboBox2.DataValueField = "IDProfileTerminal"
    '			RadComboBox2.DataSource = dt
    '			RadComboBox2.DataBind()
    '			RadComboBox2.Items.Insert(0, New RadComboBoxItem("- Select Terminal -"))
    '		end if
    '    End Sub
    '
    '    Protected Sub Loadfleets(ByVal IDProfileTerminal As String)
    '		if IDProfileTerminal > "" then
    '			Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
    '	
    '			Dim adapter As New SqlDataAdapter("SELECT * FROM [CF_Profile_Fleet] WHERE ([IDProfileTerminal] = @IDProfileTerminal)", connection)
    '			adapter.SelectCommand.Parameters.AddWithValue("@IDProfileTerminal", IDProfileTerminal)
    '	
    '			Dim dt As New DataTable()
    '			adapter.Fill(dt)
    '	
    '			RadComboBox3.DataTextField = "FleetName"
    '			RadComboBox3.DataValueField = "IDProfileFleet"
    '			RadComboBox3.DataSource = dt
    '			RadComboBox3.DataBind()
    '			RadComboBox2.Items.Insert(0, New RadComboBoxItem("- Select Fleet -"))
    '		end if
    '    End Sub
    '
    '    Protected Sub RadComboBox1_ItemsRequested(ByVal o As Object, ByVal e As RadComboBoxItemsRequestedEventArgs) Handles RadComboBox1.ItemsRequested
    '        Loadaccounts()
    '    End Sub
    '
    '    Protected Sub RadComboBox2_ItemsRequested(ByVal o As Object, ByVal e As RadComboBoxItemsRequestedEventArgs) Handles RadComboBox2.ItemsRequested
    '        Loadterminals(e.value)
    '    End Sub
    '
    '    Protected Sub RadComboBox3_ItemsRequested(ByVal o As Object, ByVal e As RadComboBoxItemsRequestedEventArgs) Handles RadComboBox3.ItemsRequested
    '        Loadfleets(e.value)
    '    End Sub



    'Protected Sub ddl_Account_SelectedIndexChanged(ByVal sender as object, ByVal e as EventArgs )
    '		dim IDProfileAccount as integer = Convert.toInt32(ddl_Account.selectedValue.toString())
    '		fillTerminals(IDProfileAccount)
    '		fillFleets(0)
    '	End Sub

    Protected Sub fillTerminals(IDProfileAccount As Integer)
        If IDProfileAccount > 0 Then
            Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)

            Dim adapter As New SqlDataAdapter("SELECT * FROM [CF_Profile_Terminal] WHERE ([IDProfileAccount] = @IDProfileAccount) ORDER BY [TerminalName]", connection)
            adapter.SelectCommand.Parameters.AddWithValue("@IDProfileAccount", Session("IDProfileAccount"))

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

    Protected Sub ddl_Terminal_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileTerminal As Integer = Convert.ToInt32(ddl_Terminal.selectedValue.toString())
        fillFleets(IDProfileTerminal)
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

    Protected Sub ddl_Fleet_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        ' do nothing
    End Sub


    Protected Sub rg_Terminals_OnLoad(ByVal o As Object, ByVal e As EventArgs) Handles rg_Terminals.Load
        Dim IDFleet As Integer
        rg_Terminals.visible = Integer.TryParse(ddl_Fleet.selectedValue, IDFleet) AndAlso IDFleet > 0
    End Sub

    Protected Sub rg_Terminals_ItemCreated(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rg_Terminals.ItemCreated
        If TypeOf e.Item Is GridCommandItem Then
            e.Item.FindControl("InitInsertButton").Parent.Visible = False
        End If

    End Sub

End Class
