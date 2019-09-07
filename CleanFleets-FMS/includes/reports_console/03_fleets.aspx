<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="03_fleets.aspx.vb" Inherits="cleanfleets_fms._03_fleets" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<h1>
		Account Fleet Report</h1>
	<table cellpadding="0" cellspacing="0" class="tdtable" style="width: 100%">
		<tr>
			<td style="padding: 3px; width: 75px;">
				Accounts:
			</td>
			<td style="padding: 3px; text-align: left;">
				<asp:DropDownList ID="ddl_Accounts" runat="server" AutoPostBack="True">
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td style="padding: 3px; width: 75px;">
				Terminals:
			</td>
			<td style="padding: 3px; text-align: left;">
				<asp:DropDownList ID="ddl_Terminals" runat="server" AutoPostBack="True">
				</asp:DropDownList>
			</td>
		</tr>
	</table>
	<h1>
		Fleets</h1>
	<telerik:radgrid id="rg_Terminals" datasourceid="sds_Fleets" allowsorting="True"
		allowpaging="True" runat="server" gridlines="None" width="95%">
        <ExportSettings HideStructureColumns="true" ExportOnlyData="True" IgnorePaging="True" />
        <MasterTableView Width="100%" CommandItemDisplay="Top" AutoGenerateColumns="False" 
                           DataSourceID="sds_Fleets">
        

            <Columns>
                <telerik:GridBoundColumn DataField="IDProfileTerminal" DataType="System.Int32" 
                    DefaultInsertValue="" HeaderText="IDProfileTerminal" 
                    SortExpression="IDProfileTerminal" UniqueName="IDProfileTerminal">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="FleetName" DefaultInsertValue="" 
                    HeaderText="FleetName" SortExpression="FleetName" 
                    UniqueName="FleetName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RuleCode" DefaultInsertValue="" 
                    HeaderText="RuleCode" SortExpression="RuleCode" 
                    UniqueName="RuleCode" ReadOnly="True">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Address1" DefaultInsertValue="" 
                    HeaderText="Address1" SortExpression="Address1" UniqueName="Address1">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Address2" DefaultInsertValue="" 
                    HeaderText="Address2" SortExpression="Address2" UniqueName="Address2">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="City" DefaultInsertValue="" 
                    HeaderText="City" SortExpression="City" UniqueName="City">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="State" DefaultInsertValue="" 
                    HeaderText="State" SortExpression="State" UniqueName="State">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Zip" DefaultInsertValue="" HeaderText="Zip" 
                    SortExpression="Zip" UniqueName="Zip">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Telephone1" DefaultInsertValue="" 
                    HeaderText="Telephone1" SortExpression="Telephone1" UniqueName="Telephone1">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Ext1" DefaultInsertValue="" 
                    HeaderText="Ext1" SortExpression="Ext1" UniqueName="Ext1">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Telephone2" DefaultInsertValue="" 
                    HeaderText="Telephone2" SortExpression="Telephone2" UniqueName="Telephone2">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Ext2" DefaultInsertValue="" 
                    HeaderText="Ext2" SortExpression="Ext2" UniqueName="Ext2">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Telephone3" DefaultInsertValue="" 
                    HeaderText="Telephone3" SortExpression="Telephone3" UniqueName="Telephone3">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Ext3" DefaultInsertValue="" 
                    HeaderText="Ext3" SortExpression="Ext3" UniqueName="Ext3">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Fax1" DefaultInsertValue="" 
                    HeaderText="Fax1" SortExpression="Fax1" UniqueName="Fax1">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Fax2" DefaultInsertValue="" 
                    HeaderText="Fax2" SortExpression="Fax2" UniqueName="Fax2">
                </telerik:GridBoundColumn>
            </Columns>
            <PagerStyle Mode="NextPrevNumericAndAdvanced" />
            <CommandItemSettings  ShowExportToExcelButton="true" 
                ShowAddNewRecordButton="False"/>
        </MasterTableView>
    </telerik:radgrid>
	<p>
		&nbsp;</p>
	<asp:SqlDataSource ID="sds_Fleets" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDProfileTerminal], [FleetName], [RuleCode], [Address1], [Address2], [City], [State], [Zip], [Telephone1], [Ext1], [Telephone2], [Ext2], [Telephone3], [Ext3], [Fax1], [Fax2] FROM [CFV_Profile_Fleet] WHERE ([IDProfileTerminal] = @IDProfileTerminal) ORDER BY [FleetName]">
		<SelectParameters>
			<asp:ControlParameter ControlID="ddl_Terminals" Name="IDProfileTerminal" PropertyName="SelectedValue"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>

