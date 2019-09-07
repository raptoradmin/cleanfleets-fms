<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="ChangePassword.aspx.vb" Inherits="cleanfleets_fms.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="RightColumnContentPlaceHolder" runat="server">
    <h2>Change Your Password</h2>
    <p>
        <asp:ChangePassword ID="ChangePwd" runat="server">
            <MailDefinition 
                IsBodyHtml="True" Subject="Your password has been changed!">
            </MailDefinition>
        </asp:ChangePassword>
    </p>
</asp:Content>
