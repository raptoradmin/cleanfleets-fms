<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="employee_details.aspx.vb" Inherits="cleanfleets_fms.employee_details" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<asp:FormView ID="FormView1" runat="server" DataKeyNames="IDProfileContact,UserID"
		DataSourceID="sdsfvEmployeeDetails" HorizontalAlign="Left" Width="800px">
		<EditItemTemplate>
			<%-- MG 12/6/2011 - there appears to be a bug somewhere preventing me from using UserID with the formview.DataKeyNames --%>
			<span style="font-weight: bold; font-size: medium; color: #ED8701">Employee</span><br />
			<br />
			<table width="100%">
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						Last Name:&nbsp;
					</td>
					<td>
						<asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' />
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						First Name:
					</td>
					<td>
						<asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' />
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						MI:
					</td>
					<td>
						<asp:TextBox ID="MITextBox" runat="server" Text='<%# Bind("MI") %>' />
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						Title:
					</td>
					<td>
						<asp:DropDownList ID="DropDownListTitle" runat="server" DataSourceID="sdsddTitle"
							DataTextField="DisplayValue" DataValueField="IDOptionList" SelectedValue='<%# Bind("IDTitle") %>'
							AppendDataBoundItems="True">
							<asp:ListItem Text="Select" Value="0" />
						</asp:DropDownList>
					</td>
				</tr>
			</table>
			<br />
			<span style="font-weight: bold; font-size: medium; color: #ED8701">Details</span><br />
			<br />
			<table width="100%">
				<tr>
					<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
						Address:
					</td>
					<td style="width: 275px">
						<asp:TextBox ID="Address1TextBox" runat="server" Text='<%# Bind("Address1") %>' Width="200px" />
					</td>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						overflow: 150">
						Telephone:
					</td>
					<td style="width: 275px">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<asp:TextBox ID="Telephone1TextBox" runat="server" Text='<%# Bind("Telephone1") %>' />
								</td>
								<td style="width: 40px; font-weight: bold; font-size: small; color: #2C7500; text-align: right;">
									Ext:
								</td>
								<td style="padding-left: 2px">
									<asp:TextBox ID="Ext1TextBox" runat="server" Text='<%# Bind("Ext1") %>' Width="50px" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
						Address:
					</td>
					<td style="width: 275px">
						<asp:TextBox ID="Address2TextBox" runat="server" Text='<%# Bind("Address2") %>' Width="200px" />
					</td>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						overflow: 150">
						Telephone:
					</td>
					<td style="width: 275px">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<asp:TextBox ID="Telephone2TextBox" runat="server" Text='<%# Bind("Telephone2") %>' />
								</td>
								<td style="width: 40px; font-weight: bold; font-size: small; color: #2C7500; text-align: right;">
									Ext:
								</td>
								<td style="padding-left: 2px">
									<asp:TextBox ID="Ext2TextBox" runat="server" Text='<%# Bind("Ext2") %>' Width="50px" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
						City:
					</td>
					<td style="width: 275px">
						<asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' />
					</td>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						overflow: 150">
						Telephone:
					</td>
					<td style="width: 275px">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<asp:TextBox ID="Telephone3TextBox" runat="server" Text='<%# Bind("Telephone3") %>' />
								</td>
								<td style="width: 40px; font-weight: bold; font-size: small; color: #2C7500; text-align: right;">
									Ext:
								</td>
								<td style="padding-left: 2px">
									<asp:TextBox ID="Ext3TextBox" runat="server" Text='<%# Bind("Ext3") %>' Width="50px" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
						State:
					</td>
					<td style="width: 275px">
						<asp:TextBox ID="StateTextBox" runat="server" Text='<%# Bind("State") %>' />
					</td>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						overflow: 150">
						Cell Phone:
					</td>
					<td style="width: 275px">
						<asp:TextBox ID="CellPhoneTextBox" runat="server" Text='<%# Bind("CellPhone") %>' />
					</td>
				</tr>
				<tr>
					<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
						Zip:
					</td>
					<td style="width: 275px">
						<asp:TextBox ID="ZipTextBox" runat="server" Text='<%# Bind("Zip") %>' />
					</td>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						overflow: 150">
						Fax:
					</td>
					<td style="width: 275px">
						<asp:TextBox ID="Fax1TextBox" runat="server" Text='<%# Bind("Fax1") %>' />
					</td>
				</tr>
				<tr>
					<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">&nbsp;
						
					</td>
					<td style="width: 275px">&nbsp;
						
					</td>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						overflow: 150">
						Email:
					</td>
					<td style="width: 275px">
						<asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' Width="250px" />
					</td>
				</tr>
			</table>
			<br />
			<b><span style="font-weight: bold; font-size: medium; color: #ED8701">Notes</span></b><br />
			<br />
			<table width="100%">
				<tr>
					<td style="width: 75px">&nbsp;
						
					</td>
					<td>
						<asp:TextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes") %>' Height="100px"
							Width="650px" TextMode="MultiLine" />
					</td>
				</tr>
			</table>
			<br />
			<b><span style="font-weight: bold; font-size: medium; color: #ED8701">Internal Notes</span></b><br />
			<br />
			<table width="100%">
				<tr>
					<td style="width: 75px">&nbsp;
						
					</td>
					<td>
						<asp:TextBox ID="NotesCFTextBox" runat="server" Text='<%# Bind("NotesCF") %>' Height="100px"
							Width="650px" TextMode="MultiLine" />
					</td>
				</tr>
			</table>
			<br />
			<b><span style="font-weight: bold; font-size: medium; color: #ED8701">Internal Notes</span></b><br />
			<br />
			<table width="100%">
				<tr>
					<td style="width: 75px">&nbsp;
						
					</td>
					<td>
						<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("NotesCF") %>' Height="100px"
							Width="650px" TextMode="MultiLine" />
					</td>
				</tr>
			</table>
			<br />
			<b><span style="font-weight: bold; font-size: medium; color: #ED8701">IMAP Configuration</span></b><br />
			<br />
			<table width="100%">
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						Username:
					</td>
					<td>
						<asp:TextBox ID="ImapUsernameTextBox" runat="server" Text='<%# Bind("IMAPUsername") %>' Enabled='<%#  UserID.ToUpper() = Eval("UserID").ToString().ToUpper() %>'></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						Password:
					</td>
					<td>
						<asp:TextBox ID="ImapPasswordTextBox" runat="server" TextMode="Password" Text='<%# Bind("IMAPPassword") %>' Enabled='<%# UserID.ToUpper() = Eval("UserID").ToString().ToUpper() %>'></asp:TextBox>

					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						Drafts Folder:
					</td>
					<td>
						<asp:TextBox ID="ImapDraftsFolderTextBox" runat="server" Text='<%# Bind("IMAPDraftsFolder") %>' Enabled='<%# UserID.ToUpper().ToUpper() = Eval("UserID").ToString().ToUpper() %>'></asp:TextBox>
					</td>
				</tr>
			</table>
			<br />
			<asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
				Text="Update" />
			&nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False"
				CommandName="Cancel" Text="Cancel" />
			<asp:HiddenField ID="UserID" Value='<%# Bind("UserID") %>' runat="server" />
		</EditItemTemplate>
		<ItemTemplate>
			<span style="font-weight: bold; font-size: medium; color: #ED8701">Employee</span><br />
			<br />
			<table width="100%">
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						Last Name:
					</td>
					<td>
						<asp:Label ID="LastNameLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("LastName") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						First Name:
					</td>
					<td>
						<asp:Label ID="FirstNameLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("FirstName") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						MI:
					</td>
					<td>
						<asp:Label ID="MILabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("MI") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						Title:
					</td>
					<td>
						<asp:Label ID="TitleLabel0" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("Title") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						User Name:
					</td>
					<td>
						<asp:Label ID="lbl_UserName" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small; color: #F18700;" Text='<%# Bind("UserName") %>'></asp:Label>
					</td>
				</tr>
			</table>
			<br />
			<span style="font-weight: bold; font-size: medium; color: #ED8701">Details</span><br />
			<br />
			<table width="100%">
				<tr>
					<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
						Address:
					</td>
					<td style="width: 275px">
						<asp:Label ID="Address1Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("Address1") %>'></asp:Label>
					</td>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 128px;">
						Telephone:
					</td>
					<td style="width: 275px">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<asp:Label ID="Telephone1Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Bind("Telephone1") %>'></asp:Label>
								</td>
								<td style="color: #2C7500; width: 40px; font-size: small; font-weight: bold; text-align: right;">
									Ext:
								</td>
								<td style="padding-left: 2px">
									<asp:Label ID="Ext1Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Bind("Ext1") %>'></asp:Label>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
						Address:
					</td>
					<td style="width: 275px">
						<asp:Label ID="Address2Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("Address2") %>'></asp:Label>
					</td>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 128px;">
						Telephone:
					</td>
					<td style="width: 275px">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<asp:Label ID="Telephone2Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Bind("Telephone2") %>'></asp:Label>
								</td>
								<td style="width: 40px; color: #2C7500; font-size: small; font-weight: bold; text-align: right;">
									<span style="color: #2C7500; font-size: small; font-weight: bold; width: 40px; text-align: right;">
										Ext:</span>
								</td>
								<td style="padding-left: 2px">
									<asp:Label ID="Ext2Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Bind("Ext2") %>'></asp:Label>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
						City:
					</td>
					<td style="width: 275px">
						<asp:Label ID="CityLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("City") %>'></asp:Label>
					</td>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 128px;">
						Telephone:
					</td>
					<td style="width: 275px">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<asp:Label ID="Telephone3Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Bind("Telephone3") %>'></asp:Label>
								</td>
								<td style="width: 40px; color: #2C7500; font-size: small; font-weight: bold; text-align: right;">
									<span style="color: #2C7500; font-size: small; font-weight: 700">Ext:</span>
								</td>
								<td style="padding-left: 2px">
									<asp:Label ID="Ext3Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Bind("Ext3") %>'></asp:Label>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
						State:
					</td>
					<td style="width: 275px">
						<asp:Label ID="StateLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("State") %>'></asp:Label>
					</td>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 128px;">
						Cell Phone:
					</td>
					<td style="width: 275px">
						<asp:Label ID="CellPhoneLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("CellPhone") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
						Zip:
					</td>
					<td style="width: 275px">
						<asp:Label ID="ZipLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("Zip") %>'></asp:Label>
					</td>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 128px;">
						Fax:
					</td>
					<td style="width: 275px">
						<asp:Label ID="Fax1Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("Fax1") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">&nbsp;
						
					</td>
					<td style="width: 275px">&nbsp;
						
					</td>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 128px;">
						Email:
					</td>
					<td style="width: 275px">
						<asp:Label ID="EmailLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("Email") %>'></asp:Label>
					</td>
				</tr>
			</table>
			<br />
			<b><span style="font-weight: bold; font-size: medium; color: #ED8701">Notes</span></b><br />
			<br />
			<table width="100%">
				<tr>
					<td width="25px">&nbsp;
						
					</td>
					<td>
						<asp:Label ID="NotesLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("Notes") %>' />
					</td>
				</tr>
			</table>
			<br />
			<b><span style="font-weight: bold; font-size: medium; color: #ED8701">Internal Notes</span></b><br />
			<br />
			<table width="100%">
				<tr>
					<td width="25px">&nbsp;
						
					</td>
					<td>
						<asp:Label ID="NotesCFLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("NotesCF") %>' />
					</td>
				</tr>
			</table>
			<br />
			<b><span style="font-weight: bold; font-size: medium; color: #ED8701">IMAP Configuration</span></b><br />
			<br />
			<table width="100%">
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						Username:
					</td>
					<td>
						<asp:Label ID="ImapUsernameLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("IMAPUsername") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						Password:
					</td>
					<td>
						<asp:Label ID="ImapPasswordLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='******'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 100px">
						Drafts Folder:
					</td>
					<td>
						<asp:Label ID="ImapDraftsFolderLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("IMAPDraftsFolder") %>'></asp:Label>
					</td>
				</tr>
			</table>
			<br style="font-family: Arial, Helvetica, sans-serif; font-size: small" />
			<asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
				Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="Edit" />
			&nbsp;<asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
				OnClientClick="return confirm('Are you certain you want to delete this Employee?')"
				Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="Delete" />
			&nbsp;<asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
				Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="New"
				Visible="False" />
			<asp:HiddenField ID="UserID" Value='<%# Bind("UserID") %>' runat="server" />
		</ItemTemplate>
	</asp:FormView>
	<br />
	<asp:SqlDataSource ID="sds_CF_Menu_Console" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [DataFieldID], [DataFieldParentID], [DataTextField], [DataNavigateUrlField], [ImageURL] FROM [CF_Menu_Console]">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sdsfvEmployeeDetails" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		DeleteCommand="DELETE FROM [CF_Profile_Contact] WHERE [UserID] = @UserID"
		SelectCommand="SELECT [IDProfileContact], [UserID], [IDModifiedUser], [ModifiedDate], [IDPrefix], [IDPostfix], [IDTitle], [Title], [LastName], [FirstName], [UserName], [MI], [Title], [Address1], [Address2], [City], [State], [County], [Country], [Zip], [Telephone1], [Ext1], [Telephone2], [Ext2], [Telephone3], [Ext3], [CellPhone], [Fax1], [Fax2],[Notes], [NotesCF], [UserName], [Email], [PasswordQuestion], CASE WHEN UPPER(@IDModifiedUser) = UPPER(UserID) THEN [IMAPUsername] ELSE '' END [IMAPUsername], CASE WHEN UPPER(@IDModifiedUser) = UPPER(UserID) THEN [IMAPPassword] ELSE '' END [IMAPPassword], CASE WHEN UPPER(@IDModifiedUser) = UPPER(UserID) THEN [IMAPDraftsFolder] ELSE '' END [IMAPDraftsFolder] FROM [CFV_Profile_Employee] WHERE ([IDProfileContact] = @IDProfileContact)"
		UpdateCommand="UPDATE [CF_Profile_Contact] SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate, [IDPrefix] = @IDPrefix, [IDPostfix] = @IDPostfix, [IDTitle] = @IDTitle, [LastName] = @LastName, [FirstName] = @FirstName, [MI] = @MI, [Title] = @Title, [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [State] = @State, [County] = @County, [Country] = @Country, [Zip] = @Zip, [MailMergeCode] = @MailMergeCode, [Telephone1] = @Telephone1, [Ext1] = @Ext1, [Telephone2] = @Telephone2, [Ext2] = @Ext2, [Telephone3] = @Telephone3, [Ext3] = @Ext3, [CellPhone] = @CellPhone, [Fax1] = @Fax1, [Fax2] = @Fax2, [EMailMergeCode] = @EMailMergeCode, [WebSite] = @WebSite, [Notes] = @Notes, [NotesCF] = @NotesCF, [IMAPUsername] = CASE WHEN UPPER(@IDModifiedUser) = UPPER(UserID) THEN @IMAPUsername ELSE [IMAPUsername] END, [IMAPPassword] = CASE WHEN UPPER(@IDModifiedUser) = UPPER(UserID) THEN @IMAPPassword ELSE [IMAPPassword] END, [IMAPDraftsFolder] = CASE WHEN UPPER(@IDModifiedUser) = UPPER(UserID) THEN @IMAPDraftsFolder ELSE [IMAPDraftsFolder] END WHERE [IDProfileContact] = @IDProfileContact; UPDATE aspnet_Membership SET [Email] = @Email, [PasswordQuestion] = @PasswordQuestion WHERE UserId = @UserID">
		<SelectParameters>
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:QueryStringParameter Name="IDProfileContact" QueryStringField="IDProfileContact"
				Type="Int32" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="UserID" Type="Object" />
		</DeleteParameters>
		<UpdateParameters>
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:Parameter Name="ModifiedDate" Type="DateTime" />
			<asp:Parameter Name="IDPrefix" Type="Int32" />
			<asp:Parameter Name="IDPostfix" Type="Int32" />
			<asp:Parameter Name="IDTitle" Type="Int32" />
			<asp:Parameter Name="LastName" Type="String" />
			<asp:Parameter Name="FirstName" Type="String" />
			<asp:Parameter Name="MI" Type="String" />
			<asp:Parameter Name="Title" Type="String" />
			<asp:Parameter Name="Address1" Type="String" />
			<asp:Parameter Name="Address2" Type="String" />
			<asp:Parameter Name="City" Type="String" />
			<asp:Parameter Name="State" Type="String" />
			<asp:Parameter Name="County" Type="String" />
			<asp:Parameter Name="Country" Type="String" />
			<asp:Parameter Name="Zip" Type="String" />
			<asp:Parameter Name="MailMergeCode" Type="String" />
			<asp:Parameter Name="Telephone1" Type="String" />
			<asp:Parameter Name="Ext1" Type="String" />
			<asp:Parameter Name="Telephone2" Type="String" />
			<asp:Parameter Name="Ext2" Type="String" />
			<asp:Parameter Name="Telephone3" Type="String" />
			<asp:Parameter Name="Ext3" Type="String" />
			<asp:Parameter Name="CellPhone" Type="String" />
			<asp:Parameter Name="Fax1" Type="String" />
			<asp:Parameter Name="Fax2" Type="String" />
			<asp:Parameter Name="EMailMergeCode" Type="String" />
			<asp:Parameter Name="WebSite" Type="String" />
			<asp:Parameter Name="Notes" Type="String" />
			<asp:Parameter Name="NotesCF" Type="String" />
			<asp:Parameter Name="IMAPUsername" Type="String" />
			<asp:Parameter Name="IMAPPassword" Type="String" />
			<asp:Parameter Name="IMAPDraftsFolder" Type="String" />
			<asp:Parameter Name="IDProfileContact" Type="Int32" />
			<asp:Parameter Name="Email" Type="String" />
			<asp:Parameter Name="PasswordQuestion" Type="String" />
			<asp:Parameter Name="UserID" Type="Object" />
		</UpdateParameters>
		<InsertParameters>
		</InsertParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sdsddTitle" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [DisplayValue], [IDOptionList] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName)">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="Title" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>

