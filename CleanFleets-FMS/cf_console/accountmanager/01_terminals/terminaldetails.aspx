﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="terminaldetails.aspx.vb" Inherits="cleanfleets_fms.terminaldetails1" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<table id="tableBreadcrumbMenu" style="width: 800px;">
		<tr>
			<td>
				<asp:Button ID="btn_TerminalList" runat="server" Text="<< Terminal List" />
			</td>
		</tr>
	</table>
	<asp:FormView ID="FormView1" runat="server" DataKeyNames="IDProfileTerminal" DataSourceID="sds_cfv_Profile_Terminal"
		HorizontalAlign="Left" Width="800px">
		<EditItemTemplate>
			<span style="font-weight: bold; font-size: medium; color: #ED8701">Terminal</span><br />
			<br />
			<table width="100%">
				<tr>
					<td style="width: 105px" class="tdtable">
						Terminal Name:
					</td>
					<td>
						<asp:TextBox ID="TerminalNameTextBox" runat="server" Text='<%# Bind("TerminalName") %>'
							Width="200px" />
					</td>
				</tr>
				<tr>
					<td style="width: 105px" class="tdtable">
						Account Name:
					</td>
					<td>
						<asp:TextBox ID="AccountNameTextBox" runat="server" Text='<%# Bind("AccountName") %>'
							Width="200px" ReadOnly="True" />
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
			<b><span style="font-weight: bold; font-size: medium; color: #ED8701">Internal Notes<br />
			</span></b>
			<table width="100%">
				<tr>
					<td style="width: 75px">&nbsp;
						
					</td>
					<td>
						<asp:TextBox ID="NotesCFTextBox" runat="server" Height="100px" Text='<%# Bind("NotesCF") %>'
							TextMode="MultiLine" Width="650px" />
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
			<asp:TextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes") %>' />
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
			<span style="font-weight: bold; font-size: medium; color: #ED8701">Terminal</span><br />
			<br />
			<table width="100%">
				<tr>
					<td style="width: 105px" class="tdtable">
						Terminal Name:
					</td>
					<td>
						<asp:Label ID="TerminalNameLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("TerminalName") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td style="width: 105px" class="tdtable">
						Account Name:
					</td>
					<td>
						<asp:Label ID="AccountNameLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
							font-size: small" Text='<%# Bind("AccountName") %>'></asp:Label>
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
								<td><asp:Label ID="Telephone2Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Me.FormatPhone(If(Convert.IsDBNull(Eval("Telephone2")), String.Empty, "Telephone2"))%>'></asp:Label></td>
								<td style="width: 40px; color: #2C7500; font-size: small; font-weight: bold; text-align: right;">
									<span style="color: #2C7500; font-size: small; font-weight: bold; width: 40px; text-align: right;">Ext:</span>
								</td>
								<td style="padding-left: 2px"><asp:Label ID="Ext2Label" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("Ext2") %>'></asp:Label></td>
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
								<td style="width: 40px; color: #2C7500; font-size: small; font-weight: bold; text-align: right;"><span style="color: #2C7500; font-size: small; font-weight: 700">Ext:</span></td>
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
			<b><span style="font-weight: bold; font-size: medium; color: #ED8701">Notes</span></b><br />
			<br />
			<table width="100%">
				<tr>
					<td width="25px">&nbsp;</td>
					<td><asp:Label ID="NotesLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("Notes") %>' /></td>
				</tr>
			</table>
			<br />
			<span style="font-weight: bold; font-size: medium; color: #ED8701">Internal Notes</span><br />
			<table width="100%">
				<tr>
					<td width="25px">&nbsp;</td>
					<td><asp:Label ID="NotesCFLabel" runat="server" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text='<%# Bind("NotesCF") %>' /></td>
				</tr>
			</table>
			<br />
			<asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="Edit" />&nbsp;
            <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('Are you certain you want to delete this Terminal?')" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="Delete" />&nbsp;
            <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Style="font-family: Arial, Helvetica, sans-serif; font-size: small" Text="New" Visible="False" />
		</ItemTemplate>
	</asp:FormView>
	<br />
    
    <telerik:radtabstrip id="tbs_AccountDetails" runat="server" multipageid="rmp_AccountDetails" selectedindex="0">
        <Tabs>
            <telerik:RadTab runat="server" PageViewID="rpv_TerminalDocuments" Text="Terminal Documents"></telerik:RadTab>
        </Tabs>
    </telerik:radtabstrip>
    
    <telerik:radmultipage id="rmp_AccountDetails" runat="server" selectedindex="0" width="800px">
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
                                <!--</tr>
                                <tr>
                                	<td style="width: 98px; text-align:right;">Terminal:</td>
                                    <td style="width: 210px; text-align:left;">
                                    	<asp:Label ID="lbl_Terminal_Name" runat="server" Text='' Style="font-size: small"></asp:Label>
                                    </td> -->
                               		<td style="width: 98px; text-align:right;">File: </td>
                                    <td style="width: 210px; text-align:left;">
                                        <asp:HiddenField ID="tbx_TerminalFileName" runat="server" Value='<%# Bind("FileName") %>'/>
                                        <asp:FileUpload ID="fu_TerminalDocument" runat="server" />
                                        <asp:CustomValidator runat="server" ClientValidationFunction="ValidateHasFile" ErrorMessage="Please upload a file" />
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
                                                
                            <table cellpadding="0" cellspacing="0" style="width:100%">
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
    <!-- Profile Account (sds_Profile_Account) -->
	<asp:SqlDataSource ID="sds_Profile_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
	  SelectCommand="
        SELECT [IDProfileTerminal], [IDProfileAccount], [AccountName], [TerminalName] 
        FROM [CFV_Profile_Terminal] 
        WHERE ([IDProfileTerminal] = @IDProfileTerminal)">
        
		<SelectParameters>
			<asp:QueryStringParameter Name="IDProfileTerminal" QueryStringField="IDProfileTerminal" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
    
    <!-- Profile Terminal (sds_cfv_Profile_Terminal) -->
	<asp:SqlDataSource ID="sds_cfv_Profile_Terminal" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
      SelectCommand="
      	SELECT [IDProfileTerminal], [IDProfileAccount], [AccountName], [TerminalName], [Address1], [Address2], [City], [State], [County], [Country], [Zip], 
          [Telephone1], [Ext1], [Telephone2], [Ext2], [Telephone3], [Ext3], [Fax1],  [WebSite], [Notes], [NotesCF] 
        FROM [CFV_Profile_Terminal] 
        WHERE ([IDProfileTerminal] = @IDProfileTerminal)"
      InsertCommand="
      	INSERT INTO [CF_Profile_Terminal] ([TerminalName], [Address1], [Address2], [City], [State], [County], [Country], [Zip], [MailMergeCode], [Telephone1], 
          [Ext1], [Telephone2], [Ext2], [Telephone3], [Ext3], [CellPhone], [Fax1], [Fax2], [WebSite], [Notes], [NotesCF]) 
        VALUES (@AccountName, @TerminalName, @Address1, @Address2, @City, @State, @County, @Country, @Zip, @MailMergeCode, @Telephone1, @Ext1, @Telephone2, 
          @Ext2, @Telephone3, @Ext3, @CellPhone, @Fax1, @Fax2, @WebSite, @Notes, @NotesCF)"
      UpdateCommand="
      	UPDATE [CF_Profile_Terminal] 
        SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate, [TerminalName] = @TerminalName, [Address1] = @Address1, [Address2] = @Address2, 
          [City] = @City, [State] = @State, [County] = @County, [Country] = @Country, [Zip] = @Zip, [Telephone1] = @Telephone1, [Ext1] = @Ext1, [Telephone2] = @Telephone2, 
          [Ext2] = @Ext2, [Telephone3] = @Telephone3, [Ext3] = @Ext3, [Fax1] = @Fax1, [WebSite] = @WebSite, [Notes] = @Notes, [NotesCF] = @NotesCF 
        WHERE [IDProfileTerminal] = @IDProfileTerminal"
	  DeleteCommand="
      	DELETE FROM [CF_Profile_Terminal] 
        WHERE [IDProfileTerminal] = @IDProfileTerminal">
        <SelectParameters>
			<asp:QueryStringParameter Name="IDProfileTerminal" QueryStringField="IDProfileTerminal" Type="Int32" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDProfileTerminal" Type="Int32" />
		</DeleteParameters>
		<UpdateParameters>
			<asp:Parameter Name="TerminalName" Type="String" />
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
			<asp:Parameter Name="IDProfileTerminal" Type="Int32" />
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:Parameter Name="ModifiedDate" Type="DateTime" />
		</UpdateParameters>
		<InsertParameters>
			<asp:Parameter Name="TerminalName" Type="String" />
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
    
    <!-- DataSource: Public Document Type (sds_ddl_Op_PublicDocumentType) -->
	<asp:SqlDataSource ID="sds_ddl_Op_PublicDocumentType" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
      SelectCommand="
      	SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] 
        FROM [CF_Option_List] 
        WHERE ([OptionName] = 'DocumentType' AND LOWER(RTRIM(RecordValue)) IN ('compliancecertificate', 'fleetsummary', 'opacitytests')) 
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
        AND F.IDProfileTerminal = @IDProfileTerminal
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
            <asp:QueryStringParameter Name="IDProfileTerminal" QueryStringField="IDProfileTerminal" Type="Int32" />
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
			<asp:QueryStringParameter Name="IDProfileTerminal" QueryStringField="IDProfileTerminal" Type="Int32" />
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
