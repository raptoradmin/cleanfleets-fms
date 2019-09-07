Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Public Class bluereport
    Inherits BaseWebForm
    Protected vehicleView As DataView
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        vehicleView = CType(sds_ReportEnginesDECS.Select(DataSourceSelectArguments.Empty), DataView)
    End Sub
End Class