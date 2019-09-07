<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="account_details.aspx.vb" Inherits="cleanfleets_fms.account_details1" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Collections.Generic" %>
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
	<style>
		.moduleTableCell {
			text-align: right;
			vertical-align: top;
			padding: 2px;
		}
		
		.defaultModuleTableCell {
			text-align: right;
			padding: 2px;	
		}
		
		.contentsList {
			/*list-style-type: none;*/
			margin: 0px;
		}
		
		.moduleRow {
			min-height:	25px;
		}
		
		.topAlign {
			vertical-align:top;
			padding: 2px;
		}
	
	</style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">

	<table cellpadding="0" cellspacing="0" style="width: 100%">
		<tr><td>
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="IDProfileAccount" DataSourceID="sdsfvAccountDetails" HorizontalAlign="Left" Width="800px">
                <EditItemTemplate>
                    <!-- Account Section -->
                    <span style="font-weight: bold; font-size: medium; color: #ED8701">Account</span><br />
                    <br />
                    <table width="100%">
                        <tr>
                            <td style="width: 120px" class="tdtable">Account Name:</td>
                            <td><asp:TextBox ID="AccountNameTextBox" runat="server" Text='<%# Bind("AccountName") %>' Height="22px" Width="250px" /></td>
                        </tr>
                        <tr>
                            <td style="width: 120px" class="tdtable">Account Number:</td>
                            <td><asp:TextBox ID="AccountNumTextBox" runat="server" Text='<%# Bind("AccountNum") %>' /></td>
                        </tr>
                        <tr>
                            <td style="width: 120px" class="tdtable">Contract Number:</td>
                            <td><asp:TextBox ID="ContractNumTextBox" runat="server" Text='<%# Bind("ContractNum") %>' /></td>
                        </tr>
                        <tr>
                            <td style="width: 120px" class="tdtable">Referred By:</td>
                            <td><asp:TextBox ID="ReferredByTextBox" runat="server" Text='<%# Bind("ReferredBy") %>' /></td>
                        </tr>
                    </table>
                    <br />
                    
                    <!-- Details Section -->
                    <span style="font-weight: bold; font-size: medium; color: #ED8701">Details</span><br />
                    <br />
                    <table width="100%">
                        <tr>
                            <td class="tdtable">Address:</td>
                            <td style="width: 275px"><asp:TextBox ID="Address1TextBox" runat="server" Text='<%# Bind("Address1") %>' Width="200px" /></td>
                            <td class="tdtable">Telephone:</td>
                            <td style="width: 275px">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td><telerik:radmaskedtextbox id="Telephone1TextBox" runat="server" text='<%# Bind("Telephone1") %>' mask="(###) ###-####"></telerik:radmaskedtextbox></td>
                                        <td style="width: 40px; font-weight: bold; font-size: small; color: #2C7500; text-align: right;">Ext:</td>
                                        <td style="padding-left: 2px"><asp:TextBox ID="Ext1TextBox" runat="server" Text='<%# Bind("Ext1") %>' Width="50px" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdtable">Address:</td>
                            <td style="width: 275px"><asp:TextBox ID="Address2TextBox" runat="server" Text='<%# Bind("Address2") %>' Width="200px" /></td>
                            <td class="tdtable">Telephone:</td>
                            <td style="width: 275px">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td><telerik:radmaskedtextbox id="Telephone2TextBox" runat="server" text='<%# Bind("Telephone2") %>' mask="(###) ###-####"></telerik:radmaskedtextbox></td>
                                        <td style="width: 40px; font-weight: bold; font-size: small; color: #2C7500; text-align: right">Ext:</td>
                                        <td style="padding-left: 2px"><asp:TextBox ID="Ext2TextBox" runat="server" Text='<%# Bind("Ext2") %>' Width="50px" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdtable">City:</td>
                            <td style="width: 275px"><asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' /></td>
                            <td class="tdtable">Telephone:</td>
                            <td style="width: 275px">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td><telerik:radmaskedtextbox id="Telephone3TextBox" runat="server" text='<%# Bind("Telephone3") %>' mask="(###) ###-####"></telerik:radmaskedtextbox></td>
                                        <td style="width: 40px; font-weight: bold; font-size: small; color: #2C7500; text-align: right">Ext:</td>
                                        <td style="padding-left: 2px"><asp:TextBox ID="Ext3TextBox" runat="server" Text='<%# Bind("Ext3") %>' Width="50px" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdtable">State:</td>
                            <td style="width: 275px"><asp:TextBox ID="StateTextBox" runat="server" Text='<%# Bind("State") %>' /></td>
                            <td class="tdtable">Fax:</td>
                            <td style="width: 275px"><telerik:radmaskedtextbox id="Fax1TextBox" runat="server" mask="(###) ###-####" text='<%# Bind("Fax1") %>'></telerik:radmaskedtextbox></td>
                        </tr>
                        <tr>
                            <td class="tdtable">Zip:</td>
                            <td style="width: 275px"><asp:TextBox ID="ZipTextBox" runat="server" Text='<%# Bind("Zip") %>' /></td>
                            <td class="tdtable">Website:</td>
                            <td style="width: 275px"><asp:TextBox ID="WebsiteTextBox" runat="server" Text='<%# Bind("Website") %>' /></td>
                        </tr>
                    </table>
                    <br />
					
					<!-- Default Modules -->
					
					<span style="font-weight: bold; font-size: medium; color: #ED8701">Default Modules</span><br />	
					<asp:PlaceHolder ID="DefaultModulesEdit" runat="server"></asp:PlaceHolder>
					
