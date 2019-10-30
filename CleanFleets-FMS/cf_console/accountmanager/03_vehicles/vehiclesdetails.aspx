<%@ Page Title="" Language="vb" Debug="true" MaintainScrollPositionOnPostback="true" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="vehiclesdetails.aspx.vb" Inherits="cleanfleets_fms.vehiclesdetails1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
	<telerik:radcodeblock id="RadCodeBlock1" runat="server">

            <script type="text/javascript">

            	function RowClick(sender, eventArgs) {
            		var MasterTableView = eventArgs.get_tableView();
            		var dataKeyValue = eventArgs.getDataKeyValue("IDImages");
            		var oWnd = radopen("../../../includes/imagemanager/imagedisplay.aspx?IDImages=" + dataKeyValue);
            	}

            	function MyClickVehicles(sender, eventArgs) {
            		var inputs = document.getElementById("<%= rg_VehicleImages.MasterTableView.ClientID %>").getElementsByTagName("input");
            		for (var i = 0, l = inputs.length; i < l; i++) {
            			var input = inputs[i];
            			if (input.type != "radio" || input == sender)
            				continue;
            			input.checked = false;
            		}

                

            	}

            	function MyClickEngines(sender, eventArgs) {
            		var inputs = document.getElementById("<%= rg_EngineImages.MasterTableView.ClientID %>").getElementsByTagName("input");
            		for (var i = 0, l = inputs.length; i < l; i++) {
            			var input = inputs[i];
            			if (input.type != "radio" || input == sender)
            				continue;
            			input.checked = false;
            		}
            	}

            	function MyClickDECS(sender, eventArgs) {
            		var inputs = document.getElementById("<%= rg_DECSImages.MasterTableView.ClientID %>").getElementsByTagName("input");
            		for (var i = 0, l = inputs.length; i < l; i++) {
            			var input = inputs[i];
            			if (input.type != "radio" || input == sender)
            				continue;
            			input.checked = false;
            		}
            	}
            </script>            

         </telerik:radcodeblock>
	<style type="text/css">
		.RadPicker_Default
		{
			vertical-align: middle;
		}
		.RadPicker_Default .RadInput
		{
			vertical-align: baseline;
		}
		.RadInput_Default
		{
			font: 12px "segoe ui" ,arial,sans-serif;
		}
		.RadInput
		{
			vertical-align: middle;
		}
	</style>

	

</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">

    <%--Added by Andrew on 10/25/2019--%>

    <asp:textbox id="ChassisVINHolder" runat="server" />

    <%--End of what was added by Andrew on 10/25/2019--%>

	<asp:FormView ID="FormView1" runat="server" DataKeyNames="IDProfileAccount,IDProfileTerminal,IDProfileFleet"
		DataSourceID="sds_CFV_Fleet_Lineage" Width="800px">
		<EditItemTemplate>
		</EditItemTemplate>
		<InsertItemTemplate>
		</InsertItemTemplate>
		<ItemTemplate>
			<div runat="server" Visible='<%# Request.QueryString("VehicleSearch") > ""  %>'>
				<asp:HyperLink
					ID="HyperLink2" runat="server" NavigateUrl='<%# "vehiclesearch.aspx?VehicleSearch=" & Request.QueryString("VehicleSearch") %>'
					Text='&laquo; Return To Search Results' ></asp:HyperLink>
			</div>
			<span style="font-size: medium; font-weight: bold; color: #2C7500">Account:</span>&nbsp;<asp:HyperLink
				ID="hl_AcoountDetails" runat="server" NavigateUrl='<%# Eval("IDProfileAccount", "../account_details.aspx?IDProfileAccount={0}") & "&IDProfileTerminal=" & Eval("IDProfileTerminal") %>'
				Text='<%# Eval("AccountName") %>'></asp:HyperLink>
			&nbsp;<span style="font-size: medium; font-weight: bold; color: #2C7500">Terminal:</span>&nbsp;<asp:HyperLink
				ID="hl_TerminalDetails" runat="server" NavigateUrl='<%# Eval("IDProfileTerminal", "../01_terminals/terminaldetails.aspx?IDProfileTerminal={0}") & "&IDProfileAccount=" & Eval("IDProfileAccount") %>'
				Text='<%# Eval("TerminalName") %>'></asp:HyperLink>
			&nbsp;<span style="font-size: medium; font-weight: bold; color: #2C7500">Fleet:</span>&nbsp;<asp:HyperLink
				ID="hl_FleetList" runat="server" NavigateUrl='<%# Eval("IDProfileAccount", "../02_fleets/fleet.aspx?IDProfileAccount={0}") & "&IDProfileTerminal=" & Eval("IDProfileTerminal") %>'
				Text='<%# Eval("FleetName") %>'></asp:HyperLink>
			&nbsp;<span style="font-size: medium; font-weight: bold; color: #2C7500">Vehicles:</span>&nbsp;<asp:HyperLink
				ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("IDProfileFleet", "vehicles.aspx?IDProfileFleet={0}") & "&IDProfileTerminal=" & Eval("IDProfileTerminal") & "&IDProfileAccount=" & Eval("IDProfileAccount") %>'
				Text='<%# Eval("FleetName") %>'></asp:HyperLink>
			
		</ItemTemplate>
	</asp:FormView>
	<br />
	<telerik:radtabstrip id="rtp_Vehicles" runat="server" multipageid="rmp_Vehicle" selectedindex="0">
                                <tabs>
                                    <telerik:RadTab runat="server" Text="Vehicle Details" 
                                        PageViewID="rpv_VehicleDetails" Selected="True">
                                    </telerik:RadTab>
                                    <telerik:RadTab runat="server" Text="Engine Details" PageViewID="rpv_Engines">
                                    </telerik:RadTab>
                                    <telerik:RadTab runat="server" PageViewID="rpv_VehicleFiles" Text="Vehicle Files">
                                    </telerik:RadTab>
                                    <telerik:RadTab runat="server" PageViewID="rpv_Reports" Text="Reports">
                                    </telerik:RadTab>
                                    <telerik:RadTab runat="server" Text="DPF Cleaning Record" PageViewID="rpv_DPFCleaning">
                                    </telerik:RadTab>
                                </tabs>
                            </telerik:radtabstrip>
	<telerik:radmultipage id="rmp_Vehicle" runat="server" selectedindex="0">
    <telerik:RadPageView ID="rpv_VehicleDetails" runat="server">

