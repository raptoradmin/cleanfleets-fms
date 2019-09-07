<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="04_vehicles.aspx.vb" Inherits="cleanfleets_fms._04_vehicles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<h1>
		Account Vehicle Report by Fleet</h1>
	<table cellpadding="0" cellspacing="0" class="tdtable" style="width: 100%">
		<tr>
			<td style="padding: 3px; width: 75px;">
				Accounts:
			</td>
			<td style="padding: 3px; text-align: left;">
				<%--<asp:DropDownList ID="ddl_Accounts" runat="server" DataSourceID="sds_Accounts" 
                        DataTextField="AccountName" DataValueField="IDProfileAccount" 
                        AppendDataBoundItems="True" AutoPostBack="True">
                        <asp:ListItem Text="Select" Value="0" />
                    </asp:DropDownList>--%>
				<asp:DropDownList ID="ddl_Account" runat="server" Width="300px" DataSourceID="sds_ddl_Account"
					DataTextField="AccountName" DataValueField="IDProfileAccount" AppendDataBoundItems="True"
					AutoPostBack="true" OnSelectedIndexChanged="ddl_Account_SelectedIndexChanged">
					<Items>
						<asp:ListItem Text="- Select Account -" Value="0" />
					</Items>
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td style="padding: 3px; width: 75px;">
				Terminals:
			</td>
			<td style="padding: 3px; text-align: left;">
				<%--<asp:DropDownList ID="ddl_Terminals" runat="server" AutoPostBack="True" 
                        DataSourceID="sds_Terminals" DataTextField="TerminalName" 
                        DataValueField="IDProfileTerminal" AppendDataBoundItems="True">
                        <asp:ListItem Text="Select" Value="0" />
                    </asp:DropDownList>--%>
				<asp:DropDownList ID="ddl_Terminal" runat="server" Width="186px" AutoPostBack="true"
					OnSelectedIndexChanged="ddl_Terminal_SelectedIndexChanged" />
			</td>
		</tr>
		<tr>
			<td style="padding: 3px; width: 75px;">
				Fleets:
			</td>
			<td style="padding: 3px; text-align: left;">
				<%--<asp:DropDownList ID="ddl_Fleets" runat="server" AutoPostBack="True" 
                        DataSourceID="sds_Fleets" DataTextField="FleetName" 
                        DataValueField="IDProfileFleet" AppendDataBoundItems="True">
                        <asp:ListItem Text="Select" Value="0" />
                    </asp:DropDownList>--%>
				<asp:DropDownList ID="ddl_Fleet" runat="server" Width="186px" AutoPostBack="true" />
			</td>
		</tr>
	</table>
	<h1>
		Vehicles</h1>
	<telerik:radgrid id="rg_Terminals" datasourceid="sds_Vehicles" allowsorting="True"
		allowpaging="True" runat="server" gridlines="None">
        <ExportSettings HideStructureColumns="true" ExportOnlyData="True" IgnorePaging="True" />
        <MasterTableView Width="100%" CommandItemDisplay="Top" AutoGenerateColumns="False" DataSourceID="sds_Vehicles">
            <Columns>
                <telerik:GridBoundColumn DataField="EquipmentType" DefaultInsertValue="" 
                    HeaderText="EquipmentType" ReadOnly="True" SortExpression="EquipmentType" 
                    UniqueName="EquipmentType">
                </telerik:GridBoundColumn>
				<telerik:GridBoundColumn DataField="SpecialProvision" DefaultInsertValue="" 
                    HeaderText="SpecialProvision" ReadOnly="True" 
                    SortExpression="SpecialProvision" UniqueName="SpecialProvision">
                </telerik:GridBoundColumn>
                <%--<telerik:GridBoundColumn DataField="EquipmentCategory" DefaultInsertValue="" 
                    HeaderText="EquipmentCategory" ReadOnly="True" 
                    SortExpression="EquipmentCategory" UniqueName="EquipmentCategory">
                </telerik:GridBoundColumn>--%>
                <telerik:GridBoundColumn DataField="VehicleStatus" DefaultInsertValue="" 
                    HeaderText="VehicleStatus" ReadOnly="True" SortExpression="VehicleStatus" 
                    UniqueName="VehicleStatus">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CARBGroup" DefaultInsertValue="" 
                    HeaderText="CARBGroup" ReadOnly="True" SortExpression="CARBGroup" 
                    UniqueName="CARBGroup">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ChassisMake" DefaultInsertValue="" 
                    HeaderText="ChassisMake" ReadOnly="True" SortExpression="ChassisMake" 
                    UniqueName="ChassisMake">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ChassisModelYear" DefaultInsertValue="" 
                    HeaderText="ChassisModelYear" ReadOnly="True" SortExpression="ChassisModelYear" 
                    UniqueName="ChassisModelYear">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LicensePlateState" DefaultInsertValue="" 
                    HeaderText="LicensePlateState" SortExpression="LicensePlateState" 
                    UniqueName="LicensePlateState">
                </telerik:GridBoundColumn>
				<telerik:GridBoundColumn DataField="LicensePlateNo" DefaultInsertValue="" 
                    HeaderText="LicensePlateNo" SortExpression="LicensePlateNo" 
                    UniqueName="LicensePlateNo">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ChassisVIN" DefaultInsertValue="" 
                    HeaderText="ChassisVIN" SortExpression="ChassisVIN" UniqueName="ChassisVIN">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="UnitNo" DefaultInsertValue="" 
                    HeaderText="UnitNo" SortExpression="UnitNo" UniqueName="UnitNo">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AnnualMiles" DefaultInsertValue="" 
                    HeaderText="AnnualMiles" SortExpression="AnnualMiles" UniqueName="AnnualMiles">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AnnualHours" DefaultInsertValue="" 
                    HeaderText="AnnualHours" SortExpression="AnnualHours" UniqueName="AnnualHours">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ActualMiles" DefaultInsertValue="" 
                    HeaderText="ActualMiles" SortExpression="ActualMiles" UniqueName="ActualMiles">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ActualHours" DefaultInsertValue="" 
                    HeaderText="ActualHours" SortExpression="ActualHours" UniqueName="ActualHours">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="GrossVehicleWeight" DefaultInsertValue="" 
                    HeaderText="GrossVehicleWeight" SortExpression="GrossVehicleWeight" 
                    UniqueName="GrossVehicleWeight">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="InServiceDate" 
                    DataType="System.DateTime" DefaultInsertValue="" 
                    HeaderText="InServiceDate" SortExpression="InServiceDate" 
                    UniqueName="InServiceDate" DataFormatString="{0:MM/dd/yyyy}">
                </telerik:GridBoundColumn>
				<telerik:GridBoundColumn DataField="PlannedComplianceDate" 
                    DataType="System.DateTime" DefaultInsertValue="" 
                    HeaderText="PlannedComplianceDate" SortExpression="PlannedComplianceDate" 
                    UniqueName="PlannedComplianceDate" DataFormatString="{0:MM/dd/yyyy}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ActualComplianceDate" 
                    DataType="System.DateTime" DefaultInsertValue="" 
                    HeaderText="ActualComplianceDate" SortExpression="ActualComplianceDate" 
                    UniqueName="ActualComplianceDate" DataFormatString="{0:MM/dd/yyyy}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BackupStatusDate" 
                    DataType="System.DateTime" DefaultInsertValue="" HeaderText="BackupStatusDate" 
                    SortExpression="BackupStatusDate" UniqueName="BackupStatusDate" DataFormatString="{0:MM/dd/yyyy}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RetireStatusDate" 
                    DataType="System.DateTime" DefaultInsertValue="" HeaderText="RetireStatusDate" 
                    SortExpression="RetireStatusDate" UniqueName="RetireStatusDate" DataFormatString="{0:MM/dd/yyyy}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EstReplacementCost" 
                    DataType="System.Decimal" DefaultInsertValue="" HeaderText="EstReplacementCost" 
                    SortExpression="EstReplacementCost" UniqueName="EstReplacementCost">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PlannedRetirementDate" 
                    DataType="System.DateTime" DefaultInsertValue="" 
                    HeaderText="PlannedRetirementDate" SortExpression="PlannedRetirementDate" 
                    UniqueName="PlannedRetirementDate" DataFormatString="{0:MM/dd/yyyy}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ActualRetirementDate" 
                    DataType="System.DateTime" DefaultInsertValue="" 
                    HeaderText="ActualRetirementDate" SortExpression="ActualRetirementDate" 
                    UniqueName="ActualRetirementDate" DataFormatString="{0:MM/dd/yyyy}">
                </telerik:GridBoundColumn>
            </Columns>
            <PagerStyle Mode="NextPrevNumericAndAdvanced" />
            <CommandItemSettings ShowExportToExcelButton="true"/>
        </MasterTableView>
    </telerik:radgrid>
	<p>
		&nbsp;</p>
	<asp:SqlDataSource ID="sds_Vehicles" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CFV_Vehicles] WHERE ([IDProfileFleet] = @IDProfileFleet)">
		<SelectParameters>
			<asp:ControlParameter ControlID="ddl_Fleet" Name="IDProfileFleet" PropertyName="SelectedValue"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>
</asp:Content>

