<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="account_list.aspx.vb" Inherits="cleanfleets_fms.account_list" %>

<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
    <table cellpadding="0" cellspacing="0" style="width: 100%; height: 30px">
        <tr>
            <td>
                <span style="font-size: large; font-weight: bold; color: #2C7500">Account List</span>
            </td>
        </tr>
    </table>
    <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" DataSourceID="sds_Account_Profile"
        GridLines="None" Width="771px" Skin="Telerik">
        <MasterTableView AutoGenerateColumns="False" DataSourceID="sds_Account_Profile"
            DataKeyNames="IDProfileAccount">
            <RowIndicatorColumn>
                <HeaderStyle Width="20px" />
            </RowIndicatorColumn>
            <ExpandCollapseColumn>
                <HeaderStyle Width="20px" />
            </ExpandCollapseColumn>
            <Columns>
                <telerik:GridBoundColumn DataField="AccountName" HeaderText="AccountName"
                    SortExpression="AccountName" UniqueName="AccountName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Telephone1" HeaderText="Telephone"
                    SortExpression="Telephone1" UniqueName="Telephone1" DataFormatString="{0:(###) ###-####}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Ext1" DefaultInsertValue=""
                    HeaderText="Ext" SortExpression="Ext1" UniqueName="Ext1">
                </telerik:GridBoundColumn>
                <telerik:GridHyperLinkColumn
                    DataNavigateUrlFields="AcccountName,IDProfileAccount"
                    DataNavigateUrlFormatString="account_details.aspx?IDProfileAccount={1}"
                    DataTextField="IDProfileAccount" DataTextFormatString="Details" Text="Details"
                    UniqueName="AccountProfile">
                    <ItemStyle CssClass="radgrid" Width="50px"></ItemStyle>
                </telerik:GridHyperLinkColumn>
                <telerik:GridHyperLinkColumn
                    DataNavigateUrlFields="AcccountName,IDProfileAccount"
                    DataNavigateUrlFormatString="account_user_list.aspx?IDProfileAccount={1}"
                    DataTextField="IDProfileAccount" DataTextFormatString="Users" Text="Users"
                    UniqueName="Users">
                    <ItemStyle CssClass="radgrid" Width="50px"></ItemStyle>
                </telerik:GridHyperLinkColumn>
                <telerik:GridHyperLinkColumn
                    DataNavigateUrlFields="AcccountName,IDProfileAccount"
                    DataNavigateUrlFormatString="01_terminals/terminal.aspx?IDProfileAccount={1}"
                    DataTextField="IDProfileAccount" DataTextFormatString="Terminals" Text="Terminals"
                    UniqueName="Terminals">
                    <ItemStyle CssClass="radgrid" Width="50px"></ItemStyle>
                </telerik:GridHyperLinkColumn>

            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sds_Account_Profile" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT [IDProfileAccount], [AccountName], CAST(Telephone1 AS bigint)as Telephone1, [Ext1], [Email], [WebSite] FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>
</asp:Content>

