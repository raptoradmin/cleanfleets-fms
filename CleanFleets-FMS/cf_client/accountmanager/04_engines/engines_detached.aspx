<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="engines_detached.aspx.vb" Inherits="cleanfleets_fms.engines_detached" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content runat="server" ContentPlaceHolderID="head">

	<script type="text/javascript">
		function RowClick(sender, eventArgs) {
			var MasterTableView = eventArgs.get_tableView();
			var cell = MasterTableView.getCellByColumnUniqueName(MasterTableView.get_dataItems()[eventArgs.get_itemIndexHierarchical()], "IDImages");
			var oWnd = radopen("../../imagemanager/imagedisplay.aspx?IDImages=" + cell.innerHTML);
		}
	</script>

	<telerik:radcodeblock id="RadCodeBlock1" runat="server">

            <script type="text/javascript">

            	function RowClick(sender, eventArgs) {
            		var MasterTableView = eventArgs.get_tableView();
            		var dataKeyValue = eventArgs.getDataKeyValue("IDImages");
            		var oWnd = radopen("../../../includes/imagemanager/imagedisplay.aspx?IDImages=" + dataKeyValue);
            	}

            	function MyClickEngines(sender, eventArgs) {
            		var inputs = document.getElementById("<%= rg_EngineImages.MasterTableView.ClientID %>").getElementsByTagName("input");
            		for (var i = 0, l = inputs.length; i < l; i++) {
            			var input = inputs[i];
            			if (input.type != "radio" || input == sender)
            				continue;
            			input.checked = false;
            		}
            	}

            	function MyClickDECS(sender, eventArgs) {
            		var inputs = document.getElementById("<%= rg_DECSImages.MasterTableView.ClientID %>").getElementsByTagName("input");
            		for (var i = 0, l = inputs.length; i < l; i++) {
            			var input = inputs[i];
            			if (input.type != "radio" || input == sender)
            				continue;
            			input.checked = false;
            		}
            	}
                         
            </script>            

         </telerik:radcodeblock>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<span style="color: #ED8701; font-size: medium; font-weight: bold">Detached Engines<br />
	</span>
	<table cellpadding="0" cellspacing="0" style="width: 100%">
		<tr>
			<td>
				&nbsp;
			</td>
		</tr>
	</table>
	<telerik:radgrid id="rg_Engines" runat="server" datakeynames="IDEngines" datasourceid="sds_CFV_Engines_Grid"
		gridlines="None" pagesize="5" showfooter="True" skin="WebBlue" width="500px"
		allowsorting="True">
                                                <mastertableview autogeneratecolumns="False" datakeynames="IDEngines" datasourceid="sds_CFV_Engines_Grid">
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="IDEngines" DataType="System.Int32" DefaultInsertValue="" HeaderText="IDEngines" ReadOnly="True" SortExpression="IDEngines" UniqueName="IDEngines">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="SerialNum" DefaultInsertValue="" HeaderText="SerialNum" SortExpression="SerialNum" UniqueName="SerialNum">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="FamilyName" DefaultInsertValue="" HeaderText="FamilyName" SortExpression="FamilyName" UniqueName="FamilyName">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="SeriesModelNo" DefaultInsertValue="" HeaderText="SeriesModelNo" SortExpression="SeriesModelNo" UniqueName="SeriesModelNo">
                                                        </telerik:GridBoundColumn>
                                                    </Columns>
                                                </mastertableview>
                                                <clientsettings enablepostbackonrowclick="True">
                                                    <selecting allowrowselect="True" />
                                                </clientsettings>
                                            </telerik:radgrid>
	<p>
		&nbsp;
	</p>
	<telerik:radtabstrip id="RadTabStrip1" runat="server" multipageid="rmp_Engines" selectedindex="0">
                                    <tabs>
                                        <telerik:RadTab runat="server" PageViewID="rpv_EngineDetails" 
                                            Text="Engine Details" Selected="True">
                                        </telerik:RadTab>
                                        <telerik:RadTab runat="server" PageViewID="rmp_EngineFiles" Text="Engine Files">
                                        </telerik:RadTab>
                                    </tabs>
                                </telerik:radtabstrip>
	<telerik:radmultipage id="rmp_Engines" runat="server" selectedindex="0">
                                        <telerik:RadPageView ID="rpv_EngineDetails" runat="server">
        <table cellpadding="0" cellspacing="0" style="width: 100%">
            <tr>
                <td style="padding: 5px; border: 1px solid #9B9B9B;">
                    <table cellpadding="0" style="width: 920px; border-collapse: collapse; border: 1px solid #9B9B9B">
                        <tr>
                            <td style="padding: 4px" valign="top" width="700px">
                                <asp:FormView ID="fv_EngineDetails" runat="server" CellPadding="5" DataKeyNames="IDEngines" DataSourceID="sds_CFV_Engines_fv" Font-Size="Small" Width="700px">
                                    <EditItemTemplate>
                                        <table style="width: 661px">
                                            <tr>
                                                <td class="tdtable" style="width: 90px;">
                                                    Serial No:</td>
                                                <td style="width: 125px;">
                                                    <asp:TextBox ID="SerialNumTextBox" runat="server" Text='<%# Bind("SerialNum") %>' Width="100px" />
                                                </td>
                                                <td class="tdtable" style="width: 92px;">
                                                    Model:</td>
                                                <td style="width: 135px;">
                                                    <telerik:RadComboBox ID="RadComboBox1" Runat="server" AllowCustomText="True" DataSourceID="sds_ddl_Op_EngineModel" DataTextField="EngineModel" DataValueField="EngineModel" EmptyMessage="Select" Skin="WebBlue" Text='<%# Bind("EngineModel") %>' Width="150px">
                                                    </telerik:RadComboBox>
                                                </td>
                                                </td>
                                                <td class="tdtable" style="width: 98px;">
                                                    Horsepower:</td>
                                                <td>
                                                    <asp:TextBox ID="HorsepowerTextBox" runat="server" Text='<%# Bind("Horsepower") %>' Width="100px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdtable" style="width: 90px;">
                                                    Manufacturer:</td>
                                                <td style="width: 125px;">
                                                    <asp:DropDownList ID="ddl_IDEngineManufacturer" runat="server" AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_EngineManufacturer" DataTextField="DisplayValue" DataValueField="IDOptionList" SelectedValue='<%# Bind("IDEngineManufacturer") %>'>
                                                        <asp:ListItem Text="Select" Value="" />
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="tdtable" style="width: 92px;">
                                                    Model No:</td>
                                                <td style="width: 135px;">
                                                    <asp:TextBox ID="SeriesModelNoTextBox" runat="server" Text='<%# Bind("SeriesModelNo") %>' Width="100px" />
                                                </td>
                                                <td class="tdtable" style="width: 98px;">
                                                    Status:</td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_IDEngineStatus" runat="server" AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_EngineStatus" DataTextField="DisplayValue" DataValueField="IDOptionList" SelectedValue='<%# Bind("IDEngineStatus") %>'>
                                                        <asp:ListItem Text="Select" Value="" />
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdtable" style="width: 90px;">
                                                    Family Name:<td style="width: 125px;">
                                                        <asp:TextBox ID="FamilyNameTextBox" runat="server" Text='<%# Bind("FamilyName") %>' Width="100px" />
                                                    </td>
                                                    <td class="tdtable" style="width: 92px;">
                                                        Model Year:</td>
                                                    <td style="width: 135px;">
                                                        <asp:DropDownList ID="ddl_ModelYear" runat="server" AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_Year" DataTextField="DisplayValue" DataValueField="IDOptionList" SelectedValue='<%# Bind("IDModelYear") %>'>
                                                            <asp:ListItem Text="Select" Value="" />
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="tdtable" style="width: 98px;">
                                                        Fuel Type:</td>
                                                    <td>
                                                        <asp:DropDownList ID="ddl_IDEngineFuelType" runat="server" AppendDataBoundItems="True" DataSourceID="sds_ddl_Op_EngineFuelType" DataTextField="DisplayValue" DataValueField="IDOptionList" SelectedValue='<%# Bind("IDEngineFuelType") %>'>
                                                            <asp:ListItem Text="Select" Value="" />
                                                        </asp:DropDownList>
                                                    </td>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <span style="color: #2C7500"><b>Description:</b></span><br />
                                        &#160;&#160;<table>
                                            <tr>
                                                <td width="25px">
                                                    &#160;
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="DescriptionTextBox" runat="server" Height="65px" Text='<%# Bind("Description") %>' TextMode="MultiLine" Width="600px" />
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <span style="color: #2C7500"><b>Notes:<br />
                                        </b></span>
                                        <table>
                                            <tr>
                                                <td width="25px">
                                                    &#160;
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="NotesTextBox" runat="server" Height="65px" Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="600px" />
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <b><span style="color: #2C7500">Internal Notes:</span></b><br />
                                        <table>
                                            <tr>
                                                <td width="25px">
                                                    &#160;
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="NotesCFTextBox" runat="server" Height="65px" Text='<%# Bind("NotesCF") %>' TextMode="MultiLine" Width="600px" />
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                   <%--                     <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                        &#160;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
                                        <br />
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <table style="width: 665px">
                                            <tr>
                                                <td class="tdtable">
                                                    Serial No:</td>
                                                <td style="width: 150px">
                                                    <asp:Label ID="lbl_ESerialNum" runat="server" Text='<%# Bind("SerialNum") %>' />
                                                </td>
                                                <td class="tdtable" style="width: 85px; ">
                                                    Model:</td>
                                                <td style="width: 135px">
                                                    <asp:Label ID="lbl_EModel" runat="server" Text='<%# Bind("EngineModel") %>' />
                                                </td>
                                                <td class="tdtable">
                                                    Horsepower:</td>
                                                <td style="width: 95px">
                                                    <asp:Label ID="lbl_EHP" runat="server" Text='<%# Bind("Horsepower") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdtable">
                                                    Manufacturer:</td>
                                                <td style="width: 150px">
                                                    <asp:Label ID="lbl_EManu" runat="server" Text='<%# Bind("EngineManufacturer") %>' />
                                                </td>
                                                <td class="tdtable" style="width: 85px; ">
                                                    Model No:</td>
                                                <td style="width: 135px">
                                                    <asp:Label ID="lbl_ESerModNo" runat="server" Text='<%# Bind("SeriesModelNo") %>' />
                                                </td>
                                                <td class="tdtable">
                                                    Status:</td>
                                                <td style="width: 95px">
                                                    <asp:Label ID="lbl_EStatus" runat="server" Text='<%# Bind("EngineStatus") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdtable">
                                                    Family Name:<td style="width: 150px">
                                                        <asp:Label ID="lbl_EFamily" runat="server" Text='<%# Bind("FamilyName") %>' />
                                                    </td>
                                                    <td class="tdtable" style="width: 85px; ">
                                                        Model Year:</td>
                                                    <td style="width: 135px">
                                                        <asp:Label ID="lbl_EYear" runat="server" Text='<%# Bind("ModelYear") %>' />
                                                    </td>
                                                    <td class="tdtable">
                                                        Fuel Type:</td>
                                                    <td style="width: 95px">
                                                        <asp:Label ID="lbl_EFuelType" runat="server" Text='<%# Bind("EngineFuelType") %>' />
                                                    </td>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <span style="color: #2C7500"><b>Description:</b></span><br />
                                        &#160;
                                        <table style="width: 400px">
                                            <tr>
                                                <td width="25px">
                                                    &#160;
                                                </td>
                                                <td>
                                                    <div class="divlblScrollText">
                                                        <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description").ToString().Replace(Environment.NewLine,"<br />") %>' />
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <span style="color: #2C7500"><b>Notes:<br />
                                        </b></span>
                                        <table style="width: 400px">
                                            <tr>
                                                <td width="25px">
                                                    &#160;
                                                </td>
                                                <td>
                                                    <div class="divlblScrollText">
                                                        <asp:Label ID="NotesLabel" runat="server" Text='<%# Eval("Notes").ToString().Replace(Environment.NewLine,"<br />") %>' />
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <b><span style="color: #2C7500">Internal Notes:</span></b><br />
                                        <table style="width: 400px">
                                            <tr>
                                                <td width="25px">
                                                    &#160;
                                                </td>
                                                <td>
                                                    <div class="divlblScrollText">
                                                        <asp:Label ID="NotesCFLabel" runat="server" Text='<%# Eval("NotesCF").ToString().Replace(Environment.NewLine,"<br />") %>' />
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
<%--<asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />--%>
                                        &#160;&#160;<asp:HiddenField ID="hf_IDEngines" runat="server" Value='<%# Bind("IDEngines") %>' />
                                    </ItemTemplate>
                                </asp:FormView>
                            </td>
                            <td style="padding: 5px; border-left-style: solid; border-left-width: 1px; border-left-color: #9B9B9B" valign="top">
                                <asp:FormView ID="fv_EngineImage" runat="server" DataKeyNames="IDImages" DataSourceID="sds_ImagesEngines_fvw">
                                    <ItemTemplate>
                                        <asp:Image ID="image0" runat="server" Height="133" ImageUrl='<%#Eval("Image") %>' Width="200" />
                                    </ItemTemplate>
                                </asp:FormView>
                                <br />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table #9b9b9b"="" 1px="" border-collapse:="" border:="" cellpadding="0" collapse;="" solid="" style="width: 920px; border-collapse: collapse; border: 1px solid #9B9B9B">
                        <tr>
                            <td style="padding: 4px" valign="top" width="700px">
                                <table cellpadding="0" cellspacing="0" style="width: 100%; height: 30px;">
                                    <tr>
                                        <td>
                                            <span style="color: #ED8701; font-size: medium; font-weight: bold">Diesel Engine Emissions Control System</span></td>
                                    </tr>
                                </table>
                                <asp:FormView ID="fv_DECSDetails" runat="server" DataKeyNames="IDDECs" DataSourceID="sds_CFV_DECs_fv" Width="700px">
                                    <EditItemTemplate>
                                        <table style="width: 100%">
                                            <tr>
                                                <td class="tdtable">
                                                    ID:</td>
                                                <td style="height: 20px">
                                                    <asp:Label ID="IDDECsLabel1" runat="server" Text='<%# Eval("IDDECs") %>' />
                                                </td>
                                                <td class="tdtable">
                                                    Model No:</td>
                                                <td style="height: 20px">
                                                    <asp:TextBox ID="DECSModelNoTextBox" runat="server" Text='<%# Bind("DECSModelNo") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdtable">
                                                    Name:</td>
                                                <td>
                                                    <asp:TextBox ID="DECSNameTextBox" runat="server" Text='<%# Bind("DECSName") %>' />
                                                </td>
                                                <td class="tdtable">
                                                    Level:</td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_IDDECsLevel" runat="server" AppendDataBoundItems="True" DataSourceID="sds_ddl_DECs_Op_Level" DataTextField="DisplayValue" DataValueField="IDOptionList" SelectedValue='<%# Bind("IDDECSLevel") %>'>
                                                        <asp:ListItem Text="Select" Value="" />
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdtable">
                                                    Manufacturer:</td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_IDDECsManufacturer" runat="server" AppendDataBoundItems="True" DataSourceID="sds_ddl_DECs_Op_Manufacturer" DataTextField="DisplayValue" DataValueField="IDOptionList" SelectedValue='<%# Bind("IDDECSManufacturer") %>'>
                                                        <asp:ListItem Text="Select" Value="" />
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="tdtable">
                                                    Install Date:</td>
                                                <td>
                                                    <telerik:RadDatePicker ID="rdp_DECSInstallationDate" Runat="server" Culture="English (United States)" DbSelectedDate='<%# Bind("DECSInstallationDate") %>'>
                                                        <calendar usecolumnheadersasselectors="False" userowheadersasselectors="False" viewselectortext="x">
                                                        </calendar>
                                                        <datepopupbutton hoverimageurl="" imageurl="" />
                                                        <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" enabledstyle-horizontalalign="Center">
                                                            <enabledstyle horizontalalign="Center" />
                                                        </dateinput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <br />
                                        <span style="color: #2C7500"><b>Notes:</b></span><br />
                                        <table style="width: 100%">
                                            <tr>
                                                <td width="25px">
                                                    &#160;
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="ntb_Notes_DECs" runat="server" Height="65px" Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="650px" />
                                                    <br />
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <b><span style="color: #2C7500">Internal Notes:</span></b><br />
                                        <table style="width: 100%">
                                            <tr>
                                                <td width="25px">
                                                    &#160;
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="ntb_NotesCF_DECs" runat="server" Height="65px" Text='<%# Bind("NotesCF") %>' TextMode="MultiLine" Width="650px" />
                                                </td>
                                            </tr>
                                        </table>
                                        &#160;<br />
