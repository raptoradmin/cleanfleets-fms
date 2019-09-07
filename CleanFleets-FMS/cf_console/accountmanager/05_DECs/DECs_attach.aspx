<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="DECs_attach.aspx.vb" Inherits="cleanfleets_fms.DECs_attach1" %>

<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Attatch DECs</p>
	<p>
		<asp:FormView ID="FormView1" runat="server" DataKeyNames="IDEngines" DataSourceID="sds_Engines"
			Width="400px">
			<EditItemTemplate>
				IDEngines:
				<asp:Label ID="IDEnginesLabel1" runat="server" Text='<%# Eval("IDEngines") %>' />
				<br />
				IDProfileAccount:
				<asp:TextBox ID="IDProfileAccountTextBox" runat="server" Text='<%# Bind("IDProfileAccount") %>' />
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
				IDProfileAccount:
				<asp:TextBox ID="IDProfileAccountTextBox" runat="server" Text='<%# Bind("IDProfileAccount") %>' />
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
				IDProfileAccount:
				<asp:Label ID="IDProfileAccountLabel" runat="server" Text='<%# Bind("IDProfileAccount") %>' />
				<br />
				SerialNum:
				<asp:Label ID="SerialNumLabel" runat="server" Text='<%# Bind("SerialNum") %>' />
				<br />
			</ItemTemplate>
		</asp:FormView>
	</p>
	<p>
		<asp:DropDownList ID="ddl_IDDECs" runat="server" DataSourceID="sds_DECs" DataTextField="SerialNo"
			DataValueField="IDDECS">
		</asp:DropDownList>
	</p>
	<p>
		<asp:Button ID="btn_Attach" runat="server" Text="Attach DECs" />
	</p>
	<p>
		&nbsp;
	</p>
	<asp:SqlDataSource ID="sds_Engines" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDEngines], [IDProfileAccount], [SerialNum] FROM [CF_Engines] WHERE ([IDEngines] = @IDEngines)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDEngines" QueryStringField="IDEngines" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_DECs" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDDECS], [SerialNo], [IDProfileAccount] FROM [CF_DECS] WHERE ([IDProfileAccount] = @IDProfileAccount AND IDEngines IS NULL) ORDER BY [SerialNo]">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>

