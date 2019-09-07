Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.CodeDom
Imports System.Web
Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Security
Imports System.Security.Principal.WindowsIdentity
Imports System.Collections.Generic
Public Class account_add
    Inherits BaseWebForm


    Protected Sub btnInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsert.Click

        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection, strsqlinsert As String
        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim currentUserId As Guid = CType(currentUser.ProviderUserKey, Guid)
        Dim IDProfileAccount As Int32 = 0

        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        strsqlinsert = "Insert into CF_Profile_Account ( "
        strsqlinsert += "IDModifiedUser,EnterDate,ModifiedDate,AccountName,AccountNum,ContractNum,ReferredBy,Address1,Address2,City,State,Zip,Telephone1,Ext1,Telephone2,Ext2,Telephone3,Ext3,Fax1,Email,Notes,NotesCF"
        strsqlinsert += ")"
        strsqlinsert += " values ("
        strsqlinsert += "@IDModifiedUser,@EnterDate,@ModifiedDate,@AccountName,@AccountNum,@ContractNum,@ReferredBy,@Address1,@Address2,@City,@State,@Zip,@Telephone1,@Ext1,@Telephone2,@Ext2,@Telephone3,@Ext3,@Fax1,@Email,@Notes,@NotesCF"
        strsqlinsert += ")"
        strsqlinsert += "; SELECT SCOPE_IDENTITY() ; "
        conn = New SqlConnection(strconnection)
        cmd = New SqlCommand(strsqlinsert, conn)
        cmd.Parameters.Add("@IDModifiedUser", SqlDbType.UniqueIdentifier).Value = currentUserId
        cmd.Parameters.Add("@EnterDate", SqlDbType.DateTime).Value = DateTime.Now
        cmd.Parameters.Add("@ModifiedDate", SqlDbType.DateTime).Value = DateTime.Now
        cmd.Parameters.Add("@AccountName", SqlDbType.VarChar, 50).Value = tb_AccountName.Text
        cmd.Parameters.Add("@AccountNum", SqlDbType.VarChar, 50).Value = tb_AccountNum.Text
        cmd.Parameters.Add("@ContractNum", SqlDbType.VarChar, 50).Value = tb_ContractNum.Text
        cmd.Parameters.Add("@ReferredBy", SqlDbType.VarChar, 50).Value = tb_ReferredBy.Text
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
        cmd.Parameters.Add("@NotesCF", SqlDbType.VarChar, 8000).Value = tb_NotesCF.Text
        cmd.Connection.Open()
        IDProfileAccount = Convert.ToInt32(cmd.ExecuteScalar())

        insertDefaultModulePreferences(conn, IDProfileAccount)

        cmd.Connection.Close()
        Response.Redirect("account_details.aspx?IDProfileAccount=" & IDProfileAccount)
    End Sub


    Private Sub insertDefaultModulePreferences(ByVal conn As SqlConnection, ByVal profileID As String)
        Dim moduleIDs = New Dictionary(Of String, String)

        Dim comm As New SqlCommand("SELECT IDOptionList, RecordValue FROM CF_Option_List WHERE OptionName = @optionName ", conn)
        comm.Parameters.Add("@optionName", "DefaultModule")
        Dim objReader As SqlDataReader
        objReader = comm.ExecuteReader()
        While objReader.Read()
            moduleIDs.Add(objReader("IDOptionList"), objReader("RecordValue"))
        End While

        objReader.Close()

        For Each kvp As KeyValuePair(Of String, String) In moduleIDs
            Dim moduleID = kvp.Key
            Dim moduleName = kvp.Value
            Dim preference As String
            Select Case moduleName
                Case "ComplianceCertification"
                    preference = "Y"
                Case "FleetSummary"
                    preference = "Y"
                Case "OpacityTests"
                    preference = "Y"
                Case "EngineModelYearReplacementSchedule"
                    preference = "N"
                Case "STBPhaseInOption"
                    preference = "N"
                Case "LowMileageConstruction"
                    preference = "N"
                Case "NOxExempt"
                    preference = "N"
                Case Else
                    Throw New Exception("Unsupported module.")
            End Select

            comm = New SqlCommand("INSERT INTO CF_AccountDefaultModules (IDProfileAccount, IDDefaultModule, IsDisplayed) VALUES (@ProfileId, @ModuleID, @IsDisplayed) ", conn)
            comm.Parameters.Add("@ProfileID", profileID)
            comm.Parameters.Add("@ModuleID", moduleID)
            comm.Parameters.Add("@IsDisplayed", preference)
            comm.ExecuteNonQuery()

        Next
    End Sub

End Class
