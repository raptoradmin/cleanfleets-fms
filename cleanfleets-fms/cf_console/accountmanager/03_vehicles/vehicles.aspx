<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="vehicles.aspx.vb" Inherits="cleanfleets_fms.vehicles1" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<asp:FormView ID="FormView1" runat="server" DataKeyNames="IDProfileAccount,IDProfileTerminal,IDProfileFleet"
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
			&nbsp;<span style="font-size: medium; font-weight: bold; color: #2C7500">Fleet:</span>&nbsp;<asp:HyperLink
				ID="hl_FleetList" runat="server" NavigateUrl='<%# Eval("IDProfileAccount", "../02_fleets/fleet.aspx?IDProfileAccount={0}") & "&IDProfileTerminal=" & Eval("IDProfileTerminal") %>'
				Text='<%# Eval("FleetName") %>'></asp:HyperLink>
		</ItemTemplate>
	</asp:FormView>
	<table cellpadding="0" cellspacing="0" style="width: 100%; height: 30px">
		<tr>
			<td style="font-size: medium; color: #ED8701">
				<b>Vehicles</b>
			</td>
		</tr>
	</table>
	<table style="width: 100%" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<telerik:radgrid id="RadGrid1" runat="server" datasourceid="sds_CFV_Vehicles" gridlines="None"
					skin="Telerik" width="800px" allowpaging="True" pagesize="20" allowsorting="True">
					<MasterTableView AutoGenerateColumns="False" DataKeyNames="IDVehicles" DataSourceID="sds_CFV_Vehicles">
						<Columns>
							<telerik:GridBoundColumn DataField="IDVehicles" DataType="System.Int32" DefaultInsertValue=""
								HeaderText="ID" ReadOnly="True" SortExpression="IDVehicles" UniqueName="IDVehicles" Display="False">
							</telerik:GridBoundColumn>
							<telerik:GridBoundColumn DataField="UnitNo" DefaultInsertValue="" HeaderText="Unit No."
								SortExpression="UnitNo" UniqueName="UnitNo">
							</telerik:GridBoundColumn>
							<telerik:GridBoundColumn DataField="LicensePlateState" DefaultInsertValue="" HeaderText="License Plate State"
								SortExpression="LicensePlateState" UniqueName="LicensePlateState">
							</telerik:GridBoundColumn>
							<telerik:GridBoundColumn DataField="LicensePlateNo" DefaultInsertValue="" HeaderText="License No."
								SortExpression="LicensePlateNo" UniqueName="LicensePlateNo">
							</telerik:GridBoundColumn>
							<telerik:GridBoundColumn DataField="VehicleStatus" DefaultInsertValue="" HeaderText="Status"
								ReadOnly="True" SortExpression="VehicleStatus" UniqueName="VehicleStatus">
							</telerik:GridBoundColumn>
							<telerik:GridBoundColumn DataField="CARBGroup" DefaultInsertValue="" HeaderText="CARB Group"
								ReadOnly="True" SortExpression="CARBGroup" UniqueName="CARBGroup">
							</telerik:GridBoundColumn>
							<telerik:GridHyperLinkColumn DataNavigateUrlFields="IDVehicles,IDProfileTerminal,IDProfileAccount,IDProfileFleet" 
							DataNavigateUrlFormatString="vehiclesdetails.aspx?IDVehicles={0}&IDProfileTerminal={1}&IDProfileAccount={2}&IDProfileFleet={3}" 
							DataTextField="IDVehicles" DataTextFormatString="Details" Text="Details" 
							UniqueName="Details">
							<ItemStyle CssClass="radgrid" Width="50px"></ItemStyle>
							</telerik:GridHyperLinkColumn>
							</Columns>
						<RowIndicatorColumn>
							<HeaderStyle Width="20px"></HeaderStyle>
						</RowIndicatorColumn>
						<ExpandCollapseColumn>
							<HeaderStyle Width="20px"></HeaderStyle>
						</ExpandCollapseColumn>
					</MasterTableView>
					<ClientSettings EnablePostBackOnRowClick="True">
						<Selecting AllowRowSelect="True" />
					</ClientSettings>
				</telerik:radgrid>
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" style="width: 100%">
		<tr>
			<td>
				<br />
				<asp:Button ID="Button1" runat="server" Text="Add Vehicle" />
			</td>
		</tr>
	</table>
	<br />
	<br />
	<asp:SqlDataSource ID="sds_CFV_Vehicles" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDVehicles], [IDModifiedUser], [EnterDate], [ModifiedDate], [IDProfileAccount], [AccountName], [IDProfileTerminal], [TerminalName], [IDProfileFleet], [FleetName], [EquipmentType], [EquipmentCategory], [VehicleStatus], [CARBGroup], [LicensePlateState], [LicensePlateNo], [ChassisVIN], [ChassisMake], [ChassisModelYear], [UnitNo], [Description], [AnnualMiles], [AnnualHours], [ActualMiles], [ActualHours], [PlannedComplianceDate], [ActualComplianceDate], [BackupStatusDate], [RetireStatusDate], [Notes], [NotesCF] FROM [CFV_Vehicles] WHERE ([IDProfileFleet] = @IDProfileFleet)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileFleet" QueryStringField="IDProfileFleet"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_CFV_Fleet_Lineage" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDProfileAccount], [AccountName], [IDProfileTerminal], [TerminalName], [IDProfileFleet], [FleetName] FROM [CFV_Fleet_Lineage] WHERE ([IDProfileFleet] = @IDProfileFleet)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileFleet" QueryStringField="IDProfileFleet"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>
