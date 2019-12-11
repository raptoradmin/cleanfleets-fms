Imports System.Data.SqlClient

Public Class addCARBrecord
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub AddCARBButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles AddCARBButton.Click

        Dim connection_string As String

        'Changing to CleanFleets for database in preparation for transition from DEV to Production; Andrew - 12/10/2019.

        connection_string = "Server=tcp:SQL16\CFNET;Database=CleanFleets;User ID=sa;Password=Cl3anFl33ts1"

        Dim CARB_conn As New SqlConnection(connection_string)

        If CARB_conn.State = ConnectionState.Closed Then

            CARB_conn.Open()

        End If

        DateValidationPrompt.Visible = False
        HappenedValidationPrompt.Visible = False
        SuccessfulPrompt.Visible = False

        Dim query_execution_flag As Boolean
        query_execution_flag = True

        'Dim Temp_TextBoxCARBDate As TextBox = CType(FindControl("TextBox_CARB_Date"), TextBox)
        Dim temp_var_date As String

        temp_var_date = TextBox_CARB_Date.Text

        Dim temp_date_split() As String
        temp_date_split = Split(temp_var_date, "/")

        Dim Valid_Date As Boolean
        Valid_Date = True

        For i = 1 To UBound(temp_date_split) + 1

            If (IsNumeric(temp_date_split(i - 1)) = False) Then

                DateValidationPrompt.Visible = True
                DateValidationPrompt.InnerHtml = "The date provided is not in the correct format (MM/DD/YYYY)."

                query_execution_flag = False

            End If

        Next

        If (UBound(temp_date_split) = 2) Then

            For i = 1 To UBound(temp_date_split) + 1

                If (i - 1 < 2) Then

                    If (Len(temp_date_split(i - 1)) > 0) And Len(temp_date_split(i - 1)) <= 2 Then

                        If (Len(temp_date_split(i - 1)) < 2) Then

                            temp_date_split(i - 1) = "0" & temp_date_split(i - 1)

                        End If

                    Else

                        Valid_Date = False

                        DateValidationPrompt.Visible = True
                        DateValidationPrompt.InnerHtml = "The date provided is not in the correct format (MM/DD/YYYY)."

                        Exit For

                    End If

                Else

                    If Not (Len(temp_date_split(i - 1)) = 4) Then

                        Valid_Date = False

                        DateValidationPrompt.Visible = True
                        DateValidationPrompt.InnerHtml = "The date provided is not in the correct format (MM/DD/YYYY)."

                        Exit For

                    End If

                End If

            Next

        Else

            Valid_Date = False

            DateValidationPrompt.Visible = True
            DateValidationPrompt.InnerHtml = "The date provided is not in the correct format (MM/DD/YYYY)."

        End If

        If (Valid_Date = True) Then

            temp_var_date = temp_date_split(0) & "/" & temp_date_split(1) & "/" & temp_date_split(2)

            'DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.DateTime)
            'DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

        Else

            query_execution_flag = False

        End If

        Dim temp_var_Happened As String
        temp_var_Happened = TextBox_CARB_Happened.Text

        If Not (temp_var_Happened = "Yes" Or temp_var_Happened = "No") Then

            HappenedValidationPrompt.Visible = True
            HappenedValidationPrompt.InnerHtml = "Please enter a valid response ('Yes' or 'No')."

            'Dim URLString As String
            'Dim VINfromURLString As String

            'URLString = Request.Url.ToString()
            'VINfromURLString = Mid(URLString, InStr(URLString, "=") + 1, Len(URLString))

            'HappenedValidationPrompt.InnerHtml = VINfromURLString

            query_execution_flag = False

        End If

        Dim temp_var_Issue As String
        Dim temp_var_Resolution As String

        temp_var_Issue = TextBox_CARB_Issue.Text
        temp_var_Resolution = TextBox_CARB_Resolution.Text

        If (query_execution_flag = True) Then

            Dim CARB_Comm As SqlCommand
            CARB_Comm = New SqlCommand("DECLARE @CARBID UNIQUEIDENTIFIER DECLARE @FINALCARBDATE DATETIME" & " SET @CARBID = NEWID() SET @FINALCARBDATE = CONVERT(DATETIME, @temp_var_date, 101) " & "INSERT INTO CF_CARB_Communication (CARBCommID, CARBDate, CARBHappened, CARBIssue, CARBResolution, ChassisVIN) " & "VALUES(@CARBID, @FINALCARBDATE, @temp_var_Happened, @temp_var_Issue, @temp_var_Resolution, @ChassisVIN)", CARB_conn)

            CARB_Comm.Parameters.Add("@temp_var_date", SqlDbType.DateTime)
            CARB_Comm.Parameters("@temp_var_date").Value = temp_var_date

            CARB_Comm.Parameters.Add("@temp_var_Happened", SqlDbType.VarChar, 3)
            CARB_Comm.Parameters("@temp_var_Happened").Value = temp_var_Happened

            CARB_Comm.Parameters.Add("@temp_var_Issue", SqlDbType.VarChar, -1)
            CARB_Comm.Parameters("@temp_var_Issue").Value = temp_var_Issue

            CARB_Comm.Parameters.Add("@temp_var_Resolution", SqlDbType.VarChar, -1)
            CARB_Comm.Parameters("@temp_var_Resolution").Value = temp_var_Resolution

            Dim URLString As String
            Dim VINfromURLString As String

            URLString = Request.Url.ToString()
            VINfromURLString = Mid(URLString, InStr(URLString, "=") + 1, InStr(URLString, "&") - (InStr(URLString, "=") + 1))

            CARB_Comm.Parameters.Add("@ChassisVIN", SqlDbType.VarChar, 50)
            CARB_Comm.Parameters("@ChassisVIN").Value = VINfromURLString

            CARB_Comm.ExecuteNonQuery()

            SuccessfulPrompt.Visible = True
            SuccessfulPrompt.InnerHtml = "New record successfully added."

            AddCARBButton.Visible = False

        End If

        CARB_conn.Close()

    End Sub

    Protected Sub DoneButton_Click(ByVal sender As Object, ByVal e As EventArgs) Handles DoneButton.Click

        Dim URLString As String
        Dim start_position As String
        Dim fromURLString As String

        URLString = Request.Url.ToString()
        start_position = InStr(URLString, "IDVehicles=")
        fromURLString = Mid(URLString, InStr(start_position, URLString, "=", vbTextCompare) + 1, Len(URLString) - InStr(start_position, URLString, "=", vbTextCompare) + 1)

        Response.Redirect("vehiclesdetails.aspx?IDVehicles=" & fromURLString)

    End Sub

End Class