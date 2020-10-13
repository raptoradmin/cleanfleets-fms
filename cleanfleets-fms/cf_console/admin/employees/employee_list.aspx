<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="employee_list.aspx.vb" Inherits="cleanfleets_fms.employee_list" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<table cellpadding="0" cellspacing="0" style="width: 100%">
		<tr>
			<td style="padding: 5px; font-size: medium; color: #ED8701">
				<b>Employee List</b>
			</td>
		</tr>
	</table>
	<div>
		<table cellpadding="0" cellspacing="0" style="padding: 5px; width: 100%; font-family: Arial, Helvetica, sans-serif;
			font-size: medium; font-weight: bold; text-align: right; color: #2C7500;">
			<tr>
				<td style="width: 80px; font-size: small;">
					&nbsp;
				</td>
				<td style="font-family: Arial, Helvetica, sans-serif; font-size: medium; font-weight: normal;
					text-align: left; color: #000000">
					&nbsp;
				</td>
			</tr>
		</table>
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
                            <telerik:GridHyperLinkColumn DataNavigateUrlFields="FirstName,IDProfileContact" 
                                DataNavigateUrlFormatString="employee_details.aspx?IDProfileContact={1}" 
                                DataTextField="IDProfileContact" DataTextFormatString="Details" 
                                Text="Details" UniqueName="Details" ItemStyle-HorizontalAlign="Right">
                                <ItemStyle Width="30px" />
                            </telerik:GridHyperLinkColumn>
                       <telerik:GridHyperLinkColumn DataNavigateUrlFields="IDProfileContact" 
                                DataNavigateUrlFormatString="employee_del.aspx?IDProfileContact={0}" 
                                DataTextField="IDProfileContact" DataTextFormatString="Delete" Text="Delete" 
                                UniqueName="Delete"  ItemStyle-HorizontalAlign="Right">
                                <ItemStyle CssClass="radgrid" />
                       </telerik:GridHyperLinkColumn>
                        </Columns>
                    </mastertableview>
                </telerik:radgrid>
	</div>
	<br />
	<asp:Button ID="btn_Add_Employee" runat="server" Text="Add Employee" />
	<br />
	<br />
	</td> </tr> </table>
	<asp:SqlDataSource ID="sdsEmployeeList" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [LastName], [FirstName], [Email], [IDProfileContact] FROM [CFV_Profile_Employee] ORDER BY [LastName]">
	</asp:SqlDataSource>
</asp:Content>

