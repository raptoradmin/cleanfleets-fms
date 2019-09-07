<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="engine_detach.aspx.vb" Inherits="cleanfleets_fms.engine_detach" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Detatch Engine</p>
	<span style="color: #FF0000; font-size: small;">Please confirm the detachment of this
		engine.</span><p>
			<asp:FormView ID="fv_Detach_Engine" runat="server" DataKeyNames="IDEngines" DataSourceID="sds_CFV_Engines"
				DefaultMode="Edit">
				<EditItemTemplate>
					<table cellpadding="0" cellspacing="0" style="width: 100%">
						<tr>
							<td style="padding: 3px; font-family: Arial, Helvetica, sans-serif; font-weight: bold;
								color: #2C7500; text-align: right; width: 121px;">
								Account:
							</td>
							<td style="padding: 3px">
								<asp:TextBox ID="tbx_AccountName" runat="server" Text='<%# Bind("AccountName") %>'
									ReadOnly="True" />
						</tr>
						<tr>
							<td style="padding: 3px; font-family: Arial, Helvetica, sans-serif; font-weight: bold;
								color: #2C7500; text-align: right; width: 121px;">
								Serial Num:
							</td>
							<td style="padding: 3px">
								<asp:TextBox ID="SerialNumTextBox" runat="server" Text='<%# Bind("SerialNum") %>'
									ReadOnly="True" />
							</td>
						</tr>
						<tr>
							<td style="padding: 3px; font-family: Arial, Helvetica, sans-serif; font-weight: bold;
								color: #2C7500; text-align: right; width: 121px;">
								Family Name:
							</td>
							<td style="padding: 3px">
								<asp:TextBox ID="FamilyNameTextBox" runat="server" Text='<%# Bind("FamilyName") %>'
									ReadOnly="True" />
							</td>
						</tr>
					</table>
					<br />
					<asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
						Text="Detach" />
					&nbsp;
				</EditItemTemplate>
				<InsertItemTemplate>
				</InsertItemTemplate>
				<ItemTemplate>
				</ItemTemplate>
			</asp:FormView>
		</p>
	<p>
	</p>
	<p>
	</p>
	<asp:SqlDataSource ID="sds_CFV_Engines" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDEngines], [AccountName], [IDVehicles], [SerialNum], [FamilyName] FROM [CFV_Engines] WHERE ([IDEngines] = @IDEngines)"
		UpdateCommand="UPDATE [CF_Engines] SET [IDVehicles] = @IDVehicles WHERE [IDEngines] = @IDEngines">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDEngines" QueryStringField="IDEngines" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDEngines" />
		</DeleteParameters>
		<UpdateParameters>
			<asp:Parameter Name="IDVehicles" />
		</UpdateParameters>
		<InsertParameters>
		</InsertParameters>
	</asp:SqlDataSource>
</asp:Content>

