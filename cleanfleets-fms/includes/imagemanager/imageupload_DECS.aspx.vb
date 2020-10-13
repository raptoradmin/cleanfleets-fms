Imports System.Data
Imports System.Data.SqlClient
Imports Radactive.WebControls.ILoad
Imports Radactive.WebControls.ILoad.Configuration

' I am going to see if Importing the "Director.vb" class file will work, I am adding the code below on 12/3/2019.



' End of what was added on 12/3/2019.

Partial Public Class ImageUpload_Detail

    Inherits System.Web.UI.Page

    Public Class Director

        ' Create a new open connection to the database
        Public Shared Function GetNewOpenDbConnection() As SqlConnection
            Dim connection As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
            connection.Open()
            Return connection
        End Function

#Region "I-Load Internal codes"

        Public Const Ex_E_101_ILoad1_InternalCode As String = "Ex_E_101_ILoad1"

        Public Const Ex_E_102_ILoad1_InternalCode As String = "Ex_E_102_ILoad1"

        Public Const Ex_E_103_ILoad1_InternalCode As String = "Ex_E_103_ILoad1"

        Public Const Ex_E_201_ILoad1_InternalCode As String = "Ex_E_201_ILoad1"

        Public Const Ex_E_202_ILoad1_InternalCode As String = "Ex_E_202_ILoad1"

        Public Const Ex_E_203_ILoad1_InternalCode As String = "Ex_E_203_ILoad1"

        Public Const Ex_E_204_ILoad1_InternalCode As String = "Ex_E_204_ILoad1"

#End Region

#Region "I-Load Reposity Folders"

        Public Shared ReadOnly Property ImageRepositoryFolder() As String
            Get
                Return System.Configuration.ConfigurationManager.AppSettings("ImageRepositoryFolder")
            End Get
        End Property

        Public Shared ReadOnly Property Ex_E_102_ILoad1_RepositoryFolder() As String
            Get
                Return System.Configuration.ConfigurationManager.AppSettings("Ex_E_102_ILoad1_RepositoryFolder")
            End Get
        End Property

        Public Shared ReadOnly Property Ex_E_103_ILoad1_RepositoryFolder() As String
            Get
                Return System.Configuration.ConfigurationManager.AppSettings("Ex_E_103_ILoad1_RepositoryFolder")
            End Get
        End Property

