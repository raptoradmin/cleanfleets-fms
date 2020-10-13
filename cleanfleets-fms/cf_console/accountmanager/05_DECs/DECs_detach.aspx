<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="DECs_detach.aspx.vb" Inherits="cleanfleets_fms.DECs_detach1" %>

<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Detatch <span style="color: #ED8701; font-size: medium; font-weight: bold">Diesel Engine
			Emissions Control System</span></p>
	<span style="color: #FF0000; font-size: small;">Please confirm the detachment of this
		DECs.</span><p>
			<asp:FormView ID="fv_Detach_Engine" runat="server" DataKeyNames="IDDECS" DataSourceID="sds_CFV_DECS"
				DefaultMode="Edit">
				<EditItemTemplate>
					<table cellpadding="0" cellspacing="0" style="width: 100%">
						<tr>
							<td style="padding: 3px; font-family: Arial, Helvetica, sans-serif; font-weight: bold;
								color: #2C7500; text-align: right; width: 121px;">
								Serial Num:
							</td>
							<td style="padding: 3px">
								<asp:TextBox ID="SerialNoTextBox" runat="server" Text='<%# Bind("SerialNo") %>' ReadOnly="True" />
							</td>
						</tr>
						<tr>
							<td style="padding: 3px; font-family: Arial, Helvetica, sans-serif; font-weight: bold;
								color: #2C7500; text-align: right; width: 121px;">
								DECs Name:
							</td>
							<td style="padding: 3px">
								<asp:TextBox ID="DECSNameTextBox" runat="server" Text='<%# Bind("DECSName") %>' ReadOnly="True" />
							</td>
						</tr>
						<tr>
							<td style="padding: 3px; font-family: Arial, Helvetica, sans-serif; font-weight: bold;
								color: #2C7500; text-align: right; width: 121px;">
								Model Num:
							</td>
							<td style="padding: 3px">
								<asp:TextBox ID="DECSModelNoTextBox" runat="server" Text='<%# Bind("DECSModelNo") %>'
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
			</asp:FormView>
		</p>
	<p>
	</p>
	<asp:SqlDataSource ID="sds_CFV_DECS" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDDECS], [IDEngines], [SerialNo], [DECSName], [DECSModelNo] FROM [CF_DECS] WHERE ([IDDECS] = @IDDECS)"
		UpdateCommand="UPDATE [CF_DECs] SET [IDEngines] = @IDEngines WHERE [IDDECS] = @IDDECS">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDDECS" QueryStringField="IDDECS" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="IDEngines" />
		</UpdateParameters>
		<InsertParameters>
		</InsertParameters>
	</asp:SqlDataSource>
</asp:Content>

