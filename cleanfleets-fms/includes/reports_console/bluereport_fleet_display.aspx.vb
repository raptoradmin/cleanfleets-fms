Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports Inspironix.DB
Imports Inspironix
Public Class bluereport_fleet_display2
    Inherits BaseWebForm

    Protected vehicleView As DataView

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        vehicleView = CType(sds_ReportEnginesDECS.Select(DataSourceSelectArguments.Empty), DataView)

        'btn_Print.Attributes("onClick") = "javascript:window.print();return false"
        btn_Print.Attributes("onClick") = "javascript:document.execCommand('print', false, null);return false"

    End Sub

End Class