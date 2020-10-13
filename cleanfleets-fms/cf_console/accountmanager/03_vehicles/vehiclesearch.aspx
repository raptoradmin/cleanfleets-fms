<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="vehiclesearch.aspx.vb" Inherits="cleanfleets_fms.vehiclesearch1" %>

<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	
	<table cellpadding="0" cellspacing="0" style="width: 100%; height: 30px">
		<tr>
			<td style="font-size: medium; color: #ED8701">
				<b>Vehicles</b>
			</td>
		</tr>
	</table>
	<asp:TextBox runat="server" name="VehicleSearch" ID="VehicleSearch"  />
	<asp:Button ID="SearchButton" runat="server" Text="Search" onclick="SearchButton_Click" />
	
	<table style="width: 100%" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<telerik:radgrid id="RadGrid1" runat="server" datasourceid="sds_QueryFV" gridlines="None"
					skin="Telerik" width="100%" allowpaging="True" pagesize="20" allowsorting="True">
					<MasterTableView AutoGenerateColumns="False" DataKeyNames="IDVehicles" DataSourceID="sds_QueryFV">
						<Columns>
							<telerik:GridBoundColumn DataField="AccountName" DataType="System.Int32" DefaultInsertValue=""
								HeaderText="Account Name" ReadOnly="True" SortExpression="AccountName" UniqueName="AccountName">
							</telerik:GridBoundColumn>
							<telerik:GridBoundColumn DataField="TerminalName" DataType="System.Int32" DefaultInsertValue=""
								HeaderText="Terminal Name" ReadOnly="True" SortExpression="TerminalName" UniqueName="TerminalName">
							</telerik:GridBoundColumn>
							<telerik:GridBoundColumn DataField="FleetName" DataType="System.Int32" DefaultInsertValue=""
								HeaderText="Fleet Name" ReadOnly="True" SortExpression="FleetName" UniqueName="FleetName">
							</telerik:GridBoundColumn>
							
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
							<telerik:GridBoundColumn DataField="ChassisVIN" DefaultInsertValue="" HeaderText="Chassis VIN"
								SortExpression="ChassisVIN" UniqueName="ChassisVIN">
							</telerik:GridBoundColumn>
							<telerik:GridBoundColumn DataField="SerialNum" DefaultInsertValue="" HeaderText="Engine Serial Num"
								SortExpression="SerialNum" UniqueName="SerialNum">
							</telerik:GridBoundColumn>
							<%-- <telerik:GridBoundColumn DataField="VehicleStatus" DefaultInsertValue="" HeaderText="Status"
								ReadOnly="True" SortExpression="VehicleStatus" UniqueName="VehicleStatus">
							</telerik:GridBoundColumn>--%>
							
							<telerik:GridHyperLinkColumn DataNavigateUrlFields="IDVehicles,IDProfileTerminal,IDProfileAccount,IDProfileFleet,OriginalSearchString" 
							DataNavigateUrlFormatString="vehiclesdetails.aspx?IDVehicles={0}&IDProfileTerminal={1}&IDProfileAccount={2}&IDProfileFleet={3}&VehicleSearch={4}" 
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
				
			</td>
		</tr>
	</table>
	<br />
	<br />
	<asp:SqlDataSource ID="sds_QueryFV" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="EXECUTE QueryFV @IDProfileAccount, @SearchString " >
		 <SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" DefaultValue="0" ConvertEmptyStringToNull="true"
				Type="Int32" />
			<asp:ControlParameter Name="SearchString" ControlID="VehicleSearch" DefaultValue="%" Type="String" />
		</SelectParameters>
		
	</asp:SqlDataSource>
</asp:Content>

