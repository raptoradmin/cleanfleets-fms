<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="engine_attach.aspx.vb" Inherits="cleanfleets_fms.engine_attach" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Attatch Engine</p>
	<p>
		<asp:FormView ID="FormView1" runat="server" DataKeyNames="IDVehicles" DataSourceID="sds_Vehicles"
			Width="400px">
			<ItemTemplate>
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td class="tdtable">
							Account Name:
						</td>
						<td class="tdtablebasic">
							<asp:Label ID="AccountNameLabel" runat="server" Text='<%# Bind("AccountName") %>' />
						</td>
					</tr>
					<tr>
						<td class="tdtable">
							Terminal Name:
						</td>
						<td class="tdtablebasic">
							<asp:Label ID="TerminalNameLabel" runat="server" Text='<%# Bind("TerminalName") %>' />
						</td>
					</tr>
					<tr>
						<td class="tdtable">
							Fleet Name:
						</td>
						<td class="tdtablebasic">
							<asp:Label ID="FleetNameLabel" runat="server" Text='<%# Bind("FleetName") %>' />
						</td>
					</tr>
					<tr>
						<td class="tdtable">
							Unit No:
						</td>
						<td class="tdtablebasic">
							<asp:Label ID="UnitNoLabel" runat="server" Text='<%# Bind("UnitNo") %>' />
						</td>
					</tr>
					<tr>
						<td class="tdtable">
							License Plate No:
						</td>
						<td class="tdtablebasic">
							<asp:Label ID="LicensePlateNoLabel" runat="server" Text='<%# Bind("LicensePlateNo") %>' />
						</td>
					</tr>
					<tr>
						<td class="tdtable">
							VIN:
						</td>
						<td class="tdtablebasic">
							<asp:Label ID="ChassisVINLabel" runat="server" Text='<%# Bind("ChassisVIN") %>' />
						</td>
					</tr>
				</table>
			</ItemTemplate>
		</asp:FormView>
	</p>
	<table id="table1" cellpadding="0" cellspacing="0" style="width: 100%">
		<tr>
			<td class="tdtable" style="width: 115px">
				Engine Serial No.
			</td>
			<td>
				<asp:DropDownList ID="ddl_IDEngines" runat="server" DataSourceID="sds_Engines" DataTextField="SerialNum"
					DataValueField="IDEngines">
				</asp:DropDownList>
			</td>
		</tr>
	</table>
	<p>
		<asp:Button ID="btn_Attach" runat="server" Text="Attach Engine" />
	</p>
	<asp:SqlDataSource ID="sds_Vehicles" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDVehicles], [AccountName], [TerminalName], [FleetName], [UnitNo], [LicensePlateNo], [ChassisVIN] FROM [CFV_Vehicles] WHERE ([IDVehicles] = @IDVehicles)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Engines" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDProfileAccount], [SerialNum], [IDEngines] FROM [CFV_Engines_Detached] WHERE ([IDProfileAccount] = @IDProfileAccount)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>
