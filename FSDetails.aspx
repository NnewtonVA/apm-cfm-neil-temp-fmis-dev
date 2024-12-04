<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="FSDetails.aspx.vb" Inherits="CFMISNew.FSDetails" MaintainScrollPositionOnPostback="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            width: 227px;
            height: 192px;
        }
        .auto-style3 {
            width: 392px;
            height: 192px;
        }
        .auto-style7 {
            width: 189px;
        }
        .auto-style8 {
        }
        .auto-style9 {
            width: 220px;
        }
        .auto-style14 {
            width: 180px;
        }
        .auto-style16 {
            width: 506px;
        }
        .auto-style18 {
            width: 171px;
        }
        .auto-style23 {
            width: 117px;
            height: 25px;
        }
        .auto-style27 {
            height: 25px;
            width: 166px;
        }
        .auto-style29 {
            width: 176px;
        }
        .auto-style30 {
            width: 176px;
            height: 21px;
        }
        .auto-style31 {
            height: 21px;
        }
        .auto-style37 {
            width: 92px;
            height: 25px;
        }
        .auto-style41 {
            height: 28px;
        }
        .auto-style45 {
            width: 120px;
            height: 25px;
        }
        .auto-style47 {
            width: 118px;
            height: 25px;
        }
        </style>
    <script language="javascript" type="text/javascript">
        function openNewWin(url) {
            var x = window.location(url);
            x.focus();
        }

        function SetDropDownListColor(ddl) {
           for (var i = 0; i < ddl.options.length; i++) {
              if (ddl.options[i].selected) {
               switch (i) {
                    case 0:
                        ddl.style.backgroundColor = 'Red';
                        return;

                    case 1:
                        ddl.style.backgroundColor = 'Yellow';
                        return;

                    case 2:
                        ddl.style.backgroundColor = 'Red';
                        return;

               }
                }
            }
        }

        var maxLength = 675;
        function validateLength(ta) {
            if(ta.value.length > maxLength) {
                ta.value = ta.value.substring(0, maxLength);
                alert("You have exceeded the 675 characters limit!");
            }
        }

</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <table width="99%"><tr><td>
        <asp:Label ID="lblFSDetail" runat="server" Text="Factsheet Details For Main And Related Sub Projects" Font-Bold="True" Font-Size="13pt"></asp:Label>
               </td><td align="right">
                   <div>
    <asp:HyperLink ID="hlDetailsPage" runat="server" ForeColor="#003399" Font-Size="10pt" Font-Bold="True">Go To Project Details Page</asp:HyperLink></div>
                    </td></tr></table>
    
        <div>
            <table width="90%" style="height: 19px"><tr><td>
               <%-- <h3><asp:Label ID="lblProjHdg" runat="server"></asp:Label></h3>--%>
            </td><td>
                <asp:Label ID="lblReviewStatus" runat="server" Font-Bold="True" ></asp:Label>
            </td><td>
                 <asp:Label ID="lblUserNm" runat="server" Visible="False"></asp:Label> &nbsp;<asp:Label ID="lblProjectNum" runat="server" Visible="False"></asp:Label>
            </td><td align="right">
                <asp:Label ID="lblLastReview" runat="server" ForeColor="#009933" Font-Italic="True" Font-Bold="True"></asp:Label>
                 </td></tr></table>    
        <div class="wideBox" style="padding-left:25px;">
            <table><tr><td>
                <asp:Label ID="lblProjDetail" runat="server" Text="Project Details" Font-Bold="True" Font-Size="14px"></asp:Label> 
                       </td><td>
                           <asp:Label ID="lblProjManagerMsg" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
                            </td>
                <td><asp:Label ID="lblProjPk" runat="server"></asp:Label></td>
                <td><asp:Label ID="lblLastDate" runat="server" ></asp:Label></td>
                <td><asp:HyperLink ID="hlProjLink" runat="server" Visible="False">Click here</asp:HyperLink></td>
                </tr></table>
            <table style="width: 723px; height: 150px;"><tr><td class="auto-style3">                      

        <asp:FormView ID="fvProjInfo" runat="server" DataKeyNames="project_pk" 
        DataSourceID="odsrcProjDetails" 
        Width="438px" Height="145px" >
        <EditItemTemplate>
        </EditItemTemplate>
        <InsertItemTemplate>
        </InsertItemTemplate>
        <ItemTemplate>
        <table style="height:147px"><tr><td style="background: #eee; font-weight:bold; padding-left:10px;" class="auto-style18">
          Project Name:
        </td><td style="padding-left:10px;" class="auto-style16">
            <asp:Label ID="lblProjName" runat="server" Text='<%# Eval("ProjectName") %>' ></asp:Label>
        </td></tr>
        <tr><td style="background: #eee; font-weight:bold; padding-left:10px;" class="auto-style18">
            Site Name:
        </td><td style="padding-left:10px;" class="auto-style16">
            <asp:Label ID="lblProjSite" runat="server"  Text='<%# Bind("stationName")%>' ></asp:Label>
        </td></tr>
        <tr><td style="background: #eee; font-weight:bold; padding-left:10px;" class="auto-style18">
            Project Title:
        </td><td style="padding-left:10px;" class="auto-style16">
            <asp:Label ID="lblProjTitle" runat="server" Text='<%# Eval("projectDesc")%>' ></asp:Label>
        </td></tr>
        <tr><td style="background: #eee; font-weight:bold; padding-left:10px;" class="auto-style18">
            Project #:
        </td><td style="padding-left:10px;" class="auto-style16">
            <asp:Label ID="lblProjNum" runat="server"  Text='<%# Eval("projectCode")%>' ></asp:Label>
        </td></tr>
        <tr><td style="background: #eee; font-weight:bold; padding-left:10px;" class="auto-style18">
            Region:</td><td style="padding-left:10px;" class="auto-style16">
                <asp:Label ID="lblRegion" runat="server" Text='<%# Eval("region") %>'></asp:Label>
                &nbsp;<asp:Label ID="lblNcaDistrict" runat="server" Text='<%# Eval("district")%>'></asp:Label>
        </td></tr>
            <tr>
                <td class="auto-style18" style="background: #eee; font-weight: bold; padding-left:10px;">VISN: &nbsp;</td>
                <td style="padding-left:10px;" class="auto-style16">
                    &nbsp;<asp:Label ID="lblProjVisn" runat="server" Text='<%# Eval("VISN") %>' Visible='<%# IIf(Eval("region") <> "Cemetery", "True", "False")%>'></asp:Label>
                </td>
            </tr>
        <tr><td style="background: #eee; font-weight:bold; padding-left:10px;" class="auto-style18">
            <asp:Label ID="lblProjPk" runat="server" Text='<%# Eval("project_pk") %>' 
                Visible="False" />
        </td><td class="auto-style16">
         <asp:CheckBox ID="cbSubProjFlag" runat="server" Visible="False" Checked='<%# Bind("subProjectFlag") %>'/>
        </td></tr>
        </table>
               <table><tr><td>
                <asp:Label ID="lblState" runat="server" Text='<%# Eval("State") %>' Visible="false"></asp:Label>
             </td><td><asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>' Visible="False"></asp:Label>
             </td><td><asp:Label ID="lblVisnNo" runat="server" Text='<%# Eval("VISNno")%>' Visible="False"></asp:Label></td>
                <td><asp:Label ID="lblStationFk" runat="server" Text='<%# Eval("station_fk")%>' Visible="False"></asp:Label></td>
            </tr></table>
        </ItemTemplate>
    </asp:FormView>
   
    <asp:ObjectDataSource ID="odsrcProjDetails" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetInfoByProjectId" 
        TypeName="FactSheetApp.FactSheetNewTableAdapters.ProjectDetailsTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter Name="project_pk" QueryStringField="project_pk" 
                Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
   
