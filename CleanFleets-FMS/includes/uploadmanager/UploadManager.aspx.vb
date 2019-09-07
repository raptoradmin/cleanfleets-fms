Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web
Imports Radactive.WebControls.ILoad
Imports Radactive.WebControls.ILoad.Core

Public Class UploadManager
    Inherits System.Web.UI.Page
    Private FileCollection As HttpFileCollection
    Private looper As Integer

    Private rootImageUrl As String = String.Empty '"~/includes/imagemanager/imagefiles/"
    Private rootFileUrl As String = String.Empty '"~/includes/filemanager/files/"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then


            If Not String.IsNullOrWhiteSpace(Request.QueryString("t")) Then
                'check querystring parameters and save to Session properties
                ClearValues()
                SetupValues()
            End If
            If Request.Headers("Referer").Contains("uploadmanager") Then
                'save Image Or file
                FileCollection = Request.Files

                For looper = 0 To FileCollection.Count - 1

                    If UploadType.Contains("i") Then

                        SaveImage(FileCollection(looper))

                    ElseIf UploadType.Contains("f") Then

                        SaveFile(FileCollection(looper))

                    End If

                Next looper

            End If
        End If

    End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        If UploadType.Contains("i") Then
            pnlImageHeading.Visible = True
            pnlFileHeading.Visible = False
            pnlDocType.Visible = False
            pnlNotes.Visible = False

        Else
            pnlFileHeading.Visible = True
            pnlDocType.Visible = True
            pnlNotes.Visible = True
            pnlImageHeading.Visible = False
        End If

    End Sub

    Private Sub ClearValues()
        Notes = Nothing
        DocTypeId = Nothing
        RecordId = Nothing
        VehicleId = Nothing
        hf_IDVehicles.Value = VehicleId
        EngineId = Nothing
        hf_IDEngines.Value = EngineId
        DECSId = Nothing
        hf_IDDECS.Value = DECSId
        ProfileAccountId = Nothing
        hf_IDProfileAccount.Value = ProfileAccountId
        TerminalId = Nothing
        hf_IDProfileTerminal.Value = TerminalId
        FleetId = Nothing
        hf_IDProfileFleet.Value = FleetId
        UploadType = Nothing
        hfType.Value = UploadType

    End Sub

    Private Sub SetupValues()
        Dim currentUser As MembershipUser = Membership.GetUser(User.Identity.Name)
        UserId = CType(currentUser.ProviderUserKey, Guid).ToString()

        UploadType = If(Not String.IsNullOrWhiteSpace(Request.QueryString("t")), Request.QueryString("t"), String.Empty)
        hfType.Value = UploadType

        'set session values
        If "vi" = UploadType Then

            VehicleId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDVehicles")), Request.QueryString("IDVehicles"), String.Empty)
            hf_IDVehicles.Value = VehicleId

            ProfileAccountId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDProfileAccount")), Request.QueryString("IDProfileAccount"), String.Empty)
            hf_IDProfileAccount.Value = ProfileAccountId

            TerminalId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDProfileTerminal")), Request.QueryString("IDProfileTerminal"), String.Empty)
            hf_IDProfileTerminal.Value = TerminalId

            FleetId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDProfileFleet")), Request.QueryString("IDProfileFleet"), String.Empty)
            hf_IDProfileFleet.Value = FleetId

        ElseIf "vf" = UploadType Then
            '"IDProfilefleet=155&IDProfileTerminal=218&IDProfileAccount=52&IDVehicles=82656049-24C1-4096-B23A-1983B6842A6A&t=vf"
            FleetId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDProfileFleet")), Request.QueryString("IDProfileFleet"), String.Empty)
            hf_IDProfileFleet.Value = FleetId

            TerminalId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDProfileTerminal")), Request.QueryString("IDProfileTerminal"), String.Empty)
            hf_IDProfileTerminal.Value = TerminalId

            ProfileAccountId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDProfileAccount")), Request.QueryString("IDProfileAccount"), String.Empty)
            hf_IDProfileAccount.Value = ProfileAccountId

            VehicleId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDVehicles")), Request.QueryString("IDVehicles"), String.Empty)
            hf_IDVehicles.Value = VehicleId

        ElseIf "ei" = UploadType Then
            '?IDEngines=2226a483-cc63-48b5-8e9b-5e083830297c&t=ei
            EngineId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDEngines")), Request.QueryString("IDEngines"), String.Empty)
            hf_IDEngines.Value = EngineId

        ElseIf "ef" = UploadType Then
            'IDProfilefleet=" & IDProfilefleet & "&IDProfileTerminal=" & IDProfileTerminal 
            '& "&IDProfileAccount=" 
            '& IDProfileAccount & "&IDEngines=" & IDEngines & "&t=ef")

            EngineId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDEngines")), Request.QueryString("IDEngines"), String.Empty)
            hf_IDEngines.Value = EngineId

            FleetId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDProfileFleet")), Request.QueryString("IDProfileFleet"), String.Empty)
            hf_IDProfileFleet.Value = FleetId

            TerminalId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDProfileTerminal")), Request.QueryString("IDProfileTerminal"), String.Empty)
            hf_IDProfileTerminal.Value = TerminalId

            ProfileAccountId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDProfileAccount")), Request.QueryString("IDProfileAccount"), String.Empty)
            hf_IDProfileAccount.Value = ProfileAccountId

        ElseIf "di" = UploadType Then
            'IDEngines=" & IDEngine & "&IDDECS=" & IDDECS & "&t=di")

            EngineId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDEngines")), Request.QueryString("IDEngines"), String.Empty)
            hf_IDEngines.Value = EngineId

            DECSId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDDECS")), Request.QueryString("IDDECS"), String.Empty)
            hf_IDProfileFleet.Value = DECSId

        ElseIf "df" = UploadType Then

            EngineId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDEngines")), Request.QueryString("IDEngines"), String.Empty)
            hf_IDEngines.Value = EngineId

            FleetId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDProfileFleet")), Request.QueryString("IDProfileFleet"), String.Empty)
            hf_IDProfileFleet.Value = FleetId

            TerminalId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDProfileTerminal")), Request.QueryString("IDProfileTerminal"), String.Empty)
            hf_IDProfileTerminal.Value = TerminalId

            ProfileAccountId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDProfileAccount")), Request.QueryString("IDProfileAccount"), String.Empty)
            hf_IDProfileAccount.Value = ProfileAccountId

            DECSId = If(Not String.IsNullOrWhiteSpace(Request.QueryString("IDDECS")), Request.QueryString("IDDECS"), String.Empty)
            hf_IDProfileFleet.Value = DECSId

        End If
    End Sub

    Private Function BuildFilePath(ByVal name As String) As String
        Dim path As String = If(UploadType.Contains("i"), System.Configuration.ConfigurationManager.AppSettings("RootImagePath"), System.Configuration.ConfigurationManager.AppSettings("RootFilePath"))
        Return String.Format("{0}{1}", path, name)
    End Function

    Protected Function GetConnectionString() As String
        Return System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString
    End Function

    Private Sub SaveFile(ByVal file As HttpPostedFile)
        rootFileUrl = ConfigurationManager.AppSettings("FileRepositoryFolder")
        RecordId = Guid.NewGuid().ToString()
        SaveFileToDisk(file)
        If UploadType.Contains("v") Then
            SaveVehicleFileDBReference()
        ElseIf UploadType.Contains("e") Then
            SaveEngineFileDBReference()
        ElseIf UploadType.Contains("d") Then
            SaveDECSFileDBReference()
        End If

    End Sub

    Private Sub SaveVehicleFileDBReference()
        'IDProfilefleet=" & IDProfilefleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicles & "&t=vf")
        Using connection As SqlConnection = Director.GetNewOpenDbConnection()

            ' ,[IDModifiedUser]
            ',[ModifiedDate]
            ',[IdDocumentType]
            ',[Title]
            ',[FileName]
            ',[FileSize]
            ',[FilePath]
            ',[IDProfileAccount]
            ',[IDProfileTerminal]
            ',[IDProfileFleet]
            ',[IDVehicles]
            ',[IDEngines]
            ',[IDDECS]
            ',[Notes]

            Using command As SqlCommand = connection.CreateCommand()
                command.CommandType = CommandType.Text
                command.CommandText = "INSERT INTO [CF_Files] ([IDFile], [IDModifiedUser], [ModifiedDate], [IdDocumentType], [Title], [FileName], [FilePath], [IDProfileAccount], [IDProfileTerminal], [IDProfileFleet], [IDVehicles], [Notes]) " &
                                      "VALUES (@IDFile, @IDModifiedUser, @ModifiedDate, @IdDocumentType, @Title, @FileName, @FilePath, @ProfileAccountId, @TerminalId, @FleetId, @VehicleId, @Notes)"

                command.Parameters.AddWithValue("@IDFile", RecordId)
                command.Parameters.AddWithValue("@IDModifiedUser", UserId)
                command.Parameters.AddWithValue("@ModifiedDate", DateTime.Now.ToString())
                command.Parameters.AddWithValue("@IdDocumentType", If(String.IsNullOrWhiteSpace(DocTypeId) OrElse DocTypeId = "0", "877", DocTypeId)) 'defaults to doc type "Other"
                command.Parameters.AddWithValue("@Title", If(String.IsNullOrWhiteSpace(Caption), "Untitled", Caption))
                command.Parameters.AddWithValue("@FileName", FileName)
                command.Parameters.AddWithValue("@FilePath", rootFileUrl)
                command.Parameters.AddWithValue("@ProfileAccountId", ProfileAccountId)
                command.Parameters.AddWithValue("@TerminalId", TerminalId)
                command.Parameters.AddWithValue("@FleetId", FleetId)
                command.Parameters.AddWithValue("@VehicleId", VehicleId)
                command.Parameters.AddWithValue("@Notes", If(String.IsNullOrWhiteSpace(Notes), String.Empty, Notes))

                command.ExecuteNonQuery()
            End Using

        End Using
    End Sub

    Private Sub SaveEngineFileDBReference()
        'IDProfilefleet=" & IDProfilefleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" 
        '& IDProfileAccount & "&IDEngines=" & IDEngines & "&t=ef")

        Using connection As SqlConnection = Director.GetNewOpenDbConnection()
            Using command As SqlCommand = connection.CreateCommand()
                command.CommandType = CommandType.Text
                command.CommandText = "INSERT INTO [CF_Files] ([IDFile], [IDModifiedUser], [ModifiedDate], [IdDocumentType], [Title], [FileName], [FilePath], [IDProfileAccount], [IDProfileTerminal], [IDProfileFleet], [IDEngines], [Notes]) " &
                                  "VALUES (@IDFile, @IDModifiedUser, @ModifiedDate, @IdDocumentType, @Title, @FileName, @FilePath, @ProfileAccountId, @TerminalId, @FleetId, @EngineId, @Notes)"

                command.Parameters.AddWithValue("@IDFile", RecordId)
                command.Parameters.AddWithValue("@IDModifiedUser", UserId)
                command.Parameters.AddWithValue("@ModifiedDate", DateTime.Now.ToString())
                command.Parameters.AddWithValue("@IdDocumentType", DocTypeId)
                command.Parameters.AddWithValue("@Title", Caption)
                command.Parameters.AddWithValue("@FileName", FileName)
                command.Parameters.AddWithValue("@FilePath", rootFileUrl)
                command.Parameters.AddWithValue("@ProfileAccountId", ProfileAccountId)
                command.Parameters.AddWithValue("@TerminalId", TerminalId)
                command.Parameters.AddWithValue("@FleetId", FleetId)
                command.Parameters.AddWithValue("@EngineId", EngineId)
                command.Parameters.AddWithValue("@Notes", Notes)

                command.ExecuteNonQuery()
            End Using

        End Using
    End Sub

    Private Sub SaveDECSFileDBReference()
        'IDProfilefleet=" & IDProfilefleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" 
        '& IDProfileAccount & "&IDEngines=" & IDEngines & "&IDDECS=" & IDDECS & "&t=df")

        Using connection As SqlConnection = Director.GetNewOpenDbConnection()
            Using command As SqlCommand = connection.CreateCommand()
                command.CommandType = CommandType.Text
                command.CommandText = "INSERT INTO [CF_Files] ([IDFile], [IDModifiedUser], [ModifiedDate], [IdDocumentType], [Title], [FileName], [FilePath], [IDProfileAccount], [IDProfileTerminal], [IDProfileFleet], [IDEngines], [IDDECS], [Notes]) " &
                                  "VALUES (@IDFile, @IDModifiedUser, @ModifiedDate, @IdDocumentType, @Title, @FileName, @FilePath, @ProfileAccountId, @TerminalId, @FleetId, @EngineId, @DECSId, @Notes)"

                command.Parameters.AddWithValue("@IDFile", RecordId)
                command.Parameters.AddWithValue("@IDModifiedUser", UserId)
                command.Parameters.AddWithValue("@ModifiedDate", DateTime.Now.ToString())
                command.Parameters.AddWithValue("@IdDocumentType", DocTypeId)
                command.Parameters.AddWithValue("@Title", Caption)
                command.Parameters.AddWithValue("@FileName", FileName)
                command.Parameters.AddWithValue("@FilePath", rootFileUrl)
                command.Parameters.AddWithValue("@ProfileAccountId", ProfileAccountId)
                command.Parameters.AddWithValue("@TerminalId", TerminalId)
                command.Parameters.AddWithValue("@FleetId", FleetId)
                command.Parameters.AddWithValue("@EngineId", EngineId)
                command.Parameters.AddWithValue("@DECSId", DECSId)
                command.Parameters.AddWithValue("@Notes", Notes)

                command.ExecuteNonQuery()
            End Using

        End Using
    End Sub

    Private Sub SaveFileToDisk(ByVal file As HttpPostedFile)
        FileName = RecordId & "_" & file.FileName
        FileCollection(looper).SaveAs(BuildFilePath(FileName))

    End Sub

    Private Sub SaveImage(ByVal image As HttpPostedFile)

        rootImageUrl = ConfigurationManager.AppSettings("ImageRepositoryFolder")
        RecordId = Guid.NewGuid().ToString()

        SaveImageToDisk(image)
        If UploadType.Contains("v") Then
            SaveVehicleImageDBReference()
        ElseIf UploadType.Contains("e") Then
            SaveEngineImageDBReference()
        ElseIf UploadType.Contains("d") Then
            SaveDECSImageDBReference()

        End If
    End Sub

    Private Sub SaveImageToDisk(ByVal image As HttpPostedFile)
        FileName = RecordId & "_" & FileCollection(looper).FileName

        ' Save the file.
        FileCollection(looper).SaveAs(BuildFilePath(FileName))

    End Sub

    Private Sub SaveVehicleImageDBReference()
        'IDProfilefleet=" & IDProfilefleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicles & "&t=vi")
        FetchDefaultVehicleImage()
        Using connection As SqlConnection = Director.GetNewOpenDbConnection()

            ' Update the record
            Using command As SqlCommand = connection.CreateCommand()
                command.CommandType = CommandType.Text
                command.CommandText = "INSERT INTO [CF_Images] ([IDImages], [IDModifiedUser], [DefaultImage], [IDVehicles], [Title], [FilePath], [FileName], [UserID]) " &
                                      "VALUES (@IDImages, @IDModifiedUser, @DefaultImage, @IDVehicles, @Title, @image_FilePath, @image_FileName, @UserID)"

                command.Parameters.AddWithValue("@IDImages", RecordId)
                command.Parameters.AddWithValue("@IDModifiedUser", UserId)
                command.Parameters.AddWithValue("@DefaultImage", DefaultImage)
                command.Parameters.AddWithValue("@IDVehicles", VehicleId)
                command.Parameters.AddWithValue("@Title", Caption)
                command.Parameters.AddWithValue("@image_FilePath", rootImageUrl)
                command.Parameters.AddWithValue("@image_FileName", FileName)
                command.Parameters.AddWithValue("@UserID", UserId)

                command.ExecuteNonQuery()
            End Using

        End Using
    End Sub

    Private Sub SaveEngineImageDBReference()
        'IDEngines=" & IDEngines & "&t=ei")
        FetchDefaultEngineImage()
        Using connection As SqlConnection = Director.GetNewOpenDbConnection()

            ' Update the record
            Using command As SqlCommand = connection.CreateCommand()
                command.CommandType = CommandType.Text
                command.CommandText = "INSERT INTO [CF_Images] ([IDImages], [IDModifiedUser], [DefaultImage], [IDEngines], [Title], [FilePath], [FileName], [UserID]) " &
                                      "VALUES (@IDImages, @IDModifiedUser, @DefaultImage, @IDEngines, @Title, @image_FilePath, @image_FileName, @UserID)"

                command.Parameters.AddWithValue("@IDImages", RecordId)
                command.Parameters.AddWithValue("@IDModifiedUser", UserId)
                command.Parameters.AddWithValue("@DefaultImage", DefaultImage)
                command.Parameters.AddWithValue("@IDEngines", EngineId)
                command.Parameters.AddWithValue("@Title", Title)
                command.Parameters.AddWithValue("@image_FilePath", rootImageUrl)
                command.Parameters.AddWithValue("@image_FileName", FileName)
                command.Parameters.AddWithValue("@UserID", UserId)

                command.ExecuteNonQuery()
            End Using

        End Using


    End Sub

    Private Sub SaveDECSImageDBReference()
        'IDEngines=" & IDEngine & "&IDDECS=" & IDDECS & "&t=di")
        FetchDefaultDECSImage()
        Using connection As SqlConnection = Director.GetNewOpenDbConnection()

            ' Update the record
            Using command As SqlCommand = connection.CreateCommand()
                command.CommandType = CommandType.Text
                command.CommandText = "INSERT INTO [CF_Images] ([IDImages], [IDModifiedUser], [DefaultImage], [IDDECS], [Title], [FilePath], [FileName], [UserID]) " &
                                      "VALUES (@IDImages, @IDModifiedUser, @DefaultImage, @IDDECS, @Title, @image_FilePath, @image_FileName, @UserID)"

                command.Parameters.AddWithValue("@IDImages", RecordId)
                command.Parameters.AddWithValue("@IDModifiedUser", UserId)
                command.Parameters.AddWithValue("@DefaultImage", DefaultImage)
                command.Parameters.AddWithValue("@IDDECS", DECSId)
                command.Parameters.AddWithValue("@Title", Title)
                command.Parameters.AddWithValue("@image_FilePath", rootImageUrl)
                command.Parameters.AddWithValue("@image_FileName", FileName)
                command.Parameters.AddWithValue("@UserID", UserId)

                command.ExecuteNonQuery()
            End Using

        End Using

    End Sub

    Private Sub FetchDefaultVehicleImage()
        Using connection As SqlConnection = Director.GetNewOpenDbConnection()
            Using command As SqlCommand = connection.CreateCommand()
                command.CommandType = CommandType.Text
                command.CommandText = "SELECT IDImages FROM [CF_Images] WHERE [IDVehicles]=@IDVehicles AND ISNULL(DefaultImage,0) = 1 "
                command.Parameters.AddWithValue("@IDVehicles", VehicleId)

                Using reader As SqlDataReader = command.ExecuteReader()
                    If (reader.Read()) Then
                        ' Record found so this new image is not default
                        DefaultImage = False
                    Else
                        DefaultImage = True
                    End If
                End Using
            End Using

        End Using
    End Sub

    Private Sub FetchDefaultEngineImage()
        Using connection As SqlConnection = Director.GetNewOpenDbConnection()
            Using command As SqlCommand = connection.CreateCommand()
                command.CommandType = CommandType.Text
                command.CommandText = "SELECT IDImages FROM [CF_Images] WHERE [IDEngines]=@IDEngines AND ISNULL(DefaultImage,0) = 1 "
                command.Parameters.AddWithValue("@IDEngines", EngineId)

                Using reader As SqlDataReader = command.ExecuteReader()
                    If (reader.Read()) Then
                        ' Record found so this new image is not default
                        DefaultImage = False
                    Else
                        DefaultImage = True
                    End If
                End Using
            End Using

        End Using
    End Sub

    Private Sub FetchDefaultDECSImage()
        Using connection As SqlConnection = Director.GetNewOpenDbConnection()
            Using command As SqlCommand = connection.CreateCommand()
                command.CommandType = CommandType.Text
                command.CommandText = "SELECT IDImages FROM [CF_Images] WHERE [IDDECS]=@IDDECS AND ISNULL(DefaultImage,0) = 1 "
                command.Parameters.AddWithValue("@IDDECS", DECSId)

                Using reader As SqlDataReader = command.ExecuteReader()
                    If (reader.Read()) Then
                        ' Record found so this new image is not default
                        DefaultImage = False
                    Else
                        DefaultImage = True
                    End If
                End Using
            End Using

        End Using
    End Sub

