<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="default.aspx.vb" Inherits="cleanfleets_fms._default4" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<table cellpadding="0" cellspacing="0" style="width: 100%; height: 30px">
		<tr>
			<td style="font-size: medium; color: #ED8701">
				<b>Analysis Center</b>
			</td>
		</tr>
	</table>
	<asp:SqlDataSource ID="sds_Profile_Account" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT count (*) FROM [CF_Profile_Account]"></asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Profile_Terminal" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT count (*) FROM [CF_Profile_Terminal]"></asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_Profile_Fleet" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT count (*) FROM [CF_Profile_Fleet]"></asp:SqlDataSource>
</asp:Content>