</td><td class="auto-style2">
    
    <asp:GridView ID="gvProjManager" runat="server" AutoGenerateColumns="False" DataKeyNames="projectPersonnel_pk" DataSourceID="sdsrcProjManager" Width="252px" EmptyDataText="No project manager has been selected" GridLines="None" Visible="false">
        <Columns>
            <asp:BoundField DataField="projectPersonnel_pk" HeaderText="projectPersonnel_pk" InsertVisible="False" ReadOnly="True" SortExpression="projectPersonnel_pk" Visible="False" />
            <asp:BoundField DataField="personnel_fk" HeaderText="personnel_fk" SortExpression="personnel_fk" Visible="False" />
            <asp:BoundField DataField="ManagerRole_fk" HeaderText="ManagerRole_fk" SortExpression="ManagerRole_fk" Visible="False" />
            <asp:BoundField DataField="FullName" HeaderText="Project Manager" ReadOnly="True" SortExpression="FullName" >
            <HeaderStyle BackColor="#E1E1E1" HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
        </Columns>
                    </asp:GridView>
    <asp:SqlDataSource ID="sdsrcProjManager" runat="server"  ConnectionString="<%$ ConnectionStrings:MainConn %>" 
        SelectCommand="SELECT ProjectPersonnel.projectPersonnel_pk, ProjectPersonnel.deleted, ProjectPersonnel.personnel_fk, ProjectPersonnel.ManagerRole_fk, Concat(Personnel.firstName, +' ' + Personnel.lastName) as FullName, lkManagerRoles.name
                       FROM ProjectPersonnel INNER JOIN Personnel ON ProjectPersonnel.personnel_fk = Personnel.personnel_pk LEFT OUTER JOIN lkManagerRoles ON ProjectPersonnel.ManagerRole_fk = lkManagerRoles.lkManagerRoles_pk
                       WHERE (ProjectPersonnel.deleted = 'False') AND (ProjectPersonnel.ManagerRole_fk = 2) AND (ProjectPersonnel.project_fk = @ProjId)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProjId" QueryStringField="project_pk" />
        </SelectParameters>
                    </asp:SqlDataSource>
   
   </td></tr></table>

    </div>

    <div class="wideBox" style="padding-left:25px;">
    <table><tr><td><h3>Scope Information</h3>
    </td><td>
        <asp:Label ID="lblUpdtScopeMsg" runat="server" Font-Bold="True" ForeColor="#33CC33"></asp:Label>
         </td></tr>
    </table>
           
        <asp:GridView ID="gvSubProjScope" runat="server" Width="95%" AutoGenerateColumns="False" DataKeyNames="project_pk" 
            DataSourceID="odsrcSubProjScope" GridLines="None" ShowHeader="False" EmptyDataText="Scope not available" OnRowDataBound="gvSubProjScope_RowDataBound">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnEditScope" runat="server" Text="Edit" CommandName="Select" onclick="btnEditScope_Click" Font-Bold="True" Height="21px" Width="53px" />
                    </ItemTemplate>
                    <ItemStyle Width="35px" VerticalAlign="Top" />
                </asp:TemplateField>
                <asp:BoundField DataField="projectDesc" SortExpression="projectDesc" HeaderText="projectDesc" >
                <ItemStyle VerticalAlign="Top" Width="175px" CssClass="gvPadding" />
                </asp:BoundField>
                <asp:BoundField DataField="comment" SortExpression="comment" HeaderText="comment">
                <ItemStyle VerticalAlign="Top" CssClass="gvPadding" />
                </asp:BoundField>
                <asp:BoundField DataField="project_pk" SortExpression="project_pk" HeaderText="project_pk" InsertVisible="False" ReadOnly="True" Visible="False">
                </asp:BoundField>
                <asp:BoundField DataField="mainProject_fk" SortExpression="mainProject_fk" HeaderText="mainProject_fk" Visible="False">
                </asp:BoundField>
                <asp:BoundField DataField="projectCode" SortExpression="projectCode" HeaderText="projectCode" Visible="False" />                          
                <asp:BoundField DataField="comment_PK" HeaderText="comment_PK" InsertVisible="False" ReadOnly="True" SortExpression="comment_PK" Visible="False" />
                <asp:TemplateField></asp:TemplateField>
            </Columns>
        </asp:GridView>

            <asp:ObjectDataSource ID="odsrcSubProjScope" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSubProjScope" TypeName="FactSheetApp.FactSheetNewTableAdapters.SubProjCommentTypesTableAdapter">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ProjectId" QueryStringField="Project_pk" Type="Int32" />
                </SelectParameters>
        </asp:ObjectDataSource>

        <asp:Panel ID="pnlEditScope" runat="server"  CssClass="modalPopup" Width="760px" BackColor="#E6EDF4" style="display:none;">
        <asp:UpdatePanel ID="mupEditScope" runat="server">
        <ContentTemplate>
            <asp:FormView ID="fvEditScope" runat="server" DataKeyNames="comment_PK" DataSourceID="sdscrEditScope" DefaultMode="Edit" Width="743px"  OnDataBound="fvEditScope_DataBound">
                <EditItemTemplate>  
                    <asp:Label ID="lblShowScopeMsg" runat="server" Text="Update Scope Information: " Font-Bold="True"></asp:Label>&nbsp;<asp:RequiredFieldValidator ID="rfvScope" runat="server" ControlToValidate="txtEditScope" ErrorMessage="Scope cannot be empty" ValidationGroup="Scope" ForeColor="Red"></asp:RequiredFieldValidator>            
                    <br />
                    <br />
                    <table><tr><td>
                         <asp:TextBox ID="txtEditScope" runat="server" Text='<%# Bind("comment") %>' Height="116px" TextMode="MultiLine" Width="652px" />
                        
                      </td></tr></table>
                    <asp:Label ID="lblCommentId" runat="server" Text='<%# Eval("comment_PK") %>' Visible="False" />
                    <asp:Label ID="lblProjetId" runat="server" Text='<%# Eval("project_FK")%>' Visible="False"></asp:Label>
                    <asp:CheckBox ID="cbSubProjFlagScope" runat="server" Checked='<%# Bind("subProjectFlag") %>' Enabled="false" Visible="False" />          
                </EditItemTemplate>
                <InsertItemTemplate>
                </InsertItemTemplate>
                <ItemTemplate>                   
                </ItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="sdscrEditScope" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" SelectCommand="SELECT comment_PK, comment, C.deleted, StageType_FK, commentType_FK, createdDate, modifyDate, project_FK, C.createdBy, C.modifyBy, P.subProjectFlag FROM Comment C INNER JOIN Project P ON C.project_FK = P.project_pk WHERE (C.commentType_FK = 2 and C.project_FK = @ProjectId)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvSubProjScope" Name="ProjectId" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Label ID="lblErrorSc" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
       <table align="center" style="width: 112px">
           <tr><td align="center">
       <asp:LinkButton ID="lbUpdtScope" runat="server"  Text="Save" CommandName="Update" Font-Bold="True" ValidationGroup="Scope"/>
         </td><td align="center">
    <asp:LinkButton ID="lbCancelEditSc" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" Font-Bold="True"/></td></tr></table> 
     </asp:Panel>
    <asp:Button id="btnEditScope" runat="server" style="display:none;"/>
    <cc1:ModalPopupExtender ID="mpeEditScope" runat="server" DropShadow ="True" X="300" Y="250"
	cancelcontrolid="lbCancelEditSc" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupEditScope"
	targetcontrolid="btnEditScope" popupcontrolid="pnlEditScope"  Enabled="True">
    </cc1:ModalPopupExtender>
   
            </div>
 
<!-- begin -->

