<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="07_fleet_calculation_export.aspx.vb" Inherits="cleanfleets_fms._07_fleet_calculation_export" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<h1>
		Fleet Calculation Report Export</h1>
	<p>&nbsp;
		</p>
	<div id="Div1">
		<%--<asp:Label ID="Label4" runat="server" AssociatedControlID="RadComboBox1">Account:</asp:Label>
            <telerik:RadComboBox ID="RadComboBox1" 
                runat="server" 
                Width="186px" 
                OnClientSelectedIndexChanging="LoadCountries"
                OnItemsRequested="RadComboBox1_ItemsRequested" />
            
            <asp:Label ID="Label5" runat="server" AssociatedControlID="RadComboBox2">Terminal:</asp:Label>
            <telerik:RadComboBox ID="RadComboBox2" 
                runat="server" 
                Width="186px" 
                OnClientSelectedIndexChanging="LoadCities" 
                OnClientItemsRequested="ItemsLoaded"
                OnItemsRequested="RadComboBox2_ItemsRequested" />
            
            <asp:Label ID="Label6" runat="server" AssociatedControlID="RadComboBox3">Fleet:</asp:Label>
            <telerik:RadComboBox ID="RadComboBox3" 
                runat="server" 
                Width="186px" 
                OnClientItemsRequested="ItemsLoaded" 
                OnItemsRequested="RadComboBox3_ItemsRequested" />
			--%>
			<table>
				<tr>
					<td style="text-align:right;"><asp:Label ID="Label4" runat="server" AssociatedControlID="ddl_Account">Account:</asp:Label></td>
					<td><asp:DropDownList ID="ddl_Account" runat="server" Width="186px" DataSourceID="sds_ddl_Account"
						  DataTextField="AccountName" DataValueField="IDProfileAccount" AppendDataBoundItems="true"
						  AutoPostBack="true" OnSelectedIndexChanged="ddl_Account_SelectedIndexChanged">
						<Items>
                        	<asp:ListItem Text="- Select an Account -" Value="-1" />
							<asp:ListItem Text="- All Accounts -" Value="0" />
						</Items>
						</asp:DropDownList>
						<asp:CustomValidator runat="server" ID="cv_ddl_Account" ControlToValidate="ddl_Account"
						  OnServerValidate="cf_ddl_Validate" ErrorMessage="*" ValidateEmpty="true" /></td>
					<td width="50px" style="text-align:right;"><asp:Label ID="Label5" runat="server" AssociatedControlID="ddl_Terminal">Terminal:</asp:Label></td>
					<td><asp:DropDownList ID="ddl_Terminal" runat="server" Width="186px" AutoPostBack="true"
						  OnSelectedIndexChanged="ddl_Terminal_SelectedIndexChanged" />
						<%--<asp:CustomValidator runat="server" id="cv_ddl_Terminal" ControlToValidate="ddl_Terminal"
							  OnServerValidate="cf_ddl_Validate" ErrorMessage="*" ValidateEmpty="true" />--%></td>
					<td width="50px" style="text-align:right;"><asp:Label ID="Label6" runat="server" AssociatedControlID="ddl_Fleet">Fleet:</asp:Label></td>
					<td><asp:DropDownList ID="ddl_Fleet" runat="server" Width="186px" AutoPostBack="true"
						  OnSelectedIndexChanged="ddl_Fleet_SelectedIndexChanged" />
						<%--<asp:CustomValidator runat="server" id="cv_ddl_Fleet" ControlToValidate="ddl_Fleet"
							  OnServerValidate="cf_ddl_Validate" ErrorMessage="*" ValidateEmpty="true" />--%></td>
				</tr>
				<tr>
					<td valign="top"><br /><asp:Label ID="Label7" runat="server" AssociatedControlID="ddl_RuleCode">Fleet Rule Code:</asp:Label></td>
					<td><br /><asp:ListBox ID="ddl_RuleCode" runat="server" Width="186px" 
						  	    DataSourceID="sds_ddl_RuleCode"
						        DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="true" Height="175px" SelectionMode="Multiple">
								<asp:ListItem Selected="true" Text="- None -" Value="" />
							  </asp:ListBox></td>
				</tr>
			</table>
	</div>
	<br />
	<br />
	<asp:Button ID="btn_Report_Excel" runat="server" Text="Export Report as Excel" />
	<asp:Button ID="btn_Report_PDF" runat="server" Text="Export Report as PDF" />
	<asp:SqlDataSource ID="sds_ddl_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_RuleCode" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CF_Option_List] WHERE OptionName = 'RuleCode' ORDER BY [DisplayValue]"></asp:SqlDataSource>
	
</asp:Content>

