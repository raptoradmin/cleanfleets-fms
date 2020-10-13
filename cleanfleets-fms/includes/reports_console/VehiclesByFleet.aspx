<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="VehiclesByFleet.aspx.vb" Inherits="cleanfleets_fms.VehiclesByFleet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="RightColumnContentPlaceHolder" runat="server">
                <div class="tablePageBodyRightColumn">
                <h1>Vehicles by Terminal and Fleet</h1>
                <p>&nbsp;</p>
                <telerik:RadComboBox ID="RadComboBox1" Runat="server" 
                    DataSourceID="sds_accounts" DataTextField="AccountName" 
                    DataValueField="IDProfileAccount" AutoPostBack="True">
                </telerik:RadComboBox>
                <p>&nbsp;</p>
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" 
                    DataSourceID="sds_Locations" GridLines="None">
<MasterTableView DataSourceID="sds_Locations" CommandItemDisplay="Top">
<CommandItemSettings ShowExportToCsvButton="True" />

   <GroupByExpressions>
     <telerik:GridGroupByExpression>
       <SelectFields>
         <telerik:GridGroupByField
           FieldAlias="IDProfileTerminal"
           FieldName="IDProfileTerminal" HeaderText=" " HeaderValueSeparator="&#149; " />
       </SelectFields>
       <GroupByFields>
         <telerik:GridGroupByField
           FieldAlias="IDProfileTerminal"
           FieldName="IDProfileTerminal" />
       </GroupByFields>
     </telerik:GridGroupByExpression>
   </GroupByExpressions>

<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
</MasterTableView>
                </telerik:RadGrid>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <br />
                
                

            </div>

    <asp:SqlDataSource ID="sds_CF_Menu_Console" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
        SelectCommand="SELECT [DataFieldID], [DataFieldParentID], [DataTextField], [DataNavigateUrlField], [ImageURL] FROM [CF_Menu_Console]">
    </asp:SqlDataSource>
    
    <telerik:RadFormDecorator ID="rfd_CleanFleets" Runat="server" Skin="Forest" />
    <%--<telerik:RadScriptManager ID="rsm_CleanFleets" Runat="server"></telerik:RadScriptManager>--%>
    

    
    <asp:SqlDataSource ID="sds_accounts" runat="server" 
    ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
    SelectCommand="SELECT [IDProfileAccount], [AccountName] FROM [CF_Profile_Account] ORDER BY [AccountName]">
</asp:SqlDataSource>
    

    
    <asp:SqlDataSource ID="sds_Locations" runat="server" 
    ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
    SelectCommand="SELECT [IDProfileTerminal], [TerminalName], [TerminalStreet], [TerminalCity], [TerminalState], [TerminalCounty], [TerminalZip], [TerminalTelephone1], [IDProfileFleet], [FleetName], [FleetStreet], [FleetCity], [FleetSate], [FleetCounty], [FleetZip], [FleetTelephone1] FROM [CFV_Report_Account_Locations] WHERE ([IDProfileAccount] = @IDProfileAccount)">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadComboBox1" DefaultValue="IDProfileAccount" 
                Name="IDProfileAccount" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
</asp:SqlDataSource>
</asp:Content>
