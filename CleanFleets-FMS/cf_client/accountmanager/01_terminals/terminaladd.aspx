<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="terminaladd.aspx.vb" Inherits="cleanfleets_fms.terminaladd" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Add Terminal<asp:HiddenField ID="hf_AccountNum" runat="server" />
	</p>
	<table style="width: 800px;">
		<tr>
			<td style="width: 100px;" class="tdtable">
				Account Name:
			</td>
			<td>
				<p>
					<asp:Label ID="lbl_AccountName" runat="server" Text="Label"></asp:Label>
				</p>
			</td>
		</tr>
	</table>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Terminal Details</p>
	<table style="width: 800px;">
		<tr>
			<td style="width: 105px;" class="tdtable">
				Terminal Name:
			</td>
			<td>
				<asp:TextBox ID="tb_TerminalName" runat="server" TabIndex="5"></asp:TextBox>
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
			<td style="width: 105px;" class="tdtable">
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
			<td style="width: 105px;" class="tdtable">
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
			<td style="width: 105px;" class="tdtable">
				City:
			</td>
			<td>
				<asp:TextBox ID="tb_City" runat="server" TabIndex="7"></asp:TextBox>
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
			<td style="width: 105px;" class="tdtable">
				State:
			</td>
			<td>
				<asp:TextBox ID="tb_State" runat="server" TabIndex="8"></asp:TextBox>
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
			<td style="width: 105px;" class="tdtable">
				Zip:
			</td>
			<td>
				<asp:TextBox ID="tb_Zip" runat="server" TabIndex="9"></asp:TextBox>
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
	<p>
		<asp:Button ID="btnInsert" runat="server" TabIndex="20" Text="Add Terminal" />
	</p>
</asp:Content>