#End Region

    End Class

    Protected Sub Page_PreLoad(sender As Object, e As System.EventArgs) Handles Me.PreLoad





    End Sub




    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        hf_IDEngines.Value = Request.QueryString("IDEngines")
        hf_IDDECS.Value = Request.QueryString("IDDECS")

        If (Not Me.IsPostBack) Then
            ' Setup the I-Load configuration

            ' Setup the control internal code / title
            Me.CF_ImageUpload.Configuration.InternalCode = Director.Ex_E_101_ILoad1_InternalCode
            Me.CF_ImageUpload.Configuration.Title = "Image Upload"

            ' Setup the lightbox window mode
            Me.CF_ImageUpload.WindowMode = ILoadWindowMode.Lightbox

            ' Create a new image definition and add it to the I-Load configurationx
            Dim definition1 As WebImageDefinition = New WebImageDefinition("Default", "Default")
            Me.CF_ImageUpload.Configuration.WebImageDefinitions.Clear()
            Me.CF_ImageUpload.Configuration.WebImageDefinitions.Add(definition1)


            ' Automatic Image Resize (Image is resized proportianlly to a max size of 800x600)
            Dim resize1 As WebImageResizeDefinition = New WebImageResizeDefinition("ImagePrimary", "Image")
            definition1.ResizeDefinitions.Add(resize1)
            resize1.Mode = Radactive.WebControls.ILoad.Core.Drawing.ImageResizeMode.Adaptive
            resize1.AdaptiveMaxSize = New System.Drawing.Size(800, 600)

            ' Initialization
            If (Not String.IsNullOrEmpty(Request.QueryString("IDImages"))) Then

                ' UPDATE...

                ' Load the database data
                Using connection As SqlConnection = Director.GetNewOpenDbConnection()
                    Using command As SqlCommand = connection.CreateCommand()
                        command.CommandType = CommandType.Text
                        command.CommandText = "SELECT [Title, FileName, ThumbnailName] FROM [CF_Images] WHERE [IDImages] = @IDImages"
                        command.Parameters.AddWithValue("@IDImages", Me.RecordId)

                        Using reader As SqlDataReader = command.ExecuteReader()

                            If (reader.Read()) Then

                                ' Record found
                                Me.txtTitle.Text = Convert.ToString(reader("Title"))

                            Else

                                ' Record not found, return to list
                                Response.Redirect("images.aspx", True)

                                Return
                            End If
                        End Using
                    End Using

                    Using command As SqlCommand = connection.CreateCommand()
                        command.CommandType = CommandType.Text
                        command.CommandText = "SELECT IDImages FROM [CF_Images] WHERE [IDEngines] = @IDEngines AND IDDECS = @IDDECS AND ISNULL(DefaultImage,0) = 1 "
                        command.Parameters.AddWithValue("@IDEngines", Me.Request.QueryString("IDEngines"))
                        command.Parameters.AddWithValue("@IDDECS", Me.Request.QueryString("IDDECS"))

                        Using reader As SqlDataReader = command.ExecuteReader()

                            If (reader.Read()) Then

                                ' Record found
                                Me.cb_DefaultImage.checked = (reader("IDImages") = Me.RecordId)

                            Else
                                Me.cb_DefaultImage.checked = True
                            End If
                        End Using
                    End Using

                End Using

                ' Get the imageId
                Dim imageId As String = Me.RecordId.ToString()

                ' Check if Picture1 exists
                If (WebImage.ExistsInFileSystem(Director.ImageRepositoryFolder, imageId)) Then

                    ' Image found...

                    ' Load Image
                    Me.CF_ImageUpload.Value = WebImage.LoadFromFileSystem(Director.ImageRepositoryFolder, imageId)

                End If
            Else

                ' INSERT...
                Me.RecordId = Guid.NewGuid()

                Using connection As SqlConnection = Director.GetNewOpenDbConnection()
                    Using command As SqlCommand = connection.CreateCommand()
                        command.CommandType = CommandType.Text
                        command.CommandText = "SELECT IDImages FROM [CF_Images] WHERE [IDEngines] = @IDEngines AND IDDECS = @IDDECS AND ISNULL(DefaultImage,0) = 1 "
                        command.Parameters.AddWithValue("@IDEngines", Me.Request.QueryString("IDEngines"))
                        command.Parameters.AddWithValue("@IDDECS", Me.Request.QueryString("IDDECS"))

                        Using reader As SqlDataReader = command.ExecuteReader()

                            If (reader.Read()) Then

                                ' Record found
                                Me.cb_DefaultImage.checked = (reader("IDImages") = Me.RecordId)

                            Else
                                Me.cb_DefaultImage.checked = True
                            End If
                        End Using
                    End Using

                End Using


            End If
        End If

    End Sub

    ' Gets or sets the record id
    Public Property RecordId() As Guid
        Get
            If (Not (Me.ViewState("RecordId") Is Nothing)) Then
                Return DirectCast(Me.ViewState("RecordId"), Guid)
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As Guid)
            Me.ViewState("RecordId") = value
        End Set
    End Property


    Protected Sub cancelButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        ' Cancel - Return to list
        Response.Redirect("imageupload.aspx")
    End Sub


    Protected Sub saveButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles saveButton.Click

        ' Save the record

        ' Validate 
        If (Not Me.IsValid) Then
            Return
        End If

        If (Me.RecordId.ToString Is Nothing) Then

            ' UPDATE...

            Using connection As SqlConnection = Director.GetNewOpenDbConnection()

                ' Update the record
                Using command As SqlCommand = connection.CreateCommand()
                    command.CommandType = CommandType.Text
                    command.CommandText = "UPDATE [CF_Images] SET [Title]=@Title WHERE [IDImages]=@IDImages"
                    command.Parameters.AddWithValue("@Title", Me.txtTitle.Text)
                    command.Parameters.AddWithValue("@IDImages", Me.RecordId)
                    command.ExecuteNonQuery()

                End Using
            End Using
        Else


            ' INSERT...

            Using connection As SqlConnection = Director.GetNewOpenDbConnection()
                ' Insert the new record
                Using command As SqlCommand = connection.CreateCommand()
                    command.CommandType = CommandType.Text
                    command.CommandText = "INSERT INTO [CF_Images] ([IDImages], [Title]) VALUES (@IDImages, @Title)"
                    command.Parameters.AddWithValue("@IDImages", Me.RecordId)
                    command.Parameters.AddWithValue("@Title", Me.txtTitle.Text)
                    command.ExecuteNonQuery()
                End Using

                Using command As SqlCommand = connection.CreateCommand()
                    command.CommandType = CommandType.Text
                    command.CommandText = "SELECT @@IDENTITY"

                End Using
            End Using

        End If

        ' Get the image id
        Dim imageId As String = Me.RecordId.ToString

        ' Update image files in the file system
        Me.CF_ImageUpload.SynchronizeFileSystem(Director.ImageRepositoryFolder, imageId)

        ' Get the file names ---------------------------------------------------
        Dim selectedImage_FileName As String
        Dim image_FileName As String
        Dim currentUser As MembershipUser = Membership.GetUser(User.Identity.Name)
        Dim UserID As Guid = CType(currentUser.ProviderUserKey, Guid)
        Dim IDEngines As String
        Dim IDDECS As String



        If (Not (CF_ImageUpload.Value Is Nothing)) Then
            ' An image has been selected...
            image_FileName = CF_ImageUpload.Value.Resizes("Image").FileName
            IDEngines = Request.QueryString("IDEngines")
            IDDECS = Request.QueryString("IDDECS")

        Else
            ' No image selected
            selectedImage_FileName = ""
            image_FileName = ""
            IDEngines = ""
            IDDECS = ""
        End If
        '----------------------------------------------------------------------

        ' Save the file names -------------------------------------------------

        Using connection As SqlConnection = Director.GetNewOpenDbConnection()
            ' Update the record
            Using command As SqlCommand = connection.CreateCommand()
                command.CommandType = CommandType.Text
                command.CommandText = "UPDATE [CF_Images] SET [FileName]=@image_FileName, [UserID]=@UserID, [IDModifiedUser]=@IDModifiedUser, [IDEngines]=@IDEngines, " &
                  "[IDDECS]=@IDDECS, DefaultImage=@DefaultImage " &
                  "WHERE [IDImages]=@IDImages"
                command.Parameters.AddWithValue("@image_FileName", image_FileName)
                command.Parameters.AddWithValue("@IDImages", Me.RecordId)
                command.Parameters.AddWithValue("@UserID", UserID)
                command.Parameters.AddWithValue("@IDModifiedUser", UserID)
                command.Parameters.AddWithValue("@IDEngines", IDEngines)
                command.Parameters.AddWithValue("@IDDECS", IDDECS)
                command.Parameters.AddWithValue("@DefaultImage", Me.cb_DefaultImage.checked)
                command.ExecuteNonQuery()
            End Using

            If Me.cb_DefaultImage.checked Then
                Using command As SqlCommand = connection.CreateCommand()
                    command.CommandType = CommandType.Text
                    command.CommandText = "UPDATE [CF_Images] SET DefaultImage=0 WHERE IDEngines = @IDEngines AND IDDECS = @IDDECS AND IDImages<>@IDImages "
                    command.Parameters.AddWithValue("@IDImages", Me.RecordId)
                    command.Parameters.AddWithValue("@IDEngines", IDEngines)
                    command.Parameters.AddWithValue("@IDDECS", IDDECS)
                    command.ExecuteNonQuery()
                End Using
            End If

        End Using
        '----------------------------------------------------------------------

        ' All done - Return to list
        Dim sbScript As New StringBuilder()
        sbScript.Append("<script language=javascript>")
        sbScript.Append("window.opener.document.forms[0].submit();")
        sbScript.Append("self.close();")
        sbScript.Append("</script>")
        ScriptManager.RegisterStartupScript(Me, Me.[GetType](), "@@@@MyPopUpScript", sbScript.ToString(), False)

    End Sub



End Class


