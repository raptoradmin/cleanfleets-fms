<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="02_terminals.aspx.vb" Inherits="cleanfleets_fms._02_terminals" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<h1>
		Account Terminal Report</h1>
	<table cellpadding="0" cellspacing="0" class="tdtable" style="width: 100%">
		<tr>
			<td style="padding: 3px; width: 75px;">
				Accounts:
			</td>
			<td style="padding: 3px; text-align: left;">
				<asp:DropDownList ID="ddl_Accounts" runat="server" DataSourceID="sds_Accounts" DataTextField="AccountName"
					DataValueField="IDProfileAccount" AppendDataBoundItems="True" AutoPostBack="True">
					<asp:ListItem Text="Select" Value="0" />
				</asp:DropDownList>
			</td>
		</tr>
	</table>
	<h1>
		Terminals</h1>
	<telerik:radgrid id="rg_Terminals" datasourceid="sds_Terminals" allowsorting="True"
		allowpaging="True" runat="server" gridlines="None">
        <ExportSettings HideStructureColumns="true" ExportOnlyData="True" IgnorePaging="True" />
        <MasterTableView Width="100%" CommandItemDisplay="Top" AutoGenerateColumns="False">
            <Columns>
                <telerik:GridBoundColumn DataField="AccountName" DefaultInsertValue="" 
                    HeaderText="AccountName" ReadOnly="True" SortExpression="AccountName" 
                    UniqueName="AccountName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TerminalName" DefaultInsertValue="" 
                    HeaderText="TerminalName" SortExpression="TerminalName" 
                    UniqueName="TerminalName">
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
            <CommandItemSettings ShowExportToExcelButton="true" 
                ShowAddNewRecordButton="False"/>
        </MasterTableView>
    </telerik:radgrid>
	<p>
		&nbsp;</p>
	<asp:SqlDataSource ID="sds_Accounts" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDProfileAccount], [AccountName] FROM [CFV_Accounts] ORDER BY [AccountName]">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Terminals" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [AccountName], [TerminalName], [Address1], [Address2], [City], [State], [Zip], [Telephone1], [Ext1], [Telephone2], [Ext2], [Telephone3], [Ext3], [Fax1], [Fax2] FROM [CFV_Profile_Terminal] WHERE ([IDProfileAccount] = @IDProfileAccount) ORDER BY [TerminalName]">
		<SelectParameters>
			<asp:ControlParameter ControlID="ddl_Accounts" Name="IDProfileAccount" PropertyName="SelectedValue"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>
