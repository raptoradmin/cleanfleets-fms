<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="quick_estimate.aspx.vb" Inherits="cleanfleets_fms.quick_estimate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <p style="color: #8EA3B9; font-size: large; font-family: Arial, Helvetica, sans-serif">
        Basic Cost Estimate Report</p>
    <p>
        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sds_accounts" DataTextField="AccountName" DataValueField="IDProfileAccount" AutoPostBack="True">
        </asp:DropDownList>
    </p>
    <p>
        &nbsp;</p>
    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="sds_Report" GridLines="None" ShowFooter="True" Skin="WebBlue">
<MasterTableView AutoGenerateColumns="False" Groupsdefaultexpanded="false" DataKeyNames="IDProfileAccount" DataSourceID="sds_Report"  ShowGroupFooter="true">


 <GroupByExpressions>
     <telerik:GridGroupByExpression>
       <SelectFields>
         <telerik:GridGroupByField
           FieldAlias="Year"
           FieldName="Year" HeaderText=" " HeaderValueSeparator="&#149; " />
       </SelectFields>
       <GroupByFields>
         <telerik:GridGroupByField
           FieldAlias="Year"
           FieldName="Year" />
       </GroupByFields>
     </telerik:GridGroupByExpression>
   </GroupByExpressions>





<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <telerik:GridBoundColumn DataField="AccountName" DefaultInsertValue="" HeaderText="AccountName" SortExpression="AccountName" UniqueName="AccountName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="TerminalName" DefaultInsertValue="" HeaderText="TerminalName" SortExpression="TerminalName" UniqueName="TerminalName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="FleetName" DefaultInsertValue="" HeaderText="FleetName" SortExpression="FleetName" UniqueName="FleetName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="UnitNo" DefaultInsertValue="" HeaderText="UnitNo" SortExpression="UnitNo" UniqueName="UnitNo">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="LicensePlateNo" DefaultInsertValue="" HeaderText="LicensePlateNo" SortExpression="LicensePlateNo" UniqueName="LicensePlateNo">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Year" DefaultInsertValue="" HeaderText="Year" ReadOnly="True" SortExpression="Year" UniqueName="Year">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="EstReplacementCost" DataType="System.Decimal" DefaultInsertValue="" HeaderText="EstReplacementCost" SortExpression="EstReplacementCost" UniqueName="EstReplacementCost" DataFormatString="{0:c2}" Aggregate="Sum">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="EstRetrofitCost" DataType="System.Decimal" DefaultInsertValue="" HeaderText="EstRetrofitCost" SortExpression="EstRetrofitCost" UniqueName="EstRetrofitCost" DataFormatString="{0:c2}" Aggregate="Sum">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="IDProfileAccount" DataType="System.Int32" DefaultInsertValue="" HeaderText="IDProfileAccount" ReadOnly="True" SortExpression="IDProfileAccount" UniqueName="IDProfileAccount">
        </telerik:GridBoundColumn>
    </Columns>
</MasterTableView>
    </telerik:RadGrid>
    <p>
        &nbsp;</p>
    <telerik:RadScriptManager ID="RadScriptManager1" Runat="server">
    </telerik:RadScriptManager>
    <p>
        <asp:SqlDataSource ID="sds_accounts" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" SelectCommand="SELECT [IDProfileAccount], [AccountName] FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sds_Report" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" SelectCommand="SELECT [AccountName], [TerminalName], [FleetName], [UnitNo], [LicensePlateNo], [Year], [EstReplacementCost], [EstRetrofitCost], [IDProfileAccount] FROM [CFV_Report_Quick_Estimate] WHERE ([IDProfileAccount] = @IDProfileAccount) ORDER BY [Year]">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="IDProfileAccount" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    </form>
</body>
</html>