<table cellpadding="0" style="width: 920px; border-collapse: collapse; border: 1px solid #9B9B9B">
            <tr>
                <td>
                    <asp:FormView ID="fv_CFV_Vehicles" runat="server" CellPadding="5" 
                        DataKeyNames="IDVehicles" DataSourceID="sds_CFV_Vehicles_fv" 
                        Width="700px">
                        <EditItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Unit No:
                                    </td>
                                    <td style="width: 102px;">
                                        <asp:TextBox ID="UnitNoTextBox" runat="server" Text='<%# Bind("UnitNo") %>' Width="75px" />
                                    </td>
                                    <td style="width: 83px; " class="tdtable">
                                        VIN: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:TextBox ID="ChassisVINTextBox" runat="server" Text='<%# Bind("ChassisVIN") %>' />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ChassisVINTextBox" ErrorMessage="*" style="font-size: x-large"></asp:RequiredFieldValidator>
										<asp:CustomValidator ID="VINValidator" runat="server" ControlToValidate="ChassisVINTextBox" 
										  OnServerValidate="UniqueVINValidator"
										  ErrorMessage="<br>This VIN is already in use by another Vehicle"></asp:CustomValidator>
                                    </td>
                                   
                                </tr>
                                <tr>
									<!--10/02/2012 IR: Editing td widths and valign-->
									<td style="width: 125px; " class="tdtable">
										License Plate State:
									</td>
									<!--10/02/2012 IR: Chaged Value from "0" to "" to enable validator to function properly-->
									<td valign="middle" width="200px">
                                        <asp:DropDownList ID="ddl_LicensePlateState" runat="server" 
                                            AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_State" 
											OnDataBinding="PreventErrorOnbinding"
                                            DataTextField="DisplayValue" DataValueField="RecordValue" 
                                            SelectedValue='<%# Bind("LicensePlateState") %>'
											CssClass="forest">
											
                                            <asp:ListItem Text="Select" Value="" />
                                        </asp:DropDownList>
										<asp:RequiredFieldValidator ID="LicensePlateStateValidator" runat="server" ControlToValidate="ddl_LicensePlateState" ErrorMessage="*" style="font-size: x-large"></asp:RequiredFieldValidator>
                                    </td>	
                                    <td style="width: 90px; " class="tdtable">
                                        License No:</td>
                                    <td style="width: 102px;">
                                        <asp:TextBox ID="LicensePlateNoTextBox" runat="server" Text='<%# Bind("LicensePlateNo") %>' Width="75px" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="LicensePlateNoTextBox" ErrorMessage="*" style="font-size: x-large"></asp:RequiredFieldValidator>
                                    </td>
                                    <td style="width: 83px; " class="tdtable">
                                        GVW:
                                    </td>
                                    <td style="width: 190px">
                                        <asp:TextBox ID="tbx_GrossVehicleWeight" runat="server" 
                                            Text='<%# Bind("GrossVehicleWeight") %>' Width="75px" />
                                    </td>
                                    <td style="width: 100px; " class="tdtable">
                                        &#160;</td>
                                    <td>
                                        &#160;</td>
                                </tr>
								<tr><td colspan="6">
								<asp:CustomValidator ID="LicensePlateNoValidator" runat="server" ControlToValidate="LicensePlateNoTextBox" 
										  OnServerValidate="UniqueLicensePlateNoValidator"
										  ErrorMessage="This License Plate is already registered to another Vehicle"></asp:CustomValidator>
								<asp:RegularExpressionValidator ID="regexp_tbx_GrossVehicleWeight" runat="server"     
                                    ErrorMessage="Invalid Gross Vehicle Weight." 
                                    ControlToValidate="tbx_GrossVehicleWeight"     
                                    ValidationExpression="(?i:^([0-9,.]*|(\?|na|n/a))$)" />
								</td></tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td>
                                        &#160;</td>
                                </tr>
                            </table>
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Annual Miles:
                                    </td>
                                    <td style="width: 67px">
                                        <asp:TextBox ID="AnnualMilesTextBox" runat="server" Text='<%# Bind("AnnualMiles") %>' Width="60px" />
                                    </td>
                                    <td style="width: 117px; " class="tdtable">
                                        Equip. Type:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddl_EquipType" runat="server" AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_EquipType" DataTextField="DisplayValue" DataValueField="IDOptionList" SelectedValue='<%# Bind("IDEquipmentType") %>' CssClass="forest">
                                            <asp:ListItem Text="Select" Value="0" />
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 155px; " class="tdtable">
                                        Est. Rep. Cost:</td>
                                    <td>
                                        <asp:TextBox ID="tbx_EstReplacementCost" runat="server" Text='<%# Bind("EstReplacementCost") %>' Width="60px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Annual Hours:
                                    </td>
                                    <td style="width: 67px">
                                        <asp:TextBox ID="AnnualHoursTextBox" runat="server" Text='<%# Bind("AnnualHours") %>' Width="60px" />
                                    </td>
                                    <%--<td style="width: 117px; " class="tdtable">
                                        Equip. Category:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddl_EquipCat" runat="server" AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_EquipCat" DataTextField="DisplayValue" DataValueField="IDOptionList" SelectedValue='<%# Bind("IDEquipmentCategory") %>' CssClass="forest">
                                            <asp:ListItem Text="Select" Value="0" />
                                        </asp:DropDownList>
                                    </td>--%>
                                    <td style="width: 117px; " class="tdtable"> 
                                       Do we have the vehicle key: 
                                    </td> 
                                    <td> 
                                    <asp:DropDownList ID="ddl_VehicleKey" runat="server" 
                                        AppendDataBoundItems="True" DataSourceID="sds_ddl_VehicleKey" 
                                        OnDataBinding="PreventErrorOnbinding" 
                                        DataTextField="DisplayValue" DataValueField="IDOptionList"  
                                        SelectedValue='<%# Bind("IDVehicleKey") %>'  
                                        CssClass="forest"> 
                                            <asp:ListItem Text="Select" Value="0" /> 
                                    </asp:DropDownList> 
                                    </td> 
								<%--	<td style="width: 117px; " class="tdtable">
                                        Special Provision:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddl_SpecialProvision" runat="server" 
										  AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_SpecialProvision" 
										  OnDataBinding="PreventErrorOnbinding"
										  DataTextField="DisplayValue" DataValueField="IDOptionList" 
										  SelectedValue='<%# Bind("IDSpecialProvision") %>' 
										  CssClass="forest">
                                            <asp:ListItem Text="Select" Value="0" />
                                        </asp:DropDownList>
                                    </td>--%>
                                    <td style="width: 155px; " class="tdtable">
                                        Make: </td>
                                    <td>
                                        <asp:DropDownList ID="ddl_ChassisMake" runat="server" 
                                            AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_ChassisMake" 
											OnDataBinding="PreventErrorOnbinding"
                                            DataTextField="DisplayValue" DataValueField="IDOptionList" 
                                            SelectedValue='<%# Bind("IDChassisMake") %>'
											CssClass="forest">
                                            <asp:ListItem Text="Select" Value="0" />
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Actual Miles:
                                    </td>
                                    <td style="width: 67px">
                                        <asp:TextBox ID="ActualMilesTextBox" runat="server" Text='<%# Bind("ActualMiles") %>' Width="60px" />
                                    </td>
                                    <td style="width: 117px; " class="tdtable">
                                        Vehicle Status:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddl_VehStatus" runat="server" 
										  AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_VehStatus" 
										  DataTextField="DisplayValue" DataValueField="IDOptionList" 
										  SelectedValue='<%# Bind("IDVehicleStatus") %>' 
										  CssClass="forest">
                                            <asp:ListItem Text="Select" Value="0" />
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 155px; " class="tdtable">
                                        Model:</td>
                                    <td>
                                        <asp:TextBox ID="tbx_ChassisModel" runat="server" 
                                            Text='<%# Bind("ChassisModel") %>' Width="120px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Actual Hours:
                                    </td>
                                    <td style="width: 67px">
                                        <asp:TextBox ID="ActualHoursTextBox" runat="server" Text='<%# Bind("ActualHours") %>' Width="60px" />
                                    </td>
                                    <td style="width: 117px; " class="tdtable">
                                        CARB Group:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddl_CARBGroup" runat="server" AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_CARBGroup" DataTextField="DisplayValue" DataValueField="IDOptionList" SelectedValue='<%# Bind("IDCARBGroup") %>' CssClass="forest">
                                            <asp:ListItem Text="Select" Value="0" />
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 155px; " class="tdtable">
                                        Model Year: </td>
                                    <td>
                                        <asp:DropDownList ID="ddl_ChassisModelYear" runat="server" 
                                            AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_Year" 
                                            DataTextField="DisplayValue" DataValueField="IDOptionList" 
                                            SelectedValue='<%# Bind("IDChassisModelYear") %>'
											CssClass="forest">
                                            <asp:ListItem Text="Select" Value="0" />
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td>
                                        &#160;</td>
                                </tr>
                            </table>
                            <table>
								<tr>
									<td style="width: 175px; " class="tdtable">
                                        Actual In-Service Date:</td>
                                    <td style="width: 130px">
                                        <telerik:RadDatePicker ID="rdp_ActualInServiceDate" Runat="server" Culture="English (United States)" DbSelectedDate='<%# Bind("ActualInServiceDate") %>' Width="90px">
                                            <calendar usecolumnheadersasselectors="False" userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" enabledstyle-horizontalalign="Center">
                                                <enabledstyle horizontalalign="Center" />
                                            </dateinput>
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td style="width: 171px; " class="tdtable">
                                        Estimated In-Service By Date:</td>
                                    <td>
                                       <asp:DropDownList ID="ddl_EstimatedInServiceDate" runat="server" 
                                            AppendDataBoundItems="True" DataSourceID="sds_ddl_CF_Milestones" 
                                            DataTextField="MilestoneDate" DataValueField="MilestoneDate" 
											DataTextFormatString = "{0:MM/dd/yyyy}"
                                            SelectedValue='<%# Bind("EstimatedInServiceDate") %>'
											CssClass="forest">
                                            <asp:ListItem Text="Select" Value="" />
                                        </asp:DropDownList>
                                    </td>
								</tr>
                                <tr>
                                    <td style="width: 175px; " class="tdtable">
                                        Planned Compliance Date:</td>
                                    <td style="width: 130px">
                                        <telerik:RadDatePicker ID="rdp_PlannedComplianceDate" Runat="server" Culture="English (United States)" DbSelectedDate='<%# Bind("PlannedComplianceDate") %>' Width="90px">
                                            <calendar usecolumnheadersasselectors="False" userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" enabledstyle-horizontalalign="Center">
                                                <enabledstyle horizontalalign="Center" />
                                            </dateinput>
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td style="width: 171px; " class="tdtable">
                                        Planned Retirement Date:</td>
                                    <td>
                                        <telerik:RadDatePicker ID="rdp_PlannedRetirementDate" Runat="server" Culture="English (United States)" DbSelectedDate='<%# Bind("PlannedRetirementDate") %>' Width="90px">
                                            <calendar usecolumnheadersasselectors="False" userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" enabledstyle-horizontalalign="Center">
                                                <enabledstyle horizontalalign="Center" />
                                            </dateinput>
                                        </telerik:RadDatePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 175px; " class="tdtable">
                                        Actual Compliance Date:</td>
                                    <td style="width: 130px">
                                        <telerik:RadDatePicker ID="rdp_ActualComplianceDate" Runat="server" Culture="English (United States)" DbSelectedDate='<%# Bind("ActualComplianceDate") %>' Width="90px">
                                            <calendar usecolumnheadersasselectors="False" userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" enabledstyle-horizontalalign="Center">
                                                <enabledstyle horizontalalign="Center" />
                                            </dateinput>
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td style="width: 171px; " class="tdtable">
                                        Actual Retirement Date:</td>
                                    <td>
                                        <telerik:RadDatePicker ID="rdp_ActualRetirementDate" Runat="server" Culture="English (United States)" DbSelectedDate='<%# Bind("ActualRetirementDate") %>' Width="90px">
                                            <calendar usecolumnheadersasselectors="False" userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" enabledstyle-horizontalalign="Center">
                                                <enabledstyle horizontalalign="Center" />
                                            </dateinput>
                                        </telerik:RadDatePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 175px; " class="tdtable">
                                        Backup Status Date:</td>
                                    <td style="width: 130px">
                                        <telerik:RadDatePicker ID="rdp_BackupStatusDate" Runat="server" Culture="English (United States)" DbSelectedDate='<%# Bind("BackupStatusDate") %>' Width="90px">
                                            <calendar usecolumnheadersasselectors="False" userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" enabledstyle-horizontalalign="Center">
                                                <enabledstyle horizontalalign="Center" />
                                            </dateinput>
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td style="width: 171px; " class="tdtable">
                                        Retire Status Date:</td>
                                    <td>
                                        <telerik:RadDatePicker ID="rdp_RetireStatusDate0" Runat="server" Culture="English (United States)" DbSelectedDate='<%# Bind("RetireStatusDate") %>' Width="90px">
                                            <calendar usecolumnheadersasselectors="False" userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" enabledstyle-horizontalalign="Center">
                                                <enabledstyle horizontalalign="Center" />
                                            </dateinput>
                                        </telerik:RadDatePicker>
                                    </td>
                                </tr>
								<tr>
									<td style="width: 175px; " class="tdtable">
                                    	Last Opacity Test Date:</td>
									<td style="width: 130px"> 
										<telerik:RadDatePicker ID="rdp_LastOpacityTestDate" Runat="server" Culture="English (United States)" DbSelectedDate='<%# Bind("LastOpacityTestDate") %>' Width="90px">
                                            <calendar usecolumnheadersasselectors="False" userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" enabledstyle-horizontalalign="Center">
                                                <enabledstyle horizontalalign="Center" />
                                            </dateinput>
                                        </telerik:RadDatePicker></td>
									<td style="width: 171px; " class="tdtable"></td>
									<td></td>
								</tr>
                            </table>
                            <br />
                            <br />
                            <br />
                            <br />
                            <span style="color: #2C7500"><b>
                            Description:</b></span><br />
                            &#160;
                            <table style="width: 100%">
                                <tr>
                                    <td width="25px">
                                        &#160;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="DescriptionTextBox0" runat="server" Height="65px" 
                                            Text='<%# Bind("Description") %>' TextMode="MultiLine" Width="650px" />
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <span style="color: #2C7500"><b>
                            Notes:</b></span><br />
                            <table style="width: 100%">
                                <tr>
                                    <td width="25px">
                                        &#160;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NotesTextBox" runat="server" Height="65px" 
                                            Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="650px" />
                                        <br />
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <b><span style="color: #2C7500">
                            Internal Notes:</span></b><br />
                            <table style="width: 100%">
                                <tr>
                                    <td width="25px">
                                        &#160;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NotesCFTextBox" runat="server" Height="65px" 
                                            Text='<%# Bind("NotesCF") %>' TextMode="MultiLine" Width="650px" />
                                    </td>
                                </tr>
                            </table>
                            &#160;<br />
                            <asp:Button ID="ubtn_CFV_Vehicles" runat="server" CausesValidation="True" 
                                CommandName="Update" Text="Update" />
                            &#160;<asp:Button ID="ubtnc_CFV_Vehicles" runat="server" CausesValidation="False" 
                                CommandName="Cancel" Text="Cancel" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Unit No:</td>
                                    <td style="width: 100px">
                                        <asp:Label ID="lbl_UnitNo0" runat="server" Text='<%# Bind("UnitNo") %>' />
                                    </td>
                                    <td style="width: 100px; " class="tdtable">
                                        VIN:</td>
                                    <td width="100px">
                                        <asp:Label ID="lbl_ChVIN0" runat="server" Text='<%# Bind("ChassisVIN") %>' />
                                    </td>
                                    <td style="width: 100px; " class="tdtable">
                                        &#160;</td>
                                    <td width="100px">
                                        &#160;</td>
                                </tr>
                                <tr>
									<td style="width: 90px; " class="tdtable">
										License Plate State:</td>
									<td>
                                        <asp:Label ID="lbl_LicensePlateState" runat="server" Text='<%# Bind("LicensePlateState") %>' Width="45px" />
                                       
                                    </td>	
                                    <td style="width: 90px; " class="tdtable">
                                        License No:
                                    </td>
                                    <td style="width: 100px">
                                        <asp:Label ID="lbl_LicenseNo0" runat="server" Text='<%# Bind("LicensePlateNo") %>' />
                                    </td>
                                    <td style="width: 100px; " class="tdtable">
                                        GVW: </td>
                                    <td width="100px">
                                        <asp:Label ID="lbl_GrossVehicleWeight" runat="server" 
                                            Text='<%# Eval("GrossVehicleWeight") %>' />
                                    </td>
                                    <td style="width: 100px; " class="tdtable">
                                        </td>
                                    <td width="100px">
                                        </td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td>
                                        &#160;</td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td style="width: 95px; " class="tdtable">
                                        Estimated Annual Miles:
                                    </td>
                                    <td style="width: 95px">
                                        <asp:Label ID="lbl_AnMiles0" runat="server" Text='<%# Bind("AnnualMiles") %>' DataFormatString="{0:n0}"/>
                                    </td>
                                    <td style="width: 105px; " class="tdtable">
                                        Equip. Type:
                                    </td>
                                    <td style="width: 115px">
                                        <asp:Label ID="lbl_EqType0" runat="server" 
                                            Text='<%# Bind("EquipmentType") %>' />
                                    </td>
                                    <td class="tdtable">
                                        Est. Rep. Cost</td>
                                    <td>
                                        <asp:Label ID="lbl_EstRepCost" runat="server" Text='<%# Bind("EstReplacementCost", "{0:c}") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 95px;" class="tdtable">
                                        Estimated Annual Hours:
                                    </td>
                                    <td style="width: 95px">
                                        <asp:Label ID="lbl_AnHours0" runat="server" Text='<%# Bind("AnnualHours") %>' DataFormatString="{0:n0}"/>
                                    </td>
                                    <%--<td style="width: 105px; " class="tdtable">
                                        Equip. Category:
                                    </td>
                                    <td style="width: 115px">
                                        <asp:Label ID="lbl_EqCategory0" runat="server" 
                                            Text='<%# Bind("EquipmentCategory") %>' />
                                    </td>--%>
                                    <td style="width: 105px; " class="tdtable">
                                        Do we have the vehicle key:
                                    </td>
                                    <td style="width: 115px"> 
                                        <asp:Label ID="lbl_VehicleKey" runat="server"  
                                            Text='<%# Bind("InPossession") %>' /> 
                                    </td> 

                                    <%--<td style="width: 105px; " class="tdtable">
                                        Special Provision:
                                    </td>
                                    <td style="width: 115px">
                                        <asp:Label ID="lbl_SpecialProvision0" runat="server" 
                                            Text='<%# Bind("SpecialProvision") %>' />
                                    </td>--%>
                                    <td class="tdtable">
                                        Make:</td>
                                    <td>
                                        <asp:Label ID="lbl_ChMake0" runat="server" Text='<%# Bind("ChassisMake") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 95px; " class="tdtable">
                                        Actual Miles:
                                    </td>
                                    <td style="width: 95px">
                                        <asp:Label ID="lbl_AcMiles0" runat="server" Text='<%# Bind("ActualMiles") %>' />
                                    </td>
                                    <td style="width: 105px; " class="tdtable">
                                        Vehicle Status:
                                    </td>
                                    <td style="width: 115px">
                                        <asp:Label ID="lbl_VehStatus0" runat="server" 
                                            Text='<%# Bind("VehicleStatus") %>' />
                                    </td>
                                    <td class="tdtable">
                                        Model:</td>
                                    <td>
                                        <asp:Label ID="lbl_ChModel" runat="server" Text='<%# Bind("ChassisModel") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 95px; " class="tdtable">
                                        Actual Hours:
                                    </td>
                                    <td style="width: 95px">
                                        <asp:Label ID="lbl_AcHours0" runat="server" Text='<%# Bind("ActualHours") %>' />
                                    </td>
                                    <td style="width: 105px; " class="tdtable">
                                        CARB Group:
                                    </td>
                                    <td style="width: 115px">
                                        <asp:Label ID="lbl_CARBGroup0" runat="server" Text='<%# Bind("CARBGroup") %>' />
                                    </td>
                                    <td class="tdtable">
                                        Model Year:</td>
                                    <td>
                                        <asp:Label ID="lbl_ChModYear0" runat="server" 
                                            Text='<%# Bind("ChassisModelYear") %>' />
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td>
                                        &#160;</td>
                                </tr>
                            </table>
                            <table>
								<tr>
                                    <td style="width: 175px; " class="tdtable">
                                        Actual In-Service Date:</td>
                                    <td style="width: 130px">
                                        <asp:Label ID="lbl_ActualInServiceDate" runat="server" Text='<%# Bind("ActualInServiceDate", "{0:MM/dd/yyyy}") %>' />
                                    </td>
                                    <td style="width: 171px; " class="tdtable">
                                        Estimated In-Service Date:</td>
                                    <td>
                                        <asp:Label ID="lbl_EstimatedInServiceDate" runat="server" Text='<%# Bind("EstimatedInServiceDate", "{0:MM/dd/yyyy}") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 175px; " class="tdtable">
                                        Planned Compliance Date:</td>
                                    <td style="width: 130px">
                                        <asp:Label ID="lbl_PlanComplDate0" runat="server" Text='<%# Bind("PlannedComplianceDate", "{0:MM/dd/yyyy}") %>' />
                                    </td>
                                    <td style="width: 171px; " class="tdtable">
                                        Planned Retirement Date:</td>
                                    <td>
                                        <asp:Label ID="lbl_PlannedRetirementDate" runat="server" Text='<%# Bind("PlannedRetirementDate", "{0:MM/dd/yyyy}") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 175px; " class="tdtable">
                                        Actual Compliance Date:</td>
                                    <td style="width: 130px">
                                        <asp:Label ID="lbl_ActCompDate0" runat="server" Text='<%# Bind("ActualComplianceDate", "{0:MM/dd/yyyy}") %>' />
                                    </td>
                                    <td style="width: 171px; " class="tdtable">
                                        Actual Retirement Date:</td>
                                    <td>
                                        <asp:Label ID="lbl_ActualRetirementDate" runat="server" Text='<%# Bind("ActualRetirementDate", "{0:MM/dd/yyyy}") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 175px; " class="tdtable">
                                        Backup Status Date:</td>
                                    <td style="width: 130px">
                                        <asp:Label ID="lbl_BackStatDate0" runat="server" Text='<%# Bind("BackupStatusDate", "{0:MM/dd/yyyy}") %>' />
                                    </td>
                                    <td style="width: 171px; " class="tdtable">
                                        Retire Status Date:</td>
                                    <td>
                                        <asp:Label ID="lbl_RetStatDate0" runat="server" Text='<%# Bind("RetireStatusDate", "{0:MM/dd/yyyy}") %>' />
                                    </td>
                                </tr>
								<tr>
									<td style="width: 175px; " class="tdtable">
                                        Last Opacity Test Date:</td>
                                    <td style="width: 130px">
										<asp:Label ID="lbl_LastOpacityDate" runat="server" Text='<%# Bind("LastOpacityTestDate", "{0:MM/dd/yyyy}") %>' />
                                    </td>
									<td style="width: 171px; " class="tdtable">
									</td>
								</tr>
                            </table>
                            <br />
                            <br />
                            <span style="color: #2C7500"><b>Description:<br />
                            </b></span>&#160;<table style="width: 400px">
                                <tr>
                                    <td width="25px">
                                        &#160;
                                    </td>
                                    <td>
                                        <div class="divlblScrollText">
                                            <asp:Label ID="DescriptionLabel0" runat="server" Text='<%# Eval("Description").ToString().Replace(Environment.NewLine, "<br />") %>' />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <span style="color: #2C7500"><b>
                            Notes:<br />
                            </b></span>
                            <br />
                            <table style="width: 400px">
                                <tr>
                                    <td width="25px">
                                        &#160;
                                    </td>
                                    <td>
                                        <div class="divlblScrollText">
                                            <asp:Label ID="NotesLabel0" runat="server" 
                                                Text='<%# Eval("Notes").ToString().Replace(Environment.NewLine, "<br />") %>' />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <b><span style="color: #2C7500">
                            Internal Notes:<br />
                            </span></b>
                            <br />
                            <table style="width: 400px">
                                <tr>
                                    <td width="25px">
                                        &#160;
                                    </td>
                                    <td>
                                        <div class="divlblScrollText">
                                            <asp:Label ID="NotesCFLabel0" runat="server" Text='<%# Eval("NotesCF").ToString().Replace(Environment.NewLine, "<br />") %>' />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" 
                                CommandName="Edit" Text="Edit" />
                            <asp:Button ID="btn_DeleteVehicle" runat="server" Text="Delete" OnClick="btn_DeleteVehicle_Click"/>
                            <asp:Button ID="btn_TransferVehicle" runat="server" OnClick="btn_TransferVehicle_Click" Text="Transfer" />
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            Please select a vehicle.
                        </EmptyDataTemplate>
                    </asp:FormView>
                </td>
                <td valign="top" 
                    style="padding: 5px; border-left-style: solid; border-left-width: 1px; border-left-color: #9B9B9B">
                             
                    <asp:FormView ID="fv_VehicleImage" runat="server" DataKeyNames="IDImages" DataSourceID="sds_ImagesVehicle_fvw">
                        <ItemTemplate>
                            <asp:Image ID="image" runat="server" ImageUrl='<%# Eval("Image") + "?Width=200" %>' Width="200" />
                        </ItemTemplate>
                    </asp:FormView>
                             
                </td>
            </tr>
            <tr>
                <td>
                    <h4>Opacity Test Results</h4>
                    <telerik:RadGrid ID="rgd_LogOpacityTests" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AutoGenerateDeleteColumn="True" AutoGenerateEditColumn="True" DataSourceID="sds_OpacityTestsLog" GridLines="None" ShowFooter="True" CssClass="radgrid">
                        <mastertableview CommandItemDisplay="Top" autogeneratecolumns="false" datakeynames="IDOpacityTestsLog" datasourceid="sds_OpacityTestsLog">
                            <Columns>
                                <telerik:GridBoundColumn DataField="AverageOpacity" DataType="System.Decimal" HeaderText="Average Opacity" SortExpression="AverageOpacity" UniqueName="AverageOpacity" DataFormatString="{0:n}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TestResult" DataType="System.String" HeaderText="Test Result" SortExpression="TestResult" UniqueName="TestResult" DataFormatString="{0}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TestedBy" DataType="System.String" HeaderText="Tested By" SortExpression="TestedBy" UniqueName="TestedBy" DataFormatString="{0}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TestDate" DataType="System.DateTime" HeaderText="Test Date" SortExpression="TestDate" UniqueName="TestDate" DataFormatString="{0:d}">
                                </telerik:GridBoundColumn>
                            </Columns>
                        <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                                <h2>Opacity Test Entry</h2>
                                <table cellpadding="0" cellspacing="0" style="width: 100%">
									<tr>
                                        <td  style="width: 98px">
                                           Average Opacity: </td>
                                        <td style="width: 210px">
                                            <asp:TextBox ID="tbx_AverageOpacity" Text='<%# Bind("AverageOpacity") %>' runat="server"></asp:TextBox>
											<asp:RegularExpressionValidator id="rev_tbx_AverageOpacity" runat="server"
											  ControlToValidate="tbx_AverageOpacity"
											  ValidationExpression="^\d{0,3}\.\d{0,2}$"
											  Display="Dynamic"
											  ErrorMessage="Please enter the Average Opacity" />
											<asp:RequiredFieldValidator id="rfv_tbx_AverageOpacity" runat="server"
											  ControlToValidate="tbx_AverageOpacity"
											  Display="Dynamic"
											  ErrorMessage="Please enter the Average Opacity" />
                                        </td>
                                        <td>&nbsp;</td>
                                        <td  style="width: 98px">
                                           Test Result: </td>
                                        <td style="width: 210px">
                                            <asp:TextBox ID="tbx_TestResult" Text='<%# Bind("TestResult") %>' runat="server"></asp:TextBox>
											<asp:RegularExpressionValidator id="rev_tbx_TestResult" runat="server"
											  ControlToValidate="tbx_TestResult"
											  ValidationExpression="^([pP][aA][sS]{2})|([fF][aA][iI][lL])$"
											  ViewStateIgnoresCase="True"
											  Display="Dynamic"
											  ErrorMessage="Please enter PASS or FAIL" />
											<asp:RequiredFieldValidator id="rfv_tbx_TestResult" runat="server"
											  ControlToValidate="tbx_TestResult"
											  Display="Dynamic"
											  ErrorMessage="Please enter the test result" />
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td  style="width: 98px">
                                           Tested by: </td>
                                        <td style="width: 210px">
                                            <asp:TextBox ID="tbx_TestedBy" Text='<%# Bind("TestedBy") %>' runat="server"></asp:TextBox>
											<asp:RequiredFieldValidator id="rfv_tbx_TestedBy" runat="server"
											  ControlToValidate="tbx_TestedBy"
											  Display="Dynamic"
											  ErrorMessage="Please enter the name of the tester" />
                                        </td>
                                        <td>&nbsp;</td>
                                        <td style="width: 98px">
                                            Test Date:</td>
                                        <td style="width: 210px">
                                             <telerik:RadDatePicker ID="rdp_TestDate" Runat="server" 
                                                Culture="English (United States)" 
                                                DbSelectedDate='<%# Bind("TestDate") %>' TabIndex="16">
                                                <Calendar ID="Calendar3" Runat="server" UseColumnHeadersAsSelectors="False" 
                                                    UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                                </Calendar>
                                                <DatePopupButton HoverImageUrl="" ImageUrl="" TabIndex="16" />
                                                <DateInput ID="DateInput3" Runat="server" DateFormat="M/d/yyyy" DisplayDateFormat="M/d/yyyy" 
                                                    TabIndex="16">
                                                </DateInput>
                                            </telerik:RadDatePicker>
											
											<asp:RequiredFieldValidator id="rfv_rdp_TestDate" runat="server"
											  ControlToValidate="rdp_TestDate"
											  Display="Dynamic"
											  ErrorMessage="Please enter a Date Recorded" />
											  
                                        </td>
                                        <td>&nbsp;</td>
									</tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" style="width: 100%">
                                    <tr>
                                        <td style="width: 66px">
                                            <asp:Button ID="btnUpdate" Text='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "Insert", "Update") %>' runat="server" CommandName='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "PerformInsert", "Update")%>'></asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False" CommandName="Cancel"></asp:Button>
                                        </td>
                                        <td>&nbsp;
                                            </td>
                                    </tr>
                                </table>
                                <br />
                                </FormTemplate>
                            </EditFormSettings>
                        </mastertableview>
                    </telerik:RadGrid>
                </td>
                <td style="padding: 5px; border-left-style: solid; border-left-width: 1px; border-left-color: #9B9B9B" valign="top">&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <h4>Mileage Log</h4>
                    <telerik:RadGrid ID="rgd_LogMileage" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AutoGenerateDeleteColumn="True" AutoGenerateEditColumn="True" DataSourceID="sds_MileageLog" GridLines="None" ShowFooter="True" CssClass="radgrid"
					onItemUpdated="RefreshVehicleMileage" onItemInserted="RefreshVehicleMileage" onItemDeleted="RefreshVehicleMileage">
                        <mastertableview CommandItemDisplay="Top" autogeneratecolumns="false" datakeynames="IDMileageLog" datasourceid="sds_MileageLog">
                            <Columns>
                                <telerik:GridBoundColumn DataField="Mileage" DataType="System.Decimal" HeaderText="Mileage" SortExpression="Mileage" UniqueName="Mileage" DataFormatString="{0:n0}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="MileageDate" DataType="System.DateTime" HeaderText="Date" SortExpression="MileageDate" UniqueName="MileageDate" DataFormatString="{0:d}">
                                </telerik:GridBoundColumn>
                                <%--<telerik:GridBoundColumn DataField="EndMileage" DataType="System.Decimal" HeaderText="End Mileage" SortExpression="EndMileage" UniqueName="EndMileage">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="EndMileageDate" DataType="System.DateTime" HeaderText="Date" SortExpression="EndMileageDate" UniqueName="EndMileageDate" DataFormatString="{0:d}">
                                </telerik:GridBoundColumn>--%>
                            </Columns>
                        <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                                <h2>Mileage Entry</h2>
                                <table cellpadding="0" cellspacing="0" style="width: 100%">
                                    <tr>
                                        <td style="width: 98px">
                                            Mileage:</td>
                                        <td style="width: 210px">
                                            <asp:TextBox ID="tbx_Mileage" Text='<%# Bind("Mileage") %>' runat="server"></asp:TextBox>
											<asp:RegularExpressionValidator id="rev_tbx_Mileage" runat="server"
											  ControlToValidate="tbx_Mileage"
											  ValidationExpression="^\d{1,10}$"
											  Display="Dynamic"
											  ErrorMessage="Please enter the proper mileage" />
											<asp:RequiredFieldValidator id="rfv_tbx_Mileage" runat="server"
											  ControlToValidate="tbx_Mileage"
											  Display="Dynamic"
											  ErrorMessage="Please enter the proper mileage" />
											  
                                        </td>
                                        <td>&nbsp;
                                            </td>
                                    <!--</tr>
                                    <tr>-->
                                        <td  style="width: 98px">
                                           Date Recorded: </td>
                                        <td style="width: 210px">
                                             <telerik:RadDatePicker ID="rdp_MileageDate" Runat="server" 
                                                Culture="English (United States)" 
                                                DbSelectedDate='<%# Bind("MileageDate") %>' TabIndex="16">
                                                <Calendar ID="Calendar2" Runat="server" UseColumnHeadersAsSelectors="False" 
                                                    UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                                </Calendar>
                                                <DatePopupButton HoverImageUrl="" ImageUrl="" TabIndex="16" />
                                                <DateInput ID="DateInput2" Runat="server" DateFormat="M/d/yyyy" DisplayDateFormat="M/d/yyyy" 
                                                    TabIndex="16">
                                                </DateInput>
                                            </telerik:RadDatePicker>
											
											<asp:RequiredFieldValidator id="rfv_rdp_MileageDate" runat="server"
											  ControlToValidate="rdp_MileageDate"
											  Display="Dynamic"
											  ErrorMessage="Please enter a Date Recorded" />
                                        </td>
                                        <td>&nbsp;
                                            </td>
                                    </tr>
