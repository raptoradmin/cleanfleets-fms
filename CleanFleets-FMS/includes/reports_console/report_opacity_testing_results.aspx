<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="report_opacity_testing_results.aspx.vb" Inherits="cleanfleets_fms.report_opacity_testing_results" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="RightColumnContentPlaceHolder" Runat="Server">
	<h1>PSIP Report to Client</h1>
	<p>&nbsp;
		
	</p>
	<div>
		<p>Include most recent Test Results collected within the specified date range. <br />
            Leave Through Date blank to include the most recent Test Results.</p>
		<asp:Label id="Label4" runat="server" AssociatedControlId="FromDate" >From Date:</asp:Label>
		<asp:TextBox id="FromDate" runat="server" CssClass="datepicker"/>
		<asp:Label id="Label5" runat="server" AssociatedControlId="FromDate" >Through Date:</asp:Label>
		<asp:TextBox id="ThroughDate" runat="server" CssClass="datepicker" />

		<br />		
        <br />

        <div style="width:75px;display:inline-block">
		<asp:Label ID="Label1" runat="server" AssociatedControlID="ddl_Account">Account:</asp:Label></div>
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
        <div style="width:75px;display:inline-block">
		<asp:Label ID="Label2" runat="server" AssociatedControlID="ddl_Terminal">Terminal:</asp:Label></div>
		<asp:DropDownList ID="ddl_Terminal" runat="server" Width="186px" AutoPostBack="true"
			OnSelectedIndexChanged="ddl_Terminal_SelectedIndexChanged" />
            <br />
		<div style="width:75px;display:inline-block">        
		<asp:Label ID="Label3" runat="server" AssociatedControlID="ddl_Fleet">Fleet:</asp:Label></div>
		<asp:DropDownList ID="ddl_Fleet" runat="server" Width="186px" AutoPostBack="true" />
		<br />

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
	<script type="text/javascript">
	$(function() {
		$(".datepicker").datepicker();
	});
	</script>
	<asp:Button ID="btn_Report" runat="server" Text="Create Report" />
	<asp:SqlDataSource ID="sds_ddl_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>
</asp:Content>


