Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Public Class vehiclesearch1
    Inherits BaseWebForm

    Protected Sub Page_Load(ByRef sender As Object, ByRef e As EventArgs)
        'SearchButton.PostBackUrl = "?"
        'Me.Form.Method = "GET"
        Me.vehiclesearch.text = Request.QueryString("VehicleSearch")
    End Sub

    Protected Sub SearchButton_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim SearchUrl As String = "vehiclesearch.aspx?VehicleSearch=" & Me.vehicleSearch.text
        Response.Redirect(SearchUrl) ' Poor man's HTTP GET
    End Sub

    Protected Sub VehicleSearch_PreRender(ByVal sender As Object, ByVal e As EventArgs) Handles vehiclesearch.PreRender
        CType(sender, TextBox).Text = Request.QueryString("VehicleSearch")
    End Sub

    Protected Sub radgrid1_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles RadGrid1.Databound
        ' if only one row, navigate to the hyperlink in the column "Details"

        Dim items = RadGrid1.MasterTableView.Items
        If items IsNot Nothing AndAlso items.Count = 1 Then
            Dim tc As System.Web.UI.WebControls.TableCell = items(0)("Details")
            Dim hlf As System.Web.UI.WebControls.HyperLink = CType(tc.Controls(0), HyperLink)

            Response.Redirect(hlf.NavigateUrl)
        End If
    End Sub

    Protected Sub sds_QueryFV_Selecting(ByVal sender As Object, ByVal e As SqlDataSourceSelectingEventArgs) Handles sds_QueryFV.selecting
        Dim newvalue As String = Request.QueryString("VehicleSearch")
        If newvalue > "" AndAlso vehiclesearch.text.trim() = "" Then
            e.Command.Parameters("@SearchString").Value = newvalue
            'CType(Page.FindControl("VehicleSearch"), TextBox).Text = newvalue
            'vehiclesearch.text = newvalue

        End If
    End Sub

End Class



