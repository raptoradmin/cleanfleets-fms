Imports MailKit.Net.Imap
Imports MailKit
Imports MimeKit
Imports OfficeOpenXml
Imports OfficeOpenXml.Style
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Net.Security
Imports System.Security.Cryptography.X509Certificates
Imports System.Net.ServicePointManager

Public Class PSIPAutomatedNotification
    Implements IHangfireJob
    Private Shared connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)

    Public Sub DoJob() Implements IHangfireJob.DoJob
        Dim dtAccounts As New DataTable()
        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand("EXEC [RetrieveAccountPSIPNotificationForMonth]", conn)
                Using oDataAdapter = New SqlDataAdapter(comm)
                    oDataAdapter.Fill(dtAccounts)
                End Using
            End Using
        End Using
        For Each drAccount As DataRow In dtAccounts.Rows
            CreateDraftsMessage(drAccount("IDProfileAccount"))
        Next
    End Sub

    Public Shared Sub CreateDraftsMessage(ByVal IDProfileAccount As Integer)
        Dim result As Boolean = False
        If IDProfileAccount = 0 Then
            'Messages.Text = "An Account must be selected before running the report"
            Return
        End If

        Dim AccountName As String = GetAccountName(IDProfileAccount)
        Dim myDataTable As DataTable = GetInUseVehicleData(IDProfileAccount)
        Dim RecipientsList As List(Of String()) = GetRecipientsList(IDProfileAccount)

        Dim workbook As Byte() = GenerateWorkbook(AccountName, myDataTable)

        Dim Message As New MimeMessage()
        If RecipientsList.Count > 0 Then
            For Each Recipient() As String In RecipientsList
                Message.To.Add(New MailboxAddress(Recipient(0), Recipient(1)))
            Next
        End If

        Message.Subject = "Upcoming Annual Vehicle PSIP Testing"
        Dim builder As New BodyBuilder()
        builder.TextBody = String.Format("The attached list of vehicles are coming up for annual smoke testing. CleanFleets would like to schedule PSIP smoke testing for your fleet at your earliest convenience. Thank you for having us assist you with your CARB compliance. Feel free to contact me to schedule the next site visit", AccountName, myDataTable.Rows.Count)

        builder.Attachments.Add("Vehicles Requiring PSIP Testing.xlsx", workbook)

        Message.Body = builder.ToMessageBody()

        Try
            result = IMAPAppendDraftMessage(Message)
        Catch exc As Exception
            Throw
        End Try

    End Sub

    Public Shared Function GetAccountName(ByVal IDProfileAccount As Integer) As String
        Dim AccountName As String = ""
        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand("SELECT AccountName FROM CF_Profile_Account WHERE IDProfileAccount = @IDProfileAccount", conn)
                comm.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
                conn.Open()
                Try
                    Using oDataReader As SqlDataReader = comm.ExecuteReader()
                        If oDataReader.Read() Then
                            AccountName = CStr(oDataReader("AccountName"))
                        End If
                    End Using
                Catch ex As Exception
                    Return "Error while retrieving account emails"
                Finally
                    If conn.State <> ConnectionState.Closed Then
                        conn.Close()
                    End If
                End Try
            End Using
        End Using
        Return AccountName
    End Function

    Public Shared Function GetInUseVehicleData(ByVal IDProfileAccount As Integer) As DataTable
        Dim myDataTable As New DataTable()
        Using conn As New SqlConnection(connectionString)
            Using adapter As New SqlDataAdapter("EXEC [ReportRequiresOpacityTesting] @IDProfileAccount", conn)
                adapter.SelectCommand.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
                adapter.Fill(myDataTable)
            End Using
        End Using
        Return myDataTable
    End Function

    Public Shared Function GetRecipientsList(ByVal IDProfileAccount As Integer) As List(Of String())
        Dim lAccountEmails As New List(Of String())
        Dim oDataTable As New DataTable()
        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand("EXEC [RetrieveAccountEmails] @IDProfileAccount", conn)
                comm.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
                conn.Open()
                Try
                    Using oDataAdapter As New SqlDataAdapter(comm)
                        oDataAdapter.Fill(oDataTable)
                    End Using
                Catch ex As Exception
                    Throw New Exception("Error while retrieving account emails")
                Finally
                    If conn.State <> ConnectionState.Closed Then
                        conn.Close()
                    End If
                End Try
            End Using
        End Using

        If oDataTable.Rows.Count = 0 Then
            Throw New Exception("No recipients found")
        End If

        Dim AccountName As String = CStr(oDataTable.Rows(0)("AccountName"))
        For Each oDataRow As DataRow In oDataTable.Rows
            Dim recipient() As String = New String() {oDataRow("FullName"), oDataRow("Email")}
            lAccountEmails.Add(recipient)
        Next
        Return lAccountEmails
    End Function

    Protected Shared Function GenerateWorkbook(ByVal AccountName As String, ByVal myDataTable As DataTable) As Byte()
        Using package As New OfficeOpenXml.ExcelPackage()
            Dim currentRow As Integer = 1
            Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("PSIP Testing")

            worksheet.Cells(1, 1).Value = "Vehicles Requiring PSIP Testing"
            worksheet.Cells(2, 1).Value = "Account: " & AccountName
            worksheet.Cells(3, 1).Value = "Report Date:" & DateTime.Now.ToString("MM/dd/yyyy")

            Using range As ExcelRange = worksheet.Cells(currentRow, 1, currentRow, 1)
                range.Style.Font.Bold = True
                range.Style.Font.Size = 14
                'range.Style.Border.Top.Style = ExcelBorderStyle.Thin
                'range.Style.Border.Bottom.Style = ExcelBorderStyle.Thin
                'range.Style.Border.Left.Style = ExcelBorderStyle.Thin
                'range.Style.Border.Right.Style = ExcelBorderStyle.Thin
                range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
            End Using

            currentRow = 5
            'fill cells with data from table
            worksheet.Cells(currentRow, 1).LoadFromDataTable(myDataTable, True)
            Using range As ExcelRange = worksheet.Cells(currentRow, 1, currentRow, myDataTable.Columns.Count)
                range.Style.Font.Bold = True
                'range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End Using
            Using range As ExcelRange = worksheet.Cells(currentRow, 1, myDataTable.Rows.Count + currentRow, myDataTable.Columns.Count)
                range.Style.Border.Top.Style = ExcelBorderStyle.Thin
                range.Style.Border.Bottom.Style = ExcelBorderStyle.Thin
                range.Style.Border.Left.Style = ExcelBorderStyle.Thin
                range.Style.Border.Right.Style = ExcelBorderStyle.Thin
            End Using

            worksheet.Cells.AutoFitColumns(0)

            Dim stream As MemoryStream = New MemoryStream(package.GetAsByteArray())
            Return stream.ToArray()
        End Using
    End Function

    Protected Shared Function IMAPAppendDraftMessage(ByVal Message As MimeMessage) As Boolean
        Dim IMAPUsername As String = ""
        Dim IMAPPassword As String = ""
        Dim IMAPDraftsFolder As String = ""
        Dim IMAPServer As String = DirectCast(ConfigurationManager.AppSettings("IMAPServer"), String)
        Dim IMAPServerPort As Integer = Integer.Parse(ConfigurationManager.AppSettings("IMAPServerPort"))
        Dim IMAPUseSSL As Boolean = Boolean.Parse(ConfigurationManager.AppSettings("IMAPUseSSL"))
        Dim result As Boolean = False

        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand("EXEC [RetrieveImapConfiguration]", conn)
                conn.Open()
                Try
                    Using oDataReader As SqlDataReader = comm.ExecuteReader()
                        If oDataReader.Read() Then
                            IMAPUsername = CStr(oDataReader("IMAPUsername"))
                            IMAPPassword = CStr(oDataReader("IMAPPassword"))
                            IMAPDraftsFolder = CStr(oDataReader("IMAPDraftsFolder"))
                        End If
                    End Using
                Catch ex As Exception
                Finally
                    If conn.State <> ConnectionState.Closed Then
                        conn.Close()
                    End If
                End Try
            End Using
        End Using

        If IMAPServer = "" Then Throw New ArgumentException("IMAP Server isn't specified for this Company")
        If IMAPUsername = "" Then Throw New ArgumentException("IMAP User Name isn't specified for this User")
        If IMAPPassword = "" Then Throw New ArgumentException("IMAP Password isn't specified for this User")
        If IMAPDraftsFolder = "" Then Throw New ArgumentException("IMAP Drafts Mailbox Path isn't specified for this User")

        Dim BypassEmailCertCheck As String = DirectCast(ConfigurationManager.AppSettings("BypassEmailCertCheck"), String)
        If Not IsNothing(BypassEmailCertCheck) AndAlso BypassEmailCertCheck.ToLower() = "true" Then
            ServerCertificateValidationCallback = New RemoteCertificateValidationCallback(AddressOf ValidateServerCertificate)
        End If

        Using client As New ImapClient()
            Try
                client.Connect(IMAPServer, IMAPServerPort, IMAPUseSSL)
                client.AuthenticationMechanisms.Remove("XOAUTH2")

                client.Authenticate(IMAPUsername, IMAPPassword)

                Dim draftsFolder As IMailFolder = Nothing
                Dim folders As New StringBuilder()


                'Dim personal As IMailFolder = client.GetFolder(client.PersonalNamespaces(0))
                For Each personalNC As FolderNamespace In client.PersonalNamespaces
                    Dim personal As IMailFolder = client.GetFolder(personalNC)


                    draftsFolder = FindFolder(IMAPDraftsFolder, personal.GetSubfolders(False))

                    If IsNothing(draftsFolder) Then
                        If ((client.Capabilities And (ImapCapabilities.SpecialUse Or ImapCapabilities.XList)) <> 0) Then
                            draftsFolder = client.GetFolder(SpecialFolder.Drafts)
                        End If
                    End If
                    If draftsFolder IsNot Nothing Then
                        Exit For
                    End If
                Next

                If IsNothing(draftsFolder) Then
                    Throw New ArgumentException(String.Format("IMAP Drafts Mailbox Path of ""{0}"" couldn't be found. Folders are: {1}", IMAPDraftsFolder, folders.ToString()))
                End If

                Message.Date = DateTime.UtcNow()

                draftsFolder.Open(FolderAccess.ReadWrite)

                draftsFolder.Append(Message, MessageFlags.Draft)
                'Catch exc As Exception
                '	Throw new Exception("", exc)
            Finally
                If client.IsConnected() Then
                    client.Disconnect(True)
                End If
            End Try
        End Using

        Return result
    End Function

    Private Shared Function FindFolder(folderName As String, parentFolder As IEnumerable(Of IMailFolder), Optional sb As StringBuilder = Nothing) As IMailFolder
        Dim found As IMailFolder = Nothing
        For Each folder In parentFolder
            If IsNothing(sb) = False Then sb.AppendLine(folder.Name)
            If folder.Name = folderName Then
                found = folder
            Else
                'Folder.Open(FolderAccess.ReadOnly)
                found = FindFolder(folderName, folder.GetSubfolders(False), sb)
            End If
            If found IsNot Nothing Then
                Exit For
            End If
        Next
        Return found
    End Function

    ' HACK bypasses SSL cert check by antivirus software
    Public Shared Function ValidateServerCertificate(sender As Object, certificate As X509Certificate, chain As X509Chain, sslPolicyErr As SslPolicyErrors) As Boolean
        Return True
    End Function
End Class