<%--                                    <tr>
                                        <td style="width: 98px">
                                            End Mileage:</td>
                                        <td style="width: 210px">
                                            <asp:TextBox ID="tbx_EndMileage" Text='<%'# Bind("EndMileage") %>'  runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;
                                            </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 98px">
                                            Date:</td>
                                        <td style="width: 210px">
                                            <telerik:RadDatePicker ID="rdp_EndMileageDate" Runat="server" 
                                                Culture="English (United States)" 
                                                DbSelectedDate='<%'# Bind("EndMileageDate") %>' TabIndex="16">
                                                <Calendar ID="Calendar1" Runat="server" UseColumnHeadersAsSelectors="False" 
                                                    UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                                </Calendar>
                                                <DatePopupButton HoverImageUrl="" ImageUrl="" TabIndex="16" />
                                                <DateInput ID="DateInput1" Runat="server" DateFormat="M/d/yyyy" DisplayDateFormat="M/d/yyyy" 
                                                    TabIndex="16">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </td>
                                        <td>&nbsp;
                                            </td>
                                    </tr>--%>
                                </table>
                                <table cellpadding="0" cellspacing="0" style="width: 100%">
                                    <tr>
                                        <td style="width: 66px">
                                            <asp:Button ID="btnUpdate" Text='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "Insert", "Update") %>' runat="server" CommandName='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "PerformInsert", "Update")%>'></asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False" CommandName="Cancel"></asp:Button>
                                        </td>
                                        <td>&nbsp;
                                            </td>
                                    </tr>
                                </table>
                                <br />
                                </FormTemplate>
                            </EditFormSettings>
                        </mastertableview>
                    </telerik:RadGrid>
                </td>
                <td style="padding: 5px; border-left-style: solid; border-left-width: 1px; border-left-color: #9B9B9B" valign="top">&nbsp;
                    </td>
            </tr>
            <tr>
                <td>
                    <h4>
                        Hours Log</h4>
                    <telerik:RadGrid ID="rgd_LogHours" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AutoGenerateDeleteColumn="True" AutoGenerateEditColumn="True" DataSourceID="sds_HoursLog" GridLines="None" ShowFooter="True" CssClass="radgrid"
					  onItemUpdated="RefreshVehicleHours" onItemInserted="RefreshVehicleHours" onItemDeleted="RefreshVehicleHours">
                        <mastertableview CommandItemDisplay="Top" autogeneratecolumns="False" datakeynames="IDHoursLog" datasourceid="sds_HoursLog">
                            <Columns>
                                <telerik:GridBoundColumn DataField="Hours" DataType="System.Decimal" DefaultInsertValue="" HeaderText="Hours" SortExpression="Hours" UniqueName="Hours">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="HoursDate" DataType="System.DateTime" DefaultInsertValue="" HeaderText="Date" SortExpression="HoursDate" UniqueName="HoursDate" DataFormatString="{0:d}">
                                </telerik:GridBoundColumn>
                                <%--<telerik:GridBoundColumn DataField="EndHours" DataType="System.Decimal" DefaultInsertValue="" HeaderText="End Hours" SortExpression="EndHours" UniqueName="EndHours">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="EndHoursDate" DataType="System.DateTime" DefaultInsertValue="" HeaderText="Date" SortExpression="EndHoursDate" UniqueName="EndHoursDate" DataFormatString="{0:d}">
                                </telerik:GridBoundColumn>--%>
                            </Columns>
                        <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                                <h2>Hours Entry</h2>
                                <table cellpadding="0" cellspacing="0" style="width: 100%">
                                    <tr>
                                        <td style="width: 98px">
                                            Hours:</td>
                                        <td style="width: 210px">
                                            <asp:TextBox ID="tbx_Hours" Text='<%# Bind("Hours") %>' runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;
                                            </td>
                                    <!--</tr>
                                    <tr>-->
                                        <td  style="width: 98px">
                                            Date</td>
                                        <td style="width: 210px">
                                             <telerik:RadDatePicker ID="rdp_HoursDate" Runat="server" 
                                                Culture="English (United States)" 
                                                DbSelectedDate='<%# Bind("HoursDate") %>' TabIndex="16">
                                                <Calendar ID="Calendar2" Runat="server" UseColumnHeadersAsSelectors="False" 
                                                    UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                                </Calendar>
                                                <DatePopupButton HoverImageUrl="" ImageUrl="" TabIndex="16" />
                                                <DateInput ID="DateInput2" Runat="server" DateFormat="M/d/yyyy" DisplayDateFormat="M/d/yyyy" 
                                                    TabIndex="16">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </td>
                                        <td>&nbsp;
                                            </td>
                                    </tr>
                                    <%--<tr>
                                        <td style="width: 98px">
                                            End Hours:</td>
                                        <td style="width: 210px">
                                            <asp:TextBox ID="tbx_EndHours" Text='<%# Bind("EndHours") %>'  runat="server"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;
                                            </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 98px">
                                            Date:</td>
                                        <td style="width: 210px">
                                            <telerik:RadDatePicker ID="rdp_EndHoursDate" Runat="server" 
                                                Culture="English (United States)" 
                                                DbSelectedDate='<%# Bind("EndHoursDate") %>' TabIndex="16">
                                                <Calendar ID="Calendar1" Runat="server" UseColumnHeadersAsSelectors="False" 
                                                    UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                                </Calendar>
                                                <DatePopupButton HoverImageUrl="" ImageUrl="" TabIndex="16" />
                                                <DateInput ID="DateInput1" Runat="server" DateFormat="M/d/yyyy" DisplayDateFormat="M/d/yyyy" 
                                                    TabIndex="16">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </td>
                                        <td>&nbsp;
                                            </td>
                                    </tr>--%>
                                </table>
                                <table cellpadding="0" cellspacing="0" style="width: 100%">
                                    <tr>
                                        <td style="width: 66px">
                                            <asp:Button ID="btnUpdate" Text='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "Insert", "Update") %>' runat="server" CommandName='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "PerformInsert", "Update")%>'></asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False" CommandName="Cancel"></asp:Button>
                                        </td>
                                        <td>&nbsp;
                                            </td>
                                    </tr>
                                </table>
                                <br />
                                </FormTemplate>
                            </EditFormSettings>
                        </mastertableview>
                    </telerik:RadGrid>
                </td>
                <td style="padding: 5px; border-left-style: solid; border-left-width: 1px; border-left-color: #9B9B9B" valign="top">&nbsp;
                    </td>
            </tr>
        </table>
