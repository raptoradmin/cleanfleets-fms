﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="bluereport_fleet.aspx.vb" Inherits="cleanfleets_fms.bluereport_fleet1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<h1>
		Blue Report</h1>
	<p>
		&nbsp;</p>
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
		<asp:Label ID="Label4" runat="server" AssociatedControlID="ddl_Account">Account:</asp:Label>
		<asp:DropDownList ID="ddl_Account" runat="server" Width="186px" DataSourceID="sds_ddl_Account"
			DataTextField="AccountName" DataValueField="IDProfileAccount" AppendDataBoundItems="true"
			AutoPostBack="true" OnSelectedIndexChanged="ddl_Account_SelectedIndexChanged">
			<Items>
				<asp:ListItem Text="- Select an Account-" Value="0" />
			</Items>
		</asp:DropDownList>
		<asp:CustomValidator runat="server" ID="cv_ddl_Account" ControlToValidate="ddl_Account"
			OnServerValidate="cf_ddl_Validate" ErrorMessage="*" ValidateEmpty="true" />
		<asp:Label ID="Label5" runat="server" AssociatedControlID="ddl_Terminal">Terminal:</asp:Label>
		<asp:DropDownList ID="ddl_Terminal" runat="server" Width="186px" AutoPostBack="true"
			OnSelectedIndexChanged="ddl_Terminal_SelectedIndexChanged" />
		<asp:CustomValidator runat="server" ID="cv_ddl_Terminal" ControlToValidate="ddl_Terminal"
			OnServerValidate="cf_ddl_Validate" ErrorMessage="*" ValidateEmpty="true" />
		<asp:Label ID="Label6" runat="server" AssociatedControlID="ddl_Fleet">Fleet:</asp:Label>
		<asp:DropDownList ID="ddl_Fleet" runat="server" Width="186px" AutoPostBack="true"
			OnSelectedIndexChanged="ddl_Fleet_SelectedIndexChanged" />
		<asp:CustomValidator runat="server" ID="cv_ddl_Fleet" ControlToValidate="ddl_Fleet"
			OnServerValidate="cf_ddl_Validate" ErrorMessage="*" ValidateEmpty="true" />
	</div>
	<br />
	<br />
	<telerik:radcodeblock id="RadCodeBlock1" runat="server">
                

        <%--<script type="text/javascript">
            //global variables for the countries and cities comboboxes
            var countriesCombo;
            var citiesCombo;

            function pageLoad() {
                // initialize the global variables
                // in this event all client objects 
                // are already created and initialized 
                countriesCombo = $find("<%'= RadComboBox2.ClientID %>");
                citiesCombo = $find("<%'= RadComboBox3.ClientID %>");
            }

            function LoadCountries(combo, eventArqs) {
                var item = eventArqs.get_item();
                countriesCombo.set_text("Loading...");
                citiesCombo.clearSelection();

                // if a continent is selected
                if (item.get_index() > 0) {
                    // this will fire the ItemsRequested event of the 
                    // countries combobox passing the continentID as a parameter 
                    countriesCombo.requestItems(item.get_value(), false);
                }
                else {
                    // the -Select a continent- item was chosen
                    countriesCombo.set_text(" ");
                    countriesCombo.clearItems();

                    citiesCombo.set_text(" ");
                    citiesCombo.clearItems();
                }
            }

            function LoadCities(combo, eventArqs) {
                var item = eventArqs.get_item();

                citiesCombo.set_text("Loading...");
                // this will fire the ItemsRequested event of the
                // cities combobox passing the countryID as a parameter 
                citiesCombo.requestItems(item.get_value(), false);
            }

            function ItemsLoaded(combo, eventArqs) {
                if (combo.get_items().get_count() > 0) {
                    // pre-select the first item
                    combo.set_text(combo.get_items().getItem(0).get_text());
                    combo.get_items().getItem(0).highlight();
                }
                combo.showDropDown();
            }

        </script>--%>
</telerik:radcodeblock>
	<asp:Button ID="btn_Report" runat="server" Text="Create Report" />
	<asp:SqlDataSource ID="sds_ddl_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>
</asp:Content>