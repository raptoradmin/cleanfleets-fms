<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="enginesadd.aspx.vb" Inherits="cleanfleets_fms.enginesadd" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Add Engine</p>
	<table style="width: 800px;">
		<tr>
			<td style="font-size: small; font-weight: bold; text-align: right; width: 125px;
				color: #2C7500">
				Vehicle VIN:
			</td>
			<td>
				<p>
					<asp:Label ID="lbl_VehicleVIN" runat="server" Text='<%# Bind("FleetName") %>'></asp:Label>
				</p>
			</td>
		</tr>
	</table>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Engine Details</p>
	<table style="width: 800px">
		<tr>
			<td style="width: 90px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
				Serial No:
			</td>
			<td style="width: 173px">
				<asp:TextBox ID="tbx_SerialNum" runat="server" Width="150px" />
				<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="tbx_SerialNum"
					ErrorMessage="*" Style="font-size: x-large"></asp:RequiredFieldValidator>
				<asp:CustomValidator ID="SerialNumValidator" runat="server" ControlToValidate="tbx_SerialNum"
					OnServerValidate="UniqueEngineSerialNumValidator" ErrorMessage="This Serial Number is already in use by another Engine"></asp:CustomValidator>
			</td>
			<td style="width: 88px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
				Model:
			</td>
			<td>
				<asp:TextBox ID="tbx_EngineModel" runat="server" Width="100px" />
				<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*"
					Style="font-size: x-large" ControlToValidate="tbx_EngineModel"></asp:RequiredFieldValidator>
			</td>
			<td style="width: 125px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
				Horsepower:
			</td>
			<td>
				<asp:TextBox ID="tbx_Horsepower" runat="server" Width="60px" />
			</td>
		</tr>
		<tr>
			<td style="width: 90px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
				Manufacturer:
			</td>
			<td style="width: 173px">
				<asp:DropDownList ID="ddl_IDEngineManufacturer" runat="server" DataSourceID="sds_ddl_Op_EngineManufacturer"
					DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="True">
					<asp:ListItem Text="Select" Value="0" />
				</asp:DropDownList>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddl_IDEngineManufacturer"
					ErrorMessage="*" InitialValue="0" Style="font-size: x-large"></asp:RequiredFieldValidator>
			</td>
			<td style="width: 88px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
				Model Year:
			</td>
			<td>
				<asp:DropDownList ID="ddl_ModelYear" runat="server" DataSourceID="sds_ddl_Op_Year"
					DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="True">
					<asp:ListItem Text="Select" Value="0" />
				</asp:DropDownList>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="ddl_ModelYear"
					ErrorMessage="*" InitialValue="0" Style="font-size: x-large"></asp:RequiredFieldValidator>
			</td>
			<td style="width: 125px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
				Displacement:
			</td>
			<td>
				<asp:TextBox ID="tbx_Displacement" runat="server" Width="60px" />
			</td>
		</tr>
		<tr>
			<td style="width: 90px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
				Family Name:
				<td style="width: 173px">
					<asp:TextBox ID="tbx_FamilyName" runat="server" Width="150px" />
					<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="tbx_FamilyName"
						ErrorMessage="*" Style="font-size: x-large"></asp:RequiredFieldValidator>
				</td>
				<td style="width: 88px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
					Status:
				</td>
				<td>
					<asp:DropDownList ID="ddl_IDEngineStatus" runat="server" DataSourceID="sds_ddl_Op_EngineStatus"
						DataTextField="DisplayValue" DataValueField="IDOptionList" Height="16px" AppendDataBoundItems="True">
						<asp:ListItem Text="Select" Value="0" />
					</asp:DropDownList>
				</td>
				<td style="width: 125px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
					Est. Retrofit Cost:
				</td>
				<td>
					<asp:TextBox ID="tbx_EstRetrofitCost" runat="server" Width="60px" />
				</td>
		</tr>
		<tr>
			<td style="width: 90px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
				Fuel Type:
				<td style="width: 173px">
					<asp:DropDownList ID="ddl_IDEngineFuelType" runat="server" DataSourceID="sds_ddl_Op_EngineFuelType"
						DataTextField="DisplayValue" DataValueField="IDOptionList" AppendDataBoundItems="True">
						<asp:ListItem Text="Select" Value="0" />
					</asp:DropDownList>
				</td>
				<td style="width: 88px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td style="width: 125px; text-align: right; font-weight: bold; color: #2C7500; font-size: small;">
					&nbsp;
				</td>
				<td>
					&nbsp;
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
		<asp:Button ID="btnInsert" runat="server" TabIndex="20" Text="Add Engine" />
	</p>
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
	<asp:SqlDataSource ID="sds_ddl_Op_Year" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="Year" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>
