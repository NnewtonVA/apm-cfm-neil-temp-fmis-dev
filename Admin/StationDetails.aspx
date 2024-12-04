<%@ Page Title="Station Detail" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="StationDetails.aspx.vb" Inherits="CFMISNew.StationDetails" %>
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
        
        .auto-style26 {
            width: 307px;
        }
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" ></asp:ScriptManager>
   <br />
    <div class="wideBox" style="padding-left:15px">
        <table style="width: 589px"><tr><td class="auto-style26">
            <h3>Station Information Details</h3>
                   </td><td>
                        <asp:Label ID="lblResult" runat="server" ForeColor="#336600" Font-Bold="True" ></asp:Label>
                        </td></tr></table>
        <asp:FormView ID="fvStationDatails" runat="server" DataKeyNames="station_pk" DataSourceID="odsrcStationDetails" Height="182px" Width="95%" DefaultMode="Edit">
            <EditItemTemplate>
                <table style="width: 100%; height: 303px"><tr><td class="auto-style22">
                    <asp:Label ID="lblEdtStnNo" runat="server" Text="Station No:" Font-Bold="True"></asp:Label>
                       </td><td class="auto-style22">
                           <asp:TextBox ID="txtEdtStnNo" runat="server" Text='<%# Bind("stationNo") %>' Width="180px" />
                       </td>
                    <td class="auto-style23"></td>
                    <td class="auto-style22">
                        <asp:Label ID="lblEdtAddress" runat="server" Font-Bold="True" Text="Facility Address:"></asp:Label>
                    </td>
                    <td class="auto-style22">
                        <asp:TextBox ID="txtEdtAddress" runat="server" Text='<%# Bind("address1") %>' Width="200px" />
                    </td>
                    </tr>
                    <tr><td class="auto-style24">
                        <asp:Label ID="lblEdtStnName" runat="server" Text="Station Name:" Font-Bold="True"></asp:Label>
                    </td><td class="auto-style24">
                        <asp:TextBox ID="txtEdtStnName" runat="server" Text='<%# Bind("stationName") %>' Width="230px" />
                    </td>
                        <td class="auto-style25"></td>
                        <td class="auto-style24">
                            <asp:Label ID="lblEdtCity" runat="server" Font-Bold="True" Text="City:"></asp:Label>
                        </td>
                        <td class="auto-style24">
                            <asp:TextBox ID="txtEdtCity" runat="server" Text='<%# Bind("city") %>' Width="200px" />
                        </td>
                    </tr><tr><td class="auto-style24">
                        <asp:Label ID="lblEdtStnDesc" runat="server" Text="Station Description:" Font-Bold="True"></asp:Label>
                    </td><td class="auto-style24">
                        <asp:TextBox ID="txtEdtStnDesc" runat="server" Text='<%# Bind("stationdesc") %>' Width="230px" />
                    </td>
                        <td class="auto-style25"></td>
                        <td class="auto-style24">
                            <asp:Label ID="lblEdtState" runat="server" Font-Bold="True" Text="State:"></asp:Label>
                        </td>
                        <td class="auto-style24">
                            <asp:DropDownList ID="ddlEdtState" runat="server" AppendDataBoundItems="True" DataSourceID="sdsrcStates" DataTextField="stateName" DataValueField="State_pk" SelectedValue='<%# Bind("State_pk")%>' Width="180px">
                                <asp:ListItem Text="-Select-" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr><tr><td class="auto-style24">
                        <asp:Label ID="lblEdtAdminOffice" runat="server" Text="Administrative Office:" Font-Bold="True"></asp:Label>
                             </td><td class="auto-style24">
                                 <asp:DropDownList ID="ddlEdtAdminOffice" runat="server" DataSourceID="sdsrcAdminOffice" DataTextField="description" 
                                     DataValueField="admin_pk" Width="234px" AppendDataBoundItems="True" SelectedValue='<%# Bind("Admin_fk") %>'>
                                     <asp:ListItem Text="-Select-" Value=""></asp:ListItem>
                                 </asp:DropDownList> 
                             </td>
                        <td class="auto-style25"></td>
                        <td class="auto-style24">
                            <asp:Label ID="lblEdtZip" runat="server" Font-Bold="True" Text="Zip Code:"></asp:Label>
                        </td>
                        <td class="auto-style24">
                             <asp:TextBox ID="txtEdtZip" runat="server" Text='<%# Bind("zipcode")%>' Width="80px"></asp:TextBox>
                             <asp:Label ID="lblPlus" runat="server" Text=" + "></asp:Label>
                             <asp:TextBox ID="txtEdtZip4" runat="server" Text='<%# Bind("zipcode4")%>' Width="40px"></asp:TextBox>
                             <asp:RegularExpressionValidator ID="rxvZip" runat="server" ControlToValidate="txtEdtZip" ErrorMessage="Zip (5)" ForeColor="Red" ValidationExpression="^\d{5}$"></asp:RegularExpressionValidator>
                             <asp:RegularExpressionValidator ID="revZip4" runat="server" ControlToValidate="txtEdtZip4" ErrorMessage="Zip (4)" ForeColor="Red" ValidationExpression="^\d{4}$"></asp:RegularExpressionValidator>
                             </td></tr>                    
                    <tr><td class="auto-style24">
                        <asp:Label ID="lblEdtRegion" runat="server" Font-Bold="True" Text="Region:"></asp:Label>
                    </td><td class="auto-style24">
                            <asp:DropDownList ID="ddlEdtRegion" runat="server" AppendDataBoundItems="True" DataSourceID="sdsrcRegion" DataTextField="region" DataValueField="region" SelectedValue='<%# Bind("region")%>' Width="182px">
                                <asp:ListItem Text="-Select-" Value=""></asp:ListItem>
                            </asp:DropDownList>
                    </td>
                        <td class="auto-style25"></td>
                        <td class="auto-style24">
                            <asp:Label ID="lblEdtInactv" runat="server" Font-Bold="True" Text="Delete/Inactivate:"></asp:Label>
                        </td>
                        <td class="auto-style24">
                            <asp:CheckBox ID="cbEdtInactv" runat="server" Checked='<%# Bind("deleted") %>' />
                        </td>
                    </tr><tr><td class="auto-style24">
                        <asp:Label ID="lblEdtStnId" runat="server" Text='<%# Eval("station_pk") %>' Visible="False" />
                    </td><td class="auto-style24">
                            <asp:SqlDataSource ID="sdsrcAdminOffice" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" SelectCommand="SELECT [admin_pk], [name], [description] FROM [lkAdministration]"></asp:SqlDataSource>
                    </td>
                        <td class="auto-style25"></td>
                        <td class="auto-style24">
                            <asp:SqlDataSource ID="sdsrcRegion" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" SelectCommand="SELECT DISTINCT [region] FROM [lkStation]"></asp:SqlDataSource>
                        </td>
                        <td class="auto-style24">
                            <asp:SqlDataSource ID="sdsrcStates" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" SelectCommand="SELECT [State_pk], [stateCode], [stateName] FROM [lkState]"></asp:SqlDataSource>
                        </td>
                    </tr></table>
                <table style="width: 401px" align="center"><tr><td align="center" class="auto-style11">
                    <asp:Button ID="btnEdtStn" runat="server" Text="Save" Font-Bold="True" Height="25px" Width="75px" OnClick="btnEdtStn_Click" />
                       </td><td align="center" class="auto-style11">
                           <asp:Button ID="btnCnclEdt" runat="server" Text="Cancel" Font-Bold="True" CommandName="Cancel" Height="25px" Width="75px" />
                       </td><td align="center" class="auto-style13">
                           <asp:Button ID="btnExitStn" runat="server" Text="Exit" Font-Bold="True" Height="25px" Width="75px" OnClick="btnExitStn_Click" />
                       </td></tr></table>
            </EditItemTemplate>
            <InsertItemTemplate>
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblStnId" runat="server" Text='<%# Eval("station_pk") %>' />
                <br />
                <asp:CheckBox ID="cbDelete" runat="server" Checked='<%# Bind("deleted") %>' Enabled="false" />
                <br />
                <asp:Label ID="lblStnNo" runat="server" Text='<%# Bind("stationNo") %>' />
                <br />
                <asp:Label ID="lblStnName" runat="server" Text='<%# Bind("stationName") %>' />
                <br />
                <asp:Label ID="lblStnDesc" runat="server" Text='<%# Bind("stationdesc") %>' />
                <br />
                <asp:Label ID="lblStnAddress" runat="server" Text='<%# Bind("address1") %>' />
                <br />
                <asp:Label ID="lblCity" runat="server" Text='<%# Bind("city") %>' />
                <br />
                <asp:Label ID="lblState" runat="server" Text='<%# Bind("stateName") %>' />
                <br />
                <asp:Label ID="regionLabel" runat="server" Text='<%# Bind("region") %>' />
            </ItemTemplate>
         </asp:FormView>
         <asp:ObjectDataSource ID="odsrcStationDetails" runat="server" SelectMethod="GetStationInfoById" TypeName="FactSheetApp.FactSheetNewTableAdapters.StationInfoTableAdapter">
             <SelectParameters>
                 <asp:QueryStringParameter Name="StationId" QueryStringField="station_pk" Type="Int32" />
             </SelectParameters>
         </asp:ObjectDataSource>
        <br />
        <br />
    </div>


</asp:Content>
