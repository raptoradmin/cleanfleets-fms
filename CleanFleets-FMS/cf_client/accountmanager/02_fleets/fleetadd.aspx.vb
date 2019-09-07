Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Public Class fleetadd
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lbl_TerminalName.Text = Request.QueryString("TermName")
        hf_IDProfileTerminal.Value = Request.QueryString("IDProfileTerminal")
        hf_IDProfileAccount.Value = Request.QueryString("IDProfileAccount")
    End Sub

    Protected Sub btnInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsert.Click

        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection, strsqlinsert As String
        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim currentUserId As Guid = CType(currentUser.ProviderUserKey, Guid)
        Dim IDProfileFleet As String

        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        strsqlinsert = "Insert into CF_Profile_fleet ( "
        strsqlinsert += "IDModifiedUser,IDRuleCode,EnterDate,ModifiedDate,IDProfileTerminal,FleetName,Address1,Address2,City,State,Zip,Telephone1,Ext1,Telephone2,Ext2,Telephone3,Ext3,Fax1,Email,Notes"
        strsqlinsert += ")"
        strsqlinsert += " values ("
        strsqlinsert += "@IDModifiedUser,@IDRuleCode,@EnterDate,@ModifiedDate,@IDProfileTerminal,@FleetName,@Address1,@Address2,@City,@State,@Zip,@Telephone1,@Ext1,@Telephone2,@Ext2,@Telephone3,@Ext3,@Fax1,@Email,@Notes"
        strsqlinsert += ")"
        strsqlinsert += "; SELECT SCOPE_IDENTITY() ; "
        conn = New SqlConnection(strconnection)
        cmd = New SqlCommand(strsqlinsert, conn)
        cmd.Parameters.Add("@IDModifiedUser", SqlDbType.UniqueIdentifier).Value = currentUserId
        cmd.Parameters.Add("@IDRuleCode", SqlDbType.Int).Value = ddl_RuleCode.Text
        cmd.Parameters.Add("@EnterDate", SqlDbType.DateTime).Value = DateTime.Now
        cmd.Parameters.Add("@ModifiedDate", SqlDbType.DateTime).Value = DateTime.Now
        cmd.Parameters.Add("@AccountName", SqlDbType.VarChar, 50).Value = lbl_TerminalName.Text
        cmd.Parameters.Add("@IDProfileTerminal", SqlDbType.VarChar, 50).Value = hf_IDProfileTerminal.Value
        cmd.Parameters.Add("@FleetName", SqlDbType.VarChar, 50).Value = tb_FleetName.Text
        cmd.Parameters.Add("@Address1", SqlDbType.VarChar, 50).Value = tb_Address1.Text
        cmd.Parameters.Add("@Address2", SqlDbType.VarChar, 50).Value = tb_Address2.Text
        cmd.Parameters.Add("@City", SqlDbType.VarChar, 50).Value = tb_City.Text
        cmd.Parameters.Add("@State", SqlDbType.VarChar, 50).Value = tb_State.Text
        cmd.Parameters.Add("@Zip", SqlDbType.VarChar, 9).Value = tb_Zip.Text
        cmd.Parameters.Add("@Telephone1", SqlDbType.VarChar, 10).Value = tb_Telephone1.Text
        cmd.Parameters.Add("@Ext1", SqlDbType.VarChar, 10).Value = tb_Ext1.Text
        cmd.Parameters.Add("@Telephone2", SqlDbType.VarChar, 10).Value = tb_Telephone2.Text
        cmd.Parameters.Add("@Ext2", SqlDbType.VarChar, 10).Value = tb_Ext2.Text
        cmd.Parameters.Add("@Telephone3", SqlDbType.VarChar, 10).Value = tb_Telephone3.Text
        cmd.Parameters.Add("@Ext3", SqlDbType.VarChar, 10).Value = tb_Ext3.Text
        cmd.Parameters.Add("@Fax1", SqlDbType.VarChar, 10).Value = tb_Fax1.Text
        cmd.Parameters.Add("@Email", SqlDbType.VarChar, 100).Value = tb_Email.Text
        cmd.Parameters.Add("@Notes", SqlDbType.VarChar, 8000).Value = tb_Notes.Text

        cmd.Connection.Open()
        IDProfileFleet = cmd.ExecuteScalar
        cmd.Connection.Close()
        Response.Redirect("fleetdetails.aspx?IDProfilefleet=" & IDProfileFleet & "&IDProfileTerminal=" & hf_IDProfileTerminal.Value & "&IDProfileAccount=" & hf_IDProfileAccount.Value)
    End Sub
End Class