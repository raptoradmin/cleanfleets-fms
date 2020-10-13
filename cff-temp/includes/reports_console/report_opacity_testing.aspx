<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="report_opacity_testing.aspx.vb" Inherits="cleanfleets_fms.report_opacity_testing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="RightColumnContentPlaceHolder" Runat="Server">
	<h1>PSIP Field Technician Report</h1>
	<p>&nbsp;
		
	</p>
	<div>
		<asp:Label ID="Label1" runat="server" AssociatedControlID="ddl_Account">Account:</asp:Label>
		<asp:DropDownList ID="ddl_Account" runat="server" Width="186px" DataSourceID="sds_ddl_Account"
			DataTextField="AccountName" DataValueField="IDProfileAccount" AppendDataBoundItems="true"
			AutoPostBack="true" OnSelectedIndexChanged="ddl_Account_SelectedIndexChanged">
			<Items>
				<asp:ListItem Text="- Select an Account-" Value="0" />
			</Items>
		</asp:DropDownList>
		<asp:CustomValidator runat="server" ID="cv_ddl_Account" ControlToValidate="ddl_Account"
			OnServerValidate="cf_ddl_Validate" ErrorMessage="Please select a valid account" ValidateEmpty="true" />
		<br />
		<asp:Label ID="Label2" runat="server" AssociatedControlID="ddl_Terminal">Terminal:</asp:Label>
		<asp:DropDownList ID="ddl_Terminal" runat="server" Width="186px" AutoPostBack="true"
			OnSelectedIndexChanged="ddl_Terminal_SelectedIndexChanged" />
		<asp:CustomValidator runat="server" ID="cv_ddl_Terminal" ControlToValidate="ddl_Terminal"
			OnServerValidate="cf_ddl_Validate" ErrorMessage="Please select a valid terminal" ValidateEmpty="true" />
		<br />
		<asp:Label ID="Label3" runat="server" AssociatedControlID="ddl_Fleet">Fleet:</asp:Label>
		<asp:DropDownList ID="ddl_Fleet" runat="server" Width="186px" AutoPostBack="true" />
		<table>
			<tbody>
				<tr>
					<td colspan="2" align="left"><br/>
						<asp:Label ID="Messages" runat="server" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<br />
	<br />
	<asp:Button ID="btn_Report" runat="server" Text="Create Report" />
	<asp:SqlDataSource ID="sds_ddl_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>
</asp:Content>
