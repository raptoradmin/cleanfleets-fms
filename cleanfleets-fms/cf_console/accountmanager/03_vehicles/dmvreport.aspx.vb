Imports System.Data.SqlClient
Imports System.IO
Imports Telerik
Imports Telerik.Web.UI

Public Class dmvreport
    Inherits BaseWebForm

    ''' <summary>
    ''' No page load events 
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    End Sub



    ''' <summary>
    ''' A function taken from stack overflow that works better than the built in 
    ''' FindControl. See PopulateFields_Click for proper use
    ''' </summary>
    ''' <param name="ctrl"></param>
    ''' <param name="id"></param>
    ''' <returns></returns>
    Function FindControlRecursive(ByVal ctrl As Control, ByVal id As String) As Control
        Dim c As Control = Nothing

        If ctrl.ID = id Then
            c = ctrl
        Else
            For Each childCtrl In ctrl.Controls
                Dim resCtrl As Control = FindControlRecursive(childCtrl, id)
                If resCtrl IsNot Nothing Then c = resCtrl
            Next
        End If

        Return c
    End Function

    ''' <summary>
    ''' Clears error labels
    ''' </summary>
    Function ClearErrorLabels(ByVal ctrl As Control) As Control
        Dim c As Control = Nothing

        Dim lb As Label = TryCast(ctrl, Label)
        If lb IsNot Nothing Then
            ' Debug.WriteLine("Found label: " & lb.ID)
            If lb.ID.Contains("Error") Then
                lb.Visible = "False"
            End If
        Else
            For Each childCtrl In ctrl.Controls
                Dim resCtrl As Control = ClearTextboxes(childCtrl)
                If resCtrl IsNot Nothing Then c = resCtrl
            Next
        End If

        Return c
    End Function

    ''' <summary>
    ''' A modification of FindControlRecursive to clear all textboxes, call with Me as parameter
    ''' </summary>
    ''' <param name="ctrl"></param>
    ''' <returns></returns>
    Function ClearTextboxes(ByVal ctrl As Control) As Control
        Dim c As Control = Nothing

        Dim tb As TextBox = TryCast(ctrl, TextBox)
        If tb IsNot Nothing Then
            tb.Text = ""
        Else
            For Each childCtrl In ctrl.Controls
                Dim resCtrl As Control = ClearTextboxes(childCtrl)
                If resCtrl IsNot Nothing Then c = resCtrl
            Next
        End If

        Return c
    End Function

    ''' <summary>
    ''' Uses a VIN to lookup existing information about the vehicle
    ''' </summary>
    ''' <param name="VIN"></param>
    ''' <returns></returns>
    Function QueryExistingInfo(ByRef VIN As String) As DataTable
        'Retrieve existing information from CF_Vehicles and CF_Option_List
        Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        Dim adapter As New SqlDataAdapter(
           "SELECT
	            [IDVehicles],
	            [ChassisVIN],
	            [ChassisModel],
	            [LicensePlateNo],
	            [IDChassisMake],
	            CFO1.[DisplayValue] AS [Make],
	            CFO2.[DisplayValue] AS [Year] 
        FROM [CleanFleets-DEV].[dbo].[CF_Vehicles] 
	        INNER JOIN [CF_Option_List] CFO1 ON [CF_Vehicles].[IDChassisMake] = CFO1.[IDOptionList]
	        INNER JOIN [CF_Option_List] CFO2 ON [CF_Vehicles].[IDChassisModelYear] = CFO2.[IDOptionList]
        WHERE [CF_Vehicles].[ChassisVIN] = @VIN", connection)
        adapter.SelectCommand.Parameters.AddWithValue("@VIN", VIN)
        Dim dt As New DataTable()

        adapter.Fill(dt)
        Return dt
    End Function

    ''' <summary>
    ''' Queries CF_DMV to see if a matching row already exists
    ''' </summary>
    ''' <param name="IDVehicles"></param>
    ''' <returns></returns>
    Function GetExistingRegistration(ByVal VIN As String) As DataTable
        'Query CF_DMV to see if a row with this ID exists
        Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        Dim adapter As New SqlDataAdapter(
          "SELECT * FROM CF_DMV WHERE ChassisVIN=@VIN", connection)
        adapter.SelectCommand.Parameters.AddWithValue("@VIN", VIN)
        Dim dt As New DataTable()
        adapter.Fill(dt)
        Return dt
    End Function

    ''' <summary>
    ''' Queries CF_DMV for an individual record
    ''' </summary>
    ''' <param name="RowID"></param>
    ''' <returns></returns>
    Function GetIndividualRegistration(ByVal RowID As String) As DataTable
         Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        Dim adapter As New SqlDataAdapter(
          "SELECT * FROM CF_DMV WHERE RowID=@RowID", connection)
        adapter.SelectCommand.Parameters.AddWithValue("@RowID", RowID)
        Dim dt As New DataTable()
        adapter.Fill(dt)
        Return dt
    End Function

    ''' <summary>
    ''' Populates fields in the first tab
    ''' </summary>
    ''' <param name="VIN"></param>
    Protected Sub PopulateEditFields_Existing(ByVal VIN As String) 
        'Grab the VIN before the page is cleared

        'Clear the page
        ChassisVIN_Error.Visible = False
        ClearTextboxes(Me)

        'Get existing information based on VIN
        Dim dt = QueryExistingInfo(VIN)

       

        'If data is found, only one row is returned. Loop through the columns and fill textboxes
        'that have matching IDs with the column names
        If dt.Rows.Count = 1 Then
            Dim row As DataRow = dt.Rows.Item(0)
            Dim count As Integer = 0
            For Each column In row.ItemArray
                Dim textbox = TryCast(FindControlRecursive(Me, dt.Columns.Item(count).ToString), TextBox)
                ' Debug.WriteLine(dt.Columns.Item(count).ToString)
                If textbox IsNot Nothing Then
                    '    Debug.WriteLine("Found a control")
                    textbox.Text = column.ToString
                End If
                count += 1
            Next
        Else
            ChassisVIN_Error.Visible = "True"
        End If

    End Sub

    Protected Sub PopulateEditFields_Registration(ByVal RowID As String)
        'Query CF_DMV to see if a row with this ID exists
        Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        Dim adapter As New SqlDataAdapter(
          "SELECT * FROM CF_DMV WHERE RowID=@RowID", connection)
        adapter.SelectCommand.Parameters.AddWithValue("@RowID", RowID)
        Dim dt As New DataTable()
        adapter.Fill(dt)

        Dim row As DataRow = dt.Rows.Item(0)
        Dim count As Integer = 0
        
        For Each column In row.ItemArray
                Dim textbox = TryCast(FindControlRecursive(Me, dt.Columns.Item(count).ToString), TextBox)
                If textbox IsNot Nothing Then
                    If textbox.ID.Contains("Date") Then
                        Debug.WriteLine("date field found")
                        Dim dateField As DateTime = column
                        textbox.Text = dateField.ToString("MM/dd/yyyy")
                    Else
                        Debug.WriteLine("non Date field found")
                        textbox.Text = column.ToString
                    End If
                End If
                count += 1
            Next


    End Sub

    ''' <summary>
    ''' Runs an SQL query that fetches existing vehicle information based on 
    ''' the entered VIN, and then fills the corresponding boxes with that information
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub PopulateFields_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles PopulateFields.Click
        'Grab the VIN before the page is cleared
        Dim VIN = ChassisVIN.Text
        ClearTextboxes(Me)
        ClearErrorLabels(Me)
        PopulateDropDownList(VIN)
        PopulateEditFields_Existing(VIN)
    End Sub

    ''' <summary>
    ''' Loops through all controls on the page and adds them to a list that is passed by reference
    ''' </summary>
    ''' <param name="ctrl"></param>
    ''' <param name="lst"></param>
    Protected Sub GetFields(ByVal ctrl As Control, ByRef lst As List(Of TextBox))
        For Each ctrl_loop As Control In Page.Controls
            Dim tb = TryCast(ctrl_loop, TextBox)
            If tb IsNot Nothing Then
                lst.Add(tb)
            End If
            For Each sub_ctrl As Control In ctrl_loop.Controls
                GetFields(sub_ctrl, lst)
            Next
        Next
    End Sub

    ''' <summary>
    ''' Inserts a new record into the CF_DMV table
    ''' </summary>
    ''' <param name="row"></param>
    Protected Sub InsertRegistrationRecord(ByVal row As DataRow)
        'Get all the form fields
        Dim lst As List(Of TextBox) =
           Page.Master.FindControl("RightColumnContentPlaceHolder").FindControl("RadMultiPageTab").FindControl("DMV_Add").Controls.OfType(Of TextBox).ToList


        'Get rid of ChassisVIN
        Dim sql_columns As String = "(IDVehicles, "
        Dim sql_values As String = "('" & row.Item("IDVehicles").ToString & "', "
        For Each tb As TextBox In lst
            If tb.Text <> "" Then
                sql_columns += tb.ID
                sql_values += "'" & tb.Text & "'"
                If tb Is lst.Last Then
                    sql_columns += ")"
                    sql_values += ")"
                Else
                    sql_columns += ", "
                    sql_values += ", "
                End If
            End If
        Next

        Dim query As String = "INSERT INTO CF_DMV " & sql_columns & " VALUES " & sql_values
        Debug.WriteLine(query)
        Dim strConnString As String = ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        Dim cn As New SqlConnection(strConnString)
        Dim cmd As New SqlCommand(query, cn)



        cmd.Connection.Open()
        cmd.ExecuteNonQuery()
        cmd.Connection.Close()
    End Sub

    ''' <summary>
    ''' Updates existing record in CF_DMV
    ''' </summary>
    ''' <param name="row"></param>
    Protected Sub UpdateRow(ByVal row As DataRow)
        'Get all the form fields
        Dim lst As List(Of TextBox) =
            Page.Master.FindControl("RightColumnContentPlaceHolder").FindControl("RadMultiPageTab").FindControl("DMV_Add").Controls.OfType(Of TextBox).ToList

        Dim sql As String = ""
        For Each tb As TextBox In lst
            If tb.Text <> "" Then
                sql += tb.ID & "='" & tb.Text & "'"
                If tb IsNot lst.Last Then
                    sql += ", "
                End If
            End If
        Next

        Dim query As String = "UPDATE CF_DMV SET " & sql & " WHERE RowID=" & YrDropDown.SelectedValue.ToString & ""
        Debug.WriteLine(query)
        Dim strConnString As String = ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        Dim cn As New SqlConnection(strConnString)
        Dim cmd As New SqlCommand(query, cn)
        cmd.Connection.Open()
        cmd.ExecuteNonQuery()
        cmd.Connection.Close()
    End Sub

    ''' <summary>
    ''' Empties the YrDropDownList
    ''' </summary>
    Protected Sub EmptyDropDownList() 
        Dim empty As List(Of ListItem) = New List(Of ListItem)
        YrDropDown.DataSource = empty 
        YrDropDown.DataBind()
    End Sub
    ''' <summary>
    ''' Gathers existing info based on VIN, and then inserts a new row into the CF_DMV table
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub SubmitRegistration_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SubmitRegistration.Click
        ' Make sure all required validation is met
        If Not Page.IsValid Then
            Debug.WriteLine("Failed validation")
            Return
        End If
        'Get existing information 
        Dim VIN As String = ChassisVIN.Text
        Dim existing_dt As DataTable = QueryExistingInfo(VIN)

        'Cancel process if we don't have a matching VIN
        If existing_dt.Rows.Count <> 1 Then
            Return
        End If
        Dim existing_row As DataRow = existing_dt.Rows.Item(0)

        'Make sure the row doesn't already exist
        Dim update As Boolean = GetIndividualRegistration(YrDropDown.SelectedValue.ToString).Rows.Count <> 0
            If update Then
            UpdateRow(existing_row)
        Else
            'If the row doesn't exist, create it 
            InsertRegistrationRecord(existing_row)
        End If

        Dim grid As RadGrid = FindControlRecursive(Me, "RecordsTable")
        grid.Rebind()

        
        'Reset the page to default
        EmptyDropDownList()
        ClearErrorLabels(Me)
        ClearTextboxes(Me)
    End Sub

    ''' <summary>
    ''' Fill and focus the third tab when a record is selected
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub RecordsTable_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles RecordsTable.SelectedIndexChanged

        'Focus the tab
        Dim tabStrip As RadTabStrip = FindControlRecursive(Me, "RadTabStrip1")
        tabStrip.SelectedIndex = 2
        Dim radpage As RadMultiPage = FindControlRecursive(Me, "RadMultiPagetab")
        radpage.SelectedIndex = 2

        'Get all the labels to be filled
        Dim lst As List(Of Label) = Page.Master.FindControl("RightColumnContentPlaceHolder").FindControl("RadMultiPageTab").FindControl("DMV_Record").Controls.OfType(Of Label).ToList


        'Get the data for filling 
        Dim grid As RadGrid = FindControlRecursive(Me, "RecordsTable")
        Dim selected_row As GridDataItem = grid.SelectedItems.Item(0)
        Dim RowID As String = selected_row.Item("RowID").Text
        Dim dt As DataTable = GetIndividualRegistration(RowID)
        Dim row = dt.Rows.Item(0)

        ' Fill fields
        Dim count As Integer = 0
        For Each column In row.ItemArray
            Dim label_ID As String = dt.Columns.Item(count).ToString & "_View"
            Dim lab = TryCast(FindControlRecursive(Me, label_ID), Label)
            ' Debug.WriteLine(dt.Columns.Item(count).ToString)
            If lab IsNot Nothing Then
                If label_ID.Contains("Date") Then 
                    Dim datestring As DateTime = DateTime.Parse(column.ToString)
                    lab.Text = datestring.ToString("MM/dd/yyyy")
                Else 
                    lab.Text = column.ToString
                End If
            Else 
                Debug.WriteLine("Could not find " & label_ID)
            End If
            count += 1
        Next




    End Sub

    ''' <summary>
    ''' Switches to the first tab and fills it with information based on the individual record being viewed
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub UpdateRecord_Click(ByVal sender As Object, ByVal e As EventArgs) Handles UpdateRecord.Click 
        'Gather information 
        Dim grid As RadGrid = FindControlRecursive(Me, "RecordsTable")
        Dim selected_row As GridDataItem = grid.SelectedItems.Item(0)
        Dim RowID As String = selected_row.Item("RowID").Text
        Dim VIN As String = selected_row.Item("ChassisVIN").Text 
       
        'Fill Fields 
        PopulateEditFields_Existing(VIN)
        PopulateEditFields_Registration(RowID)

        'Populate and select drop down list 
        PopulateDropDownList(VIN)
        YrDropDown.SelectedValue = RowID

        'Focus the tab
        Dim tabStrip As RadTabStrip = FindControlRecursive(Me, "RadTabStrip1")
        tabStrip.SelectedIndex = 0
        Dim radpage As RadMultiPage = FindControlRecursive(Me, "RadMultiPagetab")
        radpage.SelectedIndex = 0
    End Sub

    ''' <summary>
    ''' Populates the items of the drop down list in the format "yyyy - yyyy" for each registration entry in the db
    ''' </summary>
    ''' <param name="VIN"></param>
    Protected Sub PopulateDropDownList(ByVal VIN As String)

        'Get any existing registration information
        Dim existing_reg = GetExistingRegistration(VIN)

        'Return if no existing reg 
        If existing_reg Is Nothing Or existing_reg.Rows.Count = 0 Then 
            EmptyDropDownList() 
            Return
        End If

        Dim arr_lst As List(Of ListItem) = New List(Of ListItem)
        arr_lst.Add(New ListItem(" - Select Registration - ", "0"))
        YrDropDown.DataSource = arr_lst
        'Do the same for existing registration information 
        For Each row As DataRow In existing_reg.Rows
            Dim from_date As String = row.Item("FromDate").year 
            Dim through_date As String = row.Item("ThroughDate").year 
            Dim entry As ListItem = New ListItem(from_date & " - " & through_date, row.Item("RowID")) 
            Debug.WriteLine("Entry value is " & entry.Value)
            arr_lst.Add(entry)
        Next

        YrDropDown.DataTextField = "Text"
        YrDropDown.DataValueField = "Value"
        YrDropDown.DataBind()
        
        'Fill fields with info from first row
        
    End Sub

    Protected Sub YrDropDownList_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles YrDropDown.SelectedIndexChanged

        Dim selected As ListItem = YrDropDown.SelectedItem
        Debug.WriteLine(YrDropDown.SelectedValue)
        Debug.WriteLine(selected.Text & ": " & selected.Value)

        'Don't do anything for the "select registration" item
        If YrDropDown.SelectedIndex = 0 Then 
            Return
        End If
        
        PopulateEditFields_Registration(selected.Value)
        

    End Sub


End Class