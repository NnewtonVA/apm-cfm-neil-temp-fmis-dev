<%@ Page Title="Add Station" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="StationAdd.aspx.vb" Inherits="CFMISNew.StationAdd" %>

<%@ Register Src="~/UserControl/UCMenuAdmin.ascx" TagPrefix="uc1" TagName="UCMenuAdmin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style11 {
            height: 19px;
        }
        .auto-style13 {
            width: 129px;
        }
        .auto-style22 {
            height: 35px;
        }
        .auto-style23 {
            width: 39px;
            height: 35px;
        }
        .auto-style24 {
            height: 36px;
        }
        .auto-style25 {
            width: 39px;
            height: 36px;
        }
        .auto-style29 {
        width: 252px;
        height: 25px;
    }
    .auto-style30 {
        width: 55px;
        height: 25px;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <asp:ScriptManager ID="ScriptManager1" runat="server" ></asp:ScriptManager>
   <br />
    <div class="wideBox" style="padding-left:15px">
        <table style="width: 451px"><tr><td class="auto-style29">
            <h3>Add New Station</h3>
                   </td><td class="auto-style30">
                        <asp:Label ID="lblResult" runat="server" ForeColor="#009900" ></asp:Label>
                        </td></tr></table>
        <asp:FormView ID="fvAddStn" runat="server" DataSourceID="odsrcAddStation" DataKeyNames="station_pk" Width="90%" DefaultMode="Insert">
            <EditItemTemplate></EditItemTemplate>
            <InsertItemTemplate>
                <table style="width: 100%; height: 295px"><tr><td class="auto-style22">
                    <asp:Label ID="lblAddStnNo" runat="server" Text="Station No:" Font-Bold="True"></asp:Label>
                       </td><td class="auto-style22">
                           <asp:TextBox ID="txtAddStnNo" runat="server" Text='<%# Bind("stationNo") %>' Width="180px" />
                           <asp:RequiredFieldValidator ID="rfvStnNo" runat="server" ControlToValidate="txtAddStnNo" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                       </td>
                    <td class="auto-style23"></td>
                    <td class="auto-style22">
                        <asp:Label ID="lblAddAddress" runat="server" Font-Bold="True" Text="Facility Address:"></asp:Label>
                    </td>
                    <td class="auto-style22">
                        <asp:TextBox ID="txtAddAddress" runat="server" Text='<%# Bind("address1") %>' Width="200px" />
                    </td>
                    </tr>
                    <tr><td class="auto-style24">
                        <asp:Label ID="lblAddStnName" runat="server" Text="Station Name:" Font-Bold="True"></asp:Label>
                    </td><td class="auto-style24">
                        <asp:TextBox ID="txtAddStnName" runat="server" Text='<%# Bind("stationName") %>' Width="230px" />
                    </td>
                        <td class="auto-style25"></td>
                        <td class="auto-style24">
                            <asp:Label ID="lblAddCity" runat="server" Font-Bold="True" Text="City:"></asp:Label>
                        </td>
                        <td class="auto-style24">
                            <asp:TextBox ID="txtAddCity" runat="server" Text='<%# Bind("city") %>' Width="200px" />
                        </td>
                    </tr><tr><td class="auto-style24">
                        <asp:Label ID="lblAddStnDesc" runat="server" Text="Station Description:" Font-Bold="True"></asp:Label>
                    </td><td class="auto-style24">
                        <asp:TextBox ID="txtAddStnDesc" runat="server" Text='<%# Bind("stationdesc") %>' Width="230px" />
                    </td>
                        <td class="auto-style25"></td>
                        <td class="auto-style24">
                            <asp:Label ID="lblAddState" runat="server" Font-Bold="True" Text="State:"></asp:Label>
                        </td>
                        <td class="auto-style24">
                            <asp:DropDownList ID="ddlAddState" runat="server" AppendDataBoundItems="True" DataSourceID="sdsrcStates" DataTextField="stateName" DataValueField="State_pk" SelectedValue='<%# Bind("State_pk")%>' Width="180px">
                                <asp:ListItem Text="-Select-" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr><tr><td class="auto-style24">
                        <asp:Label ID="lblAddAdminOffice" runat="server" Text="Administrative Office:" Font-Bold="True"></asp:Label>
                             </td><td class="auto-style24">
                                 <asp:DropDownList ID="ddlAddAdminOffice" runat="server" DataSourceID="sdsrcAdminOffice" DataTextField="description" 
                                     DataValueField="admin_pk" Width="234px" AppendDataBoundItems="True" SelectedValue='<%# Bind("Admin_fk") %>'>
                                     <asp:ListItem Text="-Select-" Value=""></asp:ListItem>
                                 </asp:DropDownList> 
                             </td>
                        <td class="auto-style25"></td>
                        <td class="auto-style24">
                            <asp:Label ID="lblAddZip" runat="server" Font-Bold="True" Text="Zip Code:"></asp:Label>
                        </td>
                        <td class="auto-style24">
                             <asp:TextBox ID="txtAddZip" runat="server" Text='<%# Bind("zipcode")%>' Width="80px"></asp:TextBox>
                             <asp:Label ID="lblPlus" runat="server" Text=" + "></asp:Label>
                             <asp:TextBox ID="txtAddZip4" runat="server" Text='<%# Bind("zipcode4")%>' Width="40px"></asp:TextBox>
                             <asp:RegularExpressionValidator ID="rxvZip" runat="server" ControlToValidate="txtAddZip" ErrorMessage="Zip (5)" ForeColor="Red" ValidationExpression="^\d{5}$"></asp:RegularExpressionValidator>
                             <asp:RegularExpressionValidator ID="revZip4" runat="server" ControlToValidate="txtAddZip4" ErrorMessage="Zip (4)" ForeColor="Red" ValidationExpression="^\d{4}$"></asp:RegularExpressionValidator>
                             </td></tr>                    
                    <tr><td class="auto-style24">
                        <asp:Label ID="lblAddRegion" runat="server" Font-Bold="True" Text="Region:"></asp:Label>
                    </td><td class="auto-style24">
                            <asp:DropDownList ID="ddlAddRegion" runat="server" AppendDataBoundItems="True" DataSourceID="sdsrcRegion" DataTextField="region" DataValueField="region" SelectedValue='<%# Bind("region")%>' Width="182px">
                                <asp:ListItem Text="-Select-" Value=""></asp:ListItem>
                            </asp:DropDownList>
                    </td>
                        <td class="auto-style25"></td>
                        <td class="auto-style24">
                            <asp:Label ID="lblAddInactv" runat="server" Font-Bold="True" Text="Delete/Inactivate:"></asp:Label>
                        </td>
                        <td class="auto-style24">
                            <asp:CheckBox ID="cbAddInactv" runat="server" Checked='<%# Bind("deleted") %>' />
                        </td>
                    </tr><tr><td class="auto-style24">
                        <asp:Label ID="lblAddStnId" runat="server" Text='<%# Eval("station_pk") %>' Visible="False" />
                    </td><td class="auto-style24">
                            <asp:SqlDataSource ID="sdsrcAdminOffice" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" SelectCommand="SELECT [admin_pk], [name], [description] FROM [lkAdministration]"></asp:SqlDataSource>
                    </td>
                        <td class="auto-style25"></td>
                        <td class="auto-style24">
                            <asp:SqlDataSource ID="sdsrcRegion" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                                SelectCommand="SELECT DISTINCT [region] FROM [lkStation] where region is not null"></asp:SqlDataSource>
                        </td>
                        <td class="auto-style24">
                            <asp:SqlDataSource ID="sdsrcStates" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" SelectCommand="SELECT [State_pk], [stateCode], [stateName] FROM [lkState]"></asp:SqlDataSource>
                        </td>
                    </tr></table>
                <table style="width: 401px" align="center"><tr><td align="center" class="auto-style11">
                    <asp:Button ID="btnAddStn" runat="server" Text="Save" Font-Bold="True" Height="25px" Width="75px" OnClick="btnAddStn_Click"  />
                       </td><td align="center" class="auto-style11">
                           <asp:Button ID="btnCnclAdd" runat="server" Text="Reset" Font-Bold="True" CommandName="Cancel" Height="25px" Width="75px" />
                       </td><td align="center" class="auto-style13">
                           <asp:Button ID="btnExitStn" runat="server" Text="Exit" Font-Bold="True" Height="25px" Width="75px" OnClick="btnExitStn_Click" CausesValidation="false" />
                       </td></tr></table>
               
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblStnId" runat="server" Text='<%# Eval("station_pk") %>' />
                <asp:CheckBox ID="cbDeleted" runat="server" Checked='<%# Bind("deleted") %>' Enabled="false" />
                <asp:Label ID="lblStnNo" runat="server" Text='<%# Bind("stationNo") %>' />
                <asp:Label ID="lblStnName" runat="server" Text='<%# Bind("stationName") %>' />
                <asp:Label ID="lblStnDes" runat="server" Text='<%# Bind("stationdesc") %>' />
                <asp:Label ID="lblStnAddress" runat="server" Text='<%# Bind("address1") %>' />
                <asp:Label ID="lblCity" runat="server" Text='<%# Bind("city") %>' />
                <asp:Label ID="lblRegion" runat="server" Text='<%# Bind("region") %>' />
                <asp:Label ID="lblState" runat="server" Text='<%# Eval("State_pk") %>' />
                <asp:Label ID="lblZip" runat="server" Text='<%# Bind("zipcode") %>' />
                <asp:Label ID="lblZip4" runat="server" Text='<%# Bind("zipcode4") %>' />
                <asp:Label ID="lblAdmin" runat="server" Text='<%# Bind("Admin_fk") %>' />


            </ItemTemplate>

        </asp:FormView>


        <asp:ObjectDataSource ID="odsrcAddStation" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetStationInformation" TypeName="FactSheetApp.FactSheetNewTableAdapters.StationInfoTableAdapter"></asp:ObjectDataSource>


    </div>

   
</asp:Content>