<%--    <div class="wideBox" style="padding-left:25px;">
    <table><tr><td><h3>EXTERNAL Scope Information</h3>
    </td><td>
        <asp:Label ID="lblUpdtScopeMsgExternal" runat="server" Font-Bold="True" ForeColor="#33CC33"></asp:Label>
         </td></tr>
    </table>
           
        <asp:GridView ID="gvSubProjScopeExternal" runat="server" Width="95%" AutoGenerateColumns="False" DataKeyNames="project_pk" 
            DataSourceID="odsrcSubProjScopeExternal" GridLines="None" ShowHeader="False" EmptyDataText="Scope not available" OnRowDataBound="gvSubProjScopeExternal_RowDataBound">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnEditScopeExternal" runat="server" Text="Edit" CommandName="Select" onclick="btnEditScopeExternal_Click" Font-Bold="True" Height="21px" Width="53px" />
                    </ItemTemplate>
                    <ItemStyle Width="35px" VerticalAlign="Top" />
                </asp:TemplateField>
                <asp:BoundField DataField="projectDesc" SortExpression="projectDesc" HeaderText="projectDesc" >
                <ItemStyle VerticalAlign="Top" Width="175px" CssClass="gvPadding" />
                </asp:BoundField>
                <asp:BoundField DataField="comment" SortExpression="comment" HeaderText="comment">
                <ItemStyle VerticalAlign="Top" CssClass="gvPadding" />
                </asp:BoundField>
                <asp:BoundField DataField="project_pk" SortExpression="project_pk" HeaderText="project_pk" InsertVisible="False" ReadOnly="True" Visible="False">
                </asp:BoundField>
                <asp:BoundField DataField="mainProject_fk" SortExpression="mainProject_fk" HeaderText="mainProject_fk" Visible="False">
                </asp:BoundField>
                <asp:BoundField DataField="projectCode" SortExpression="projectCode" HeaderText="projectCode" Visible="False" />                          
                <asp:BoundField DataField="comment_PK" HeaderText="comment_PK" InsertVisible="False" ReadOnly="True" SortExpression="comment_PK" Visible="False" />
                <asp:TemplateField></asp:TemplateField>
            </Columns>
        </asp:GridView>

            <asp:ObjectDataSource ID="odsrcSubProjScopeExternal" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSubProjScope" TypeName="CFMISNew.FactSheetDataSetTableAdapters.ExternalSubProjCommentTypesTableAdapter">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ProjectId" QueryStringField="Project_pk" Type="Int32" />
                </SelectParameters>
        </asp:ObjectDataSource>

      <asp:Panel ID="pnlEditScopeExternal" runat="server"  CssClass="modalPopup" Width="760px" BackColor="#E6EDF4" style="display:none;">
        <asp:UpdatePanel ID="mupEditScopeExternal" runat="server">
        <ContentTemplate>
            <asp:FormView ID="fvEditScopeExternal" runat="server" DataKeyNames="comment_PK" DataSourceID="sdscrEditScopeExternal" DefaultMode="Edit" Width="743px"   OnDataBound="fvEditScopeExternal_DataBound">
                <EditItemTemplate>  
                    <asp:Label ID="lblShowScopeMsgExternal" runat="server" Text="Update EXTERNAL Scope Information: " Font-Bold="True"></asp:Label>&nbsp;<asp:RequiredFieldValidator ID="rfvScopeExternal" runat="server" ControlToValidate="txtEditScopeExternal" ErrorMessage="Scope cannot be empty" ValidationGroup="Scope" ForeColor="Red"></asp:RequiredFieldValidator>            
                    <br />
                    <br />
                    <table><tr><td>
                         <asp:TextBox ID="txtEditScopeExternal" runat="server" Text='<%# Bind("comment") %>' Height="116px" TextMode="MultiLine" Width="652px" />
                        
                      </td></tr></table>
                    <asp:Label ID="lblCommentId" runat="server" Text='<%# Eval("comment_PK") %>' Visible="False" />
                    <asp:Label ID="lblProjetId" runat="server" Text='<%# Eval("project_FK")%>' Visible="False"></asp:Label>
                    <asp:CheckBox ID="cbSubProjFlagScope" runat="server" Checked='<%# Bind("subProjectFlag") %>' Enabled="false" Visible="False" />          
                </EditItemTemplate>
                <InsertItemTemplate>
                </InsertItemTemplate>
                <ItemTemplate>                   
                </ItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="sdscrEditScopeExternal" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" SelectCommand="SELECT comment_PK, comment, C.deleted, StageType_FK, commentType_FK, createdDate, modifyDate, project_FK, C.createdBy, C.modifyBy, P.subProjectFlag FROM Comment C INNER JOIN Project P ON C.project_FK = P.project_pk WHERE (C.commentType_FK = 6 and C.project_FK = @ProjectId)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvSubProjScopeExternal" Name="ProjectId" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
        </asp:UpdatePanel>


    <asp:Label ID="lblErrorScExternal" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
       <table align="center" style="width: 112px">
           <tr><td align="center">
       <asp:LinkButton ID="lbUpdtScopeExternal" runat="server"  Text="Save" CommandName="Update" Font-Bold="True" ValidationGroup="Scope"/>
         </td><td align="center">
    <asp:LinkButton ID="lbCancelEditScExternal" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" Font-Bold="True"/></td></tr></table> 
     </asp:Panel>
    <asp:Button id="btnEditScopeExternal" runat="server" style="display:none;"/>
    <cc1:ModalPopupExtender ID="mpeEditScopeExternal" runat="server" DropShadow ="True" X="300" Y="250"
	cancelcontrolid="lbCancelEditScExternal" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupEditScopeExternal"
	targetcontrolid="btnEditScopeExternal" popupcontrolid="pnlEditScopeExternal"  Enabled="True">
    </cc1:ModalPopupExtender>
   
            </div>--%>

