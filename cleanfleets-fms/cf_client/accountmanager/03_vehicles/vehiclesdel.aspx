<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/CF_Client.Master" CodeBehind="vehiclesdel.aspx.vb" Inherits="cleanfleets_fms.vehiclesdel" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
	<style type="text/css">
		.RadGrid_Default
		{
			font: 12px/16px "segoe ui" ,arial,sans-serif;
		}
		.RadGrid_Default
		{
			border: 1px solid #828282;
			background: #fff;
			color: #333;
		}
		.RadGrid_Default
		{
			font: 12px/16px "segoe ui" ,arial,sans-serif;
		}
		.RadGrid_Default
		{
			border: 1px solid #828282;
			background: #fff;
			color: #333;
		}
		.RadGrid_Default
		{
			font: 12px/16px "segoe ui" ,arial,sans-serif;
		}
		.RadGrid_Default
		{
			border: 1px solid #828282;
			background: #fff;
			color: #333;
		}
		.RadGrid_Default
		{
			font: 12px/16px "segoe ui" ,arial,sans-serif;
		}
		.RadGrid_Default
		{
			border: 1px solid #828282;
			background: #fff;
			color: #333;
		}
		.RadGrid_Default
		{
			font: 12px/16px "segoe ui" ,arial,sans-serif;
		}
		.RadGrid_Default
		{
			border: 1px solid #828282;
			background: #fff;
			color: #333;
		}
		.RadGrid_Default
		{
			font: 12px/16px "segoe ui" ,arial,sans-serif;
		}
		.RadGrid_Default
		{
			border: 1px solid #828282;
			background: #fff;
			color: #333;
		}
		.RadGrid_Default
		{
			font: 12px/16px "segoe ui" ,arial,sans-serif;
		}
		.RadGrid_Default
		{
			border: 1px solid #828282;
			background: #fff;
			color: #333;
		}
		.RadGrid_Default .rgMasterTable
		{
			border-collapse: separate;
		}
		.RadGrid_Default .rgMasterTable
		{
			font: 12px/16px "segoe ui" ,arial,sans-serif;
		}
		.RadGrid_Default .rgMasterTable
		{
			border-collapse: separate;
		}
		.RadGrid_Default .rgMasterTable
		{
			font: 12px/16px "segoe ui" ,arial,sans-serif;
		}
		.RadGrid_Default .rgMasterTable
		{
			border-collapse: separate;
		}
		.RadGrid_Default .rgMasterTable
		{
			font: 12px/16px "segoe ui" ,arial,sans-serif;
		}
		.RadGrid_Default .rgMasterTable
		{
			border-collapse: separate;
		}
		.RadGrid_Default .rgMasterTable
		{
			font: 12px/16px "segoe ui" ,arial,sans-serif;
		}
		.RadGrid_Default .rgMasterTable
		{
			border-collapse: separate;
		}
		.RadGrid_Default .rgMasterTable
		{
			font: 12px/16px "segoe ui" ,arial,sans-serif;
		}
		.RadGrid_Default .rgMasterTable
		{
			border-collapse: separate;
		}
		.RadGrid_Default .rgMasterTable
		{
			font: 12px/16px "segoe ui" ,arial,sans-serif;
		}
		.RadGrid_Default .rgMasterTable
		{
			border-collapse: separate;
		}
		.RadGrid_Default .rgMasterTable
		{
			font: 12px/16px "segoe ui" ,arial,sans-serif;
		}
		.RadGrid_Default .rgHeader
		{
			color: #333;
			text-decoration: none;
		}
		.RadGrid_Default .rgHeader
		{
			border: 0;
			border-bottom: 1px solid #828282;
			padding-top: 5px;
			padding-bottom: 4px;
			background: #eaeaea 0 -2300px repeat-x url('mvwres://Telerik.Web.UI, Version=2009.3.1208.35, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Grid.sprite.gif');
			text-align: left;
			font-weight: normal;
		}
		.RadGrid_Default .rgHeader
		{
			padding-left: 7px;
			padding-right: 7px;
		}
		.RadGrid_Default .rgHeader
		{
			cursor: default;
		}
		.RadGrid_Default .rgHeader
		{
			color: #333;
			text-decoration: none;
		}
		.RadGrid_Default .rgHeader
		{
			border: 0;
			border-bottom: 1px solid #828282;
			padding-top: 5px;
			padding-bottom: 4px;
			background: #eaeaea 0 -2300px repeat-x url('mvwres://Telerik.Web.UI, Version=2009.3.1208.35, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Grid.sprite.gif');
			text-align: left;
			font-weight: normal;
		}
		.RadGrid_Default .rgHeader
		{
			padding-left: 7px;
			padding-right: 7px;
		}
		.RadGrid_Default .rgHeader
		{
			cursor: default;
		}
		.RadGrid_Default .rgHeader
		{
			color: #333;
			text-decoration: none;
		}
		.RadGrid_Default .rgHeader
		{
			border: 0;
			border-bottom: 1px solid #828282;
			padding-top: 5px;
			padding-bottom: 4px;
			background: #eaeaea 0 -2300px repeat-x url('mvwres://Telerik.Web.UI, Version=2009.3.1208.35, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Grid.sprite.gif');
			text-align: left;
			font-weight: normal;
		}
		.RadGrid_Default .rgHeader
		{
			padding-left: 7px;
			padding-right: 7px;
		}
		.RadGrid_Default .rgHeader
		{
			cursor: default;
		}
		.RadGrid_Default .rgHeader
		{
			color: #333;
			text-decoration: none;
		}
		.RadGrid_Default .rgHeader
		{
			border: 0;
			border-bottom: 1px solid #828282;
			padding-top: 5px;
			padding-bottom: 4px;
			background: #eaeaea 0 -2300px repeat-x url('mvwres://Telerik.Web.UI, Version=2009.3.1208.35, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Grid.sprite.gif');
			text-align: left;
			font-weight: normal;
		}
		.RadGrid_Default .rgHeader
		{
			padding-left: 7px;
			padding-right: 7px;
		}
		.RadGrid_Default .rgHeader
		{
			cursor: default;
		}
		.RadGrid_Default .rgHeader
		{
			color: #333;
			text-decoration: none;
		}
		.RadGrid_Default .rgHeader
		{
			border: 0;
			border-bottom: 1px solid #828282;
			padding-top: 5px;
			padding-bottom: 4px;
			background: #eaeaea 0 -2300px repeat-x url('mvwres://Telerik.Web.UI, Version=2009.3.1208.35, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Grid.sprite.gif');
			text-align: left;
			font-weight: normal;
		}
		.RadGrid_Default .rgHeader
		{
			padding-left: 7px;
			padding-right: 7px;
		}
		.RadGrid_Default .rgHeader
		{
			cursor: default;
		}
		.RadGrid_Default .rgHeader
		{
			color: #333;
			text-decoration: none;
		}
		.RadGrid_Default .rgHeader
		{
			border: 0;
			border-bottom: 1px solid #828282;
			padding-top: 5px;
			padding-bottom: 4px;
			background: #eaeaea 0 -2300px repeat-x url('mvwres://Telerik.Web.UI, Version=2009.3.1208.35, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Grid.sprite.gif');
			text-align: left;
			font-weight: normal;
		}
		.RadGrid_Default .rgHeader
		{
			padding-left: 7px;
			padding-right: 7px;
		}
		.RadGrid_Default .rgHeader
		{
			cursor: default;
		}
		.RadGrid_Default .rgHeader
		{
			color: #333;
			text-decoration: none;
		}
		.RadGrid_Default .rgHeader
		{
			border: 0;
			border-bottom: 1px solid #828282;
			padding-top: 5px;
			padding-bottom: 4px;
			background: #eaeaea 0 -2300px repeat-x url('mvwres://Telerik.Web.UI, Version=2009.3.1208.35, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Grid.sprite.gif');
			text-align: left;
			font-weight: normal;
		}
		.RadGrid_Default .rgHeader
		{
			padding-left: 7px;
			padding-right: 7px;
		}
		.RadGrid_Default .rgHeader
		{
			cursor: default;
		}
	</style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="RightColumnContentPlaceHolder">
	<p style="font-size: medium; font-weight: bold; color: #ED8701">
		Delete Vehicle</p>
	<span style="color: #FF0000; font-size: small;">Please confirm the deletion of this
		vehicle.</span><p style="font-size: medium; font-weight: bold; color: #ED8701">
			<asp:FormView ID="fv_VehicleDelete" runat="server" DataKeyNames="IDVehicles" DataSourceID="sds_Vehicles"
				Style="font-size: small; color: #000000" Width="500px">
				<EditItemTemplate>
				</EditItemTemplate>
				<InsertItemTemplate>
				</InsertItemTemplate>
				<ItemTemplate>
					<span style="color: #2C7500">IDVehicles:</span>
					<asp:Label ID="IDVehiclesLabel" runat="server" Text='<%# Eval("IDVehicles") %>' Font-Bold="False" />
					<br />
					<span style="color: #2C7500">Unit No:</span>
					<asp:Label ID="UnitNoLabel" runat="server" Text='<%# Bind("UnitNo") %>' Font-Bold="False" />
					<br />
					<span style="color: #2C7500">License Plate No:</span>
					<asp:Label ID="LicensePlateNoLabel" runat="server" Text='<%# Bind("LicensePlateNo") %>'
						Font-Bold="False" />
					<br />
					<span style="color: #2C7500">ID Vehicles:</span>
					<asp:Label ID="lbl_IDVehicles" runat="server" Text='<%# Bind("IDVehicles") %>' Font-Bold="False" />
					<br />
					<br />
					<asp:Button ID="btn_Delete" runat="server" Text="Delete" OnClick="btn_Delete_Click" />
					<br />
					<br />
					<br />
					<asp:HiddenField ID="hf_IDVehicles" Value='<%# Eval("IDVehicles") %>' runat="server" />
					<asp:HiddenField ID="hf_IDEngines" runat="server" Value='<%# Eval("IDEngines") %>' />
					<asp:HiddenField ID="hf_IDDECS" runat="server" Value='<%# Eval("IDDECS") %>' />
					<br />
				</ItemTemplate>
			</asp:FormView>
			<h3>
				Engine Records that will be deleted</h3>
			<telerik:radgrid id="RadGrid1" runat="server" datasourceid="sds_EngineRecords" gridlines="None"
				width="600px">