</telerik:RadPageView>
                        <telerik:RadPageView ID="rpv_Engines" runat="server">
                        <table cellpadding="0" 
                            style="width: 920px; border-collapse: collapse; border: 1px solid #9B9B9B">
                            <tr>
                                <td valign="top" width="700px" style="padding: 4px">
                                    <table cellpadding="0" cellspacing="0" style="width: 100%; height: 30px;" width="700px">
                                        <tr>
                                            <td style="width: 200px">
                                                <span style="color: #ED8701; font-size: medium; font-weight: bold">Engines</span></td>
                                            <td>
                                                <span style="color: #2C7500; font-weight: bold">Vehicle Unit No:</span>
                                                <asp:Label ID="rmp_lbl_VUN" runat="server" ></asp:Label>
                                                &nbsp; <span style="color: #2C7500; font-weight: bold">VIN: </span>
                                                <asp:Label ID="rmp_lbl_VIN" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <telerik:RadGrid ID="rg_Engines" runat="server" DataKeyNames="IDEngines" DataSourceID="sds_CFV_Engines_Grid"
                                    GridLines="None" PageSize="5" ShowFooter="True" Skin="Telerik" Width="680px">
                                        <mastertableview autogeneratecolumns="False" datakeynames="IDEngines" datasourceid="sds_CFV_Engines_Grid">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="SerialNum" DefaultInsertValue="" HeaderText="Serial No." SortExpression="SerialNum" UniqueName="SerialNum">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="IDEngines" DefaultInsertValue="" HeaderText="ID Engines" SortExpression="IDEngines" UniqueName="IDEngines">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="FamilyName" DefaultInsertValue="" HeaderText="Family Name" SortExpression="FamilyName" UniqueName="FamilyName">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="EngineModel" DefaultInsertValue="" HeaderText="Model" SortExpression="EngineModel" UniqueName="EngineModel">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </mastertableview>
                                        <clientsettings enablepostbackonrowclick="True">
                                            <selecting allowrowselect="True" />
                                        </clientsettings>
                                    </telerik:RadGrid>
                                    <br />
                                    <br />
                                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td width="50px">
                                                <asp:Button ID="btn_AddEngine" runat="server" Text="Add Engine" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btn_AttachEngine" runat="server" Text="Attach Engine" />
                                            </td>
                                            <td>
                                                <asp:HiddenField ID="hf_rg_EnginesIDSelectedEngine" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <br />
                                    <asp:FormView ID="fv_EngineDetails" runat="server" CellPadding="5" 
                                        DataKeyNames="IDEngines" DataSourceID="sds_CFV_Engines_fv" Font-Size="Small" 
                                        Width="700px">
                                        <EditItemTemplate>
                                            <table style="width: 661px">
                                                <tr>
                                                    </td>
                                                    <td class="tdtable" style="width: 90px;">
                                                        Serial No:
                                                    </td>
                                                    <td style="width: 125px;">
                                                        <asp:TextBox ID="SerialNumTextBox" runat="server" 
                                                            Text='<%# Bind("SerialNum") %>' Width="100px" />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                                            ControlToValidate="SerialNumTextBox" ErrorMessage="*" 
                                                            style="font-size: x-large"></asp:RequiredFieldValidator>
														<asp:CustomValidator ID="SerialNumValidator" runat="server" ControlToValidate="SerialNumTextBox" 
														  OnServerValidate="UniqueEngineSerialNumValidator"
														  ErrorMessage="This Serial Number is already in use by another Engine"></asp:CustomValidator>
                                                    </td>
                                                    <td class="tdtable" style="width: 98px;">
                                                        Model:
                                                    </td>
                                                    <td style="width: 135px;">
                                                        <asp:TextBox ID="SeriesModelNoTextBox" runat="server" 
                                                            Text='<%# Bind("EngineModel") %>' Width="100px" />
                                                    </td>
                                                    <td class="tdtable" style="width: 98px;">
                                                        Horsepower:</td>
                                                    <td>
                                                        <asp:TextBox ID="HorsepowerTextBox" runat="server" 
                                                            Text='<%# Bind("Horsepower") %>' Width="100px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdtable" style="width: 90px;">
                                                        Manufacturer:
                                                    </td>
                                                    <td style="width: 125px;">
                                                        <asp:DropDownList ID="ddl_IDEngineManufacturer" runat="server" 
                                                            AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_EngineManufacturer" 
                                                            DataTextField="DisplayValue" DataValueField="IDOptionList" 
                                                            SelectedValue='<%# Bind("IDEngineManufacturer") %>'
															CssClass="forest">
                                                            <asp:ListItem Text="Select" Value="0" />
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="tdtable" style="width: 98px;">
                                                        Model Year:
                                                    </td>
                                                    <td style="width: 135px;">
                                                        <asp:DropDownList ID="ddl_ModelYear" runat="server" AppendDataBoundItems="True" 
                                                            DataSourceID="sds_ddl_Op_Year" DataTextField="DisplayValue" 
                                                            DataValueField="IDOptionList" SelectedValue='<%# Bind("IDModelYear") %>'
															CssClass="forest">
                                                            <asp:ListItem Text="Select" Value="0" />
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="tdtable" style="width: 98px;">
                                                        Displacement:</td>
                                                    <td>
                                                        <asp:TextBox ID="tbx_Displacement" runat="server" 
                                                            Text='<%# Bind("Displacement") %>' Width="100px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdtable" style="width: 90px;">
                                                        Family Name:
                                                        <td style="width: 125px;">
                                                            <asp:TextBox ID="FamilyNameTextBox" runat="server" 
                                                                Text='<%# Bind("FamilyName") %>' Width="100px" />
                                                        </td>
                                                        <td class="tdtable" style="width: 98px;">
                                                            Status:</td>
                                                        <td style="width: 135px;">
                                                            <asp:DropDownList ID="ddl_IDEngineStatus" runat="server" 
                                                                AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_EngineStatus" 
                                                                DataTextField="DisplayValue" DataValueField="IDOptionList" 
                                                                SelectedValue='<%# Bind("IDEngineStatus") %>'
																CssClass="forest">
                                                                <asp:ListItem Text="Select" Value="0" />
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="tdtable" style="width: 98px;">
                                                            Est. Retro. Cost</td>
                                                        <td>
                                                            <asp:TextBox ID="tbx_EstRetCost" runat="server" 
                                                                Text='<%# Bind("EstRetrofitCost") %>' Width="100px" />
                                                        </td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdtable" style="width: 90px; ">
                                                        Fuel Type:
                                                        <td style="width: 125px">
                                                            <asp:DropDownList ID="ddl_IDEngineFuelType" runat="server" 
                                                                AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_EngineFuelType" 
																OnDataBinding="PreventErrorOnbinding"
                                                                DataTextField="DisplayValue" DataValueField="IDOptionList" 
                                                                SelectedValue='<%# Bind("IDEngineFuelType") %>'
																CssClass="forest">
                                                                <asp:ListItem Text="Select" Value="0" />
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="tdtable" style="width: 98px; ">&nbsp;
                                                            </td>
                                                        <td style="width: 135px">&nbsp;
                                                            </td>
                                                        <td class="tdtable" style="width: 98px; ">
                                                            &#160;</td>
                                                        <td>
                                                            &#160;</td>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <span style="color: #2C7500"><b>
                                            Description:</b></span><br />
                                            &nbsp;
                                            <table>
                                                <tr>
                                                    <td width="25px">&nbsp;
                                                        
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="DescriptionTextBox" runat="server" Height="65px" 
                                                            Text='<%# Bind("Description") %>' TextMode="MultiLine" Width="600px" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <span style="color: #2C7500"><b>Notes:<br /></b></span>
                                            <table>
                                                <tr>
                                                    <td width="25px">&nbsp;
                                                        
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="NotesTextBox" runat="server" Height="65px" 
                                                            Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="600px" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <b><span style="color: #2C7500">Internal Notes:</span></b><br />
                                            <table>
                                                <tr>
                                                    <td width="25px">
                                                        &#160;
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="NotesCFTextBox" runat="server" Height="65px" 
                                                            Text='<%# Bind("NotesCF") %>' TextMode="MultiLine" Width="600px" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
											<asp:HiddenField ID="hf_IDEngines" runat="server" 
                                                            Value='<%# Bind("IDEngines") %>' />
                                            <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" 
                                                CommandName="Update" Text="Update" />
                                            &#160;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" 
                                                CommandName="Cancel" Text="Cancel" />
                                            <br />
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <table style="width: 665px">
                                                <tr>
                                                    <td class="tdtable" style="width: 90px; ">
                                                        Serial No:
                                                    </td>
                                                    <td style="width: 120px">
                                                        <asp:Label ID="EngineSerialNum" runat="server" 
                                                            Text='<%# Eval("SerialNum") %>' />
                                                    </td>
                                                    <td class="tdtable" style="width: 80px; ">
                                                        Model: </td>
                                                    <td style="width: 115px">
                                                        <asp:Label ID="lbl_ESerModNo" runat="server" 
                                                            Text='<%# Bind("EngineModel") %>' />
                                                    </td>
                                                    <td class="tdtable" style="width: 100px; ">
                                                        Horsepower:</td>
                                                    <td>
                                                        <asp:Label ID="lbl_EHP" runat="server" Text='<%# Bind("Horsepower") %>' />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdtable" style="width: 90px; ">
                                                        Manufacturer:
                                                    </td>
                                                    <td style="width: 120px">
                                                        <asp:Label ID="lbl_EManu" runat="server" 
                                                            Text='<%# Bind("EngineManufacturer") %>' />
                                                    </td>
                                                    <td class="tdtable" style="width: 80px; ">
                                                        Model Year:
                                                    </td>
                                                    <td style="width: 115px">
                                                        <asp:Label ID="lbl_EYear" runat="server" Text='<%# Bind("ModelYear") %>' />
                                                    </td>
                                                    <td class="tdtable" style="width: 100px; ">
                                                        Displacement:</td>
                                                    <td>
                                                        <asp:Label ID="lbl_EHP0" runat="server" Text='<%# Bind("Displacement") %>' />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdtable" style="width: 90px; ">
                                                        Family Name:
                                                        <td style="width: 120px">
                                                            <asp:Label ID="lbl_EFamily" runat="server" Text='<%# Bind("FamilyName") %>' />
                                                        </td>
                                                        <td class="tdtable" style="width: 80px; ">
                                                            Status:</td>
                                                        <td style="width: 115px">
                                                            <asp:Label ID="lbl_EStatus" runat="server" Text='<%# Bind("EngineStatus") %>' />
                                                        </td>
                                                        <td class="tdtable" style="width: 100px; ">
                                                            Est. Retro Cost:</td>
                                                        <td>
                                                            <asp:Label ID="lbl_EstRetCost" runat="server" 
                                                                Text='<%# Bind("EstRetrofitCost", "{0:c}") %>' />
                                                        </td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdtable" style="width: 90px; ">
                                                        Fuel Type:
                                                        <td style="width: 120px">
                                                            <asp:Label ID="lbl_EFuelType" runat="server" 
                                                                Text='<%# Bind("EngineFuelType") %>' />
                                                        </td>
                                                        <td class="tdtable" style="width: 80px; ">
                                                            &#160;</td>
                                                        <td style="width: 115px">
                                                            &#160;</td>
                                                        <td class="tdtable" style="width: 100px; ">
                                                            &#160;</td>
                                                        <td>
                                                            &#160;</td>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <span style="color: #2C7500"><b>
                                            Description:</b></span><br />
                                            <table style="width: 400px">
                                                <tr>
                                                    <td width="25px">
                                                        &#160;
                                                    </td>
                                                    <td>
                                                        <div class="divlblScrollText">
                                                            <asp:Label ID="DescriptionLabel" runat="server" 
                                                                Text='<%# Eval("Description").ToString().Replace(Environment.NewLine, "<br />") %>' />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <span style="color: #2C7500"><b>
                                            Notes:<br />
                                            </b></span>
                                            <table style="width: 400px">
                                                <tr>
                                                    <td width="25px">
                                                        &#160;
                                                    </td>
                                                    <td>
                                                        <div class="divlblScrollText">
                                                            <asp:Label ID="NotesLabel" runat="server" 
                                                                Text='<%# Eval("Notes").ToString().Replace(Environment.NewLine, "<br />") %>' />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <b><span style="color: #2C7500">
                                            Internal Notes:</span></b><br />
                                            <table style="width: 400px">
                                                <tr>
                                                    <td width="25px">
                                                        &#160;
                                                    </td>
                                                    <td>
                                                        <div class="divlblScrollText">
                                                            <asp:Label ID="NotesCFLabel" runat="server" 
                                                                Text='<%# Eval("NotesCF").ToString().Replace(Environment.NewLine, "<br />") %>' />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <table id="table1" cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td style="width: 40px">
                                                        &#160;</td>
                                                    <td style="width: 63px">
                                                        &#160;</td>
                                                    <td style="width: 317px">
                                                        &#160;</td>
                                                    <td width="50px">
                                                        &#160;</td>
                                                    <td width="50px">&nbsp;
                                                        </td>
                                                    <td>&nbsp;
                                                        </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 40px">
                                                        <asp:Button ID="EditButton" runat="server" CausesValidation="False" 
                                                            CommandName="Edit" Text="Edit" />
                                                    </td>
                                                    <td style="width: 63px">
                                                        <asp:Button ID="btn_DetachEngine" runat="server" 
                                                            OnClick="btn_DetachEngine_Click" Text="Detach" />
                                                    </td>
                                                    <td style="width: 317px">
                                                        <asp:HiddenField ID="hf_IDEngines" runat="server" 
                                                            Value='<%# Bind("IDEngines") %>' />
                                                    </td>
                                                    <td width="50px">
                                                        <asp:Button ID="btn_AddDECs" runat="server" onclick="btn_AddDECs_Click" Text="Add DECS" />
                                                    </td>
                                                    <td width="50px">
                                                        <asp:Button ID="btn_AttachDECS" runat="server" OnClick="btn_AttachDECs_Click" 
                                                            Text="Attach DECS" />
                                                    </td>
                                                    <td>&nbsp;
                                                        </td>
                                                </tr>
                                            </table>
                                            &#160;
                                        </ItemTemplate>
                                    </asp:FormView>
                                    <br />
                                    <br />
                                </td>
                                <td valign="top" 
                                    style="padding: 5px; border-left-style: solid; border-left-width: 1px; border-left-color: #9B9B9B">
                                    <asp:FormView ID="fv_EngineImage" runat="server" DataKeyNames="IDImages" DataSourceID="sds_ImagesEngines_fvw">
                                        <ItemTemplate>
                                            <asp:Image ID="image0" runat="server" ImageUrl='<%#Eval("Image") + "?Width=200" %>' Width="200" />
                                        </ItemTemplate>
                                    </asp:FormView>
                                </td>
                            </tr>
                        </table>
                            
                            <br />
                            <table cellpadding="0"  style="width: 920px; border-collapse: collapse; border: 1px solid #9B9B9B">
                                <tr>
                                    <td valign="top" width="700px" style="padding: 4px">
                                        <table cellpadding="0" cellspacing="0" style="width: 100%; height: 30px;">
                                            <tr>
                                                <td>
                                                    <span style="color: #ED8701; font-size: medium; font-weight: bold">Diesel Engine 
                                                    Emissions Control System</span></td>
                                            </tr>
                                        </table>
                                        <asp:ListView ID="lv_DECSDetails" runat="server" DataKeyNames="IDDECS" 
                                            DataSourceID="sds_CFV_DECs_lv" >
                                            <EditItemTemplate>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 115px; " class="tdtable">
                                                            Serial No:</td>
                                                        <td class="style1">
                                                            <asp:TextBox ID="DECSSerialNoTextBox" runat="server" Text='<%# Bind("SerialNo") %>' />
                                                        </td>
                                                        <td style="width: 115px; " class="tdtable">
                                                            Model:</td>
                                                        <td style="height: 20px">
                                                            <asp:TextBox ID="DECSModelNoTextBox" runat="server" 
                                                                Text='<%# Bind("DECSModelNo") %>' />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 115px; " class="tdtable">
                                                            Name:</td>
                                                        <td class="style2">
                                                            <asp:TextBox ID="DECSName" runat="server" Text='<%# Bind("DECSName") %>' 
                                                                Width="250px" />
                                                        </td>
                                                        <td style="width: 115px; " class="tdtable">
                                                            Level:</td>
                                                        <td>
                                                            <asp:DropDownList ID="ddl_IDDECsLevel" runat="server" 
                                                                AppendDataBoundItems="True" DataSourceID="sds_ddl_DECs_Op_Level" 
																OnDataBinding="PreventErrorOnbinding"
                                                                DataTextField="DisplayValue" DataValueField="IDOptionList" 
                                                                SelectedValue='<%# Bind("IDDECSLevel") %>'
																CssClass="forest">
                                                                <asp:ListItem Text="Select" Value="0" />
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 115px; " class="tdtable">
                                                            Manufacturer:</td>
                                                        <td class="style2">
                                                            <asp:DropDownList ID="ddl_IDDECsManufacturer" runat="server" AppendDataBoundItems="True" 
																DataSourceID="sds_ddl_DECs_Op_Manufacturer" DataTextField="DisplayValue" 
																OnDataBinding="PreventErrorOnbinding"
																DataValueField="IDOptionList" SelectedValue='<%# Bind("IDDECSManufacturer") %>'
																CssClass="forest">
                                                                <asp:ListItem Text="Select" Value="0" />
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 115px; " class="tdtable">
                                                            Install Date:</td>
                                                        <td>
                                                            <telerik:RadDatePicker ID="rdp_DECSInstallationDate" Runat="server" 
                                                                Culture="English (United States)" 
                                                                DbSelectedDate='<%# Bind("DECSInstallationDate") %>'>
                                                                <calendar usecolumnheadersasselectors="False" 
                                                                userowheadersasselectors="False" viewselectortext="x">
                                                                </calendar>
                                                                <datepopupbutton hoverimageurl="" imageurl="" />
                                                                <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" 
                                                                enabledstyle-horizontalalign="Center">
                                                                    <enabledstyle horizontalalign="Center" />
                                                                </dateinput>
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <br />
                                                <span style="color: #2C7500"><b>Notes:</b></span><br />
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td width="25px">
                                                            &#160;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="ntb_Notes_DECs" runat="server" Height="65px" Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="650px" />
                                                            <br />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <b><span style="color: #2C7500">Internal Notes:</span></b><br />
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td width="25px">
                                                            &#160;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="ntb_NotesCF_DECs" runat="server" Height="65px" Text='<%# Bind("NotesCF") %>' TextMode="MultiLine" Width="650px" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                &#160;<br />
                                                <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" 
                                                    CommandName="Update" Text="Update" />
                                                &#160;<asp:Button ID="UpdateCancelButton" runat="server" 
                                                    CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                                <br />
                                            </EditItemTemplate>
                                            
                                            <ItemTemplate>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 115px; " class="tdtable">
                                                            Serial No:</td>
                                                        <td style="height: 20px">
                                                            <asp:Label ID="DECsSerialNum" runat="server" Text='<%# Eval("SerialNo") %>' />
                                                        </td>
                                                        <td style="width: 115px; " class="tdtable">
                                                            Model:</td>
                                                        <td style="height: 20px">
                                                            <asp:Label ID="DECSModelNoLabel" runat="server" 
                                                                Text='<%# Bind("DECSModelNo") %>' />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 115px; " class="tdtable">
                                                            Name:</td>
                                                        <td>
                                                            <asp:Label ID="DECSName" runat="server" Text='<%# Eval("DECSName") %>' />
                                                        </td>
                                                        <td style="width: 115px; " class="tdtable">
                                                            Level:</td>
                                                        <td>
                                                            <asp:Label ID="IDDECSLevelLabel" runat="server" 
                                                                Text='<%# Bind("DECSLevel") %>' />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 115px; " class="tdtable">
                                                            Manufacturer:</td>
                                                        <td>
                                                            <asp:Label ID="IDDECSManufacturerLabel" runat="server" Text='<%# Bind("DECSManufacturer") %>' />
                                                        </td>
                                                        <td style="width: 115px; " class="tdtable">
                                                            Install Date:</td>
                                                        <td>
                                                            <asp:Label ID="DECSInstallationDateLabel" runat="server" 
                                                                Text='<%# Bind("DECSInstallationDate", "{0:MM/dd/yyyy}") %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <span style="color: #2C7500"><b>Notes:<br />
                                                </b></span>
                                                <table style="width: 400px">
                                                    <tr>
                                                        <td width="25px">
                                                            &#160;
                                                        </td>
                                                        <td>
                                                            <div class="divlblScrollText">
                                                                <asp:Label ID="NotesLabel" runat="server" Text='<%# Eval("Notes").ToString().Replace(Environment.NewLine, "<br />") %>' />
                                                            </div>
                                                            <br />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <b><span style="color: #2C7500">Internal Notes:</span></b><br />
                                                <table style="width: 400px">
                                                    <tr>
                                                        <td width="25px">
                                                            &#160;
                                                        </td>
                                                        <td>
                                                            <div class="divlblScrollText">
                                                                <asp:Label ID="NotesCFLabel" runat="server" Text='<%# Eval("NotesCF").ToString().Replace(Environment.NewLine, "<br />") %>' />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table ID="table2" cellpadding="0" cellspacing="0" style="width: 100%">
                                                    <tr>
                                                        <td style="width: 40px">&nbsp;
                                                            </td>
                                                        <td>&nbsp;
                                                            </td>
                                                        <td>&nbsp;
                                                            </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 40px">
                                                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" 
                                                                CommandName="Edit" Text="Edit" />
                                                            </td>
                                                        <td>
                                                            <asp:Button ID="btn_DetachDECs" runat="server" OnClick="btn_DetachDECs_Click" 
																CommandArgument='<%# BIND("IDDECS") %>'
                                                                Text="Detach" />
                                                        </td>
                                                        <td>
                                                            <asp:HiddenField ID="hf_IDDECS" runat="server" Value='<%# Bind("IDDECS") %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                &#160;
                                            </ItemTemplate>
                                        </asp:ListView>
                                        <br />
                                    </td>
                                    <td 
                                        style="padding: 5px; border-left-style: solid; border-left-width: 1px; border-left-color: #9B9B9B" 
                                        valign="top">
                                        <asp:FormView ID="fv_DECSImage" runat="server" DataKeyNames="IDImages" DataSourceID="sds_ImagesDECs_fvw">
                                            <ItemTemplate>
                                                <asp:Image ID="image1" runat="server" ImageUrl='<%#Eval("Image") + "?Width=200"%>' Width="200" />
                                            </ItemTemplate>
                                        </asp:FormView>
                                    </td>
                                </tr>
                            </table>
						</telerik:RadPageView>
                                <telerik:RadPageView ID="rpv_VehicleFiles" runat="server">
                                <table style="width: 920px; border-collapse: collapse; border: 1px solid #9B9B9B">
                                    <tr>
                                        <td style="padding: 4px" valign="top" width="700px">
                                            <table cellpadding="0" cellspacing="0" style="width: 100%; height: 30px;" width="700px">
                                                <tr>
                                                    <td style="width: 200px">
                                                        <span style="color: #ED8701; font-size: medium; font-weight: bold">Vehicle File Manager</span></td>
                                                    <td>
                                                        <span style="color: #2C7500; font-weight: bold">Vehicle Unit No:</span>
                                                        <asp:Label ID="rmp_lbl_VUN0" runat="server"></asp:Label>
                                                        &nbsp; <span style="color: #2C7500; font-weight: bold">VIN: </span>
                                                        <asp:Label ID="rmp_lbl_VIN0" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <p>&nbsp;
                                                </p>
                                                                <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Button ID="btn_AddVehicleImage" runat="server" Text="Add Image" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>&nbsp;
                                                                            </td>
                                                                    </tr>
                                            </table>
                                            
<%-- Vehicle Images Grid --%>

												<telerik:RadGrid ID="rg_VehicleImages" runat="server" 
												AllowAutomaticDeletes="True" AutoGenerateDeleteColumn="True" CssClass="radgrid" 
												DataSourceID="sds_ImagesVehicle" GridLines="None" Width="300px">
													<mastertableview autogeneratecolumns="False" datakeynames="IDImages" clientdatakeynames="IDImages" 
													datasourceid="sds_ImagesVehicle">
														<rowindicatorcolumn>
															<HeaderStyle Width="20px" />
														</rowindicatorcolumn>
														<expandcollapsecolumn>
															<HeaderStyle Width="20px" />
														</expandcollapsecolumn>
														<Columns>
															<telerik:GridTemplateColumn  HeaderText="Default" DefaultInsertValue="" UniqueName="gtc_VehicleImage">
																<ItemTemplate>
																	<asp:RadioButton  ID="rbt_VehicleImage" GroupName="MyGroupVehicles"
																	onclick="MyClickVehicles(this,event)" runat="server" AutoPostBack="True"
																	checked='<%# If(Eval("DefaultImage") Is DBNull.Value, False, Eval("DefaultImage")) %>'
																	oncheckedchanged="rbt_VehicleImage_CheckedChanged" />
																</ItemTemplate>
															</telerik:GridTemplateColumn>
															<telerik:GridImageColumn AlternateText="Thumbnail" 
															DataImageUrlFields="FilePath, FileName" DataImageUrlFormatString="{0}/{1}?Width=100" 
															DataType="System.String" FooterText="ImageColumn footer" HeaderText="" 
															ImageAlign="Middle" ImageWidth="100px" UniqueName="vehicleimage">
																<HeaderStyle Width="75px" />
															</telerik:GridImageColumn>
															<telerik:GridBoundColumn DataField="IDImages" DataType="System.Guid"
															DefaultInsertValue="" HeaderText="IDImages" ReadOnly="True"
															SortExpression="IDImages" UniqueName="IDImages" Visible="False">
															</telerik:GridBoundColumn>
														</Columns>           
														<NoRecordsTemplate>
															<div>No Images to Display.</div>
														</NoRecordsTemplate>                 
													</mastertableview>
												<clientsettings>
												<clientevents onrowdblclick="RowClick" />
												</clientsettings>
												</telerik:RadGrid>
                                            <p>&nbsp;
                                                </p>
                                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btn_AddVehicleFile" runat="server" Text="Add File" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;
                                                        </td>
                                                </tr>
                                            </table>