#Region "Properties"
    Public Property FileName() As String
        Get
            If (Not (Session("FileName") Is Nothing)) Then
                Return DirectCast(Session("FileName"), String)
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As String)
            Session("FileName") = value
        End Set
    End Property
    Public Property FleetId() As String
        Get
            If (Not (Session("FleetId") Is Nothing)) Then
                Return DirectCast(Session("FleetId"), String)
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As String)
            Session("FleetId") = value
        End Set
    End Property
    Public Property TerminalId() As String
        Get
            If (Not (Session("TerminalId") Is Nothing)) Then
                Return DirectCast(Session("TerminalId"), String)
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As String)
            Session("TerminalId") = value
        End Set
    End Property
    Public Property ProfileAccountId() As String
        Get
            If (Not (Session("ProfileAccountId") Is Nothing)) Then
                Return DirectCast(Session("ProfileAccountId"), String)
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As String)
            Session("ProfileAccountId") = value
        End Set
    End Property
    Public Property DECSId() As String
        Get
            If (Not (Session("DECSId") Is Nothing)) Then
                Return DirectCast(Session("DECSId"), String)
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As String)
            Session("DECSId") = value
        End Set
    End Property
    Public Property RecordId() As String
        Get
            If (Not (Session("RecordId") Is Nothing)) Then
                Return DirectCast(Session("RecordId"), String)
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As String)
            Session("RecordId") = value
        End Set
    End Property
    Public Property VehicleId() As String
        Get
            If (Not (Session("VehicleId") Is Nothing)) Then
                Return DirectCast(Session("VehicleId"), String)
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As String)
            Session("VehicleId") = value
        End Set
    End Property
    Public Property EngineId() As String
        Get
            If (Not (Session("EngineId") Is Nothing)) Then
                Return DirectCast(Session("EngineId"), String)
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As String)
            Session("EngineId") = value
        End Set
    End Property
    Public Property UploadType As String
        Get
            If (Not (Session("UploadType") Is Nothing)) Then
                Return DirectCast(Session("UploadType"), String)
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As String)
            Session("UploadType") = value
        End Set
    End Property
    Public Property UserId As String
        Get
            If (Not (Session("UserId") Is Nothing)) Then
                Return DirectCast(Session("UserId"), String)
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As String)
            Session("UserId") = value
        End Set
    End Property
    Public Property DefaultImage As Boolean
        Get
            If (Not (Session("DefaultImage") Is Nothing)) Then
                Return DirectCast(Session("DefaultImage"), Boolean)
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As Boolean)
            Session("DefaultImage") = value
        End Set
    End Property
    Public Property Caption As String
        Get
            If (Not (Session("Caption") Is Nothing)) Then
                Return DirectCast(Session("Caption"), String)
            Else
                Return String.Empty
            End If
        End Get
        Set(ByVal value As String)
            Session("Caption") = value
        End Set
    End Property
    Public Property DocTypeId As Int32
        Get
            If (Not (Session("DocTypeId") Is Nothing)) Then
                Return DirectCast(Session("DocTypeId"), Int32)
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As Int32)
            Session("DocTypeId") = value
        End Set
    End Property
    Public Property Notes As String
        Get
            If (Not (Session("Notes") Is Nothing)) Then
                Return DirectCast(Session("Notes"), String)
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As String)
            Session("Notes") = value
        End Set
    End Property
    Protected Sub Caption_TextChanged(sender As Object, e As EventArgs) Handles txtCaption.TextChanged
        Caption = txtCaption.Text
        Notes = txtNotes.Text
    End Sub

    Protected Sub ddlDocType_SelectedIndexChanged(sender As Object, e As EventArgs)
        DocTypeId = Int32.Parse(ddlDocType.SelectedValue)
    End Sub
#End Region

End Class