<!-- end -->


           <div class="wideBox" style="padding-left:25px;">
          <table><tr><td><h3>Current Status Information</h3>
          </td>
              <td>
                  <asp:Label ID="lblUpdtStatusMsg" runat="server" Font-Bold="True" ForeColor="#33CC33" ></asp:Label>
              </td>
                 </tr></table>   
              
               <asp:GridView ID="gvStatus" runat="server" AutoGenerateColumns="False" DataKeyNames="project_pk" DataSourceID="odsrcAllStatus" GridLines="None" ShowHeader="False" Width="95%" EmptyDataText="Status not available">
                   <Columns>
                       <asp:TemplateField>
                           <ItemTemplate> 
                               <asp:Button ID="btnEditStatus" runat="server" Text="Edit" Font-Bold="True" Height="21px" Width="53px" CommandName="Select" OnClick="btnEditStatus_Click"  />
                           </ItemTemplate>
                           <ItemStyle Width="35px" VerticalAlign="Top" />
                       </asp:TemplateField> 
                       <asp:BoundField DataField="project_pk" HeaderText="project_pk" SortExpression="project_pk" InsertVisible="False" ReadOnly="True" Visible="False">
                       </asp:BoundField>
                       <asp:BoundField DataField="mainProject_fk" HeaderText="mainProject_fk" SortExpression="mainProject_fk" Visible="False">
                       </asp:BoundField>
                       <asp:BoundField DataField="projectDesc" HeaderText="projectDesc" SortExpression="projectDesc" >
                       <ItemStyle VerticalAlign="Top" Width="175px" CssClass="gvPadding" />
                       </asp:BoundField>
                       <asp:BoundField DataField="stageCode" HeaderText="Stage" SortExpression="stageCode" >
                       <ItemStyle VerticalAlign="Top" Width="40px" CssClass="gvPadding" />
                       </asp:BoundField>
                       <asp:BoundField DataField="comment" HeaderText="Status" SortExpression="comment" >
                       <ItemStyle VerticalAlign="Top" CssClass="gvPadding" />
                       </asp:BoundField>
                       <asp:BoundField DataField="projectCode" HeaderText="projectCode" SortExpression="projectCode" Visible="False" />
                   </Columns>
               </asp:GridView>
               <asp:ObjectDataSource ID="odsrcAllStatus" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetStatusMainAndSubProj" TypeName="FactSheetApp.FactSheetNewTableAdapters.StatusMainAndSubProjTableAdapter">
                   <SelectParameters>
                       <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                   </SelectParameters>
               </asp:ObjectDataSource>

         <asp:Panel ID="pnlEditStatus" runat="server"  CssClass="modalPopup" Width="760px" BackColor="#E6EDF4" style="display:none;">
            <asp:UpdatePanel ID="mupEditStatus" runat="server">
                <ContentTemplate>

                    <asp:FormView ID="fvEditStatus" runat="server" DataKeyNames="comment_PK" DataSourceID="sdarcEditStatus" DefaultMode="Edit" Width="754px">
                        <EditItemTemplate>
                            <asp:Label ID="lblStatusMsg" runat="server" Text="Update Status Information:" Font-Bold="True"></asp:Label>&nbsp;<asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="txtEditStatus" ErrorMessage="Status cannot be empty" ValidationGroup="Status" ForeColor="Red"></asp:RequiredFieldValidator>
                            <br />
                            <br />
                            <table><tr><td>
                                <asp:DropDownList ID="ddlStatusTp" runat="server"  DataTextField="stageCode" DataValueField="stage_PK" SelectedValue='<%# Bind("StageType_FK") %>' DataSourceID="odsrcStageType" Width="86px" ></asp:DropDownList>
                                <asp:ObjectDataSource ID="odsrcStageType" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetStageTypeList" TypeName="FactSheetApp.FactSheetNewTableAdapters.lkStageTypeTableAdapter" UpdateMethod="Update">
                                    <DeleteParameters>
                                        <asp:Parameter Name="Original_stage_PK" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="stageCode" Type="String" />
                                        <asp:Parameter Name="stageDesc" Type="String" />
                                        <asp:Parameter Name="stageName" Type="String" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="stageCode" Type="String" />
                                        <asp:Parameter Name="stageDesc" Type="String" />
                                        <asp:Parameter Name="stageName" Type="String" />
                                        <asp:Parameter Name="Original_stage_PK" Type="Int32" />
                                    </UpdateParameters>
                                </asp:ObjectDataSource>
                             </td></tr><tr><td>
                                 <asp:TextBox ID="txtEditStatus" runat="server" Text='<%# Bind("comment") %>' Height="170px" TextMode="MultiLine" Width="717px" />
                                 
                             </td></table>
                            
                            <asp:Label ID="lblStageId" runat="server" Text='<%# Bind("StageType_FK") %>' Visible="False" />
                            <asp:Label ID="lblComTypeId" runat="server" Text='<%# Bind("commentType_FK") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lblStatusId" runat="server" Text='<%# Eval("comment_PK") %>' Visible="False" />
                            <asp:Label ID="lblProjId" runat="server" Text='<%# Eval("project_FK")%>' Visible="False"></asp:Label>
                        </EditItemTemplate>
                        <InsertItemTemplate> 
                        </InsertItemTemplate>
                        <ItemTemplate>
                        </ItemTemplate>
                    </asp:FormView>

                    <asp:SqlDataSource ID="sdarcEditStatus" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                        SelectCommand="SELECT Comment.comment_PK, Comment.comment, Comment.StageType_FK, Comment.commentType_FK, Comment.createdDate, Comment.modifyDate, Comment.project_FK, Comment.createdBy, Comment.modifyBy, lkStageType.stageCode
                                       FROM Comment INNER JOIN lkStageType ON Comment.StageType_FK = lkStageType.stage_PK
                                       WHERE (Comment.commentType_FK = 3) AND (Comment.project_FK = @ProjectId)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvStatus" Name="ProjectId" PropertyName="SelectedValue" />
                </SelectParameters>

                    </asp:SqlDataSource>
               </ContentTemplate>
            </asp:UpdatePanel>
        <asp:Label ID="lblErrorSt" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
       <table align="center" style="width: 112px">
           <tr><td align="center">
       <asp:LinkButton ID="lbUpdtStatus" runat="server" Text="Save" CommandName="Update" Font-Bold="True" Width="35px" ValidationGroup="Status"/>
         </td><td align="center">
    <asp:LinkButton ID="lbCancelEditSt" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" Font-Bold="True"/></td></tr></table> 
     </asp:Panel>
    <asp:Button id="btnEditStatus" runat="server" style="display:none;"/>
    <cc1:ModalPopupExtender ID="mpeEditStatus" runat="server" DropShadow ="True" X="300" Y="250"
	cancelcontrolid="lbCancelEditSt" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupEditStatus"
	targetcontrolid="btnEditStatus" popupcontrolid="pnlEditStatus"  Enabled="True">
    </cc1:ModalPopupExtender>

            </div>

            <div class="wideBox" style="padding-left:25px;">
                <table><tr><td>
                     <h3>Schedule Information</h3>
                           </td></tr></table>

                <asp:GridView ID="gvSchedule" runat="server" AutoGenerateColumns="False" DataSourceID="sdsrcSchedule"
                     Width="95%" DataKeyNames="project_pk" OnRowDataBound="gvSchedule_RowDataBound" OnSelectedIndexChanged = "OnSelectedIndexChanged" EmptyDataText="Schedule not available">
                    <Columns>
                        <%--<asp:BoundField DataField="project_pk" HeaderText="project_pk" InsertVisible="False" ReadOnly="True" SortExpression="project_pk" Visible="False" />--%>
                        <asp:TemplateField Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblProjId" runat="server" Text='<%# Eval("project_pk")%>' Visible="False"></asp:Label>                              
                                </ItemTemplate>
                                <ItemStyle Width="35px" />
                            </asp:TemplateField>
                          <asp:TemplateField Visible="False">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbSubProjFlag" runat="server" Visible="False" Checked='<%# Bind("subProjectFlag") %>' />                               
                                </ItemTemplate>
                                <ItemStyle Width="35px" />
                            </asp:TemplateField>
                        <asp:TemplateField>
                                <ItemTemplate> 
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" Font-Bold="True" Height="21px" Width="53px" CommandName="Select"  />
                                </ItemTemplate>
                                <ItemStyle Width="35px" />
                            </asp:TemplateField>                      
                        <asp:BoundField DataField="projectDesc" HeaderText="Project Title" SortExpression="projectDesc" >
                        <ItemStyle CssClass="gvPadding" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mainProject_fk" HeaderText="mainProject_fk" SortExpression="mainProject_fk" Visible="False" />
                        <asp:BoundField DataField="milestone" HeaderText="Milestone" SortExpression="milestone" >
                        <ItemStyle CssClass="gvPadding" />
                        </asp:BoundField>
                        <asp:BoundField DataField="orignal" HeaderText="Original/Projected" SortExpression="orignal" DataFormatString="{0:MM/yyyy}" >
                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="actual" HeaderText="Completion" SortExpression="actual" DataFormatString="{0:d}" >
                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="projected" HeaderText="Projected" SortExpression="projected" Visible="False" >
                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                        </asp:BoundField>
                    </Columns>
                   
                </asp:GridView>
                  <asp:SqlDataSource ID="sdsrcSchedule" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                   SelectCommand="SELECT Project.project_pk, Project.projectDesc, Project.projectCode, Project.mainProject_fk, Project.subProjectFlag, 
lkMilestone.milestone, Schedule.orignal, Schedule.actual
FROM Project INNER JOIN Schedule ON Project.project_pk = Schedule.project_FK INNER JOIN lkMilestone ON Schedule.mileStone_FK = lkMilestone.milestone_PK
WHERE (lkMilestone.showinFactsheet = 1 and (Project.mainProject_fk = @ProjectId))And((Schedule.orignal IS NOT NULL) OR (Schedule.actual IS NOT NULL))
ORDER BY Project.projectCode">
                      <SelectParameters>
                          <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" />
                      </SelectParameters>
                </asp:SqlDataSource>
   
          <asp:Panel ID="pnlEditSchedule" runat="server"  CssClass="modalPopup" style="display:none;"
        Width="900px" Height="1190px" BackColor="#E6EDF4">
        <asp:UpdatePanel ID="mupEditSchedule" runat="server">
        <ContentTemplate>
