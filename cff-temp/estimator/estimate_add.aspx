<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="estimate_add.aspx.vb" Inherits="cleanfleets_fms.estimate_add" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="RightColumnContentPlaceHolder" runat="server">
<h3>
        Quick Estimate System - Add Account</h3>
    <p>
        &nbsp;</p>
    <table cellpadding="5" cellspacing="0" style="width: 100%">
        <tr>
            <td class="tbltld" style="width: 173px">
                Account Name:</td>
            <td>
                <asp:TextBox ID="tbx_AccountName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 173px">
                &nbsp;</td>
            <td>
                <asp:Button ID="Button1" runat="server" Text="Continue" />
            </td>
        </tr>
    </table>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        <telerik:RadScriptManager ID="RadScriptManager1" Runat="server">
        </telerik:RadScriptManager>
    </p>
    <p>
        <telerik:RadFormDecorator ID="RadFormDecorator1" Runat="server" DecoratedControls="All" Skin="WebBlue" />
    </p>
</asp:Content>
