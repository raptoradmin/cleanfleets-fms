<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="account_user_details.aspx.vb" Inherits="cleanfleets_fms.account_user_details" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<asp:Label ID="Message" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text=''></asp:Label>

	<asp:FormView ID="FormView1" runat="server" DataKeyNames="IDProfileContact" DataSourceID="sdsfvEmployeeDetails"
		HorizontalAlign="Left" Width="800px">
		<EditItemTemplate>
			<div>
				<span style="font-weight: bold; font-size: medium; color: #ED8701">Employee</span><br />
				<br />
				<asp:HiddenField ID="UserIDHiddenField" runat="server" Value='<%# Bind("UserID") %>' />
				
				<table width="100%">
					<tr>
						<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
							width: 130px">
							Last Name:&nbsp;
						</td>
						<td>
							<asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' />
						</td>
					</tr>
					<tr>
						<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
							width: 130px">
							First Name:
						</td>
						<td>
							<asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' />
						</td>
					</tr>
					<tr>
						<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
							width: 130px">
							MI:
						</td>
						<td>
							<asp:TextBox ID="MITextBox" runat="server" Text='<%# Bind("MI") %>' />
						</td>
					</tr>
					<tr>
						<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
							width: 130px">
							Title:
						</td>
						<td>
							<asp:DropDownList ID="DropDownListTitle" runat="server" AppendDataBoundItems="True"
								DataSourceID="sdsddTitle" DataTextField="DisplayValue" DataValueField="IDOptionList">
								<asp:ListItem Value="">Select</asp:ListItem>
							</asp:DropDownList>
						</td>
					</tr>
					<tr>
						<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
							width: 130px">
							User Name:
						</td>
						<td>
							<asp:HiddenField ID="hf_OldUserName" runat="server" Value='<%# Eval("UserName") %>' />
							<asp:TextBox ID="tbx_UserName" runat="server" Text='<%# Bind("UserName") %>' readOnly="true"/>
							<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbx_UserName"
								ErrorMessage="*" Font-Bold="True" Font-Size="Large"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr>
						<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
							width: 130px">
							Password:
						</td>
						<td>
							<asp:HiddenField ID="tbx_OldPassword" runat="server" Value='<%# Eval("Password") %>' />
							<asp:TextBox ID="tbx_Password" runat="server" Text='<%# Bind("Password") %>' />
							<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbx_Password"
								ErrorMessage="*" Font-Bold="True" Font-Size="Large"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr>
						<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
							width: 130px">
							Password:
						</td>
						<td>
							<asp:TextBox ID="tbx_PasswordVerify" runat="server" Text='<%# Eval("Password") %>'/>
							<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="tbx_PasswordVerify"
								ErrorMessage="*" Font-Bold="True" Font-Size="Large"></asp:RequiredFieldValidator>
							<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="tbx_Password"
								ControlToValidate="tbx_PasswordVerify" ErrorMessage="Password do not match."></asp:CompareValidator>
						</td>
					</tr>
					<tr>
						<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
							width: 130px">
							Password Question:
						</td>
						<td>
							<asp:TextBox ID="tbx_PasswordQuestion" runat="server" Text='<%# Bind("PasswordQuestion") %>'
								Width="425px" />
							<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbx_PasswordQuestion"
								ErrorMessage="*" Font-Bold="True" Font-Size="Large"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr>
						<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
							width: 130px">
							Password Answer:
						</td>
						<td>
							<asp:TextBox ID="tbx_PasswordAnswer" runat="server" Text='<%# Bind("PasswordAnswer") %>'
								Width="425px" />
							<asp:RequiredFieldValidator ID="RequiredFieldValidatorPasswordAnswer" runat="server" ControlToValidate="tbx_PasswordAnswer"
								ErrorMessage="*" Font-Bold="True" Font-Size="Large"></asp:RequiredFieldValidator>
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
							<asp:RequiredFieldValidator id="EmailRequiredValidator" runat="server"
                                    ControlToValidate="EmailTextBox" ForeColor="red"
                                    Display="Static" ErrorMessage="Required" />
						</td>
					</tr>
				</table>
				<br />
				<table width="100%">
					<tr>
						<td width="325px">	
						<!-- 09/13/2012 IR: Added radgrid to allow updating of user terminal permissions -->
						<p style="font-size: medium; font-weight: bold; color: #ED8701">Terminal Permissions</p>
						<telerik:radgrid id="RadGrid1" runat="server" AllowAutomaticUpdates="True" allowsorting="True" datasourceid="sds_Profile_Terminal"
								gridlines="None" skin="Telerik" width="400px" cssclass="radgrid" >
								<mastertableview autogeneratecolumns="False"
								datakeynames="IDProfileTerminal" 
								nomasterrecordstext="This Account has no Terminals assigned.">
								<rowindicatorcolumn>
									<HeaderStyle Width="20px" />
								</rowindicatorcolumn>
								<expandcollapsecolumn>
									<HeaderStyle Width="20px" />
								</expandcollapsecolumn>
								<Columns>
									<telerik:GridBoundColumn DataField="TerminalName" HeaderText="Terminal Name" 
										SortExpression="TerminalName" UniqueName="TerminalName" ReadOnly="true">
									</telerik:GridBoundColumn>
									<telerik:GridTemplateColumn UniqueName="PermissionLevel" HeaderText="Permission Level"
										InitializeTemplatesFirst="false">
										<ItemTemplate>
											<table cellspacing="0" width="100%" class="myTable">
												<tr>
													<td style="width: 50%">
														<%--<asp:DropDownList id="Permissions" runat="server"
														 DataSourceID="sds_Terminal_Permissions"
														 DataTextField="DisplayValue"
														 DataValueField="RecordValue"
														 SelectedValue='<%# Bind("PermissionLevel")%>'
														 AutoPostBack="True"
														 AppendDataBoundItems="True">
														 <asp:ListItem Text="--Choose One--" Value="" />
													</asp:DropDownList>--%>
													<asp:DropDownList id="Permissions" runat="server"
														 DataTextField="DisplayValue"
														 DataValueField="RecordValue"
														 SelectedValue='<%# Bind("PermissionLevel")%>'
														 AutoPostBack="True"
														 AppendDataBoundItems="True">
															 <asp:ListItem Text="--Choose One--" Value="" />
															 <asp:ListItem Text="Full" Value="A" />
															 <asp:ListItem Text="Read Only" Value="B" />
															 <asp:ListItem Text="None" Value="G" />
													</asp:DropDownList>
													<asp:HiddenField ID="IDProfileTerminalHiddenField" runat="server" Value='<%# Bind("IDProfileTerminal") %>' />
													</td>
											</table>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Center" />
									</telerik:GridTemplateColumn>
								</Columns>
								</mastertableview>
							</telerik:radgrid>
							<%--<telerik:radgrid id="RadGrid1" runat="server" AllowAutomaticUpdates="True" allowsorting="True" datasourceid="sds_Profile_Terminal"
								gridlines="None" skin="Telerik" width="400px" cssclass="radgrid" >
								<mastertableview autogeneratecolumns="False"
								datakeynames="IDProfileTerminal" 
								nomasterrecordstext="This Account has no Terminals assigned.">
								<rowindicatorcolumn>
									<HeaderStyle Width="20px" />
								</rowindicatorcolumn>
								<expandcollapsecolumn>
									<HeaderStyle Width="20px" />
								</expandcollapsecolumn>
								<Columns>
									<telerik:GridEditCommandColumn UniqueName="EditCommandColumn" HeaderText="">
										<ItemStyle Width="50px" />
									</telerik:GridEditCommandColumn>
									<telerik:GridBoundColumn DataField="TerminalName" HeaderText="Terminal Name" 
										SortExpression="TerminalName" UniqueName="TerminalName" ReadOnly="true">
									</telerik:GridBoundColumn>
									<telerik:GridDropDownColumn UniqueName="PermissionLevel" ListTextField="DisplayValue" DataField="PermissionLevel"
									  ListValueField="RecordValue" datasourceid="sds_Terminal_Permissions" HeaderText="Permission Level"
									  DropDownControlType="DropDownList" EnableEmptyListItem = "true"
									  EmptyListItemText="--Choose an option--" EmptyListItemValue="">
									</telerik:GridDropDownColumn>
								</Columns>
								<EditFormSettings EditFormType="Template">
                        			<FormTemplate>
										<table cellpadding="0" cellspacing="0" style="width: 100%">
											<tr>
												<td style="width: 100%">
													<b>New Permission Level</b>
													<asp:DropDownList id="Permissions" runat="server"
														 DataSourceID="sds_Terminal_Permissions"
														 DataTextField="DisplayValue"
														 DataValueField="RecordValue"
														 SelectedValue='<%# Bind("PermissionLevel") %>'
														 AutoPostBack="True"
														 AppendDataBoundItems="True">
														 <asp:ListItem Text="--Choose One--" Value="" />
													</asp:DropDownList>
													<asp:HiddenField ID="IDProfileTerminalHiddenField" runat="server" Value='<%# Bind("IDProfileTerminal") %>' />
												</td>
												<td>&nbsp;
													</td>
											</tr>
										</table>
										<br/>
										<table cellpadding="0" cellspacing="0" style="width: 100%">
											<tr>
												<td style="width: 66px">
													<asp:Button ID="btnUpdate" Text="Update" runat="server" CommandName="Update"></asp:Button>
												</td>
												<td>
													<asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False" CommandName="Cancel"></asp:Button>
												</td>
												<td>&nbsp;
													</td>
											</tr>
										</table>
										<br />
										</FormTemplate>
									</EditFormSettings>
								</mastertableview>
							</telerik:radgrid>--%>
							<%--<asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>--%>
						</td>
					</tr>
				</table>
				<br/>
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
				<asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
					Text="Update" OnClick="UpdateButton_Click" />
				&nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False"
					CommandName="Cancel" Text="Cancel" />
			</div>
		</EditItemTemplate>
		<ItemTemplate>
			<span style="font-weight: bold; font-size: medium; color: #ED8701">Employee</span><br />
			<br />
			<table width="100%">
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 131px">
						Last Name:
					</td>
					<td>
						<asp:Label ID="LastNameLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("LastName") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 131px">
						First Name:
					</td>
					<td>
						<asp:Label ID="FirstNameLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("FirstName") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 131px">
						MI:
					</td>
					<td>
						<asp:Label ID="MILabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("MI") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 131px">
						Title:
					</td>
					<td>
						<asp:Label ID="TitleLabel0" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("Title") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 131px">
						User Name:
					</td>
					<td>
						<asp:Label ID="lbl_UserName" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small; color: #F18700;" Text='<%# Bind("UserName") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 131px">
						Password:
					</td>
					<td>
						<asp:Label ID="lbl_Password" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small; color: #F18700;" Text='<%# Bind("Password") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 131px">
						Password Question
					</td>
					<td>
						<asp:Label ID="lbl_PasswordQuestion" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small; color: #F18700;" Text='<%# Bind("PasswordQuestion") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
						width: 131px">
						Password Answer
					</td>
					<td>
						<asp:Label ID="lbl_PasswordAnswer" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small; color: #F18700;" Text='<%# Bind("PasswordAnswer") %>'></asp:Label>
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
			<!-- 09/13/2012: Added radgrid for displaying user terminal permissions -->
			<span style="font-weight: bold; font-size: medium; color: #ED8701"> Terminal Permissions</span>
			<telerik:radgrid id="RadGrid2" runat="server" allowsorting="True" datasourceid="sds_Profile_Terminal"
			gridlines="None" skin="Telerik" width="300px" cssclass="radgrid" AllowMultiRowEdit="True">
			<mastertableview autogeneratecolumns="False"
			datakeynames="IDProfileTerminal" 
			nomasterrecordstext="This Account has no Terminals assigned.">
			<rowindicatorcolumn>
				<HeaderStyle Width="20px" />
			</rowindicatorcolumn>
			<expandcollapsecolumn>
				<HeaderStyle Width="20px" />
			</expandcollapsecolumn>
			<Columns>
				<telerik:GridBoundColumn DataField="TerminalName" HeaderText="Terminal Name" 
					SortExpression="TerminalName" UniqueName="TerminalName">
				</telerik:GridBoundColumn>
				<telerik:GridDropDownColumn UniqueName="PermissionLevel" ListTextField="DisplayValue" DataField="PermissionLevel"
				  ListValueField="PermissionLevel" datasourceid="sds_Profile_Terminal" HeaderText="Permission Level"
				  DropDownControlType="DropDownList" AllowSorting="true" EnableEmptyListItem = "true" 
				  EmptyListItemText="--Choose an option--" EmptyListItemValue="">
				</telerik:GridDropDownColumn>
			</Columns>
			</mastertableview>
		</telerik:radgrid>
			<br style="font-family: Arial, Helvetica, sans-serif; font-size: small" />
			<asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
				Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="Edit" />
		</ItemTemplate>
	</asp:FormView>
	
	
	<br /><br />
	<asp:SqlDataSource ID="sdsfvEmployeeDetails" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		DeleteCommand="DELETE FROM [CF_Profile_Contact] WHERE [UserID] = @UserID" 
		SelectCommand="SELECT [IDProfileContact], [UserID], [Password], [Email], [PasswordQuestion], [PasswordAnswer], [IDModifiedUser], [ModifiedDate], [IDPrefix], [IDPostfix], [IDTitle], [Title], [LastName], [FirstName], [UserName], [MI], [Title], [Address1], [Address2], [City], [State], [County], [Country], [Zip], [Telephone1], [Ext1], [Telephone2], [Ext2], [Telephone3], [Ext3], [CellPhone], [Fax1], [Fax2],[Notes], [NotesCF], [UserName] FROM [CFV_Profile_Contact] WHERE ([IDProfileContact] = @IDProfileContact)"
		
		UpdateCommand="UPDATE [CF_Profile_Contact] SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate, [IDPrefix] = @IDPrefix, [IDPostfix] = @IDPostfix, [IDTitle] = @IDTitle, [LastName] = @LastName, [FirstName] = @FirstName, [MI] = @MI, [Title] = @Title, [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [State] = @State, [County] = @County, [Country] = @Country, [Zip] = @Zip, [MailMergeCode] = @MailMergeCode, [Telephone1] = @Telephone1, [Ext1] = @Ext1, [Telephone2] = @Telephone2, [Ext2] = @Ext2, [Telephone3] = @Telephone3, [Ext3] = @Ext3, [CellPhone] = @CellPhone, [Fax1] = @Fax1, [Fax2] = @Fax2, [EMailMergeCode] = @EMailMergeCode, [WebSite] = @WebSite, [Notes] = @Notes, [NotesCF] = @NotesCF WHERE [IDProfileContact] = @IDProfileContact">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileContact" QueryStringField="IDProfileContact"
				Type="Int32" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="UserID" Type="Object" />
		</DeleteParameters>
		<UpdateParameters>
			<asp:Parameter Name="IDProfileContact" Type="Int32" />
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
			<asp:Parameter Name="IDProfileAccount" Type="Int32" />
			<asp:Parameter Name="UserID" Type="Object" />
			<asp:Parameter Name="UserName" Type="String" />
			<asp:Parameter Name="Email" Type="String" />
			<asp:Parameter Name="PasswordQuestion" Type="String" />
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
	<!--09/13/2012 IR: Added data source to get and update user terminal permissions -->
	<asp:SqlDataSource ID="sds_Profile_Terminal" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="GetUserTerminals" SelectCommandType="StoredProcedure"
		UpdateCommand="UPDATE [CF_UserTerminals] SET [PermissionLevel] = @PermissionLevel WHERE [UserId] = @UserId AND [IDProfileTerminal] = @IDProfileTerminal" >
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileContact" QueryStringField="IDProfileContact"
				Type="Int32" />
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount"
				Type="Int32" />
			<asp:Parameter Direction="Output" Name="Result" Type="String" size=100 />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="PermissionLevel" Type="Char" />
			<asp:Parameter Name="IDProfileTerminal" Type="Int32" />
			<asp:Parameter Name="UserId" />
		</UpdateParameters>
	</asp:SqlDataSource>
	<!--09/13/2012 IR: Added data source to populate the dropdown list of user terminal permissions -->
	<asp:SqlDataSource ID="sds_Terminal_Permissions" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT RecordValue, DisplayValue FROM CF_Option_List WHERE OptionName='TerminalPermissions'">
	</asp:SqlDataSource>
</asp:Content>

