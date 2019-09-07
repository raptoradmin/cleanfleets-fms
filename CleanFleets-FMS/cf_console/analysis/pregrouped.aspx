<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="pregrouped.aspx.vb" Inherits="cleanfleets_fms.pregrouped" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="RightColumnContentPlaceHolder" runat="server">
    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" 
        GridLines="None" ShowGroupPanel="True">
<MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
         <GroupByExpressions>  
                   <telerik:GridGroupByExpression>  
                     <GroupByFields>  
                      <telerik:GridGroupByField FieldName="AccountName" FieldAlias="AccountName" />  
                     </GroupByFields>
                     <SelectFields>  
                      <telerik:GridGroupByField  FieldName="AccountName" FieldAlias="AccountName" />  
                     </SelectFields>  
                      <GroupByFields>  
                      <telerik:GridGroupByField FieldName="TerminalName" FieldAlias="TerminalName" />  
                     </GroupByFields>
                     <SelectFields>  
                      <telerik:GridGroupByField  FieldName="TerminalName" FieldAlias="TerminalName" />  
                     </SelectFields> 
                      <GroupByFields>  
                      <telerik:GridGroupByField FieldName="FleetName" FieldAlias="FleetName" />  
                     </GroupByFields>
                     <SelectFields>  
                      <telerik:GridGroupByField  FieldName="FleetName" FieldAlias="FleetName" />  
                     </SelectFields> 
                   </telerik:GridGroupByExpression>  
                 </GroupByExpressions>  
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <telerik:GridBoundColumn DataField="AccountName" DefaultInsertValue="" 
            HeaderText="AccountName" SortExpression="AccountName" UniqueName="AccountName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="TerminalName" DefaultInsertValue="" 
            HeaderText="TerminalName" SortExpression="TerminalName" 
            UniqueName="TerminalName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="FleetName" DefaultInsertValue="" 
            HeaderText="FleetName" SortExpression="FleetName" UniqueName="FleetName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="UnitNo" DefaultInsertValue="" 
            HeaderText="UnitNo" SortExpression="UnitNo" UniqueName="UnitNo">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="LicensePlateNo" DefaultInsertValue="" 
            HeaderText="LicensePlateNo" SortExpression="LicensePlateNo" 
            UniqueName="LicensePlateNo">
        </telerik:GridBoundColumn>
    </Columns>
</MasterTableView>
        <ClientSettings AllowDragToGroup="True">
        </ClientSettings>
        
    </telerik:RadGrid>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
        SelectCommand="SELECT [AccountName], [TerminalName], [FleetName], [UnitNo], [LicensePlateNo] FROM [CFV_Vehicles_by_Account] ORDER BY [AccountName]">
    </asp:SqlDataSource>
    <telerik:RadScriptManager ID="RadScriptManager1" Runat="server">
    </telerik:RadScriptManager>
</asp:Content>
