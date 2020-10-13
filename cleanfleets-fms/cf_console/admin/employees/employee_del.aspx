<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="employee_del.aspx.vb" Inherits="cleanfleets_fms.employee_del" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Delete Employee</p>
	<span style="color: #FF0000; font-size: small;">Please confirm the deletion of this
		employee.</span><p style="font-size: medium; font-weight: bold; color: #ED8701">
			<asp:FormView ID="FormView1" runat="server" DataKeyNames="UserID" DataSourceID="sds_Contact"
				Style="font-size: small; color: #000000" Width="500px">
				<EditItemTemplate>
				</EditItemTemplate>
				<InsertItemTemplate>
				</InsertItemTemplate>
				<ItemTemplate>
					<table cellpadding="2" cellspacing="0" style="width: 100%">
						<tr>
							<td style="text-align: right; color: #2C7500; font-size: small; width: 110px; font-weight: bold;">
								Emplyee ID:
							</td>
							<td>
								<asp:Label ID="lbl_IDProfileContact" runat="server" Font-Bold="False" Font-Size="Small"
									Text='<%# Eval("IDProfileContact") %>' />
							</td>
						</tr>
						<tr>
							<td style="text-align: right; color: #2C7500; font-size: small; width: 110px; font-weight: bold;">
								User Name:
							</td>
							<td>
								<asp:Label ID="lbl_UserName" runat="server" Font-Bold="False" Font-Size="Small" Text='<%# Bind("UserName") %>' />
							</td>
						</tr>
						<tr>
							<td style="text-align: right; color: #2C7500; font-size: small; width: 110px; font-weight: bold;">
								Last Name:
							</td>
							<td>
								<asp:Label ID="LastNameLabel" runat="server" Font-Bold="False" Font-Size="Small"
									Text='<%# Bind("LastName") %>' />
							</td>
						</tr>
						<tr>
							<td style="text-align: right; color: #2C7500; font-size: small; width: 110px; font-weight: bold;">
								First Name:
							</td>
							<td>
								<asp:Label ID="FirstNameLabel" runat="server" Font-Bold="False" Font-Size="Small"
									Text='<%# Bind("FirstName") %>' />
							</td>
						</tr>
					</table>
					<asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
						Text="Delete" OnClick="DeleteButton_Click" />
					<br />
					<br />
					<asp:HiddenField ID="hf_IDProfileAccount" runat="server" Value='<%# Bind("IDProfileAccount") %>' />
					<asp:Label ID="lbl_IDProfileAccount" runat="server" Font-Bold="False" Font-Size="XX-Small"
						Text='<%# Bind("IDProfileAccount") %>' ForeColor="White" />
				</ItemTemplate>
			</asp:FormView>
		</p>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		&nbsp;
	</p>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		&nbsp;
	</p>
	<asp:SqlDataSource ID="sds_Contact" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		DeleteCommand="DELETE FROM [aspnet_Users] WHERE [UserID] = @UserID" SelectCommand="SELECT [IDProfileContact], [IDProfileAccount], [UserID], [IDModifiedUser], [ModifiedDate], [IDPrefix], [IDPostfix], [IDTitle], [Title], [LastName], [FirstName], [UserName], [MI], [Title], [Address1], [Address2], [City], [State], [County], [Country], [Zip], [Telephone1], [Ext1], [Telephone2], [Ext2], [Telephone3], [Ext3], [CellPhone], [Fax1], [Fax2],[Notes], [NotesCF], [UserName], [Email], [PasswordQuestion] FROM [CFV_Profile_Employee] WHERE ([IDProfileContact] = @IDProfileContact)">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileContact" QueryStringField="IDProfileContact"
				Type="Int32" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="UserID" />
		</DeleteParameters>
	</asp:SqlDataSource>
</asp:Content>

