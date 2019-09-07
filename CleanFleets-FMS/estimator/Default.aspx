<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="Default.aspx.vb" Inherits="cleanfleets_fms._Default8" %>
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
                                Quick Estimate System</h3>
                        </td>
                    </tr>
                </table>
                <br />
    <h3>
        Existing Estimates</h3>
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="sds_Accounts" GridLines="None" Skin="WebBlue" Width="400px">
<MasterTableView AutoGenerateColumns="False" DataSourceID="sds_Accounts">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <telerik:GridBoundColumn DataField="AccountName" DefaultInsertValue="" HeaderText="Account" SortExpression="AccountName" UniqueName="AccountName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="ReplacementCost" DataType="System.Decimal" DefaultInsertValue="" HeaderText="Replacement Cost" SortExpression="ReplacementCost" UniqueName="ReplacementCost" DataFormatString="{0:c2}" >
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="RetrofitCost" DataType="System.Decimal" DefaultInsertValue="" HeaderText="Retrofit Cost" SortExpression="RetrofitCost" UniqueName="RetrofitCost" DataFormatString="{0:c2}" >
        </telerik:GridBoundColumn>
        <telerik:GridHyperLinkColumn
                DataNavigateUrlFields="IDQEAccount" 
                DataNavigateUrlFormatString="estimate.aspx?IDAccount={0}" 
                Text="Estimate" 
                UniqueName="IDQEAccount">
            <ItemStyle CssClass="radgrid" Width="50px"></ItemStyle>
        </telerik:GridHyperLinkColumn>
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
        <telerik:RadFormDecorator ID="RadFormDecorator1" Runat="server" DecoratedControls="All" Skin="WebBlue" />
    </p>
    <p>
        <asp:SqlDataSource ID="sds_Accounts" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" SelectCommand="SELECT [IDQEAccount], [AccountName], [ReplacementCost], [RetrofitCost] FROM [CFV_QE_Estimate_Totals] ORDER BY [AccountName]"></asp:SqlDataSource>
    </p>
</asp:Content>
