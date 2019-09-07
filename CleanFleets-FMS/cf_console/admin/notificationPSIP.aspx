<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="notificationPSIP.aspx.vb" Inherits="cleanfleets_fms.notificationPSIP" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RightColumnContentPlaceHolder" Runat="Server">
	<h1>PSIP Notification Settings</h1>
	<p>
		Here you can select an Employee to receive the drafts for all Accounts' PSIP Notifications.
	</p>
	<asp:Panel ID="pnlSettings" runat="server">
		<table>
			<tr>
				<td>
					<asp:Label ID="Employee_Label" runat="server" AssociatedControlID="ddl_Employee">Employee:</asp:Label>
				</td>
				<td align="left">
					<asp:DropDownList ID="ddl_Employee" runat="server" Width="186px" DataSourceID="sdsEmployeeList" OnDataBound="ddl_Employee_DataBound"
						DataTextField="Name" DataValueField="IDProfileContact" AppendDataBoundItems="true">
						<Items>
							<asp:ListItem Text="- Select an Employee -" Value="0" />
						</Items>
					</asp:DropDownList>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left">
					<asp:Button ID="btnSave" runat="server" TabIndex="2" Text="Save" />
				</td>
			</tr>
		</table>
		<br />
		<br />
		<table>
			<tr>
				<td>
					<asp:Label ID="Account_Label" runat="server" AssociatedControlID="ddl_Account">Account:</asp:Label>
				</td>
				<td align="left">
					<asp:DropDownList ID="ddl_Account" runat="server" Width="300px" DataSourceID="sds_ddl_Account" DataTextField="AccountName" DataValueField="IDProfileAccount" AppendDataBoundItems="True">
						<Items>
							<asp:ListItem Text="- Select Account -" Value="0" />
						</Items>
					</asp:DropDownList>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left">
					<asp:Button ID="btnPreview" runat="server" TabIndex="3" Text="Preview Report" />
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left">
					<asp:Button ID="btnTest" runat="server" TabIndex="3" Text="Test Report" />
				</td>
			</tr>
		</table>
		<br />
		<br />
		<table>
			<tr>
				<td colspan="2" align="left">
					<asp:Label ID="Messages" runat="server" />
				</td>
			</tr>
		</table>
	</asp:Panel>
	<asp:Panel ID="pnlReport" runat="server" Visible="false">
		<asp:Button ID="btnReturn" runat="server" TabIndex="3" Text="Go Back" />
		<br />
		<br />
		Recipients:<br />
		<asp:Label ID="Recipients" runat="server" />
		<br />
		<br />
		Email Body:<br />
		<asp:Label ID="EmailBody" runat="server" />
		<br />
		<br />
		Preview of vehicles:<br />
		<telerik:radgrid ID="gv_Vehicles" runat="server" AutoGenerateColumns="true" CellPadding="2" CellSpacing="0">
		</telerik:radgrid>
	</asp:Panel>
	
	<asp:SqlDataSource ID="sdsEmployeeList" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [LastName] + ', ' + [FirstName] [Name], [Email], [IDProfileContact] FROM [CFV_Profile_Employee] ORDER BY [LastName]">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]">
	</asp:SqlDataSource>
</asp:Content>
