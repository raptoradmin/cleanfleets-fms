<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="08_Engine_Model_Year_Replacement_Schedule.aspx.vb" Inherits="cleanfleets_fms._08_Engine_Model_Year_Replacement_Schedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder" >
	<h1>
		Engine Model Year Replacement Schedule</h1>
	<p>&nbsp;
		</p>
	<div id="Div1">
	<table>
		<tr>
			<td style="text-align:right;"><asp:Label ID="Label4" runat="server" AssociatedControlID="ddl_Account">Account:</asp:Label></td>
			<td><asp:DropDownList ID="ddl_Account" runat="server" Width="186px" DataSourceID="sds_ddl_Account"
			  DataTextField="AccountName" DataValueField="IDProfileAccount" AppendDataBoundItems="true"
			  AutoPostBack="true" OnSelectedIndexChanged="ddl_Account_SelectedIndexChanged">
			  <Items>
				  <asp:ListItem Text="- Select an Account-" Value="0" />
			  </Items>
			</asp:DropDownList>
			<asp:CustomValidator runat="server" ID="cv_ddl_Account" ControlToValidate="ddl_Account"
			OnServerValidate="cf_ddl_Validate" ErrorMessage="*" ValidateEmpty="true" /></td>
			<td><asp:Label ID="Label5" runat="server" AssociatedControlID="ddl_Terminal">Terminal:</asp:Label></td>
			<td><asp:DropDownList ID="ddl_Terminal" runat="server" Width="186px" AutoPostBack="true"
			OnSelectedIndexChanged="ddl_Terminal_SelectedIndexChanged" />
		<%--<asp:CustomValidator runat="server" ID="cv_ddl_Terminal" ControlToValidate="ddl_Terminal"
			OnServerValidate="cf_ddl_Validate" ErrorMessage="*" ValidateEmpty="true" />--%></td>
			<td><asp:Label ID="Label6" runat="server" AssociatedControlID="ddl_Fleet">Fleet:</asp:Label></td>
			<td><asp:DropDownList ID="ddl_Fleet" runat="server" Width="186px" AutoPostBack="true"
			OnSelectedIndexChanged="ddl_Fleet_SelectedIndexChanged" />
		<%--<asp:CustomValidator runat="server" ID="cv_ddl_Fleet" ControlToValidate="ddl_Fleet"
			OnServerValidate="cf_ddl_Validate" ErrorMessage="*" ValidateEmpty="true" />--%></td>
		</tr>
		<tr>
			<td><asp:Label ID="Label7" runat="server" AssociatedControlID="ddl_Fleet">Vehicle Class:</asp:Label></td>
			<td><asp:DropDownList ID="ddl_EngineReplacementScheduleClass" runat="server" Width="186px"
				AutoPostBack="true" DataSourceID="sds_ddl_Op_EngineReplacementScheduleClass"
				DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="true">
				<asp:ListItem Text="- Select -" Value="0" />
			</asp:DropDownList>
			<asp:CustomValidator runat="server" ID="cv_ddl_EngineReplacementScheduleClass" ControlToValidate="ddl_EngineReplacementScheduleClass"
				OnServerValidate="cf_ddl_Validate" ErrorMessage="*" ValidateEmpty="true" /></td>
		</tr>
	</table>
	</div>
	<br />
	<br />
	<asp:Button ID="btn_Report" runat="server" Text="Export Report" />
	<asp:SqlDataSource ID="sds_ddl_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_EngineReplacementScheduleClass" runat="server"
		ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = 'EngineReplacementScheduleClass') ORDER BY [DisplayValue]">
	</asp:SqlDataSource>
</asp:Content>
