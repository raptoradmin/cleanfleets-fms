<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="engine_del.aspx.vb" Inherits="cleanfleets_fms.engine_del" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Delete Engine</p>
	<span style="color: #FF0000; font-size: small;">Please confirm the deletion of this
		engine.</span><p style="font-size: medium; font-weight: bold; color: #ED8701">
			<asp:FormView ID="fv_VehicleDelete" runat="server" DataKeyNames="IDEngines" DataSourceID="sds_Engines"
				Style="font-size: small; color: #000000" Width="500px">
				<EditItemTemplate>
					IDEngines:
					<asp:Label ID="IDEnginesLabel1" runat="server" Text='<%# Eval("IDEngines") %>' />
					<br />
					EngineManufacturer:
					<asp:TextBox ID="EngineManufacturerTextBox" runat="server" Text='<%# Bind("EngineManufacturer") %>' />
					<br />
					ModelYear:
					<asp:TextBox ID="ModelYearTextBox" runat="server" Text='<%# Bind("ModelYear") %>' />
					<br />
					SerialNum:
					<asp:TextBox ID="SerialNumTextBox" runat="server" Text='<%# Bind("SerialNum") %>' />
					<br />
					<asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
						Text="Update" />
					&nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False"
						CommandName="Cancel" Text="Cancel" />
				</EditItemTemplate>
				<InsertItemTemplate>
					EngineManufacturer:
					<asp:TextBox ID="EngineManufacturerTextBox" runat="server" Text='<%# Bind("EngineManufacturer") %>' />
					<br />
					ModelYear:
					<asp:TextBox ID="ModelYearTextBox" runat="server" Text='<%# Bind("ModelYear") %>' />
					<br />
					SerialNum:
					<asp:TextBox ID="SerialNumTextBox" runat="server" Text='<%# Bind("SerialNum") %>' />
					<br />
					<asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
						Text="Insert" />
					&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False"
						CommandName="Cancel" Text="Cancel" />
				</InsertItemTemplate>
				<ItemTemplate>
					IDEngines:
					<asp:Label ID="IDEnginesLabel" runat="server" Text='<%# Eval("IDEngines") %>' />
					<br />
					EngineManufacturer:
					<asp:Label ID="EngineManufacturerLabel" runat="server" Text='<%# Bind("EngineManufacturer") %>' />
					<br />
					ModelYear:
					<asp:Label ID="ModelYearLabel" runat="server" Text='<%# Bind("ModelYear") %>' />
					<br />
					SerialNum:
					<asp:Label ID="SerialNumLabel" runat="server" Text='<%# Bind("SerialNum") %>' />
					<br />
					<br />
					<asp:Button ID="btn_Delete" runat="server" OnClick="Button1_Click" Text="Button" />
					<br />
				</ItemTemplate>
			</asp:FormView>
		</p>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		&nbsp;
	</p>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		&nbsp;
	</p>
	<asp:SqlDataSource ID="sds_Engines" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDEngines], [EngineManufacturer], [ModelYear], [SerialNum] FROM [CFV_Engines] WHERE ([IDEngines] = @IDEngines)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDEngines" QueryStringField="IDEngines" Type="Int32" />
		</SelectParameters>
		<DeleteParameters>
		</DeleteParameters>
		<UpdateParameters>
		</UpdateParameters>
		<InsertParameters>
		</InsertParameters>
	</asp:SqlDataSource>
</asp:Content>

