<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="default.aspx.vb" Inherits="cleanfleets_fms._default" %>

<%@ Register Src="~/controls/Footer.ascx" TagPrefix="uc1" TagName="Footer" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="/includes/styles/cf_style.css" />
</head>
<body>
    <form id="form1" runat="server" defaultfocus="Login1_UserName">


        <table class="tableLoginPageHeader">
            <tr>
                <td>&nbsp;
                </td>
            </tr>

        </table>
        <table id="tableLoginPageBody" class="tableLoginPageBody">
            <tr>
                <td>
                    <h2>&nbsp;</h2>
                    <h2>Welcome to the CleanFleets.net</h2>
                    <h1>Fleet Compliance Management System</h1>
                    <h3>If you are a registered user, please login.</h3>
                    <div class="controlLogin">
                        <div>
                            <asp:Login ID="Login1" runat="server" Width="273px">
                                <LayoutTemplate>
                                    <table border="0" cellpadding="1" cellspacing="0"
                                        style="border-collapse: collapse;">
                                        <tr>
                                            <td>
                                                <table border="0" cellpadding="0" style="width: 273px;">
                                                    <tr>
                                                        <td align="center" colspan="2">&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="UserName" runat="server" Width="150px"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server"
                                                                ControlToValidate="UserName" ErrorMessage="User Name is required."
                                                                ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="150px"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server"
                                                                ControlToValidate="Password" ErrorMessage="Password is required."
                                                                ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me next time." />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" colspan="2" style="color: Red;">
                                                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td align="right" colspan="2" style="text-align: center">
                                                            <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In"
                                                                ValidationGroup="Login1" />
                                                            <!-- MG 12/14/2011 - need mail server
													 <asp:Button ID="ForgotPWButton" runat="server" CommandName="ForgotPassword" Text="Forgot Password" 
													   OnClick="ForgotPWButton_click"/>
													   -->
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </LayoutTemplate>
                            </asp:Login>
                        </div>
                    </div>
                    <br />

                </td>
            </tr>
        </table>

        <uc1:Footer runat="server" ID="Footer" />


        <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server"
            Skin="Forest" />
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
    </form>
</body>
</html>