<%-- Vehicle Files Grid --%>

                                            <telerik:RadGrid ID="rg_VehicleFiles" runat="server" 
                                                AllowAutomaticDeletes="True" AutoGenerateDeleteColumn="True" CssClass="radgrid" 
                                                DataSourceID="sds_FilesVehicle" GridLines="None" Width="300px">
                                                <mastertableview autogeneratecolumns="False" datakeynames="IDFile" datasourceid="sds_FilesVehicle">
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="Title" DefaultInsertValue="" HeaderText="Title" SortExpression="Title" UniqueName="Title">
                                                        </telerik:GridBoundColumn>
														<telerik:GridBoundColumn DataField="DisplayValue" DefaultInsertValue="" HeaderText="Document Type" SortExpression="DocumentType" UniqueName="DocumentType">
															
														</telerik:GridBoundColumn>
                                                        <telerik:GridHyperLinkColumn DataNavigateUrlFields="FilePath,FileName" DataNavigateUrlFormatString="{0}{1}" DataTextField="IDVehicles" DataTextFormatString="View" Target="_Blank" Text="View" UniqueName="View">
                                                            <ItemStyle CssClass="radgrid" />
                                                        </telerik:GridHyperLinkColumn>
                                                    </Columns>
													<NoRecordsTemplate>
														<div>No Files to Display.</div>
													</NoRecordsTemplate>
                                                </mastertableview>
                                            </telerik:RadGrid>
                                            <p>&nbsp;
                                                </p>
                                            <h1>
											
                                                Engine Files</h1>
                                            <telerik:RadGrid ID="rg_EnginesFiles" runat="server" DataKeyNames="IDEngines" DataSourceID="sds_CFV_Engines_Grid" GridLines="None" PageSize="5" ShowFooter="True" Skin="Telerik" Width="680px">
                                                <mastertableview autogeneratecolumns="False" datakeynames="IDEngines" datasourceid="sds_CFV_Engines_Grid">
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="SerialNum" DefaultInsertValue="" HeaderText="Serial No." SortExpression="SerialNum" UniqueName="SerialNum">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="IDEngines" DefaultInsertValue="" HeaderText="ID Engines" SortExpression="IDEngines" UniqueName="IDEngines">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="FamilyName" DefaultInsertValue="" HeaderText="Family Name" SortExpression="FamilyName" UniqueName="FamilyName">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="EngineModel" DefaultInsertValue="" HeaderText="Model" SortExpression="EngineModel" UniqueName="EngineModel">
                                                        </telerik:GridBoundColumn>
                                                    </Columns>
                                                </mastertableview>
                                                <clientsettings enablepostbackonrowclick="True">
                                                    <selecting allowrowselect="True" />
                                                </clientsettings>
                                            </telerik:RadGrid>
                                            <asp:HiddenField ID="hf_rg_EnginesFilesIDEngines" runat="server" />
                                            <br />
                                            <br />
                                            <br />
                                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btn_AddEngineImage" runat="server" Text="Add Image" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;
                                                        </td>
                                                </tr>
                                            </table>

<%-- Engine Images Grid --%>
                                          
                                            <telerik:RadGrid ID="rg_EngineImages" runat="server" 
                                                AllowAutomaticDeletes="True" AutoGenerateDeleteColumn="True"
                                            CssClass="radgrid" DataSourceID="sds_ImagesEngines" GridLines="None" 
                                                Width="300px">
                                                <mastertableview autogeneratecolumns="False" datakeynames="IDImages" clientdatakeynames="IDImages" datasourceid="sds_ImagesEngines">
                                                    <rowindicatorcolumn>
                                                        <HeaderStyle Width="20px" />
                                                    </rowindicatorcolumn>
                                                    <expandcollapsecolumn>
                                                        <HeaderStyle Width="20px" />
                                                    </expandcollapsecolumn>
                                                    <Columns>
                                                        <telerik:GridTemplateColumn DefaultInsertValue="" HeaderText="Default" UniqueName="gtc_EngineImage">
                                                            <ItemTemplate>
                                                                <asp:RadioButton  ID="rbt_EngineImage" GroupName="MyGroupEngines"
                                                                    onclick="MyClickEngines(this,event)" runat="server" AutoPostBack="True"
                                                                    checked='<%# If(Eval("DefaultImage") Is DBNull.Value, False, Eval("DefaultImage")) %>'
                                                                    oncheckedchanged="rbt_EngineImage_CheckedChanged" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridImageColumn AlternateText="Thumbnail" DataImageUrlFields="FilePath, FileName"
                                                        DataImageUrlFormatString="{0}/{1}?Width=100" DataType="System.String" FooterText="ImageColumn footer"
                                                        HeaderText="" ImageAlign="Middle" ImageWidth="100px" UniqueName="vehicleimage">
                                                            <HeaderStyle Width="75px" />
                                                        </telerik:GridImageColumn>
                                                        <telerik:GridBoundColumn DataField="IDImages" DataType="System.Guid"
                                                         DefaultInsertValue="" HeaderText="IDImages" ReadOnly="True"
                                                         SortExpression="IDImages" UniqueName="IDImages" Visible="False">
                                                        </telerik:GridBoundColumn>
                                                    </Columns>
													<NoRecordsTemplate>
														<div>No Images to Display.</div>
													</NoRecordsTemplate>
                                                </mastertableview>
                                                <clientsettings>
                                                    <clientevents onrowdblclick="RowClick" />
                                                </clientsettings>
                                            </telerik:RadGrid>
                                            <p>
                                            </p>
                                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btn_AddEngineFile" runat="server" Text="Add File" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;
                                                        </td>
                                                </tr>
                                            </table>

<%-- Engine Files Grid --%>
                                            
                                            <telerik:RadGrid ID="rg_EngineFiles" runat="server" AllowAutomaticDeletes="True"
                                            AutoGenerateDeleteColumn="True" CssClass="radgrid" 
                                                DataSourceID="sds_FilesEngine" GridLines="None" Width="300px">
                                                <mastertableview autogeneratecolumns="False" datakeynames="IDFile" datasourceid="sds_FilesEngine">
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="Title" DefaultInsertValue=""
                                                        HeaderText="Title" SortExpression="Title" UniqueName="Title">
                                                        </telerik:GridBoundColumn>
														<telerik:GridBoundColumn DataField="DisplayValue" DefaultInsertValue="" 
														HeaderText="Document Type" SortExpression="DocumentType" UniqueName="DocumentType">	
														</telerik:GridBoundColumn>
                                                        <telerik:GridHyperLinkColumn DataNavigateUrlFields="FilePath,FileName"
                                                        DataNavigateUrlFormatString="{0}{1}" DataTextField="IDVehicles"
                                                        DataTextFormatString="View" Target="_Blank" Text="View" UniqueName="View">
                                                            <ItemStyle CssClass="radgrid" />
                                                        </telerik:GridHyperLinkColumn>
                                                    </Columns>
													<NoRecordsTemplate>
														<div>No Files to Display.</div>
													</NoRecordsTemplate>
                                                </mastertableview>
                                            </telerik:RadGrid>
                                            <p>
                                            </p>
                                            
<%-- DECS --%>                                            
                                            
                                            <h1>
                                                DECS Files</h1>
                                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btn_AddDECSImage" runat="server" Text="Add Image" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;
                                                        </td>
                                                </tr>
                                            </table>
                                            <%-- DECS Images Grid --%>
                                            <telerik:RadGrid ID="rg_DECSImages" runat="server" AllowAutomaticDeletes="True" 
                                                AutoGenerateDeleteColumn="True" CssClass="radgrid" 
                                                DataSourceID="sds_ImagesDECS" GridLines="None" Width="300px">
                                                <mastertableview autogeneratecolumns="False" clientdatakeynames="IDImages" 
                                                    datakeynames="IDImages" datasourceid="sds_ImagesDECS">
                                                    <rowindicatorcolumn>
                                                        <HeaderStyle Width="20px" />
                                                    </rowindicatorcolumn>
                                                    <expandcollapsecolumn>
                                                        <HeaderStyle Width="20px" />
                                                    </expandcollapsecolumn>
                                                    <CommandItemSettings ExportToPdfText="Export to Pdf" />
                                                    <Columns>
                                                        <telerik:GridTemplateColumn DefaultInsertValue="" HeaderText="Default" 
                                                            UniqueName="gtc_DECSImage">
                                                            <ItemTemplate>
                                                                <asp:RadioButton ID="rbt_DECSImage" runat="server" AutoPostBack="True" 
                                                                    checked='<%# If(Eval("DefaultImage") Is DBNull.Value, False, Eval("DefaultImage")) %>' 
                                                                    GroupName="MyGroupDECS" oncheckedchanged="rbt_DECSImage_CheckedChanged" 
                                                                    onclick="MyClickDECS(this,event)" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridImageColumn AlternateText="Thumbnail" 
                                                            DataImageUrlFields="FilePath, FileName" DataImageUrlFormatString="{0}/{1}?Width=100" 
                                                            DataType="System.String" FooterText="ImageColumn footer" HeaderText="" 
                                                            ImageAlign="Middle" ImageWidth="100px" 
                                                            UniqueName="vehicleimage">
                                                            <HeaderStyle Width="75px" />
                                                        </telerik:GridImageColumn>
                                                        <telerik:GridBoundColumn DataField="IDImages" DataType="System.Guid" 
                                                            DefaultInsertValue="" HeaderText="IDImages" ReadOnly="True" 
                                                            SortExpression="IDImages" UniqueName="IDImages" Visible="False">
                                                        </telerik:GridBoundColumn>
                                                    </Columns>
													<NoRecordsTemplate>
														<div>No Images to Display.</div>
													</NoRecordsTemplate>
                                                </mastertableview>
                                                <clientsettings>
                                                    <clientevents onrowdblclick="RowClick" />
                                                </clientsettings>
                                            </telerik:RadGrid>
                                            <p>&nbsp;
                                                </p>
                                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btn_AddDECSFile" runat="server" Text="Add File" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;
                                                        </td>
                                                </tr>
                                            </table>
                                            
<%-- DECS Images Grid --%>
                                            
                                            <telerik:RadGrid ID="rg_DECsFiles" runat="server" AllowAutomaticDeletes="True" AutoGenerateDeleteColumn="True"
                                            CssClass="radgrid" DataSourceID="sds_FilesDECS" GridLines="None" 
                                                Width="300px">
                                                <mastertableview autogeneratecolumns="False" datakeynames="IDFile" 
                                                    datasourceid="sds_FilesDECS">
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="Title"
                                                         DefaultInsertValue="" HeaderText="Title"
                                                         SortExpression="Title" UniqueName="Title">
                                                        </telerik:GridBoundColumn>
														<telerik:GridBoundColumn DataField="DisplayValue" DefaultInsertValue="" 
														 HeaderText="Document Type" SortExpression="DocumentType" UniqueName="DocumentType">	
														</telerik:GridBoundColumn>
                                                        <telerik:GridHyperLinkColumn DataNavigateUrlFields="FilePath,FileName" 
                                                            DataNavigateUrlFormatString="{0}{1}" DataTextField="IDVehicles" 
                                                            DataTextFormatString="View" Target="_Blank" Text="View" UniqueName="View">
                                                            <ItemStyle CssClass="radgrid" />
                                                        </telerik:GridHyperLinkColumn>
                                                    </Columns>
													<NoRecordsTemplate>
														<div>No Files to Display.</div>
													</NoRecordsTemplate>
                                                </mastertableview>
                                            </telerik:RadGrid>
                                            <br />
                                            <p>
                                            </p>
                                        </td>
                                        <td style="padding: 5px; border-left-style: solid; border-left-width: 1px; border-left-color: #9B9B9B" valign="top">
                                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td>&nbsp;
                                                        </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td>
                                                         <asp:FormView ID="fvw_IDDECS" runat="server" DataKeyNames="IDImages" DataSourceID="sds_ImagesDECS">
                                                            <ItemTemplate>
                                                                <asp:HiddenField ID="hf_IDDECSImage" runat="server" EnableViewState="False" Value='<%# Eval("IDDECS") %>' />
                                                            </ItemTemplate>
                                                        </asp:FormView>
                                                        <br />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
</telerik:RadPageView>
                                <telerik:RadPageView ID="rpv_Reports" runat="server">
                                <table cellpadding="0" style="width: 920px; border-collapse: collapse; border: 1px solid #9B9B9B">
                                    <tr>
                                        <td style="padding: 4px" valign="top" width="700px">
                                            <table cellpadding="0" cellspacing="0" style="width: 100%; height: 30px;" width="700px">
                                                <tr>
                                                    <td style="width: 200px">
                                                        <span style="color: #ED8701; font-size: medium; font-weight: bold">Reports</span></td>
                                                    <td>
                                                        <span style="color: #2C7500; font-weight: bold">Vehicle Unit No:</span>
                                                        <asp:Label ID="rmp_lbl_VUN1" runat="server"></asp:Label>
                                                        &nbsp; <span style="color: #2C7500; font-weight: bold">VIN: </span>
                                                        <asp:Label ID="rmp_lbl_VIN1" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <table style="width: 100%">
                                                <tr>
                                                    <td style="width: 25px">&nbsp;
                                                        </td>
                                                    <td style="width: 135px">
                                                        <asp:Button ID="btn_BasicReport" runat="server" Text="Basic Report" />
                                                    </td>
                                                    <td>
                                                        Basic report that includes Vehicle, Engine, and DECS details.</td>
                                                </tr>
												<tr>
                                                    <td style="width: 25px">&nbsp;
                                                        </td>
                                                    <td style="width: 135px">
                                                        <asp:Button ID="btn_DoorStickerReport" runat="server" Text="Door Sticker Report" />
                                                    </td>
                                                    <td>
                                                        Report that generates a Vehicle door sticker.</td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 25px">&nbsp;
                                                        </td>
                                                    <td style="width: 135px;color:red;" colspan="2"><%= GVWMessage %>
                                                        </td>
                                                    <td>&nbsp;
                                                        </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 25px">&nbsp;
                                                        </td>
                                                    <td style="width: 135px">&nbsp;
                                                        </td>
                                                    <td>&nbsp;
                                                        </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 25px">&nbsp;
                                                        </td>
                                                    <td style="width: 135px">&nbsp;
                                                        </td>
                                                    <td>&nbsp;
                                                        </td>
                                                </tr>
                                            </table>
                                            <br />
                                        </td>
                                        <td style="padding: 5px; border-left-style: solid; border-left-width: 1px; border-left-color: #9B9B9B" valign="top">&nbsp;
                                            </td>
                                    </tr>
                                </table>
                                <p>&nbsp;
                                    </p>