<!--					<asp:CheckBoxList ID="chk_DefaultModules" runat="server" RepeatLayout="Table" DataSourceID="src_DefaultModules" DataTextField="DisplayValue">
						<asp:ListItem></asp:ListItem>
					</asp:CheckBoxList>-->
					<br/>
					
					<!-- End Default Modules -->
					
					<!-- Custom Modules -->
						<span style="font-weight: bold; font-size: medium; color: #ED8701">Custom Modules</span><br />
						<asp:PlaceHolder ID="CustomModulesEdit" runat="server"></asp:PlaceHolder>
						<asp:Button ID="createModuleBtn" Text="Create Module" OnClick="createModuleBtn_Click" runat="server"></asp:Button>
						<br /><br />
					
					<!-- End Custom Modules -->
					
					
					
                    
                    <!-- Compliance Options Section -->
                    <span style="font-weight: bold; font-size: medium; color: #ED8701">Compliance Options</span><br />
                    <br />
                    <table>
                        <tr>
                            <td class="tdtable">Class 7-8 BACT Replacement Schedule:</td>
                            <td class="tdtable">
                                <asp:DropDownList ID="ddl_IDClass78BACTReplacementSchedule" runat="server" DataSourceID="sds_ddl_Op_IDClass78BACTReplacementSchedule" DataTextField="DisplayValue" DataValueField="IDOptionList" SelectedValue='<%# Bind("IDClass78BACTReplacementSchedule") %>' AppendDataBoundItems="true">
                                    <asp:ListItem Text="" Value="0" />
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <!-- PSIP Notifications Section -->
                    <span style="font-weight: bold; font-size: medium; color: #ED8701">PSIP Notification Options</span><br />
                    <br />
                    <table>
                        <tr>
                            <td class="defaultModuleTableCell">Receive Notification Emails:</td>
                            <td class="defaultModuleTableCell"><asp:Checkbox ID="cb_PSIPNotification" runat="server" Checked='<%# Bind("PSIPNotificationEmail") %>'></asp:Checkbox></td>
                            <td class="defaultModuleTableCell">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="defaultModuleTableCell">Notifying Month:</td>
                            <td class="defaultModuleTableCell">
								<asp:DropDownList ID="ddl_PSIPMonth" runat="server" DataValueField="value" SelectedValue='<%# Bind("PSIPMonth") %>'>
									<asp:ListItem Text="Select a month" Value="None"></asp:ListItem>
									<asp:ListItem Text="January" Value="January"></asp:ListItem>
									<asp:ListItem Text="February" Value="February"></asp:ListItem>
									<asp:ListItem Text="March" Value="March"></asp:ListItem>
									<asp:ListItem Text="April" Value="April"></asp:ListItem>
									<asp:ListItem Text="May" Value="May"></asp:ListItem>
									<asp:ListItem Text="June" Value="June"></asp:ListItem>
									<asp:ListItem Text="July" Value="July"></asp:ListItem>
									<asp:ListItem Text="August" Value="August"></asp:ListItem>
									<asp:ListItem Text="September" Value="September"></asp:ListItem>
									<asp:ListItem Text="October" Value="October"></asp:ListItem>
									<asp:ListItem Text="November" Value="November"></asp:ListItem>
									<asp:ListItem Text="December" Value="December"></asp:ListItem>
								</asp:DropDownList>
                            </td>
                            <td class="defaultModuleTableCell">
								<asp:CustomValidator ID="cv_ddl_PSIPMonth" runat="server" ErrorMessage="Please select a month" ControlToValidate="ddl_PSIPMonth" ClientValidationFunction="validatePSIPMonth" ControlToReference="cb_PSIPNotification" />
                                <%--<asp:RequiredFieldValidator ID="rfv_ddl_PSIPMonth" runat="server" ControlToValidate="ddl_PSIPMonth" InitialValue="None" Display="Dynamic" Enabled='<%# IIf(Eval("PSIPNotificationEmail") = 1, True, False) %>' ErrorMessage="Please select a month" />--%>
                            </td>
                        </tr>
                    </table>
                    <br />
                    
                    <asp:Button ID="UpdateButton0" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />&nbsp;
                    <asp:Button ID="UpdateCancelButton0" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    Address1: 		<asp:TextBox ID="Address1TextBox0" runat="server" Text='<%# Bind("Address1") %>' /> <br />
                    Address2: 		<asp:TextBox ID="Address2TextBox0" runat="server" Text='<%# Bind("Address2") %>' /><br />
                    City: 			<asp:TextBox ID="CityTextBox0" runat="server" Text='<%# Bind("City") %>' /><br />
                    State: 			<asp:TextBox ID="StateTextBox0" runat="server" Text='<%# Bind("State") %>' /><br />
                    County: 		<asp:TextBox ID="CountyTextBox" runat="server" Text='<%# Bind("County") %>' /><br />
                    Country: 		<asp:TextBox ID="CountryTextBox" runat="server" Text='<%# Bind("Country") %>' /><br />
                    Zip: 			<asp:TextBox ID="ZipTextBox0" runat="server" Text='<%# Bind("Zip") %>' /><br />
                    MailMergeCode: 	<asp:TextBox ID="MailMergeCodeTextBox0" runat="server" Text='<%# Bind("MailMergeCode") %>' /> <br />
                    Telephone1: 	<asp:TextBox ID="Telephone1TextBox0" runat="server" Text='<%# Bind("Telephone1") %>' /><br />
                    Ext1: 			<asp:TextBox ID="Ext1TextBox0" runat="server" Text='<%# Bind("Ext1") %>' /><br />
                    Telephone2: 	<asp:TextBox ID="Telephone2TextBox0" runat="server" Text='<%# Bind("Telephone2") %>' /><br />
                    Ext2: 			<asp:TextBox ID="Ext2TextBox0" runat="server" Text='<%# Bind("Ext2") %>' /><br />
                    Telephone3: 	<asp:TextBox ID="Telephone3TextBox0" runat="server" Text='<%# Bind("Telephone3") %>' /><br />
                    Ext3: 			<asp:TextBox ID="Ext3TextBox0" runat="server" Text='<%# Bind("Ext3") %>' /><br />
                    CellPhone: 		<asp:TextBox ID="CellPhoneTextBox0" runat="server" Text='<%# Bind("CellPhone") %>' /><br />
                    Fax1: 			<asp:TextBox ID="Fax1TextBox0" runat="server" Text='<%# Bind("Fax1") %>' /><br />
                    Fax2: 			<asp:TextBox ID="Fax2TextBox" runat="server" Text='<%# Bind("Fax2") %>' /><br />
                    WebSite: 		<asp:TextBox ID="WebSiteTextBox0" runat="server" Text='<%# Bind("WebSite") %>' /><br />
                    Notes:			<asp:TextBox ID="NotesTextBox0" runat="server" Text='<%# Bind("Notes") %>' /><br />
                    NotesCF: 		<asp:TextBox ID="NotesCFTextBox0" runat="server" Text='<%# Bind("NotesCF") %>' /> <br />
                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />&nbsp;
                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </InsertItemTemplate>
                <ItemTemplate>
				
				

				
                    <!-- Account Section -->
                    <span style="font-weight: bold; font-size: medium; color: #ED8701">
                        Account
                        <asp:Label ID="lbl_IDProfileAccount" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("IDProfileAccount") %>' Visible="False"></asp:Label>
                    </span>
                    <br />
                    <br />
                    <table width="100%">
                        <tr>
                            <td style="width: 115px" class="tdtable">Account Name:</td>
                            <td><asp:Label ID="AccountNameLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("AccountName") %>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 115px" class="tdtable">Account Number:</td>
                            <td><asp:Label ID="AccountNumLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("AccountNum") %>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 115px" class="tdtable">Contract Number:</td>
                            <td><asp:Label ID="ContractNumLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("ContractNum") %>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 115px" class="tdtable">Referred By:</td>
                            <td><asp:Label ID="ReferredByLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("ReferredBy") %>'></asp:Label></td>
                        </tr>
                    </table>
                    <br />
                    
                    <!-- Details Section -->
                    <span style="font-weight: bold; font-size: medium; color: #ED8701">Details</span><br />
                    <br />
                    <table width="100%">
                        <tr>
                            <td class="tdtable">Address:</td>
                            <td style="width: 275px"><asp:Label ID="Address1Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("Address1") %>'></asp:Label></td>
                            <td class="tdtable">Telephone:</td>
                            <td style="width: 275px">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td><asp:Label ID="Telephone1Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Me.FormatPhone(If(Convert.IsDBNull(Eval("Telephone1")), String.Empty, "Telephone1"))%>'></asp:Label></td>
                                        <td style="color: #2C7500; width: 40px; font-size: small; font-weight: bold; text-align: right;">
                                            <span style="color: #2C7500; font-size: small; font-weight: 700">Ext:</span>
                                        </td>
                                        <td style="padding-left: 2px"><asp:Label ID="Ext1Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("Ext1") %>'></asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdtable">Address:</td>
                            <td style="width: 275px"><asp:Label ID="Address2Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("Address2") %>'></asp:Label></td>
                            <td class="tdtable">Telephone:</td>
                            <td style="width: 275px">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td><asp:Label ID="Telephone2Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Me.FormatPhone(If(Convert.IsDBNull(Eval("Telephone2")), String.Empty, "Telephone2"))%>'></asp:Label></td>
                                        <td style="width: 40px; color: #2C7500; font-size: small; font-weight: bold; text-align: right;">
                                            <span style="color: #2C7500; font-size: small; font-weight: 700">Ext:</span>
                                        </td>
                                        <td style="padding-left: 2px">
                                            <asp:Label ID="Ext2Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("Ext2") %>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdtable">City:</td>
                            <td style="width: 275px"><asp:Label ID="CityLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("City") %>'></asp:Label></td>
                            <td class="tdtable">Telephone:</td>
                            <td style="width: 275px">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td><asp:Label ID="Telephone3Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Me.FormatPhone(If(Convert.IsDBNull(Eval("Telephone3")), String.Empty, "Telephone3"))%>'></asp:Label></td>
                                        <td style="width: 40px; color: #2C7500; font-size: small; font-weight: bold; text-align: right;">
                                            <span style="color: #2C7500; font-size: small; font-weight: 700">Ext:</span>
                                        </td>
                                        <td style="padding-left: 2px"><asp:Label ID="Ext3Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("Ext3") %>'></asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdtable">State:</td>
                            <td style="width: 275px"><asp:Label ID="StateLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("State") %>'></asp:Label></td>
                            <td class="tdtable">Fax:</td>
                            <td style="width: 275px"><asp:Label ID="Fax1Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Me.FormatPhone(If(Convert.IsDBNull(Eval("Fax1")), String.Empty, "Fax1"))%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td class="tdtable">Zip:</td>
                            <td style="width: 275px"><asp:Label ID="ZipLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("Zip") %>'></asp:Label></td>
                            <td class="tdtable">Website:</td>
                            <td style="width: 275px"><asp:HyperLink ID="WebsiteLabel" runat="server" Text='<%# Bind("Website") %>' NavigateUrl='<%# Eval("Website") %>' Target="_blank"></asp:HyperLink></td>
                        </tr>
                    </table>
                    <br />
					
					
					<!-- Default Modules -->
						<span style="font-weight: bold; font-size: medium; color: #ED8701">Default Modules</span><br />
						<!-- created in createDefaultModuleView() in code behind file -->
						<asp:PlaceHolder ID="DefaultModulesView" runat="server"></asp:PlaceHolder>
						<br/>

				
				
					<!-- End Default Modules -->
					
					
					
					<!-- Custom Modules -->
						<span style="font-weight: bold; font-size: medium; color: #ED8701">Custom Modules</span><br />
						<!-- created in createCustomModuleView() in code behind file -->
						<asp:Label ID="CustomModuleMessage"></asp:Label>
						<asp:PlaceHolder ID="CustomModulesView" runat="server"></asp:PlaceHolder>
						<asp:Button ID="createModuleBtn" Text="Create Module" OnClick="createModuleBtn_Click" runat="server"></asp:Button>
						<br /><br />
					<!-- End Custom Modules -->
					
					
                    
                    <!-- Compliance Option Section -->
                    <span style="font-weight: bold; font-size: medium; color: #ED8701">Compliance Options</span><br />
                    <br />
                    <table>
                        <tr>
                            <td class="tdtable">Class 7-8 BACT Replacement Schedule:</td>
                            <td class=""><asp:Label ID="sds_lbl_Op_IDClass78BACTReplacementSchedule" runat="server" Text='<%# Bind("Class78BACTReplacementSchedule") %>' /></asp:Label></td>
                        </tr>
                    </table>
                    <br />
                    <!-- PSIP Notifications Section -->
                    <span style="font-weight: bold; font-size: medium; color: #ED8701">PSIP Notification Options</span><br />
                    <br />
                    <table>
                        <tr>
                            <td class="tdtable">Receive Notification Emails:</td>
                            <td class=""><asp:Label ID="PSIPNotificationLabel" runat="server" Text='<%# IIf(Eval("PSIPNotificationEmail") = 1, "Yes", "No") %>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td class="tdtable">Notifying Month:</td>
                            <td class=""><asp:Label ID="PSIPMonthLabel" runat="server" Text='<%# Eval("PSIPMonth") %>'></asp:Label></td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="EditButton0" runat="server" CausesValidation="False" CommandName="Edit" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="Edit" />&nbsp;
                    <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('Are you certain you want to delete this Account?')" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="Delete" />&nbsp;
                    <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="New" Visible="False" />
                </ItemTemplate>
            </asp:FormView>
		</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>
            <telerik:radtabstrip id="tbs_AccountDetails" runat="server" multipageid="rmp_AccountDetails" selectedindex="0">
                <Tabs>
                    <telerik:RadTab runat="server" Selected="True" Text="Contacts"></telerik:RadTab>
                    <telerik:RadTab runat="server" PageViewID="rpv_Notes" Text="Notes"></telerik:RadTab>
                    <telerik:RadTab runat="server" PageViewID="rpv_InternalNotes" Text="Internal Notes"></telerik:RadTab>
                    <telerik:RadTab runat="server" PageViewID="rpv_PublicDocuments" Text="Public Documents"></telerik:RadTab>
                    <telerik:RadTab runat="server" PageViewID="rpv_TerminalDocuments" Text="Terminal Documents"></telerik:RadTab>
                </Tabs>
            </telerik:radtabstrip>
            <telerik:radmultipage id="rmp_AccountDetails" runat="server" selectedindex="0" width="800px">
                <!-- rpv_Contacts -->
                <telerik:RadPageView ID="rpv_Contacts" runat="server">
                    <table cellpadding="0" cellspacing="0" style="border:1px solid #666666; background-color:#EEEEEE; width:660px;">
                        <tr>
                            <td>
                                <telerik:RadGrid ID="RadGrid2" runat="server" AllowAutomaticUpdates="True" DataSourceID="sds_rpv_Contact" GridLines="None" AllowSorting="True">
                                    <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="Top" DataKeyNames="IDProfileContact" DataSourceID="sds_rpv_Contact" EditMode="PopUp">
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="LastName" HeaderText="Last Name" SortExpression="LastName" UniqueName="LastName"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" UniqueName="FirstName"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Title" HeaderText="Title" SortExpression="Title" UniqueName="Title"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Email" HeaderText="Email" SortExpression="Email" UniqueName="Email"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Telephone1" HeaderText="Telephone" SortExpression="Telephone1" UniqueName="Telephone1"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Ext1" HeaderText="Ext" SortExpression="Ext1" UniqueName="Ext1"></telerik:GridBoundColumn>
                                            <telerik:GridHyperLinkColumn DataNavigateUrlFields="IDProfileContact" DataNavigateUrlFormatString="account_user_del.aspx?IDProfileContact={0}" DataTextField="IDProfileContact" DataTextFormatString="Delete" Text="Delete" UniqueName="Delete">
                                                <ItemStyle CssClass="radgrid" />
                                            </telerik:GridHyperLinkColumn>
                                        </Columns>
                                        <CommandItemSettings AddNewRecordImageUrl="/images/1pix.gif" AddNewRecordText="" />
                                        <EditFormSettings EditFormType="Template" PopUpSettings-Modal="true">
                                            <PopUpSettings Modal="True" Width="725px" />
                                            <FormTemplate>
                                                <style></style>
                                                <table cellpadding="6" cellspacing="0" class="style1" style="text-align: left">
                                                    <tr>
                                                        <td>
                                                            <span style="font-weight: bold; font-size: medium; color: #ED8701">Contact</span><br />
                                                            <table width="100%">
                                                                <tr>
                                                                    <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right; width: 100px">Contact Type:</td>
                                                                    <td>&nbsp;</td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right; width: 100px">Title:</td>
                                                                    <td>&nbsp;</td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right; width: 100px">First Name:</td>
                                                                    <td><asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' /></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right; width: 100px">Last Name:</td>
                                                                    <td><asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' /></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right; width: 100px">MI:</td>
                                                                    <td><asp:TextBox ID="MITextBox" runat="server" MaxLength="2" Text='<%# Bind("MI") %>' Width="50px" /></td>
                                                                </tr>
                                                            </table>
                                                            <br />
                                                            <span style="font-weight: bold; font-size: medium; color: #ED8701">Contact Details</span><br />
                                                            <table width="100%">
                                                                <tr>
                                                                    <td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">Address:</td>
                                                                    <td style="width: 275px"><asp:TextBox ID="Address1TextBox" runat="server" Text='<%# Bind("Address1") %>' Width="200px" /></td>
                                                                    <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right;">Telephone:</td>
                                                                    <td style="width: 275px">
                                                                        <table cellpadding="0" cellspacing="0">
                                                                            <tr>
                                                                                <td>
                                                                                    <telerik:RadMaskedTextBox ID="Telephone1TextBox" runat="server" Mask="(###) ###-####" Text='<%# Bind("Telephone1") %>'></telerik:RadMaskedTextBox>
                                                                                </td>
                                                                                <td style="width: 40px; font-weight: bold; font-size: small; color: #2C7500; text-align: right;">Ext:</td>
                                                                                <td style="padding-left: 2px"><asp:TextBox ID="Ext1TextBox" runat="server" Text='<%# Bind("Ext1") %>' Width="50px" /></td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">Address:</td>
                                                                    <td style="width: 275px"><asp:TextBox ID="Address2TextBox" runat="server" Text='<%# Bind("Address2") %>' Width="200px" /></td>
                                                                    <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right">Telephone:</td>
                                                                    <td style="width: 275px">
                                                                        <table cellpadding="0" cellspacing="0">
                                                                            <tr>
                                                                                <td><telerik:RadMaskedTextBox ID="Telephone2TextBox" runat="server" Mask="(###) ###-####" Text='<%# Bind("Telephone2") %>'></telerik:RadMaskedTextBox></td>
                                                                                <td style="width: 40px; font-weight: bold; font-size: small; color: #2C7500; text-align: right">Ext:</td>
                                                                                <td style="padding-left: 2px"><asp:TextBox ID="Ext2TextBox" runat="server" Text='<%# Bind("Ext2") %>' Width="50px" /></td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">City:</td>
                                                                    <td style="width: 275px"><asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' /></td>
                                                                    <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right">Telephone:</td>
                                                                    <td style="width: 275px">
                                                                        <table cellpadding="0" cellspacing="0">
                                                                            <tr>
                                                                                <td><telerik:RadMaskedTextBox ID="Telephone3TextBox" runat="server" Mask="(###) ###-####" Text='<%# Bind("Telephone3") %>'></telerik:RadMaskedTextBox></td>
                                                                                <td style="width: 40px; font-weight: bold; font-size: small; color: #2C7500; text-align: right">Ext: </td>
                                                                                <td style="padding-left: 2px"><asp:TextBox ID="Ext3TextBox" runat="server" Text='<%# Bind("Ext3") %>' Width="50px" /></td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">State:</td>
                                                                    <td style="width: 275px"><asp:TextBox ID="StateTextBox" runat="server" Text='<%# Bind("State") %>' /></td>
                                                                    <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right">Cell Phone:</td>
                                                                    <td style="width: 275px"><telerik:RadMaskedTextBox ID="CellPhoneTextBox" runat="server" Mask="(###) ###-####" Text='<%# Bind("CellPhone") %>'></telerik:RadMaskedTextBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">Zip:</td>
                                                                    <td style="width: 275px"><asp:TextBox ID="ZipTextBox" runat="server" Text='<%# Bind("Zip") %>' /></td>
                                                                    <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right">Fax:</td>
                                                                    <td style="width: 275px"><telerik:RadMaskedTextBox ID="Fax1TextBox" runat="server" Mask="(###) ###-####" Text='<%# Bind("Fax1") %>'></telerik:RadMaskedTextBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-weight: bold; color: #2C7500; text-align: right; width: 100px; font-size: small">&nbsp;</td>
                                                                    <td style="width: 275px">&nbsp;</td>
                                                                    <td style="font-size: small; font-weight: bold; color: #2C7500; text-align: right">Email:</td>
                                                                    <td style="width: 275px"><asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' /></td>
                                                                </tr>
                                                            </table>
                                                            <br />
                                                            <span style="font-weight: bold; font-size: medium; color: #ED8701">Notes</span><br />
                                                            <table width="100%">
                                                                <tr>
                                                                    <td style="width: 75px">&nbsp;</td>
                                                                    <td><asp:TextBox ID="TextBox1" runat="server" Height="100px" Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="650px" /></td>
                                                                </tr>
                                                            </table>
                                                            <br />
                                                            <span style="font-weight: bold; font-size: medium; color: #ED8701">Internal Notes</span><br />
                                                            <table width="100%">
                                                                <tr>
                                                                    <td style="width: 75px">&nbsp;</td>
                                                                    <td><asp:TextBox ID="NotesCFTextBox" runat="server" Height="100px" Text='<%# Bind("NotesCF") %>' TextMode="MultiLine" Width="650px" /></td>
                                                                </tr>
                                                            </table>
                                                            <table style="width: 100%">
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Button ID="Button1" runat="server" CommandName='<%# Iif (TypeOf Container is GridEditFormInsertItem, "PerformInsert", "Update") %>' Text='<%# Iif (TypeOf Container is GridEditFormInsertItem, "Insert", "Update") %>' />&nbsp;
                                                                        <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
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
                                <asp:SqlDataSource ID="sds_rpv_Contact" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
                                  DeleteCommand="DELETE FROM [CF_Profile_Contact] WHERE [UserID] = @UserID" 
                                  SelectCommand="SELECT [IDProfileContact], [IDProfileAccount], [UserID], [IDModifiedUser], [EnterDate], [ModifiedDate], [LastName], [FirstName], [MI], [Title], [UserName], [Email], [Address1], [Address2], [City], [State], [County], [Country], [Zip], [MailMergeCode], [Telephone1], [Ext1], [Telephone2], [Ext2], [Telephone3], [Ext3], [CellPhone], [Fax1], [Fax2], [EMailMergeCode], [WebSite], [Notes], [NotesCF] FROM [CFV_Profile_Contact] WHERE ([IDProfileAccount] = @IDProfileAccount)"
                                  UpdateCommand="UPDATE [CF_Profile_Contact] SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate, [LastName] = @LastName, [FirstName] = @FirstName, [MI] = @MI, [Title] = @Title, [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [State] = @State, [County] = @County, [Country] = @Country, [Zip] = @Zip, [MailMergeCode] = @MailMergeCode, [Telephone1] = @Telephone1, [Ext1] = @Ext1, [Telephone2] = @Telephone2, [Ext2] = @Ext2, [Telephone3] = @Telephone3, [Ext3] = @Ext3, [CellPhone] = @CellPhone, [Fax1] = @Fax1, [Fax2] = @Fax2, [EMailMergeCode] = @EMailMergeCode, [WebSite] = @WebSite, [Notes] = @Notes, [NotesCF] = @NotesCF WHERE [IDProfileContact] = @IDProfileContact">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount" Type="Int32" />
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
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td><asp:Button ID="btn_AddContact" runat="server" Text="Add Contact" /></td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>
                                <br />
                            </td>
                        </tr>
                    </table>
                </telerik:RadPageView>
                
                <!-- rpv_Notes -->
                <telerik:RadPageView ID="rpv_Notes" runat="server" Width="100%">
                    <table cellpadding="0" cellspacing="0" style="border: 1px solid #666666; background-color: #EEEEEE;">
                        <tr>
                            <td>
                                <asp:FormView ID="FormView2" runat="server" DataKeyNames="IDProfileAccount" DataSourceID="sdsfvAccountDetailsNotes">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="NotesTextBox" runat="server" Height="250px" Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="500px" />
                                        <br />
                                        <br />
                                        <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />&#160;
                                        <asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                    </EditItemTemplate>
                                    <InsertItemTemplate></InsertItemTemplate>
                                    <ItemTemplate>
                                        <div class="divlblScrollText">
                                            <asp:Label ID="NotesLabel" runat="server" Text='<%# Eval("Notes").ToString().Replace(Environment.NewLine,"<br />") %>' Style="font-size: small"></asp:Label>
                                        </div>
                                        <br />
                                        <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                    </ItemTemplate>
                                </asp:FormView>
                            </td>
                        </tr>
                    </table>
                </telerik:RadPageView>
                
                <!-- rpv_InternalNotes -->
                <telerik:RadPageView ID="rpv_InternalNotes" runat="server">
                    <table cellpadding="0" cellspacing="0" style="border: 1px solid #666666; background-color: #EEEEEE;">
                        <tr><td>
                            <asp:FormView ID="FormView3" runat="server" DataKeyNames="IDProfileAccount" DataSourceID="sdsfvAccountDetailsInternalNotes">
                                <EditItemTemplate>
                                    <asp:TextBox ID="NotesTextBox0" runat="server" Height="250px" Text='<%# Bind("NotesCF") %>' TextMode="MultiLine" Width="500px" /><br />
                                    <br />
                                    <asp:Button ID="UpdateButtonNotesCF" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />&nbsp;
                                    <asp:Button ID="UpdateCancelButtonNotesCF" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                </EditItemTemplate>
                                <InsertItemTemplate></InsertItemTemplate>
                                <ItemTemplate>
                                    <div class="divlblScrollText">
                                        <asp:Label ID="lbl_NotesCF" runat="server" Style="font-size: small" Text='<%# Eval("NotesCF").ToString().Replace(Environment.NewLine,"<br />") %>'></asp:Label>
                                    </div>
                                    <br />
                                    <asp:Button ID="EditButton0" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                </ItemTemplate>
                            </asp:FormView>
                        </td></tr>
                    </table>
                </telerik:RadPageView>
                
                <!-- rpv_PublicDocuments -->     
                <telerik:RadPageView ID="rpv_PublicDocuments" runat="server" Width="100%">
                    <telerik:RadGrid ID="rgd_PublicDocuments" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"  AllowAutomaticUpdates="True" 
                      AutoGenerateDeleteColumn="True" AutoGenerateEditColumn="True" DataSourceID="sds_PublicDocuments" GridLines="None" ShowFooter="True" CssClass="radgrid">
                        <mastertableview CommandItemDisplay="Top" AutoGenerateColumns="false" DataKeyNames="IDFile" DataSourceID="sds_PublicDocuments">
                            <Columns>
                                <telerik:GridBoundColumn DataField="Title" DataType="System.String" HeaderText="Title" SortExpression="Title" UniqueName="Title" ></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="DocumentType" DataType="System.String" HeaderText="Document Type" SortExpression="DocumentType" UniqueName="DocumentType"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="FileName" DataType="System.String" HeaderText="FileName" SortExpression="FileName" UniqueName="FileName"></telerik:GridBoundColumn>
                                <telerik:GridHyperLinkColumn FooterText="" DataTextFormatString="View File" DataNavigateUrlFields="FilePath,FileName" UniqueName="ViewPublicDocument" DataNavigateUrlFormatString="{0}/{1}" HeaderText="" DataTextField="FileName" Target="_blank"></telerik:GridHyperLinkColumn>
                            </Columns>
                            <EditFormSettings EditFormType="Template" >
                                <FormTemplate>
                                    <h2>Attach Document</h2>
                                    <asp:Label ID="PublicDocumentMessageLbl" runat="server" ></asp:Label>
                                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td style="width: 98px; text-align:right;">Title:</td>
                                            <td style="width: 210px; text-align:left;">
                                                <asp:TextBox ID="tbx_Title" Text='<%# Bind("Title") %>' runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator id="rfv_tbx_Title" runat="server" ControlToValidate="tbx_Title" Display="Dynamic" ErrorMessage="Please enter a Document Title" />
                                            </td>
                                            <td style="width: 98px; text-align:right;">Document Type:</td>
                                            <td style="width: 210px; text-align:left;">
                                                <asp:DropDownList ID="ddl_PublicDocumentType" runat="server" DataSourceID="sds_ddl_Op_PublicDocumentType" DataTextField="DisplayValue" DataValueField="IDOptionList" SelectedValue='<%# Bind("IDDocumentType") %>' OnDataBinding="PreventErrorOnbinding" AppendDataBoundItems="true">
                                                    <asp:ListItem Text="" Value="0" />
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ControlToValidate="ddl_PublicDocumentType" Display="Dynamic" ErrorMessage="Please choose a Document Type" />
                                            </td>
                                            <td>&nbsp;</td>
                                            <td style="width: 98px; text-align:right;">File: </td>
                                            <td style="width: 210px; text-align:left;">
                                                <asp:HiddenField ID="tbx_FileName" runat="server" Value='<%# Bind("FileName") %>'/>
                                                <asp:FileUpload ID="fu_PublicDocument" runat="server" />
                                                <%--<asp:RequiredFieldValidator id="rfv_fu_PublicDocument" runat="server" ControlToValidate="fu_PublicDocument" Display="Dynamic" ErrorMessage="Please upload a file" />--%>
                                                <asp:CustomValidator runat="server" ClientValidationFunction="ValidateHasFile" ErrorMessage="Please upload a file" />
                                                <script language="javascript" type="text/javascript">
                                                    function ValidateHasFile(source, args) {
                                                        var $itemElements = $telerik.$(masterTable.get_Element());
                                                        var $hiddenFileName = $itemElements.find("input[id*='tbx_FileName']");
                                                        var $filePublicDocument = $itemElements.find(":input[id*='fu_PublicDocument']");
                                                        
                                                        if ($hiddenFileName.val() === "") {
                                                            return !($filePublicDocument.val() === "");
                                                        } else {
                                                            return true;
                                                        }
                                                    }
                                                </script>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                                        
                                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td style="width: 66px"><asp:Button ID="btnUpdate" runat="server" CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>' Text='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "Insert", "Update") %>'></asp:Button></td>
                                            <td><asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False" CommandName="Cancel"></asp:Button></td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                    <br />
                                </FormTemplate>
                            </EditFormSettings>
                        </mastertableview>
                    </telerik:RadGrid>
                </telerik:RadPageView>
                
                <!-- rpv_TerminalDocuments -->  
                <telerik:RadPageView ID="rpv_TerminalDocuments" runat="server" Width="100%">
                    <telerik:RadGrid ID="rgd_TerminalDocuments" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"  AllowAutomaticUpdates="True" 
                      AutoGenerateDeleteColumn="True" AutoGenerateEditColumn="True" DataSourceID="sds_TerminalDocuments" GridLines="None" ShowFooter="True" CssClass="radgrid">
                        <mastertableview CommandItemDisplay="Top" AutoGenerateColumns="false" DataKeyNames="IDFile" DataSourceID="sds_TerminalDocuments">
                            <Columns>
                                <telerik:GridBoundColumn DataField="Title" DataType="System.String" HeaderText="Title" SortExpression="Title" UniqueName="TerminalTitle" ></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="DocumentType" DataType="System.String" HeaderText="Document Type" SortExpression="DocumentType" UniqueName="TerminalDocumentType"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="FileName" DataType="System.String" HeaderText="FileName" SortExpression="FileName" UniqueName="TerminalFileName"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="IDProfileTerminal" DataType="System.String" HeaderText="IDTerminal" SortExpression="IDTerminal" UniqueName="TerminalID"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TerminalName" DataType="System.String" HeaderText="TerminalName" SortExpression="TerminalName" UniqueName="TerminalName"></telerik:GridBoundColumn>
                                <telerik:GridHyperLinkColumn FooterText="" DataTextFormatString="View File" DataNavigateUrlFields="FilePath,FileName" UniqueName="ViewTerminalDocument" DataNavigateUrlFormatString="{0}/{1}" HeaderText="" DataTextField="FileName" Target="_blank"></telerik:GridHyperLinkColumn>
                            </Columns>
                            <EditFormSettings EditFormType="Template" >
                                <FormTemplate>
                                    <h2>Attach Document</h2>
                                    <asp:Label ID="TerminalDocumentMessageLbl" runat="server" ></asp:Label>
                                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td style="width: 98px; text-align:right;">Title:</td>
                                            <td style="width: 210px; text-align:left;">
                                                <asp:TextBox ID="tbx_Title" Text='<%# Bind("Title") %>' runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator id="rfv_tbx_Title" runat="server" ControlToValidate="tbx_Title" Display="Dynamic" ErrorMessage="Please enter a Document Title" />
                                            </td>
                                            <td style="width: 98px; text-align:right;">Document Type:</td>
                                            <td style="width: 210px; text-align:left;">
                                                <asp:DropDownList ID="ddl_TerminalDocumentType" runat="server" DataSourceID="sds_ddl_Op_PublicDocumentType" DataTextField="DisplayValue" DataValueField="IDOptionList" SelectedValue='<%# Bind("IDDocumentType") %>' OnDataBinding="PreventErrorOnbinding" AppendDataBoundItems="true">
                                                    <asp:ListItem Text="--Select--" Value="0" />
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ControlToValidate="ddl_TerminalDocumentType" Display="Dynamic" ErrorMessage="Please choose a Document Type" />
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td style="width: 98px; text-align:right;">Terminal:</td>
                                            <td style="width: 210px; text-align:left;">
                                             	<asp:DropDownList ID="ddl_TerminalID" runat="server" DataSourceID="sds_ddl_Op_AccountTerminals" DataTextField="TerminalName" DataValueField="IDProfileTerminal" SelectedValue='<%# Bind("IDProfileTerminal") %>' OnDataBinding="PreventErrorOnbinding" AppendDataBoundItems="true">
                                                    <asp:ListItem Text="--Select--" Value="0" />
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" ControlToValidate="ddl_TerminalID" Display="Dynamic" ErrorMessage="Please choose a Terminal" />
                                            </td>
                                            <td style="width: 98px; text-align:right;">File: </td>
                                            <td style="width: 210px; text-align:left;">
                                                <asp:HiddenField ID="tbx_TerminalFileName" runat="server" Value='<%# Bind("FileName") %>'/>
                                                <asp:FileUpload ID="fu_TerminalDocument" runat="server" /><small>Terminal Documents must be PDFs</small>
                                                <asp:CustomValidator runat="server" ClientValidationFunction="ValidateHasFile" ErrorMessage="Please upload a PDF file" />
                                                <script language="javascript" type="text/javascript">
                                                    function ValidateHasFile(source, args) {
                                                        var $itemElements = $telerik.$(masterTable.get_Element());
                                                        var $hiddenFileName = $itemElements.find("input[id*='tbx_TerminalFileName']");
                                                        var $fileTerminalDocument = $itemElements.find(":input[id*='fu_TerminalDocument']");
                                                        
                                                        if ($hiddenFileName.val() === "") {
                                                            return !($filePublicDocument.val() === "");
                                                        } else {
                                                            return true;
                                                        }
                                                    }
                                                </script>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                                        
                                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td style="width: 66px"><asp:Button ID="btnUpdate" runat="server" CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>' Text='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "Insert", "Update") %>'></asp:Button></td>
                                            <td><asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False" CommandName="Cancel"></asp:Button></td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                    <br />
                                </FormTemplate>
                            </EditFormSettings>
                        </mastertableview>
                    </telerik:RadGrid>
                </telerik:RadPageView> 
            </telerik:radmultipage>
		</td></tr>
	</table>
	<br />
	<br />
    
    <!-- DATA SOURCES -->
    
    <!-- DataSource: Account Details (sdsfvAccountDetails) -->
	<asp:SqlDataSource ID="sdsfvAccountDetails" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT [IDProfileAccount], [AccountName], [AccountNum], [ContractNum], [ReferredBy], [Address1], [Address2], [City], [State], [County], [Country], [Zip], [MailMergeCode], 
          [Telephone1], [Ext1], [Telephone2], [Ext2], [Telephone3], [Ext3], [Fax1], [Fax2], [WebSite], [IDClass78BACTReplacementSchedule], 
          [dbo].[GetIDOptionListRecordValue](IDClass78BACTReplacementSchedule) AS [Class78BACTReplacementSchedule], CASE WHEN [PSIPNotificationEmail] = 'Y' THEN 1 ELSE 0 END [PSIPNotificationEmail], ISNULL([PSIPMonth], 'None') [PSIPMonth]
        FROM [CF_Profile_Account] 
        WHERE ([IDProfileAccount] = @IDProfileAccount)"
	  UpdateCommand="
      	UPDATE [CF_Profile_Account] 
        SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate,[AccountName] = @AccountName, [AccountNum] = @AccountNum, [ContractNum] = @ContractNum, 
          [ReferredBy] = @ReferredBy,  [Address1] = @Address1, [Address2] = @Address2, [City] = @City, [State] = @State, [County] = @County, [Country] = @Country, [Zip] = @Zip, 
          [MailMergeCode] = @MailMergeCode, [Telephone1] = @Telephone1, [Ext1] = @Ext1, [Telephone2] = @Telephone2, [Ext2] = @Ext2, [Telephone3] = @Telephone3, [Ext3] = @Ext3, 
          [Fax1] = @Fax1, [Fax2] = @Fax2, [WebSite] = @WebSite, [IDClass78BACTReplacementSchedule] = @IDClass78BACTReplacementSchedule, [PSIPNotificationEmail] = CASE WHEN UPPER(@PSIPNotificationEmail) = 'TRUE' THEN 'Y' ELSE 'N' END, [PSIPMonth] = @PSIPMonth
        WHERE [IDProfileAccount] = @IDProfileAccount"
	  DeleteCommand="
      	DELETE FROM [CF_Profile_Account] 
        WHERE [IDProfileAccount] = @IDProfileAccount
    ">
        <SelectParameters>
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount" Type="Int32" />
		</SelectParameters>
		<UpdateParameters>
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:Parameter Name="ModifiedDate" Type="DateTime" />
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
			<asp:Parameter Name="Fax1" Type="String" />
			<asp:Parameter Name="Fax2" Type="String" />
			<asp:Parameter Name="WebSite" Type="String" />
			<asp:Parameter Name="IDClass78BACTReplacementSchedule" Type="Int32" />
			<asp:Parameter Name="PSIPNotificationEmail" Type="String" />
			<asp:Parameter Name="PSIPMonth" Type="String" />
			<asp:Parameter Name="IDProfileAccount" Type="Int32" />
		</UpdateParameters>
        <DeleteParameters>
			<asp:Parameter Name="IDProfileAccount" Type="Int32" />
		</DeleteParameters>
		<InsertParameters></InsertParameters>
	</asp:SqlDataSource>
    
    <!-- DataSource: Clean Fleets Menu Console (sds_CF_Menu_Console) -->
	<asp:SqlDataSource ID="sds_CF_Menu_Console" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT [DataFieldID], [DataFieldParentID], [DataTextField], [DataNavigateUrlField], [ImageURL] 
        FROM [CF_Menu_Console]">
	</asp:SqlDataSource>
    
    <!-- DataSource: Notes (sdsfvAccountDetailsNotes) -->
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
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount" Type="Int32" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="IDProfileAccount" Type="Int32" />
			<asp:Parameter Name="IDProfileAccount" Type="Int32" />
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:Parameter Name="ModifiedDate" Type="DateTime" />
		</UpdateParameters>
		<InsertParameters></InsertParameters>
	</asp:SqlDataSource>
    
    <!-- DataSource: Internal Notes (sdsfvAccountDetailsInternalNotes) -->
	<asp:SqlDataSource ID="sdsfvAccountDetailsInternalNotes" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT [IDProfileAccount], [NotesCF] 
        FROM [CF_Profile_Account] 
        WHERE ([IDProfileAccount] = @IDProfileAccount)"
	  UpdateCommand="
      	UPDATE [CF_Profile_Account] 
        SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate,[NotesCF] = @NotesCF 
        WHERE [IDProfileAccount] = @IDProfileAccount">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount" Type="Int32" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="NotesCF" Type="String" />
			<asp:Parameter Name="IDProfileAccount" Type="Int32" />
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:Parameter Name="ModifiedDate" Type="DateTime" />
		</UpdateParameters>
		<InsertParameters></InsertParameters>
	</asp:SqlDataSource>
    
    <!-- DataSource: BACT ReplacementSchedule (sds_ddl_Op_IDClass78BACTReplacementSchedule) -->
	<asp:SqlDataSource ID="sds_ddl_Op_IDClass78BACTReplacementSchedule" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
      SelectCommand="
        SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] 
        FROM [CF_Option_List] 
        WHERE ([OptionName] = 'Class78BACTReplacementSchedule') 
        ORDER BY [DisplayValue]">
	</asp:SqlDataSource>
    
    <!-- DataSource: Public Documents (sds_PublicDocuments) -->
	<asp:SqlDataSource ID="sds_PublicDocuments" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT *
        FROM [CFV_Files_Account_Public] 
        WHERE [IDProfileAccount] = @IDProfileAccount"
	  InsertCommand="
      	INSERT INTO [CF_Files] (IDFile, EnterDate, IDModifiedUser, ModifiedDate, Title, FileName, FileSize, FilePath, IDDocumentType, IDProfileAccount) 
        VALUES (@IDFile, GETDATE(), @IDModifiedUser, GETDATE(), @Title, @FileName, @FileSize, @FilePath, @IDDocumentType, @IDProfileAccount) "
	  UpdateCommand="
      	UPDATE [CF_Files] 
        SET IDModifiedUser = @IDModifiedUser, ModifiedDate = GETDATE(), Title = @Title, FileName = ISNULL(@FileName, FileName), FileSize = ISNULL(@FileSize, FileSize), FilePath = ISNULL(@FilePath,FilePath), IDDocumentType = @IDDocumentType 
        WHERE IDFile = @IDFile" 
	  DeleteCommand="DELETE FROM [CF_Files] WHERE IDFile = @IDFile">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount" Type="Int32" />
		</SelectParameters>
		<InsertParameters>
			<asp:Parameter Name="IDFile" />
			<asp:Parameter Name="IDModifiedUser" Type="String" />
			<asp:Parameter Name="Title" Type="String"  />
			<asp:Parameter Name="FileName" Type="String" />
			<asp:Parameter Name="FileSize" Type="String" />
			<asp:Parameter Name="FilePath" Type="String" />
			<asp:Parameter Name="IDDocumentType" Type="String" />
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount" Type="Int32" />
		</InsertParameters>
		<UpdateParameters>
			<asp:Parameter Name="IDFile" />
			<asp:Parameter Name="IDModifiedUser" Type="String" />
			<asp:Parameter Name="Title" Type="String"  />
			<asp:Parameter Name="FileName" Type="String" />
			<asp:Parameter Name="FileSize" Type="String" />
			<asp:Parameter Name="FilePath" Type="String" />
			<asp:Parameter Name="IDDocumentType" Type="String" />
		</UpdateParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDFile" />
		</DeleteParameters>
	</asp:SqlDataSource>
    
    <!-- DataSource: Public Document Type (sds_ddl_Op_PublicDocumentType) -->
	<asp:SqlDataSource ID="sds_ddl_Op_PublicDocumentType" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
      SelectCommand="
      	SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] 
        FROM [CF_Option_List] 
        WHERE ([OptionName] = 'DocumentType' AND LOWER(RTRIM(RecordValue)) IN ('compliancecertificate', 'fleetsummary', 'opacitytests', 'other')) 
        ORDER BY [DisplayValue]">
	</asp:SqlDataSource>
    
    <!-- DataSource: Terminal Documents (sds_TerminalDocuments) -->
    <asp:SqlDataSource ID="sds_TerminalDocuments" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
      	SELECT F.*, T.TerminalName, O.DisplayValue AS DocumentType
        FROM [CF_Files] F
        LEFT JOIN CF_Profile_Terminal T ON F.IDProfileTerminal = T.IDProfileTerminal
        LEFT JOIN CF_Option_List O ON F.IDDocumentType = O.IDOptionList
        WHERE F.[IDProfileAccount] = @IDProfileAccount
        AND F.IDProfileTerminal IS NOT NULL
        AND RTRIM(ISNULL(O.OptionName, 'DocumentType')) = 'DocumentType' 
        ORDER BY T.IDProfileTerminal ASC, DocumentType, F.Title"
	  InsertCommand="
      	INSERT INTO [CF_Files] (IDFile, EnterDate, IDModifiedUser, ModifiedDate, Title, FileName, FileSize, FilePath, IDDocumentType, IDProfileAccount, IDProfileTerminal) 
        VALUES (@IDFile, GETDATE(), @IDModifiedUser, GETDATE(), @Title, @FileName, @FileSize, @FilePath, @IDDocumentType, @IDProfileAccount, @IDProfileTerminal) "
	  UpdateCommand="
      	UPDATE [CF_Files] 
        SET IDModifiedUser = @IDModifiedUser, ModifiedDate = GETDATE(), Title = @Title, FileName = ISNULL(@FileName, FileName), FileSize = ISNULL(@FileSize, FileSize), 
          FilePath = ISNULL(@FilePath,FilePath), IDDocumentType = @IDDocumentType 
        WHERE IDFile = @IDFile" 
	  DeleteCommand="
      	DELETE FROM [CF_Files] 
        WHERE IDFile = @IDFile">
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount" Type="Int32" />
		</SelectParameters>
		<InsertParameters>
			<asp:Parameter Name="IDFile" />
			<asp:Parameter Name="IDModifiedUser" Type="String" />
			<asp:Parameter Name="Title" Type="String"  />
			<asp:Parameter Name="FileName" Type="String" />
			<asp:Parameter Name="FileSize" Type="String" />
			<asp:Parameter Name="FilePath" Type="String" />
			<asp:Parameter Name="IDDocumentType" Type="String" />
            <asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount" Type="Int32" />
			<asp:Parameter Name="IDProfileTerminal" Type="Int32" />
		</InsertParameters>
		<UpdateParameters>
			<asp:Parameter Name="IDFile" />
			<asp:Parameter Name="IDModifiedUser" Type="String" />
			<asp:Parameter Name="Title" Type="String"  />
			<asp:Parameter Name="FileName" Type="String" />
			<asp:Parameter Name="FileSize" Type="String" />
			<asp:Parameter Name="FilePath" Type="String" />
			<asp:Parameter Name="IDDocumentType" Type="String" />
		</UpdateParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDFile" />
		</DeleteParameters>
	</asp:SqlDataSource>
	
	<!-- Datasource: Default Modules (src_DefaultModules) -->
	<asp:SqlDataSource ID="src_DefaultModules" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
      SelectCommand="
      	SELECT [IsDisplayed], [DisplayValue], [RecordValue], [IDDefaultModule]
        FROM [CF_AccountDefaultModules] INNER JOIN [CF_Option_List]
		ON IDDefaultModule = IDOptionList
        WHERE IDProfileAccount = @IDProfileAccount
        ORDER BY [DisplayValue]"
	  UpdateCommand="
	  	UPDATE [CF_AccountDefaultModules]
		SET IsDisplayed = @IsDisplayed
		WHERE IDProfileAccount = @IDProfileAccount AND IDDefaultModule = @IDDefaultModule">
        <SelectParameters>
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount" Type="Int32" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="IDProfileAccount" />
			<asp:Parameter Name="IDDefaultModule" />
			<asp:Parameter Name="IsDisplayed" Type="String"/>
		</UpdateParameters>
	</asp:SqlDataSource>
    
    <!-- DataSource: Account Terminals (sds_ddl_Op_AccountTerminals) -->
	<asp:SqlDataSource ID="sds_ddl_Op_AccountTerminals" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
      SelectCommand="
      	SELECT [IDProfileTerminal], [TerminalName]
        FROM [CF_Profile_Terminal] 
        WHERE IDProfileAccount = @IDProfileAccount
        ORDER BY [IDProfileTerminal]">
        <SelectParameters>
			<asp:QueryStringParameter Name="IDProfileAccount" QueryStringField="IDProfileAccount" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	

    
</asp:Content>