<%--                                        <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                        &#160;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />--%>
                                        <br />
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <table style="width: 100%">
                                            <tr>
                                                <td class="tdtable">
                                                    ID:</td>
                                                <td style="height: 20px">
                                                    <asp:Label ID="IDDECsLabel" runat="server" Text='<%# Eval("IDDECs") %>' />
                                                </td>
                                                <td class="tdtable">
                                                    Model No:</td>
                                                <td style="height: 20px">
                                                    <asp:Label ID="DECSModelNoLabel" runat="server" Text='<%# Bind("DECSModelNo") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdtable">
                                                    Name:</td>
                                                <td>
                                                    <asp:Label ID="DECSNameLabel" runat="server" Text='<%# Bind("DECSName") %>' />
                                                </td>
                                                <td class="tdtable">
                                                    Level:</td>
                                                <td>
                                                    <asp:Label ID="IDDECSLevelLabel" runat="server" Text='<%# Bind("DECSLevel") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdtable">
                                                    Manufacturer:</td>
                                                <td>
                                                    <asp:Label ID="IDDECSManufacturerLabel" runat="server" Text='<%# Bind("DECSManufacturer") %>' />
                                                </td>
                                                <td class="tdtable">
                                                    Install Date:</td>
                                                <td>
                                                    <asp:Label ID="DECSInstallationDateLabel" runat="server" Text='<%# Bind("DECSInstallationDate", "{0:MM/dd/yyyy}") %>' />
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <span style="color: #2C7500"><b>Notes:<br />
                                        </b></span>
                                        <table style="width: 400px">
                                            <tr>
                                                <td width="25px">
                                                    &#160;
                                                </td>
                                                <td>
                                                    <div class="divlblScrollText">
                                                        <asp:Label ID="NotesLabel" runat="server" Text='<%# Eval("Notes").ToString().Replace(Environment.NewLine,"<br />") %>' />
                                                    </div>
                                                    <br />
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <b><span style="color: #2C7500">Internal Notes:</span></b><br />
                                        <table style="width: 400px">
                                            <tr>
                                                <td width="25px">
                                                    &#160;
                                                </td>
                                                <td>
                                                    <div class="divlblScrollText">
                                                        <asp:Label ID="NotesCFLabel" runat="server" Text='<%# Eval("NotesCF").ToString().Replace(Environment.NewLine,"<br />") %>' />
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <%--<asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                        &#160;<asp:Button ID="btn_DetachDECs" runat="server" CausesValidation="False" CommandName="Delete" Text="Detach" />--%>
                                        <asp:HiddenField ID="hf_IDDECS" runat="server" Value='<%# Bind("IDDECS") %>' />
                                    </ItemTemplate>
                                    <EmptyDataTemplate>
                                        <%--<asp:Button ID="btn_AddDECs" runat="server" onclick="btn_AddDECs_Click" Text="Add DECS" />--%>
                                    </EmptyDataTemplate>
                                </asp:FormView>
                                <br />
                                <br />
                                <br />
                                <br />
                            </td>
                            <td style="padding: 5px; border-left-style: solid; border-left-width: 1px; border-left-color: #9B9B9B" valign="top">
                                <asp:FormView ID="fv_DECSImage" runat="server" DataKeyNames="IDImages" DataSourceID="sds_ImagesDECs_fvw">
                                    <ItemTemplate>
                                        <asp:Image ID="image1" runat="server" Height="133" ImageUrl='<%#Eval("Image") %>' Width="200" />
                                    </ItemTemplate>
                                </asp:FormView>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br />
        <br />