<br />
         <table style="width: 818px">
                        <tr><td class="auto-style41">
                            <h4>Schedule Information(Highlighted Schedules are for Factsheet Review)</h4></td>
                            <td>
                                <asp:Label ID="lblUpdtMsg" runat="server" ForeColor="#009900"></asp:Label>
                            </td>
                            <td>
                                <asp:Button ID="btnUpdateSchedule" runat="server" Text="Save Update" /></td>
                            <td align="center">
                                <asp:LinkButton ID="lbCancelEdit" runat="server" CausesValidation="False" CommandName="Cancel" Font-Bold="True" Font-Size="Small" Text="Close" Width="55px" />
                            </td>
                        </tr>
                       </table>
                   <cc1:ConfirmButtonExtender runat="server" ID="cbeSchedule" TargetControlID="btnUpdateSchedule" ConfirmText="Please make sure the Actual date is right. Only admin can modify it once it's entered."></cc1:ConfirmButtonExtender>
                     <table style="width: 99%">
                        <tr><th class="auto-style37" align="left">
                            Stage
                            </th>
                            <th class="auto-style27" align="left">Schedule </th>
                                    <th  align="left" class="auto-style47">Prospectus<br />(Baseline) </th>
                                    <th  align="left" class="auto-style23">Original<br />(Projected) </th>
                                    <th  align="left" class="auto-style45" valign="top">Revised </th>
                                    <th  align="left" class="auto-style47" valign="top">Completion </th>
                                    <%--<th>Projected</th>--%>
                        </tr>
                   <asp:Repeater ID="rptSchedule" runat="server" OnItemDataBound="rptSchedule_ItemDataBound">            
                    <ItemTemplate>
                        <tr onmouseover="style.backgroundColor='LightBlue'" onmouseout="style.backgroundColor=''"><td>
                            <div>
                                <asp:Label ID="lblStage" runat="server" Text='<%# Eval("milestoneStage")%>' Visible="true" Font-Bold="True"></asp:Label>
                            </td><td>
                            <div>
                                <asp:Label ID="lblSchedule" runat="server" Text='<%# Eval("Milestone")%>'></asp:Label>
                                <asp:HiddenField ID="hdnMilestoneId" runat="server" Value='<%# Eval("milestone_PK")%>' />
                                <asp:HiddenField ID="hdnenvironmentalMilestone" runat="server" Value='<%# Eval("environmentalMilestone")%>' />

                                <asp:Label ID="lblMilestoneFk" runat="server" Text='<%# Eval("milestone_PK")%>' Font-Size="Smaller" Visible="False"></asp:Label>
                                <asp:Label ID="lblProjId" runat="server" Text='<%# Eval("project_Fk")%>' Font-Size="Smaller" Visible="False"></asp:Label>
                           </div></td>
                            <td><div><asp:TextBox ID="txtProspectus" runat="server" Text='<%# Bind("prospectus", "{0:MM/dd/yyyy}")%>' Height="15px" Width="70px"></asp:TextBox>
                                <cc1:CalendarExtender ID="ceProspectus" runat="server" TargetControlID="txtProspectus"></cc1:CalendarExtender>
                                <asp:CompareValidator ID="cvProspectus" runat="server" ErrorMessage="Invalid" ControlToValidate="txtProspectus" Operator="DataTypeCheck" Type="Date" ForeColor="Red"></asp:CompareValidator>
                                </div></td>
                            <td><div><asp:TextBox ID="txtOriginal" runat="server" Text='<%# Bind("orignal", "{0:MM/dd/yyyy}")%>' Height="15px" Width="70px"></asp:TextBox>
                                <cc1:CalendarExtender ID="ceOriginal" runat="server" TargetControlID="txtOriginal"></cc1:CalendarExtender>
                                <asp:CompareValidator ID="cvOriginal" runat="server" ErrorMessage="Invalid" ControlToValidate="txtOriginal" Operator="DataTypeCheck" Type="Date" ForeColor="Red"></asp:CompareValidator>
                                </div></td>
                            <td><div><asp:TextBox ID="txtRevised" runat="server" Text='<%# Bind("revised", "{0:MM/dd/yyyy}")%>' Height="15px" Width="70px"></asp:TextBox>
                                <cc1:CalendarExtender ID="ceRevised" runat="server" TargetControlID="txtRevised"></cc1:CalendarExtender>
                                <asp:CompareValidator ID="cvRevised" runat="server" ErrorMessage="Invalid" ControlToValidate="txtRevised" Operator="DataTypeCheck" Type="Date" ForeColor="Red"></asp:CompareValidator>
                                </div></td>
                            <td><div><asp:TextBox ID="txtActual" runat="server" Text='<%# Bind("actual", "{0:MM/dd/yyyy}")%>' Height="15px" Width="70px"></asp:TextBox>
                                <cc1:CalendarExtender ID="ceActual" runat="server" TargetControlID="txtActual"></cc1:CalendarExtender>
                                 <asp:CompareValidator ID="cvActual" runat="server" ErrorMessage="Invalid" ControlToValidate="txtActual" Operator="DataTypeCheck" Type="Date" ForeColor="Red"></asp:CompareValidator>
                            </div></td>
                            <td><div>    
                                 <asp:CompareValidator ID="cvFutureActual" runat="server" ControlToValidate="txtActual" ForeColor="Red"  
                                    Operator="LessThanEqual" Type="Date" ErrorMessage="No future date" ></asp:CompareValidator>
                      </div></td>
                             <%--<td align="center"><div>
                                 <asp:CheckBox ID="cbIsActualProspectus" runat="server" Checked='<%# Bind("IsActualProspectus")%>'  />                
                                </div></td>--%>
                        </tr>
                     </ItemTemplate></asp:Repeater></table>   
        </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Label ID="lblError" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
</asp:Panel>
    <asp:Button id="btnShowEdit" runat="server" style="display:none;"/>
    <cc1:ModalPopupExtender ID="mpeEditSchedule" runat="server" DropShadow ="True" X="150" Y="150" 
	cancelcontrolid="lbCancelEdit" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupEditSchedule"
	targetcontrolid="btnShowEdit" popupcontrolid="pnlEditSchedule"  Enabled="True">
    </cc1:ModalPopupExtender>
                 
            </div>

            <div class="wideBox" style="padding-left:25px;">           
            <table><tr><td><h3>Funding for Factsheet</h3>
            </td><td>
                <asp:Label ID="lblFundingRequired" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
            </td></tr></table>
                             
                <table style="width: 352px; height: 87px"><tr><td style="background: #eee; font-weight:bold; padding-left:10px;" class="auto-style30">
                    Total Estimated Cost:
                           </td><td align="right" class="auto-style31">
                              <asp:Label ID="lblTecDisp" runat="server" ></asp:Label>
                              <asp:Label ID="lblTec" style="display: none;" runat="server" ></asp:Label>
                           </td><td align="right">
                               <asp:ImageButton ID="ibTec" runat="server" ImageUrl="~/Images/InformationIcon.png" Height="21" Width="21px" />
                           </td></tr><tr><td style="background: #eee; font-weight:bold; padding-left:10px;" class="auto-style29">
                               <asp:Label ID="lblAppropriatedTh" runat="server"></asp:Label>
                           </td><td align="right">
                               <asp:Label ID="lblAppThr" runat="server" ></asp:Label>
                           </td><td align="right">
                               <asp:ImageButton ID="ibApprThr" runat="server" ImageUrl="~/Images/InformationIcon.png" Height="21" Width="21px"/>
                                </td></tr><tr><td style="background: #eee; font-weight:bold; padding-left:10px;" class="auto-style29">
                               <asp:Label ID="lblReqstFnd" runat="server"></asp:Label>
                                         </td><td align="right">
                               <asp:Label ID="lblRequestd" runat="server" ></asp:Label>
                           </td><td align="right">
                               <asp:ImageButton ID="ibRequest" runat="server" ImageUrl="~/Images/InformationIcon.png" Height="21" Width="21px"/>   
                           </td></tr><tr><td style="background: #eee; font-weight:bold; padding-left:10px;" class="auto-style29">
                               Future Request:
                                         </td><td align="right">
                                  <asp:Label ID="lblFutureDisp" runat="server"></asp:Label>
                                  <asp:Label ID="lblFuture" style="display: none;" runat="server"></asp:Label>
                           </td><td align="right">
                               <asp:ImageButton ID="ibFuture" runat="server" ImageUrl="~/Images/InformationIcon.png" Height="21" Width="21px"/>
                           </td></tr></table>
                <asp:Panel ID="pnlTec" runat="server" CssClass="modalPopup" Width="380px" BackColor="White" style="padding-left:10px;display:none;" Height="90px">
                    <asp:UpdatePanel ID="mupTec" runat="server">
                        <ContentTemplate>
                            <div style="overflow:auto;">
                            <div style="float:right; padding-top:2px;"><asp:LinkButton ID="lbTecClose" runat="server">Close</asp:LinkButton></div>
                            <div style="float:left;">
                            <p style="padding-left:5px;padding-top:2px">Total Estimated Cost is coming from the Cost section of the main project.
                                It will show TBD if Total Estimated Cost is equal to 0.00
                             </p>
                            </div></div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>  
                <cc1:ModalPopupExtender ID="mpeTec" runat="server" CancelControlID="lbTecClose"
                    BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupTec"
	       TargetControlID="ibTec" popupcontrolid="pnlTec"  Enabled="True"></cc1:ModalPopupExtender> 
             
                <asp:Panel ID="pnlApprthr" runat="server" CssClass="modalPopup" Width="380px" BackColor="White" style="padding-left:10px;display:none;" Height="75px">
                    <asp:UpdatePanel ID="mupApprthr" runat="server">
                        <ContentTemplate>
                            <div style="overflow:auto;">
                            <div style="float:right; padding-top:2px;"><asp:LinkButton ID="lbApprthrClose" runat="server">Close</asp:LinkButton></div>
                            <div style="float:left;">
                            <p style="padding-left:5px;padding-top:2px">This is the sum of Appropriation up to the current fiscal year. 
                                This is coming from the funding section of a main project.</p>
                            </div></div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>  
                <cc1:ModalPopupExtender ID="mpeApprthr" runat="server" CancelControlID="lbApprthrClose"
                    BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupApprthr"
	       TargetControlID="ibApprThr" popupcontrolid="pnlApprthr"  Enabled="True"></cc1:ModalPopupExtender>               
   
                <asp:Panel ID="pnlRequested" runat="server" CssClass="modalPopup" Width="380px" BackColor="White" style="padding-left:10px;display:none;" Height="75px">
                    <asp:UpdatePanel ID="mupRequested" runat="server">
                        <ContentTemplate>
                            <div style="overflow:auto;">
                            <div style="float:right; padding-top:2px;"><asp:LinkButton ID="lbRequestedClose" runat="server">Close</asp:LinkButton></div>
                            <div style="float:left;">
                            <p style="padding-left:5px;padding-top:2px;">This is the sum of Requested fund(s) with Approval Type Budget Request.
                                This is coming from the funding section of a main project.                                
                            </p>
                            </div></div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>  
                <cc1:ModalPopupExtender ID="mpeRequested" runat="server" CancelControlID="lbRequestedClose"
                    BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupRequested"
	       TargetControlID="ibRequest" popupcontrolid="pnlRequested"  Enabled="True"></cc1:ModalPopupExtender>
           