<MasterTableView AutoGenerateColumns="False" DataKeyNames="IDEngines" DataSourceID="sds_EngineRecords">
    <Columns>
        <telerik:GridBoundColumn DataField="IDEngines" DataType="System.Int32" 
            DefaultInsertValue="" HeaderText="IDEngines" ReadOnly="True" 
            SortExpression="IDEngines" UniqueName="IDEngines">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="IDVehicles" DataType="System.Int32" 
            DefaultInsertValue="" HeaderText="IDVehicles" SortExpression="IDVehicles" 
            UniqueName="IDVehicles">
        </telerik:GridBoundColumn>
    </Columns>
</MasterTableView>
                            </telerik:radgrid>
			<h3>
				Vehicle Images that will be deleted</h3>
			<telerik:radgrid id="rg_VehicleImages" runat="server" cssclass="radgrid" gridlines="None"
				width="600px">
                        <mastertableview autogeneratecolumns="False" datakeynames="IDImages" clientdatakeynames="IDImages">
                            <Columns>
                                <telerik:GridBoundColumn DataField="IDImages" DataType="System.Int32" DefaultInsertValue=""
                                    HeaderText="ID" ReadOnly="True" SortExpression="IDImages" UniqueName="IDImages" Display="True">
                                </telerik:GridBoundColumn>
                                <telerik:GridImageColumn AlternateText="Thumbnail" 
                                    DataImageUrlFields="FilePath, ThumbnailName" DataImageUrlFormatString="{0}/{1}" 
                                    DataType="System.String" FooterText="ImageColumn footer" HeaderText="" 
                                    ImageAlign="Middle" UniqueName="Thumbnail">
                                </telerik:GridImageColumn>
                                <telerik:GridImageColumn AlternateText="FileName" 
                                    DataImageUrlFields="FilePath, FileName" DataImageUrlFormatString="{0}/{1}" 
                                    DataType="System.String" FooterText="ImageColumn footer" HeaderText="" 
                                    ImageAlign="Middle" UniqueName="FileName" ImageHeight="200px" ImageWidth="200px">
                                </telerik:GridImageColumn>
                            </Columns>
                        </mastertableview>
                    </telerik:radgrid>
			<h3>
				Engines and DECS Images that will be deleted</h3>
			<telerik:radgrid id="rg_EngineImages" runat="server" cssclass="radgrid" gridlines="None"
				width="600px">
                            <mastertableview autogeneratecolumns="False" datakeynames="IDImages" clientdatakeynames="IDImages">
                            <Columns>
                                <telerik:GridBoundColumn DataField="IDImages" DataType="System.Int32" DefaultInsertValue=""
                                    HeaderText="ID" ReadOnly="True" SortExpression="IDImages" UniqueName="IDImages" Display="True">
                                </telerik:GridBoundColumn>
                                <telerik:GridImageColumn AlternateText="Thumbnail" 
                                    DataImageUrlFields="FilePath, ThumbnailName" DataImageUrlFormatString="{0}/{1}" 
                                    DataType="System.String" FooterText="ImageColumn footer" HeaderText="" 
                                    ImageAlign="Middle" UniqueName="Thumbnail">
                                </telerik:GridImageColumn>
                                <telerik:GridImageColumn AlternateText="FileName" 
                                    DataImageUrlFields="FilePath, FileName" DataImageUrlFormatString="{0}/{1}" 
                                    DataType="System.String" FooterText="ImageColumn footer" HeaderText="" 
                                    ImageAlign="Middle" UniqueName="FileName" ImageHeight="200px" ImageWidth="200px">
                                </telerik:GridImageColumn>
                            </Columns>
                        </mastertableview>
                    </telerik:radgrid>
			<h3>
				Vehicle Files that will be deleted</h3>
			<telerik:radgrid id="rg_VehicleFiles" runat="server" cssclass="radgrid" gridlines="None"
				width="600px">
                        <mastertableview autogeneratecolumns="False" datakeynames="IDFile" clientdatakeynames="IDFile">
                            <Columns>
                                <telerik:GridBoundColumn DataField="IDFile" DataType="System.Int32" DefaultInsertValue=""
                                    HeaderText="ID" ReadOnly="True" SortExpression="IDFile" UniqueName="IDFile" Display="True">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Title" DataType="System.Int32" DefaultInsertValue=""
                                    HeaderText="Title" ReadOnly="True" SortExpression="Title" UniqueName="Title" Display="True">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </mastertableview>
                    </telerik:radgrid>
			<h3>
				Engines and DECS Files that will be deleted</h3>
			<telerik:radgrid id="rg_EngineFiles" runat="server" cssclass="radgrid" gridlines="None"
				width="600px">
                            <mastertableview autogeneratecolumns="False" datakeynames="IDFile" clientdatakeynames="IDFile">
                            <Columns>
                                <telerik:GridBoundColumn DataField="IDFile" DataType="System.Int32" DefaultInsertValue=""
                                    HeaderText="ID" ReadOnly="True" SortExpression="IDFile" UniqueName="IDFile" Display="True">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Title" DataType="System.Int32" DefaultInsertValue=""
                                    HeaderText="Title" ReadOnly="True" SortExpression="Title" UniqueName="Title" Display="True">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </mastertableview>
                    </telerik:radgrid>
			<p>
				&nbsp;
			</p>
			<p>
				&nbsp;
			</p>
			<p>
				&nbsp;
			</p>
			<p>
				&nbsp;
			</p>
			<asp:SqlDataSource ID="sds_Vehicles" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
				SelectCommand="SELECT [IDVehicles], [IDEngines], [IDDECS], [UnitNo], [LicensePlateNo] FROM [CFV_Join_V_E_D] WHERE ([IDVehicles] = @IDVehicles)">
				<SelectParameters>
					<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
				</SelectParameters>
				<DeleteParameters>
				</DeleteParameters>
				<UpdateParameters>
				</UpdateParameters>
				<InsertParameters>
				</InsertParameters>
			</asp:SqlDataSource>
			<br />
			<asp:SqlDataSource ID="sds_EngineRecords" runat="server" ConnectionString="<%$ ConnectionStrings:CF_SQL_Connection %>"
				SelectCommand="SELECT [IDEngines], [IDVehicles] FROM [CF_Engines] WHERE ([IDVehicles] = @IDVehicles)">
				<SelectParameters>
					<asp:QueryStringParameter Name="IDVehicles" QueryStringField="IDVehicles" />
				</SelectParameters>
			</asp:SqlDataSource>
</asp:Content>
