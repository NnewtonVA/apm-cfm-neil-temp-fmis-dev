<%@ Page Title="Add Project" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AddProject.aspx.vb" Inherits="CFMISNew.AddProject" %>

<%@ Register Src="~/UserControl/UCMenuAdmin.ascx" TagPrefix="uc1" TagName="UCMenuAdmin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <style type="text/css">
        .auto-style5 {
            width: 200px;
            height: 490px;
        }
        .auto-style6 {
            height: 490px;
        }
       
        .auto-style13 {
            width: 204px;
        }
        .auto-style15 {
            width: 125px;
        }
        .auto-style16 {
            width: 236px;
        }
        
        .auto-style17 {
            width: 125px;
            height: 26px;
        }
        .auto-style18 {
            width: 204px;
            height: 26px;
        }
        .auto-style19 {
            width: 236px;
            height: 26px;
        }
        
        .auto-style20 {
            width: 277px;
        }
        .auto-style21 {
            width: 277px;
            height: 26px;
        }
        
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <table style="width:99%;"><tr><td style="vertical-align:top; " class="auto-style5">
        <asp:Label ID="lblRole" runat="server" Visible="False"></asp:Label>
        <uc1:UCMenuAdmin runat="server" ID="UCMenuAdmin" />
           </td><td valign="top" class="auto-style6">
                <div class="wideBox" style="padding-left:15px">
        <h3>Add a New Project</h3>
                    <b>To Add a Sub Project, Go to the Main Project's Details page     </b>
                     <asp:Label ID="lblError" runat="server" Font-Bold="True" ForeColor="Red" Font-Size="12px"></asp:Label>
                    <asp:FormView ID="fvAddProject" runat="server" DataKeyNames="project_pk" DataSourceID="odsrcAddProject" 
                        DefaultMode="Insert" Width="93%" Height="350px">
                        <EditItemTemplate></EditItemTemplate>
                        <InsertItemTemplate>
                            <table style="width: 554px" width="560px">
                                <tr><td class="auto-style15">
                                    <asp:Label ID="lblAddProjDes" runat="server" Text="Project Description: " Font-Bold="True"></asp:Label>
                                    </td><td class="auto-style20">
                                         <asp:TextBox ID="txtProjDesc" runat="server" Text='<%# Bind("projectDesc") %>' Width="95%" />
                                    </td>
                                    <td class="auto-style16">
                                        <asp:RequiredFieldValidator ID="rfvProjDesc" runat="server" ControlToValidate="txtProjDesc" ErrorMessage="Required" Font-Bold="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr><tr><td class="auto-style17">
                                        <asp:Label ID="lblAddStation" runat="server" Text="Station: " Font-Bold="True"></asp:Label>
                                    </td><td class="auto-style21">
                                        <asp:DropDownList ID="ddlStation" runat="server" Height="21px" Width="95%" DataSourceID="odsrcStationList" DataTextField="Station"  DataValueField="station_pk" SelectedValue='<%# Bind("station_fk") %>' AppendDataBoundItems="True">
                                            <asp:ListItem Text="-Select-" Value="0"></asp:ListItem>
                                        </asp:DropDownList>                                        
                                    </td>
                                    <td class="auto-style19">
                                        <asp:RequiredFieldValidator ID="rfvStation" runat="server" ControlToValidate="ddlStation" ErrorMessage="Select Station" Font-Bold="True" ForeColor="Red" InitialValue="0"></asp:RequiredFieldValidator>
                                    </td>
                                </tr><tr><td class="auto-style15">
                                        <asp:Label ID="lblAddProjNo" runat="server" Text="Project Number: " Font-Bold="True"></asp:Label> 
                                     </td><td class="auto-style20">
                                       <asp:TextBox ID="txtProjCode" runat="server" Text='<%# Bind("projectCode") %>' Width="95%" />
                                     </td>
                                    <td class="auto-style16">
                                        <%--<asp:RequiredFieldValidator ID="rfvProjCode" runat="server" ControlToValidate="txtProjCode" ErrorMessage="Required" Font-Bold="true" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                        <cc1:MaskedEditExtender ID="meeProjCode" runat="server" TargetControlID="txtProjCode"  Mask="999-999" InputDirection="LeftToRight" ClearMaskOnLostFocus="False"></cc1:MaskedEditExtender>
                                        <%--<asp:RegularExpressionValidator ID="regvProjectCode" runat="server" ControlToValidate="txtProjCode" ForeColor="Red" ValidationExpression="^(\d{3}-\d{3})$" ErrorMessage="Sub project cannot be added here"></asp:RegularExpressionValidator>--%>
                                    </td>
                                </tr><tr><td class="auto-style15">
                                         <asp:Label ID="lblAddStatus" runat="server" Text="Status: " Font-Bold="True"></asp:Label> 
                                     </td><td class="auto-style20">
                                         <asp:DropDownList ID="ddlStatus" runat="server" Height="21px" Width="95%" DataSourceID="odsrcStatusList" DataTextField="statusName" DataValueField="status_pk" SelectedValue='<%# Bind("status_fk") %>' AppendDataBoundItems="True">
                                             <asp:ListItem Text="-Select-" Value="0"></asp:ListItem>
                                         </asp:DropDownList>
                                     </td>
                                    <td class="auto-style16">
                                        <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus" ErrorMessage="Select Status" Font-Bold="true" ForeColor="Red" InitialValue="0"></asp:RequiredFieldValidator>
                                    </td>
                                </tr><tr><td class="auto-style17">
                                         <asp:Label ID="lblAddDelivery" runat="server" Text="Method of Delivery: " Font-Bold="True"></asp:Label> 
                                     </td><td class="auto-style21">
                                         <asp:DropDownList ID="ddlDelivary" runat="server" Height="21px" Width="95%" DataSourceID="odsrcDelivaryList" DataTextField="deliveryMethodName" DataValueField="deliveryMethod_pk" SelectedValue='<%# Bind("delivery_method_fk") %>' AppendDataBoundItems="True">
                                             <asp:ListItem Text="-Select-" Value="0"></asp:ListItem>
                                         </asp:DropDownList>
                                                       </td>
                                    <td class="auto-style19">
                                        <asp:RequiredFieldValidator ID="rfvDelivery" runat="server" ControlToValidate="ddlDelivary" ErrorMessage="Select Delivery Method" Font-Bold="true" ForeColor="Red" InitialValue="0"></asp:RequiredFieldValidator>
                                    </td>
                                </tr><tr><td class="auto-style15">
                                        <asp:Label ID="lblAddFmsNo" runat="server" Text="Current FMS Number: " Font-Bold="True" Visible="False"></asp:Label> 
                                    </td><td class="auto-style20">
                                       <asp:TextBox ID="txtFmsNo" runat="server" Text='<%# Bind("fms_number") %>' Width="95%" Visible="False" />
                                    </td>
                                    <td class="auto-style16">
                                        <%--<asp:RequiredFieldValidator ID="rfvFmsNo" runat="server" ControlToValidate="txtFmsNo" ErrorMessage="Required" Font-Bold="true" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    </td>
                                </tr></table>
                            <asp:ObjectDataSource ID="odsrcStationList" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetStationsList" TypeName="FactSheetApp.FactSheetNewTableAdapters.StationListTableAdapter"></asp:ObjectDataSource>
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
                            <br />
                                <table width="680px"><tr><td>
                                    <asp:Label ID="lblAddProgCat" runat="server" Text="Program Category: " Font-Bold="True"></asp:Label> 
                                </td><td>
                                    <asp:DropDownList ID="ddlProgCat" runat="server" Height="21px" Width="95%" DataSourceID="odsrcProgramList" DataTextField="CategoryName" DataValueField="Category_pk" SelectedValue='<%# Bind("Category1_fk") %>' AppendDataBoundItems="True">
                                        <asp:ListItem Text="-Select from list-" Value="0"></asp:ListItem>
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
                                    <td>
                                        <asp:RequiredFieldValidator ID="rfvProgCat" runat="server" ControlToValidate="ddlProgCat" ErrorMessage="Select Category" Font-Bold="true" ForeColor="Red" InitialValue="0"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                    <asp:Label ID="lblAddProgYr" runat="server" Text="Program Year: " Font-Bold="True"></asp:Label>  
                                </td><td>
                                    <asp:TextBox ID="txtProgYr" runat="server" Text='<%# Bind("programYear") %>' Width="95px" />
                                </td>
                                    <td>
                                        <asp:CompareValidator ID="cvProgYr" runat="server" ControlToValidate="txtProgYr" ErrorMessage="Integer only" ForeColor="Red" Operator="DataTypeCheck" Type="Integer" Font-Bold="True"></asp:CompareValidator>
                                    </td>
                                    </tr><tr><td>
                                    <asp:Label ID="lblAddProgSubCat" runat="server" Text="Program Sub Category: " Font-Bold="True"></asp:Label>
                                </td><td>
                                    <asp:DropDownList ID="ddlSubCat" runat="server" Height="21px" Width="95%" DataSourceID="odsrcSubProgramList" DataTextField="SubCategoryName" DataValueField="SubCategory_pk" SelectedValue='<%# Bind("Category2_fk") %>' AppendDataBoundItems="True">
                                       <asp:ListItem Text="-Select from list-" Value="0"></asp:ListItem>
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
                                        <td>
                                            <asp:RequiredFieldValidator ID="rfvProgSubCat" runat="server" ControlToValidate="ddlSubCat" ErrorMessage="Select Sub Category" Font-Bold="true" ForeColor="Red" InitialValue="0"></asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblRegion" runat="server" Text="Region: " Font-Bold="True"></asp:Label>                           
                                </td><td>                                
                                            <asp:DropDownList ID="ddlRegion" runat="server"  DataSourceID="sdsrcRegion" DataTextField="region" DataValueField="region" SelectedValue='<%# Bind("region")%>' 
                                                AppendDataBoundItems="True" Height="16px" Width="120px" OnSelectedIndexChanged="ddlRegion_SelectedIndexChanged" AutoPostBack="True">
                                            <asp:ListItem Text="-Select from list-" Value="Null"></asp:ListItem>
                                            </asp:DropDownList>
                                    <asp:SqlDataSource ID="sdsrcRegion" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                                        SelectCommand="SELECT DISTINCT region FROM Project Where region is not null  Order By region"></asp:SqlDataSource>
                                </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="rfvRegion" runat="server" ControlToValidate="ddlRegion" Display="Dynamic" ErrorMessage="Select Region" Font-Bold="true" ForeColor="Red" InitialValue="Null"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr><tr><td>
                                     <asp:Label ID="lblAddProjTp" runat="server" Text="Project Type: " Font-Bold="True"></asp:Label>  
                                </td><td>
                                   <asp:DropDownList ID="ddlProjTp" runat="server" Height="21px" Width="95%" DataSourceID="odsrcProjTypeList" DataTextField="projectTypeName" DataValueField="projectType_pk" SelectedValue='<%# Bind("project_type_fk") %>' AppendDataBoundItems="True" AutoPostBack="True">
                                       <asp:ListItem Text="-Select from list-" Value="0"></asp:ListItem>
                                   </asp:DropDownList>
                                            <asp:ObjectDataSource ID="odsrcProjTypeList" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetProjectTypeList" TypeName="FactSheetApp.FactSheetNewTableAdapters.lkProjectTypeTableAdapter" UpdateMethod="Update">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="Original_projectType_pk" Type="Int32" />
                                                </DeleteParameters>
                                                <InsertParameters>
                                                    <asp:Parameter Name="projectTypeName" Type="String" />
                                                </InsertParameters>
                                                <UpdateParameters>
                                                    <asp:Parameter Name="projectTypeName" Type="String" />
                                                    <asp:Parameter Name="Original_projectType_pk" Type="Int32" />
                                                </UpdateParameters>
                                            </asp:ObjectDataSource>
                                </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="rfvProjType" runat="server" ControlToValidate="ddlProjTp" InitialValue="0" ErrorMessage="Select Type" Font-Bold="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblNcaDistrict" runat="server" Font-Bold="True" ></asp:Label>
                                        </td><td>
                                            
                                            <asp:DropDownList ID="ddlNcaDistrict" runat="server" DataSourceID="sdsrcNcaDistrict" DataTextField="district" 
                                                DataValueField="district_pk" Height="16px" SelectedValue='<%# Bind("ncaDistrict_fk") %>' Width="120px" AppendDataBoundItems="True" Visible="False">
                                           <asp:ListItem Text="-Select from list-" Value=""></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="sdsrcNcaDistrict" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                                                SelectCommand="SELECT * FROM [lkNCAdistrict] Order By district"></asp:SqlDataSource>
                                            
                                </td>
                                        <td>&nbsp;</td>
                                    </tr></table>
                            <br />
                             <%--<asp:TextBox ID="txtMiscCat" runat="server" Text='<%# Bind("Category3_fk") %>' Visible="False" />
                                    <asp:DropDownList ID="ddlMiscCat" runat="server" Height="21px" Width="90%"></asp:DropDownList>--%>
                            <%--<asp:TextBox ID="project_type_fkTextBox" runat="server" Text='<%# Bind("project_type_fk") %>' />--%>
                            <%--delegation_fk:
                            <asp:TextBox ID="delegation_fkTextBox" runat="server" Text='<%# Bind("delegation_fk") %>' />
                            <br />--%>
                            <%--delivery_method_fk:
                            <asp:TextBox ID="delivery_method_fkTextBox" runat="server" Text='<%# Bind("delivery_method_fk") %>' />
                            <br />--%>
                          
                            <table align="center" style="width: 411px; height: 30px"><tr><td align="center">
                                <asp:Button ID="btnAddProject" runat="server" Text="Submit" CausesValidation="true" CssClass="submitBtn" OnClick="btnAddProject_Click" />
                            </td><td align="center">
                                <asp:Button ID="btnClear" runat="server" Text="Reset" CausesValidation="False" CssClass="submitBtn" CommandName="Cancel" />
                                 </td><td align="center">
                                <asp:Button ID="btnCanclProj" runat="server" Text="Exit" CausesValidation="False" CssClass="submitBtn" OnClick="btnCanclProj_Click" />
                                            </td></tr></table>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <table><tr><td>
                                <asp:Label ID="lblProjectNo" runat="server" Text='<%# Eval("project_pk") %>' />
                                       </td><td>
                                           <asp:CheckBox ID="cbDeleted" runat="server" Checked='<%# Bind("deleted") %>' Enabled="false" />
                                            </td><td>
                                                <asp:Label ID="lblFmsNo" runat="server" Text='<%# Bind("fms_number") %>' />
                                                 </td></tr><tr><td>
                                                     <asp:Label ID="lblprojCode" runat="server" Text='<%# Bind("projectCode") %>' />
                                       </td><td>
                                           <asp:Label ID="lblProjDesc" runat="server" Text='<%# Bind("projectDesc") %>' />
                                            </td><td>
                                                <asp:Label ID="lblCancelDt" runat="server" Text='<%# Bind("cancelDate") %>' />
                                                 </td></tr><tr><td>
                                                     <asp:Label ID="lblMouDt" runat="server" Text='<%# Bind("mouDate") %>' />
                                       </td><td>
                                           <asp:Label ID="lblProgramYr" runat="server" Text='<%# Bind("programYear") %>' />
                                            </td><td>
                                                <asp:CheckBox ID="cbSubProjFlag" runat="server" Checked='<%# Bind("subProjectFlag") %>' Enabled="false" />
                                                 </td></tr><tr><td>
                                                     <asp:Label ID="lblLegacyProjCode" runat="server" Text='<%# Bind("legacyProjectCode") %>' />
                                       </td><td>
                                           <asp:Label ID="lblCreatedOn" runat="server" Text='<%# Bind("creationDate") %>' />
                                            </td><td>
                                                <asp:Label ID="lblmainProj" runat="server" Text='<%# Bind("mainProject_fk") %>' />
                                                 </td></tr><tr><td>
                                                     <asp:Label ID="lblStation" runat="server" Text='<%# Bind("station_fk") %>' />
                                       </td><td>
                                           <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("status_fk") %>' />
                                            </td><td>
                                                 <asp:Label ID="lblProjTp" runat="server" Text='<%# Bind("project_type_fk") %>' />
                                                 </td></tr><tr><td>
                                                     <asp:Label ID="lblProgCat" runat="server" Text='<%# Bind("Category1_fk") %>' />
                                       </td><td>
                                           <asp:Label ID="lblSubCat" runat="server" Text='<%# Bind("Category2_fk") %>' />
                                            </td><td>
                                                <asp:Label ID="lblMisCat" runat="server" Text='<%# Bind("Category3_fk") %>' />
                                                 </td></tr><tr><td>
                                                     <asp:Label ID="lblDelivaryMethod" runat="server" Text='<%# Bind("delivery_method_fk") %>' />
                                       </td><td>
                                            <asp:Label ID="lblCreationUser" runat="server" Text='<%# Bind("createdBy")%>' />
                                            </td><td>
                                                 <asp:Label ID="lblShowRegion" runat="server" Text='<%# Bind("region")%>'></asp:Label>
                                                 </td></tr></table>              
                        </ItemTemplate>
                    </asp:FormView>
                    <asp:ObjectDataSource ID="odsrcAddProject" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllProjectInfo" TypeName="FactSheetApp.FactSheetNewTableAdapters.ProjectTableAdapter" InsertMethod="Insert" UpdateMethod="Update">
                        <DeleteParameters>
                            <asp:Parameter Name="Original_project_pk" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="deleted" Type="Boolean" />
                            <asp:Parameter Name="fms_number" Type="String" />
                            <asp:Parameter Name="projectCode" Type="String" />
                            <asp:Parameter Name="projectDesc" Type="String" />
                            <asp:Parameter Name="cancelDate" Type="DateTime" />
                            <asp:Parameter Name="mouDate" Type="DateTime" />
                            <asp:Parameter Name="programYear" Type="Int32" />
                            <asp:Parameter Name="subProjectFlag" Type="Boolean" />
                            <asp:Parameter Name="legacyProjectCode" Type="String" />
                            <asp:Parameter Name="creationDate" Type="DateTime" />
                            <asp:Parameter Name="modificationDate" Type="DateTime" />
                            <asp:Parameter Name="mainProject_fk" Type="Int32" />
                            <asp:Parameter Name="station_fk" Type="Int32" />
                            <asp:Parameter Name="status_fk" Type="Int32" />
                            <asp:Parameter Name="projectType_fk" Type="Int32" />
                            <asp:Parameter Name="Category_fk" Type="Int32" />
                            <asp:Parameter Name="subCategory_fk" Type="Int32" />
                            <asp:Parameter Name="delegation_fk" Type="Int32" />
                            <asp:Parameter Name="delivery_method_fk" Type="Int32" />
                            <asp:Parameter Name="modifyBy" Type="String" />
                            <asp:Parameter Name="createdBy" Type="String" />
                            <asp:Parameter Name="_region" Type="String" />
                            <asp:Parameter Name="ncaDistrict_fk" Type="Int32" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="deleted" Type="Boolean" />
                            <asp:Parameter Name="fms_number" Type="String" />
                            <asp:Parameter Name="projectCode" Type="String" />
                            <asp:Parameter Name="projectDesc" Type="String" />
                            <asp:Parameter Name="cancelDate" Type="DateTime" />
                            <asp:Parameter Name="mouDate" Type="DateTime" />
                            <asp:Parameter Name="programYear" Type="Int32" />
                            <asp:Parameter Name="subProjectFlag" Type="Boolean" />
                            <asp:Parameter Name="legacyProjectCode" Type="String" />
                            <asp:Parameter Name="creationDate" Type="DateTime" />
                            <asp:Parameter Name="modificationDate" Type="DateTime" />
                            <asp:Parameter Name="mainProject_fk" Type="Int32" />
                            <asp:Parameter Name="station_fk" Type="Int32" />
                            <asp:Parameter Name="status_fk" Type="Int32" />
                            <asp:Parameter Name="projectType_fk" Type="Int32" />
                            <asp:Parameter Name="Category_fk" Type="Int32" />
                            <asp:Parameter Name="subCategory_fk" Type="Int32" />
                            <asp:Parameter Name="delegation_fk" Type="Int32" />
                            <asp:Parameter Name="delivery_method_fk" Type="Int32" />
                            <asp:Parameter Name="modifyBy" Type="String" />
                            <asp:Parameter Name="createdBy" Type="String" />
                            <asp:Parameter Name="_region" Type="String" />
                            <asp:Parameter Name="ncaDistrict_fk" Type="Int32" />
                            <asp:Parameter Name="Original_project_pk" Type="Int32" />
                        </UpdateParameters>
                    </asp:ObjectDataSource>
      </div>
    
           </td></tr></table>

</asp:Content>
