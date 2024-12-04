<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="UserInfo.aspx.vb" Inherits="CFMISNew.UserInfo" %>

<%@ Register Src="~/UserControl/UCMenuAdmin.ascx" TagPrefix="uc1" TagName="UCMenuAdmin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            width: 84px;
        }
        .auto-style3 {
            width: 273px;
        }
        .auto-style5 {
            width: 92px;
        }
        .auto-style6 {
            width: 40px;
        }
        .data {
            width: 116px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <table style="width:98%;">        
        <tr>
<%--            <td valign="top" width="15%">
            <uc1:UCMenuAdmin runat="server" ID="UCMenuAdmin" />
            </td>--%>
            
            <td valign="top" width="20%"> 
               <div style="padding-left:25px;  height:475px; background-color:#b3ccff;">
                 <table>
                    <tr>
                        <td>
                            <uc1:UCMenuAdmin runat="server" id="UCMenuAdmin1" />
                        </td>
                    </tr>
                 </table>
               </div>
            </td>

            <td valign="top">
            <div style="padding-left:10px">
        <br />
        <asp:Label ID="lblUserPg" runat="server" 
        Text="This page is to Add or Update user information: " Font-Bold="True" ></asp:Label>
    <asp:Label ID="lblUserRoleId" runat="server" Visible="False" ></asp:Label>
<br />
<table width="99%"><tr><td align="left" class="auto-style2">
        <asp:Label ID="lblAddmsg" runat="server" Text="To Add User: " Font-Bold="True"></asp:Label>
    </td><td align="left" class="auto-style3">
        <asp:Button ID="btnAddUser" runat="server" Text="Add User" Font-Bold="True" Height="26px" Width="100px" />
    </td><td class="auto-style5">
        <asp:Label ID="lblInfo" runat="server" Text="User group info"></asp:Label>
         </td><td align="left" class="auto-style6">
        <asp:Image ID="iInformation" runat="server" ImageUrl="~/Images/InformationIcon.png" onmouseover="$find('behaviorIDofPopop').showPopup()" 
                                onmouseout="$find('behaviorIDofPopop').hidePopup();" Height="21px" Width="21px" />
    </td><td>
         <cc1:popupcontrolextender runat="server" ID="pceGrop" 
                                BehaviorID="behaviorIDofPopop" TargetControlID="iInformation" 
                                PopupControlID="pnlPopUp" Position="Right"></cc1:popupcontrolextender>
                            <asp:Panel ID="pnlPopUp" runat="server" BorderStyle="Solid" BorderWidth="1px" 
                                HorizontalAlign="Left" Direction="NotSet"  style="display:none;" CssClass="HowTo" Width="400px">
                                <asp:GridView ID="gvGroupInfo" runat="server" DataSourceID="sdsrcGroupInfo" AutoGenerateColumns="False" Width="99%">
                                    <Columns>
                                        <asp:BoundField DataField="groupName" HeaderText="Group" SortExpression="groupName">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="groupDesc" HeaderText="Description" SortExpression="groupDesc" />
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsrcGroupInfo" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                                    SelectCommand="SELECT [groupName], [groupDesc] FROM [UserGroup] Where userGroup <> 600"></asp:SqlDataSource>                         
                            </asp:Panel>
         </td></tr></table>
    &nbsp;<asp:Label ID="lblResult" runat="server" Font-Bold="True" ForeColor="#FF3300"></asp:Label>
<br />

        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
            <table><tr><td>
                  <asp:Label ID="lblUser" runat="server" Text="Search by User Name:  " Font-Bold="True"></asp:Label>
            </td><td>
                  <asp:TextBox ID="txtUser" runat="server" Height="22px" Width="132px"></asp:TextBox>   
            </td><td align="right">
                  <asp:Button ID="btnSearch" runat="server" Text="Search" Font-Bold="True" Height="26px" Width="90px" />
            </td><td align="right">
                  <asp:Button ID="btnVwAll" runat="server" Text="View All" Font-Bold="True" Height="26px" Width="90px" />
            </td></tr></table>
        </asp:Panel>

        <asp:Panel ID="pnlUserList" runat="server">
            <asp:Label ID="lblMsg" runat="server" Text="Click on Edit to update information:" 
            Font-Bold="True"></asp:Label>
                <br />
                <br />
            <table width="98%"><tr><td align="left">
            Showing records <%=gvUser.PageIndex * gvUser.PageSize + 1%> -
                    <%=(gvUser.PageIndex * gvUser.PageSize + gvUser.Rows.Count)%> 
        <asp:Label ID="lblTotalRec" runat="server"></asp:Label>            
        </td><td align="right">
            <asp:Label ID="lblPageSize" runat="server" Text="Show records per page: "></asp:Label>
        </td><td align="left">
                        <asp:DropDownList ID="ddlPageSize" runat="server" AppendDataBoundItems="True" 
                        AutoPostBack="True" Height="21px" 
                        onselectedindexchanged="ddlPageSize_SelectedIndexChanged" Width="48px">
                        <asp:ListItem>10</asp:ListItem>
                        <asp:ListItem>25</asp:ListItem>
                        <asp:ListItem>50</asp:ListItem>
                        <asp:ListItem>100</asp:ListItem>
                    </asp:DropDownList>
        </td>
        </tr>                           
        </table>
            <asp:GridView ID="gvUser" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
                DataKeyNames="personnel_pk" DataSourceID="odsrcUserInfoDS" ForeColor="#333333" Width="98%" OnDataBound="gvUser_DataBound">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:TemplateField HeaderText="First Name" SortExpression="firstName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFirstNm" runat="server" Text='<%# Bind("firstName") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblFirstNm" runat="server" Text='<%# Bind("firstName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle CssClass="gvPadding" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last Name" SortExpression="lastName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtLastNm" runat="server" Text='<%# Bind("lastName") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblLastNm" runat="server" Text='<%# Bind("lastName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle CssClass="gvPadding" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Title" SortExpression="title" Visible="False">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtTitle" runat="server" Text='<%# Bind("title") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblTitle" runat="server" Text='<%# Bind("title") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Phone" SortExpression="phoneNumber">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPhone" runat="server" Text='<%# Bind("phoneNumber") %>' Width="40px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPhone" runat="server" Text='<%# Bind("phoneNumber") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle CssClass="gvPadding" Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email" SortExpression="email">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("email") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle CssClass="gvPadding" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ID" SortExpression="username">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtId" runat="server" Text='<%# Bind("username") %>' Width="40px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblId" runat="server" Text='<%# Bind("username") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle CssClass="gvPadding" />
                    </asp:TemplateField>
                    <asp:CheckBoxField DataField="sreFlag" HeaderText="SRE1" SortExpression="sreFlag" Visible="false">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
                    <asp:CheckBoxField DataField="degreeFlag" HeaderText="degree" SortExpression="degreeFlag" Visible="False" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
                    <asp:CheckBoxField DataField="projEngineerFlag" HeaderText="Proj Engineer1" SortExpression="projEngineerFlag" Visible="false">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
                    <asp:CheckBoxField DataField="projManagerFlag" HeaderText="Proj Manager1" SortExpression="projManagerFlag" Visible="false">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
                    <asp:CheckBoxField DataField="contractingOfficerFlag" HeaderText="Cont. Officer1" SortExpression="contractingOfficerFlag" Visible="false">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
                    <asp:CheckBoxField DataField="projectPersonnel" HeaderText="Project Personnel" SortExpression="projectPersonnel" Visible="true">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>

                    <asp:TemplateField HeaderText="Group" SortExpression="groupName">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlGroup" runat="server" DataSourceID="sdsrcUserGroup" DataTextField="groupName" DataValueField="userGroup" Width="40px"></asp:DropDownList>
                            <asp:SqlDataSource ID="sdsrcUserGroup" runat="server"  ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                                SelectCommand="GetUserGroupBasedOnAdminType" SelectCommandType="StoredProcedure">
                                <SelectParameters><asp:ControlParameter Name="UserGroup" ControlID="lblUserRoleId" PropertyName="Text" /></SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblGroup" runat="server" Text='<%# Bind("groupName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle CssClass="gvPadding" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="userGroup" HeaderText="userGroup" SortExpression="userGroup" Visible="False" >
                    <ItemStyle CssClass="gvPadding" />
                    </asp:BoundField>
                    <asp:CheckBoxField DataField="deleted" HeaderText="Inactive" SortExpression="deleted" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
                    <asp:BoundField DataField="personnel_pk" HeaderText="personnel_pk" InsertVisible="False" ReadOnly="True" SortExpression="personnel_pk" Visible="False" />
                    <asp:BoundField DataField="user_group_fk" HeaderText="user_group_fk" SortExpression="user_group_fk" Visible="False" />
                     <%--<asp:CommandField ShowEditButton="True" />--%>
                    <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                <asp:LinkButton ID="lbEditUser" runat="server" CausesValidation="False"
                 CommandName="Select"  Text="Edit" OnClick="lbEditUser_Click"></asp:LinkButton>
                </ItemTemplate>
                        <ItemStyle CssClass="gvPadding" />
           </asp:TemplateField>
                </Columns>
                 <PagerTemplate>
                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled= '<%#IIf((gvUser.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="White">&lt;&lt; First</asp:LinkButton>
                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled= '<%#IIf((gvUser.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="White">&lt; Prev</asp:LinkButton> 
                    [Total Pg No: <%=gvUser.PageCount%>][Current pg: <%=gvUser.PageIndex + 1%>]
                    <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled= '<%#IIf((gvUser.PageCount)=(gvUser.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="White">Next &gt;</asp:LinkButton>
                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled= '<%#IIf((gvUser.PageCount)=(gvUser.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="White">Last &gt;&gt;</asp:LinkButton><br />
                         <asp:Label ID="lblGoTo" runat="server" Text="Go to Pg:"></asp:Label>    
                    <asp:DropDownList ID="ddlPaging" runat="server" AutoPostBack="True" 
                        Height="21px" OnSelectedIndexChanged="ddlPaging_SelectedIndexChanged" 
                        Width="55px">
                    </asp:DropDownList>
                    <asp:Label ID="lblCurrentPg" runat="server"></asp:Label>    
                </PagerTemplate>
                        <PagerStyle HorizontalAlign="Center" />
            <EditRowStyle BackColor="#FFFFCC" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
<%--            <asp:ObjectDataSource ID="odsrcUserInfo" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetUserListByLogedUser" TypeName="FactSheetApp.FactSheetNewTableAdapters.PersonnelTableAdapter">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lblUserRoleId" Name="UserGroup" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>--%>

            <asp:ObjectDataSource ID="odsrcUserInfoDS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetUserListByLogedUser" TypeName="CFMISNew.FactSheetDataSetTableAdapters.PersonnelTableAdapter">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lblUserRoleId" Name="UserGroup" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>

        </asp:Panel>
      </div>
  </td></tr>
</table>
    <asp:Panel ID="pnlAddUser" runat="server"  CssClass="modalPopup" style="display:none;"
        DefaultButton="lbAddUser" Width="487px" Height="250px" BackColor="#E6EDF4">
        <asp:UpdatePanel ID="mupAddUser" runat="server">
        <ContentTemplate>
<br /><table style="height: 160px" class="Modaltable"><tr><td class="style6">
</td><td>
                    <asp:FormView ID="fvAddUser" runat="server"  DataSourceID="odsrcUserInfoDS" 
                DefaultMode="Insert" Width="459px" Height="129px">
            <EditItemTemplate></EditItemTemplate>
            <InsertItemTemplate>
            <table style="width: 428px; height: 111px" bgcolor="#FFFFCC"><tr><td class="style5" colspan="2">
                <asp:Label ID="lblHeadingMsg" runat="server" Font-Bold="True" Font-Size="Small" 
                    Text="Enter user Information:"></asp:Label>
            </td></tr><tr style="display:none;">
            <td>
                <asp:Label ID="lblAddFrstNm" runat="server" Text="First Name: " 
                    Font-Bold="True"></asp:Label>
            </td><td>
                <asp:TextBox ID="txtAddFrstNm" runat="server" Height="19px" Width="210px"></asp:TextBox>
            </td></tr>
            <tr style="display:none;"><td>
                <asp:Label ID="lblAddLstNm" runat="server" Text="Last Name: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:TextBox ID="txtAddLstNm" runat="server" Height="19px" Width="210px"></asp:TextBox>
            </td></tr>
            <tr><td>
                <asp:Label ID="lblAddUserNm" runat="server" Text="Log On Id: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:TextBox ID="txtAddUserNm" runat="server" Height="19px" Width="210px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAddUserNm" runat="server" ControlToValidate="txtAddUserNm" 
                    ErrorMessage="User ID is required." ForeColor ="Red" ValidationGroup="AddUser"></asp:RequiredFieldValidator>
            </td></tr>
            <tr><td>
                <asp:Label ID="lblAddPhone" runat="server" Text="Phone: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:TextBox ID="txtAddPhone" runat="server" Height="19px" Width="210px"></asp:TextBox>
                <cc1:MaskedEditExtender ID="meePhone" runat="server" TargetControlID="txtAddPhone" Mask="(999) 999-9999" InputDirection="LeftToRight" ClearMaskOnLostFocus="False"></cc1:MaskedEditExtender>
            </td></tr>
            <tr style="display:none;"><td>
                <asp:Label ID="lblAddEmail" runat="server" Text="Email: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:TextBox ID="txtAddEmail" runat="server" Height="19px" Width="210px"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="rfvAddEmail" ControlToValidate="txtAddEmail" runat="server" 
                    ErrorMessage="Email is required" ForeColor="Red" ValidationGroup ="AddUser"></asp:RequiredFieldValidator>--%>
            </td></tr>
            <tr><td>
                <asp:Label ID="lblAddGroup" runat="server" Text="Group: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:DropDownList ID="ddlGroup" runat="server" 
                            DataTextField="groupName" DataValueField="userGroup" Height="21px" 
                            Width="142px" AppendDataBoundItems="True" DataSourceID="sdsrcUserGroup">
                            <asp:ListItem Value="0">-Select-</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvGroup" runat="server" ControlToValidate="ddlGroup" ErrorMessage="Select group" Font-Bold="true" 
                    ForeColor="Red" InitialValue="0" ValidationGroup="AddUser"></asp:RequiredFieldValidator>       
                 <asp:SqlDataSource ID="sdsrcUserGroup" runat="server"  ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                                SelectCommand="GetUserGroupBasedOnAdminType" SelectCommandType="StoredProcedure">
                                <SelectParameters><asp:ControlParameter Name="UserGroup" ControlID="lblUserRoleId" PropertyName="Text" /></SelectParameters>
                            </asp:SqlDataSource>   
            </td>
            </tr>
            <tr style="display:none"><td>
                <asp:Label ID="lblAddSre" runat="server" Text="SRE: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:CheckBox ID="cbAddSre" runat="server" />
            </td></tr>
            <tr style="display:none"><td>
                <asp:Label ID="lblAddProjEng" runat="server" Text="Proj. Engineer: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:CheckBox ID="cbAddProjEng" runat="server" />
            </td></tr>
            <tr style="display:none"><td>
                <asp:Label ID="lblAddProjMangr" runat="server" Text="Proj. Manager: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:CheckBox ID="cbProjMangr" runat="server" />
            </td></tr>
            <tr style="display:none"><td>
                <asp:Label ID="lblContOfficer" runat="server" Text="Contract Officer: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:CheckBox ID="cbContOfficer" runat="server" />
            </td></tr>
            <tr><td>
                <asp:Label ID="lblAddprojectPersonnel" runat="server" Text="Project Personnel: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:CheckBox ID="cbAddprojectPersonnel" runat="server" />
            </td></tr>

            </table>
            </InsertItemTemplate>
            </asp:FormView>
</td></tr></table>
            
        </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Label ID="lblErrorAddUser" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
    <table align="center" class="data">
    <tr><td align="center">
    <asp:LinkButton ID="lbAddUser" runat="server" Text="Save" CommandName="Insert" Font-Bold="True" 
        Font-Size="Small" ValidationGroup="AddUser"/>
    </td><td align="center">
    <asp:LinkButton ID="lbCnclAddUser" runat="server" CommandName="Cancel" Text="Cancel" Font-Bold="True"
                Font-Size="Small" CausesValidation="False" />
    </td></tr></table>
</asp:Panel>
    <asp:Button id="btnShow" runat="server" style="display:none;"/>
    <cc1:ModalPopupExtender ID="mpeAddUser" runat="server" DropShadow ="True" X="300" Y="250"
	cancelcontrolid="lbCnclAddUser" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupAddUser"
	targetcontrolid="btnShow" popupcontrolid="pnlAddUser" Enabled="True">
    </cc1:ModalPopupExtender>


    <asp:Panel ID="pnlEditUser" runat="server"  CssClass="modalPopup" style="display:none;"
        DefaultButton="lbUserEdit" Width="487px" Height="350px" BackColor="#E6EDF4">
        <asp:UpdatePanel ID="mupEditUser" runat="server">
        <ContentTemplate>
<br /><table style="height: 160px" class="Modaltable"><tr><td class="style6">
</td><td>
             <asp:FormView ID="fvEditUser" runat="server"  DataSourceID="odsrcEditUserDS" DataKeyNames="personnel_pk" 
                DefaultMode="Edit" Width="459px" Height="129px">
            <EditItemTemplate>
                 <table style="width: 428px; height: 111px" bgcolor="#FFFFCC"><tr><td class="style5" colspan="2">
                <asp:Label ID="lblHeadingMsg" runat="server" Font-Bold="True" Font-Size="Small" 
                    Text="Update user Information:"></asp:Label>
            </td></tr><tr>
            <td>
                <asp:Label ID="lblEditFrstNm" runat="server" Text="First Name: " 
                    Font-Bold="True"></asp:Label>
            </td><td>
                <asp:TextBox ID="txtEditFrstNm" runat="server" Height="19px" Width="210px" Text='<%# Bind("firstName") %>'></asp:TextBox>
            </td></tr>
            <tr><td>
                <asp:Label ID="lblEditLstNm" runat="server" Text="Last Name: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:TextBox ID="txtEditLstNm" runat="server" Height="19px" Width="210px" Text='<%# Bind("lastName") %>'></asp:TextBox>
            </td></tr>
            <tr><td>
                <asp:Label ID="lblEditUserNm" runat="server" Text="Log On Id: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:TextBox ID="txtEditUserNm" runat="server" Height="19px" Width="210px" Text='<%# Bind("username") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditUserNm" runat="server" ControlToValidate="txtEditUserNm" 
                    ErrorMessage="User ID is required." ForeColor ="Red" ValidationGroup="EditUser"></asp:RequiredFieldValidator>
            </td></tr>
            <tr><td>
                <asp:Label ID="lblEditPhone" runat="server" Text="Phone: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:TextBox ID="txtEditPhone" runat="server" Height="19px" Width="210px" Text='<%# Bind("phoneNumber") %>'></asp:TextBox>
            <cc1:MaskedEditExtender ID="meePhoneEdit" runat="server" TargetControlID="txtEditPhone" Mask="(999) 999-9999" InputDirection="LeftToRight" ClearMaskOnLostFocus="False"></cc1:MaskedEditExtender>
            </td></tr>
            <tr><td>
                <asp:Label ID="lblEditEmail" runat="server" Text="Email: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:TextBox ID="txtEditEmail" runat="server" Height="19px" Width="210px" Text='<%# Bind("email") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditEmail" ControlToValidate="txtEditEmail" runat="server" 
                    ErrorMessage="Email is required" ForeColor="Red" ValidationGroup ="EditUser"></asp:RequiredFieldValidator>
            </td></tr>
            <tr><td>
                <asp:Label ID="lblEditGroup" runat="server" Text="Group: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:DropDownList ID="ddlEditGroup" runat="server" SelectedValue='<%# Bind("userGroup") %>'
                            DataTextField="groupName" DataValueField="userGroup" Height="21px" 
                            Width="142px" AppendDataBoundItems="True" DataSourceID="sdsrcEditUserGroup">
                            <asp:ListItem Value="0">-Select-</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvEditGroup" runat="server" ControlToValidate="ddlEditGroup" ErrorMessage="Select group" Font-Bold="true" 
                    ForeColor="Red" InitialValue="0" ValidationGroup="EditUser"></asp:RequiredFieldValidator>       
                 <asp:SqlDataSource ID="sdsrcEditUserGroup" runat="server"  ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                                SelectCommand="GetUserGroupBasedOnAdminType" SelectCommandType="StoredProcedure">
                                <SelectParameters><asp:ControlParameter Name="UserGroup" ControlID="lblUserRoleId" PropertyName="Text" /></SelectParameters>
                            </asp:SqlDataSource>   
            </td>
            </tr>

            <tr style="display:none"><td>
                <asp:Label ID="lblEditSre" runat="server" Text="SRE: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:CheckBox ID="cbEditSre" runat="server" Checked='<%# Bind("sreFlag") %>' />
            </td></tr>
            <tr style="display:none"><td>
                <asp:Label ID="lblEditProjEng" runat="server" Text="Proj. Engineer: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:CheckBox ID="cbEditProjEng" runat="server" Checked='<%# Bind("projEngineerFlag") %>' />
            </td></tr>
            <tr style="display:none"><td>
                <asp:Label ID="lblEditProjMangr" runat="server" Text="Proj. Manager: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:CheckBox ID="cbEditProjMangr" runat="server" Checked='<%# Bind("projManagerFlag") %>' />
            </td></tr>
            <tr style="display:none"><td>
                <asp:Label ID="lblEditContOfficer" runat="server" Text="Contract Officer: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:CheckBox ID="cbEditContOfficer" runat="server" Checked='<%# Bind("contractingOfficerFlag") %>' />
            </td></tr>
            <tr><td>
                <asp:Label ID="lblEditprojectPersonnel" runat="server" Text="Project Personnel: " Font-Bold="True"></asp:Label>
            </td><td>
                <asp:CheckBox ID="cbEditprojectPersonnel" runat="server" Checked='<%# Bind("projectPersonnel")%>' />
<%--                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("projectPersonnel") %>' />--%>

            </td></tr>

            <tr><td>
                <asp:Label ID="lblInactive" runat="server" Font-Bold="True" Text="Inactive:"></asp:Label>
            </td><td>
                <asp:CheckBox ID="cbInactive" runat="server" Checked='<%# Bind("deleted") %>' />
            </td></tr>
            </table>
                <asp:Label ID="lblPersonnelId" runat="server" Text='<%# Bind("personnel_pk") %>' Visible="False"></asp:Label>
            </EditItemTemplate>
            <InsertItemTemplate>
           
            </InsertItemTemplate>
            </asp:FormView>
<%--      <asp:ObjectDataSource ID="odsrcEditUser" runat="server" SelectMethod="GetPersonnelById" TypeName="FactSheetApp.FactSheetNewTableAdapters.PersonnelTableAdapter">
         <SelectParameters>
            <asp:ControlParameter ControlID="gvUser" Name="personnel_pk" PropertyName="SelectedValue" Type="Int32" />
         </SelectParameters>
      </asp:ObjectDataSource>--%>

      <asp:ObjectDataSource ID="odsrcEditUserDS" runat="server" SelectMethod="GetPersonnelById" TypeName="CFMISNew.FactSheetDataSetTableAdapters.PersonnelTableAdapter">
         <SelectParameters>
            <asp:ControlParameter ControlID="gvUser" Name="personnel_pk" PropertyName="SelectedValue" Type="Int32" />
         </SelectParameters>
      </asp:ObjectDataSource>


</td></tr></table>
            
        </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Label ID="lblError" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
    <table align="center" class="data">
    <tr><td align="center">
    <asp:LinkButton ID="lbUserEdit" runat="server" Text="Save" CommandName="Update" OnClick="lbUserEdit_Click" Font-Bold="True" 
        Font-Size="Small" ValidationGroup="EditUser"/>
    </td><td align="center">
    <asp:LinkButton ID="lbCancelEdit" runat="server" CommandName="Cancel" Text="Cancel" Font-Bold="True"
                Font-Size="Small" CausesValidation="False" />
    </td></tr></table>
</asp:Panel>
    <asp:Button id="btnShowEdit" runat="server" style="display:none;"/>
    <cc1:ModalPopupExtender ID="mpeEditUser" runat="server" DropShadow ="True" X="300" Y="250"
	cancelcontrolid="lbCancelEdit" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupEditUser"
	targetcontrolid="btnShowEdit" popupcontrolid="pnlEditUser" Enabled="True">
    </cc1:ModalPopupExtender>
</asp:Content>
