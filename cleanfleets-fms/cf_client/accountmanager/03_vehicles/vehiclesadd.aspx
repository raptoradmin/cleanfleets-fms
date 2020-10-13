<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="vehiclesadd.aspx.vb" Inherits="cleanfleets_fms.vehiclesadd" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<style type="text/css">
		.inputTitle {
			/*width: 175px;*/
			text-align: right;
			font-weight: bold;
			color: #2C7500;
			font-size: small;
		}
	</style>

	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Add Vehicle</p>
	<table style="width: 800px;">
		<tr>
			<td style="font-size: small; font-weight: bold; text-align: right; width: 125px;
				color: #2C7500">
				Fleet Name:
			</td>
			<td>
				<p>
					<asp:Label ID="lbl_FleetName" runat="server" Text='<%# Bind("FleetName") %>'></asp:Label>
					&nbsp;</p>
			</td>
		</tr>
	</table>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Vehicle Details</p>
	<table style="width: 100%">
		<tr>
			<td style="width: 90px;" class="inputTitle">
				Unit No:
			</td>
			<td style="width: 102px">
				<asp:TextBox ID="tbx_UnitNo" runat="server" Width="75px" />
				<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbx_UnitNo"
					ErrorMessage="*" Style="font-size: x-large"></asp:RequiredFieldValidator>
			</td>
			<td style="width: 90px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
				VIN:
			</td>
			<td style="width: 190px" colspan="3">
				<asp:TextBox ID="tbx_ChassisVIN" runat="server" />
				<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbx_ChassisVIN"
					ErrorMessage="*" Style="font-size: x-large"></asp:RequiredFieldValidator>
				<asp:CustomValidator ID="VINValidator" runat="server" ControlToValidate="tbx_ChassisVIN"
					OnServerValidate="UniqueVINValidator" ErrorMessage="This VIN is already in use by another Vehicle"></asp:CustomValidator>
			</td>
		</tr>
		<tr>
			<td style="width: 140px;" class="tdtable">
				License Plate State:
			</td>
			<!--10/02/2012 IR: Editing td width and valign-->
			<td valign="middle" width="175px">
				<!--10/02/2012 IR: Chaged Value from "0" to "" to enable validator to function properly-->
				<asp:DropDownList ID="ddl_LicensePlateState" runat="server" AppendDataBoundItems="True"
					DataSourceID="sds_ddl_Op_State" OnDataBinding="PreventErrorOnbinding" DataTextField="DisplayValue"
					DataValueField="RecordValue" CssClass="forest">
					<asp:ListItem Text="Select" Value="" />
				</asp:DropDownList>
				<asp:RequiredFieldValidator ID="LicensePlateStateValidator" runat="server" ControlToValidate="ddl_LicensePlateState"
					ErrorMessage="*" Style="font-size: x-large"></asp:RequiredFieldValidator>
			</td>
			<td style="width: 90px;" class="inputTitle">
				License No:
			</td>
			<td style="width: 102px">
				<asp:TextBox ID="tbx_LicensePlateNo" runat="server" Width="75px" />
				<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbx_LicensePlateNo"
					ErrorMessage="*" Style="font-size: x-large"></asp:RequiredFieldValidator>
			</td>
			<td style="width: 90px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
				GVW:
			</td>
			<td style="width: 190px">
				<asp:TextBox ID="tbx_GrossVehicleWeight" runat="server" />
			</td>
			<td style="width: 90px;" class="inputTitle">&nbsp;
				
			</td>
			<td>&nbsp;
				
			</td>
		</tr>
		<tr>
			<td colspan="6">
				<asp:CustomValidator ID="LicensePlateNoValidator" runat="server" ControlToValidate="tbx_LicensePlateNo"
					OnServerValidate="UniqueLicensePlateNoValidator" ErrorMessage="This License Plate is already registered to another Vehicle"></asp:CustomValidator>
			</td>
		</tr>
	</table>
	<br />
	<table style="width: 100%">
		<tr>
			<td style="width: 90px;" class="inputTitle">
				Annual Miles:
			</td>
			<td style="width: 67px">
				<asp:TextBox ID="tbx_AnnualMiles" runat="server" Width="60px" />
			</td>
			<td style="width: 150px" class="inputTitle">
				Equip. Type:
			</td>
			<td style="width: 140px">
				<asp:DropDownList ID="ddl_IDEquipmentType" runat="server" DataSourceID="sds_ddl_Op_EquipType"
					DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="True">
					<asp:ListItem Text="Select" Value="0" />
				</asp:DropDownList>
			</td>
			<td style="width: 165px;" class="inputTitle">
				Est. Replacement Cost:
			</td>
			<td>
				<asp:TextBox ID="tbx_EstReplacementCost" runat="server"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td style="width: 90px;" class="inputTitle">
				Annual Hours:
			</td>
			<td style="width: 67px">
				<asp:TextBox ID="tbx_AnnualHours" runat="server" Width="60px" />
			</td>
			<td style="width: 150px;" class="inputTitle">
				Equip. Category:
			</td>
			<td style="width: 140px">
				<asp:DropDownList ID="ddl_IDEquipmentCategory" runat="server" DataSourceID="sds_ddl_Op_EquipCat"
					DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="True">
					<asp:ListItem Text="Select" Value="0" />
				</asp:DropDownList>
			</td>
			<td style="width: 165px;" class="inputTitle">
				Make:
			</td>
			<td>
				<asp:DropDownList ID="ddl_ChassisMake" runat="server" DataSourceID="sds_ddl_Op_ChassisMake"
					DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="True">
					<asp:ListItem Text="Select" Value="0" />
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td style="width: 90px;" class="inputTitle">
				Actual Miles:
			</td>
			<td style="width: 67px">
				<asp:TextBox ID="tbx_ActualMiles" runat="server" Width="60px" />
			</td>
			<td style="width: 150px;" class="inputTitle">
				Vehicle Status:
			</td>
			<td style="width: 140px">
				<asp:DropDownList ID="ddl_IDVehicleStatus" runat="server" DataSourceID="sds_ddl_Op_VehStatus"
					DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="True">
					<asp:ListItem Text="Select" Value="0" />
				</asp:DropDownList>
			</td>
			<td style="width: 165px;" class="inputTitle">
				Model:
			</td>
			<td>
				<asp:TextBox ID="tbx_ChassisModel" runat="server"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td style="width: 90px;" class="inputTitle">
				Actual Hours:
			</td>
			<td style="width: 67px">
				<asp:TextBox ID="tbx_ActualHours" runat="server" Width="60px" />
			</td>
			<td style="width: 150px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
				CARB Group:
			</td>
			<td style="width: 140px">
				<asp:DropDownList ID="ddl_IDCARBGroup" runat="server" DataSourceID="sds_ddl_Op_CARBGroup"
					DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="True">
					<asp:ListItem Text="Select" Value="0" />
				</asp:DropDownList>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddl_IDCARBGroup"
					ErrorMessage="*" InitialValue="0" Style="font-size: x-large"></asp:RequiredFieldValidator>
			</td>
			<td style="width: 165px;" class="inputTitle">
				Model Year:
			</td>
			<td>
				<asp:DropDownList ID="ddl_ChassisModelYear" runat="server" DataSourceID="sds_ddl_Op_Year"
					DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="True">
					<asp:ListItem Text="Select" Value="0" />
				</asp:DropDownList>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddl_ChassisModelYear"
					ErrorMessage="*" InitialValue="0" Style="font-size: x-large"></asp:RequiredFieldValidator>
			</td>
		</tr>
	</table>
	<br />
	<table style="width: 100%">
		<tr>
			<td style="width: 180px;" class="inputTitle">
				<b>Planned Compliance Date:</b>&#160;
			</td>
			<td style="width: 155px">
				<telerik:raddatepicker id="rdp_PlannedComplianceDate" runat="server" culture="English (United States)">
                                            <calendar usecolumnheadersasselectors="False" 
                                            userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" 
                                            enabledstyle-horizontalalign="Center">
