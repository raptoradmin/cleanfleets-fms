<%@ Page Title="" Language="vb" AutoEventWireup="true" MasterPageFile="~/CF_Client.Master" CodeBehind="~/includes/reports_client/05_vehicles_detailed.aspx.vb" Inherits="cleanfleets_fms._05_vehicles_detailed" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<h1>
		Account Vehicle Report by Fleet - Detailed</h1>
	<div id="qsfexWrapper">
		<table cellpadding="0" cellspacing="0" class="style1">
			<!--<tr>
                            <td class="tdtable" style="padding: 3px">
                                <%--<asp:Label ID="Label1" runat="server" AssociatedControlID="ddl_Account">Account:</asp:Label>--%>
                            </td>
                            <td style="padding: 3px">
                                <%--<telerik:RadComboBox ID="RadComboBox1" runat="server" 
                                    OnClientSelectedIndexChanging="Loadterminals" 
                                    OnItemsRequested="RadComboBox1_ItemsRequested" Width="300px" />--%>
								<%--<asp:DropDownList id="ddl_Account" runat="server"
								  Width="300px"
								  DataSourceID="sds_ddl_Account"
								  DataTextField="AccountName" DataValueField="IDProfileAccount" 
								  AppendDataBoundItems="True"
								  AutoPostBack="true" OnSelectedIndexChanged="ddl_Account_SelectedIndexChanged" >
								  <items>
								  	<asp:ListItem Text="- Select Account -" Value="0" />
								  </items>
								</asp:DropDownList>--%>
                            </td>
                        </tr>-->
			<tr>
				<td class="tdtable" style="padding: 3px">
					<asp:Label ID="Label2" runat="server" AssociatedControlID="ddl_Terminal">Terminal:</asp:Label>
				</td>
				<td style="padding: 3px">
					<%--<telerik:RadComboBox ID="RadComboBox2" runat="server"
                                    OnClientItemsRequested="ItemsLoaded" OnClientSelectedIndexChanging="Loadfleets" 
                                    OnItemsRequested="RadComboBox2_ItemsRequested" Width="186px" />--%>
					<asp:DropDownList ID="ddl_Terminal" runat="server" Width="186px" DataSourceID="sds_ddl_Terminal"
						DataTextField="TerminalName" DataValueField="IDProfileTerminal" AppendDataBoundItems="True"
						AutoPostBack="true" OnSelectedIndexChanged="ddl_Terminal_SelectedIndexChanged">
						<Items>
							<asp:ListItem Text="- Select Terminal -" Value="0" />
						</Items>
					</asp:DropDownList>
				</td>
			</tr>
			<tr>
				<td class="tdtable" style="padding: 3px">
					<asp:Label ID="Label3" runat="server" AssociatedControlID="ddl_Fleet">Fleet:</asp:Label>
				</td>
				<td style="padding: 3px">
					<%--<telerik:RadComboBox ID="RadComboBox3" runat="server" 
                                    OnClientItemsRequested="ItemsLoaded" 
                                    OnItemsRequested="RadComboBox3_ItemsRequested" Width="186px" 
                                    AutoPostBack="True" />--%>
					<asp:DropDownList ID="ddl_Fleet" runat="server" Width="186px" AutoPostBack="true" />
				</td>
			</tr>
			<tr>
				<td class="tdtable" style="padding: 3px">&nbsp;
					
				</td>
				<td style="padding: 3px">&nbsp;
					
				</td>
			</tr>
		</table>
	</div>
	<%--<script type="text/javascript">
            //global variables for the terminals and fleets comboboxes
            var terminalsCombo;
            var fleetsCombo;

            function pageLoad() {
                // initialize the global variables
                // in this event all client objects 
                // are already created and initialized 
                terminalsCombo = $find("<%'= RadComboBox2.ClientID %>");
                fleetsCombo = $find("<%'= RadComboBox3.ClientID %>");
            }

            function Loadterminals(combo, eventArqs) {
                var item = eventArqs.get_item();
                terminalsCombo.set_text("Loading...");
                fleetsCombo.clearSelection();

                // if a continent is selected
                if (item.get_index() > 0) {
                    // this will fire the ItemsRequested event of the 
                    // terminals combobox passing the continentID as a parameter 
                    terminalsCombo.requestItems(item.get_value(), false);
                }
                else {
                    // the -Select a continent- item was chosen
                    terminalsCombo.set_text(" ");
                    terminalsCombo.clearItems();

                    fleetsCombo.set_text(" ");
                    fleetsCombo.clearItems();
                }
            }

            function Loadfleets(combo, eventArqs) {
                var item = eventArqs.get_item();
                fleetsCombo.set_text("Loading...");
				fleetsCombo.clearSelection();
				
				if (item.get_index() > 0) {
					// this will fire the ItemsRequested event of the
					// fleets combobox passing the countryID as a parameter 
					fleetsCombo.requestItems(item.get_value(), false);
				} else {
					fleetsCombo.set_text(" ");
                    fleetsCombo.clearItems();
				}
            }

            function ItemsLoaded(combo, eventArqs) {
                if (combo.get_items().get_count() > 0) {
                    // pre-select the first item
                    combo.set_text(combo.get_items().getItem(0).get_text());
                    combo.get_items().getItem(0).highlight();
                }
                combo.showDropDown();
            }

        </script>--%>
	<h1>
		Vehicles</h1>
	<telerik:radgrid id="rg_Terminals" datasourceid="sds_Vehicles" allowsorting="True"
		allowpaging="True" runat="server" gridlines="None" onload="rg_Terminals_OnLoad">
        <ExportSettings HideStructureColumns="true" ExportOnlyData="True" IgnorePaging="True" />
        <MasterTableView Width="100%" CommandItemDisplay="Top" AutoGenerateColumns="False" 
                           DataSourceID="sds_Vehicles">
        

            <CommandItemSettings ShowExportToCsvButton="True" />
        

            <Columns>
                <telerik:GridBoundColumn DataField="UnitNo" DefaultInsertValue="" 
                    HeaderText="UnitNo" SortExpression="UnitNo" 
                    UniqueName="UnitNo">
                </telerik:GridBoundColumn>
				 <telerik:GridBoundColumn DataField="LicensePlateState" DefaultInsertValue="" 
                    HeaderText="LicensePlateState" 
                    SortExpression="LicensePlateState" UniqueName="LicensePlateState">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LicensePlateNo" DefaultInsertValue="" 
                    HeaderText="LicensePlateNo" 
                    SortExpression="LicensePlateNo" UniqueName="LicensePlateNo">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ChassisVIN" DefaultInsertValue="" 
                    HeaderText="ChassisVIN" SortExpression="ChassisVIN" 
                    UniqueName="ChassisVIN">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EquipmentType" DefaultInsertValue="" 
                    HeaderText="EquipmentType" ReadOnly="True" SortExpression="EquipmentType" 
                    UniqueName="EquipmentType">
                </telerik:GridBoundColumn>
				<telerik:GridBoundColumn DataField="SpecialProvision" DefaultInsertValue="" 
                    HeaderText="SpecialProvision" ReadOnly="True" SortExpression="SpecialProvision" 
                    UniqueName="SpecialProvision">
                </telerik:GridBoundColumn>
                <%--<telerik:GridBoundColumn DataField="EquipmentCategory" DefaultInsertValue="" 
                    HeaderText="EquipmentCategory" ReadOnly="True" SortExpression="EquipmentCategory" 
                    UniqueName="EquipmentCategory">
                </telerik:GridBoundColumn>--%>
                <telerik:GridBoundColumn DataField="VehicleStatus" DefaultInsertValue="" 
                    HeaderText="VehicleStatus" ReadOnly="True" SortExpression="VehicleStatus" 
                    UniqueName="VehicleStatus">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CARBGroup" DefaultInsertValue="" 
                    HeaderText="CARBGroup" SortExpression="CARBGroup" 
                    UniqueName="CARBGroup" ReadOnly="True">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ChassisMake" DefaultInsertValue="" 
                    HeaderText="ChassisMake" SortExpression="ChassisMake" 
                    UniqueName="ChassisMake" ReadOnly="True">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ChassisModelYear" DefaultInsertValue="" 
                    HeaderText="ChassisModelYear" SortExpression="ChassisModelYear" 
                    UniqueName="ChassisModelYear" ReadOnly="True">
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
				<telerik:GridBoundColumn DataField="WeightDefinition" DefaultInsertValue="" 
                    HeaderText="WeightDefinition" SortExpression="WeightDefinition" 
                    UniqueName="WeightDefinition">
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
                <telerik:GridBoundColumn DataField="EngineManufacturer" DefaultInsertValue="" 
                    HeaderText="EngineManufacturer" ReadOnly="True" 
                    SortExpression="EngineManufacturer" UniqueName="EngineManufacturer">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EngineModel" DefaultInsertValue="" 
                    HeaderText="EngineModel" SortExpression="EngineModel" UniqueName="EngineModel">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EngineStatus" DefaultInsertValue="" 
                    HeaderText="EngineStatus" ReadOnly="True" SortExpression="EngineStatus" 
                    UniqueName="EngineStatus">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EngineFuelType" DefaultInsertValue="" 
                    HeaderText="EngineFuelType" ReadOnly="True" SortExpression="EngineFuelType" 
                    UniqueName="EngineFuelType">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ModelYear" DefaultInsertValue="" 
                    HeaderText="ModelYear" ReadOnly="True" SortExpression="ModelYear" 
                    UniqueName="ModelYear">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SerialNum" DefaultInsertValue="" 
                    HeaderText="SerialNum" SortExpression="SerialNum" UniqueName="SerialNum">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="FamilyName" DefaultInsertValue="" 
                    HeaderText="FamilyName" SortExpression="FamilyName" UniqueName="FamilyName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SeriesModelNo" DefaultInsertValue="" 
                    HeaderText="SeriesModelNo" SortExpression="SeriesModelNo" 
                    UniqueName="SeriesModelNo">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Horsepower" DefaultInsertValue="" 
                    HeaderText="Horsepower" SortExpression="Horsepower" UniqueName="Horsepower">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Displacement" DefaultInsertValue="" 
                    HeaderText="Displacement" SortExpression="Displacement" 
                    UniqueName="Displacement">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EstRetrofitCost" DataType="System.Decimal" 
                    DefaultInsertValue="" HeaderText="EstRetrofitCost" 
                    SortExpression="EstRetrofitCost" UniqueName="EstRetrofitCost">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DECSName" DefaultInsertValue="" 
                    HeaderText="DECSName" SortExpression="DECSName" UniqueName="DECSName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SerialNo" DefaultInsertValue="" 
                    HeaderText="SerialNo" SortExpression="SerialNo" UniqueName="SerialNo">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DECSManufacturer" DefaultInsertValue="" 
                    HeaderText="DECSManufacturer" ReadOnly="True" SortExpression="DECSManufacturer" 
                    UniqueName="DECSManufacturer">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DECSLevel" DefaultInsertValue="" 
                    HeaderText="DECSLevel" ReadOnly="True" SortExpression="DECSLevel" 
                    UniqueName="DECSLevel">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DECSModelNo" DefaultInsertValue="" 
                    HeaderText="DECSModelNo" SortExpression="DECSModelNo" UniqueName="DECSModelNo">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DECSInstallationDate" 
                    DataType="System.DateTime" DefaultInsertValue="" 
                    HeaderText="DECSInstallationDate" SortExpression="DECSInstallationDate" 
                    UniqueName="DECSInstallationDate" DataFormatString="{0:MM/dd/yyyy}">
                </telerik:GridBoundColumn>
            </Columns>
        

            <PagerStyle Mode="NextPrevNumericAndAdvanced" />
        </MasterTableView>
    </telerik:radgrid>
	<p>&nbsp;
		</p>

	<asp:SqlDataSource ID="sds_Vehicles" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	    SelectCommandType="StoredProcedure"
	    SelectCommand="ReportVehiclesDetails">
	    <SelectParameters>
	        <asp:ControlParameter ControlID="ddl_Fleet" Name="IDProfileFleet" PropertyName="SelectedValue"
				Type="Int32" />
	    </SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Terminal" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CF_Profile_Terminal] INNER JOIN [CF_UserTerminals] ON CF_Profile_Terminal.[IDProfileTerminal] = CF_UserTerminals.[IDProfileTerminal]  WHERE ([IDProfileAccount] = @IDProfileAccount AND [UserId] = @UserId AND PermissionLevel <> 'G') ORDER BY [TerminalName]">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
			<asp:Parameter Name="UserId" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>

