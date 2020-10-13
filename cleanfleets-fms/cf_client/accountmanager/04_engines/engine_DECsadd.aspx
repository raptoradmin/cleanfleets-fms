<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="engine_DECsadd.aspx.vb" Inherits="cleanfleets_fms.engine_DECsadd" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Add Diesel Emissions Control System</p>
	<table style="width: 800px;">
		<tr>
			<td style="width: 115px;" class="tdtable">
				Engine Serial No:
			</td>
			<td>
				<p>
					<asp:Label ID="lbl_EngineSerialNo" runat="server" Text='<%# Bind("FleetName") %>'></asp:Label>
				</p>
			</td>
		</tr>
	</table>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		DECS Details</p>
	<table>
		<tr>
			<td class="tdtable">
				DECS Name:
			</td>
			<td style="width: 365px">
				<asp:TextBox ID="tbx_DECSName" runat="server" Width="150px" />
			</td>
		</tr>
		<tr>
			<td class="tdtable">
				DECS Manufacturer:
			</td>
			<td style="width: 365px">
				<asp:DropDownList ID="ddl_IDDECSManufacturer" runat="server" DataSourceID="sds_ddl_Op_DECSManufacturer"
					DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="True">
					<asp:ListItem Text="Select" Value="0" />
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td class="tdtable">
				DECS Level:
			</td>
			<td style="width: 365px">
				<asp:DropDownList ID="ddl_IDDECSLevel" runat="server" DataSourceID="sds_ddl_Op_DECSLevel"
					DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="True">
					<asp:ListItem Text="Select" Value="0" />
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td class="tdtable">
				DECS Model No:
			</td>
			<td style="width: 365px">
				<asp:TextBox ID="tbx_DECSModelNo" runat="server" Width="100px" />
			</td>
		</tr>
		<tr>
			<td class="tdtable">
				Install Date:
			</td>
			<td style="width: 365px">
				<telerik:raddatepicker id="rdp_DECSInstallationDate" runat="server" culture="English (United States)"
					selecteddate="2000-01-01">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>

<DateInput DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" SelectedDate="2000-01-01"></DateInput>
                                        </telerik:raddatepicker>
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
		<asp:Button ID="btnInsert" runat="server" TabIndex="20" Text="Add DECS" />
	</p>
	<asp:SqlDataSource ID="sds_ddl_Op_DECSLevel" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="DECSLevel" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_DECSManufacturer" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="DECSManufacturer" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>