</telerik:RadPageView>
                                        <telerik:RadPageView ID="rmp_EngineFiles" runat="server">
                                            <table cellpadding="0" cellspacing="0" style="padding: 5px; border: 1px solid #9B9B9B; width: 100%">
                                                <tr>
                                                    <td>
                                                        <h1>
                                                            Engine Files</h1>
                                                        <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                            <tr>
                                                                <td>
                                                                    <%--<asp:Button ID="btn_AddEngineImage" runat="server" Text="Add Image" />--%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>&nbsp;
                                                                    </td>
                                                            </tr>
                                                        </table>
                                                        <telerik:RadGrid ID="rg_EngineImages" runat="server" AllowAutomaticDeletes="True" AutoGenerateDeleteColumn="True" CssClass="radgrid" DataSourceID="sds_ImagesEngines" GridLines="None" Width="600px">
                                                            <mastertableview autogeneratecolumns="False" clientdatakeynames="IDImages" datakeynames="IDImages" datasourceid="sds_ImagesEngines">
                                                                <Columns>
                                                                    <telerik:GridTemplateColumn DefaultInsertValue="" HeaderText="Default" UniqueName="rbt_VehicleImage">
                                                                        <ItemTemplate>
<%--  <asp:RadioButton ID="rbt_EngineImage" runat="server" AutoPostBack="True" checked='<%# IF(Eval("DefaultImage") is DBNull.Value, False, Eval("DefaultImage")) %>' GroupName="MyGroupEngines" oncheckedchanged="rbt_EngineImage_CheckedChanged" onclick="MyClickEngines(this,event)" />--%>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridImageColumn AlternateText="Thumbnail" DataImageUrlFields="FilePath, Image" DataImageUrlFormatString="{0}/{1}" DataType="System.String" FooterText="ImageColumn footer" HeaderText="" ImageAlign="Middle" UniqueName="vehicleimage">
                                                                        <HeaderStyle Width="75px" />
                                                                    </telerik:GridImageColumn>
                                                                    <telerik:GridBoundColumn DataField="IDImages" DataType="System.Int32" DefaultInsertValue="" HeaderText="IDImages" ReadOnly="True" SortExpression="IDImages" UniqueName="IDImages" Visible="False">
                                                                    </telerik:GridBoundColumn>
                                                                </Columns>
                                                            </mastertableview>
                                                            <clientsettings>
                                                                <clientevents onrowdblclick="RowClick" />
                                                            </clientsettings>
                                                        </telerik:RadGrid>
                                                        <p>
                                                        </p>
                                                        <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                            <tr>
                                                                <td>
                                                                   <%-- <asp:Button ID="btn_AddEngineFile" runat="server" Text="Add File" />--%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>&nbsp;
                                                                    </td>
                                                            </tr>
                                                        </table>
                                                        <p>
                                                            &nbsp;<telerik:RadGrid ID="rg_EngineFiles" runat="server" AllowAutomaticDeletes="True" AutoGenerateDeleteColumn="True" CssClass="radgrid" DataSourceID="sds_FilesEngine" GridLines="None" Width="600px">
                                                                <mastertableview autogeneratecolumns="False" datakeynames="IDFile" datasourceid="sds_FilesEngine">
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn DataField="Title" DefaultInsertValue="" HeaderText="Title" SortExpression="Title" UniqueName="Title">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridHyperLinkColumn DataNavigateUrlFields="FilePath,FileName" DataNavigateUrlFormatString="{0}{1}" DataTextField="IDVehicles" DataTextFormatString="View" Target="_Blank" Text="View" UniqueName="View">
                                                                            <ItemStyle CssClass="radgrid" />
                                                                        </telerik:GridHyperLinkColumn>
                                                                    </Columns>
                                                                </mastertableview>
                                                            </telerik:RadGrid>
                                                            <p>
                                                            </p>
                                                            <p>
                                                                <asp:Label ID="Label1" runat="server" ForeColor="#2C7500" style="font-size: large; font-weight: 700" Text="DECS Files"></asp:Label>
                                                            </p>
                                                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                                <tr>
                                                                    <td>
                                                                        <%--<asp:Button ID="btn_AddDECSImage" runat="server" Text="Add Image" />--%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>&nbsp;
                                                                        </td>
                                                                </tr>
                                                            </table>
                                                            <telerik:RadGrid ID="rg_DECSImages" runat="server" AllowAutomaticDeletes="True" AutoGenerateDeleteColumn="True" CssClass="radgrid" DataSourceID="sds_ImagesDECs" GridLines="None" Width="600px">
                                                                <mastertableview autogeneratecolumns="False" clientdatakeynames="IDImages" datakeynames="IDImages" datasourceid="sds_ImagesDECs">
                                                                    <Columns>
                                                                        <telerik:GridTemplateColumn DefaultInsertValue="" HeaderText="Default" UniqueName="rbt_VehicleImage">
                                                                            <ItemTemplate>
                                                                                <%--<asp:RadioButton ID="rbt_DECSImage" runat="server" AutoPostBack="True" checked='<%# IF(Eval("DefaultImage") is DBNull.Value, False, Eval("DefaultImage")) %>' GroupName="MyGroupDECS" oncheckedchanged="rbt_DECSImage_CheckedChanged" onclick="MyClickDECS(this,event)" />--%>
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridImageColumn AlternateText="Thumbnail" DataImageUrlFields="FilePath, Image" DataImageUrlFormatString="{0}/{1}" DataType="System.String" FooterText="ImageColumn footer" HeaderText="" ImageAlign="Middle" UniqueName="vehicleimage">
                                                                            <HeaderStyle Width="75px" />
                                                                        </telerik:GridImageColumn>
                                                                        <telerik:GridBoundColumn DataField="IDImages" DataType="System.Int32" DefaultInsertValue="" HeaderText="IDImages" ReadOnly="True" SortExpression="IDImages" UniqueName="IDImages" Visible="False">
                                                                        </telerik:GridBoundColumn>
                                                                    </Columns>
                                                                </mastertableview>
                                                                <clientsettings>
                                                                    <clientevents onrowdblclick="RowClick" />
                                                                </clientsettings>
                                                            </telerik:RadGrid>
                                                            <p>&nbsp;
                                                                </p>
                                                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                                <tr>
                                                                    <td>
                                                                        <%--<asp:Button ID="btn_AddDECSFile" runat="server" Text="Add File" />--%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>&nbsp;
                                                                        </td>
                                                                </tr>
                                                            </table>
                                                            <telerik:RadGrid ID="rg_DECsFiles" runat="server" AllowAutomaticDeletes="True" AutoGenerateDeleteColumn="True" CssClass="radgrid" DataSourceID="sds_FilesDECS" GridLines="None" Width="600px">
                                                                <mastertableview autogeneratecolumns="False" datakeynames="IDFile" datasourceid="sds_FilesDECS">
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn DataField="Title" DefaultInsertValue="" HeaderText="Title" SortExpression="Title" UniqueName="Title">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridHyperLinkColumn DataNavigateUrlFields="FilePath,FileName" DataNavigateUrlFormatString="{0}{1}" DataTextField="IDVehicles" DataTextFormatString="View" Target="_Blank" Text="View" UniqueName="View">
                                                                            <ItemStyle CssClass="radgrid" />
                                                                        </telerik:GridHyperLinkColumn>
                                                                    </Columns>
                                                                </mastertableview>
                                                            </telerik:RadGrid>
                                                        </p>
                                                    </td>
                                                </tr>
                                            </table>
    <br />
