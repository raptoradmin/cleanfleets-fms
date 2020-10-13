<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="bluereport_fleet_CARB.aspx.vb" Inherits="cleanfleets_fms.bluereport_fleet_CARB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="RightColumnContentPlaceHolder" runat="server">

<h1>
		Blue Report by CARB Group</h1>
	<p>
		&nbsp;</p>
	<div id="Div1">


		CARB Group:
		<asp:DropDownList ID="ddl_CARBGroup" runat="server" Width="186px" DataSourceID="sds_ddl_Op_CARBGroup"
			DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="True">
			<asp:ListItem Text="- Select -" Value="0" />
		</asp:DropDownList>

		<asp:CustomValidator runat="server" ID="cv_ddl_CARBGroup" ControlToValidate="ddl_CARBGroup"
			OnServerValidate="cf_ddl_Validate" ErrorMessage="*" ValidateEmpty="true" />
	</div>
	<br />
	<br />

	<asp:Button ID="btn_Report" runat="server" Text="Create Report" />
	<asp:SqlDataSource ID="sds_ddl_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_CARBGroup" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = 'CARBGroup') ORDER BY [DisplayValue]">
	</asp:SqlDataSource>
    </asp:Content>
