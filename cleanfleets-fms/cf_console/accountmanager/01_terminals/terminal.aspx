<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="terminal.aspx.vb" Inherits="cleanfleets_fms.terminal1" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<asp:FormView ID="fv_BreadCrumb" runat="server" DataKeyNames="IDProfileAccount,IDProfileTerminal,IDProfileFleet"
		DataSourceID="sds_CFV_Fleet_Lineage" Width="800px">
		<EditItemTemplate>
		</EditItemTemplate>
		<InsertItemTemplate>
		</InsertItemTemplate>
		<ItemTemplate>
			<span style="font-size: medium; font-weight: bold; color: #2C7500">Account:</span>&nbsp;<asp:HyperLink
				ID="hl_AcoountDetails" runat="server" NavigateUrl='<%# Eval("IDProfileAccount", "../account_details.aspx?IDProfileAccount={0}") & "&IDProfileTerminal=" & Eval("IDProfileTerminal") %>'
				Text='<%# Eval("AccountName") %>'></asp:HyperLink>
		</ItemTemplate>
	</asp:FormView>
	<table style="width: 780px">
		<tr>
			<td>
				<asp:FormView ID="FormView1" runat="server" DataKeyNames="IDProfileAccount" DataSourceID="sds_Profile_Account"
					Font-Bold="False" Style="font-size: medium">
					<EditItemTemplate>
						IDProfileAccount:
						<asp:Label ID="IDProfileAccountLabel1" runat="server" Text='<%# Eval("IDProfileAccount") %>' />
						<br />
						AccountName:
						<asp:TextBox ID="AccountNameTextBox" runat="server" Text='<%# Bind("AccountName") %>' />
						<br />
						<asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
							Text="Update" />
						&nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False"
							CommandName="Cancel" Text="Cancel" />
					</EditItemTemplate>
					<InsertItemTemplate>
						AccountName:
						<asp:TextBox ID="AccountNameTextBox" runat="server" Text='<%# Bind("AccountName") %>' />
						<br />
						<asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
							Text="Insert" />
						&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False"
							CommandName="Cancel" Text="Cancel" />
					</InsertItemTemplate>
					<ItemTemplate>
						<table cellpadding="0" cellspacing="0" style="width: 100%">
							<tr>
								<td>
									<asp:Label ID="lbl_AccountName" runat="server" Text='<%# Bind("AccountName") %>'
										Font-Bold="True" Font-Size="Large" ForeColor="#2C7500" />
								</td>
								<td>
									<asp:Label ID="lbl_IDProfileAccount" runat="server" Style="font-size: xx-small; color: #FFFFFF"
										Text='<%# Eval("IDProfileAccount") %>' />
								</td>
							</tr>
						</table>
					</ItemTemplate>
				</asp:FormView>
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" style="width: 100%; height: 30px;">
		<tr>
			<td style="font-family: Arial, Helvetica, sans-serif; font-size: medium; font-weight: bold;
				color: #ED8701">
				Terminal List
			</td>
		</tr>
	</table>
	<telerik:radgrid id="rg_Terminal_List" runat="server" allowsorting="True" datasourceid="sds_Profile_Terminal"
		gridlines="None" skin="Telerik" width="780px" cssclass="radgrid">
                    <mastertableview autogeneratecolumns="False" datasourceid="sds_Profile_Terminal" 
                        datakeynames="IDProfileTerminal" 
                        nomasterrecordstext="This Account has no Terminals assigned.">
                        <rowindicatorcolumn>
                            <HeaderStyle Width="20px" />
                        </rowindicatorcolumn>
                        <expandcollapsecolumn>
                            <HeaderStyle Width="20px" />
                        </expandcollapsecolumn>
                        <Columns>

                             <telerik:GridBoundColumn DataField="TerminalName" HeaderText="Terminal Name" 
                                SortExpression="TerminalName" UniqueName="TerminalName">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Telephone1" HeaderText="Telephone" 
                                SortExpression="Telephone1" UniqueName="Telephone1" DataFormatString="{0:(###) ###-####}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Ext1" DefaultInsertValue="" 
                                HeaderText="Ext" SortExpression="Ext1" UniqueName="Ext1">
                            </telerik:GridBoundColumn>
                            <telerik:GridHyperLinkColumn DataNavigateUrlFields="Website" HeaderText="Website" 
                                UniqueName="Website" DataTextField="Website" Target="Blank">
                            </telerik:GridHyperLinkColumn>
                            <telerik:GridBoundColumn DataField="City" DefaultInsertValue="" 
                                HeaderText="City" UniqueName="column">
                            </telerik:GridBoundColumn>
                            <telerik:GridHyperLinkColumn DataNavigateUrlFields="TerminalName,IDProfileTerminal,IDProfileAccount" 
                                DataNavigateUrlFormatString="TerminalDetails.aspx?IDProfileTerminal={1}&IDProfileAccount={2}" 
                                DataTextField="IDProfileTerminal" DataTextFormatString="Details" Text="Details" 
                                UniqueName="Details">
                                <ItemStyle CssClass="radgrid" Width="50px"></ItemStyle>
                            </telerik:GridHyperLinkColumn>
                            <telerik:GridHyperLinkColumn
                                DataNavigateUrlFields="TerminalName,IDProfileTerminal,IDProfileAccount" 
                                DataNavigateUrlFormatString="../02_fleets/fleet.aspx?IDProfileTerminal={1}&IDProfileAccount={2}" 
                                DataTextField="IDProfileTerminal" DataTextFormatString="Fleets" Text="Fleets" 
                                UniqueName="Fleets">
                                <ItemStyle CssClass="radgrid" Width="50px"></ItemStyle>
                            </telerik:GridHyperLinkColumn>
                        </Columns>
                    </mastertableview>
                </telerik:radgrid>
	<br />
	<asp:Button ID="btn_Add_Terminal" runat="server" Text="Add Terminal" />
	<asp:SqlDataSource ID="sds_CF_Menu_Console" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [DataFieldID], [DataFieldParentID], [DataTextField], [DataNavigateUrlField], [ImageURL] FROM [CF_Menu_Console]">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_CFV_Fleet_Lineage" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDProfileAccount], [AccountName], [IDProfileTerminal], [TerminalName], [IDProfileFleet], [FleetName] FROM [CFV_Fleet_Lineage] WHERE ([IDProfileAccount] = @IDProfileAccount)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Profile_Terminal" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDProfileTerminal], [TerminalName], [IDProfileAccount], [AccountName], [City], CAST(Telephone1 AS bigint)as Telephone1, [Ext1] FROM [CFV_Profile_Terminal] WHERE ([IDProfileAccount] = @IDProfileAccount) ORDER BY TerminalName">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Profile_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDProfileAccount], [AccountName] FROM [CF_Profile_Account] WHERE ([IDProfileAccount] = @IDProfileAccount)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>

