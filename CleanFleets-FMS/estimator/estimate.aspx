<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="estimate.aspx.vb" Inherits="cleanfleets_fms.estimate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="RightColumnContentPlaceHolder" runat="server">
 <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td style="padding: 5px; width: 160px; background-color: #CDD8E0; vertical-align: top;">
                <br />
                <br />
                <br />
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/estimator/Default.aspx">Estimates</asp:HyperLink>
                <br />
                <br />
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/estimator/estimate_add.aspx">New Estimate</asp:HyperLink>
            </td>
            <td style="padding: 5px; background-color: #FFFFFF;">
                <table cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                        <td style="padding: 5px; background-color: #FFFFFF;">
                            <h3>
                                Quick Estimate System - Estimate</h3>
                        </td>
                    </tr>
                </table>
                <br />
    <table cellpadding="3" cellspacing="0" style="width: 100%">
        <tr>
            <td class="tbltld" style="width: 150px">
                Account Name:</td>
            <td>
        <asp:Label ID="lbl_AccountName" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="sds_GVW_14" GridLines="None" ShowFooter="True" Skin="WebBlue" Width="500px">
<MasterTableView AutoGenerateColumns="False" DataSourceID="sds_GVW_14">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <telerik:GridBoundColumn DataField="GrossVehicleWeight" DefaultInsertValue="" HeaderText="GVW" ReadOnly="True" SortExpression="GrossVehicleWeight" UniqueName="GrossVehicleWeight">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Year" DefaultInsertValue="" HeaderText="Year" ReadOnly="True" SortExpression="Year" UniqueName="Year">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="QuantityVehicles" DataType="System.Int32" DefaultInsertValue="" HeaderText="# Vehicles" SortExpression="QuantityVehicles" UniqueName="QuantityVehicles" ItemStyle-Width="75px">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="ReplacementCost" DataType="System.Decimal" DefaultInsertValue="" HeaderText="Replacement Cost" SortExpression="ReplacementCost" UniqueName="ReplacementCost" DataFormatString="{0:c2}" Aggregate="Sum" ItemStyle-Width="100px">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="RetrofitCost" DataType="System.Decimal" DefaultInsertValue="" HeaderText="Retrofit Cost" SortExpression="RetrofitCost" UniqueName="RetrofitCost" DataFormatString="{0:c2}" Aggregate="Sum" ItemStyle-Width="100px">
        </telerik:GridBoundColumn>
    </Columns>
</MasterTableView>
    </telerik:RadGrid>
    <p>
        &nbsp;</p>
    <telerik:RadGrid ID="RadGrid2" runat="server" DataSourceID="sds_GVW_26" GridLines="None" ShowFooter="True" Skin="WebBlue" Width="500px">
<MasterTableView AutoGenerateColumns="False" DataSourceID="sds_GVW_26">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <telerik:GridBoundColumn DataField="GrossVehicleWeight" DefaultInsertValue="" HeaderText="GVW" ReadOnly="True" SortExpression="GrossVehicleWeight" UniqueName="GrossVehicleWeight">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Year" DefaultInsertValue="" HeaderText="Year" ReadOnly="True" SortExpression="Year" UniqueName="Year">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="QuantityVehicles" DataType="System.Int32" DefaultInsertValue="" HeaderText="# Vehicles" SortExpression="QuantityVehicles" UniqueName="QuantityVehicles" ItemStyle-Width="75px">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="ReplacementCost" DataType="System.Decimal" DefaultInsertValue="" HeaderText="Replacement Cost" SortExpression="ReplacementCost" UniqueName="ReplacementCost" DataFormatString="{0:c2}" Aggregate="Sum" ItemStyle-Width="100px">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="RetrofitCost" DataType="System.Decimal" DefaultInsertValue="" HeaderText="Retrofit Cost" SortExpression="RetrofitCost" UniqueName="RetrofitCost" DataFormatString="{0:c2}" Aggregate="Sum" ItemStyle-Width="100px">
        </telerik:GridBoundColumn>
    </Columns>
