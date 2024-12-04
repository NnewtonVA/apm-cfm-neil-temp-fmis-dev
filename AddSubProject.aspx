<%@ Page Title="Add Sub Project" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AddSubProject.aspx.vb" Inherits="CFMISNew.AddSubProject" %>
<%@ Register Src="~/UserControl/UCMenuGeneral.ascx" TagPrefix="uc1" TagName="UCMenuGeneral" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style type="text/css">
        .auto-style2 {
            width: 133px;
        }
        .auto-style6 {
            height: 490px;
        }
         .auto-style7 {
             width: 360px;
         }
         .auto-style11 {
             width: 114px;
         }

         .auto-style12 {
             width: 412px;
         }

         .auto-style14 {
             width: 139px;
         }
         
         </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
     <table style="width:99%;"><tr><td valign="top" class="auto-style6">
        <div class="wideBox" style="padding-left:15px">
           <table style="width: 624px"><tr><td class="auto-style12">
               <%--<h3>Add a New Sub Project</h3>--%>
               <asp:Label ID="lblProjnum" runat="server" Font-Bold="True" Font-Size="15px" ></asp:Label>
                  </td><td>
                      
                       <asp:Label ID="lblError" runat="server" Font-Bold="True" ForeColor="Red" Font-Size="12px"></asp:Label>
                  </td></tr></table> 
            <br />
                             
                    <asp:FormView ID="fvAddProject" runat="server" DataSourceID="odsrcAddProject" Width="724px">
                        <EditItemTemplate>                           
                        </EditItemTemplate>
                        <InsertItemTemplate>        
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <table>
                                <tr><td class="auto-style2">
                                        <asp:Label ID="lblAddStation" runat="server" Text="Station: " Font-Bold="True"></asp:Label>
                                    </td><td class="auto-style7">
                                        <asp:Label ID="lblStation" runat="server" Text='<%# String.Concat(Eval("stationNo"), " - ", Eval("projectName"))%>' Font-Bold="True"></asp:Label>
                                       <%-- <asp:DropDownList ID="ddlStation" runat="server" Height="21px" Width="95%" DataSourceID="odsrcStationList" DataTextField="Station"  DataValueField="station_pk" SelectedValue='<%# Bind("station_fk") %>' >
                                        </asp:DropDownList>
                                        <asp:ObjectDataSource ID="odsrcStationList" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetStationsList" TypeName="FactSheetApp.FactSheetNewTableAdapters.StationListTableAdapter"></asp:ObjectDataSource>--%>
                                    </td>
                                    <td class="auto-style11">&nbsp;</td>
                                </tr><tr><td class="auto-style2">
                                    <asp:Label ID="lblRegion" runat="server" Text="Region:" Font-Bold="True"></asp:Label>
                                         </td><td class="auto-style7">
                                              <asp:Label ID="lblAddRegion" runat="server" Text='<%# Bind("region") %>' Font-Bold="True"></asp:Label>
                                              &nbsp;<asp:Label ID="lblNcaDistrict" runat="server" Font-Bold="True" Text='<%# Bind("NCAdistrict")%>'></asp:Label>
                                              </td><td class="auto-style11"></td></tr>
                                <tr><td class="auto-style2">
                                    <asp:Label ID="lblAddProjDes" runat="server" Text="Project Description: " Font-Bold="True"></asp:Label>
                                    </td><td class="auto-style7">
                                         <asp:TextBox ID="txtProjDesc" runat="server" Text='<%# Bind("projectDesc") %>' Width="95%" />
                                    </td>
                                    <td class="auto-style11">
                                        <asp:RequiredFieldValidator ID="rfvProjDesc" runat="server" ControlToValidate="txtProjDesc" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator></td>
                                </tr><tr><td class="auto-style2">
                                        <asp:Label ID="lblAddProjNo" runat="server" Text="Project Number: " Font-Bold="True"></asp:Label> 
                                     </td><td class="auto-style7">
                                       <asp:TextBox ID="txtProjCode" runat="server" Text='<%# Bind("projectCode") %>' Width="95%" />
                                     </td>
                                    <td class="auto-style11">
                                        
                                        <%--<asp:RequiredFieldValidator ID="rfvProjCode" runat="server" ControlToValidate="txtProjCode" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                        <cc1:MaskedEditExtender ID="meeProjCode" runat="server" TargetControlID="txtProjCode"  Mask="999-999-L" InputDirection="LeftToRight" ClearMaskOnLostFocus="False"></cc1:MaskedEditExtender>
                                    </td>
                                </tr><tr><td class="auto-style2">
                                         <asp:Label ID="lblAddStatus" runat="server" Text="Status: " Font-Bold="True"></asp:Label> 
                                     </td><td class="auto-style7">
                                         <asp:DropDownList ID="ddlStatus" runat="server" Height="21px" Width="95%" DataSourceID="odsrcStatusList" DataTextField="statusName" DataValueField="status_pk" SelectedValue='<%# Bind("status_fk") %>' AppendDataBoundItems="True">
                                             <asp:ListItem Text="-Select-" Value="0"></asp:ListItem>
                                         </asp:DropDownList>
                                         <asp:ObjectDataSource ID="odsrcStatusList" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetStatusList" TypeName="FactSheetApp.FactSheetNewTableAdapters.lkProjectStatusTableAdapter" UpdateMethod="Update">
                                             <DeleteParameters>
                                                 <asp:Parameter Name="Original_status_pk" Type="Int32" />
                                             </DeleteParameters>
                                             <InsertParameters>
                                                 <asp:Parameter Name="statusName" Type="String" />
                                             </InsertParameters>
                                             <UpdateParameters>
                                                 <asp:Parameter Name="statusName" Type="String" />
                                                 <asp:Parameter Name="Original_status_pk" Type="Int32" />
                                             </UpdateParameters>
                                         </asp:ObjectDataSource>
                                     </td>
                                    <td class="auto-style11"><asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus" ErrorMessage="Select Status" ForeColor="Red" InitialValue="0"></asp:RequiredFieldValidator></td>
                                </tr><tr><td class="auto-style2">
                                         <asp:Label ID="lblAddDelivery" runat="server" Text="Method of Delivery: " Font-Bold="True"></asp:Label> 
                                     </td><td class="auto-style7">
                                         <asp:DropDownList ID="ddlDelivary" runat="server" Height="21px" Width="95%" DataSourceID="odsrcDelivaryList" DataTextField="deliveryMethodName" DataValueField="deliveryMethod_pk" SelectedValue='<%# Bind("delivery_method_fk") %>' AppendDataBoundItems="True">
                                             <asp:ListItem Text="-Select-" Value=""></asp:ListItem>
                                         </asp:DropDownList>
                                                       <asp:ObjectDataSource ID="odsrcDelivaryList" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDelivaryMethodList" TypeName="FactSheetApp.FactSheetNewTableAdapters.lkDeliveryMethodTableAdapter" UpdateMethod="Update">
                                                           <DeleteParameters>
                                                               <asp:Parameter Name="Original_deliveryMethod_pk" Type="Int32" />
                                                           </DeleteParameters>
                                                           <InsertParameters>
                                                               <asp:Parameter Name="deliveryMethodName" Type="String" />
                                                           </InsertParameters>
                                                           <UpdateParameters>
                                                               <asp:Parameter Name="deliveryMethodName" Type="String" />
                                                               <asp:Parameter Name="Original_deliveryMethod_pk" Type="Int32" />
                                                           </UpdateParameters>
                                         </asp:ObjectDataSource>
                                                       </td>
                                    <td class="auto-style11">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">
                                        <asp:Label ID="lblAddProgCat" runat="server" Font-Bold="True" Text="Program Category: "></asp:Label>
                                    </td>
                                    <td class="auto-style7">
                                        <asp:DropDownList ID="ddlProgCat" runat="server" AppendDataBoundItems="True" DataSourceID="odsrcProgramList" DataTextField="CategoryName" DataValueField="Category_pk" Height="21px" SelectedValue='<%# Bind("Category_fk")%>' Width="95%">
                                            <asp:ListItem Text="-Select from list-" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:ObjectDataSource ID="odsrcProgramList" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetProgramCatList" TypeName="FactSheetApp.FactSheetNewTableAdapters.lkProgramCategoryTableAdapter" UpdateMethod="Update">
                                            <DeleteParameters>
                                                <asp:Parameter Name="Original_Category_pk" Type="Int32" />
                                            </DeleteParameters>
                                            <InsertParameters>
                                                <asp:Parameter Name="CategoryName" Type="String" />
                                            </InsertParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="CategoryName" Type="String" />
                                                <asp:Parameter Name="Original_Category_pk" Type="Int32" />
                                            </UpdateParameters>
                                        </asp:ObjectDataSource>
                                    </td>
                                    <td class="auto-style11">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">
                                        <asp:Label ID="lblAddProgSubCat" runat="server" Font-Bold="True" Text="Program Sub Category: "></asp:Label>
                                    </td>
                                    <td class="auto-style7">
                                        <asp:DropDownList ID="ddlSubCat" runat="server" AppendDataBoundItems="True" DataSourceID="odsrcSubProgramList" DataTextField="SubCategoryName" DataValueField="SubCategory_pk" Height="21px" SelectedValue='<%# Bind("SubCategory_fk") %>' Width="95%">
                                            <asp:ListItem Text="-Select from list-" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:ObjectDataSource ID="odsrcSubProgramList" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetProgramSubCatList" TypeName="FactSheetApp.FactSheetNewTableAdapters.lkProgramSubCategoryTableAdapter" UpdateMethod="Update">
                                            <DeleteParameters>
                                                <asp:Parameter Name="Original_SubCategory_pk" Type="Int32" />
                                            </DeleteParameters>
                                            <InsertParameters>
                                                <asp:Parameter Name="SubCategoryName" Type="String" />
                                            </InsertParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="SubCategoryName" Type="String" />
                                                <asp:Parameter Name="Original_SubCategory_pk" Type="Int32" />
                                            </UpdateParameters>
                                        </asp:ObjectDataSource>
                                    </td>
                                    <td class="auto-style11">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">
                                        <asp:Label ID="lblAddFmsNo" runat="server" Font-Bold="True" Text="Current FMS Number: " Visible="False"></asp:Label>
                                    </td>
                                    <td class="auto-style7">
                                        <asp:TextBox ID="txtFmsNo" runat="server" Text='<%# Bind("fms_number") %>' Visible="False" Width="95%" />
                                    </td>
                                    <td class="auto-style11">&nbsp;</td>
                                </tr>
                            </table>
                            <br />
                            <asp:Label ID="lblStationFk" runat="server" Text='<%# Bind("station_fk") %>' Visible="False" />
                             <asp:Label ID="lblProjId" runat="server" Text='<%# Bind("project_pk") %>' Visible="False" />
                            <asp:Label ID="lblNcaDistFk" runat="server" Text='<%# Bind("ncaDistrict_fk")%>' Visible="False"></asp:Label>
                            <asp:Label ID="lblProjCode" runat="server" Text='<%# Bind("ProjectCode")%>' Visible="False"></asp:Label>
                            <asp:Label ID="lblProjType" runat="server" Text='<%# Bind("projectType_fk") %>' Visible="False"></asp:Label>
                            <br />

                             <table align="center" style="width: 421px; height: 30px"><tr><td align="center">
                                 <asp:Button ID="btnAddSubProj" runat="server" Text="Submit" CssClass="submitBtn" OnClick="btnAddSubProj_Click" />
                             </td><td align="center">
                                 <asp:Button ID="btnClear" runat="server" Text="Reset" CausesValidation="false" CssClass="submitBtn"  OnClick="btnClear_Click" />                               
                             </td><td align="center">
                                 <asp:Button ID="btnCanclSubProj" runat="server" Text="Exit" CausesValidation="false" CssClass="submitBtn" OnClick="btnCanclSubProj_Click" />
                                  </td></tr></table>
                        </ItemTemplate>
                    </asp:FormView>
                    <asp:ObjectDataSource ID="odsrcAddProject" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetInfoForProjectDetails" TypeName="FactSheetApp.FactSheetNewTableAdapters.vw_ProjectTableAdapter">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
      </div>
    
           </td></tr></table>


</asp:Content>
