Imports System.Data.SqlClient
Imports System.IO

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
    ''' Saves uploaded images to the root directory of website, needs to be updated once a location
    ''' to save the images is chosen
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub TestButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles TestButton.Click
        Dim filename As String = Path.GetFileName(FileUploadControl.FileName)
        FileUploadControl.SaveAs(Server.MapPath("~/") & filename)
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
    Function CheckExistingRegistration(ByVal IDVehicles As String) As Boolean
        'Query CF_DMV to see if a row with this ID exists
        Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        Dim adapter As New SqlDataAdapter(
          "SELECT IDVehicles FROM CF_DMV WHERE IDVehicles=@IDVehicles", connection)
        adapter.SelectCommand.Parameters.AddWithValue("@IDVehicles", IDVehicles)
        Dim dt As New DataTable()
        adapter.Fill(dt)

        'Return True if a row exists, false otherwise
        If dt.Rows.Count = 1 Then 
            Return True 
        Else 
            Return False
        End If
    End Function

    ''' <summary>
    ''' Runs an SQL query that fetches existing vehicle information based on 
    ''' the entered VIN, and then fills the corresponding boxes with that information
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub PopulateFields_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles PopulateFields.Click
        'Grab the VIN before the page is cleared
        Dim VIN = ChassisVIN.Text

        'Clear the page
        'ClearErrorLabels(Me) --Currently not working and not sure why, avoiding for time being
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

    ''' <summary>
    ''' Loops through all controls on the page and adds them to a list that is passed by reference
    ''' </summary>
    ''' <param name="ctrl"></param>
    ''' <param name="lst"></param>
    Protected Sub GetFields(ByVal ctrl As Control, ByRef lst As List(Of Textbox)) 
     For Each ctrl_loop As Control in Page.Controls
            Dim tb = TryCast(ctrl_loop, TextBox)
            If tb IsNot Nothing Then 
                lst.Add(tb)
            End If
            For Each sub_ctrl As Control in ctrl_loop.Controls 
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
        Dim lst As List(Of TextBox) = Page.Master.FindControl("RightColumnContentPlaceHolder").Controls.OfType(Of TextBox).ToList
      
        'Get rid of ChassisVIN
        lst.RemoveAt(0)
        Dim sql_columns As String = "(IDVehicles"
        Dim sql_values As String = "(""" & row.Item("IDVehicles").ToString & """, "
        For each tb As TextBox In lst
            If tb.Text <> "" Then 
                sql_columns += tb.ID 
                sql_values +=  """"  & tb.Text & """" 
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
        Dim sql As String
        Dim strConnString As String = ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        sql = 
        "UPDATE CF_DMV 
         SET
            FromDate = @FromDate,
            ThroughDate = @ThroughDate
         WHERE IDVehicles=@IDVehicles"
        Dim cn As New SqlConnection(strConnString)
        Dim cmd As New SqlCommand(sql, cn)

        cmd.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = row.Item("IDVehicles")
        cmd.Parameters.Add("@FromDate", SqlDbType.Date).Value = FromDate.Text
        cmd.Parameters.Add("@ThroughDate", SqlDbType.Date).Value = ThroughDate.Text

        cmd.Connection.Open()
        cmd.ExecuteNonQuery()
        cmd.Connection.Close()
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
            MsgBox("No matching VIN found, please add the vehicle before adding its registration")
            Return
        End If
        Dim existing_row As DataRow = existing_dt.Rows.Item(0)
      
        'Make sure the row doesn't already exist
       Dim existingReg As Boolean = CheckExistingRegistration(existing_row.Item("IDVehicles").ToString())
        If existingReg Then 
           Dim result As MsgBoxResult = MsgBox("Registration for this vehicle already exists, would you like to update the information?", vbYesNo)
           If result = MsgBoxResult.Yes Then 
                UpdateRow(existing_row)
            Else 
                Return 
           End If
        Else 
            'If the row doesn't exist, create it 
            InsertRegistrationRecord(existing_row)
        End If

        
        
        'Reset the page to default
        ClearErrorLabels(Me)
        ClearTextboxes(Me)
        MsgBox("Registration information stored successfully!")
    End Sub

End Class