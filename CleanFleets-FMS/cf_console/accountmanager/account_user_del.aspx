<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="account_user_del.aspx.vb" Inherits="cleanfleets_fms.account_user_del" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Delete User</p>
	<span style="color: #FF0000; font-size: small;">Please confirm the deletion of this
		user.</span><p style="font-size: medium; font-weight: bold; color: #ED8701">
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
					<br />
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
	<asp:SqlDataSource ID="sds_CF_Menu_Console" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [DataFieldID], [DataFieldParentID], [DataTextField], [DataNavigateUrlField], [ImageURL] FROM [CF_Menu_Console]">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Contact" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		DeleteCommand="DELETE FROM [aspnet_Users] WHERE [UserID] = @UserID" InsertCommand="INSERT INTO [CF_Profile_Contact] ([UserID], [IDModifiedUser], [ModifiedDate], [LastName], [FirstName], [IDProfileAccount]) VALUES (@UserID, @IDModifiedUser, @ModifiedDate, @LastName, @FirstName, @IDProfileAccount)"
		SelectCommand="SELECT [UserID], [UserName], [IDModifiedUser], [ModifiedDate], [LastName], [FirstName], [IDProfileContact], [IDProfileAccount] FROM [CFV_Profile_Contact] WHERE ([IDProfileContact] = @IDProfileContact)"
		UpdateCommand="UPDATE [CF_Profile_Contact] SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate, [LastName] = @LastName, [FirstName] = @FirstName, [IDProfileContact] = @IDProfileContact, [IDProfileAccount] = @IDProfileAccount WHERE [UserID] = @UserID">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileContact" QueryStringField="IDProfileContact"
				Type="Int32" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="UserID" Type="Object" />
		</DeleteParameters>
		<UpdateParameters>
		</UpdateParameters>
		<InsertParameters>
		</InsertParameters>
	</asp:SqlDataSource>
</asp:Content>

