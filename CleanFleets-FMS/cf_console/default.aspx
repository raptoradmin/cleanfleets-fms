<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="default.aspx.vb" Inherits="cleanfleets_fms._default1" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
        #form1 {
            text-align: left;
        }
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
    <table style="width: 650px" class="tablecenter">
        <tr>
            <td style="text-align: center;" colspan="5">
                <h5>Welcome to the Fleet Compliance Management System</h5>
                <p class="greendark">
                    <b>Administration Console</b>
                </p>
                <p class="greendark">
                    &nbsp;
                </p>
            </td>
        </tr>
        <tr>
            <td style="text-align: center; width: 150px;">
                <telerik:RadGrid ID="RadGrid4" runat="server" DataSourceID="sds_Users" Font-Bold="False"
                    Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                    GridLines="None" HorizontalAlign="Center" Skin="Default" Width="110px" CssClass="tablecenter">
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="sds_Users">
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>

                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridBoundColumn DataField="Column1" DataType="System.Int32"
                                DefaultInsertValue="" HeaderText="Total Users" ReadOnly="True"
                                SortExpression="Total Users" UniqueName="Users">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <HeaderStyle HorizontalAlign="Center" />
                </telerik:RadGrid>
            </td>
            <td style="text-align: center; width: 150px;">
                <telerik:RadGrid ID="RadGrid5" runat="server" DataSourceID="sds_Employees" Font-Bold="False"
                    Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                    GridLines="None" HorizontalAlign="Center" Skin="Default" Width="110px" CssClass="tablecenter">
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="sds_Employees">
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>

                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridBoundColumn DataField="Column1" DataType="System.Int32"
                                DefaultInsertValue="" HeaderText="Total Employees" ReadOnly="True"
                                SortExpression="Total Employees" UniqueName="Employees">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <HeaderStyle HorizontalAlign="Center" />
                </telerik:RadGrid>
            </td>
            <td style="text-align: center; width: 150px;">
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="sds_Profile_Account"
                    Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" GridLines="None" HorizontalAlign="Center" Skin="Default"
                    Width="110px" CssClass="tablecenter">
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="sds_Profile_Account">
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>

                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridBoundColumn DataField="Column1" DataType="System.Int32"
                                DefaultInsertValue="" HeaderText="Total Accounts" ReadOnly="True"
                                SortExpression="Total Accounts" UniqueName="Accounts">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <HeaderStyle HorizontalAlign="Center" />
                </telerik:RadGrid>
            </td>
            <td style="width: 150px; text-align: center;">
                <telerik:RadGrid ID="RadGrid2" runat="server" DataSourceID="sds_Profile_Terminal"
                    Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" GridLines="None" HorizontalAlign="Center" Skin="Default"
                    Width="110px" CssClass="tablecenter">
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="sds_Profile_Terminal">
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>

                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridBoundColumn DataField="Column1" DataType="System.Int32"
                                DefaultInsertValue="" HeaderText="Total Terminals" ReadOnly="True"
                                SortExpression="Total Terminals" UniqueName="Terminals">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <HeaderStyle HorizontalAlign="Center" />
                </telerik:RadGrid>
            </td>
            <td style="width: 150px; text-align: center;">
                <telerik:RadGrid ID="RadGrid3" runat="server" DataSourceID="sds_Profile_Fleet" Font-Bold="False"
                    Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                    GridLines="None" HorizontalAlign="Center" Skin="Default" Width="110px" CssClass="tablecenter">
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="sds_Profile_Fleet">
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>

                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridBoundColumn DataField="Column1" DataType="System.Int32"
                                DefaultInsertValue="" HeaderText="Total Fleets" ReadOnly="True"
                                SortExpression="Total Fleets" UniqueName="Fleets">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <HeaderStyle HorizontalAlign="Center" />
                </telerik:RadGrid>
            </td>
            <td style="width: 150px; text-align: center;">
                <telerik:RadGrid ID="RadGrid6" runat="server" DataSourceID="sds_Vehicles" Font-Bold="False"
                    Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                    GridLines="None" HorizontalAlign="Center" Skin="Default" Width="110px" CssClass="tablecenter">
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="sds_Vehicles">
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>

                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridBoundColumn DataField="Column1" DataType="System.Int32"
                                DefaultInsertValue="" HeaderText="Total Vehicles" ReadOnly="True"
                                SortExpression="Total Vehicles" UniqueName="Vehicles">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <HeaderStyle HorizontalAlign="Center" />
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td style="width: 150px; text-align: center;">&nbsp;
            </td>
            <td style="width: 150px; text-align: center;">&nbsp;
            </td>
            <td style="width: 150px; text-align: center;">&nbsp;
            </td>
            <td style="width: 150px; text-align: center;">&nbsp;
            </td>
            <td style="width: 150px; text-align: center;">&nbsp;
            </td>
            <td style="width: 150px; text-align: center;">&nbsp;
            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="sds_Profile_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT count (*) FROM [CF_Profile_Account]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sds_Profile_Terminal" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT count (*) FROM [CF_Profile_Terminal]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sds_Profile_Fleet" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT count (*) FROM [CF_Profile_Fleet]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sds_Users" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT count (*) FROM [CFV_Profile_Contact]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sds_Employees" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT count (*) FROM [CFV_Profile_Employee]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sds_Vehicles" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
        SelectCommand="SELECT count (*) FROM [CFV_Vehicles]"></asp:SqlDataSource>
</asp:Content>
