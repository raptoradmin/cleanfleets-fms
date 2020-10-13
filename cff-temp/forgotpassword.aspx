<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="forgotpassword.aspx.vb" Inherits="cleanfleets_fms.forgotpassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
<asp:PasswordRecovery ID="PasswordRecovery1" runat="server" BackColor="#F7F6F3" 
            BorderColor="#E6E2D8" BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" 
            Font-Names="Verdana" Font-Size="Large" 
            Width="532px" >                           
                <MailDefinition From="support@cleanfleets.net" Subject="CleanFleets.Net Forgetton Password" Priority="High">
                </MailDefinition>
                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                <SuccessTextStyle Font-Bold="True" ForeColor="#5D7B9D" />
                <TextBoxStyle Font-Size=Medium />
                <UserNameTemplate>
                    <span style="text-align:center">
                    <font face="Verdana">
                    <h3>Forgot Password </h3>
					<p>Please enter your username below to have your password sent to your email address on file.</p>
                    User Name: <asp:TextBox ID="UserName" runat="server" 
                        Width="236px"></asp:TextBox>&nbsp;
                        <asp:Button ID="SubmitButton" runat="server" OnClick="ReturnToLogin"
                        Text="Send" CommandName="Submit" />&nbsp;
                        <asp:Button runat="server" id="btn_cancel1" Text="Cancel" OnClick="ReturnToLogin"/><br />
                    <span  style="color: #FF0000">
                    <asp:Literal ID="FailureText" runat="server"></asp:Literal>
                    </span>
                    </font> 
                    </span>                    
                </UserNameTemplate>
                <QuestionTemplate>
                <h2>Forgot Password</h2>
                Hello <asp:Literal ID="UserName" runat="server"></asp:Literal><br />
                Please answer your password question : <br />
                <asp:Literal ID="Question" runat="server"></asp:Literal>
                <asp:TextBox ID="Answer" runat="server"></asp:TextBox><br />
                 <asp:Button ID="SubmitButton" runat="server" Text="Send Answer By Mail" 
CommandName="Submit"/><br />
                  <asp:Literal ID="FailureText" runat="server"></asp:Literal>
                </QuestionTemplate>
                <SuccessTemplate>
                Your password has been sent to your email address
                <asp:Label ID="EmailLabel" runat="server"></asp:Label>
				<asp:Button runat="server" id="btn_login1" Text="Return to Login" OnClick="returnToLogin" />
                </SuccessTemplate>
                <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="0.9em" 
                    ForeColor="White" />
                <SubmitButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" 
                    BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" 
                    ForeColor="#284775" />
        </asp:PasswordRecovery>
		
    </form>
    </body>

</html>
