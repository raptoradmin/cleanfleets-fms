Imports System.Data
Imports System.Data.SqlClient
Public Class updateVehicleInformation
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btn_UpdateVehicleInformation_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_UpdateVehicleInformation.Click

        Dim CF_SQL_Connection As String = ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString
        Using myConnection As New SqlConnection(CF_SQL_Connection)
            myConnection.Open()
            Dim myCommand As New SqlCommand("EXECUTE UpdateVehicleInformation", myConnection)
            myCommand.ExecuteNonQuery()
            myConnection.Close()
            Me.Results.Text = "Updated."
        End Using

    End Sub

End Class