<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="dmvreport.aspx.vb" Inherits="cleanfleets_fms.dmvreport" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	
    <asp:FileUpload ID="FileUploadControl" runat="server" />
    <asp:Button ID="TestButton" runat="server" Text="Upload" />
    
    <h1>Please enter VIN to autofill existing fields</h1>
    <asp:TextBox ID="ChassisVIN" runat="server"></asp:TextBox>
    <asp:Button ID="PopulateFields" Text="Search Records" runat="server"></asp:Button>
    <br />
    <asp:Label ID="ChassisVIN_Error" runat="server" CssClass="ui-state-error" Visible="false" Text="VIN not found in existing records, please enter information manually"></asp:Label>
    <h2>Test Fields</h2>
    
    <!-- Form fields begin !-->
    <p>Valid From Date</p>
    <asp:TextBox ID="FromDate"  CssClass="datepicker" runat="server"></asp:TextBox>

    <p>Valid Through Date</p>
    <asp:TextBox ID="ThroughDate" CssClass="datepicker" runat="server"></asp:TextBox>
    <asp:CompareValidator id="cv_Date" runat="server" 
     ControlToCompare="FromDate" cultureinvariantvalues="true" 
     display="Dynamic" enableclientscript="true"  
     ControlToValidate="ThroughDate" 
     ErrorMessage="Start date must be earlier than finish date"
     type="Date" setfocusonerror="true" Operator="GreaterThan" 
     text="Start date must be earlier than finish date"></asp:CompareValidator>

    <!-- ROW BREAK IN PHYSICAL FORM !-->

    <p>Make</p>
    <asp:TextBox ID="Make" runat="server"></asp:TextBox>
    <br /><br />

    <p>YR Model</p>
    <asp:TextBox ID="Year" runat="server"></asp:TextBox>
    <br /><br />

    <p>YR 1st Sold</p>
    <asp:TextBox ID="YrFirstSold" runat="server"></asp:TextBox>
    <br /><br />

    <p>VLF Class</p>
    <asp:TextBox ID="VlfClass" runat="server"></asp:TextBox>
    <br /><br />

    <p>Type Veh</p>
    <asp:TextBox ID="TypeVeh" runat="server"></asp:TextBox>
    <br /><br />

    <p>Type LIC</p>
    <asp:TextBox ID="TypeLic" runat="server"></asp:TextBox>
    <br /><br />

    <p>License Number</p>
    <asp:TextBox ID="LicensePlateNo" runat="server"></asp:TextBox>
    <br /><br />

    <!-- ROW BREAK IN PHYSICAL FORM !-->

    <p>Body Type Model</p>
    <asp:TextBox ID="BodyType" runat="server"></asp:TextBox>

    <p>MP</p>
    <asp:TextBox ID="MP" runat="server"></asp:TextBox>

    <p>MO</p>
    <asp:TextBox ID="MO" runat="server"></asp:TextBox>

    <!-- ROW BREAK IN PHYSICAL FROM !-->

    <p>Type Vehicle Use</p>
    <asp:TextBox ID="TypeVehicleUse" runat="server"></asp:TextBox>
    
    <p>Date Issued</p>
    <asp:TextBox ID="DateIssued" CssClass="datepicker" runat="server"></asp:TextBox>

    <p>CC/Alco</p>
    <asp:TextBox ID="CCAlco" runat="server"></asp:TextBox>

    <p>Date Fee Received</p>
    <asp:TextBox ID="DateFeeReceived" CssClass="datepicker" runat="server"></asp:TextBox>

    <p>PIC</p>
    <asp:TextBox ID="Pic" runat="server"></asp:TextBox>

    <p>Sticker Issued</p>
    <asp:TextBox ID="StickerIssued" runat="server"></asp:TextBox>

    <!-- ROW BREAK IN PHYSICAL FORM !-->


    <p>Name</p>
    <asp:TextBox ID="Name" runat="server"></asp:TextBox>

    <p>Address</p>
    <asp:TextBox ID="Address" runat="server"></asp:TextBox>

    <p>Amount Paid</p>
    <asp:TextBox ID="AmountPaid" runat="server"></asp:TextBox>
    <!-- Form fields end !-->
    <asp:Button ID="SubmitRegistration" runat="server" Text="Submit Registration" />
    <script type="text/javascript">
    $(function() {
		$(".datepicker").datepicker();
	});
	</script>
</asp:Content>

