Imports MailKit.Net.Imap
Imports MailKit.Search
Imports MailKit
Imports MimeKit
Imports OfficeOpenXml
Imports OfficeOpenXml.Style
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.IO
Imports System.Net.Security
Imports System.Security.Cryptography.X509Certificates
Imports Telerik.Web.UI
Public Class notificationPSIP
    Inherits BaseWebForm

    Protected IDProfileContact As Integer = 0
    Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)

    Protected Sub cf_console_admin_notificationPSIP_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand("EXEC [RetrieveConfigValue] @ParameterCode", conn)
                comm.Parameters.AddWithValue("@ParameterCode", "DraftEmply")
                conn.Open()
                Try
                    Using objReader As SqlDataReader = comm.ExecuteReader()
                        If objReader.Read() Then
                            IDProfileContact = CInt(objReader("ParameterValue"))
                        End If
                        objReader.Close()
                    End Using
                    conn.Close()
                Catch ex As Exception
                    If conn.State <> ConnectionState.Closed Then
                        conn.Close()
                    End If
                End Try
            End Using
        End Using
    End Sub

    Protected Sub ddl_Employee_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        If IDProfileContact > 0 Then
            ddl_Employee.SelectedValue = IDProfileContact
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim UpdatedIDProfileAccount As Integer = CInt(ddl_Employee.SelectedValue)
        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand("EXEC [UpsertConfigValue] @ParameterCode, @ParameterValue, @ParameterDesc", conn)
                With comm.Parameters
                    .AddWithValue("@ParameterCode", "DraftEmply")
                    .AddWithValue("@ParameterValue", CStr(UpdatedIDProfileAccount))
                    .AddWithValue("@ParameterDesc", "IDProfileContact for Employee to receive PSIP notifications")
                End With
                conn.Open()
                Try
                    comm.ExecuteNonQuery()
                    conn.Close()
                    IDProfileContact = UpdatedIDProfileAccount
                    Messages.Text = ""
                Catch ex As Exception
                    Messages.Text = "Error while updating"
                    ddl_Employee.SelectedIndex = IDProfileContact
                    If conn.State <> ConnectionState.Closed Then
                        conn.Close()
                    End If
                End Try
            End Using
        End Using
    End Sub

    Protected Sub btnReturn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReturn.Click
        pnlSettings.Visible = True
        pnlReport.Visible = False
    End Sub

    Protected Sub btnPreview_Click() Handles btnPreview.Click
        Dim IDProfileAccount As Integer = CInt(ddl_Account.SelectedValue)
        If IDProfileAccount = 0 Then
            Messages.Text = "Error: An Account must be selected before running the report"
            Return
        End If

        Dim AccountName As String = PSIPAutomatedNotification.GetAccountName(IDProfileAccount)
        Dim myDataTable As DataTable = PSIPAutomatedNotification.GetInUseVehicleData(IDProfileAccount)
        Dim RecipientsList As List(Of String()) = PSIPAutomatedNotification.GetRecipientsList(IDProfileAccount)
        Dim ToList As List(Of String) = New List(Of String)
        For Each Recipient() As String In RecipientsList
            ToList.Add(String.Format("{0} ({1})", Recipient(0), Recipient(1)))
        Next

        gv_Vehicles.DataSource = myDataTable
        gv_Vehicles.DataBind()

        Recipients.Text = String.Join(", ", ToList)
        EmailBody.Text = String.Format("{0} contains {1} vehicles in use", AccountName, myDataTable.Rows.Count)

        pnlSettings.Visible = False
        pnlReport.Visible = True
        Messages.Text = ""
    End Sub

    Protected Sub btnTest_Click() Handles btnTest.Click
        Dim IDProfileAccount As Integer = CInt(ddl_Account.SelectedValue)
        Try
            If IDProfileAccount = 0 Then
                Throw New ArgumentException("An Account must be selected before running the report")
            End If
            PSIPAutomatedNotification.CreateDraftsMessage(IDProfileAccount)
            Messages.Text = ""
        Catch ex As Exception
            Messages.Text = "Error: " & ex.ToString
        End Try
        'Dim result As Boolean = False
        'If IDProfileAccount = 0 Then
        '	Messages.Text = "An Account must be selected before running the report"
        '	Return
        'End If

        'Dim AccountName As String = GetAccountName(IDProfileAccount)
        'Dim myDataTable As DataTable = GetInUseVehicleData(IDProfileAccount)
        'Dim RecipientsList As List(Of String()) = GetRecipientsList(IDProfileAccount)

        'Dim workbook As Byte() = GenerateWorkbook(AccountName, myDataTable)

        'Dim Message As New MimeMessage()
        'If RecipientsList.Count > 0 Then
        '	For Each Recipient() As String In RecipientsList
        '		Message.To.Add(New MailboxAddress(Recipient(0), Recipient(1)))
        '	Next
        'End If

        'Message.Subject = "Vehicles Requiring PSIP Testing"
        'Dim builder As New BodyBuilder()
        'builder.TextBody = String.Format("{0} contains {1} vehicles in use", AccountName, myDataTable.Rows.Count)

        'builder.Attachments.Add("Vehicles Requiring PSIP Testing.xlsx", workbook)

        'Message.Body = builder.ToMessageBody()

        'Try
        '	result = IMAPAppendDraftMessage(IDProfileContact, Message)
        'Catch exc As Exception
        '	Messages.Text = "Error: " & exc.Message
        'End Try

        'If result Then
        '	Messages.Text = "Email draft successfuly placed"
        'End If

    End Sub

End Class