<EnabledStyle HorizontalAlign="Center"></EnabledStyle>
                                            </dateinput>
                                        </telerik:raddatepicker>
			</td>
			<td style="width: 170px;" class="inputTitle">
				Planed Retirement Date:
			</td>
			<td style="width: 155px">
				<telerik:raddatepicker id="rdp_PlannedRetirementDate" runat="server" culture="English (United States)">
                                            <calendar usecolumnheadersasselectors="False" 
                                            userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" 
                                            enabledstyle-horizontalalign="Center">
<EnabledStyle HorizontalAlign="Center"></EnabledStyle>
                                            </dateinput>
                                        </telerik:raddatepicker>
			</td>
			<td style="width: 140px;" class="inputTitle">
				&#160;<b>Backup Status Date:</b>
			</td>
			<td>
				<telerik:raddatepicker id="rdp_BackupStatusDate" runat="server" culture="English (United States)">
                                            <calendar usecolumnheadersasselectors="False" 
                                            userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" 
                                            enabledstyle-horizontalalign="Center">
<EnabledStyle HorizontalAlign="Center"></EnabledStyle>
                                            </dateinput>
                                        </telerik:raddatepicker>
			</td>
		</tr>
		<tr>
			<td style="width: 180px;" class="inputTitle">
				<b>Actual Compliance Date:</b>
			</td>
			<td style="width: 155px">
				<telerik:raddatepicker id="rdp_ActualComplianceDate" runat="server" culture="English (United States)">
                                            <calendar usecolumnheadersasselectors="False" 
                                            userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" 
                                            enabledstyle-horizontalalign="Center">
