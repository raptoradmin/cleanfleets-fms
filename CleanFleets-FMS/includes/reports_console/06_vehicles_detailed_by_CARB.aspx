<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="06_vehicles_detailed_by_CARB.aspx.vb" Inherits="cleanfleets_fms._06_vehicles_detailed_by_CARB1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="RightColumnContentPlaceHolder" runat=server>
	<h1>
		Account Vehicle Report by Fleet</h1>
	<div id="qsfexWrapper">
		<table cellpadding="0" cellspacing="0" class="style1">
			<tr>
				<td class="tdtable" style="padding: 3px">
					<asp:Label ID="Label1" runat="server" AssociatedControlID="ddl_Account">Account:</asp:Label>
				</td>
				<td style="padding: 3px">
					<%--<telerik:RadComboBox ID="RadComboBox1" runat="server" 
                                    OnClientSelectedIndexChanging="Loadterminals" 
                                    OnItemsRequested="RadComboBox1_ItemsRequested" Width="300px" />--%>
					<asp:DropDownList ID="ddl_Account" runat="server" Width="300px" DataSourceID="sds_ddl_Account"
						DataTextField="AccountName" DataValueField="IDProfileAccount" AppendDataBoundItems="True"
						AutoPostBack="True" OnSelectedIndexChanged="ddl_Account_SelectedIndexChanged">
						<Items>
							<asp:ListItem Text="- Select Account -" Value="-1" />
                            <asp:ListItem Text="- All Accounts -" Value="0" />
						</Items>
					</asp:DropDownList>
				</td>
				<td width="50px" style="text-align:right;"><asp:Label ID="Label5" runat="server" AssociatedControlID="ddl_Terminal">Terminal:</asp:Label></td>
				<td><asp:DropDownList ID="ddl_Terminal" runat="server" Width="186px" AutoPostBack="True" OnSelectedIndexChanged="ddl_Terminal_SelectedIndexChanged" />
					<%--<asp:CustomValidator runat="server" id="cv_ddl_Terminal" ControlToValidate="ddl_Terminal"
						  OnServerValidate="cf_ddl_Validate" ErrorMessage="*" ValidateEmpty="true" />--%></td>
				<td width="50px" style="text-align:right;"><asp:Label ID="Label6" runat="server" AssociatedControlID="ddl_Fleet">Fleet:</asp:Label></td>
				<td><asp:DropDownList ID="ddl_Fleet" runat="server" Width="186px" AutoPostBack="True" 
					   OnSelectedIndexChanged="ddl_Fleet_SelectedIndexChanged" />
                     
					<%--<asp:CustomValidator runat="server" id="cv_ddl_Fleet" ControlToValidate="ddl_Fleet"
						  OnServerValidate="cf_ddl_Validate" ErrorMessage="*" ValidateEmpty="true" />--%></td>
			</tr>
			<tr>
				<td class="tdtable" style="padding: 3px">
					<asp:Label ID="Label2" runat="server" AssociatedControlID="ddl_CARBGroup">CARB Group:</asp:Label>
				</td>
				<td style="padding: 3px">
					<%--<telerik:RadComboBox ID="RadComboBox2" runat="server"
                                    OnClientItemsRequested="ItemsLoaded" OnClientSelectedIndexChanging="Loadfleets" 
                                    OnItemsRequested="RadComboBox2_ItemsRequested" Width="186px" />--%>
					<asp:DropDownList ID="ddl_CARBGroup" runat="server" Width="186px" DataSourceID="sds_ddl_Op_CARBGroup"
						DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="True" 
						AutoPostBack="True" OnSelectedIndexChanged="ddl_CARBGroup_SelectedIndexChanged">
						<asp:ListItem Text="- Select -" Value="0" />
					</asp:DropDownList>
				</td>
			</tr>
			<tr>
				<td class="tdtable" style="padding: 3px">
					<asp:Label ID="Label3" runat="server" AssociatedControlID="ddl_RuleCode">Rule Code:</asp:Label>
				</td>
				<td style="padding: 3px">
					<%--<telerik:RadComboBox ID="RadComboBox2" runat="server"
                                    OnClientItemsRequested="ItemsLoaded" OnClientSelectedIndexChanging="Loadfleets" 
                                    OnItemsRequested="RadComboBox2_ItemsRequested" Width="186px" />--%>
					<asp:DropDownList ID="ddl_RuleCode" runat="server" Width="186px" 
						  	    DataSourceID="sds_ddl_RuleCode"
						        DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="True" 
								AutoPostBack="True" OnSelectedIndexChanged="ddl_RuleCode_SelectedIndexChanged">
								<asp:ListItem Selected="true" Text="- Select -" Value="0" />
							  </asp:DropDownList>
				</td>
			</tr>
			<tr>
				<td class="tdtable" style="padding: 3px">&nbsp;
					<asp:Button ID="btn_Query" runat="server" Text="Query"  />
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
		allowpaging="True" runat="server" gridlines="None" onload="rg_Terminals_OnLoad" >
        <ExportSettings HideStructureColumns="true" ExportOnlyData="True" IgnorePaging="True" />
        <MasterTableView Width="100%" CommandItemDisplay="Top" AutoGenerateColumns="False" 
                           DataSourceID="sds_Vehicles">
        

            <CommandItemSettings ShowExportToCsvButton="True" />
        

            <Columns>
				<telerik:GridBoundColumn DataField="AccountName" DefaultInsertValue="" 
                    HeaderText="Account" SortExpression="AccountName" 
                    UniqueName="AccountName">
				</telerik:GridBoundColumn>
				 <telerik:GridBoundColumn DataField="TerminalName" DefaultInsertValue="" 
                    HeaderText="Terminal" SortExpression="TerminalName" 
                    UniqueName="TerminalName">
                </telerik:GridBoundColumn>
				<telerik:GridBoundColumn DataField="FleetName" DefaultInsertValue="" 
                    HeaderText="Fleet" SortExpression="FleetName" 
                    UniqueName="FleetName">
				</telerik:GridBoundColumn>
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
               <%-- <telerik:GridBoundColumn DataField="EquipmentCategory" DefaultInsertValue="" 
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
				<telerik:GridBoundColumn DataField="ChassisModel" DefaultInsertValue="" 
                    HeaderText="Model" SortExpression="ChassisModel" 
                    UniqueName="ChassisModel" ReadOnly="True">
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
				<telerik:GridBoundColumn DataField="ActualInServiceDate" 
                    DataType="System.DateTime" DefaultInsertValue="" 
                    HeaderText="ActualInServiceDate" SortExpression="ActualInServiceDate" 
                    UniqueName="ActualInServiceDate" DataFormatString="{0:MM/dd/yyyy}">
                </telerik:GridBoundColumn>
				<telerik:GridBoundColumn DataField="EstimatedInServiceDate" 
                    DataType="System.DateTime" DefaultInsertValue="" 
                    HeaderText="EstimatedInServiceDate" SortExpression="EstimatedInServiceDate" 
                    UniqueName="EstimatedInServiceDate" DataFormatString="{0:MM/dd/yyyy}">
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
				<telerik:GridBoundColumn DataField="Notes" 
                    DefaultInsertValue="" HeaderText="Notes" 
                    SortExpression="Notes" UniqueName="Notes">
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
	        <asp:ControlParameter ControlID="ddl_Account" Name="IDProfileAccount" PropertyName="SelectedValue"
				Type="Int32" />
			<asp:ControlParameter ControlID="ddl_Terminal" Name="IDProfileTerminal" PropertyName="SelectedValue"
				Type="Int32" />
			<asp:ControlParameter ControlID="ddl_Fleet" Name="IDProfileFleet" PropertyName="SelectedValue"
				Type="Int32" />
			<asp:ControlParameter ControlID="ddl_CARBGroup" Name="IDCARBGroup" PropertyName="SelectedValue"
				Type="Int32" />
			<asp:ControlParameter ControlID="ddl_RuleCode" Name="IDRuleCode" PropertyName="SelectedValue"
				Type="Int32" />
	    </SelectParameters>
	</asp:SqlDataSource>
	
	
	<asp:SqlDataSource ID="sds_ddl_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CF_Profile_Account] ORDER BY [AccountName]"></asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_CARBGroup" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = 'CARBGroup') ORDER BY [DisplayValue]">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_RuleCode" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT * FROM [CF_Option_List] WHERE OptionName = 'RuleCode' ORDER BY [DisplayValue]"></asp:SqlDataSource>
</asp:Content>
