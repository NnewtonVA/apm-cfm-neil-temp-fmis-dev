<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="MyInfo.aspx.vb" Inherits="CFMISNew.MyInfo" %>
<%@ Register Src="~/UserControl/UCMenuAdmin.ascx" TagPrefix="uc1" TagName="UCMenuAdmin" %>
<%@ Register Src="~/UserControl/UCMenuGeneral.ascx" TagPrefix="uc1" TagName="UCMenuGeneral" %>
<%@ Register Src="~/UserControl/UCMenuEnvEngineer.ascx" TagPrefix="uc1" TagName="UCMenuEnvEngineer" %> 
<%@ Register Src="~/UserControl/UCMenuEnvDirector.ascx" TagPrefix="uc1" TagName="UCMenuEnvDirector" %> 


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">

        .auto-style1 {
            width: 104px;
        }
        .auto-style2 {
            width: 104px;
        }
        .auto-style3 {
            width: 104px;
            height: 23px;
        }
        .auto-style4 {
            height: 23px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <table style="width:98%;"><tr><td style="vertical-align:top; width:200px">
        <asp:Label ID="lblRole" runat="server" Visible="False"></asp:Label>
        <uc1:UCMenuAdmin runat="server" id="UCMenuAdmin" />
        <uc1:UCMenuGeneral runat="server" ID="UCMenuGeneral" />
        <uc1:UCMenuEnvEngineer runat="server" id="UCMenuEnvEngineer" />
        <uc1:UCMenuEnvDirector runat="server" id="UCMenuEnvDirector" />
           </td><td valign="top">
               <div class="wideBox" style="padding-left:15px">
        <h3>Edit Personal Information</h3>
                   <br />
                   <asp:FormView ID="fvPersonalInfo" runat="server" DataKeyNames="personnel_pk"  DefaultMode="Edit" Width="445px" DataSourceID="odsrcUpdatePersonalInfo" Height="205px" >
                       <EditItemTemplate>
                           <table style="height: 149px" width="98%"><tr><td class="auto-style2" >
                               <b>First Name:</b>
                                      </td><td>
                                          <asp:TextBox ID="txtFirstNm" runat="server" Text='<%# Bind("firstName") %>' Width="98%" />
                                      </td>
                               <td>
                                   <asp:RequiredFieldValidator ID="rfvFirstNm" runat="server" ControlToValidate="txtFirstNm" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                               </td>
                               </tr><tr><td class="auto-style1">
                                          <b>Last Name:</b>
                                      </td><td>
                                           <asp:TextBox ID="txtLastNm" runat="server" Text='<%# Bind("lastName") %>' Width="98%" />
                                      </td>
                                   <td><asp:RequiredFieldValidator ID="rfvLstNm" runat="server" ControlToValidate="txtLastNm" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator></td>
                               </tr><tr><td class="auto-style1">
                                          <b>Phone Number:</b>
                                      </td><td>
                                          <asp:TextBox ID="txtPhoneNum" runat="server" Text='<%# Bind("phoneNumber") %>' Width="98%" />
                                      <cc1:MaskedEditExtender ID="meePhone" runat="server" TargetControlID="txtPhoneNum" Mask="(999) 999-9999" InputDirection="LeftToRight" ClearMaskOnLostFocus="False"></cc1:MaskedEditExtender>
                                      </td>
                                   <td></td>
                               </tr><tr><td class="auto-style3">
                                          <b>Email:</b>
                                      </td><td class="auto-style4">
                                          <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                                      </td>
                                   <td class="auto-style4"></td>
                               </tr><tr><td class="auto-style1">
                                          <b>Access Group:</b>
                                      </td><td>
                                          <asp:Label ID="lblGroupNm" runat="server" Text='<%# Bind("groupName") %>'></asp:Label>
                                      </td>
                                   <td>&nbsp;</td>
                               </tr>
                           </table>
                           <asp:Label ID="lblPersonnelPk" runat="server" Text='<%# Eval("personnel_pk") %>' Visible="False" />
                           <br />
                           <br />
                           
                           <table align="center" style="width: 129px"><tr><td align="center"><asp:LinkButton ID="lbUpdateInfo" runat="server" CausesValidation="True" Text="Save" OnClick="lbUpdateInfo_Click" /></td>
                               <td align="center"><asp:LinkButton ID="lbCnclUpdt" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" /></td></tr></table>
                           
                           
                       </EditItemTemplate>
                       <InsertItemTemplate></InsertItemTemplate>
                       <ItemTemplate></ItemTemplate>

                   </asp:FormView>
                   <asp:ObjectDataSource ID="odsrcUpdatePersonalInfo" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetPersonalInfoForUpdate" TypeName="FactSheetApp.FactSheetNewTableAdapters.UpdatePersonalInfoTableAdapter">
                       <SelectParameters>
                           <asp:SessionParameter Name="UserNm" SessionField="UserNm" Type="String" />
                       </SelectParameters>
                   </asp:ObjectDataSource>
                   <%--<asp:SqlDataSource ID="sdsrcUpdatePersonalInfo" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                       SelectCommand="SELECT Personnel.personnel_pk, Personnel.firstName, Personnel.lastName, Personnel.phoneNumber,Personnel.user_group_fk, Personnel.email, UserGroup.groupName, Personnel.sreFlag, Personnel.projEngineerFlag, Personnel.projManagerFlag, Personnel.contractingOfficerFlag
                                      FROM  Personnel LEFT OUTER JOIN UserGroup ON Personnel.user_group_fk = UserGroup.userGroup_pk
                                      WHERE (Personnel.username = @UserNm)">
                       <SelectParameters>
                           <asp:SessionParameter Name="UserNm" SessionField="UserNm" />
                       </SelectParameters>
                   </asp:SqlDataSource>--%>
                   

                </div></td></tr>
    </table>
</asp:Content>