<EnabledStyle HorizontalAlign="Center"></EnabledStyle>
                                            </dateinput>
                                        </telerik:raddatepicker>
			</td>
			<td style="width: 170px;" class="inputTitle">
				Actual Retirement Date:
			</td>
			<td style="width: 155px">
				<telerik:raddatepicker id="rdp_ActualRetirementDate" runat="server" culture="English (United States)">
                                            <calendar usecolumnheadersasselectors="False" 
                                            userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" 
                                            enabledstyle-horizontalalign="Center">
<EnabledStyle HorizontalAlign="Center"></EnabledStyle>
                                            </dateinput>
                                        </telerik:raddatepicker>
			</td>
			<td style="width: 140px;" class="inputTitle">
				<b>Retire Status Date:</b>&#160;
			</td>
			<td>
				<telerik:raddatepicker id="rdp_RetireStatusDate" runat="server" culture="English (United States)">
                                            <calendar usecolumnheadersasselectors="False" 
                                            userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" 
                                            enabledstyle-horizontalalign="Center">
<EnabledStyle HorizontalAlign="Center"></EnabledStyle>
                                            </dateinput>
                                        </telerik:raddatepicker>
			</td>
		</tr>
		
		<tr>
		<td class="inputTitle">
			<strong>Last Opacity Test Date:</strong>&nbsp;
		</td>
		<td>
			<telerik:raddatepicker id="rdp_LastOpacityTestDate" runat="server" culture="English (United States)">
                                            <calendar usecolumnheadersasselectors="False" 
                                            userowheadersasselectors="False" viewselectortext="x">
                                            </calendar>
                                            <datepopupbutton hoverimageurl="" imageurl="" />
                                            <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" 
                                            enabledstyle-horizontalalign="Center">
<EnabledStyle HorizontalAlign="Center"></EnabledStyle>
                                            </dateinput>
                                        </telerik:raddatepicker>
		</td>
		
		
		
		</tr>
		
	</table>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Description</p>
	<table style="width: 800px">
		<tr>
			<td>
				<asp:TextBox ID="tbx_Description" runat="server" Height="65px" TextMode="MultiLine"
					Width="600px" />
			</td>
		</tr>
	</table>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Notes</p>
	<table style="width: 800px;">
		<tr>
			<td>
				<asp:TextBox ID="tbx_Notes" runat="server" Height="75px" TabIndex="19" TextMode="MultiLine"
					Width="600px"></asp:TextBox>
			</td>
		</tr>
	</table>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Internal Notes</p>
	<table style="width: 800px;">
		<tr>
			<td>
				<asp:TextBox ID="tbx_NotesCF" runat="server" Height="75px" TabIndex="19" TextMode="MultiLine"
					Width="600px"></asp:TextBox>
			</td>
		</tr>
	</table>
	<p>
		<asp:Button ID="btnInsert" runat="server" TabIndex="20" Text="Add Vehicle" />
	</p>
	<p>
		<asp:HiddenField ID="hf_IDProfileFleet" runat="server" />
		
		<asp:HiddenField ID="hf_fleetsRuleCode"  runat="server" />
		<asp:HiddenField ID="hf_onRoadRuleCode"  runat="server" />
		<asp:HiddenField ID="hf_lightRuleCode"  runat="server" />
		<asp:HiddenField ID="hf_heavyRuleCode"  runat="server" />
		
	</p>
	<asp:SqlDataSource ID="sds_ddl_Op_EquipType" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="EquipmentType" Name="OptionName" QueryStringField="OptionName"
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
	<asp:SqlDataSource ID="sds_ddl_Op_ChassisMake" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="ChassisMake" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_Year" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="Year" Name="OptionName" QueryStringField="OptionName"
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
</asp:Content>
