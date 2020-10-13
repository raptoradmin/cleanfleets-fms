<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="account_user_list_all.aspx.vb" Inherits="cleanfleets_fms.account_user_list_all" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<table cellpadding="0" cellspacing="0" style="width: 100%">
		<tr>
			<td style="padding: 5px; font-size: medium; color: #ED8701">
				<b>Account User List</b>
			</td>
		</tr>
	</table>
	<div>
	</div>
	<div>
		<telerik:radgrid id="RadGrid1" runat="server" allowsorting="True" datasourceid="sdsEmployeeList"
			gridlines="None" skin="Telerik" width="771px">
                    <mastertableview autogeneratecolumns="False" datasourceid="sdsEmployeeList">
                        <rowindicatorcolumn>
                            <HeaderStyle Width="20px" />
                        </rowindicatorcolumn>
                        <expandcollapsecolumn>
                            <HeaderStyle Width="20px" />
                        </expandcollapsecolumn>
                        <Columns>
                            <telerik:GridBoundColumn DataField="LastName" HeaderText="Last Name" 
                                SortExpression="LastName" UniqueName="LastName">
                                <ItemStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FirstName" HeaderText="First Name" 
                                SortExpression="FirstName" UniqueName="FirstName">
                                <ItemStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Email" HeaderText="Email" 
                                SortExpression="Email" UniqueName="Email">
                            </telerik:GridBoundColumn>
                            <telerik:GridHyperLinkColumn DataNavigateUrlFields="FirstName,IDProfileContact,IDProfileAccount" 
                                DataNavigateUrlFormatString="account_user_details.aspx?IDProfileContact={1}&IDProfileAccount={2}" 
                                DataTextField="IDProfileContact" DataTextFormatString="Details" 
                                Text="View" UniqueName="View" ItemStyle-HorizontalAlign="Right">
                                <ItemStyle Width="30px" />
                            </telerik:GridHyperLinkColumn>
                            <telerik:GridHyperLinkColumn DataNavigateUrlFields="IDProfileContact" 
                                DataNavigateUrlFormatString="account_user_del.aspx?IDProfileContact={0}" 
                                DataTextField="IDProfileContact" DataTextFormatString="Delete" Text="Delete" 
                                UniqueName="Delete" ItemStyle-HorizontalAlign="Right">
                                <ItemStyle CssClass="radgrid" />
                            </telerik:GridHyperLinkColumn>
                        </Columns>
                    </mastertableview>
                </telerik:radgrid>
	</div>
	<br />
	
	<asp:SqlDataSource ID="sdsEmployeeList" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [LastName], [FirstName], [Email], [IDProfileContact], [IDProfileAccount] FROM [CFV_Profile_Contact]">
		<SelectParameters>
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>