</telerik:RadPageView>
        <telerik:RadPageView ID="rpv_DPFCleaning" runat="server">
      <table cellpadding="0" style="width: 920px; border-collapse: collapse; border: 1px solid #9B9B9B">
            <tr>
                <td>
                    <asp:FormView ID="fv_CFV_DPF" runat="server" CellPadding="5" 
                        DataKeyNames="IDDPF" DataSourceID="sds_CFV_DPF_fv" 
                        Width="700px">
                        <EditItemTemplate>

                            <%--<table id="DPF_Record_Table" cellpadding="0" cellspacing="0" style="width: 100%">--%> 
                                <%--<tr> 
                                    <td style="width: 100px;"> 
                                        <asp:Label ID="TestPrompt" runat="server" Text='<%# Bind("ModifiedDate") %>' /> 
                                    </td> 
                                </tr>--%> 
                                <%--<tr> 
                                    <td class="tdtable" style="width: 70px"> 
                                        Select DPF Record: 
                                    </td> 
                                    <td> 
                                        <asp:DropDownList ID="ddl_DPF_Records" runat="server" DataSourceID="sds_DPF" DataTextField="EnterDate" 
                                            DataValueField="IDDPF" AppendDataBoundItems="true" AutoPostBack="true"> 
  
                                            <asp:ListItem Text="Select" Value="" /> 
                                        </asp:DropDownList> 
                                    </td> 
                                </tr> 
                            </table>--%>

                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Date:
                                    </td>
                                    <td style="width: 102px;">
                                        <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("ModifiedDate") %>' Width="75px" />
                                    </td>
                                    <td style="width: 83px; " class="tdtable">
                                        Invoice Number: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:TextBox ID="InvoiceNoTextBox" runat="server" Text='<%# Bind("InvoiceNumber") %>' />
                                    </td>
                                   <td style="width: 83px; " class="tdtable">
                                        PO Number: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:TextBox ID="PONumberTextBox" runat="server" Text='<%# Bind("PONumber") %>' />
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td>
                                        &#160;</td>
                                </tr>
                            </table>
                            <table>
                                <tr>
									<td style="width: 125px; " class="tdtable">
										<span style="color: #ED8701; font-size: medium; font-weight: bold">Vehicle</span>
									</td>
                               </tr>
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Company:
                                    </td>
                                    <td style="width: 102px;">
                                        <asp:TextBox ID="CompanyTextBox" runat="server" Text='<%# Bind("Company") %>' Width="75px" />
                                    </td>
                                    <td style="width: 83px; " class="tdtable">
                                        VIN #: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:TextBox ID="VINNoTestBox" runat="server" Text='<%# Bind("VINNumber") %>' />
                                    </td>
                                   <td style="width: 83px; " class="tdtable">
                                        Make: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:TextBox ID="MakeTextBox" runat="server" Text='<%# Bind("Make") %>' />
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Model:
                                    </td>
                                    <td style="width: 102px;">
                                        <asp:TextBox ID="ModelTextBox" runat="server" Text='<%# Bind("Model") %>' Width="75px" />
                                    </td>
                                    <td style="width: 83px; " class="tdtable">
                                        Plate No: </td>
                                    <td style="width: 190px" colspan="2">
                                        <asp:TextBox ID="PlateTextBox" runat="server" Text='<%# Bind("Plate") %>' />
                                    </td>
                                   <td style="width: 83px; " class="tdtable">
                                        Miles: </td>
                                    <td style="width: 190px" colspan="2">
                                        <asp:TextBox ID="MilesTextBox" runat="server" Text='<%# Bind("Miles") %>' />
                                    </td>
                                      <td style="width: 83px; " class="tdtable">
                                        Hours: </td>
                                    <td style="width: 190px" colspan="2">
                                        <asp:TextBox ID="HoursTextBox" runat="server" Text='<%# Bind("Hours") %>' />
                                    </td>
                                </tr>
								<tr><td colspan="6">
								<asp:CustomValidator ID="LicensePlateNoValidator" runat="server" ControlToValidate="PlateTextBox" 
										  OnServerValidate="UniqueLicensePlateNoValidator"
										  ErrorMessage="This License Plate is already registered to another Vehicle"></asp:CustomValidator>
							
								</td></tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td>
                                        &#160;</td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td style="width: 125px; " class="tdtable">
										<span style="color: #ED8701; font-size: medium; font-weight: bold">Filter</span>
									</td>
                                </tr>
                            </table>
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Make/Model:
                                    </td>
                                    <td style="width: 67px">
                                        <asp:TextBox ID="FilterMakeModelTextBox" runat="server" Text='<%# Bind("FilterMake") %>' Width="60px" />
                                    </td>
                                    <td style="width: 117px; " class="tdtable">
                                        Serial Number:
                                    </td>
                                    <td>
                                       <asp:TextBox ID="SerialNoTextBox" runat="server" Text='<%# Bind("SerialNumber") %>' Width="60px" />
                                    </td>
                                    <td style="width: 155px; " class="tdtable">
                                       Part Number:</td>
                                    <td>
                                        <asp:TextBox ID="PartNumberTextBox" runat="server" Text='<%# Bind("PartNumber") %>' Width="60px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Substrate:
                                    </td>
                                    <td style="width: 67px">
                                        <asp:TextBox ID="SubstrateTextBox" runat="server" Text='<%# Bind("Substrate") %>' Width="60px" />
                                    </td>
                                   	<td style="width: 117px; " class="tdtable">
                                        Doc Cleaned
                                    </td>
                                    <td>
                                        <asp:DropDownList id="DocCleanedDropDown"  runat="server" AutoPostBack="true">
                                            <asp:ListItem Selected="True" Value="No"> No </asp:ListItem>
                                            <asp:ListItem Value="Yes"> Yes </asp:ListItem>
                                            </asp:DropDownList>
                                    </td>
                                   </tr>
                                </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td>
                                        &#160;</td>
                                </tr>
                            </table>
                           <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td style="width: 125px; " class="tdtable">
										<span style="color: #ED8701; font-size: medium; font-weight: bold">Cleaning Results</span>
									</td>
                                </tr>
                            </table>
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Condition:
                                    </td>
                                    <td style="width: 67px">
                                        <asp:TextBox ID="ConditionTextBox" runat="server" Text='<%# Bind("Condition") %>' Width="60px" />
                                    </td
                                </tr>
                            </table>
                            <table border="1">
                                <tr>
                                    <td style="width: 15%; " class="tdtable"> </td>
                                    <td style="width: 14%; " class="tdtable">DPF Initial</td>
                                   	<td style="width: 14%; " class="tdtable">DPF Final</td>
                                    <td style="width: 14%; " class="tdtable">Difference</td>
                                    <td style="width: 14%; " class="tdtable">DOC1 Initial</td>
                                    <td style="width: 14%; " class="tdtable">DOC1 Final</td>
                                    <td style="width: 14%; " class="tdtable">Difference</td>
                                  </tr>
                                <tr>
                                    <td style="width: 15%; " class="tdtable">Weight (Grams)</br>&nbsp;&nbsp;</td>
                                    <td style="width: 14%; " class="tdtable"><asp:TextBox ID="W_DPFInitialTextbox" runat="server" Text='<%# Bind("DPFInitWeight") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:TextBox ID="W_DPFFinalTextbox" runat="server" Text='<%# Bind("DPFFinalWeight") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:TextBox ID="W_DPFDiffTextBox" runat="server" Text='<%# Bind("DPFWeightDiff") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:TextBox ID="DOC1InitialTextBox" runat="server" Text='<%# Bind("DOCInitWeight") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:TextBox ID="DOC1FinalTextBox" runat="server" Text='<%# Bind("DOCFinalWeight") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:TextBox ID="DOC1DiffTextBox" runat="server" Text='<%# Bind("DOCWeightDiff") %>' /></td>
                                </tr>
                                <tr>
                                    <td style="width: 15%; " class="tdtable">Flow Restriction</br>(Inch of Water)</td>
                                    <td style="width: 14%; " class="tdtable"><asp:TextBox ID="F_DPFInitialTextbox" runat="server" Text='<%# Bind("DPFInitFR") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:TextBox ID="F_DPFFinalTextbox" runat="server" Text='<%# Bind("DPFFinalFR") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:TextBox ID="F_DPFDiffTextBox" runat="server" Text='<%# Bind("DPFFRDiff") %>' /></td>
                                    <td style="width: 14%; " class="tdtable">--------</td>
                                    <td style="width: 14%; " class="tdtable">--------</td>
                                    <td style="width: 14%; " class="tdtable">--------</td>
                                </tr>
                                </table>
                                <table>
								<tr>
									<td style="width: 175px; " class="tdtable">
                                        Wire Test Results:</td>
                                    <td style="width: 130px">
                                        <asp:TextBox ID="WireTestTextBox" runat="server" Text='<%# Bind("WTResults") %>' Width="60px" />
                                    </td>
                                </tr>
                                <tr>
									<td style="width: 175px; " class="tdtable">
                                        Cleaning Tech:</td>
                                    <td style="width: 130px">
                                        <asp:TextBox ID="CleaningTechTextBox" runat="server" Text='<%# Bind("CleaningTech") %>' Width="60px" />
                                    </td>
                                </tr>   
                                <tr>
                                    <td style="width: 200px; " class="tdtable">
                                        Required Multiple Cleanings:
                                    </td>
                                    <td>
                                        <asp:DropDownList id="MultipleCleaningsDropDown" runat="server" AutoPostBack="true" >
                                                <asp:ListItem Selected="True" Value="No"> No </asp:ListItem>
                                                <asp:ListItem Value="Yes"> Yes </asp:ListItem>                                    
                                        </asp:DropDownList> 
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="width: 117px; " class="tdtable">
                                        Notes:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Notes" runat="server" Height="65px" 
                                            Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="650px" />
                                    </td>
                                </tr>
                            </table>  
                            &#160;<br />
                            <asp:Button ID="ubtn_CFV_Vehicles" runat="server" CausesValidation="True" 
                                CommandName="Update" Text="Update" />
                            &#160;<asp:Button ID="ubtnc_CFV_Vehicles" runat="server" CausesValidation="False" 
                                CommandName="Cancel" Text="Cancel" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                        </InsertItemTemplate>
                        <ItemTemplate>

                            <%-- Added by Andrew on 10/17/2019 --%>

                            <%--<table id="DPF_Record_Table" cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
			                        <td class="tdtable" style="width: 70px">
				                        Select DPF Record:
			                        </td>
			                        <td>
				                        <asp:DropDownList ID="ddl_DPF_Records" runat="server" DataSourceID="sds_DPF" DataTextField="VINNumber"
					                        DataValueField="IDDPF" AutoPostBack="True">
				                        </asp:DropDownList>
			                        </td>
		                        </tr>
                            </table>--%>

                             <%--<asp:Label ID="TestPrompt" runat="server" Visible="false" Text='<%# Bind("ModifiedDate") %>' />--%> 
  
                            <table id="DPF_Record_Table" cellpadding="0" cellspacing="0" style="width: 100%"> 
                                <%--<tr> 
                                    <td style="width: 100px;"> 
                                        <asp:Label ID="TestPrompt" runat="server" Text='<%# Bind("ModifiedDate") %>' /> 
                                    </td> 
                                </tr>--%> 
                                <tr> 
                                    <td class="tdtable" style="width: 70px"> 
                                        Select DPF Record: 
                                    </td> 
                                    <td> 
                                        <asp:DropDownList ID="ddl_DPF_Records" runat="server" DataSourceID="sds_DPF" DataTextField="EnterDate" 
                                            DataValueField="IDDPF" AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_DPF_Records_SelectedIndexChanged" AutoPostBack="true"> 
  
                                            <asp:ListItem Text="Select" Value="" /> 
                                        </asp:DropDownList> 
                                    </td> 
                                </tr> 
                            </table> 

                            <%-- End Of What was added by Andrew on 10/17/2019 --%>

                          <table style="width: 100%">
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Date: </td>
                                    <td style="width: 100px;">
                                        <asp:Label ID="lbl_Date" runat="server" Visible="false" Text='<%# Bind("ModifiedDate") %>' />
                                    </td>
                                    <td style="width: 83px; " class="tdtable">
                                        Invoice Number: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:Label ID="lbl_InvoiceNo" runat="server" Visible="false" Text='<%# Bind("InvoiceNumber") %>' />
                                    </td>
                                   <td style="width: 83px; " class="tdtable">
                                        PO Number: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:Label ID="lbl_PONo" runat="server" Visible="false" Text='<%# Bind("PONumber") %>' />
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td>
                                        &#160;</td>
                                </tr>
                            </table>
                            <table>
                                <tr>
				    <td style="width: 125px; text-align:left" class="tdtable">
				    <span style="color: #ED8701; font-size: medium; font-weight: bold">Vehicle</span>
				</td>
                               </tr>
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Company:
                                    </td>
                                    <td style="width: 102px;">
                                        <asp:Label ID="lbl_Company" runat="server" Text='<%# Bind("Company") %>' />
                                    </td>
                                    <td style="width: 83px; " class="tdtable">
                                        VIN #: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:Label ID="lbl_VINNo" runat="server" Visible="false" Text='<%# Bind("VINNumber") %>' />
                                    </td>
                                   <td style="width: 83px; " class="tdtable">
                                        Make: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:Label ID="lbl_Make" runat="server" Visible="false" Text='<%# Bind("Make") %>' />
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Model:
                                    </td>
                                    <td style="width: 102px;">
                                        <asp:Label ID="lbl_Model" runat="server" Visible="false" Text='<%# Bind("Model") %>' />
                                    </td>
                                    <td style="width: 83px; " class="tdtable">
                                        Plate No: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:Label ID="lbl_PlateNo" runat="server" Visible="false" Text='<%# Bind("Plate") %>' />
                                    </td>
                                   <td style="width: 83px; " class="tdtable">
                                        Miles: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:Label ID="lbl_Miles" runat="server" Visible="false" Text='<%# Bind("Miles") %>' />
                                    </td>
                                     </tr>
                                    <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Hours: 
                                    </td>
                                    <td style="width: 102px">
                                        <asp:Label ID="lbl_Hours" runat="server" Visible="false" Text='<%# Bind("Hours") %>' />
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td>
                                        &#160;</td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td style="width: 125px; text-align:left" class="tdtable">
										<span style="color: #ED8701; font-size: medium; font-weight: bold">Filter</span>
									</td>
                                </tr>
                            </table>
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Make/Model:
                                    </td>
                                    <td style="width: 67px">
                                        <asp:Label ID="lbl_MakeModel" runat="server" Visible="false" Text='<%# Bind("FilterMake") %>' />
                                    </td>
                                    <td style="width: 117px; " class="tdtable">
                                        Serial Number:
                                    </td>
                                    <td>
                                       <asp:Label ID="lbl_SerialNo" runat="server" Visible="false" Text='<%# Bind("SerialNumber") %>' />
                                    </td>
                                    <td style="width: 155px; " class="tdtable">
                                       Part Number:</td>
                                    <td>
                                        <asp:Label ID="lbl_PartNo" runat="server" Visible="false" Text='<%# Bind("PartNumber") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Substrate:
                                    </td>
                                    <td style="width: 67px">
                                        <asp:Label ID="lbl_Substrate" runat="server" Visible="false" Text='<%# Bind("Substrate") %>' />
                                    </td>
                                   	<td style="width: 117px; " class="tdtable">
                                        Doc Cleaned:
                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_DocCleaned" runat="server" Visible="false" Text='<%# Bind("DocCleaned") %>' />
                                    </td>
                                   </tr>
                                </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td>
                                        &#160;</td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td style="width: 125px; text-align:left" class="tdtable">
										<span style="color: #ED8701;  font-size: medium; font-weight: bold">Cleaning Results</span>
									</td>
                                </tr>
                            </table>
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 15px; " class="tdtable">
                                        Condition:
                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_Condition" runat="server" Visible="false" Text='<%# Bind("Condition") %>' />
                                    </td
                                </tr>
                            </table>
                            <table border="1">
                                <tr>
                                    <td style="width: 15%; " class="tdtable"> </td>
                                    <td style="width: 14%; " class="tdtable">DPF Initial</td>
                                   	<td style="width: 14%; " class="tdtable">DPF Final</td>
                                    <td style="width: 14%; " class="tdtable">Difference</td>
                                    <td style="width: 14%; " class="tdtable">DOC1 Initial</td>
                                    <td style="width: 14%; " class="tdtable">DOC1 Final</td>
                                    <td style="width: 14%; " class="tdtable">Difference</td>
                                  </tr>
                                <tr>
                                    <td style="width: 15%; " class="tdtable">Weight (Grams)</br>&nbsp;&nbsp;</td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="lbl_W_DPFInitial" runat="server" Visible="false" Text='<%# Bind("DPFInitWeight") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="lbl_W_DPFFinal" runat="server" Visible="false" Text='<%# Bind("DPFFinalWeight") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="lbl_W_DPFDiff" runat="server" Visible="false" Text='<%# Bind("DPFWeightDiff") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="lbl_DOC1Initial" runat="server" Visible="false" Text='<%# Bind("DOCInitWeight") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="lbl_DOC1Final" runat="server" Visible="false" Text='<%# Bind("DOCFinalWeight") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="lbl_DOC1Diff" runat="server" Visible="false" Text='<%# Bind("DOCWeightDiff") %>' /></td>
                                </tr>
                                <tr>
                                    <td style="width: 15%; " class="tdtable">Flow Restricition</br>(Inch of Water)</td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="F_DPFInitial" runat="server" Visible="false" Text='<%# Bind("DPFInitFR") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="F_DPFFinal" runat="server" Visible="false" Text='<%# Bind("DPFFinalFR") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="F_DPFDiff" runat="server" Visible="false" Text='<%# Bind("DPFFRDiff") %>' /></td>
                                    <td style="width: 14%; " class="tdtable">--------</td>
                                    <td style="width: 14%; " class="tdtable">--------</td>
                                    <td style="width: 14%; " class="tdtable">--------</td>
                                </tr>
                                </table>
                                <table>
								<tr>
									<td style="width: 175px; " class="tdtable">
                                        Wire Test Results:</td>
                                    <td style="width: 130px">
                                        <asp:Label ID="lbl_WireTestResults" runat="server" Visible="false" Text='<%# Bind("WTResults") %>' Width="60px" />
                                    </td>
                                </tr>
                                <tr>
									<td style="width: 175px; " class="tdtable">
                                        Cleaning Tech:</td>
                                    <td style="width: 130px">
                                        <asp:Label ID="lbl_CleaningTech" runat="server" Visible="false" Text='<%# Bind("CleaningTech") %>' Width="60px" />
                                    </td>
                                </tr>   
                                <tr>
                                    <td style="width: 200px; " class="tdtable">
                                        Required Multiple Cleanings:
                                    </td>
                                    <td>
                                       <asp:Label ID="lbl_MultipleCleanings" runat="server" Visible="false" Text='<%# Bind("MultipleCleanings") %>' />
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="width: 117px; " class="tdtable">
                                        Notes:
                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_Notes" runat="server" Visible="false" Height="65px" 
                                            Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="650px" />
                                    </td>
                                </tr>
                            </table>
                                   <asp:Button ID="EditButton" runat="server" Visible="false" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                   <%--<asp:Button ID="btnUpdate" Text='<%# "Update" %>' runat="server" CommandName='<%# "Update"%>'></asp:Button>--%>
                                   <asp:Button ID="btnCancel" Text="Cancel" runat="server" Visible="false" CausesValidation="False" CommandName="Cancel" /><%--</asp:Button>--%>
                           </ItemTemplate>
                        <%-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --%>
                        <EmptyDataTemplate>
                          <%--  No Cleaning Record Data.--%>

                            <%-- Added by Andrew on 10/17/2019 --%>

                            <table id="DPF_Record_Table" cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
			                        <td class="tdtable" style="width: 70px">
				                        Select DPF Record:
			                        </td>
			                        <td>
				                        <asp:DropDownList ID="ddl_DPF_Records" runat="server" DataSourceID="sds_DPF" DataTextField="VINNumber"
					                        DataValueField="IDDPF" AutoPostBack="true">
				                        </asp:DropDownList>
			                        </td>
		                        </tr>
                            </table>

                            <%-- End Of What was added by Andrew on 10/17/2019 --%>
                             <table style="width: 100%">
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Date: </td>
                                    <td style="width: 100px;">
                                        <asp:Label ID="lbl_Date" runat="server" Text='<%# Bind("ModifiedDate") %>' />
                                    </td>
                                    <td style="width: 83px; " class="tdtable">
                                        Invoice Number: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:Label ID="lbl_InvoiceNo" runat="server" Text='<%# Bind("InvoiceNumber") %>' />
                                    </td>
                                   <td style="width: 83px; " class="tdtable">
                                        PO Number: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:Label ID="lbl_PONo" runat="server" Text='<%# Bind("PONumber") %>' />
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td>
                                        &#160;</td>
                                </tr>
                            </table>
                            <table>
                                <tr>
				    <td style="width: 125px; text-align:left" class="tdtable">
				    <span style="color: #ED8701; font-size: medium; font-weight: bold">Vehicle</span>
				</td>
                               </tr>
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Company:
                                    </td>
                                    <td style="width: 102px;">
                                        <asp:Label ID="lbl_Company" runat="server" Text='<%# Bind("Company") %>' />
                                    </td>
                                    <td style="width: 83px; " class="tdtable">
                                        VIN #: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:Label ID="lbl_VINNo" runat="server" Text='<%# Bind("VINNumber") %>' />
                                    </td>
                                   <td style="width: 83px; " class="tdtable">
                                        Make: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:Label ID="lbl_Make" runat="server" Text='<%# Bind("Make") %>' />
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Model:
                                    </td>
                                    <td style="width: 102px;">
                                        <asp:Label ID="lbl_Model" runat="server" Text='<%# Bind("Model") %>' />
                                    </td>
                                    <td style="width: 83px; " class="tdtable">
                                        Plate No: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:Label ID="lbl_PlateNo" runat="server" Text='<%# Bind("Plate") %>' />
                                    </td>
                                   <td style="width: 83px; " class="tdtable">
                                        Miles: </td>
                                    <td style="width: 190px" colspan="3">
                                        <asp:Label ID="lbl_Miles" runat="server" Text='<%# Bind("Miles") %>' />
                                    </td>
                                     </tr>
                                    <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Hours: 
                                    </td>
                                    <td style="width: 102px">
                                        <asp:Label ID="lbl_Hours" runat="server" Text='<%# Bind("Hours") %>' />
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td>
                                        &#160;</td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td style="width: 125px; text-align:left" class="tdtable">
										<span style="color: #ED8701; font-size: medium; font-weight: bold">Filter</span>
									</td>
                                </tr>
                            </table>
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Make/Model:
                                    </td>
                                    <td style="width: 67px">
                                        <asp:Label ID="lbl_MakeModel" runat="server" Text='<%# Bind("FilterMake") %>' />
                                    </td>
                                    <td style="width: 117px; " class="tdtable">
                                        Serial Number:
                                    </td>
                                    <td>
                                       <asp:Label ID="lbl_SerialNo" runat="server" Text='<%# Bind("SerialNumber") %>' />
                                    </td>
                                    <td style="width: 155px; " class="tdtable">
                                       Part Number:</td>
                                    <td>
                                        <asp:Label ID="lbl_PartNo" runat="server" Text='<%# Bind("PartNumber") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 90px; " class="tdtable">
                                        Substrate:
                                    </td>
                                    <td style="width: 67px">
                                        <asp:Label ID="lbl_Substrate" runat="server" Text='<%# Bind("Substrate") %>' />
                                    </td>
                                   	<td style="width: 117px; " class="tdtable">
                                        Doc Cleaned:
                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_DocCleaned" runat="server" Text='<%# Bind("DocCleaned") %>' />
                                    </td>
                                   </tr>
                                </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td>
                                        &#160;</td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td style="width: 125px; text-align:left" class="tdtable">
										<span style="color: #ED8701;  font-size: medium; font-weight: bold">Cleaning Results</span>
									</td>
                                </tr>
                            </table>
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 15px; " class="tdtable">
                                        Condition:
                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_Condition" runat="server" Text='<%# Bind("Condition") %>' />
                                    </td
                                </tr>
                            </table>
                            <table border="1">
                                <tr>
                                    <td style="width: 15%; " class="tdtable"> </td>
                                    <td style="width: 14%; " class="tdtable">DPF Initial</td>
                                   	<td style="width: 14%; " class="tdtable">DPF Final</td>
                                    <td style="width: 14%; " class="tdtable">Difference</td>
                                    <td style="width: 14%; " class="tdtable">DOC1 Initial</td>
                                    <td style="width: 14%; " class="tdtable">DOC1 Final</td>
                                    <td style="width: 14%; " class="tdtable">Difference</td>
                                  </tr>
                                <tr>
                                    <td style="width: 15%; " class="tdtable">Weight (Grams)</br>&nbsp;&nbsp;</td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="lbl_W_DPFInitial" runat="server" Text='<%# Bind("DPFInitWeight") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="lbl_W_DPFFinal" runat="server" Text='<%# Bind("DPFFinalWeight") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="lbl_W_DPFDiff" runat="server" Text='<%# Bind("DPFWeightDiff") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="lbl_DOC1Initial" runat="server" Text='<%# Bind("DOCInitWeight") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="lbl_DOC1Final" runat="server" Text='<%# Bind("DOCFinalWeight") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="lbl_DOC1Diff" runat="server" Text='<%# Bind("DOCWeightDiff") %>' /></td>
                                </tr>
                                <tr>
                                    <td style="width: 15%; " class="tdtable">Flow Restricition</br>(Inch of Water)</td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="F_DPFInitial" runat="server" Text='<%# Bind("DPFInitFR") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="F_DPFFinal" runat="server" Text='<%# Bind("DPFFinalFR") %>' /></td>
                                    <td style="width: 14%; " class="tdtable"><asp:Label ID="F_DPFDiff" runat="server" Text='<%# Bind("DPFFRDiff") %>' /></td>
                                    <td style="width: 14%; " class="tdtable">--------</td>
                                    <td style="width: 14%; " class="tdtable">--------</td>
                                    <td style="width: 14%; " class="tdtable">--------</td>
                                </tr>
                                </table>
                                <table>
								<tr>
									<td style="width: 175px; " class="tdtable">
                                        Wire Test Results:</td>
                                    <td style="width: 130px">
                                        <asp:Label ID="lbl_WireTestResults" runat="server" Text='<%# Bind("WTResults") %>' Width="60px" />
                                    </td>
                                </tr>
                                <tr>
									<td style="width: 175px; " class="tdtable">
                                        Cleaning Tech:</td>
                                    <td style="width: 130px">
                                        <asp:Label ID="lbl_CleaningTech" runat="server" Text='<%# Bind("CleaningTech") %>' Width="60px" />
                                    </td>
                                </tr>   
                                <tr>
                                    <td style="width: 200px; " class="tdtable">
                                        Required Multiple Cleanings:
                                    </td>
                                    <td>
                                       <asp:Label ID="lbl_MultipleCleanings" runat="server" Text='<%# Bind("MultipleCleanings") %>' />
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="width: 117px; " class="tdtable">
                                        Notes:
                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_Notes" runat="server" Height="65px" 
                                            Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="650px" />
                                    </td>
                                </tr>
                            </table>
                                   <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                   <%--<asp:Button ID="btnUpdate" Text='<%# "Update" %>' runat="server" CommandName='<%# "Update"%>'></asp:Button>--%>
                                   <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False" CommandName="Cancel" /><%--</asp:Button>--%>
                        </EmptyDataTemplate>
                    </asp:FormView>
                    </table>
                   </telerik:RadPageView>
