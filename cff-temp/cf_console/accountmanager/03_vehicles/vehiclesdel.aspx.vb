Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.IO
Public Class vehiclesdel1
    Inherits BaseWebForm

    Protected Sub rg_VehicleImages_NeedDataSource(ByVal source As Object, ByVal e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles rg_VehicleImages.NeedDataSource

        Dim IDVehicles = Request.QueryString("IDVehicles")

        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CF_Images WHERE IDVehicles = @IDVehicles", conn)

        comm.Parameters.Add("@IDVehicles", SqlDbType.VarChar, 50).Value = IDVehicles

        comm.Connection.Open()
        Dim myDataAdapter As New SqlDataAdapter(comm)
        Dim myDataSet As New DataSet
        Dim dtData As New DataTable
        Dim dtRow As DataRow
        myDataAdapter.Fill(myDataSet)
        comm.Connection.Close()

        For Each dtRow In myDataSet.Tables(0).Rows

            rg_VehicleImages.DataSource = myDataSet

        Next

    End Sub


    Protected Sub rg_EngineImages_NeedDataSource(ByVal source As Object, ByVal e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles rg_EngineImages.NeedDataSource


        Dim IDVehicles = Request.QueryString("IDVehicles")

        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CF_Images INNER JOIN (SELECT IDEngines FROM CF_Engines WHERE IDVehicles = @IDVehicles)AS CF_Engines ON CF_Engines.IDEngines = CF_Images.IDEngines", conn)

        comm.Parameters.Add("@IDVehicles", SqlDbType.VarChar, 50).Value = IDVehicles

        comm.Connection.Open()
        Dim myDataAdapter As New SqlDataAdapter(comm)
        Dim myDataSet As New DataSet
        Dim dtData As New DataTable
        Dim dtRow As DataRow
        myDataAdapter.Fill(myDataSet)
        comm.Connection.Close()

        For Each dtRow In myDataSet.Tables(0).Rows

            rg_EngineImages.DataSource = myDataSet

        Next


    End Sub


    Protected Sub rg_VehicleFiles_NeedDataSource(ByVal source As Object, ByVal e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles rg_VehicleFiles.NeedDataSource

        Dim IDVehicles = Request.QueryString("IDVehicles")

        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CF_Files WHERE IDVehicles = @IDVehicles", conn)

        comm.Parameters.Add("@IDVehicles", SqlDbType.VarChar, 50).Value = IDVehicles

        comm.Connection.Open()
        Dim myDataAdapter As New SqlDataAdapter(comm)
        Dim myDataSet As New DataSet
        Dim dtData As New DataTable
        Dim dtRow As DataRow
        myDataAdapter.Fill(myDataSet)
        comm.Connection.Close()

        For Each dtRow In myDataSet.Tables(0).Rows

            rg_VehicleFiles.DataSource = myDataSet

        Next

    End Sub


    Protected Sub rg_EngineFiles_NeedDataSource(ByVal source As Object, ByVal e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles rg_EngineFiles.NeedDataSource


        Dim IDVehicles = Request.QueryString("IDVehicles")

        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CF_Files INNER JOIN (SELECT IDEngines FROM CF_Engines WHERE IDVehicles = @IDVehicles)AS CF_Engines ON CF_Engines.IDEngines = CF_Files.IDEngines", conn)

        comm.Parameters.Add("@IDVehicles", SqlDbType.VarChar, 50).Value = IDVehicles

        comm.Connection.Open()
        Dim myDataAdapter As New SqlDataAdapter(comm)
        Dim myDataSet As New DataSet
        Dim dtData As New DataTable
        Dim dtRow As DataRow
        myDataAdapter.Fill(myDataSet)
        comm.Connection.Close()

        For Each dtRow In myDataSet.Tables(0).Rows

            rg_EngineFiles.DataSource = myDataSet

        Next


    End Sub




    Protected Sub btn_Delete_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim IDVehicles = Request.QueryString("IDVehicles")
        Dim IDEngine As HiddenField = CType(fv_VehicleDelete.FindControl("hf_IDEngines"), HiddenField)
        Dim IDEngines As String = IDEngine.Value
        Dim IDDEC As HiddenField = CType(fv_VehicleDelete.FindControl("hf_IDDECS"), HiddenField)
        Dim IDDECs As String = IDDEC.Value

        '<<<<<<<<<<<<<<<<<<<<                 >>>>>>>>>>>>>>>>>>>>>>>>
        '<<<<<<<<<<<<<<<<<<<<  Delete Images  >>>>>>>>>>>>>>>>>>>>>>>>
        '<<<<<<<<<<<<<<<<<<<<                 >>>>>>>>>>>>>>>>>>>>>>>>


        '**************************************************
        'Delete Vehicle Image Files
        '**************************************************

        Dim connectionString_Vehicle_Images As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn_Vehicle_Images As New SqlConnection(connectionString_Vehicle_Images)
        Dim comm_Vehicle_Images As New SqlCommand("SELECT * FROM CF_Images WHERE IDVehicles = @IDVehicles", conn_Vehicle_Images)

        comm_Vehicle_Images.Parameters.Add("@IDVehicles", SqlDbType.VarChar, 50).Value = IDVehicles

        comm_Vehicle_Images.Connection.Open()
        Dim myDataAdapter_Vehicle_Images As New SqlDataAdapter(comm_Vehicle_Images)
        Dim myDataSet_Vehicle_Images As New DataSet
        Dim dtData_Vehicle_Images As New DataTable
        Dim dtRow_Vehicle_Images As DataRow
        myDataAdapter_Vehicle_Images.Fill(myDataSet_Vehicle_Images)
        conn_Vehicle_Images.Close()


        For Each dtRow_Vehicle_Images In myDataSet_Vehicle_Images.Tables(0).Rows

            Dim FileName = dtRow_Vehicle_Images.Item("FileName")
            Try
                File.Delete(MapPath(".") & "..\..\..\..\includes\imagemanager\imagefiles\" & FileName)
            Catch fnf As FileNotFoundException
            Catch dnf As DirectoryNotFoundException
            End Try
        Next

        'For Each dtRow_Vehicle_Images In myDataSet_Vehicle_Images.Tables(0).Rows

        '    Dim ThumbNailName = dtRow_Vehicle_Images.Item("ThumbNailName")

        '	try
        '       File.Delete(MapPath(".") & "..\..\..\..\includes\imagemanager\imagefiles\" & ThumbNailName)
        '	catch fnf as FileNotFoundException
        '	catch dnf as DirectoryNotFoundException
        '	end try

        'Next

        '**************************************************
        'Delete Engine and DECS Image Files
        '**************************************************

        Dim connectionString_Engine_Images As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn_Engine_Images As New SqlConnection(connectionString_Engine_Images)
        Dim comm_Engine_Images As New SqlCommand("SELECT * FROM CF_Images INNER JOIN (SELECT IDEngines FROM CF_Engines WHERE IDVehicles = @IDVehicles)AS CF_Engines ON CF_Engines.IDEngines = CF_Images.IDEngines", conn_Engine_Images)

        comm_Engine_Images.Parameters.Add("@IDVehicles", SqlDbType.VarChar, 50).Value = IDVehicles

        comm_Engine_Images.Connection.Open()
        Dim myDataAdapter_Engine_Images As New SqlDataAdapter(comm_Engine_Images)
        Dim myDataSet_Engine_Images As New DataSet
        Dim dtData_Engine_Images As New DataTable
        Dim dtRow_Engine_Images As DataRow
        myDataAdapter_Engine_Images.Fill(myDataSet_Engine_Images)
        conn_Engine_Images.Close()


        For Each dtRow_Engine_Images In myDataSet_Engine_Images.Tables(0).Rows

            Dim FileName = dtRow_Engine_Images.Item("FileName")
            Try
                File.Delete(MapPath(".") & "..\..\..\..\includes\imagemanager\imagefiles\" & FileName)
            Catch fnf As FileNotFoundException
            Catch dnf As DirectoryNotFoundException
            End Try
        Next

        'For Each dtRow_Engine_Images In myDataSet_Engine_Images.Tables(0).Rows
        '
        '            Dim ThumbNailName = dtRow_Engine_Images.Item("ThumbNailName")
        '			try
        '            	File.Delete(MapPath(".") & "..\..\..\..\includes\imagemanager\imagefiles\" & ThumbNailName)
        '			catch fnf as FileNotFoundException
        '			catch dnf as DirectoryNotFoundException
        '			end try
        '        Next

        '**************************************************
        'Delete Engine and DECS Image Records from Image Table
        '**************************************************

        Dim sql_E_D_Images As String
        Dim strConnString_E_D_Images As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        sql_E_D_Images = "DELETE FROM CF_Images WHERE exists (SELECT CF_Vehicles.IDVehicles FROM CF_Vehicles INNER JOIN  CF_Engines ON CF_Vehicles.IDVehicles = CF_Engines.IDVehicles WHERE CF_Images.IDEngines = CF_Engines.IDEngines AND CF_Vehicles.IDVehicles = @IDVehicles)"
        Dim connection_E_D_Images As New SqlConnection(strConnString_E_D_Images)
        Dim command_E_D_Images As New SqlCommand(sql_E_D_Images, connection_E_D_Images)
        With command_E_D_Images.Parameters
            command_E_D_Images.Parameters.AddWithValue("@IDVehicles", IDVehicles)
        End With

        command_E_D_Images.Connection.Open()
        command_E_D_Images.ExecuteNonQuery()
        command_E_D_Images.Connection.Close()

        '**************************************************
        'Delete Vehicle Image Records from Image Table
        '**************************************************

        Dim sql_V_Images As String
        Dim strConnString_V_Images As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        sql_V_Images = "DELETE FROM CF_Images WHERE IDVehicles = @IDVehicles"
        Dim connection_V_Images As New SqlConnection(strConnString_V_Images)
        Dim command_V_Images As New SqlCommand(sql_V_Images, connection_V_Images)
        With command_V_Images.Parameters
            command_V_Images.Parameters.AddWithValue("@IDVehicles", IDVehicles)
        End With

        command_V_Images.Connection.Open()
        command_V_Images.ExecuteNonQuery()
        command_V_Images.Connection.Close()



        '<<<<<<<<<<<<<<<<<<<<                 >>>>>>>>>>>>>>>>>>>>>>>>
        '<<<<<<<<<<<<<<<<<<<<  Delete Files   >>>>>>>>>>>>>>>>>>>>>>>>
        '<<<<<<<<<<<<<<<<<<<<                 >>>>>>>>>>>>>>>>>>>>>>>>



        '**************************************************
        'Delete Vehicle Files
        '**************************************************

        Dim connectionString_Vehicle_Files As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn_Vehicle_Files As New SqlConnection(connectionString_Vehicle_Files)
        Dim comm_Vehicle_Files As New SqlCommand("SELECT * FROM CF_Images WHERE IDVehicles = @IDVehicles", conn_Vehicle_Files)

        comm_Vehicle_Files.Parameters.Add("@IDVehicles", SqlDbType.VarChar, 50).Value = IDVehicles

        comm_Vehicle_Files.Connection.Open()
        Dim myDataAdapter_Vehicle_Files As New SqlDataAdapter(comm_Vehicle_Files)
        Dim myDataSet_Vehicle_Files As New DataSet
        Dim dtData_Vehicle_Files As New DataTable
        Dim dtRow_Vehicle_Files As DataRow
        myDataAdapter_Vehicle_Files.Fill(myDataSet_Vehicle_Files)
        conn_Vehicle_Files.Close()


        For Each dtRow_Vehicle_Files In myDataSet_Vehicle_Files.Tables(0).Rows

            Dim FileName = dtRow_Vehicle_Files.Item("FileName")
            Try
                File.Delete(MapPath(".") & "..\..\..\..\includes\filemanager\files\" & FileName)
            Catch fnf As FileNotFoundException
            Catch dnf As DirectoryNotFoundException
            End Try
        Next


        '**************************************************
        'Delete Engine and DECS Files
        '**************************************************

        Dim connectionString_Engine_Files As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn_Engine_Files As New SqlConnection(connectionString_Engine_Files)
        Dim comm_Engine_Files As New SqlCommand("SELECT * FROM CF_Files INNER JOIN (SELECT IDEngines FROM CF_Engines WHERE IDVehicles = @IDVehicles)AS CF_Engines ON CF_Engines.IDEngines = CF_Files.IDEngines", conn_Engine_Files)

        comm_Engine_Files.Parameters.Add("@IDVehicles", SqlDbType.VarChar, 50).Value = IDVehicles

        comm_Engine_Files.Connection.Open()
        Dim myDataAdapter_Engine_Files As New SqlDataAdapter(comm_Engine_Files)
        Dim myDataSet_Engine_Files As New DataSet
        Dim dtData_Engine_Files As New DataTable
        Dim dtRow_Engine_Files As DataRow
        myDataAdapter_Engine_Files.Fill(myDataSet_Engine_Files)
        conn_Engine_Files.Close()


        For Each dtRow_Engine_Files In myDataSet_Engine_Files.Tables(0).Rows

            Dim FileName = dtRow_Engine_Files.Item("FileName")
            Try
                File.Delete(MapPath(".") & "..\..\..\..\includes\filemanager\files\" & FileName)
            Catch fnf As FileNotFoundException
            Catch dnf As DirectoryNotFoundException
            End Try

        Next


        '**************************************************
        'Delete Engine and DECS File Records from File Table
        '**************************************************

        Dim sql_E_D_Files As String
        Dim strConnString_E_D_Files As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        sql_E_D_Files = "DELETE FROM CF_Files WHERE exists (SELECT CF_Vehicles.IDVehicles FROM CF_Vehicles INNER JOIN  CF_Engines ON CF_Vehicles.IDVehicles = CF_Engines.IDVehicles WHERE CF_Files.IDEngines = CF_Engines.IDEngines AND CF_Vehicles.IDVehicles = @IDVehicles)"
        Dim connection_E_D_Files As New SqlConnection(strConnString_E_D_Files)
        Dim command_E_D_Files As New SqlCommand(sql_E_D_Images, connection_E_D_Files)
        With command_E_D_Files.Parameters
            command_E_D_Files.Parameters.AddWithValue("@IDVehicles", IDVehicles)
        End With

        command_E_D_Files.Connection.Open()
        command_E_D_Files.ExecuteNonQuery()
        command_E_D_Files.Connection.Close()

        '**************************************************
        'Delete Vehicle File Records from File Table
        '**************************************************

        Dim sql_V_Files As String
        Dim strConnString_V_Files As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        sql_V_Files = "DELETE FROM CF_FilesWHERE IDVehicles = @IDVehicles"
        Dim connection_V_Files As New SqlConnection(strConnString_V_Images)
        Dim command_V_Files As New SqlCommand(sql_V_Images, connection_V_Images)
        With command_V_Files.Parameters
            command_V_Files.Parameters.AddWithValue("@IDVehicles", IDVehicles)
        End With

        command_V_Files.Connection.Open()
        command_V_Files.ExecuteNonQuery()
        command_V_Files.Connection.Close()



        '<<<<<<<<<<<<<<<<<<<<                 >>>>>>>>>>>>>>>>>>>>>>>>
        '<<<<<<<<<<<<<<<<<<<<  Delete Records >>>>>>>>>>>>>>>>>>>>>>>>
        '<<<<<<<<<<<<<<<<<<<<                 >>>>>>>>>>>>>>>>>>>>>>>>



        '**************************************************
        'Delete DECS Records from CF_DECS
        '**************************************************

        Dim sql2 As String
        Dim strConnString2 As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        sql2 = "DELETE from CF_DECS where exists (select CF_Vehicles.IDVehicles from CF_Vehicles Inner Join  CF_Engines on CF_Vehicles.IDVehicles = CF_Engines.IDVehicles Where CF_DECS.IDEngines = CF_Engines.IDEngines and CF_Vehicles.IDVehicles = @IDVehicles)"
        Dim connection2 As New SqlConnection(strConnString2)
        Dim command2 As New SqlCommand(sql2, connection2)
        With command2.Parameters
            command2.Parameters.AddWithValue("@IDVehicles", IDVehicles)
        End With

        command2.Connection.Open()
        command2.ExecuteNonQuery()
        command2.Connection.Close()

        '**************************************************
        'Delete Engine Records from CF_Engines
        '**************************************************

        Dim sql1 As String
        Dim strConnString1 As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        sql1 = "DELETE FROM CF_Engines WHERE IDVehicles = @IDVehicles"
        Dim connection1 As New SqlConnection(strConnString1)
        Dim command1 As New SqlCommand(sql1, connection1)
        With command1.Parameters
            command1.Parameters.AddWithValue("@IDVehicles", IDVehicles)
        End With

        command1.Connection.Open()
        command1.ExecuteNonQuery()
        command1.Connection.Close()

        '**************************************************
        'Delete Vehicle Records from CF_Vehicles
        '**************************************************

        Dim sql As String
        Dim strConnString As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        sql = "DELETE FROM CF_Vehicles WHERE IDVehicles = @IDVehicles"
        Dim connection As New SqlConnection(strConnString)
        Dim command As New SqlCommand(sql, connection)
        With command.Parameters
            command.Parameters.AddWithValue("@IDVehicles", IDVehicles)
        End With

        command.Connection.Open()
        command.ExecuteNonQuery()
        command.Connection.Close()



        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDProfilefleet As String = Request.QueryString("IDProfilefleet")

        Response.Redirect("vehicles.aspx?IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDProfilefleet=" & IDProfilefleet)

    End Sub



End Class