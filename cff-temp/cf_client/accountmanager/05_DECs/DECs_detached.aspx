<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="DECs_detached.aspx.vb" Inherits="cleanfleets_fms.DECs_detached" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content runat="server" ContentPlaceHolderID="head">

	<script type="text/javascript">
		function RowClick(sender, eventArgs) {
			var MasterTableView = eventArgs.get_tableView();
			var cell = MasterTableView.getCellByColumnUniqueName(MasterTableView.get_dataItems()[eventArgs.get_itemIndexHierarchical()], "IDImages");
			var oWnd = radopen("../../imagemanager/imagedisplay.aspx?IDImages=" + cell.innerHTML);
		}
	</script>

</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<span style="color: #ED8701; font-size: medium; font-weight: bold">Detached DECs<br />
	</span>
	<table cellpadding="0" cellspacing="0" style="width: 100%">
		<tr>
			<td>
				&nbsp;
			</td>
		</tr>
	</table>
	<telerik:radgrid id="rg_DECs" runat="server" datakeynames="IDDECS" datasourceid="sds_CFV_DECs_Grid"
		gridlines="None" pagesize="5" showfooter="True" skin="Telerik" width="500px"
		allowsorting="True">
        <mastertableview autogeneratecolumns="False" datakeynames="IDDECS" datasourceid="sds_CFV_DECs_Grid">
            <Columns>
                <telerik:GridBoundColumn DataField="DECSName" DefaultInsertValue="" HeaderText="DECS Name" SortExpression="DECSName" UniqueName="DECSName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SerialNo" DefaultInsertValue="" HeaderText="Serial Num" SortExpression="SerialNo" UniqueName="SerialNo">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DECSModelNo" DefaultInsertValue="" HeaderText="Model Num" SortExpression="DECSModelNo" UniqueName="DECSModelNo">
                </telerik:GridBoundColumn>
            </Columns>
        </mastertableview>
        <clientsettings enablepostbackonrowclick="True">
            <selecting allowrowselect="True" />
        </clientsettings>
    </telerik:radgrid>
	<br />
	<table cellpadding="0" style="width: 920px; border-collapse: collapse; border: 1px solid #9B9B9B">
		<tr>
			<td valign="top" width="700px" style="padding: 4px">
				<table cellpadding="0" cellspacing="0" style="width: 100%; height: 30px;">
					<tr>
						<td>
							<span style="color: #ED8701; font-size: medium; font-weight: bold">Diesel Engine Emissions
								Control System</span>
						</td>
					</tr>
				</table>
				<asp:FormView ID="fv_DECSDetails" runat="server" DataKeyNames="IDDECs" DataSourceID="sds_CFV_DECs_fv"
					Width="700px">
					<EditItemTemplate>
						<table style="width: 100%">
							<tr>
								<td style="width: 95px;" class="tdtable">
									Serial Num:
								</td>
								<td style="height: 20px; width: 180px;">
									<asp:TextBox ID="SerialNoTextBox" runat="server" Text='<%# Bind("SerialNo") %>' />
								</td>
								<td style="width: 100px;" class="tdtable">
									Model No:
								</td>
								<td style="height: 20px">
									<asp:TextBox ID="DECSModelNoTextBox" runat="server" Text='<%# Bind("DECSModelNo") %>' />
								</td>
							</tr>
							<tr>
								<td style="width: 95px;" class="tdtable">
									Name:
								</td>
								<td style="width: 180px">
									<asp:TextBox ID="DECSNameTextBox" runat="server" Text='<%# Bind("DECSName") %>' />
								</td>
								<td style="width: 100px;" class="tdtable">
									Level:
								</td>
								<td>
									<asp:DropDownList ID="ddl_IDDECsLevel" runat="server" AppendDataBoundItems="True"
										DataSourceID="sds_ddl_DECs_Op_Level" DataTextField="DisplayValue" DataValueField="IDOptionList"
										SelectedValue='<%# Bind("IDDECSLevel") %>'>
										<asp:ListItem Text="Select" Value="" />
									</asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td style="width: 95px;" class="tdtable">
									Manufacturer:
								</td>
								<td style="width: 180px">
									<asp:DropDownList ID="ddl_IDDECsManufacturer" runat="server" AppendDataBoundItems="True"
										DataSourceID="sds_ddl_DECs_Op_Manufacturer" DataTextField="DisplayValue" DataValueField="IDOptionList"
										SelectedValue='<%# Bind("IDDECSManufacturer") %>'>
										<asp:ListItem Text="Select" Value="" />
									</asp:DropDownList>
								</td>
								<td style="width: 100px;" class="tdtable">
									Install Date:
								</td>
								<td>
									<telerik:raddatepicker id="rdp_DECSInstallationDate" runat="server" culture="English (United States)"
										dbselecteddate='<%# Bind("DECSInstallationDate") %>'>
                                                                        <calendar usecolumnheadersasselectors="False" userowheadersasselectors="False" viewselectortext="x">
                                                                        </calendar>
                                                                        <datepopupbutton hoverimageurl="" imageurl="" />
                                                                        <dateinput dateformat="M/d/yyyy" displaydateformat="M/d/yyyy" enabledstyle-horizontalalign="Center">
                                                                            <enabledstyle horizontalalign="Center" />
                                                                        </dateinput>
                                                                    </telerik:raddatepicker>
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
									<asp:TextBox ID="ntb_Notes_DECs" runat="server" Height="65px" Text='<%# Bind("Notes") %>'
										TextMode="MultiLine" Width="650px" />
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
									<asp:TextBox ID="ntb_NotesCF_DECs" runat="server" Height="65px" Text='<%# Bind("NotesCF") %>'
										TextMode="MultiLine" Width="650px" />
								</td>
							</tr>
						</table>
						&#160;<br />
						<asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
							Text="Update" />
						&#160;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False"
							CommandName="Cancel" Text="Cancel" />
						<br />
					</EditItemTemplate>
					<InsertItemTemplate>
					</InsertItemTemplate>
					<ItemTemplate>
						<table style="width: 100%">
							<tr>
								<td style="width: 95px;" class="tdtable">
									Serial Num:
								</td>
								<td style="height: 20px; width: 200px;">
									<asp:Label ID="SerialNoLabel" runat="server" Text='<%# Bind("SerialNo") %>' />
								</td>
								<td style="width: 100px;" class="tdtable">
									Model No:
								</td>
								<td style="height: 20px">
									<asp:Label ID="DECSModelNoLabel" runat="server" Text='<%# Bind("DECSModelNo") %>' />
								</td>
							</tr>
							<tr>
								<td style="width: 95px;" class="tdtable">
									Name:
								</td>
								<td style="width: 200px">
									<asp:Label ID="DECSNameLabel" runat="server" Text='<%# Bind("DECSName") %>' />
								</td>
								<td style="width: 100px;" class="tdtable">
									Level:
								</td>
								<td>
									<asp:Label ID="IDDECSLevelLabel" runat="server" Text='<%# Bind("DECSLevel") %>' />
								</td>
							</tr>
							<tr>
								<td style="width: 95px;" class="tdtable">
									Manufacturer:
								</td>
								<td style="width: 200px">
									<asp:Label ID="IDDECSManufacturerLabel" runat="server" Text='<%# Bind("DECSManufacturer") %>' />
								</td>
								<td style="width: 100px;" class="tdtable">
									Install Date:
								</td>
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
						<asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
							Text="Edit" />
						&#160;<asp:HiddenField ID="hf_IDDECS" runat="server" Value='<%# Bind("IDDECS") %>' />
					</ItemTemplate>
				</asp:FormView>
				<br />
			</td>
			<td style="padding: 5px; border-left-style: solid; border-left-width: 1px; border-left-color: #9B9B9B"
				valign="top">
				<asp:Button ID="btn_AddDECSImage" runat="server" Text="Add Image" />
				<telerik:radgrid cssclass="radgrid" id="rg_DECSImages" runat="server" allowautomaticdeletes="True"
					autogeneratedeletecolumn="True" datasourceid="sds_ImagesDECs" gridlines="None"
					width="220px">
                                                    <mastertableview autogeneratecolumns="False" datakeynames="IDImages" datasourceid="sds_ImagesDECs">
                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="IDimages" DefaultInsertValue="" HeaderText="" ItemStyle-ForeColor="White" ItemStyle-Width="2px" SortExpression="True">
                                                                <HeaderStyle Width="2px" />
                                                                <ItemStyle ForeColor="White" Width="2px" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridImageColumn AlternateText="Thumbnail" DataImageUrlFields="FilePath, FileName" DataImageUrlFormatString="{0}/{1}" DataType="System.String" FooterText="ImageColumn footer" HeaderText="" ImageAlign="Middle">
                                                                <HeaderStyle Width="75px" />
                                                            </telerik:GridImageColumn>
                                                            <telerik:GridBoundColumn DataField="FileName" DefaultInsertValue="" HeaderText="FileName" SortExpression="FileName" UniqueName="FileName" Visible="False">
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </mastertableview>
                                                    <clientsettings>
                                                        <clientevents onrowdblclick="RowClick" />
                                                    </clientsettings>
                                                </telerik:radgrid>
				<table cellpadding="0" cellspacing="0" style="width: 100%">
					<tr>
						<td>
							&nbsp;
						</td>
					</tr>
				</table>
				<asp:Button runat="server" Text="Add File" ID="btn_AddDECSFile" />
				<br />
				<br />
				<telerik:radgrid cssclass="radgrid" id="rg_DECsFiles" runat="server" allowautomaticdeletes="True"
					autogeneratedeletecolumn="True" datasourceid="sds_FilesDECS" gridlines="None">
                                                    <mastertableview autogeneratecolumns="False" datakeynames="IDFile" datasourceid="sds_FilesDECS">
                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="Title" DefaultInsertValue="" HeaderText="Title" SortExpression="Title" UniqueName="Title">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridHyperLinkColumn DataNavigateUrlFields="FilePath,FileName"
                                                        DataNavigateUrlFormatString="{0}{1}" DataTextField="IDVehicles"
                                                        DataTextFormatString="View" Target="_Blank" Text="View" UniqueName="View">
                                                            <ItemStyle CssClass="radgrid" />
                                                        </telerik:GridHyperLinkColumn>
                                                        </Columns>
                                                    </mastertableview>
                                                </telerik:radgrid>
				<br />
			</td>
		</tr>
	</table>
	<br />
	<br />
	<asp:SqlDataSource ID="sds_CFV_DECs_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDDECS], [DECSName], [SerialNo], [DECSModelNo] FROM [CFV_DECs_Detached] ORDER BY [DECSName]">
	</asp:SqlDataSource>
	<br />
	<br />
	<%-- This datasource is for --%>
	<asp:SqlDataSource ID="sds_CFV_DECs_fv" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDDECs], [IDModifiedUser], [EnterDate], [ModifiedDate], [DECSName], [SerialNo], [IDDECSManufacturer], [DECSManufacturer], [IDDECSLevel], [DECSLevel], [DECSModelNo], [DECSInstallationDate], [Notes], [NotesCF] FROM [CFV_DECS_Detached] WHERE ([IDDECS] = @IDDECS)"
		DeleteCommand="DELETE FROM [CF_DECs] WHERE [IDDECs] = @IDDECs" UpdateCommand="UPDATE [CF_DECs] SET [IDModifiedUser] = @IDModifiedUser, [ModifiedDate] = @ModifiedDate, [DECSName] = @DECSName, [SerialNo] = @SerialNo, [IDDECSManufacturer] = @IDDECSManufacturer, [IDDECSLevel] = @IDDECSLevel, [DECSModelNo] = @DECSModelNo, [DECSInstallationDate] = @DECSInstallationDate, [Notes] = @Notes, [NotesCF] = @NotesCF WHERE [IDDECs] = @IDDECs">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_DECs" Name="IDDECS" PropertyName="SelectedValue" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDDECs" />
		</DeleteParameters>
		<UpdateParameters>
			<asp:SessionParameter DefaultValue="0" Name="IDModifiedUser" SessionField="UserID" />
			<asp:Parameter Name="ModifiedDate" Type="DateTime" />
			<asp:Parameter Name="DECSName" Type="String" />
			<asp:Parameter Name="SerialNo" Type="String" />
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
	<br />
	<br />
	<asp:SqlDataSource ID="sds_ImagesDECs" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDImages], [IDDECS], [Title], [FilePath], [FileName], [Image] FROM [CFV_Images_DECS] WHERE ([IDDECs] = @IDDECs)"
		DeleteCommand="DELETE FROM [CF_Images] WHERE [IDImages] = @IDImages">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_DECs" Name="IDDECS" PropertyName="SelectedValue" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDDECs" />
		</DeleteParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="sds_FilesDECS" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
		SelectCommand="SELECT [IDFile], [Title], [FileName], [FilePath], [IDDECS] FROM [CFV_Files_DECS] WHERE ([IDDECs] = @IDDECs)"
		DeleteCommand="DELETE FROM [CF_Files] WHERE [IDFile] = @IDFile">
		<SelectParameters>
			<asp:ControlParameter ControlID="rg_DECs" Name="IDDECS" PropertyName="SelectedValue" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="IDFile" />
		</DeleteParameters>
	</asp:SqlDataSource>
</asp:Content>

