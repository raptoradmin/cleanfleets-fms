<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="vehiclestransfer.aspx.vb" Inherits="cleanfleets_fms.vehiclestransfer" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<h6>
		Vehicle</h6>
	<table style="width: 100%" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<asp:FormView ID="FormView1" runat="server" DataKeyNames="IDVehicles" DataSourceID="sds_CFV_Vehicles"
					Width="450px">
					<EditItemTemplate>
						IDVehicles:
						<asp:Label ID="IDVehiclesLabel1" runat="server" Text='<%# Eval("IDVehicles") %>' />
						<br />
						TerminalName:
						<asp:TextBox ID="TerminalNameTextBox" runat="server" Text='<%# Bind("TerminalName") %>' />
						<br />
						LicensePlateNo:
						<asp:TextBox ID="LicensePlateNoTextBox" runat="server" Text='<%# Bind("LicensePlateNo") %>' />
						<br />
						ChassisVIN:
						<asp:TextBox ID="ChassisVINTextBox" runat="server" Text='<%# Bind("ChassisVIN") %>' />
						<br />
						UnitNo:
						<asp:TextBox ID="UnitNoTextBox" runat="server" Text='<%# Bind("UnitNo") %>' />
						<br />
						<asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
							Text="Update" />
						&nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False"
							CommandName="Cancel" Text="Cancel" />
					</EditItemTemplate>
					<InsertItemTemplate>
						IDVehicles:
						<asp:TextBox ID="IDVehiclesTextBox" runat="server" Text='<%# Bind("IDVehicles") %>' />
						<br />
						TerminalName:
						<asp:TextBox ID="TerminalNameTextBox" runat="server" Text='<%# Bind("TerminalName") %>' />
						<br />
						LicensePlateNo:
						<asp:TextBox ID="LicensePlateNoTextBox" runat="server" Text='<%# Bind("LicensePlateNo") %>' />
						<br />
						ChassisVIN:
						<asp:TextBox ID="ChassisVINTextBox" runat="server" Text='<%# Bind("ChassisVIN") %>' />
						<br />
						UnitNo:
						<asp:TextBox ID="UnitNoTextBox" runat="server" Text='<%# Bind("UnitNo") %>' />
						<br />
						<asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
							Text="Insert" />
						&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False"
							CommandName="Cancel" Text="Cancel" />
					</InsertItemTemplate>
					<ItemTemplate>
						<table id="table1" cellpadding="0" cellspacing="0" style="width: 100%">
							<tr>
								<td class="tdtable" style="width: 115px">
									Unit:
								</td>
								<td>
									<asp:Label ID="UnitNoLabel" runat="server" Text='<%# Bind("UnitNo") %>' />
								</td>
							</tr>
							<tr>
								<td class="tdtable" style="width: 115px">
									License Plate No:
								</td>
								<td>
									<asp:Label ID="LicensePlateNoLabel" runat="server" Text='<%# Bind("LicensePlateNo") %>' />
								</td>
							</tr>
							<tr>
								<td class="tdtable" style="width: 115px">
									VIN
								</td>
								<td>
									<asp:Label ID="ChassisVINLabel" runat="server" Text='<%# Bind("ChassisVIN") %>' />
								</td>
							</tr>
							<tr>
								<td class="tdtable" style="width: 115px">
									Terminal:
								</td>
								<td>
									<asp:Label ID="TerminalNameLabel" runat="server" Text='<%# Bind("TerminalName") %>' />
								</td>
							</tr>
							<tr>
								<td class="tdtable" style="width: 115px">
									Fleet:
								</td>
								<td>
									<asp:Label ID="FleetNameLabel" runat="server" Text='<%# Bind("FleetName") %>' />
								</td>
							</tr>
							<tr>
								<td class="tdtable" style="width: 115px">
									&nbsp;
								</td>
								<td>
									<asp:Label ID="IDVehiclesLabel" runat="server" Text='<%# Eval("IDVehicles") %>' />
								</td>
							</tr>
						</table>
					</ItemTemplate>
				</asp:FormView>
			</td>
		</tr>
	</table>
	<h6>
		Transfer</h6>
	<table id="table2" cellpadding="0" cellspacing="0" style="width: 100%">
		<tr>
			<td class="tdtable" style="width: 70px">
				Terminal:
			</td>
			<td>
				<asp:DropDownList ID="ddl_Terminal" runat="server" DataSourceID="sds_Terminal" DataTextField="TerminalName"
					DataValueField="IDProfileTerminal" AutoPostBack="True">
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td class="tdtable" style="width: 70px">
				&nbsp;
			</td>
			<td>
				&nbsp;
			</td>
		</tr>
		<tr>
			<td class="tdtable" style="width: 70px">
				Fleet:
			</td>
			<td>
				<asp:DropDownList ID="ddl_Fleet" runat="server" DataSourceID="sds_Fleet" DataTextField="FleetName"
					DataValueField="IDProfileFleet">
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td class="tdtable" style="width: 70px">
				&nbsp;
			</td>
			<td>
				&nbsp;
			</td>
		</tr>
		<tr>
			<td class="tdtable" style="width: 70px">
				&nbsp;
			</td>
			<td>
				<asp:Button ID="Button1" runat="server" Text="Transfer" />
			</td>
		</tr>
	</table>
	<br />
	<asp:SqlDataSource ID="sds_CFV_Vehicles" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDVehicles], [TerminalName], [FleetName], [LicensePlateNo], [ChassisVIN], [UnitNo] FROM [CFV_Vehicles] WHERE ([IDVehicles] = @IDVehicles)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Terminal" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDProfileAccount], [IDProfileTerminal], [TerminalName] FROM [CF_Profile_Terminal] WHERE ([IDProfileAccount] = @IDProfileAccount) ORDER BY [TerminalName]">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Fleet" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDProfileFleet], [FleetName] FROM [CF_Profile_Fleet] WHERE ([IDProfileTerminal] = @IDProfileTerminal) ORDER BY [FleetName]">
		<SelectParameters>
			<asp:ControlParameter ControlID="ddl_Terminal" Name="IDProfileTerminal" PropertyName="SelectedValue"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>
