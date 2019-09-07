Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports Telerik.Web.UI
Public Class bluereport_fleet1
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'fill the continents combo
            'LoadContinents()
        End If
    End Sub

    '    Protected Sub LoadContinents()
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
    '        'insert the first item
    '        RadComboBox1.Items.Insert(0, New RadComboBoxItem("- Select an Account -"))
    '    End Sub
    '
    '    Protected Sub LoadCountries(ByVal IDProfileAccount As String)
    '        Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
    '
    '        'select a country based on the continentID
    '        Dim adapter As New SqlDataAdapter("SELECT * FROM [CF_Profile_Terminal] WHERE ([IDProfileAccount] = @IDProfileAccount) ORDER BY [TerminalName]", connection)
    '        adapter.SelectCommand.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
    '
    '        Dim dt As New DataTable()
    '        adapter.Fill(dt)
    '
    '        RadComboBox2.DataTextField = "TerminalName"
    '        RadComboBox2.DataValueField = "IDProfileTerminal"
    '        RadComboBox2.DataSource = dt
    '        RadComboBox2.DataBind()
    '    End Sub
    '
    '    Protected Sub LoadCities(ByVal IDProfileTerminal As String)
    '        Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
    '
    '        'select a city based on the countryID
    '        Dim adapter As New SqlDataAdapter("SELECT * FROM [CF_Profile_Fleet] WHERE ([IDProfileTerminal] = @IDProfileTerminal)", connection)
    '        adapter.SelectCommand.Parameters.AddWithValue("@IDProfileTerminal", IDProfileTerminal)
    '
    '        Dim dt As New DataTable()
    '        adapter.Fill(dt)
    '
    '        RadComboBox3.DataTextField = "FleetName"
    '        RadComboBox3.DataValueField = "IDProfileFleet"
    '        RadComboBox3.DataSource = dt
    '        RadComboBox3.DataBind()
    '    End Sub
    '
    '    Protected Sub RadComboBox1_ItemsRequested(ByVal o As Object, ByVal e As RadComboBoxItemsRequestedEventArgs) Handles RadComboBox1.ItemsRequested
    '        LoadContinents()
    '    End Sub
    '
    '    Protected Sub RadComboBox2_ItemsRequested(ByVal o As Object, ByVal e As RadComboBoxItemsRequestedEventArgs) Handles RadComboBox2.ItemsRequested
    '        ' e.Text is the first parameter of the requestItems method 
    '        ' invoked in LoadCountries method 
    '        LoadCountries(e.Text)
    '    End Sub
    '
    '    Protected Sub RadComboBox3_ItemsRequested(ByVal o As Object, ByVal e As RadComboBoxItemsRequestedEventArgs) Handles RadComboBox3.ItemsRequested
    '        ' e.Text is the first parameter of the requestItems method
    '        ' invoked in LoadCities method 
    '        LoadCities(e.Text)
    '    End Sub


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
            Dim windowManager As New RadWindowManager()
            Dim RadWindow As New RadWindow()
            RadWindow.NavigateUrl = "~/includes/reports_console/bluereport_fleet_display.aspx?Query=Fleet&IDProfileFleet=" & ddl_Fleet.SelectedValue
            RadWindow.ID = "RadWindow1"
            RadWindow.VisibleOnPageLoad = True
            RadWindow.Height = 400
            RadWindow.Width = 850
            RadWindow.Modal = True
            windowManager.Windows.Add(RadWindow)
            Me.Form.Controls.Add(RadWindow)
        End If
    End Sub


    Protected Sub ddl_Fleet_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) 'Handles RadComboBox3.SelectedIndexChanged

        'Session("IDProfileFLeet") = RadComboBox3.SelectedValue

    End Sub


    Sub cf_ddl_Validate(sender As Object, args As ServerValidateEventArgs)
        Dim value As Integer
        args.IsValid = True
        'if args.isValid then args.IsValid = ( Integer.tryParse(ddl_Account.selectedValue, value) andAlso value > 0) 
        'if args.isValid then args.IsValid = ( Integer.tryParse(ddl_Terminal.selectedValue, value) andAlso value > 0) 
        If args.IsValid Then args.IsValid = (Integer.TryParse(args.Value, value) AndAlso value > 0)
    End Sub



End Class