<%--            <asp:Panel ID="pnlFuture" runat="server" CssClass="modalPopup" Width="380px" BackColor="White" style="padding-left:10px;display:none;" Height="100px">
                    <asp:UpdatePanel ID="mupFuture" runat="server">
                        <ContentTemplate>
                            <div style="overflow:auto;">
                            <div style="float:right; padding-top:2px;"><asp:LinkButton ID="lbFutureClose" runat="server">Close</asp:LinkButton></div>
                            <div style="float:left;">
                            <p style="padding-left:5px;padding-top:2px">This is a calculated field. The formula to calculate this field is - <br />
                               Future Request = Total Estimated Cost - (Appropriated through current year + Approved Request)
                               It will show TBD if Future Request is less than 0.00
                            </p>
                            </div></div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>  
                <cc1:ModalPopupExtender ID="mpeFuture" runat="server" CancelControlID="lbFutureClose"
                    BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupFuture"
	       TargetControlID="ibFuture" popupcontrolid="pnlFuture"  Enabled="True"></cc1:ModalPopupExtender>--%>

            <asp:Panel ID="pnlFuture" runat="server" CssClass="modalPopup" Width="380px" BackColor="White" style="padding-left:10px;display:none;" Height="80px">
                    <asp:UpdatePanel ID="mupFuture" runat="server">
                        <ContentTemplate>
                            <div style="overflow:auto;">
                            <div style="float:right; padding-top:2px;"><asp:LinkButton ID="lbFutureClose" runat="server">Close</asp:LinkButton></div>
                            <div style="float:left;">
                            <p style="padding-left:5px;padding-top:2px">This is a calculated field. The formula to calculate this field is - <br />
                               Future Request = Total Estimated Cost - (Appropriated through current year + Approved Request)
                               It will show TBD if Future Request is less than 0.00
                            </p>
                            </div></div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>  
                <cc1:ModalPopupExtender ID="mpeFuture" runat="server" CancelControlID="lbFutureClose"
                    BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupFuture"
	       TargetControlID="ibFuture" popupcontrolid="pnlFuture"  Enabled="True"></cc1:ModalPopupExtender>


            </div>

             <div class="wideBox" style="padding-left:25px;"> 
            <table><tr><td><h3>Comments</h3>
            </td><td>
                <asp:Label ID="lblUpdateCommentMsg" runat="server" Font-Bold="True" ForeColor="#33CC33"></asp:Label>
                 </td></tr></table>          
                 <asp:GridView ID="gvComments" runat="server" AutoGenerateColumns="False" DataKeyNames="project_pk" 
                     DataSourceID="odsrcGetAllComments" GridLines="None" ShowHeader="False" Width="95%" EmptyDataText="Comment not available">
                     <Columns>
                         <asp:TemplateField>
                              <ItemTemplate> 
                                    <asp:Button ID="btnEditComment" runat="server" Text="Edit" Font-Bold="True" Height="21px" Width="53px" CommandName="Select" OnClick="btnEditComment_Click"  />
                                </ItemTemplate>
                                <ItemStyle Width="35px" VerticalAlign="Top" />
                         </asp:TemplateField>
                         <asp:BoundField DataField="projectDesc" HeaderText="projectDesc" SortExpression="projectDesc">
                         <ItemStyle VerticalAlign="Top" Width="175px" CssClass="gvPadding" />
                         </asp:BoundField>
                         <asp:BoundField DataField="projectCode" HeaderText="projectCode" SortExpression="projectCode" Visible="False">
                         </asp:BoundField>
                         <asp:BoundField DataField="comment" HeaderText="comment" SortExpression="comment" >
                         <ItemStyle VerticalAlign="Top" CssClass="gvPadding" />
                         </asp:BoundField>
                         <asp:BoundField DataField="project_pk" HeaderText="project_pk" InsertVisible="False" ReadOnly="True" SortExpression="project_pk" Visible="False" />
                         <asp:BoundField DataField="mainProject_fk" HeaderText="mainProject_fk" SortExpression="mainProject_fk" Visible="False" />
                     </Columns>
                 </asp:GridView>

                 <asp:ObjectDataSource ID="odsrcGetAllComments" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCommentMainAndSubProject" TypeName="FactSheetApp.FactSheetNewTableAdapters.SubProjCommentTypesTableAdapter">
                     <SelectParameters>
                         <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                     </SelectParameters>
                 </asp:ObjectDataSource>

        <asp:Panel ID="pnlEditComment" runat="server"  CssClass="modalPopup" Width="760px" BackColor="#E6EDF4" style="display:none;">
        <asp:UpdatePanel ID="mupEditComment" runat="server">
        <ContentTemplate>
            <asp:FormView ID="fvEditComment" runat="server" DataKeyNames="comment_PK" DataSourceID="sdscrEditComment" DefaultMode="Edit" Width="743px" OnDataBound="fvEditComment_DataBound">
                <EditItemTemplate>  
                    <asp:Label ID="lblShowCommentMsg" runat="server" Text="Update Comment Information: " Font-Bold="True"></asp:Label>&nbsp;
