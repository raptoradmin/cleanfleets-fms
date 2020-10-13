Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.IO
Public Class engine_del
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Protected Sub btn_Delete_Click(ByVal sender As Object, ByVal e As System.EventArgs)


        Dim IDEngines As String = Request.QueryString("IDEngines")

        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CF_Images WHERE IDEngines = IDEngines", conn)
        comm.Connection.Open()

        Dim myDataAdapter As New SqlDataAdapter(comm)
        Dim myDataSet As New DataSet
        Dim dtData As New DataTable
        Dim dtRow As DataRow
        myDataAdapter.Fill(myDataSet)
        conn.Close()

        For Each dtRow In myDataSet.Tables(0).Rows

            Dim FileName = dtRow.Item("FileName")

            File.Delete(MapPath(".") & "..\..\..\..\includes\imagemanager\imagefiles\" & FileName)

        Next

        For Each dtRow In myDataSet.Tables(0).Rows

            Dim ThumbNailName = dtRow.Item("ThumbNailName")

            File.Delete(MapPath(".") & "..\..\..\..\includes\imagemanager\imagefiles\" & ThumbNailName)

        Next


        Dim hfIDEngine As HiddenField = CType(fv_VehicleDelete.FindControl("hf_IDEngines"), HiddenField)
        IDEngines = hfIDEngine.Value

        Dim sql1 As String
        Dim strConnString1 As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        sql1 = "DELETE FROM CF_Engines WHERE IDEngines = @IDEngines"
        Dim connection1 As New SqlConnection(strConnString1)
        Dim command1 As New SqlCommand(sql1, connection1)
        With command1.Parameters
            command1.Parameters.AddWithValue("@IDEngines", IDEngines)
        End With

        command1.Connection.Open()
        command1.ExecuteNonQuery()
        command1.Connection.Close()



        Dim sql3 As String
        Dim strConnString3 As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        sql3 = "DELETE FROM CF_Images WHERE IDEngines = @IDEngines"
        Dim connection3 As New SqlConnection(strConnString3)
        Dim command3 As New SqlCommand(sql3, connection3)
        With command3.Parameters
            command3.Parameters.AddWithValue("@IDEngines", IDEngines)
        End With

        command3.Connection.Open()
        command3.ExecuteNonQuery()
        command3.Connection.Close()


        Response.Redirect("engines_detached.aspx")

    End Sub

End Class