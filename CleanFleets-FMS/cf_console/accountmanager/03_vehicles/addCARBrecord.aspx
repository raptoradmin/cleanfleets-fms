<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="addCARBrecord.aspx.vb" Inherits="cleanfleets_fms.addCARBrecord" %>

<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">

    <div id="DateValidationPrompt" runat="server" visible="false"></div>
    <div id="SuccessfulPrompt" runat="server" visible="false"></div>
    <div id="HappenedValidationPrompt" runat="server" visible="false"></div>

	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Add CARB Communication Record Section
	</p>
    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td>
                &#160;</td>
        </tr>
    </table>

    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td style="width: 200px; " class="tdtable">
                Did CARB Communication Happen?:
            </td>
            <td>
                <asp:TextBox ID="TextBox_CARB_Happened" runat="server" Text="Type a 'Yes' or an 'No'." />
            </td>
            <td style="width: 200px; " class="tdtable">
                Initial CARB Communication Date:
            </td>
            <td>
                <asp:TextBox ID="TextBox_CARB_Date" runat="server" Text="DD/MM/YYYY" />
            </td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td>
                &#160;</td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td>
                &#160;</td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td>
                &#160;</td>
        </tr>
    </table>
    <p style="font-size: medium; font-weight: bold; color: #ED8701">
		CARB Communication Issue:</p>
	<table style="width: 800px;">
		<tr>
			<td>
				<asp:TextBox ID="TextBox_CARB_Issue" runat="server" Height="75px" TabIndex="19" TextMode="MultiLine"
					Width="600px"></asp:TextBox>
			</td>
		</tr>
	</table>
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		CARB Communication Resolution:</p>
	<table style="width: 800px;">
		<tr>
			<td>
				<asp:TextBox ID="TextBox_CARB_Resolution" runat="server" Height="75px" TabIndex="19" TextMode="MultiLine"
					Width="600px"></asp:TextBox>
			</td>
		</tr>
	</table>
    <%--<table cellpadding="0" cellspacing="0" style="width: 800px;">
        <tr>
            <td style="width: 200px; " class="tdtable">
                CARB Communication Issue:
            </td>
            <td>
                <asp:TextBox ID="TextBox_CARB_Issue" runat="server" Width="150px" Text="If there was an issue related to CARB Communication, please enter it." />
            </td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td>
                &#160;</td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td>
                &#160;</td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td>
                &#160;</td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td style="width: 200px; " class="tdtable">
                CARB Communication Resolution:
            </td>
            <td>
                <asp:Label ID="lbl_CARB_Resolution" runat="server" Text='<%# Bind("CARB_Resolution") %>' />
            </td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td>
                &#160;</td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td>
                &#160;</td>
        </tr>
    </table>--%>
    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td>
                &#160;</td>
        </tr>
    </table>
    <asp:Button ID="AddCARBButton" runat="server" Text="Add CARB Record" OnClick="AddCARBButton_Click" />
</asp:Content>
