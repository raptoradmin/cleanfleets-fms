<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="fleetdetails.aspx.vb" Inherits="cleanfleets_fms.fleetdetails" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<table id="tableBreadcrumbMenu" style="width: 800px;">
		<tr>
			<td>
				<asp:Button ID="btn_FleetList" runat="server" Text="&lt;&lt; Fleet List" />
			</td>
		</tr>
	</table>
	<asp:FormView ID="FormView1" runat="server" DataKeyNames="IDProfileFleet" DataSourceID="sds_cfv_Profile_Fleet"
		HorizontalAlign="Left" Width="800px">
		<EditItemTemplate>
			<span style="font-weight: bold; font-size: medium; color: #ED8701">Fleet</span><br />
			<br />
			<table width="100%">
				<tr>
					<td style="width: 105px" class="tdtable">
						Fleet Name:
					</td>
					<td>
						<asp:TextBox ID="FleetNameTextBox" runat="server" Text='<%# Bind("FleetName") %>'
							Width="200px" />
					</td>
				</tr>
				<tr>
					<td style="width: 105px" class="tdtable">
						Rule Code:
					</td>
					<td>
						<asp:DropDownList ID="ddl_RuleCode" runat="server" AppendDataBoundItems="True" DataSourceID="sds_RuleCode"
							DataTextField="DisplayValue" SelectedValue='<%# Bind("IDRuleCode") %>' DataValueField="IDOptionList">
							<asp:ListItem Text="Select" Value="0" />
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td style="width: 105px" class="tdtable">
						Terminal Name:
					</td>
					<td>
						<asp:TextBox ID="TerminalNameTextBox" runat="server" BackColor="#FCE7CC" ReadOnly="True"
							Text='<%# Bind("TerminalName") %>' Width="200px" />
					</td>
				</tr>
			</table>
			<br />
			<span style="font-weight: bold; font-size: medium; color: #ED8701">Details</span><br />
			<br />
			<table width="100%">
				<tr>
					<td class="tdtable">
						Address:
					</td>
					<td style="width: 275px">
						<asp:TextBox ID="Address1TextBox" runat="server" Text='<%# Bind("Address1") %>' Width="200px" />
					</td>
					<td class="tdtable">
						Telephone:
					</td>
					<td style="width: 275px">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<telerik:radmaskedtextbox id="Telephone1TextBox" runat="server" text='<%# Bind("Telephone1") %>'
										mask="(###) ###-####">
                                                </telerik:radmaskedtextbox>
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
					<td class="tdtable">
						Address:
					</td>
					<td style="width: 275px">
						<asp:TextBox ID="Address2TextBox" runat="server" Text='<%# Bind("Address2") %>' Width="200px" />
					</td>
					<td class="tdtable">
						Telephone:
					</td>
					<td style="width: 275px">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<telerik:radmaskedtextbox id="Telephone2TextBox" runat="server" text='<%# Bind("Telephone2") %>'
										mask="(###) ###-####">
                                                </telerik:radmaskedtextbox>
								</td>
								<td style="width: 40px; font-weight: bold; font-size: small; color: #2C7500; text-align: right">
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
					<td class="tdtable">
						City:
					</td>
					<td style="width: 275px">
						<asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' />
					</td>
					<td class="tdtable">
						Telephone:
					</td>
					<td style="width: 275px">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<telerik:radmaskedtextbox id="Telephone3TextBox" runat="server" text='<%# Bind("Telephone3") %>'
										mask="(###) ###-####">
                                                </telerik:radmaskedtextbox>
								</td>
								<td style="width: 40px; font-weight: bold; font-size: small; color: #2C7500; text-align: right">
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
					<td class="tdtable">
						State:
					</td>
					<td style="width: 275px">
						<asp:TextBox ID="StateTextBox" runat="server" Text='<%# Bind("State") %>' />
					</td>
					<td class="tdtable">
						Fax:
					</td>
					<td style="width: 275px">
						<telerik:radmaskedtextbox id="Fax1TextBox" runat="server" mask="(###) ###-####" text='<%# Bind("Fax1") %>'>
                                    </telerik:radmaskedtextbox>
					</td>
				</tr>
				<tr>
					<td class="tdtable">
						Zip:
					</td>
					<td style="width: 275px">
						<asp:TextBox ID="ZipTextBox" runat="server" Text='<%# Bind("Zip") %>' />
					</td>
					<td class="tdtable">
						Website:
					</td>
					<td style="width: 275px">
						<asp:TextBox ID="WebsiteTextBox" runat="server" Text='<%# Bind("Website") %>' />
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
			<asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
				Text="Update" />
			&nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False"
				CommandName="Cancel" Text="Cancel" />
		</EditItemTemplate>
		<InsertItemTemplate>
		</InsertItemTemplate>
		<ItemTemplate>
			<span style="font-weight: bold; font-size: medium; color: #ED8701">Fleet</span><br />
			<br />
			<table width="100%">
				<tr>
					<td style="width: 105px" class="tdtable">
						Fleet Name:
					</td>
					<td>
						<asp:Label ID="FleetNameLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("FleetName") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="width: 105px" class="tdtable">
						Rule Code:
					</td>
					<td>
						<asp:Label ID="lbl_RuleCode" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("RuleCode") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="width: 105px" class="tdtable">
						Terminal Name:
					</td>
					<td>
						<asp:Label ID="TerminalNameLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("TerminalName") %>'></asp:Label>
					</td>
				</tr>
			</table>
			<br />
			<span style="font-weight: bold; font-size: medium; color: #ED8701">Details</span><br />
			<br />
			<table width="100%">
				<tr>
					<td class="tdtable">
						Address:
					</td>
					<td style="width: 275px">
						<asp:Label ID="Address1Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("Address1") %>'></asp:Label>
					</td>
					<td class="tdtable">
						Telephone:
					</td>
					<td style="width: 275px">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<asp:Label ID="Telephone1Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Me.FormatPhone(If(Convert.IsDBNull(Eval("Telephone1")), String.Empty, "Telephone1"))%>'></asp:Label>
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
					<td class="tdtable">
						Address:
					</td>
					<td style="width: 275px">
						<asp:Label ID="Address2Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("Address2") %>'></asp:Label>
					</td>
					<td class="tdtable">
						Telephone:
					</td>
					<td style="width: 275px">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<asp:Label ID="Telephone2Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Me.FormatPhone(If(Convert.IsDBNull(Eval("Telephone2")), String.Empty, "Telephone2"))%>'></asp:Label>
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
					<td class="tdtable">
						City:
					</td>
					<td style="width: 275px">
						<asp:Label ID="CityLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("City") %>'></asp:Label>
					</td>
					<td class="tdtable">
						Telephone:
					</td>
					<td style="width: 275px">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<asp:Label ID="Telephone3Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Me.FormatPhone(If(Convert.IsDBNull(Eval("Telephone3")), String.Empty, "Telephone3"))%>'></asp:Label>
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
					<td class="tdtable">
						State:
					</td>
					<td style="width: 275px">
						<asp:Label ID="StateLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("State") %>'></asp:Label>
					</td>
					<td class="tdtable">
						Fax:
					</td>
					<td style="width: 275px">
						<asp:Label ID="Fax1Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Me.FormatPhone(If(Convert.IsDBNull(Eval("Fax1")), String.Empty, "Fax1"))%>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="tdtable">
						Zip:
					</td>
					<td style="width: 275px">
						<asp:Label ID="ZipLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("Zip") %>'></asp:Label>
					</td>
					<td class="tdtable">
						Website:
					</td>
					<td style="width: 275px">
						<asp:HyperLink ID="WebsiteLabel" runat="server" Text='<%# Bind("Website") %>' NavigateUrl='<%# Eval("Website") %>'
							Target="_blank"></asp:HyperLink>
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
			<br />
			<!--09/13/2012 IR: Show the edit and delete buttons when the current user has read/write permissions on the terminal -->
			<% if me.terminalPermission = "A" then %>
				<asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
					Text="Edit" />
				&nbsp;<asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
					OnClientClick="return confirm('Are you certain you want to delete this Fleet?')"
					Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="Delete" />
				&nbsp;<asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
					Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="New"
					Visible="False" />
			<% end if %>
		</ItemTemplate>
	</asp:FormView>
	<br />
	<asp:SqlDataSource ID="sds_cfv_Profile_Fleet" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		DeleteCommand="DELETE FROM [CF_Profile_Fleet] WHERE [IDProfileFleet] = @IDProfileFleet"
		InsertCommand="INSERT INTO [CF_Profile_Fleet] ([FleetName], [Address1], [Address2], [City], [State], [County], [Country], [Zip], [MailMergeCode], [Telephone1], [Ext1], [Telephone2], [Ext2], [Telephone3], [Ext3], [CellPhone], [Fax1], [Fax2], [WebSite], [Notes], [NotesCF]) VALUES (@AccountName, @TerminalName, @Address1, @Address2, @City, @State, @County, @Country, @Zip, @MailMergeCode, @Telephone1, @Ext1, @Telephone2, @Ext2, @Telephone3, @Ext3, @CellPhone, @Fax1, @Fax2, @WebSite, @Notes, @NotesCF)"
		SelectCommand="SELECT [IDProfileFleet], [IDProfileTerminal], [IDRuleCode], [RuleCode], [FleetName], [TerminalName], [Address1], [Address2], [City], [State], [County], [Country], [Zip], [Telephone1], [Ext1], [Telephone2], [Ext2], [Telephone3], [Ext3], [Fax1],  [WebSite], [Notes], [NotesCF] FROM [CFV_Profile_Fleet] WHERE ([IDProfileFLeet] = @IDProfileFleet)"
		UpdateCommand="UPDATE [CF_Profile_Fleet] SET [IDModifiedUser] = @IDModifiedUser,  [IDRuleCode] =  @IDRuleCode, [ModifiedDate] = @ModifiedDate, [FleetName] = @FleetName,  [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [State] = @State, [County] = @County, [Country] = @Country, [Zip] = @Zip, [Telephone1] = @Telephone1, [Ext1] = @Ext1, [Telephone2] = @Telephone2, [Ext2] = @Ext2, [Telephone3] = @Telephone3, [Ext3] = @Ext3, [Fax1] = @Fax1, [WebSite] = @WebSite, [Notes] = @Notes, [NotesCF] = @NotesCF WHERE [IDProfileFleet] = @IDProfileFleet">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileFleet" QueryStringField="IDProfileFleet"
				Type="Int32" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDProfileFleet" Type="Int32" />
		</DeleteParameters>
		<UpdateParameters>
			<asp:Parameter Name="FleetName" Type="String" />
			<asp:Parameter Name="Address1" Type="String" />
			<asp:Parameter Name="Address2" Type="String" />
			<asp:Parameter Name="City" Type="String" />
			<asp:Parameter Name="State" Type="String" />
			<asp:Parameter Name="County" Type="String" />
			<asp:Parameter Name="Country" Type="String" />
			<asp:Parameter Name="Zip" Type="String" />
			<asp:Parameter Name="Telephone1" Type="String" />
			<asp:Parameter Name="Ext1" Type="String" />
			<asp:Parameter Name="Telephone2" Type="String" />
			<asp:Parameter Name="Ext2" Type="String" />
			<asp:Parameter Name="Telephone3" Type="String" />
			<asp:Parameter Name="Ext3" Type="String" />
			<asp:Parameter Name="CellPhone" Type="String" />
			<asp:Parameter Name="Fax1" Type="String" />
			<asp:Parameter Name="WebSite" Type="String" />
			<asp:Parameter Name="Notes" Type="String" />
			<asp:Parameter Name="NotesCF" Type="String" />
			<asp:Parameter Name="IDProfileFleet" Type="Int32" />
			<asp:Parameter Name="IDRuleCode" Type="Int32" />
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:Parameter Name="ModifiedDate" Type="DateTime" />
		</UpdateParameters>
		<InsertParameters>
			<asp:Parameter Name="FleetName" Type="String" />
			<asp:Parameter Name="Address1" Type="String" />
			<asp:Parameter Name="Address2" Type="String" />
			<asp:Parameter Name="City" Type="String" />
			<asp:Parameter Name="State" Type="String" />
			<asp:Parameter Name="County" Type="String" />
			<asp:Parameter Name="Country" Type="String" />
			<asp:Parameter Name="Zip" Type="String" />
			<asp:Parameter Name="Telephone1" Type="String" />
			<asp:Parameter Name="Ext1" Type="String" />
			<asp:Parameter Name="Telephone2" Type="String" />
			<asp:Parameter Name="Ext2" Type="String" />
			<asp:Parameter Name="Telephone3" Type="String" />
			<asp:Parameter Name="Ext3" Type="String" />
			<asp:Parameter Name="CellPhone" Type="String" />
			<asp:Parameter Name="Fax1" Type="String" />
			<asp:Parameter Name="WebSite" Type="String" />
			<asp:Parameter Name="Notes" Type="String" />
			<asp:Parameter Name="NotesCF" Type="String" />
		</InsertParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_RuleCode" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:Parameter DefaultValue="RuleCode" Name="OptionName" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>