</MasterTableView>
    </telerik:RadGrid>
    <p>
        &nbsp;</p>
    <telerik:RadGrid ID="RadGrid3" runat="server" DataSourceID="sds_Totals" GridLines="None" Skin="WebBlue" Width="500px">
<MasterTableView AutoGenerateColumns="False" DataSourceID="sds_Totals">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <telerik:GridTemplateColumn DefaultInsertValue="" UniqueName="TemplateColumn">
            
        </telerik:GridTemplateColumn>
        <telerik:GridBoundColumn DataField="ReplacementCost" DataType="System.Decimal" DefaultInsertValue="" HeaderText="Replacement Cost" SortExpression="ReplacementCost" UniqueName="ReplacementCost" DataFormatString="{0:c2}" ItemStyle-Width="100px">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="RetrofitCost" DataType="System.Decimal" DefaultInsertValue="" HeaderText="Retrofit Cost" SortExpression="RetrofitCost" UniqueName="RetrofitCost" DataFormatString="{0:c2}" ItemStyle-Width="100px">
        </telerik:GridBoundColumn>
    </Columns>
</MasterTableView>
    </telerik:RadGrid>
                <p>
                    &nbsp;</p>
            </td>
        </tr>
    </table>
    <p>
        &nbsp;</p>
    <p>
        <telerik:RadScriptManager ID="RadScriptManager1" Runat="server">
        </telerik:RadScriptManager>
    </p>
    <p>
        <asp:SqlDataSource ID="sds_QE_Account" runat="server"></asp:SqlDataSource>
    </p>
    <p>
        <asp:SqlDataSource ID="sds_GVW" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT [IDOptionList], [DisplayValue] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
            <SelectParameters>
                <asp:Parameter DefaultValue="GrossVehicleWeight" Name="OptionName" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <asp:SqlDataSource ID="sds_Year" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
    SelectCommand="SELECT [IDOptionList], [DisplayValue] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
        <SelectParameters>
            <asp:Parameter DefaultValue="Year" Name="OptionName" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <p>
        <asp:SqlDataSource ID="sds_GVW_14" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT [GrossVehicleWeight], [Year], [QuantityVehicles], [ReplacementCost], [RetrofitCost] FROM [CFV_QE_Estimate] WHERE (([IDQEAccount] = @IDQEAccount) AND ([IDGrossVehicleWeight] = @IDGrossVehicleWeight)) ORDER BY [Year]">
            <SelectParameters>
                <asp:QueryStringParameter Name="IDQEAccount" QueryStringField="IDAccount" Type="Int32" />
                <asp:Parameter DefaultValue="528" Name="IDGrossVehicleWeight" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <asp:SqlDataSource ID="sds_GVW_26" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
    SelectCommand="SELECT [GrossVehicleWeight], [Year], [QuantityVehicles], [ReplacementCost], [RetrofitCost] FROM [CFV_QE_Estimate] WHERE (([IDQEAccount] = @IDQEAccount) AND ([IDGrossVehicleWeight] = @IDGrossVehicleWeight)) ORDER BY [Year]">
        <SelectParameters>
            <asp:QueryStringParameter Name="IDQEAccount" QueryStringField="IDAccount" Type="Int32" />
            <asp:Parameter DefaultValue="529" Name="IDGrossVehicleWeight" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <p>
        <asp:SqlDataSource ID="sds_Totals" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT [ReplacementCost], [RetrofitCost] FROM [CFV_QE_Estimate_Totals] WHERE ([IDQEAccount] = @IDQEAccount)">
            <SelectParameters>
                <asp:QueryStringParameter Name="IDQEAccount" QueryStringField="IDAccount" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <telerik:RadFormDecorator ID="RadFormDecorator1" Runat="server" DecoratedControls="All" Skin="WebBlue" />
    </p>
</asp:Content>
