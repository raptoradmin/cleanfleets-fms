<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="employee_add.aspx.vb" Inherits="cleanfleets_fms.employee_add" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Add Employee</p>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		<asp:CreateUserWizard ID="CreateUserWizard1" runat="server" Height="497px" Width="894px"
			CreateUserButtonText="Add Contact" Style="font-size: x-small; color: #000000">
			<WizardSteps>
				<asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
					<ContentTemplate>
						<table border="0">
							<tr>
								<td align="right" style="font-size: small; font-weight: bold; text-align: right;
									width: 150px; color: #2C7500">
									&nbsp;
								</td>
								<td colspan="2" style="color: #FF3300">
									<asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
								</td>
							</tr>
							<tr>
								<td align="right" style="font-size: small; font-weight: bold; text-align: right;
									width: 150px; color: #2C7500">
									Employee Role:
								</td>
								<td>
									<b><span style="font-size: medium; color: #2C7500">
										<asp:DropDownList ID="ddl_IDEmployeeRole" runat="server" AppendDataBoundItems="True"
											DataSourceID="sds_CF_Option_List_EmployeeRole" DataTextField="DisplayValue" DataValueField="DisplayValue"
											TabIndex="5">
											<asp:ListItem Text="Select" Value="" />
										</asp:DropDownList>
									</span></b>
								</td>
								<td>
									&nbsp;
								</td>
							</tr>
							<tr>
								<td align="right" style="font-size: small; font-weight: bold; text-align: right;
									width: 150px; color: #2C7500">
									First Name:
								</td>
								<td>
									<asp:TextBox ID="tb_FirstName" runat="server"></asp:TextBox>
								</td>
								<td>
									&nbsp;
								</td>
							</tr>
							<tr>
								<td align="right" style="font-size: small; font-weight: bold; text-align: right;
									width: 150px; color: #2C7500">
									Last Name:
								</td>
								<td>
									<asp:TextBox ID="tb_LastName" runat="server"></asp:TextBox>
								</td>
								<td>
									&nbsp;
								</td>
							</tr>
							<tr>
								<td align="right" style="font-size: small; font-weight: bold; text-align: right;
									width: 150px; color: #2C7500">
									MI:
								</td>
								<td>
									<b><span style="font-size: medium; color: #2C7500">
										<asp:TextBox ID="tb_MI" runat="server" MaxLength="2" TabIndex="3" Width="50px"></asp:TextBox>
									</span></b>
								</td>
								<td>
									&nbsp;
								</td>
							</tr>
							<tr>
								<td align="right" style="font-size: small; font-weight: bold; text-align: right;
									width: 150px; color: #2C7500">
									Title:
								</td>
								<td>
									<b><span style="font-size: medium; color: #2C7500">
										<asp:DropDownList ID="ddl_IDEmployeeTitle" runat="server" AppendDataBoundItems="True"
											DataSourceID="sds_CF_Option_List_Employee_Title" DataTextField="DisplayValue"
											DataValueField="IDOptionList" TabIndex="5">
											<asp:ListItem Text="Select" Value="" />
										</asp:DropDownList>
									</span></b>
								</td>
								<td style="color: #FF0000">
									&nbsp;
								</td>
							</tr>
							<tr>
								<td align="right" style="font-size: small; font-weight: bold; text-align: right;
									width: 150px; color: #2C7500">
									<asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" ForeColor="#2C7500">User 
                                    Name:</asp:Label>
								</td>
								<td>
									<asp:TextBox ID="UserName" runat="server"></asp:TextBox>
									<asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
										ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
								</td>
								<td style="color: #FF0000">
									&nbsp;
								</td>
							</tr>
							<tr>
								<td align="right" style="font-size: small; font-weight: bold; text-align: right;
									width: 150px; color: #2C7500">
									<asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" ForeColor="#2C7500">Password:</asp:Label>
								</td>
								<td>
									<asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
									<asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
										ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
								</td>
								<td>
									<asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password"
										ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match."
										ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
								</td>
							</tr>
							<tr>
								<td align="right" style="font-size: small; font-weight: bold; text-align: right;
									width: 150px; color: #2C7500">
									<asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword"
										ForeColor="#2C7500">Confirm Password:</asp:Label>
								</td>
								<td>
									<asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
									<asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
										ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required."
										ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
								</td>
								<td>
									&nbsp;
								</td>
							</tr>
							<tr>
								<td align="right" style="font-size: small; font-weight: bold; text-align: right;
									width: 150px; color: #2C7500">
									<asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email" ForeColor="#2C7500">E-mail:</asp:Label>
								</td>
								<td>
									<asp:TextBox ID="Email" runat="server"></asp:TextBox>
									<asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
										ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
								</td>
								<td>
									&nbsp;
								</td>
							</tr>
							<tr>
								<td align="right" style="font-size: small; font-weight: bold; text-align: right;
									width: 150px; color: #2C7500">
									<asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question" ForeColor="#2C7500">Security 
                                    Question:</asp:Label>
								</td>
								<td>
									<asp:TextBox ID="Question" runat="server"></asp:TextBox>
									<asp:RequiredFieldValidator ID="QuestionRequired" runat="server" ControlToValidate="Question"
										ErrorMessage="Security question is required." ToolTip="Security question is required."
										ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
								</td>
								<td>
									&nbsp;
								</td>
							</tr>
							<tr>
								<td align="right" style="font-size: small; font-weight: bold; text-align: right;
									width: 150px; color: #2C7500">
									<asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer" ForeColor="#2C7500">Security 
                                    Answer:</asp:Label>
								</td>
								<td>
									<asp:TextBox ID="Answer" runat="server"></asp:TextBox>
									<asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer"
										ErrorMessage="Security answer is required." ToolTip="Security answer is required."
										ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
								</td>
								<td>
									&nbsp;
								</td>
							</tr>
						</table>
						<p style="font-size: medium; font-weight: bold; color: #ED8701">
							Employee Details</p>
						<table style="width: 800px;">
							<tr>
								<td style="font-size: small; font-weight: bold; text-align: right; width: 100px;
									color: #2C7500">
									Address:
								</td>
								<td>
									<asp:TextBox ID="tb_Address1" runat="server" TabIndex="6"></asp:TextBox>
								</td>
								<td style="font-size: small; font-weight: bold; text-align: right; width: 125px;
									color: #2C7500">
									Telephone:
								</td>
								<td>
									<table style="width: 100%">
										<tr>
											<td>
												<span style="font-weight: bold; font-size: medium; color: #ED8701"><b><span style="font-size: medium;
													color: #2C7500">
													<telerik:radmaskedtextbox id="tb_Telephone1" runat="server" mask="(###) ###-####"
														tabindex="11">
                                                </telerik:radmaskedtextbox>
												</span></b></span>
											</td>
											<td style="font-size: small; font-weight: bold; text-align: right; color: #2C7500">
												Ext:
											</td>
											<td>
												&nbsp;
											</td>
											<td>
												<b><span style="font-size: medium; color: #2C7500">
													<asp:TextBox ID="tb_Ext1" runat="server" TabIndex="12" Width="50px"></asp:TextBox>
												</span></b>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="font-size: small; font-weight: bold; text-align: right; width: 100px;
									color: #2C7500">
									Address:
								</td>
								<td>
									<asp:TextBox ID="tb_Address2" runat="server" TabIndex="7"></asp:TextBox>
								</td>
								<td style="font-size: small; font-weight: bold; text-align: right; width: 125px;
									color: #2C7500">
									Telephone:
								</td>
								<td>
									<table style="width: 100%">
										<tr>
											<td>
												<span style="font-weight: bold; font-size: medium; color: #ED8701"><b><span style="font-size: medium;
													color: #2C7500">
													<telerik:radmaskedtextbox id="tb_Telephone2" runat="server" mask="(###) ###-####"
														tabindex="13">
                                                </telerik:radmaskedtextbox>
												</span></b></span>
											</td>
											<td style="font-size: small; font-weight: bold; text-align: right; color: #2C7500">
												Ext:
											</td>
											<td>
												&nbsp;
											</td>
											<td>
												<b><span style="font-size: medium; color: #2C7500">
													<asp:TextBox ID="tb_Ext2" runat="server" TabIndex="14" Width="50px"></asp:TextBox>
												</span></b>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="font-size: small; font-weight: bold; text-align: right; width: 100px;
									color: #2C7500">
									City:
								</td>
								<td>
									<asp:TextBox ID="tb_City" runat="server" TabIndex="8"></asp:TextBox>
								</td>
								<td style="font-size: small; font-weight: bold; text-align: right; width: 125px;
									color: #2C7500">
									Telephone:
								</td>
								<td>
									<table style="width: 100%">
										<tr>
											<td>
												<span style="font-weight: bold; font-size: medium; color: #ED8701"><b><span style="font-size: medium;
													color: #2C7500">
													<telerik:radmaskedtextbox id="tb_Telephone3" runat="server" mask="(###) ###-####"
														tabindex="15">
                                                </telerik:radmaskedtextbox>
												</span></b></span>
											</td>
											<td style="font-size: small; font-weight: bold; text-align: right; color: #2C7500">
												Ext:
											</td>
											<td>
												&nbsp;
											</td>
											<td>
												<b><span style="font-size: medium; color: #2C7500">
													<asp:TextBox ID="tb_Ext3" runat="server" TabIndex="16" Width="50px"></asp:TextBox>
												</span></b>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="font-size: small; font-weight: bold; text-align: right; width: 100px;
									color: #2C7500">
									State:
								</td>
								<td>
									<asp:TextBox ID="tb_State" runat="server" TabIndex="9"></asp:TextBox>
								</td>
								<td style="font-size: small; font-weight: bold; text-align: right; width: 125px;
									color: #2C7500">
									Cell Phone:
								</td>
								<td>
									<span style="font-weight: bold; font-size: medium; color: #ED8701"><b><span style="font-size: medium;
										color: #2C7500">
										<telerik:radmaskedtextbox id="tb_CellPhone" runat="server" mask="(###) ###-####"
											tabindex="17">
                                    </telerik:radmaskedtextbox>
									</span></b></span>
								</td>
							</tr>
							<tr>
								<td style="font-size: small; font-weight: bold; text-align: right; width: 100px;
									color: #2C7500">
									Zip:
								</td>
								<td>
									<asp:TextBox ID="tb_Zip" runat="server" TabIndex="10"></asp:TextBox>
								</td>
								<td style="font-size: small; font-weight: bold; text-align: right; width: 125px;
									color: #2C7500">
									Fax:
								</td>
								<td>
									<span style="font-weight: bold; font-size: medium; color: #ED8701"><b><span style="font-size: medium;
										color: #2C7500">
										<telerik:radmaskedtextbox id="tb_Fax1" runat="server" mask="(###) ###-####" tabindex="18">
                                    </telerik:radmaskedtextbox>
									</span></b></span>
								</td>
							</tr>
							<tr>
								<td style="font-size: small; font-weight: bold; text-align: right; width: 100px;
									color: #2C7500">
									&nbsp;
								</td>
								<td>
									&nbsp;
								</td>
								<td style="font-size: small; font-weight: bold; text-align: right; width: 125px;
									color: #2C7500">
									Email:
								</td>
								<td>
									<asp:TextBox ID="tb_Email" runat="server" TabIndex="19" Width="225px"></asp:TextBox>
								</td>
							</tr>
						</table>
						<p style="font-size: medium; font-weight: bold; color: #ED8701">
							Notes</p>
						<table style="width: 800px;">
							<tr>
								<td style="width: 96px">
									&nbsp;
								</td>
								<td>
									<asp:TextBox ID="tb_Notes" runat="server" Height="75px" TabIndex="20" TextMode="MultiLine"
										Width="600px"></asp:TextBox>
								</td>
							</tr>
						</table>
						<p style="font-size: medium; font-weight: bold; color: #ED8701">
							Internal Notes</p>
						<table style="width: 800px;">
							<tr>
								<td style="width: 96px">
									&nbsp;
								</td>
								<td>
									<asp:TextBox ID="tb_NotesCF" runat="server" Height="75px" TabIndex="19" TextMode="MultiLine"
										Width="600px"></asp:TextBox>
								</td>
							</tr>
						</table>
						<br />
						<br />
						<br />
					</ContentTemplate>
					<CustomNavigationTemplate>
						<table border="0" cellspacing="5" style="width: 100%; height: 100%;">
							<tr align="left">
								<td align="left" colspan="0">
									<asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Add User"
										ValidationGroup="CreateUserWizard1" />
								</td>
							</tr>
						</table>
					</CustomNavigationTemplate>
				</asp:CreateUserWizardStep>
				<asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" />
			</WizardSteps>
		</asp:CreateUserWizard>
	</p>
	<asp:SqlDataSource ID="sds_CF_Option_List_Employee_Title" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [RecordValue], [DisplayValue], [IDOptionList] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="Title" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_CF_Option_List_EmployeeRole" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName)">
		<SelectParameters>
			<asp:Parameter DefaultValue="UserRole" Name="OptionName" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>

