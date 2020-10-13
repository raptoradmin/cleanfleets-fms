<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="updateVehicleInformation.aspx.vb" Inherits="cleanfleets_fms.updateVehicleInformation" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	An automated process with update information and statistics about Vehicles periodically.  If you'd like to update Vehicle information before the next scheduled time, use the button below.
	<br><br>
	<asp:Label runat="server" id="Results" />
	<br><br>
	<asp:Button runat="server" id="btn_UpdateVehicleInformation" Text="Update Vehicle Information Now" />
</asp:content>
