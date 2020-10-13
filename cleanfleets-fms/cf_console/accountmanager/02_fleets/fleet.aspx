<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="fleet.aspx.vb" Inherits="cleanfleets_fms.fleet1" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<asp:FormView ID="FormView2" runat="server" DataKeyNames="IDProfileAccount,IDProfileTerminal,IDProfileFleet"
		DataSourceID="sds_CFV_Fleet_Lineage" Width="800px">
		<EditItemTemplate>
		</EditItemTemplate>
		<InsertItemTemplate>
		</InsertItemTemplate>
		<ItemTemplate>
			<span style="font-size: medium; font-weight: bold; color: #2C7500">Account:</span>&nbsp;<asp:HyperLink
				ID="hl_AcoountDetails" runat="server" NavigateUrl='<%# Eval("IDProfileAccount", "../account_details.aspx?IDProfileAccount={0}") & "&IDProfileTerminal=" & Eval("IDProfileTerminal") %>'
				Text='<%# Eval("AccountName") %>'></asp:HyperLink>
			&nbsp;<span style="font-size: medium; font-weight: bold; color: #2C7500">Terminal:</span>&nbsp;<asp:HyperLink
				ID="hl_TerminalDetails" runat="server" NavigateUrl='<%# Eval("IDProfileTerminal", "../01_terminals/terminal.aspx?IDProfileTerminal={0}") & "&IDProfileAccount=" & Eval("IDProfileAccount") %>'
				Text='<%# Eval("TerminalName") %>'></asp:HyperLink>
		</ItemTemplate>
	</asp:FormView>
	<table style="width: 780px">
		<tr>
			<td>
				<asp:FormView ID="FormView1" runat="server" DataKeyNames="IDProfileAccount" DataSourceID="sds_Profile_Terminal"
					Font-Bold="False" Style="font-size: medium">
					<EditItemTemplate>
					</EditItemTemplate>
					<InsertItemTemplate>
					</InsertItemTemplate>
					<ItemTemplate>
						<table cellpadding="0" cellspacing="0" style="width: 100%">
							<tr>
								<td>
									<asp:Label ID="lbl_TerminalName" runat="server" Text='<%# Bind("TerminalName") %>'
										Font-Bold="True" Font-Size="Large" ForeColor="#2C7500" />
								</td>
								<td>
									<asp:Label ID="lbl_IDProfileTerminal" runat="server" Style="font-size: xx-small;
										color: #FFFFFF" Text='<%# Eval("IDProfileTerminal") %>' />
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
		<tr>
			<td style="font-size: medium; color: #ED8701">
				<b>Fleet List</b>
			</td>
		</tr>
	</table>
	<telerik:radgrid id="RadGrid1" runat="server" datasourceid="sds_Profile_Fleet" gridlines="None"
		skin="Telerik" width="780px" allowsorting="True" cssclass="radgrid" showfooter="True">
                        <FooterStyle HorizontalAlign="Right" />
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="IDProfileFleet" DataSourceID="sds_Profile_Fleet">
                            <Columns>

                                <telerik:GridBoundColumn DataField="FleetName" HeaderText="Fleet Name" SortExpression="FleetName"
                                    UniqueName="FleetName">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="City" DefaultInsertValue="" HeaderText="City"
                                    UniqueName="column1">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Telephone1" HeaderText="Telephone" SortExpression="Telephone1"
                                    UniqueName="Telephone1" DataFormatString="{0:(###) ###-####}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Ext1" DefaultInsertValue="" HeaderText="Ext"
                                    SortExpression="Ext1" UniqueName="Ext1">
                                </telerik:GridBoundColumn>
                                <telerik:GridHyperLinkColumn DataNavigateUrlFields="FleetName,IDProfileTerminal,IDProfileAccount,IDProfileFleet" DataNavigateUrlFormatString="FleetDetails.aspx?IDProfileTerminal={1}&IDProfileAccount={2}&IDProfileFleet={3}"
                                    DataTextField="IDProfileFleet" DataTextFormatString="Details" Text="Details"
                                    UniqueName="Details">
                                    <ItemStyle CssClass="radgrid" Width="50px"></ItemStyle>
                                </telerik:GridHyperLinkColumn>
                                <telerik:GridHyperLinkColumn DataNavigateUrlFields="FleetName,IDProfileTerminal,IDProfileAccount,IDProfileFleet" DataNavigateUrlFormatString="../03_vehicles/vehicles.aspx?IDProfileTerminal={1}&IDProfileAccount={2}&IDProfileFleet={3}"
                                    DataTextField="IDProfileFleet" DataTextFormatString="Vehicles" Text="Vehicles"
                                    UniqueName="Vehicles">
                                    <ItemStyle CssClass="radgrid" Width="50px"></ItemStyle>
                                </telerik:GridHyperLinkColumn>
                               <telerik:GridBoundColumn DataField="TotalVehicles" DefaultInsertValue="" HeaderText="#" Aggregate="Sum" FooterText=" "
                                    SortExpression="TotalVehicles" UniqueName="TotalVehicles" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="25px"  HeaderStyle-Width="25px" FooterStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center" Width="25px"></HeaderStyle>

<ItemStyle HorizontalAlign="Center" Width="25px"></ItemStyle>
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:radgrid>
	<br />
	<asp:Button ID="btn_Add_Fleet" runat="server" Text="Add Fleet" />
	<asp:SqlDataSource ID="sds_CFV_Fleet_Lineage" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDProfileAccount], [AccountName], [IDProfileTerminal], [TerminalName], [IDProfileFleet], [FleetName] FROM [CFV_Fleet_Lineage] WHERE ([IDProfileTerminal] = @IDProfileTerminal)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileTerminal" QueryStringField="IDProfileTerminal"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Profile_Fleet" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDProfileAccount], [IDProfileFleet], [IDProfileTerminal], [FleetName], [City], CAST(Telephone1 AS bigint)as Telephone1, [Ext1], [City], [TotalVehicles]  FROM [CFV_Profile_Fleet] WHERE ([IDProfileTerminal] = @IDProfileTerminal)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileTerminal" QueryStringField="IDProfileTerminal"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Profile_Terminal" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDProfileAccount], [IDProfileTerminal], [TerminalName] FROM [CF_Profile_Terminal] WHERE ([IDProfileTerminal] = @IDProfileTerminal)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileTerminal" QueryStringField="IDProfileTerminal"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>