</telerik:radmultipage>

<%--<script type="text/javascript">
	Telerik.Web.UI.RadGrid.prototype._canRiseRowEvent = function(e) {
		var el = Telerik.Web.UI.Grid.GetCurrentElement(e);
		var exclude = "input,select,option,button,a,textarea";
		if (!(el && el.tagName && exclude.indexOf(el.tagName.toLowerCase()) < 0)) {
			return false;
		}
		if (this.get_masterTableView() && !Telerik.Web.UI.Grid.IsChildOf(el, this.get_masterTableView().get_element()))
			return false;
		return true;
	}
	Telerik.Web.UI.GridSelection.prototype._shouldRaiseRowEvent = function(el) {
		var isClientSelectCheckBox = (el.tagName.toLowerCase() == "input" &&
			el.type.toLowerCase() == "checkbox" &&
			el.id && el.id.indexOf("SelectCheckBox") != -1);
		var exclude = "input,select,option,button,a,textarea";
		return !isClientSelectCheckBox && exclude.indexOf(el.tagName.toLowerCase()) < 0;
	}
</script>--%>

<telerik:RadWindowManager ID="RadWindowManager1" runat="server" Height="600" Modal="true" Width="800"></telerik:RadWindowManager>

	<asp:SqlDataSource ID="sds_CFV_Fleet_Lineage" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDProfileAccount], [AccountName], [IDProfileTerminal], [TerminalName], [IDProfileFleet], [FleetName], IDVehicles FROM [CFV_Fleet_Lineage] WHERE ([IDProfileFleet] = @IDProfileFleet)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileFleet" QueryStringField="IDProfileFleet"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_CFV_Vehicles" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDVehicles], [IDModifiedUser], [EnterDate], [ModifiedDate], [IDProfileAccount], [AccountName], [IDProfileTerminal], [TerminalName], [IDProfileFleet], [FleetName], [EquipmentType], [EquipmentCategory], [SpecialProvision], [VehicleStatus], [CARBGroup], [LicensePlateNo], [ChassisVIN], [ChassisMake], [ChassisModelYear], [UnitNo], [Description], [AnnualMiles], [AnnualHours], [ActualMiles], [ActualHours], [PlannedComplianceDate], [ActualComplianceDate], [BackupStatusDate], [RetireStatusDate], [LastOpacityTestDate], [Notes], [NotesCF] FROM [CFV_Vehicles] WHERE ([IDProfileFleet] = @IDProfileFleet)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileFleet" QueryStringField="IDProfileFleet"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_CFV_Vehicles_fv" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDVehicles], [IDModifiedUser], [EnterDate], [ModifiedDate], [PlannedRetirementDate], [ActualRetirementDate], [EstReplacementCost], [IDProfileAccount], [AccountName], [IDProfileTerminal], [TerminalName], [IDProfileFleet], [FleetName], [IDEquipmentType], [EquipmentType], [IDEquipmentCategory], [EquipmentCategory], [IDVehicleStatus], [VehicleStatus], [IDCARBGroup], [CARBGroup], [IDVehicleKey], [InPossession], [LicensePlateState], [LicensePlateNo], [ChassisVIN], [ChassisModel], [IDChassisMake], [ChassisMake], [IDChassisModelYear], [ChassisModelYear], [UnitNo], [Description], [AnnualMiles], [AnnualHours], [ActualMiles], [ActualHours], [GrossVehicleWeight], [ActualInServiceDate], [EstimatedInServiceDate], [PlannedComplianceDate], [ActualComplianceDate], [BackupStatusDate], [RetireStatusDate], [LastOpacityTestDate], [Notes], [NotesCF] FROM [CFV_Vehicles] WHERE ([IDVehicles] = @IDVehicles)"
		DeleteCommand="DELETE FROM [CF_Vehicles] WHERE [IDVehicles] = @IDVehicles"
		UpdateCommand="UPDATE [CF_Vehicles] SET [IDModifiedUser] = @IDModifiedUser, [PlannedRetirementDate] = @PlannedRetirementDate, [ActualRetirementDate] = @ActualRetirementDate, [EstReplacementCost] = @EstReplacementCost, [ModifiedDate] = @ModifiedDate, [IDEquipmentType] = @IDEquipmentType, [IDEquipmentCategory] = @IDEquipmentCategory, [IDVehicleKey] = @IDVehicleKey, [InPossession] = @InPossession, [IDVehicleStatus] = @IDVehicleStatus, [IDCARBGroup] = @IDCARBGroup, [LicensePlateState] = UPPER(@LicensePlateState), [LicensePlateNo] = @LicensePlateNo, [ChassisVIN] = @ChassisVIN, [ChassisModel] = @ChassisModel, [IDChassisMake] = @IDChassisMake, [IDChassisModelYear] = @IDChassisModelYear, [UnitNo] = @UnitNo, [Description] = @Description, [AnnualMiles] = @AnnualMiles, [AnnualHours] = @AnnualHours, [ActualMiles] = @ActualMiles, [ActualHours] = @ActualHours, [GrossVehicleWeight] = @GrossVehicleWeight, [ActualInServiceDate] = @ActualInServiceDate, [EstimatedInServiceDate] = @EstimatedInServiceDate, [PlannedComplianceDate] = @PlannedComplianceDate, [ActualComplianceDate] = @ActualComplianceDate, [BackupStatusDate] = @BackupStatusDate, [RetireStatusDate] = @RetireStatusDate, [LastOpacityTestDate] = @LastOpacityTestDate, [Notes] = @Notes, [NotesCF] = @NotesCF WHERE [IDVehicles] = @IDVehicles">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDVehicles" />
		</DeleteParameters>
		<UpdateParameters>
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:Parameter Name="ModifiedDate" Type="DateTime" />
			<asp:Parameter Name="IDProfileFleet" Type="Int32" />
			<asp:Parameter Name="IDEquipmentType" Type="Int32" />
			<asp:Parameter Name="IDEquipmentCategory" Type="Int32" />
			<asp:Parameter Name="IDSpecialProvision" Type="Int32" />
			<asp:Parameter Name="IDVehicleStatus" Type="Int32" />
			<asp:Parameter Name="IDCARBGroup" Type="Int32" />
			<asp:Parameter Name="LicensePlateState" Type="String" />
			<asp:Parameter Name="LicensePlateNo" Type="String" />
			<asp:Parameter Name="ChassisVIN" Type="String" />
			<asp:Parameter Name="IDChassisMake" Type="Int32" />
			<asp:Parameter Name="ChassisModel" Type="String" />
			<asp:Parameter Name="IDChassisModelYear" Type="Int32" />
			<asp:Parameter Name="UnitNo" Type="String" />
			<asp:Parameter Name="Description" Type="String" />
			<asp:Parameter Name="AnnualMiles" Type="String" />
			<asp:Parameter Name="AnnualHours" Type="String" />
			<asp:Parameter Name="ActualMiles" Type="String" />
			<asp:Parameter Name="ActualHours" Type="String" />
			<asp:Parameter Name="GrossVehicleWeight" Type="String" />
			<asp:Parameter Name="ActualInServiceDate" Type="DateTime" />
			<asp:Parameter Name="EstimatedInServiceDate" Type="DateTime" />
			<asp:Parameter Name="PlannedComplianceDate" Type="DateTime" />
			<asp:Parameter Name="ActualComplianceDate" Type="DateTime" />
			<asp:Parameter Name="BackupStatusDate" Type="DateTime" />
			<asp:Parameter Name="RetireStatusDate" Type="DateTime" />
			<asp:Parameter Name="PlannedRetirementDate" Type="DateTime" />
			<asp:Parameter Name="ActualRetirementDate" Type="DateTime" />
			<asp:Parameter Name="EstReplacementCost" Type="String" />
			<asp:Parameter Name="Notes" Type="String" />
			<asp:Parameter Name="NotesCF" Type="String" />
            <asp:Parameter Name="IDVehicleKey" Type="Int32" />
            <asp:Parameter Name="InPossession" Type="String" />
			<asp:Parameter Name="IDVehicles" />
		</UpdateParameters>
		<InsertParameters>
		</InsertParameters>
	</asp:SqlDataSource>

    <%-- Added by Andrew on 10/18/2019 --%>

    <asp:SqlDataSource ID="sds_CFV_DPF_fv" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
        SelectCommand="SELECT [IDDPF], [IDModifiedUser], [ModifiedDate], [InvoiceNumber], [PONumber], [Company], [VINNumber], [Make], [Model], [Plate], [Miles], [Hours], [FilterMake], [SerialNumber], [PartNumber], [Substrate], [DocCleaned], [Condition], [DPFInitWeight], [DPFFinalWeight], [DPFWeightDiff], [DOCInitWeight], [DOCFinalWeight], [DOCWeightDiff], [DPFInitFR], [DPFFinalFR], [DPFFRDiff], [WTResults], [CleaningTech], [MultipleCleanings], [Notes] FROM [CF_DPF]"> 
        
    </asp:SqlDataSource> 

    <%-- End of what was added by Andrew on 10/18/2019 --%>

    <%-- Commented out by Andrew on 10/18/2019 to test duplicated code chunk above. --%>

   <%--<asp:SqlDataSource ID="sds_CFV_DPF_fv" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
        SelectCommand="SELECT [IDDPF], [IDModifiedUser], [ModifiedDate], [IDVehicles], [InvoiceNumber], [PONumber], [Company], [VINNumber], [Make], [Model], [Plate], [Miles], [Hours], [FilterMake], [SerialNumber], [PartNumber], [Substrate], [DocCleaned], [Condition], [DPFInitWeight], [DPFFinalWeight], [DPFWeightDiff], [DOCInitWeight], [DOCFinalWeight], [DOCWeightDiff], [DPFInitFR], [DPFFinalFR], [DPFFRDiff], [WTResults], [CleaningTech], [MultipleCleanings], [Notes] FROM [CFV_DPF] WHERE ([IDDPF] = @IDDPF)" 
        UpdateCommand="UPDATE [CF_DPF] SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate, [InvoiceNumber] = @InvoiceNumber, [PONumber] = @PONumber, [Company] = @Company, [VINNumber] = @VINNumber, [Make] = @Make, [Model] = @Model, [Plate] = @Plate, [Miles] = @Miles, [Hours] = @Hours, [FilterMake] = @FilterMake, [SerialNumber] = @SerialNumber, [PartNumber] = @PartNumber, [Substrate] = @Substrate, [DocCleaned] = @DocCleaned, [Condition] = @Condition, [DPFInitWeight] = @DPFInitWeight, [DPFFinalWeight] = @DPFFinalWeight, [DPFWeightDiff] = @DPFWeightDiff, [DOCInitWeight] = @DOCInitWeight, [DOCFinalWeight] = @DOCFinalWeight, [DOCWeightDiff] = @DOCWeightDiff, [DPFInitFR] = @DPFInitFR, [DPFFinalFR] = @DPFFinalFR, [DPFFRDiff] = @DPFFRDiff, [WTResults] = @WTResults, [CleaningTech] = @CleaningTech, [MultipleCleanings] = @MultipleCleanings, [Notes] = @Notes  WHERE [IDDPF] = @IDDPF"> 
    <DeleteParameters> 
        <asp:Parameter Name="IDDPF" /> 
    </DeleteParameters> 
    <SelectParameters> 
        <asp:QueryStringParameter Name="IDDPF" QueryStringField="IDDPF" /> 
    </SelectParameters> 
    <UpdateParameters> 
        <asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" /> 
        <asp:Parameter Name="ModifiedDate" Type="DateTime" /> 
        <asp:Parameter Name="InvoiceNumber" Type="String" /> 
        <asp:Parameter Name="PONumber" Type="String" /> 
        <asp:Parameter Name="Company" Type="String" /> 
        <asp:Parameter Name="VINNumber" Type="String" /> 
        <asp:Parameter Name="Make" Type="String" /> 
        <asp:Parameter Name="Model" Type="String" /> 
        <asp:Parameter Name="Plate" Type="String" /> 
        <asp:Parameter Name="Miles" Type="Int32" /> 
        <asp:Parameter Name="Hours" Type="Int32" /> 
        <asp:Parameter Name="FilterMake" Type="String" /> 
        <asp:Parameter Name="SerialNumber" Type="Int32" /> 
        <asp:Parameter Name="PartNumber" Type="Int32" /> 
        <asp:Parameter Name="Substrate" Type="String" /> 
        <asp:Parameter Name="DocCleaned" Type="String" /> 
        <asp:Parameter Name="Condition" Type="String" /> 
        <asp:Parameter Name="DPFInitWeight" Type="Int32" /> 
        <asp:Parameter Name="DPFFinalWeight" Type="Int32" /> 
        <asp:Parameter Name="DPFWeightDiff" Type="Int32" /> 
        <asp:Parameter Name="DOCInitWeight" Type="Int32" /> 
        <asp:Parameter Name="DOCFinalWeight" Type="Int32" /> 
        <asp:Parameter Name="DOCWeightDiff" Type="Int32" /> 
        <asp:Parameter Name="DPFInitFR" Type="String" /> 
        <asp:Parameter Name="DPFFinalFR" Type="String" /> 
        <asp:Parameter Name="DPFFRDiff" Type="String" /> 
        <asp:Parameter Name="WTResults" Type="String" /> 
        <asp:Parameter Name="CleaningTech" Type="String" /> 
        <asp:Parameter Name="MultipleCleanings" Type="String" /> 
        <asp:Parameter Name="Notes" Type="String" /> 
        <asp:Parameter Name="IDDPF" /> 
        </UpdateParameters> 
    <InsertParameters> 
    </InsertParameters> 
    </asp:SqlDataSource>--%>
    
    <%-- End of what was commented out by Andrew on 10/18/2019 to test duplicated code chunk above. --%>

	<asp:SqlDataSource ID="sds_ddl_Op_ChassisMake" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="ChassisMake" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_State" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="state" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_OpacityTestsLog" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		DeleteCommand="DELETE FROM [CF_Vehicles_Log_OpacityTests] WHERE [IDOpacityTestsLog]= @IDOpacityTestsLog"
		InsertCommand="INSERT INTO [CF_Vehicles_Log_OpacityTests] ([IDVehicles], [TestDate], [TestedBy], [AverageOpacity], [TestResult]) VALUES (@IDVehicles, @TestDate, @TestedBy, @AverageOpacity, UPPER(@TestResult))"
		SelectCommand="SELECT [IDOpacityTestsLog], [IDVehicles], [TestDate], [TestedBy], [AverageOpacity], [TestResult] FROM [CF_Vehicles_Log_OpacityTests] WHERE ([IDVehicles] = @IDVehicles) ORDER BY TestDate"
		UpdateCommand="UPDATE [CF_Vehicles_Log_OpacityTests] SET [TestDate] = @TestDate, [TestedBy] = @TestedBy, [AverageOpacity] = @AverageOpacity, [TestResult] = @TestResult WHERE [IDOpacityTestsLog] = @IDOpacityTestsLog">
		<DeleteParameters>
			<asp:Parameter Name="IDOpacityTestsLog" />
		</DeleteParameters>
		<InsertParameters>
			<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
			<asp:Parameter Name="TestDate" />
			<asp:Parameter Name="TestedBy" />
			<asp:Parameter Name="AverageOpacity" />
			<asp:Parameter Name="TestResult" />
		</InsertParameters>
		<SelectParameters>
			<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="TestDate" />
			<asp:Parameter Name="TestedBy" />
			<asp:Parameter Name="AverageOpacity" />
			<asp:Parameter Name="TestResult" />
			<asp:Parameter Name="IDOpacityTestsLog" />
		</UpdateParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_MileageLog" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		DeleteCommand="DELETE FROM [CF_Vehicles_Log_Mileage] WHERE [IDMileageLog] = @IDMileageLog"
		InsertCommand="INSERT INTO [CF_Vehicles_Log_Mileage] ([IDVehicles], [Mileage], [MileageDate]) VALUES (@IDVehicles, @Mileage, @MileageDate)"
		SelectCommand="SELECT [IDMileageLog], [IDVehicles], [Mileage], [MileageDate] FROM [CFV_Vehicles_Log_Mileage] WHERE ([IDVehicles] = @IDVehicles) ORDER BY MileageDate "
		UpdateCommand="UPDATE [CF_Vehicles_Log_Mileage] SET [Mileage] = @Mileage, [MileageDate] = @MileageDate WHERE [IDMileageLog] = @IDMileageLog">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDMileageLog" />
		</DeleteParameters>
		<UpdateParameters>
			<asp:Parameter Name="Mileage" Type="Int32" />
			<asp:Parameter Name="MileageDate" Type="DateTime" />
			<asp:Parameter Name="IDMileageLog" />
			<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
		</UpdateParameters>
		<InsertParameters>
			<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
			<asp:Parameter Name="Mileage" Type="Int32" />
			<asp:Parameter Name="MileageDate" Type="DateTime" />
		</InsertParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_HoursLog" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		DeleteCommand="DELETE FROM [CF_Vehicles_Log_Hours] WHERE [IDHoursLog] = @IDHoursLog"
		InsertCommand="INSERT INTO [CF_Vehicles_Log_Hours] ([IDVehicles], [Hours], [HoursDate]) VALUES (@IDVehicles, @Hours, @HoursDate)"
		SelectCommand="SELECT [IDHoursLog], [IDVehicles], [Hours], [HoursDate] FROM [CF_Vehicles_Log_Hours] WHERE ([IDVehicles] = @IDVehicles)"
		UpdateCommand="UPDATE [CF_Vehicles_Log_Hours] SET [Hours] = @Hours, [HoursDate] = @HoursDate WHERE [IDHoursLog] = @IDHoursLog">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDHoursLog" />
		</DeleteParameters>
		<UpdateParameters>
			<asp:Parameter Name="Hours" Type="Int32" />
			<asp:Parameter Name="HoursDate" Type="DateTime" />
			<asp:Parameter Name="IDHoursLog" />
		</UpdateParameters>
		<InsertParameters>
			<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
			<asp:Parameter Name="Hours" Type="Int32" />
			<asp:Parameter Name="HoursDate" Type="DateTime" />
		</InsertParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_CFV_Engines_fv" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDEngines], [IDModifiedUser], [ModifiedDate], [IDVehicles], [IDEngineManufacturer], [EngineManufacturer], [EngineModel], [Displacement], [EstRetrofitCost], [EngineModel], [IDEngineStatus], [EngineStatus], [IDEngineFuelType], [EngineFuelType], [SerialNum], [Description], [IDModelYear], [ModelYear], [FamilyName], [SeriesModelNo], [Horsepower], [Notes], [NotesCF] FROM [CFV_Engines] WHERE ([IDEngines] = @IDEngines)"
		UpdateCommand="UPDATE [CF_Engines] SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate, [IDEngineManufacturer] = @IDEngineManufacturer, [EngineModel] = @EngineModel, [Displacement] = @Displacement, [EstRetrofitCost] = @EstRetrofitCost, [IDEngineStatus] = @IDEngineStatus, [IDEngineFuelType] = @IDEngineFuelType, [IDModelYear] = @IDModelYear, [SerialNum] = @SerialNum, [FamilyName] = @FamilyName, [SeriesModelNo] = @SeriesModelNo, [Horsepower] = @Horsepower, [Description] = @Description, [Notes] = @Notes, [NotesCF] = @NotesCF WHERE [IDEngines] = @IDEngines">
		<DeleteParameters>
			<asp:Parameter Name="IDEngines" />
		</DeleteParameters>
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_Engines" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
		<UpdateParameters>
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:Parameter Name="ModifiedDate" Type="DateTime" />
			<asp:Parameter Name="IDEngineManufacturer" Type="Int32" />
			<asp:Parameter Name="EngineModel" Type="String" />
			<asp:Parameter Name="IDEngineStatus" Type="Int32" />
			<asp:Parameter Name="IDEngineFuelType" Type="Int32" />
			<asp:Parameter Name="IDModelYear" Type="Int32" />
			<asp:Parameter Name="SerialNum" Type="String" />
			<asp:Parameter Name="FamilyName" Type="String" />
			<asp:Parameter Name="SeriesModelNo" Type="String" />
			<asp:Parameter Name="Horsepower" Type="String" />
			<asp:Parameter Name="Displacement" Type="String" />
			<asp:Parameter Name="EstRetrofitCost" Type="String" />
			<asp:Parameter Name="Description" Type="String" />
			<asp:Parameter Name="Notes" Type="String" />
			<asp:Parameter Name="NotesCF" Type="String" />
			<asp:Parameter Name="IDEngines" />
		</UpdateParameters>
		<InsertParameters>
		</InsertParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_CFV_Engines_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDEngines], [SerialNum], [Description], [ModelYear], [FamilyName], [SeriesModelNo], [EngineModel] FROM [CFV_Engines] WHERE ([IDVehicles] = @IDVehicles)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_EquipType" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="EquipmentType" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_SpecialProvision" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="SpecialProvision" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_EquipCat" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="EquipmentCategory" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_VehStatus" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="VehicleStatus" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_CARBGroup" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="CARBGroup" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_EngineManufacturer" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="EngineManufacturer" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_EngineModel" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [EngineModel] FROM [CFV_EngineModel] ORDER BY [EngineModel]">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_EngineStatus" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="EngineStatus" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_EngineFuelType" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="EngineFuelType" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
 
    <asp:SqlDataSource ID="sds_ddl_VehicleKey" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
        SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]"> 
        <SelectParameters> 
            <asp:QueryStringParameter DefaultValue="VehicleKey" Name="OptionName" QueryStringField="OptionName"  
                Type="String" /> 
        </SelectParameters> 
    </asp:SqlDataSource> 
   	<asp:SqlDataSource ID="sds_CFV_DECs_lv" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDDECS], [IDModifiedUser], [EnterDate], [ModifiedDate], [IDEngines], [DECSName], [SerialNo], [IDDECSManufacturer], [DECSManufacturer], [IDDECSLevel], [DECSLevel], [DECSModelNo], [DECSInstallationDate], [Notes], [NotesCF] FROM [CFV_DECs] WHERE ([IDEngines] = @IDEngines)"
		UpdateCommand="UPDATE [CF_DECs] SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate, [DECSName] = @DECSName, [SerialNo] = @SerialNo, [IDDECSManufacturer] = @IDDECSManufacturer, [IDDECSLevel] = @IDDECSLevel, [DECSModelNo] = @DECSModelNo, [DECSInstallationDate] = @DECSInstallationDate, [Notes] = @Notes, [NotesCF] = @NotesCF WHERE [IDDECS] = @IDDECS">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_Engines" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
		<UpdateParameters>
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:Parameter Name="ModifiedDate" Type="DateTime" />
			<asp:Parameter Name="DECSName" Type="String" />
			<asp:Parameter Name="IDDECSManufacturer" Type="Int32" />
			<asp:Parameter Name="IDDECSLevel" Type="Int32" />
			<asp:Parameter Name="DECSModelNo" Type="String" />
			<asp:Parameter Name="SerialNo" Type="String" />
			<asp:Parameter Name="DECSInstallationDate" Type="DateTime" />
			<asp:Parameter Name="Notes" Type="String" />
			<asp:Parameter Name="NotesCF" Type="String" />
		</UpdateParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_DECs_Op_Level" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="DECSLevel" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_DECs_Op_Manufacturer" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="DECSManufacturer" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_Year" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) 
		UNION SELECT NULL AS [IDOptionList], '' AS [RecordValue], '' AS [DisplayValue], @OptionName AS [OptionName]  
		ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="Year" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ImagesVehicle" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDImages], [DefaultImage], [IDModifiedUser], [ModifiedDate], [IDVehicles], [IDEngines], [Title], [FilePath], [FileName], [UserID], [EnterDate] FROM [CF_Images] WHERE ([IDVehicles] = @IDVehicles)"
		DeleteCommand="DELETE FROM [CF_Images] WHERE [IDImages] = @IDImages">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDImages" />
		</DeleteParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ImagesEngines" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDImages], [DefaultImage], [IDModifiedUser], [ModifiedDate], [IDVehicles], [IDEngines], [Title], [FilePath], [FileName], [UserID], [EnterDate] FROM [CFV_Images_Engines] WHERE ([IDEngines] = @IDEngines)"
		DeleteCommand="DELETE FROM [CF_Images] WHERE [IDImages] = @IDImages">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_EnginesFiles" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDImages" />
		</DeleteParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ImagesDECs" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDImages], [DefaultImage], [IDModifiedUser], [ModifiedDate], [IDVehicles], [IDEngines], [IDDECS], [Title], [FilePath], [FileName], [UserID], [EnterDate] FROM [CFV_Images_DECS] WHERE ([IDEngines] = @IDEngines)"
		DeleteCommand="DELETE FROM [CF_Images] WHERE [IDImages] = @IDImages">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_EnginesFiles" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDImages" />
		</DeleteParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDEngines] FROM [CF_Engines] WHERE ([IDEngines] = @IDEngines)">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_EngineFiles" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Fleets" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDProfileFleet], [FleetName] FROM [CFV_A_T_F_Names] WHERE ([IDProfileTerminal] = @IDProfileTerminal) ORDER BY [TerminalName]">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileTerminal" QueryStringField="IDProfileTerminal"
				Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ImagesVehicle_fvw" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDImages], [IDVehicles], [IDEngines], [IDDECS], [Title], [Image] FROM [CFV_Images_Default] WHERE ([IDVehicles] = @IDVehicles)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_FilesVehicle" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDFile], [IDModifiedUser], [ModifiedDate], [IDVehicles], [Title], [FilePath], [FileName], [EnterDate], [IDDocumentType], [DisplayValue] FROM [CF_Files] LEFT OUTER JOIN CF_OPTION_LIST ON [IDOptionList] = [IDDocumentType]  WHERE ([IDVehicles] = @IDVehicles)"
		DeleteCommand="DELETE FROM [CF_Files] WHERE [IDFile] = @IDFile">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDFile" />
		</DeleteParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ImagesEngines_fvw" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDImages], [IDVehicles], [IDEngines], [IDDECS], [Title], [Image] FROM [CFV_Images_Default] WHERE ([IDEngines] = @IDEngines) AND IDDECS IS NULL">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_Engines" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_FilesEngine" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDFile], [Title], [FileName], [FilePath], [IDEngines], [IDDocumentType], [DisplayValue] FROM [CF_Files] LEFT OUTER JOIN CF_OPTION_LIST ON [IDOptionList] = [IDDocumentType] WHERE ([IDEngines] = @IDEngines)"
		DeleteCommand="DELETE FROM [CF_Files] WHERE [IDFile] = @IDFile">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_EnginesFiles" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDFile" />
		</DeleteParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ImagesDECs_fvw" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDImages], [IDVehicles], [IDEngines], [IDDECS], [Title], [Image] FROM [CFV_Images_Default] WHERE ([IDEngines] = @IDEngines) AND IDDECS IS NOT NULL">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_Engines" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_FilesDECS" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDFile], [Title], [FileName], [FilePath], [IDEngines], [IDDECS], [IDDocumentType], [DisplayValue] FROM [CF_Files] LEFT OUTER JOIN CF_OPTION_LIST ON [IDOptionList] = [IDDocumentType] WHERE ([IDEngines] = @IDEngines)"
		DeleteCommand="DELETE FROM [CF_Files] WHERE [IDFile] = @IDFile">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_EnginesFiles" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDFile" />
		</DeleteParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_rg_DECSImages" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDImages], [IDVehicles], [IDEngines], [IDDECS], [Title], [Image] FROM [CFV_Images_Default] WHERE ([IDEngines] = @IDEngines) AND IDDECS IS NOT NULL">
		<SelectParameters>
			<asp:Parameter DefaultValue="" Name="IDEngines" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_CF_Milestones" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT MilestoneDate FROM [CF_Compliance_Milestones] ORDER BY [MilestoneDate]">
	</asp:SqlDataSource>

    <%-- Added by Andrew on 10/17/2019 --%>
	
	<asp:SqlDataSource ID="sds_DPF" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [EnterDate], [IDDPF] FROM [CF_DPF] WHERE [VINNUMBER] = @ChassisVINHolderParam ORDER BY [EnterDate]">
		<SelectParameters>
		<%--<asp:QueryStringParameter Name="VINNumber" QueryStringField="VINNUmber"
				Type="Int32" />--%>
            <asp:ControlParameter Name="ChassisVINHolderParam" ControlID="ChassisVINHolder" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>

    <%--<asp:SqlDataSource ID="sds_DPF_2" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [EnterDate], [IDDPF] FROM [CF_DPF] WHERE [VINNUMBER] = @ChassisVINTextBoxParam ORDER BY [EnterDate]">
		<SelectParameters>--%>
		<%--<asp:QueryStringParameter Name="VINNumber" QueryStringField="VINNUmber"
				Type="Int32" />--%>
            <%--<asp:ControlParameter Name="ChassisVINTextBoxParam" ControlID="fv_CFV_Vehicles$ChassisVINTextBox" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>--%>

    <%-- End of what was added by Andrew on 10/17/2019 --%>

</asp:Content>