<%--                    <asp:RequiredFieldValidator ID="rfvComment" runat="server" ControlToValidate="txtEditComment" ErrorMessage="Scope cannot be empty" ValidationGroup="Comment" ForeColor="Red"></asp:RequiredFieldValidator>  --%>          
                    <br />
                    <br />
                    <table><tr><td>
                         <asp:TextBox ID="txtEditComment" runat="server" Text='<%# Bind("comment") %>' Height="116px" TextMode="MultiLine" Width="652px" />
                        
                      </td></tr></table>
                    <asp:Label ID="lblCommentId" runat="server" Text='<%# Eval("comment_PK") %>' Visible="False" />
                    <asp:Label ID="lblProjetId" runat="server" Text='<%# Eval("project_FK")%>' Visible="False"></asp:Label>
                    <asp:CheckBox ID="cbSubProjFlagScope" runat="server" Checked='<%# Bind("subProjectFlag") %>' Enabled="false" Visible="False" />          
                </EditItemTemplate>
                <InsertItemTemplate>
                </InsertItemTemplate>
                <ItemTemplate>                   
                </ItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="sdscrEditComment" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                SelectCommand="SELECT comment_PK, comment, C.deleted, StageType_FK, commentType_FK, createdDate, modifyDate, project_FK, C.createdBy, C.modifyBy, P.subProjectFlag FROM Comment C INNER JOIN Project P ON C.project_FK = P.project_pk WHERE (C.commentType_FK = 1 and C.project_FK = @ProjectId)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvComments" Name="ProjectId" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Label ID="lblErrorCom" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
       <table align="center" style="width: 112px">
           <tr><td align="center">
       <asp:LinkButton ID="lbUpdtComment" runat="server"  Text="Save" CommandName="Update" Font-Bold="True" ValidationGroup="Comment"/>
         </td><td align="center">
    <asp:LinkButton ID="lbCancelEditCom" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" Font-Bold="True"/></td></tr></table> 
     </asp:Panel>
    <asp:Button id="btnEditComment" runat="server" style="display:none;"/>
    <cc1:ModalPopupExtender ID="mpeEditComment" runat="server" DropShadow ="True" X="300" Y="250"
	cancelcontrolid="lbCancelEditCom" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupEditComment"
	targetcontrolid="btnEditComment" popupcontrolid="pnlEditComment"  Enabled="True">
    </cc1:ModalPopupExtender>

             </div>

