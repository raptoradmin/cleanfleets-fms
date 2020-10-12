<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="account_add.aspx.vb" Inherits="cleanfleets_fms.account_add" %>

<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Add Account</p>
	<table style="padding: 3px; width: 800px;">
		<tr>
			<td style="width: 115px;" class="tdtable">
				Account Name:
			</td>
			<td>
				<asp:TextBox ID="tb_AccountName" runat="server" TabIndex="1" Width="250px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td style="width: 115px;" class="tdtable">
				Account Number:
			</td>
			<td>
				<b><span style="font-size: medium; color: #2C7500">
					<asp:TextBox ID="tb_AccountNum" runat="server" TabIndex="2"></asp:TextBox>
				</span></b>
			</td>
		</tr>
		<tr>
			<td style="width: 115px;" class="tdtable">
				Contract Number:
			</td>
			<td>
				<b><span style="font-size: medium; color: #2C7500">
					<asp:TextBox ID="tb_ContractNum" runat="server" TabIndex="3"></asp:TextBox>
				</span></b>
			</td>
		</tr>
		<tr>
			<td style="width: 115px;" class="tdtable">
				Referred By:
			</td>
			<td>
				<b><span style="font-size: medium; color: #2C7500">
					<asp:TextBox ID="tb_ReferredBy" runat="server" TabIndex="3"></asp:TextBox>
				</span></b>
			</td>
		</tr>
        <tr><%-- jacky's edit 8-27-20--%>
			<td style="width: 115px;" class="tdtable">
				Fed Taxpayer ID:
			</td>
			<td>
				<b><span style="font-size: medium; color: #2C7500">
					<telerik:radmaskedtextbox ID="tb_FederalTaxpayerID" runat="server"  mask="##-#######" TabIndex="3"></telerik:radmaskedtextbox>
                    <asp:RegularExpressionValidator Display = "Dynamic" ControlToValidate = "tb_FederalTaxpayerID" ID="RegularExpressionValidator1" 
                        ValidationExpression = "^[\s\S]{9,}$" runat="server" ErrorMessage="Minimum 9 Number required."></asp:RegularExpressionValidator>
				</span></b>
			</td>
		</tr>
        <tr>
			<td style="width: 115px;" class="tdtable">
				TRUCRS ID:
			</td>
			<td>
				<b><span style="font-size: medium; color: #2C7500">
					<asp:TextBox ID="tb_TRUCRSID" runat="server" TabIndex="3"></asp:TextBox>
                    
				</span></b>
			</td>
		</tr>
        <tr>
			<td style="width: 115px;" class="tdtable">
				NAICS Code #:
			</td>
			<td>
				<b><span style="font-size: medium; color: #2C7500">
					<asp:TextBox ID="tb_NAICScode" runat="server" TabIndex="3"></asp:TextBox>
                    
				</span></b>
			</td>
		</tr>
        <tr>
			<td style="width: 115px;" class="tdtable">
				USDOT #:
			</td>
			<td>
				<b><span style="font-size: medium; color: #2C7500">
					<asp:TextBox ID="tb_USDOT" runat="server" TabIndex="3"></asp:TextBox>
                    
				</span></b>
			</td>
		</tr>
        <tr>
			<td style="width: 115px;" class="tdtable">
				Other Permit:
			</td>
			<td>
				<b><span style="font-size: medium; color: #2C7500">
					<asp:TextBox ID="tb_OtherPermit" runat="server" TabIndex="3"></asp:TextBox>
                    
				</span></b>
			</td>
		</tr><%-- end of jacky's edit 8-27-20--%>
	</table>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Account Details</p>
	<table style="width: 800px;">
		<tr>
			<td class="tdtable">
				Address:
			</td>
			<td>
				<asp:TextBox ID="tb_Address1" runat="server" TabIndex="5"></asp:TextBox>
			</td>
			<td class="tdtable">
				Telephone:
			</td>
			<td>
				<table style="width: 100%">
					<tr>
						<td>
							<span style="font-weight: bold; font-size: medium; color: #ED8701"><b><span style="font-size: medium;
								color: #2C7500">
								<telerik:radmaskedtextbox id="tb_Telephone1" runat="server" mask="(###) ###-####"
									tabindex="10">
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
								<asp:TextBox ID="tb_Ext1" runat="server" TabIndex="11" Width="50px"></asp:TextBox>
							</span></b>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="tdtable">
				Address:
			</td>
			<td>
				<asp:TextBox ID="tb_Address2" runat="server" TabIndex="6"></asp:TextBox>
			</td>
			<td class="tdtable">
				Telephone:
			</td>
			<td>
				<table style="width: 100%">
					<tr>
						<td>
							<span style="font-weight: bold; font-size: medium; color: #ED8701"><b><span style="font-size: medium;
								color: #2C7500">
								<telerik:radmaskedtextbox id="tb_Telephone2" runat="server" mask="(###) ###-####"
									tabindex="12">
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
								<asp:TextBox ID="tb_Ext2" runat="server" TabIndex="13" Width="50px"></asp:TextBox>
							</span></b>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="tdtable">
				City:
			</td>
			<td>
				<asp:TextBox ID="tb_City" runat="server" TabIndex="7"></asp:TextBox>
			</td>
			<td class="tdtable">
				Telephone:
			</td>
			<td>
				<table style="width: 100%">
					<tr>
						<td>
							<span style="font-weight: bold; font-size: medium; color: #ED8701"><b><span style="font-size: medium;
								color: #2C7500">
								<telerik:radmaskedtextbox id="tb_Telephone3" runat="server" mask="(###) ###-####"
									tabindex="14">
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
								<asp:TextBox ID="tb_Ext3" runat="server" TabIndex="15" Width="50px"></asp:TextBox>
							</span></b>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="tdtable">
				State:
			</td>
			<td>
				<asp:TextBox ID="tb_State" runat="server" TabIndex="8"></asp:TextBox>
			</td>
			<td class="tdtable">
				Cell Phone:
			</td>
			<td>
				<span style="font-weight: bold; font-size: medium; color: #ED8701"><b><span style="font-size: medium;
					color: #2C7500">
					<telerik:radmaskedtextbox id="tb_CellPhone" runat="server" mask="(###) ###-####"
						tabindex="16">
                                        </telerik:radmaskedtextbox>
				</span></b></span>
			</td>
		</tr>
		<tr>
			<td class="tdtable">
				Zip:
			</td>
			<td>
				<asp:TextBox ID="tb_Zip" runat="server" TabIndex="9"></asp:TextBox>
			</td>
			<td class="tdtable">
				Fax:
			</td>
			<td>
				<span style="font-weight: bold; font-size: medium; color: #ED8701"><b><span style="font-size: medium;
					color: #2C7500">
					<telerik:radmaskedtextbox id="tb_Fax1" runat="server" mask="(###) ###-####" tabindex="17">
                                        </telerik:radmaskedtextbox>
				</span></b></span>
			</td>
		</tr>
		<tr>
			<td style="font-size: small; font-weight: bold; text-align: right; width: 100px;
				color: #2C7500" class="tdtable">
				&nbsp;
			</td>
			<td>
				&nbsp;
			</td>
			<td class="tdtable">
				Email:
			</td>
			<td>
				<asp:TextBox ID="tb_Email" runat="server" TabIndex="18" Width="225px"></asp:TextBox>
			</td>
		</tr>
	</table>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Notes</p>
	<table style="width: 800px;">
		<tr>
			<td>
				<asp:TextBox ID="tb_Notes" runat="server" Height="75px" TabIndex="19" TextMode="MultiLine"
					Width="600px"></asp:TextBox>
			</td>
		</tr>
	</table>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Internal Notes</p>
	<table style="width: 800px;">
		<tr>
			<td>
				<asp:TextBox ID="tb_NotesCF" runat="server" Height="75px" TabIndex="19" TextMode="MultiLine"
					Width="600px"></asp:TextBox>
			</td>
		</tr>
	</table>
	<p>
		<asp:Button ID="btnInsert" runat="server" TabIndex="20" Text="Add Account" />
	</p>
	<asp:SqlDataSource ID="sds_CF_Menu_Console" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [DataFieldID], [DataFieldParentID], [DataTextField], [DataNavigateUrlField], [ImageURL] FROM [CF_Menu_Console]">
	</asp:SqlDataSource>
</asp:Content>

