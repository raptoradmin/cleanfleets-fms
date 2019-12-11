Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Collections.Generic
Public Class engines_detached1
    Inherits System.Web.UI.Page

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender

        Dim rg_Vehicles As RadGrid = CType(FindControlIterative(Page, "rg_Engines"), RadGrid)
        If rg_Vehicles.SelectedIndexes.Count = 0 Then
            rg_Vehicles.SelectedIndexes.Add(0)
        End If

    End Sub


    Protected Sub btn_DeleteEngine_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim IDProfileFleet As String = Request.QueryString("IDProfileFleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDVehicles As String = Request.QueryString("IDVehicles")
        If IDProfileFleet IsNot Nothing Then
            Response.Redirect("vehiclesdel.aspx?IDProfileFleet=" & IDProfileFleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicles)
        End If

    End Sub


    Protected Sub sds_CFV_Engines_fv_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles sds_CFV_Engines_fv.Updating

        Dim UserID As String
        Dim MemUser As MembershipUser
        MemUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey.ToString()

        If MemUser Is Nothing Then
            e.Cancel = True
        Else
            e.Command.Parameters("@IDModifiedUser").Value = UserID.ToString()
            e.Command.Parameters("@ModifiedDate").Value = DateTime.Now
        End If

    End Sub


    Protected Sub btn_AddDECs_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim IDEngine As HiddenField = CType(fv_EngineDetails.FindControl("hf_IDEngines"), HiddenField)
        Dim IDEngines As String = IDEngine.Value

        Response.Redirect("engine_DECsadd.aspx?IDEngines=" & IDEngines)

    End Sub


    Protected Sub sds_CFV_DECs_fv_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles sds_CFV_DECs_fv.Updating

        Dim UserID As String
        Dim MemUser As MembershipUser
        MemUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey.ToString()

        If MemUser Is Nothing Then
            e.Cancel = True
        Else
            e.Command.Parameters("@IDModifiedUser").Value = UserID.ToString()
            e.Command.Parameters("@ModifiedDate").Value = DateTime.Now
        End If

    End Sub


    Protected Sub rbt_EngineImage_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim IDEngine As HiddenField = CType(fv_EngineDetails.FindControl("hf_IDEngines"), HiddenField)
        Dim IDEngines As String = IDEngine.Value
        Dim item As GridDataItem = DirectCast(TryCast(sender, RadioButton).NamingContainer, GridDataItem)
        Dim rdBtn As RadioButton = TryCast(sender, RadioButton)
        Dim IDImages As String = item.OwnerTableView.DataKeyValues(item.ItemIndex)("IDImages")

        If rdBtn.Checked = True Then

            Dim sql As String
            Dim strConnString As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
            sql = "UPDATE CF_Images SET DefaultImage = @Value WHERE IDEngines = @IDEngines AND IDDECS IS NULL"
            Dim connection As New SqlConnection(strConnString)
            Dim command As New SqlCommand(sql, connection)

            command.Parameters.Add("@Value", SqlDbType.Int).Value = "0"
            command.Parameters.Add("@IDEngines", SqlDbType.Int).Value = IDEngines

            command.Connection.Open()
            command.ExecuteNonQuery()
            command.Connection.Close()

            Dim sql1 As String
            Dim strConnString1 As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
            sql1 = "UPDATE CF_Images SET DefaultImage = @Value WHERE IDImages = @IDImages"
            Dim connection1 As New SqlConnection(strConnString1)
            Dim command1 As New SqlCommand(sql1, connection1)

            command1.Parameters.Add("@Value", SqlDbType.Int).Value = "1"
            command1.Parameters.Add("@IDImages", SqlDbType.Int).Value = IDImages
            command1.Connection.Open()
            command1.ExecuteNonQuery()
            command1.Connection.Close()

            fv_EngineImage.DataBind()

        Else

        End If


    End Sub


    Protected Sub rbt_DECSImage_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim IDDEC As HiddenField = CType(fv_DECSDetails.FindControl("hf_IDDECS"), HiddenField)
        Dim IDDECS As String = IDDEC.Value
        Dim item As GridDataItem = DirectCast(TryCast(sender, RadioButton).NamingContainer, GridDataItem)
        Dim rdBtn As RadioButton = TryCast(sender, RadioButton)
        Dim IDImages As String = item.OwnerTableView.DataKeyValues(item.ItemIndex)("IDImages")

        If rdBtn.Checked = True Then

            Dim sql As String
            Dim strConnString As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
            sql = "UPDATE CF_Images SET DefaultImage = @Value WHERE IDDECS = @IDDECS"
            Dim connection As New SqlConnection(strConnString)
            Dim command As New SqlCommand(sql, connection)

            command.Parameters.Add("@Value", SqlDbType.Int).Value = "0"
            command.Parameters.Add("@IDDECS", SqlDbType.Int).Value = IDDECS

            command.Connection.Open()
            command.ExecuteNonQuery()
            command.Connection.Close()

            Dim sql1 As String
            Dim strConnString1 As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
            sql1 = "UPDATE CF_Images SET DefaultImage = @Value WHERE IDImages = @IDImages"
            Dim connection1 As New SqlConnection(strConnString1)
            Dim command1 As New SqlCommand(sql1, connection1)

            command1.Parameters.Add("@Value", SqlDbType.Int).Value = "1"
            command1.Parameters.Add("@IDImages", SqlDbType.Int).Value = IDImages
            command1.Connection.Open()
            command1.ExecuteNonQuery()
            command1.Connection.Close()

            fv_DECSImage.DataBind()

        Else

        End If

    End Sub


    Protected Sub btn_AddEngineImage_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_AddEngineImage.Click

        Dim IDEngine As HiddenField = CType(fv_EngineDetails.FindControl("hf_IDEngines"), HiddenField)
        Dim IDEngines As String = IDEngine.Value
        Dim sbScript As New StringBuilder()

        sbScript.Append("<script language='javascript'>")
        sbScript.Append("window.open('")
        sbScript.Append("../../../includes/imagemanager/imageupload_engines.aspx?IDEngines=" & IDEngines)
        sbScript.Append("', 'CustomPopUp',")
        sbScript.Append("'width=800, height=600, menubar=yes, resizable=yes');<")
        sbScript.Append("/script>")

        ' Make use ScriptManager to register the script
        ScriptManager.RegisterStartupScript(Me, Me.[GetType](), "@@@@MyPopUpScript", sbScript.ToString(), False)

    End Sub


    Protected Sub btn_AddDECSImage_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_AddDECSImage.Click

        Dim IDEngine As HiddenField = CType(fv_EngineDetails.FindControl("hf_IDEngines"), HiddenField)
        Dim IDDEC As HiddenField = CType(fv_DECSDetails.FindControl("hf_IDDECS"), HiddenField)
        Dim IDEngines As String = IDEngine.Value
        Dim IDDECS As String = IDDEC.Value
        Dim sbScript As New StringBuilder()

        sbScript.Append("<script language='javascript'>")
        sbScript.Append("window.open('")
        sbScript.Append("../../../includes/imagemanager/imageupload_DECS.aspx?IDEngines=" & IDEngines & "&IDDECS=" & IDDECS)
        sbScript.Append("', 'CustomPopUp',")
        sbScript.Append("'width=800, height=600, menubar=yes, resizable=yes');<")
        sbScript.Append("/script>")

        ' Make use ScriptManager to register the script
        ScriptManager.RegisterStartupScript(Me, Me.[GetType](), "@@@@MyPopUpScript", sbScript.ToString(), False)

    End Sub


    Protected Sub btn_AddEngineFile_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_AddEngineFile.Click

        Dim IDProfilefleet As String = Request.QueryString("IDProfilefleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDEngine As HiddenField = CType(fv_EngineDetails.FindControl("hf_IDEngines"), HiddenField)
        Dim IDEngines As String = IDEngine.Value
        Dim sbScript As New StringBuilder()

        sbScript.Append("<script language='javascript'>")
        sbScript.Append("window.open('")
        sbScript.Append("../../../includes/filemanager/fileupload_engines.aspx?IDProfilefleet=" & IDProfilefleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDEngines=" & IDEngines)
        sbScript.Append("', 'CustomPopUp',")
        sbScript.Append("'width=800, height=600, menubar=yes, resizable=yes');<")
        sbScript.Append("/script>")

        ' Make use ScriptManager to register the script
        ScriptManager.RegisterStartupScript(Me, Me.[GetType](), "@@@@MyPopUpScript", sbScript.ToString(), False)

    End Sub


    Protected Sub btn_AddDECSFile_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_AddDECSFile.Click

        Dim IDProfilefleet As String = Request.QueryString("IDProfilefleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDEngine As HiddenField = CType(fv_EngineDetails.FindControl("hf_IDEngines"), HiddenField)
        Dim IDEngines As String = IDEngine.Value
        Dim IDDEC As HiddenField = CType(fv_DECSDetails.FindControl("hf_IDDECS"), HiddenField)
        Dim IDDECS As String = IDDEC.Value
        Dim sbScript As New StringBuilder()

        sbScript.Append("<script language='javascript'>")
        sbScript.Append("window.open('")
        sbScript.Append("../../../includes/filemanager/fileupload_DECS.aspx?IDProfilefleet=" & IDProfilefleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDEngines=" & IDEngines & "&IDDECS=" & IDDECS)
        sbScript.Append("', 'CustomPopUp',")
        sbScript.Append("'width=800, height=600, menubar=yes, resizable=yes');<")
        sbScript.Append("/script>")

        ' Make use ScriptManager to register the script
        ScriptManager.RegisterStartupScript(Me, Me.[GetType](), "@@@@MyPopUpScript", sbScript.ToString(), False)

    End Sub


    Protected Sub rg_EngineImages_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rg_EngineImages.PreRender

        rg_EngineImages.MasterTableView.Rebind()

    End Sub


    Protected Sub rg_EngineFiles_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rg_EngineFiles.PreRender

        rg_EngineFiles.MasterTableView.Rebind()

    End Sub


    Protected Sub rg_DECSImages_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rg_DECSImages.PreRender

        rg_DECSImages.MasterTableView.Rebind()

    End Sub


    Protected Sub rg_DECsFiles_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rg_DECsFiles.PreRender

        rg_DECsFiles.MasterTableView.Rebind()

    End Sub


    Protected Sub sds_CFV_DECs_fv_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sds_CFV_DECs_fv.Selected

        If e.AffectedRows < 1 Then

            btn_AddDECSImage.Visible = False
            btn_AddDECSFile.Visible = False
            rg_DECSImages.Visible = False
            rg_DECsFiles.Visible = False
            Label1.Visible = False

        End If

    End Sub

    ' MG 12/14/2011 - there were problems finding hf_IDDECS control on page (different tab maybe?), so I use this function to find it instead
    Public Shared Function FindControlIterative(ByVal myRoot As Control, ByVal myIDOfControlToFind As String) As Control
        Dim myRootControl As Control = New Control
        myRootControl = myRoot
        Dim setOfChildControls As LinkedList(Of Control) = New LinkedList(Of Control)

        Do While (myRootControl IsNot Nothing)
            If myRootControl.ID = myIDOfControlToFind Then
                Return myRootControl
            End If
            For Each childControl As Control In myRootControl.Controls
                If childControl.ID = myIDOfControlToFind Then
                    Return childControl
                End If
                If childControl.HasControls() Then
                    setOfChildControls.AddLast(childControl)
                End If
            Next
            myRootControl = setOfChildControls.First.Value
            setOfChildControls.Remove(myRootControl)
        Loop
        Return Nothing

    End Function

End Class



