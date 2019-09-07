<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="default.aspx.vb" Inherits="cleanfleets_fms._default2" %>



<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<table style="width: 450px" class="tablecenter">
		<tr>
			<td style="text-align: center;" colspan="3">
				<h5>
					Account Snapshot</h5>
				<p class="greendark">
					&nbsp;
				</p>
				<p class="greendark">
					&nbsp;
				</p>
			</td>
		</tr>
		<tr>
			<td style="text-align: center; width: 150px;">
				<telerik:radgrid id="RadGrid1" runat="server" datasourceid="sds_Profile_Account"
					font-bold="False" font-italic="False" font-overline="False" font-strikeout="False"
					font-underline="False" gridlines="None" horizontalalign="Center" skin="Default"
					width="100px" cssclass="tablecenter">
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
												</telerik:radgrid>
								</td>
								<td style="width: 150px; text-align: center;">
									<telerik:radgrid id="RadGrid2" runat="server" datasourceid="sds_Profile_Terminal"
										font-bold="False" font-italic="False" font-overline="False" font-strikeout="False"
										font-underline="False" gridlines="None" horizontalalign="Center" skin="Default"
										width="100px" cssclass="tablecenter">
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
												</telerik:radgrid>
								</td>
								<td style="width: 150px; text-align: center;">
									<telerik:radgrid id="RadGrid3" runat="server" datasourceid="sds_Profile_Fleet" font-bold="False"
										font-italic="False" font-overline="False" font-strikeout="False" font-underline="False"
										gridlines="None" horizontalalign="Center" skin="Default" width="100px" cssclass="tablecenter">
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
				</telerik:radgrid>
			</td>
			<td style="width: 150px; text-align: center;">
				<telerik:radgrid id="RadGrid4" runat="server" datasourceid="sds_Vehicles" font-bold="False"
						font-italic="False" font-overline="False" font-strikeout="False" font-underline="False"
						gridlines="None" horizontalalign="Center" skin="Default" width="110px" cssclass="tablecenter">
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
					</telerik:radgrid>
			</td>
		</tr>
		<tr>
			<td style="width: 150px; text-align: center;">
				&nbsp;
			</td>
			<td style="width: 150px; text-align: center;">
				&nbsp;
			</td>
			<td style="width: 150px; text-align: center;">
				&nbsp;
			</td>
		</tr>
	</table>
	
	<asp:SqlDataSource ID="sds_Profile_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT count (*) FROM [CF_Profile_Account]"></asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Profile_Terminal" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT count (*) FROM [CF_Profile_Terminal]"></asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Profile_Fleet" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT count (*) FROM [CF_Profile_Fleet]"></asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Vehicles" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT count (*) FROM [CFV_Vehicles]">
	</asp:SqlDataSource>
</asp:Content>
