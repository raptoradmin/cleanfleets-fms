<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="accounts_user_del.aspx.vb" Inherits="cleanfleets_fms.accounts_user_del" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <title>Fleet Compliance Management System</title>
    <link rel="stylesheet" type="text/css" href="/includes/styles/cf_style.css"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="RightColumnContentPlaceHolder" runat="server">
<table id="tablePageBodyContainer" class="tablePageBodyContainer">
	<tr>
		<td>
		<table id="tablePageHeader" class="tablePageHeader">
			<tr>
				<td class="tablePageHeaderColumn">
					<div class="divPageHeader">
						<span style="font-size: small">Welcome:</span>
						<asp:LoginName ID="LoginName" runat="server" CssClass="controlLoginName" />
                        <br />
                        <asp:LoginStatus ID="LoginStatus" runat="server" 
                            class="controlLoginStatus" onMouseOver="this.style.color='Black' " 
                            onMouseOut="this.style.color='White' " CssClass="controlLoginStatus" 
                            ForeColor="White"/>
					</div>
				</td>
			</tr>
		</table>
    <table id="tablePageBody" class="tablePageBody">
        <tr>
            <td class="tablePageBodyLeftColumn">
                <telerik:RadPanelBar ID="RadPanelBar1" Runat="server" DataFieldID="DataFieldID" 
                    DataFieldParentID="DataFieldParentID" 
                    DataNavigateUrlField="DataNavigateUrlField" DataSourceID="sds_CF_Menu_Console" 
                    DataTextField="DataTextField" DataValueField="DataTextField" Height="400px" 
                    Skin="Forest" Width="180px" ExpandMode="FullExpandedItem" 
                    PersistStateInCookie="True">
                </telerik:RadPanelBar>
            </td>
            <td class="tablePageBodyRightColumn">
                            <p style="font-size: medium; font-weight: bold; color: #ED8701">
                                Delete Employee</p>
                            <span style="color: #FF0000; font-size: small;">Please confirm the deletion of 
                            this employee.</span><p style="font-size: medium; font-weight: bold; color: #ED8701">
                                <asp:FormView ID="FormView1" runat="server" DataKeyNames="UserID" 
                                    DataSourceID="sds_Contact" style="font-size: small; color: #000000" 
                                    Width="500px">
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <table cellpadding="2" cellspacing="0" style="width: 100%">
                                            <tr>
                                                <td style="text-align: right; color: #2C7500; font-size: small; width: 110px; font-weight: bold;">
                                                    Emplyee ID:</td>
                                                <td>
                                                    <asp:Label ID="lbl_IDProfileContact" runat="server" 
                                                        Font-Bold="False" Font-Size="Small" Text='<%# Eval("IDProfileContact") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; color: #2C7500; font-size: small; width: 110px; font-weight: bold;">
                                                    User Name:</td>
                                                <td>
                                                    <asp:Label ID="lbl_UserName" runat="server" Font-Bold="False" Font-Size="Small" 
                                                        Text='<%# Bind("UserName") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; color: #2C7500; font-size: small; width: 110px; font-weight: bold;">
                                                    Last Name:
                                                </td>
                                                <td>
                                                    <asp:Label ID="LastNameLabel" runat="server" Font-Bold="False" 
                                                        Font-Size="Small" Text='<%# Bind("LastName") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; color: #2C7500; font-size: small; width: 110px; font-weight: bold;">
                                                    First Name:</td>
                                                <td>
                                                    <asp:Label ID="FirstNameLabel" runat="server" Font-Bold="False" 
                                                        Font-Size="Small" Text='<%# Bind("FirstName") %>' />
                                                </td>
                                            </tr>
                                        </table>
                                        
                                        <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" 
                CommandName="Delete" Text="Delete" onclick="DeleteButton_Click" />

                                        <br />
                                        <br />
                                        <asp:HiddenField ID="hf_IDProfileAccount" runat="server" Value='<%# Bind("IDProfileAccount") %>' />

                                        <asp:Label ID="lbl_IDProfileAccount" runat="server" Font-Bold="False" 
                                            Font-Size="XX-Small" Text='<%# Bind("IDProfileAccount") %>' 
                                            ForeColor="White" />

                                    </ItemTemplate>
                                </asp:FormView>
                            </p>
                            <p style="font-size: medium; font-weight: bold; color: #ED8701">&nbsp;
                                </p>
                            <p style="font-size: medium; font-weight: bold; color: #ED8701">&nbsp;
                                </p>
            </td>
       </table>
    
</table>
    
        
    <table class="tablePageFooter">
        <tr>
            <td>
                <!--#include virtual ="/includes/footer.htm" --></td>
        </tr>
    </table>
                            <asp:SqlDataSource ID="sds_CF_Menu_Console" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
                                SelectCommand="SELECT [DataFieldID], [DataFieldParentID], [DataTextField], [DataNavigateUrlField], [ImageURL] FROM [CF_Menu_Console]">
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="sds_Contact" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>" 
        DeleteCommand="DELETE FROM [aspnet_Users] WHERE [UserID] = @UserID" 
        InsertCommand="INSERT INTO [CF_Profile_Contact] ([UserID], [IDModifiedUser], [ModifiedDate], [LastName], [FirstName], [IDProfileAccount]) VALUES (@UserID, @IDModifiedUser, @ModifiedDate, @LastName, @FirstName, @IDProfileAccount)" 
        SelectCommand="SELECT [UserID], [UserName], [IDModifiedUser], [ModifiedDate], [LastName], [FirstName], [IDProfileContact], [IDProfileAccount] FROM [CF_Profile_Contact] WHERE ([IDProfileContact] = @IDProfileContact)" 
        
        
        UpdateCommand="UPDATE [CF_Profile_Contact] SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate, [LastName] = @LastName, [FirstName] = @FirstName, [IDProfileContact] = @IDProfileContact, [IDProfileAccount] = @IDProfileAccount WHERE [UserID] = @UserID">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="IDProfileContact" 
                                        QueryStringField="IDProfileContact" Type="Int32" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="UserID" Type="Object" />
                                </DeleteParameters>
                                <UpdateParameters>
                                </UpdateParameters>
                                <InsertParameters>
                                </InsertParameters>
    </asp:SqlDataSource>
                            <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
                            </telerik:RadScriptManager>
                            <telerik:RadFormDecorator ID="RadFormDecorator1" 
        runat="server" DecoratedControls="All"
                                Skin="Forest" />
</asp:Content>
