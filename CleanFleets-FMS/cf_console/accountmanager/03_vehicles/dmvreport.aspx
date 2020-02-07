<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Console.Master" CodeBehind="dmvreport.aspx.vb" Inherits="cleanfleets_fms.dmvreport" %>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	
    <asp:FileUpload ID="FileUploadControl" runat="server" />
    <asp:Button ID="TestButton" runat="server" Text="Upload" />
    
    <h1>Please enter VIN to autofill existing fields</h1>
    <p>VIN</p>
    <asp:TextBox ID="ChassisVIN" runat="server"></asp:TextBox>
    <asp:Button ID="PopulateFields" Text="Search Records" runat="server" CausesValidation="false"></asp:Button>
    <br />
    <asp:RequiredFieldValidator runat="server" id="ChassisVIN_Validator" controltovalidate="ChassisVIN" errormessage="Please enter the VIN" />
    <asp:Label ID="ChassisVIN_Error" runat="server" CssClass="ui-state-error" Visible="false" Text="VIN not found in existing records, please enter information manually"></asp:Label>
    <h2>Test Fields</h2>
    
    <!-- Form fields begin !-->
    
    <table>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>
                <p>Valid From Date<span style="color:red;">*</span></p>
                <asp:TextBox ID="FromDate"  CssClass="datepicker" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" id="FromDate_Validator" controltovalidate="FromDate" errormessage="Please enter the start date" />
            </td>
            <td>&nbsp;</td>
            <td>
                <p>Valid Through Date<span style="color:red;">*</span></p>
                <asp:TextBox ID="ThroughDate" CssClass="datepicker" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" id="ThroughDate_Validator" controltovalidate="ThroughDate" errormessage="Please enter the expired date" />
                <asp:CompareValidator id="cv_Date" runat="server" 
                 ControlToCompare="FromDate" cultureinvariantvalues="true" 
                 display="Dynamic" enableclientscript="true"  
                 ControlToValidate="ThroughDate" 
                 ErrorMessage="Start date must be earlier than finish date"
                 type="Date" setfocusonerror="true" Operator="GreaterThan" 
                 text="Start date must be earlier than finish date"></asp:CompareValidator>
            </td>
        </tr>
    <!-- ROW BREAK IN PHYSICAL FORM !-->
        <tr>
            <td>
                <p>Make</p>
                <asp:TextBox ID="Make" runat="server"></asp:TextBox>
            </td>
            <td>
                <p>YR Model</p>
                <asp:TextBox ID="Year" runat="server"></asp:TextBox>
            </td>
            <td>
                <p>YR 1st Sold</p>
                <asp:TextBox ID="YrFirstSold" runat="server"></asp:TextBox>
            </td>
            <td>
                <p>VLF Class</p>
                <asp:TextBox ID="VlfClass" runat="server"></asp:TextBox>
            </td>
            <td>
                <p>Type Veh</p>
                <asp:TextBox ID="TypeVeh" runat="server"></asp:TextBox>
            </td>
            <td>
                <p>Type LIC</p>
                <asp:TextBox ID="TypeLic" runat="server"></asp:TextBox>
            </td>
            <td>
                <p>License Number<span style="color:red;">*</span></p>
                <asp:TextBox ID="LicensePlateNo" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" id="LicensePlateNo_Validator" controltovalidate="LicensePlateNo" errormessage="Please enter the License Number" />

            </td>
        </tr>
    
    <!-- ROW BREAK IN PHYSICAL FORM !-->
        <tr>
            <td>
                <p>Body Type Model</p>
                <asp:TextBox ID="BodyType" runat="server"></asp:TextBox>
            </td>
            <td>
                <p>MP</p>
                <asp:TextBox ID="MP" runat="server"></asp:TextBox>
            </td>
            <td>
                <p>MO</p>
                <asp:TextBox ID="MO" runat="server"></asp:TextBox>
            </td>
        </tr>

    <!-- ROW BREAK IN PHYSICAL FROM !-->
        <tr>
            <td>
                <p>Type Vehicle Use</p>
                <asp:TextBox ID="TypeVehicleUse" runat="server"></asp:TextBox>
            </td>
            <td>
                <p>Date Issued<span style="color:red;">*</span></p>
                <asp:TextBox ID="DateIssued" CssClass="datepicker" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" id="DateIssued_Validator" controltovalidate="DateIssued" errormessage="Please enter the date issued" />

            </td>
            <td>
                <p>CC/Alco</p>
                <asp:TextBox ID="CCAlco" runat="server"></asp:TextBox>
            </td>
            <td>
                <p>Date Fee Received<span style="color:red;">*</span></p>
                <asp:TextBox ID="DateFeeReceived" CssClass="datepicker" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" id="DateFeeReceived_Validator" controltovalidate="DateFeeReceived" errormessage="Please enter the fee received date" />

            </td>
            <td>
                <p>PIC</p>
                <asp:TextBox ID="Pic" runat="server"></asp:TextBox>
            </td>
            <td>
                <p>Sticker Issued<span style="color:red;">*</span></p>
                <asp:TextBox ID="StickerIssued" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" id="StickerIssued_Validator" controltovalidate="StickerIssued" errormessage="Please enter the sticker issued" />

            </td>
        </tr>

    <!-- ROW BREAK IN PHYSICAL FORM !-->

        <tr>
            <td>
                <p>Name<span style="color:red;">*</span></p>
                <asp:TextBox ID="Name" runat="server" MaxLength="200"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" id="Name_Validator" controltovalidate="Name" errormessage="Please enter the name" />

            </td>
            <td>
                <p>Amount Paid<span style="color:red;">*</span></p>
                <asp:TextBox ID="AmountPaid" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" id="AmountPaid_Validator" controltovalidate="AmountPaid" errormessage="Please enter the amount paid" />

            </td>
        </tr>
        <tr>
             <td>
                <p>Address<span style="color:red;">*</span></p>
                <asp:TextBox ID="Address" runat="server" MaxLength="200"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" id="Address_Validator" controltovalidate="Address" errormessage="Please enter the address" />

            </td>
        </tr>
    </table>
    <!-- Form fields end !-->
    <asp:Button ID="SubmitRegistration" runat="server" Text="Submit Registration" />
    <script type="text/javascript">
    $(function() {
		$(".datepicker").datepicker();
	});
	</script>
</asp:Content>

