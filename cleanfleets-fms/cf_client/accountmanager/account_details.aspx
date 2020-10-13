<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="account_details.aspx.vb" Inherits="cleanfleets_fms.account_details" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
	<script type="text/javascript">
		function RowDblClick(sender, eventArgs) {
			sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
		}
	</script>
	<script type="text/javascript">
		var popUp;
		function PopUpShowing(sender, eventArgs) {
			popUp = eventArgs.get_popUp();
			var gridWidth = sender.get_element().offsetWidth;
			var gridHeight = sender.get_element().offsetHeight;
			var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("20px"));
			var popUpHeight = popUp.style.height.substr(0, popUp.style.height.indexOf("px"));
			popUp.style.left = ((gridWidth - popUpWidth) / 2 + sender.get_element().offsetLeft).toString() + "px";
			popUp.style.top = ((gridHeight - popUpHeight) / 2 + sender.get_element().offsetTop).toString() + "px";
		}
	</script>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<style>
		.header	{ color:#ED8701; font-weight:bold; font-size:medium; }
		
		.label		{ text-align:right; }
		.label span { color:#2C7500; font-size:small; font-weight:bold; width:25px; }
	</style>
	<table cellpadding="0" cellspacing="0" style="width: 100%">
		<tr>
			<td>
				<asp:FormView ID="FormView1" runat="server" DataKeyNames="IDProfileAccount" DataSourceID="sdsfvAccountDetails"
					HorizontalAlign="Left" Width="800px">
					<EditItemTemplate>
						<span class="header">Account</span><br />
						<br />
						<table width="100%">
							<tr>
								<td class="label"><span>Account Name:</span></td>
								<td><asp:TextBox ID="AccountNameTextBox" runat="server" Text='<%# Bind("AccountName") %>' Height="22px" Width="250px" /></td>
							</tr>
							<tr>
								<td class="label"><span>Account Number:</span></td>
								<td>
									<asp:TextBox ID="AccountNumTextBox" runat="server" Text='<%# Bind("AccountNum") %>' />
								</td>
							</tr>
							<tr>
								<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
									width: 125px">
									Contract Number:
								</td>
								<td>
									<asp:TextBox ID="ContractNumTextBox" runat="server" Text='<%# Bind("ContractNum") %>' />
								</td>
							</tr>
							<tr>
								<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
									width: 125px">
									Referred By:
								</td>
								<td>
									<asp:TextBox ID="ReferredByTextBox" runat="server" Text='<%# Bind("ReferredBy") %>' />
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
								<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
									Address:
								</td>
								<td style="width: 275px">
									<asp:TextBox ID="Address2TextBox" runat="server" Text='<%# Bind("Address2") %>' Width="200px" />
								</td>
								<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right">
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
								<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
									City:
								</td>
								<td style="width: 275px">
									<asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' />
								</td>
								<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right">
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
								<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
									State:
								</td>
								<td style="width: 275px">
									<asp:TextBox ID="StateTextBox" runat="server" Text='<%# Bind("State") %>' />
								</td>
								<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right">
									Fax:
								</td>
								<td style="width: 275px">
									<telerik:radmaskedtextbox id="Fax1TextBox" runat="server" mask="(###) ###-####" text='<%# Bind("Fax1") %>'>
                                                            </telerik:radmaskedtextbox>
								</td>
							</tr>
							<tr>
								<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
									Zip:
								</td>
								<td style="width: 275px">
									<asp:TextBox ID="ZipTextBox" runat="server" Text='<%# Bind("Zip") %>' />
								</td>
								<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right">
									Website:
								</td>
								<td style="width: 275px">
									<asp:TextBox ID="WebsiteTextBox" runat="server" Text='<%# Bind("Website") %>' />
								</td>
							</tr>
						</table>
						<br />
						<span style="font-weight: bold; font-size: medium; color: #ED8701">Compliance Options</span><br />
						<br />
						<table>
							<tr>
								<td class="tdtable">
									Class 7-8 BACT Replacement Schedule:
								</td>
								<td class="tdtable">
									<asp:DropDownList ID="ddl_IDClass78BACTReplacementSchedule" runat="server" DataSourceID="sds_ddl_Op_IDClass78BACTReplacementSchedule"
										DataTextField="DisplayValue" DataValueField="IDOptionList" SelectedValue='<%# Bind("IDClass78BACTReplacementSchedule") %>'
										AppendDataBoundItems="true">
										<asp:ListItem Text="" Value="0" />
									</asp:DropDownList>
							</tr>
						</table>
						<br />
						<asp:Button ID="UpdateButton0" runat="server" CausesValidation="True" CommandName="Update"
							Text="Update" />
						&nbsp;<asp:Button ID="UpdateCancelButton0" runat="server" CausesValidation="False"
							CommandName="Cancel" Text="Cancel" />
					</EditItemTemplate>
					<InsertItemTemplate>
						Address1:
						<asp:TextBox ID="Address1TextBox0" runat="server" Text='<%# Bind("Address1") %>' />
						<br />
						Address2:
						<asp:TextBox ID="Address2TextBox0" runat="server" Text='<%# Bind("Address2") %>' />
						<br />
						City:
						<asp:TextBox ID="CityTextBox0" runat="server" Text='<%# Bind("City") %>' />
						<br />
						State:
						<asp:TextBox ID="StateTextBox0" runat="server" Text='<%# Bind("State") %>' />
						<br />
						County:
						<asp:TextBox ID="CountyTextBox" runat="server" Text='<%# Bind("County") %>' />
						<br />
						Country:
						<asp:TextBox ID="CountryTextBox" runat="server" Text='<%# Bind("Country") %>' />
						<br />
						Zip:
						<asp:TextBox ID="ZipTextBox0" runat="server" Text='<%# Bind("Zip") %>' />
						<br />
						MailMergeCode:
						<asp:TextBox ID="MailMergeCodeTextBox0" runat="server" Text='<%# Bind("MailMergeCode") %>' />
						<br />
						Telephone1:
						<asp:TextBox ID="Telephone1TextBox0" runat="server" Text='<%# Bind("Telephone1") %>' />
						<br />
						Ext1:
						<asp:TextBox ID="Ext1TextBox0" runat="server" Text='<%# Bind("Ext1") %>' />
						<br />
						Telephone2:
						<asp:TextBox ID="Telephone2TextBox0" runat="server" Text='<%# Bind("Telephone2") %>' />
						<br />
						Ext2:
						<asp:TextBox ID="Ext2TextBox0" runat="server" Text='<%# Bind("Ext2") %>' />
						<br />
						Telephone3:
						<asp:TextBox ID="Telephone3TextBox0" runat="server" Text='<%# Bind("Telephone3") %>' />
						<br />
						Ext3:
						<asp:TextBox ID="Ext3TextBox0" runat="server" Text='<%# Bind("Ext3") %>' />
						<br />
						CellPhone:
						<asp:TextBox ID="CellPhoneTextBox0" runat="server" Text='<%# Bind("CellPhone") %>' />
						<br />
						Fax1:
						<asp:TextBox ID="Fax1TextBox0" runat="server" Text='<%# Bind("Fax1") %>' />
						<br />
						Fax2:
						<asp:TextBox ID="Fax2TextBox" runat="server" Text='<%# Bind("Fax2") %>' />
						<br />
						WebSite:
						<asp:TextBox ID="WebSiteTextBox0" runat="server" Text='<%# Bind("WebSite") %>' />
						<br />
						Notes:
						<asp:TextBox ID="NotesTextBox0" runat="server" Text='<%# Bind("Notes") %>' />
						<br />
						NotesCF:
						<asp:TextBox ID="NotesCFTextBox0" runat="server" Text='<%# Bind("NotesCF") %>' />
						<br />
						<asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
							Text="Insert" />
						&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False"
							CommandName="Cancel" Text="Cancel" />
					</InsertItemTemplate>
					<ItemTemplate>
						<span style="font-weight: bold; font-size: medium; color: #ED8701">Account
							<asp:Label ID="lbl_IDProfileAccount" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
								font-size: small" Text='<%# Bind("IDProfileAccount") %>' Visible="False"></asp:Label>
						</span>
						<br />
						<br />
						<table width="100%">
							<tr>
								<td class="label">
									<span>Account Name:</span>
								</td>
								<td>
									<asp:Label ID="AccountNameLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Bind("AccountName") %>'></asp:Label>
								</td>
							</tr>
							<tr>
								<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
									width: 125px">
									Account Number:
								</td>
								<td>
									<asp:Label ID="AccountNumLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Bind("AccountNum") %>'></asp:Label>
								</td>
							</tr>
							<tr>
								<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
									width: 125px">
									Contract Number:
								</td>
								<td>
									<asp:Label ID="ContractNumLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Bind("ContractNum") %>'></asp:Label>
								</td>
							</tr>
							<tr>
								<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
									width: 125px">
									Referred By:
								</td>
								<td>
									<asp:Label ID="ReferredByLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Bind("ReferredBy") %>'></asp:Label>
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
								<td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
									State:
								</td>
								<td style="width: 275px">
									<asp:Label ID="StateLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Bind("State") %>'></asp:Label>
								</td>
								<td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
									width: 128px;">
									Fax:
								</td>
								<td style="width: 275px">
									<asp:Label ID="Fax1Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
										font-size: small" Text='<%# Me.FormatPhone(If(Convert.IsDBNull(Eval("Fax1")), String.Empty, "Fax1"))%>'></asp:Label>
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
									Website:
								</td>
								<td style="width: 275px">
									<asp:HyperLink ID="WebsiteLabel" runat="server" Text='<%# Bind("Website") %>' NavigateUrl='<%# Eval("Website") %>'
										Target="_blank"></asp:HyperLink>
								</td>
							</tr>
						</table>
						<br />
						<span style="font-weight: bold; font-size: medium; color: #ED8701">Compliance Options</span><br />
						<br />
						<table>
							<tr>
								<td class="tdtable">
									Class 7-8 BACT Replacement Schedule:
								</td>
								<td class="">
									<asp:Label ID="sds_lbl_Op_IDClass78BACTReplacementSchedule" runat="server" Text='<%# Bind("Class78BACTReplacementSchedule") %>' />
							</tr>
						</table>
						<br />
						<asp:Button ID="EditButton0" runat="server" CausesValidation="False" CommandName="Edit"
							Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="Edit" />
						&nbsp;
                        <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
							OnClientClick="return confirm('Are you certain you want to delete this Account?')"
							Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="Delete" Visible="False" />
						&nbsp;<asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
							Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="New"
							Visible="False" />
					</ItemTemplate>
				</asp:FormView>
			</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
		<tr>
			<td>
				<telerik:radtabstrip id="tbs_AccountDetails" runat="server" multipageid="rmp_AccountDetails" selectedindex="0">
                    <Tabs>
                        <telerik:RadTab runat="server" Text="Contacts" Selected="True"></telerik:RadTab>
                        <telerik:RadTab runat="server" PageViewID="rpv_Notes" Text="Notes"></telerik:RadTab>
                        <telerik:RadTab runat="server" PageViewID="rpv_TerminalDocuments" Text="Terminal Documents"></telerik:RadTab>
                    </Tabs>
                </telerik:radtabstrip>
				<telerik:radmultipage id="rmp_AccountDetails" runat="server" selectedindex="0" width="800px">
            		<!-- RPV_Contacts -->
                    <telerik:RadPageView ID="rpv_Contacts" runat="server">
                    	<table cellpadding="0" cellspacing="0" style="border: 1px solid #666666; background-color: #EEEEEE; width: 660px;">
                           	<tr>
                           		<td>
            						<telerik:RadGrid ID="RadGrid2" runat="server" AllowAutomaticUpdates="True" DataSourceID="sds_rpv_Contact" GridLines="None" AllowSorting="True">
                     					<MasterTableView AutoGenerateColumns="False" CommandItemDisplay="Top" DataKeyNames="IDProfileContact" DataSourceID="sds_rpv_Contact" EditMode="PopUp">
                                          	<Columns>
                                               <telerik:GridBoundColumn DataField="LastName" HeaderText="Last Name" SortExpression="LastName" UniqueName="LastName"></telerik:GridBoundColumn>
                                               <telerik:GridBoundColumn DataField="First Name" HeaderText="First Name" SortExpression="FirstName" UniqueName="FirstName"></telerik:GridBoundColumn>
                                               <telerik:GridBoundColumn DataField="Title" HeaderText="Title" SortExpression="Title" UniqueName="Title"></telerik:GridBoundColumn>
                                               <telerik:GridBoundColumn DataField="Email" HeaderText="Email" SortExpression="Email" UniqueName="Email"></telerik:GridBoundColumn>
                                               <telerik:GridBoundColumn DataField="Telephone1" HeaderText="Telephone" SortExpression="Telephone1" UniqueName="Telephone1"></telerik:GridBoundColumn>
                                               <telerik:GridBoundColumn DataField="Ext1" HeaderText="Ext" SortExpression="Ext1" UniqueName="Ext1"></telerik:GridBoundColumn>
                        					</Columns>
                              				<CommandItemSettings AddNewRecordImageUrl="/images/1pix.gif" AddNewRecordText="" />
                                            	<EditFormSettings EditFormType="Template" PopUpSettings-Modal="true">
                                                	<PopUpSettings Modal="True" Width="725px" />
                                                    <FormTemplate>
                                                        <table cellpadding="6" cellspacing="0" class="style1" style="text-align: left">
                                                            <tr>
                                                                <td>
                                                                    <span style="font-weight: bold; font-size: medium; color: #ED8701">Contact</span><br />
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td style="font-size:small; font-weight:bold; color:#2C7500; text-align:right; width:100px">
                                                                                Contact Type:
                                                                            </td>
                                                                            <td>&nbsp;</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
                                                                        width: 100px">
                                                                                Title:
                                                                            </td>
                                                                            <td>&nbsp;
                                                                                
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
                                                                        width: 100px">
                                                                                First Name:
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="FirstNameTextBox" runat="server" 
                                                                                    Text='<%# Bind("FirstName") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
                                                                        width: 100px">
                                                                                Last Name:
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="LastNameTextBox" runat="server" 
                                                                                    Text='<%# Bind("LastName") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;
                                                                        width: 100px">
                                                                                MI:
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="MITextBox" runat="server" MaxLength="2" 
                                                                                    Text='<%# Bind("MI") %>' Width="50px" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <br />
                                                                    <span style="font-weight: bold; font-size: medium; color: #ED8701">Contact 
                                                                    Details</span><br />
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
                                                                                Address:
                                                                            </td>
                                                                            <td style="width: 275px">
                                                                                <asp:TextBox ID="Address1TextBox" runat="server" Text='<%# Bind("Address1") %>' 
                                                                                    Width="200px" />
                                                                            </td>
                                                                            <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;">
                                                                                Telephone:
                                                                            </td>
                                                                            <td style="width: 275px">
                                                                                <table cellpadding="0" cellspacing="0">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <telerik:RadMaskedTextBox ID="Telephone1TextBox" runat="server" 
                                                                                                Mask="(###) ###-####" Text='<%# Bind("Telephone1") %>'>
                                                                                            </telerik:RadMaskedTextBox>
                                                                                        </td>
                                                                                        <td style="width: 40px; font-weight: bold; font-size: small; color: #2C7500; text-align: right;">
                                                                                            Ext:
                                                                                        </td>
                                                                                        <td style="padding-left: 2px">
                                                                                            <asp:TextBox ID="Ext1TextBox" runat="server" Text='<%# Bind("Ext1") %>' 
                                                                                                Width="50px" />
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
                                                                                <asp:TextBox ID="Address2TextBox" runat="server" Text='<%# Bind("Address2") %>' 
                                                                                    Width="200px" />
                                                                            </td>
                                                                            <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right">
                                                                                Telephone:
                                                                            </td>
                                                                            <td style="width: 275px">
                                                                                <table cellpadding="0" cellspacing="0">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <telerik:RadMaskedTextBox ID="Telephone2TextBox" runat="server" 
                                                                                                Mask="(###) ###-####" Text='<%# Bind("Telephone2") %>'>
                                                                                            </telerik:RadMaskedTextBox>
                                                                                        </td>
                                                                                        <td style="width: 40px; font-weight: bold; font-size: small; color: #2C7500; text-align: right">
                                                                                            Ext:
                                                                                        </td>
                                                                                        <td style="padding-left: 2px">
                                                                                            <asp:TextBox ID="Ext2TextBox" runat="server" Text='<%# Bind("Ext2") %>' 
                                                                                                Width="50px" />
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
                                                                            <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right">
                                                                                Telephone:
                                                                            </td>
                                                                            <td style="width: 275px">
                                                                                <table cellpadding="0" cellspacing="0">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <telerik:RadMaskedTextBox ID="Telephone3TextBox" runat="server" 
                                                                                                Mask="(###) ###-####" Text='<%# Bind("Telephone3") %>'>
                                                                                            </telerik:RadMaskedTextBox>
                                                                                        </td>
                                                                                        <td style="width: 40px; font-weight: bold; font-size: small; color: #2C7500; text-align: right">
                                                                                            Ext:
                                                                                        </td>
                                                                                        <td style="padding-left: 2px">
                                                                                            <asp:TextBox ID="Ext3TextBox" runat="server" Text='<%# Bind("Ext3") %>' 
                                                                                                Width="50px" />
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
                                                                            <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right">
                                                                                Cell Phone:
                                                                            </td>
                                                                            <td style="width: 275px">
                                                                                <telerik:RadMaskedTextBox ID="CellPhoneTextBox" runat="server" 
                                                                                    Mask="(###) ###-####" Text='<%# Bind("CellPhone") %>'>
                                                                                </telerik:RadMaskedTextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">
                                                                                Zip:
                                                                            </td>
                                                                            <td style="width: 275px">
                                                                                <asp:TextBox ID="ZipTextBox" runat="server" Text='<%# Bind("Zip") %>' />
                                                                            </td>
                                                                            <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right">
                                                                                Fax:
                                                                            </td>
                                                                            <td style="width: 275px">
                                                                                <telerik:RadMaskedTextBox ID="Fax1TextBox" runat="server" Mask="(###) ###-####" 
                                                                                    Text='<%# Bind("Fax1") %>'>
                                                                                </telerik:RadMaskedTextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">&nbsp;
                                                                                
                                                                            </td>
                                                                            <td style="width: 275px">&nbsp;
                                                                                
                                                                            </td>
                                                                            <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right">
                                                                                Email:
                                                                            </td>
                                                                            <td style="width: 275px">
                                                                                <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <br />
                                                                    <b><span style="font-weight: bold; font-size: medium; color: #ED8701">Notes</span></b><br />
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td style="width: 75px">&nbsp;
                                                                                
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="TextBox1" runat="server" Height="100px" 
                                                                                    Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="650px" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <br />
                                                                    <b><span style="font-weight: bold; font-size: medium; color: #ED8701">Internal 
                                                                    Notes</span></b><br />
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td style="width: 75px">&nbsp;
                                                                                
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="NotesCFTextBox" runat="server" Height="100px" 
                                                                                    Text='<%# Bind("NotesCF") %>' TextMode="MultiLine" Width="650px" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <table style="width: 100%">
                                                                        <tr>
                                                                            <td align="right">
                                                                                <asp:Button ID="Button1" runat="server" 
                                                                                    CommandName='<%# Iif (TypeOf Container is GridEditFormInsertItem, "PerformInsert", "Update") %>' 
                                                                                    Text='<%# Iif (TypeOf Container is GridEditFormInsertItem, "Insert", "Update") %>' />
                                                                                &nbsp;
                                                                                <asp:Button ID="Button2" runat="server" CausesValidation="False" 
                                                                                    CommandName="Cancel" Text="Cancel" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </FormTemplate>
                         						</EditFormSettings>
                                            </MasterTableView>
                                            <ClientSettings>
                                                <ClientEvents OnRowDblClick="RowDblClick" />
                                                <Selecting AllowRowSelect="True" />
                                                <ClientEvents OnPopUpShowing="PopUpShowing" />
                                            </ClientSettings>
                                        </telerik:RadGrid>
                                                            
                                    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"> </telerik:RadAjaxManager>
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                    <br />
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>
                    
                    <!-- RPV_Notes -->
                    <telerik:RadPageView ID="rpv_Notes" runat="server" Width="100%">
                        <table cellpadding="0" cellspacing="0" style="border: 1px solid #666666; background-color: #EEEEEE;">
                            <tr>
                                <td>
                                    <asp:FormView ID="FormView2" runat="server" DataKeyNames="IDProfileAccount" DataSourceID="sdsfvAccountDetailsNotes">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="NotesTextBox" runat="server" Height="250px" Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="500px" /><br />
                                            <br />
                                            <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />&#160;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" /></EditItemTemplate>
                                        <InsertItemTemplate></InsertItemTemplate>
                                        <ItemTemplate>&#160;
                                        	<div class="divlblScrollText">
                                                <asp:Label ID="NotesLabel" runat="server" Text='<%# Eval("Notes").ToString().Replace(Environment.NewLine,"<br />") %>' Style="font-size: small" /></div>
                                            <br />
                                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                        </ItemTemplate>
                                    </asp:FormView>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>
                    
                    <!-- RPV_TerminalDocuments -->
                    <telerik:RadPageView ID="rpv_TerminalDocuments" runat="server" Width="100%">
            			<telerik:RadGrid ID="rgd_TerminalDocuments" runat="server" AllowAutomaticDeletes="False" AllowAutomaticInserts="False"  AllowAutomaticUpdates="False" AutoGenerateDeleteColumn="False" AutoGenerateEditColumn="False" DataSourceID="sds_TerminalDocuments" GridLines="None" ShowFooter="True" CssClass="radgrid">
               				<mastertableview AutoGenerateColumns="false" DataKeyNames="IDFile" DataSourceID="sds_TerminalDocuments">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Title" DataType="System.String" HeaderText="Title" SortExpression="Title" UniqueName="TerminalTitle" ></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DocumentType" DataType="System.String" HeaderText="Document Type" SortExpression="DocumentType" UniqueName="TerminalDocumentType"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="FileName" DataType="System.String" HeaderText="FileName" SortExpression="FileName" UniqueName="TerminalFileName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="IDProfileTerminal" DataType="System.String" HeaderText="IDTerminal" SortExpression="IDTerminal" UniqueName="TerminalID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TerminalName" DataType="System.String" HeaderText="TerminalName" SortExpression="TerminalName" UniqueName="TerminalName"></telerik:GridBoundColumn>
                                    <telerik:GridHyperLinkColumn FooterText="" DataTextFormatString="View File" DataNavigateUrlFields="FilePath,FileName" UniqueName="ViewTerminalDocument" DataNavigateUrlFormatString="{0}/{1}" HeaderText="" DataTextField="FileName" Target="_blank"></telerik:GridHyperLinkColumn>
                                </Columns>
                			</mastertableview>
            			</telerik:RadGrid>
       				</telerik:RadPageView> 
                </telerik:radmultipage>
			</td>
		</tr>
	</table>
	<br />
	<br />
    
    <!-- Contact (sds_rpv_Contact) -->
    <asp:SqlDataSource ID="sds_rpv_Contact" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
      SelectCommand="
        SELECT [IDProfileContact], [IDProfileAccount], [UserID], [IDModifiedUser], [EnterDate], [ModifiedDate], [LastName], [FirstName], [MI], [Title], 
          [Address1], [Address2], [City], [State], [County], [Country], [Zip], [MailMergeCode], [Telephone1], [Ext1], [Telephone2], [Ext2], [Telephone3], 
          [Ext3], [CellPhone], [Fax1], [Fax2], [EMailMergeCode], [WebSite], [Notes], [NotesCF], [UserName], [Email], [PasswordQuestion] 
        FROM [CFV_Profile_Contact] 
        WHERE ([IDProfileAccount] = @IDProfileAccount)"
      UpdateCommand="
      	UPDATE [CF_Profile_Contact] 
        SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate, [LastName] = @LastName, [FirstName] = @FirstName, [MI] = @MI, 
          [Title] = @Title, [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [State] = @State, [County] = @County, [Country] = @Country, 
          [Zip] = @Zip, [MailMergeCode] = @MailMergeCode, [Telephone1] = @Telephone1, [Ext1] = @Ext1, [Telephone2] = @Telephone2, [Ext2] = @Ext2, 
          [Telephone3] = @Telephone3, [Ext3] = @Ext3, [CellPhone] = @CellPhone, [Fax1] = @Fax1, [Fax2] = @Fax2, [EMailMergeCode] = @EMailMergeCode, 
          [WebSite] = @WebSite, [Notes] = @Notes, [NotesCF] = @NotesCF
        WHERE [IDProfileContact] = @IDProfileContact"
      DeleteCommand="
      	DELETE FROM [CF_Profile_Contact] 
        WHERE [UserID] = @UserID">
        <SelectParameters>
            <asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="UserID" Type="Object" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="IDProfileContact" Type="Int32" />
            <asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
            <asp:Parameter Name="ModifiedDate" Type="DateTime" />
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
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="UserID" Type="Object" />
            <asp:Parameter Name="IDModifiedUser" Type="Object" />
            <asp:Parameter Name="EnterDate" Type="DateTime" />
            <asp:Parameter Name="ModifiedDate" Type="DateTime" />
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
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="PasswordQuestion" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    
    <!-- Account Details (sdsfvAccountDetails) -->
	<asp:SqlDataSource ID="sdsfvAccountDetails" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT [IDProfileAccount], [AccountName], [AccountNum], [ContractNum], [ReferredBy], [Address1], [Address2], [City], [State], [County], [Country], 
          [Zip], [MailMergeCode], [Telephone1], [Ext1], [Telephone2], [Ext2], [Telephone3], [Ext3], [Fax1], [Fax2], [WebSite], [IDClass78BACTReplacementSchedule], 
          [dbo].[GetIDOptionListRecordValue](IDClass78BACTReplacementSchedule) AS [Class78BACTReplacementSchedule] 
		FROM [CF_Profile_Account] 
        WHERE ([IDProfileAccount] = @IDProfileAccount)" 
      UpdateCommand="
      	UPDATE [CF_Profile_Account] 
        SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate,[AccountName] = @AccountName, [AccountNum] = @AccountNum, [ContractNum] = @ContractNum, 
          [ReferredBy] = @ReferredBy,  [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [State] = @State, [County] = @County, [Country] = @Country, 
          [Zip] = @Zip, [MailMergeCode] = @MailMergeCode, [Telephone1] = @Telephone1, [Ext1] = @Ext1, [Telephone2] = @Telephone2, [Ext2] = @Ext2, [Telephone3] = @Telephone3, 
          [Ext3] = @Ext3, [Fax1] = @Fax1, [Fax2] = @Fax2, [WebSite] = @WebSite, [IDClass78BACTReplacementSchedule] = @IDClass78BACTReplacementSchedule 
        WHERE [IDProfileAccount] = @IDProfileAccount"
	  DeleteCommand="
      	DELETE FROM [CF_Profile_Account] 
        WHERE [IDProfileAccount] = @IDProfileAccount">
        <SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDProfileAccount" Type="Int32" />
		</DeleteParameters>
		<UpdateParameters>
			<asp:Parameter Name="AccountName" Type="String" />
			<asp:Parameter Name="AccountNum" Type="String" />
			<asp:Parameter Name="ContractNum" Type="String" />
			<asp:Parameter Name="ReferredBy" Type="String" />
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
			<asp:Parameter Name="WebSite" Type="String" />
			<asp:Parameter Name="IDClass78BACTReplacementSchedule" Type="Int32" />
			<asp:Parameter Name="IDProfileAccount" Type="Int32" />
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:Parameter Name="ModifiedDate" Type="DateTime" />
		</UpdateParameters>
		<InsertParameters></InsertParameters>
	</asp:SqlDataSource>

	<!-- Account Details Notes (sdsfvAccountDetailsNotes) -->
	<asp:SqlDataSource ID="sdsfvAccountDetailsNotes" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
        SELECT [IDProfileAccount], [Notes] 
        FROM [CF_Profile_Account] 
        WHERE ([IDProfileAccount] = @IDProfileAccount)"
	  UpdateCommand="
      	UPDATE [CF_Profile_Account] 
        SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate,[Notes] = @Notes 
        WHERE [IDProfileAccount] = @IDProfileAccount">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="Notes" Type="String" />
			<asp:Parameter Name="IDProfileAccount" Type="Int32" />
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:Parameter Name="ModifiedDate" Type="DateTime" />
		</UpdateParameters>
		<InsertParameters></InsertParameters>
	</asp:SqlDataSource>
    
    <!-- Class 7-8 BACT Replacement Schedule (sds_ddl_Op_IDClass78BACTReplacementSchedule) -->
	<asp:SqlDataSource ID="sds_ddl_Op_IDClass78BACTReplacementSchedule" runat="server"
	  ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
      SelectCommand="
      	SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] 
        FROM [CF_Option_List] 
        WHERE ([OptionName] = 'Class78BACTReplacementSchedule') 
        ORDER BY [DisplayValue]">
	</asp:SqlDataSource>
    
  	<!-- DataSource: Terminal Documents (sds_TerminalDocuments) -->
    <asp:SqlDataSource ID="sds_TerminalDocuments" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT F.*, T.TerminalName, O.DisplayValue AS DocumentType, P.PermissionLevel
        FROM [CF_Files] F
        LEFT JOIN CF_Profile_Terminal T ON F.IDProfileTerminal = T.IDProfileTerminal
        LEFT JOIN CF_Option_List O ON F.IDDocumentType = O.IDOptionList
        LEFT JOIN CF_Profile_Contact C ON C.IDProfileAccount = F.IDProfileAccount
        LEFT JOIN CF_UserTerminals P ON P.UserID = C.UserID AND P.IDProfileTerminal = T.IDProfileTerminal
        WHERE F.[IDProfileAccount] = @IDProfileAccount
        AND F.IDProfileTerminal IS NOT NULL
        AND RTRIM(ISNULL(O.OptionName, 'DocumentType')) = 'DocumentType' 
        AND C.IDProfileContact = @IDProfileContact
        AND P.PermissionLevel LIKE '[AB]' 
        ORDER BY T.IDProfileTerminal ASC, DocumentType, F.Title">
		<SelectParameters>
			<asp:SessionParameter Name="IDProfileAccount" SessionField="IDProfileAccount" />
            <asp:SessionParameter Name="IDProfileContact" SessionField="IDProfileContact" />
        </SelectParameters>
	</asp:SqlDataSource>
</asp:Content>

