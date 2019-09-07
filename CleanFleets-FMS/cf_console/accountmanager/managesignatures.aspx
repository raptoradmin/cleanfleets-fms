<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="managesignatures.aspx.vb" Inherits="cleanfleets_fms.managesignatures" %>
<asp:Content ID="Content1" ContentPlaceHolderID="RightColumnContentPlaceHolder" Runat="Server">
    <div id="dvSectionManage" runat="server">
		<h1>Upload Signatures</h1>
		<div id="dvImportFile" runat="server">
			<p>
				Upload signatures in either .PNG or .JPG formats. Signatures uploaded will be matched on first and last name (PSIP Tester will be separated by spaces to match First and Last name. If only the Last Name is on the Test Results, it'll be matched with either the signature's First or Last Name). Feel free to create multiple signatures for potential matches.  If no match is found, a new record will be created. If a match is found, then the record will be updated.
			</p>
			<table ID="tblImportFile" runat="server" cellpadding="0" cellspacing="0" class="style1">
				<tr>
					<td class="tdtable" style="padding: 3px" align="left">
						<asp:Label ID="Label1" runat="server" AssociatedControlID="txb_FirstName">First Name:</asp:Label>
					</td>
					<td style="padding: 3px" align="left">
						<asp:TextBox ID="txb_FirstName" runat="server"></asp:TextBox>
						<%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="txb_FirstName" ErrorMessage="Please enter your first name." />--%>
					</td>
				</tr>
				<tr>
					<td class="tdtable" style="padding: 3px" align="left">
						<asp:Label ID="Label3" runat="server" AssociatedControlID="txb_LastName">Last Name:</asp:Label>
					</td>
					<td style="padding: 3px" align="left">
						<asp:TextBox ID="txb_LastName" runat="server"></asp:TextBox>
						<%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="txb_LastName" ErrorMessage="Please enter your last name" />--%>
					</td>
				</tr>
				<tr>
					<td class="tdtable" style="padding: 3px" align="left">
						<asp:Label ID="Label2" runat="server" AssociatedControlID="fu_ImportFile">Text File:</asp:Label>
					</td>
					<td style="padding: 3px" align="left">
						<asp:FileUpload ID="fu_ImportFile" runat="server" accept="image/png, image/jpeg" />
						<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="fu_ImportFile" ErrorMessage="Please choose a image file to import." />
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2" align="left"><br/>
						<asp:Button ID="btnImport" runat="server" TabIndex="20" Text="Import" /> 			
					</td>
				</tr>
			</table>
		</div>
		<table>
			<tr>
				<td colspan="2" align="left"><br/>
					<asp:Label ID="Messages" runat="server" />
				</td>
			</tr>
		</table>
		<h1>Existing Signatures</h1>
		<telerik:radgrid ID="rg_Signatures" runat="server" AutoGenerateColumns="false" CellPadding="2" CellSpacing="0">
				<MasterTableView Width="100%" AutoGenerateColumns="False">
					<Columns>
						<telerik:GridBoundColumn DataField="FirstName" HeaderText="First Name" UniqueName="FirstName"></telerik:GridBoundColumn>
						<telerik:GridBoundColumn DataField="LastName" HeaderText="Last Name" UniqueName="LastName"></telerik:GridBoundColumn>
						<telerik:GridBoundColumn DataField="FilePath" HeaderText="Signature" UniqueName="FilePath"></telerik:GridBoundColumn>
						<telerik:GridImageColumn DataImageUrlFields="FilePath" HeaderText="Signature" ImageWidth="100px"></telerik:GridImageColumn>
						<telerik:GridTemplateColumn HeaderText="" AllowFiltering="false" >
							<ItemTemplate>
								<asp:Button ID="btnDeleteSignature" runat="server" CausesValidation="false" CommandName="DeleteSignature" Text="Delete Signature" CommandArgument='<%# Eval("IDSignature") %>' />
							</ItemTemplate>
						</telerik:GridTemplateColumn>
					</Columns>
				</MasterTableView>
		</telerik:radgrid>
	</div>
</asp:Content>