</telerik:RadPageView>
                                    </telerik:radmultipage>
	<p>
		&nbsp;
	</p>
	<asp:SqlDataSource ID="sds_CFV_Engines_fv" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDEngines], [IDModifiedUser], [ModifiedDate], [IDVehicles], [IDEngineManufacturer], [EngineManufacturer], [EngineModel], [IDModelYear], [IDEngineStatus], [EngineStatus], [IDEngineFuelType], [EngineFuelType], [SerialNum], [Description], [ModelYear], [FamilyName], [SeriesModelNo], [Horsepower], [Notes], [NotesCF] FROM [CFV_Engines] WHERE ([IDEngines] = @IDEngines)"
		UpdateCommand="UPDATE [CF_Engines] SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate, [IDEngineManufacturer] = @IDEngineManufacturer, [EngineModel] = @EngineModel, [IDEngineStatus] = @IDEngineStatus, [IDEngineFuelType] = @IDEngineFuelType, [IDModelYear] = @IDModelYear, [SerialNum] = @SerialNum, [FamilyName] = @FamilyName, [SeriesModelNo] = @SeriesModelNo, [Horsepower] = @Horsepower, [Description] = @Description, [Notes] = @Notes, [NotesCF] = @NotesCF WHERE [IDEngines] = @IDEngines">
		<DeleteParameters>
			<asp:Parameter Name="IDEngines" />
		</DeleteParameters>
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_Engines" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
		<UpdateParameters>
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:Parameter Name="ModifiedDate" Type="DateTime" />
			<asp:Parameter Name="IDEngineManufacturer" Type="Int32" />
			<asp:Parameter Name="IDEngineModel" Type="Int32" />
			<asp:Parameter Name="IDEngineStatus" Type="Int32" />
			<asp:Parameter Name="IDEngineFuelType" Type="Int32" />
			<asp:Parameter Name="IDModelYear" Type="Int32" />
			<asp:Parameter Name="SerialNum" Type="String" />
			<asp:Parameter Name="FamilyName" Type="String" />
			<asp:Parameter Name="SeriesModelNo" Type="String" />
			<asp:Parameter Name="Horsepower" Type="String" />
			<asp:Parameter Name="Description" Type="String" />
			<asp:Parameter Name="Notes" Type="String" />
			<asp:Parameter Name="NotesCF" Type="String" />
			<asp:Parameter Name="IDEngines" />
		</UpdateParameters>
		<InsertParameters>
		</InsertParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_CFV_Engines_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDEngines], [SerialNum], [Description], [ModelYear], [FamilyName], [SeriesModelNo] FROM [CFV_Engines_Detached]">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_EngineManufacturer" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="EngineManufacturer" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_EngineModel" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [EngineModel] FROM [CFV_EngineModel] ORDER BY [EngineModel]">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_EngineStatus" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="EngineStatus" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_EngineFuelType" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="EngineFuelType" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_Op_Year" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="Year" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<br />
	<asp:SqlDataSource ID="sds_CFV_DECs_fv" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDDECs], [IDModifiedUser], [EnterDate], [ModifiedDate], [IDEngines], [DECSName], [IDDECSManufacturer], [DECSManufacturer], [IDDECSLevel], [DECSLevel], [DECSModelNo], [DECSInstallationDate], [Notes], [NotesCF] FROM [CFV_DECs] WHERE ([IDEngines] = @IDEngines)"
		DeleteCommand="DELETE FROM [CF_DECs] WHERE [IDDECs] = @IDDECs" UpdateCommand="UPDATE [CF_DECs] SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate, [DECSName] = @DECSName, [IDDECSManufacturer] = @IDDECSManufacturer, [IDDECSLevel] = @IDDECSLevel, [DECSModelNo] = @DECSModelNo, [DECSInstallationDate] = @DECSInstallationDate, [Notes] = @Notes, [NotesCF] = @NotesCF WHERE [IDDECs] = @IDDECs">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_Engines" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDDECs" />
		</DeleteParameters>
		<UpdateParameters>
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:Parameter Name="ModifiedDate" Type="DateTime" />
			<asp:Parameter Name="DECSName" Type="String" />
			<asp:Parameter Name="IDDECSManufacturer" Type="Int32" />
			<asp:Parameter Name="IDDECSLevel" Type="Int32" />
			<asp:Parameter Name="DECSModelNo" Type="String" />
			<asp:Parameter Name="DECSInstallationDate" Type="DateTime" />
			<asp:Parameter Name="Notes" Type="String" />
			<asp:Parameter Name="NotesCF" Type="String" />
		</UpdateParameters>
		<InsertParameters>
		</InsertParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_DECs_Op_Level" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="DECSLevel" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ddl_DECs_Op_Manufacturer" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDOptionList], [RecordValue], [DisplayValue], [OptionName] FROM [CF_Option_List] WHERE ([OptionName] = @OptionName) ORDER BY [DisplayValue]">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="DECSManufacturer" Name="OptionName" QueryStringField="OptionName"
				Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ImagesEngines_fvw" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDImages], [IDVehicles], [IDEngines], [IDDECS], [Title], [Image] FROM [CFV_Images_Default] WHERE ([IDEngines] = @IDEngines) AND IDDECS IS NULL">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_Engines" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
	</asp:SqlDataSource>
	<br />
	<asp:SqlDataSource ID="sds_ImagesDECs_fvw" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDImages], [IDVehicles], [IDEngines], [IDDECS], [Title], [Image] FROM [CFV_Images_Default] WHERE ([IDEngines] = @IDEngines) AND IDDECS IS NOT NULL">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_Engines" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
	</asp:SqlDataSource>
	<br />
	<asp:SqlDataSource ID="sds_ImagesDECs" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDImages], [DefaultImage], [IDModifiedUser], [ModifiedDate], [IDVehicles], [IDEngines], [IDDECS], [Title], [FilePath], [FileName], [UserID], [EnterDate] FROM [CFV_Images_DECS] WHERE ([IDEngines] = @IDEngines)"
		DeleteCommand="DELETE FROM [CF_Images] WHERE [IDImages] = @IDImages">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_Engines" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDImages" />
		</DeleteParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_FilesDECS" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDFile], [Title], [FileName], [FilePath], [IDEngines], [IDDECS] FROM [CFV_Files_DECS] WHERE ([IDEngines] = @IDEngines)"
		DeleteCommand="DELETE FROM [CF_Files] WHERE [IDFile] = @IDFile">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_Engines" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDFile" />
		</DeleteParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_ImagesEngines" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDImages], [DefaultImage], [IDModifiedUser], [ModifiedDate], [IDVehicles], [IDEngines], [Title], [FilePath], [FileName], [UserID], [EnterDate] FROM [CFV_Images_Engines] WHERE ([IDEngines] = @IDEngines)"
		DeleteCommand="DELETE FROM [CF_Images] WHERE [IDImages] = @IDImages">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_Engines" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDImages" />
		</DeleteParameters>
	</asp:SqlDataSource>
	<%--Engine Files This datasource is for rg_EngineFiles--%>
	<asp:SqlDataSource ID="sds_FilesEngine" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDFile], [Title], [FileName], [FilePath], [IDEngines] FROM [CFV_Files_Engines] WHERE ([IDEngines] = @IDEngines)"
		DeleteCommand="DELETE FROM [CF_Files] WHERE [IDFile] = @IDFile">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_Engines" Name="IDEngines" PropertyName="SelectedValue" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDFile" />
		</DeleteParameters>
	</asp:SqlDataSource>
</asp:Content>