<!-- RVB Begin -->

            <div class="wideBox" style="padding-left:25px;" id="divProjectHealthandLeadershipHightlights" runat="server"> 
            <table><tr><td><h3>Project Health and Leadership Highlights</h3>
            </td><td>
                <asp:Label ID="lblUpdateCommentMsgExternal" runat="server" Font-Bold="True" ForeColor="#33CC33"></asp:Label>
                 </td></tr></table>          
                 <asp:GridView ID="gvCommentsExternal" runat="server" AutoGenerateColumns="False" DataKeyNames="project_pk" 
                     DataSourceID="odsrcGetAllCommentsExternal" GridLines="None" ShowHeader="False" Width="95%" EmptyDataText="Leadership Highlights not available" OnRowDataBound="gvCommentsExternal_RowDataBound">
                     <Columns>
                         <asp:TemplateField>
                              <ItemTemplate> 
                                  <asp:Button ID="btnEditCommentExternal" runat="server" Text="Edit" Font-Bold="True" Height="21px" Width="53px" CommandName="Select" OnClick="btnEditCommentExternal_Click"  />
                              </ItemTemplate>
                              <ItemStyle Width="35px" VerticalAlign="Top" />
                         </asp:TemplateField>
                         <asp:BoundField DataField="projectDesc" HeaderText="projectDesc" SortExpression="projectDesc">
                         <ItemStyle VerticalAlign="Top" Width="175px" CssClass="gvPadding" />
                         </asp:BoundField>
                         <asp:BoundField DataField="projectCode" HeaderText="projectCode" SortExpression="projectCode" Visible="False">
                         </asp:BoundField>
                         <asp:BoundField DataField="riskType" HeaderText="riskType" SortExpression="riskType" Visible="False">
                         </asp:BoundField>
                         <asp:BoundField DataField="riskTypeColor" HeaderText="riskTypeColor" SortExpression="riskTypeColor" Visible="True">
                             <ItemStyle VerticalAlign="Top" Width="100px" CssClass="gvPadding" />
                         </asp:BoundField>
                         <asp:BoundField DataField="comment" HeaderText="comment" SortExpression="comment" >
                         <ItemStyle VerticalAlign="Top" CssClass="gvPadding" />
                         </asp:BoundField>
                         <asp:BoundField DataField="project_pk" HeaderText="project_pk" InsertVisible="False" ReadOnly="True" SortExpression="project_pk" Visible="False" />
                         <asp:BoundField DataField="mainProject_fk" HeaderText="mainProject_fk" SortExpression="mainProject_fk" Visible="False" />
                     </Columns>
                 </asp:GridView>

                 <asp:ObjectDataSource ID="odsrcGetAllCommentsExternal" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCommentMainAndSubProject" TypeName="CFMISNew.FactSheetDataSetTableAdapters.ExternalSubProjCommentTypesTableAdapter">
                     <SelectParameters>
                         <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                     </SelectParameters>
                 </asp:ObjectDataSource>

        <asp:Panel ID="pnlEditCommentExternal" runat="server"  CssClass="modalPopup" Width="760px" BackColor="#E6EDF4" style="display:none;">
        <asp:UpdatePanel ID="mupEditCommentExternal" runat="server">
        <ContentTemplate>
            <asp:FormView ID="fvEditCommentExternal" runat="server" DataKeyNames="comment_PK" DataSourceID="sdscrEditCommentExternal" DefaultMode="Edit" Width="743px" OnDataBound="fvEditCommentExternal_DataBound">
                <EditItemTemplate>  
                    <asp:Label ID="lblShowScopeMsgExternal" runat="server" Text="Update Project Health and Leadership Highlights Information: " Font-Bold="True"></asp:Label>&nbsp;            
                    <br />
                    <br />
                    <table>
                        <tr><td>
                            <asp:Label ID="lblEditProjectHealth" runat="server" Text="Edit Project Health: " Font-Bold="True"></asp:Label>
                            <asp:Image ID="iInformationEditProjectHealth" runat="server" ImageUrl="~/Images/InformationIcon.png" onmouseover="$find('behaviorIDofPopopEditProjectHealth').showPopup()" 
                                onmouseout="$find('behaviorIDofPopopEditProjectHealth').hidePopup();" Height="21px" Width="21px" />       

                            <cc1:popupcontrolextender runat="server" ID="pceProjectHealth" 
                                BehaviorID="behaviorIDofPopopEditProjectHealth" TargetControlID="iInformationEditProjectHealth" 
                                PopupControlID="pnlPopUpEditProjectHealth" Position="Right"></cc1:popupcontrolextender>
                            <asp:Panel ID="pnlPopUpEditProjectHealth" runat="server" BorderStyle="Solid" BorderWidth="1px" 
                                HorizontalAlign="Left" Direction="NotSet"  style="display:none;" CssClass="HowTo" Width="400px">
                                    -	Red: Project (Scope/Schedule/Budget) at High Risk <br />
                                    -	Yellow: Project (Scope/Schedule/Budget) at Moderate Risk <br />
                                    -	Green: Project (Scope/Schedule/Budget) at Low Risk <br />
                            </asp:Panel>
                            <br />

                            <asp:DropDownList ID="ddlRiskType" SelectedValue='<%# Bind("RiskType") %>' runat="server" onchange="SetDropDownListColor(this);" style="width:140px;">
                                <asp:ListItem style="background-color: Green !important;" Value="3">Green</asp:ListItem>
                                <asp:ListItem style="background-color: Yellow !important;" Value="2">Yellow</asp:ListItem>
                                <asp:ListItem style="background-color: Red !important;" Value="1">Red</asp:ListItem>
                            </asp:DropDownList>

                        </td></tr>
                        <tr><td>
                            <asp:Label ID="lblEditExternalComntHdg" runat="server" Text="Edit Leadership Highlights: (limit up to 675 chars) " Font-Bold="True"></asp:Label>
                            <asp:Image ID="iInformationExternalCommentEdt" runat="server" ImageUrl="~/Images/InformationIcon.png" onmouseover="$find('behaviorIDofPopopExternalComment').showPopup()" 
                                onmouseout="$find('behaviorIDofPopopExternalComment').hidePopup();" Height="21px" Width="21px" />       
                            <cc1:popupcontrolextender runat="server" ID="pceGrop" 
                                BehaviorID="behaviorIDofPopopExternalComment" TargetControlID="iInformationExternalCommentEdt" 
                                PopupControlID="pnlPopUpExternalCommentEdt" Position="Right"></cc1:popupcontrolextender>
                            <asp:Panel ID="pnlPopUpExternalCommentEdt" runat="server" BorderStyle="Solid" BorderWidth="1px" 
                                HorizontalAlign="Left" Direction="NotSet"  style="display:none;" CssClass="HowTo" Width="400px">
                                Concisely explain the Risk assessment that correlates with the color selected, the impacts or potential impacts and way  forward (who’s accountable and timeline).   For “Green Projects” tell the good news story (Cost, Schedule, Quality, what do we want leadership to know.  Provide Risk Assessment in the following format:<br /><br />
                                -	Bottom Line Up Front (BLUF): What is the issue (Scope/Schedule/Budget/Political implication, etc.)<br />
                                -	DISCUSSION: Provide any background or suggest a brief to cover material in depth and or any actions taken or planned to address/mitigate identified risk <br />
                                -	RECOMMENDATION: What you want leadership to do (For Information Only; receive a briefing; make a decision etc.) <br />
                            </asp:Panel>
                            <br />
                          <asp:TextBox ID="txtEditCommentExternal" runat="server" Text='<%# Bind("comment") %>' Height="116px" TextMode="MultiLine" Width="652px" />                        
                      </td></tr>
                    </table>
                    <asp:Label ID="lblCommentId" runat="server" Text='<%# Eval("comment_PK") %>' Visible="False" />
                    <asp:Label ID="lblProjetId" runat="server" Text='<%# Eval("project_PK")%>' Visible="False"/>
                    <asp:Label ID="lblCreatedDate" runat="server" Text='<%# Eval("createdDate") %>' Visible="False" />
                </EditItemTemplate>
                <InsertItemTemplate>
                </InsertItemTemplate>
                <ItemTemplate>                   
                </ItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="sdscrEditCommentExternal" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                SelectCommand="SELECT comment_PK, comment, C.deleted, C.StageType_FK, C.commentType_FK, C.createdDate, C.modifyDate, P.project_PK, C.createdBy, 
    C.modifyBy, P.subProjectFlag,
	CASE WHEN C.riskType_FK IS NULL THEN P.riskType_FK 
ELSE C.riskType_FK 
END as RiskType,
CASE WHEN C.riskType_FK IS NULL THEN 
  CASE
     WHEN P.riskType_FK = 1 THEN 'Red'
     WHEN P.riskType_FK = 2 THEN 'Yellow'
	 ELSE 'Green'
  END
ELSE
  CASE
    WHEN C.riskType_FK = 1 THEN 'Red'
    WHEN C.riskType_FK = 2 THEN 'Yellow'
    ELSE 'Green'
  END   
END as RiskTypeColor	
	FROM (select * from Comment WHERE commentType_FK = 5) C RIGHT OUTER JOIN Project P ON C.project_FK = P.project_pk 
	WHERE P.project_PK = @ProjectId">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvCommentsExternal" Name="ProjectId" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Label ID="lblErrorComExternal" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
       <table align="center" style="width: 112px">
           <tr><td align="center">
       <asp:LinkButton ID="lbUpdtCommentExternal" runat="server"  Text="Save" CommandName="Update" Font-Bold="True"/>
         </td><td align="center">
    <asp:LinkButton ID="lbCancelEditComExternal" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" Font-Bold="True"/></td></tr></table> 
     </asp:Panel>
    <asp:Button id="btnEditCommentExternal" runat="server" style="display:none;"/>
    <cc1:ModalPopupExtender ID="mpeEditCommentExternal" runat="server" DropShadow ="True" X="300" Y="250"
	cancelcontrolid="lbCancelEditComExternal" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupEditCommentExternal"
	targetcontrolid="btnEditCommentExternal" popupcontrolid="pnlEditCommentExternal"  Enabled="True">
    </cc1:ModalPopupExtender>
    </div>

<!-- End -->


            <div class="wideBox" align="center">
                <table style="width: 785px"><tr><td class="auto-style9">
                    <asp:CheckBox ID="cbDue" runat="server" Text="Submit review for current month?" TextAlign="Left" AutoPostBack="True" Font-Bold="True" Visible="False" />
                           </td><td align="right">
                               <asp:Label ID="lblDue" runat="server" Text="Enter the due period:" Visible="False" Font-Bold="True"></asp:Label>
                                </td><td align="left">
                                    <asp:TextBox ID="txtDue" runat="server" Visible="False" Height="19px" Width="102px"></asp:TextBox>
                                   <cc1:TextBoxWatermarkExtender ID="tweDue" runat="server" WatermarkCssClass="Watermark" 
                                       TargetControlID="txtDue" WatermarkText="eg.:MM-YYYY"></cc1:TextBoxWatermarkExtender>  
                                </td>
                    <td class="auto-style7">
                        <asp:FormView ID="fvReviewDue" runat="server" DataSourceID="sdsrcReviewDue" Visible="True">
                            <InsertItemTemplate> 
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblRvwMsg" runat="server" Text="Last Review (mm/yyyy):" Font-Bold="True"></asp:Label>
                                <asp:Label ID="lblShowReportDue" runat="server" Text='<%# Bind("reportdue") %>' Font-Bold="True" />
                                <asp:Label ID="lblLastActivity" runat="server" Text='<%# Bind("fsActivity_fk")%>' Visible="False"></asp:Label>
                            </ItemTemplate>
                        </asp:FormView>
                    </td>
                       </tr><tr><td valign="top" class="auto-style9">
                        <asp:Label ID="lblDuePeriod" runat="server" Font-Bold="True" ForeColor="#FF3300"></asp:Label>
                           </td><td valign="top">
                                    <asp:RegularExpressionValidator ID="revDue" runat="server" ControlToValidate="txtDue" ValidationGroup="ReviewDue" 
                                        ErrorMessage="Please enter in correct format" ValidationExpression="^\d{2}-\d{4}$" Font-Bold="True" ForeColor="Red"></asp:RegularExpressionValidator>
                           </td><td align="left" class="auto-style10">
                                    &nbsp;</td>
                        <td class="auto-style8">
                        <asp:SqlDataSource ID="sdsrcReviewDue" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                            SelectCommand="Select top (1)reportdue, fsActivity_fk from FsApprovalHistory where project_pk = @ProjectId order by fsAH_pk Desc">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                                </td>
                       </tr></table>
                           
                <table style="width: 638px"><tr><td>
                       &nbsp;</td><td colspan="2">
                       <asp:Button ID="btnSubmit" runat="server" Text="Submit For Review" CssClass="submitBtn" ValidationGroup="ReviewDue" 
           onclick="btnSubmit_Click" Font-Bold="True" Width="181px" />
                        <%--<asp:Button ID="btnPublish" runat="server" Text="Publish" CssClass="submitBtn" Visible="False" />--%>
                </td><td>
                        <%--<asp:Button ID="btnPublish" runat="server" Text="Publish" CssClass="submitBtn" Visible="False" />--%>
                       </td></tr><tr><td>
                    <asp:Button ID="btnDeny" runat="server" Text="Return" CssClass="submitBtn" onclick="btnDeny_Click" Visible="False" BackColor="#FD887B" Width="100px" />
                </td><td>
                            <asp:Button ID="btnReturnByDirector" runat="server" Text="Return" CssClass="submitBtn" BackColor="#FFFFCC" Width="100px" />
                </td><td class="auto-style14">
                            <asp:Button ID="btnApproveByDirector" runat="server" Text="Approve" CssClass="submitBtn" BackColor="#C4FFC4" Width="100px" />
                </td><td>
                    <asp:Button ID="btnApprove" runat="server" Text="Approve to Publish" Visible="False" BackColor="#AAFFAA" Width="138px" Font-Bold="True" />
                </td>
<%--                <td>
                    <asp:LinkButton runat="server" ID="btnEmail" Text="Send Email LB" />
                    <asp:Hyperlink ID="HypelinkMailTo" runat="server" Text="Send Email" Visible="False"/>
                    <asp:Hyperlink ID="Hyperlink1" runat="server" Text="Send Email" Visible="False"/>
                    <asp:LinkButton ID="linkButtonMailTo" runat="server" Text="Send Email" Visible="false" />
                </td>
                             --%>    </tr></table>
   
  </div>

 </div>


</asp:Content>

