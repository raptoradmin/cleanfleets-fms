<%@ Page Title="Fleet Compliance Management System | Changelog" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="changelog.aspx.vb" Inherits="cleanfleets_fms._default1" %>

<%@ Register Assembly="CFWebControls" Namespace="CFWebControls" TagPrefix="cc1" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        #form1 {
            text-align: left;
        }
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">

    <h1>Vehicle Changelog</h1>

    <p>Note to anyone who is testing this changelog:</p>
    <p>User name is not currently displayed, as this would require an update to the database architecture.</p>

    <asp:Button ID="Button1" runat="server" Text="Download Report" />

    <asp:SqlDataSource ID="sds_CFV_ChangeLog" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CFV_Vehicles] ORDER BY ModifiedDate DESC" >
	</asp:SqlDataSource>

    <telerik:RadGrid ID="RG_changelog" runat="server" DataSourceID="sds_CFV_ChangeLog" AllowPaging="true" PageSize="50" Width="800">
        <MasterTableView AutoGenerateColumns="false">
            <Columns>
                <telerik:GridBoundColumn DataField="IDModifiedUser" DataType="System.String" HeaderText="User Name" UniqueName="ChangelogUserStatic" ></telerik:GridBoundColumn>
                <%--<telerik:GridHyperLinkColumn DataNavigateUrlFields="IDModifiedUser" DataNavigateUrlFormatString="{0}"
                    DataTextField="IDModifiedUser" DataTextFormatString="{0}" HeaderText="User" UniqueName="ChangelogUser" >
                    <ItemStyle CssClass="radgrid"></ItemStyle>
                </telerik:GridHyperLinkColumn>--%>
                <%--URL can be expanded to include "breadcrumbs" along top of page--%> 
                <telerik:GridHyperLinkColumn DataNavigateUrlFields="IDVehicles" DataNavigateUrlFormatString="accountmanager/03_vehicles/vehiclesdetails.aspx?IDVehicles={0}"
                    DataTextField="UnitNo" DataTextFormatString="{0}" HeaderText="Vehicle" UniqueName="ChangelogHyperlink" >
                    <ItemStyle CssClass="radgrid"></ItemStyle>
                </telerik:GridHyperLinkColumn>
                <telerik:GridBoundColumn DataField="ModifiedDate" DataType="System.String" HeaderText="Modified Date" UniqueName="ChangelogModifiedDate" ></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="IDVehicles" DataFormatString="?" DataType="System.String" HeaderText="Edit" UniqueName="ChangelogEditType" ></telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

</asp:Content>
