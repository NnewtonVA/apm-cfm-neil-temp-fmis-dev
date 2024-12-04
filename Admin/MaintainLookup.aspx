<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="MaintainLookup.aspx.vb" Inherits="CFMISNew.MaintainLookup" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" ></asp:ScriptManager>
    <div class="wideBox" style="padding-left:15px">
        <h2 align="center">Maintain major lookup lists in the application </h2>
        <div style="padding-left:35px; padding-right:35px;">
        <p style="font-weight: bold; font-family:Arial, Helvetica, Sans-Serif; font-size:12px"" >
            There are several dropdown lists in the application which help user to choose an item from 
            the available options. These options may change in future or user may need to add new options
            for the list. This page allows the user to maintain the options in the list to best serve their purpose.
            <br />
            <br />
            Below are the lists that populates dropdown options. Choose one to add/update.
        </p>
        </div>
        <br />
        <div style="width: 70%; padding-left:35px">
           <cc1:Accordion runat="server" ID="aLookuoList" HeaderCssClass="accordionHeader" Width="99%" 
               HeaderSelectedCssClass="accordionHeaderSelected" ContentCssClass="accordionContent" SelectedIndex="-1" RequireOpenedPane="false">
               <Panes>
                   <cc1:AccordionPane ID="apProjStatus" runat="server">
                       <Header>Project Status List</Header>
               <Content>
                  
                   <div style="padding-left:60px">
                   <asp:GridView ID="gvProjStatus" runat="server" DataKeyNames="status_pk" DataSourceID="odsrcStatusList" AutoGenerateColumns="False" 
                       AllowPaging="True" EmptyDataText="No match found" AllowSorting="True" CellPadding="4" 
                       ForeColor="#333333" GridLines="None" Width="75%"  ShowFooter="True">
                       <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                       <Columns>
                           <asp:BoundField DataField="status_pk" HeaderText="status_pk" SortExpression="status_pk" ControlStyle-CssClass="gvPadding" Visible="False" />
                           <asp:TemplateField HeaderText="Status Name" SortExpression="statusName" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtUpdtStatus" runat="server" Text='<%# Bind("statusName")%>' Width="250px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEdtStatus" runat="server" ControlToValidate="txtUpdtStatus" ErrorMessage="Required" ForeColor="Red" ValidationGroup="EdtStatus"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                               <ItemTemplate>
                                    <asp:Label ID="lblStatusName" runat="server" Text='<%# Eval("statusName")%>'></asp:Label>
                               </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtAddStatus" runat="server" Text='<%# Bind("statusName")%>' Width="250px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvStatusNm" runat="server" ControlToValidate="txtAddStatus" ErrorMessage="Required" ForeColor="Red" ValidationGroup="AddStatus"></asp:RequiredFieldValidator>
                                </FooterTemplate>
                            </asp:TemplateField>
                           <asp:TemplateField HeaderText="Status Code" SortExpression="statusCode" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtUpdtStatusCd" runat="server" Text='<%# Bind("statusCode")%>' Width="50px" Enabled="false"></asp:TextBox>
                                </EditItemTemplate>
                               <ItemTemplate>
                                    <asp:Label ID="lblStatusCode" runat="server" Text='<%# Eval("statusCode")%>'></asp:Label>
                               </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtAddStatusCd" runat="server" Text='<%# Bind("statusCode")%>' Width="50px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvStatusCd" runat="server" ControlToValidate="txtAddStatusCd" ErrorMessage="Required" ForeColor="Red" ValidationGroup="AddStatus"></asp:RequiredFieldValidator>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">                              
                                 <EditItemTemplate>
                                     <asp:Button ID="btnUpdtStatus" runat="server" Text="Update" CausesValidation="True" CommandName="Update" CssClass="roundBtn" ValidationGroup="EdtStatus"/>             
                        &nbsp;
                                <asp:Button ID="btnCnclStatus" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="roundBtn"/>                                        
                                 </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Button ID="btnEditStatus" runat="server" Text="Edit" CommandName="Edit" Font-Bold="False" Font-Size="12px" Width="40px" CssClass="roundBtn" />
                                </ItemTemplate>
                               <FooterTemplate>
                                   <asp:Button ID="btnAddStatus" runat="server" Text="Add New" OnClick="btnAddStatus_Click"  Font-Bold="False" Font-Size="12px"  CssClass="roundBtn" ValidationGroup="AddStatus"/>
                               </FooterTemplate>
                                <FooterStyle />
                            </asp:TemplateField>
                       </Columns>
                       <PagerTemplate>
                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled= '<%#IIf((gvProjStatus.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="White">&lt;&lt; First</asp:LinkButton>
                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled= '<%#IIf((gvProjStatus.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="White">&lt; Prev</asp:LinkButton> 
                    [Total Pg No: <%=gvProjStatus.PageCount%>][Current pg: <%=gvProjStatus.PageIndex + 1%>]
                    <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled= '<%#IIf((gvProjStatus.PageCount)=(gvProjStatus.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="White">Next &gt;</asp:LinkButton>
                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled= '<%#IIf((gvProjStatus.PageCount)=(gvProjStatus.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="White">Last &gt;&gt;</asp:LinkButton><br />
                    <asp:Label ID="lblCurrentPg" runat="server"></asp:Label>    
                </PagerTemplate>
                       <PagerStyle HorizontalAlign="Center"  BackColor="#284775" ForeColor="White" />
                        <EditRowStyle BackColor="#d8d8d8" />
                        <FooterStyle BackColor="#e2e1de" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                   </asp:GridView>
                  <asp:ObjectDataSource ID="odsrcStatusList" runat="server" DeleteMethod="Delete" 
                      SelectMethod="GetStatusList" TypeName="FactSheetApp.FactSheetNewTableAdapters.lkProjectStatusTableAdapter" UpdateMethod="UpdateStatusName">
                        <DeleteParameters><asp:Parameter Name="Original_status_pk" Type="Int32" /></DeleteParameters>
                        <UpdateParameters><asp:Parameter Name="statusName" Type="String" /><asp:Parameter Name="statusCode" Type="String" />
                         <asp:Parameter Name="status_pk" Type="Int32" /></UpdateParameters></asp:ObjectDataSource></div>
               </Content>
                   </cc1:AccordionPane>
                   <cc1:AccordionPane ID="apProjCategory" runat="server">
                        <Header>Project Category List</Header>
               <Content>
                   <div style="padding-left:60px">
                   <asp:GridView ID="gvProgCat" runat="server" AllowPaging="True"  EmptyDataText="No match found" AllowSorting="True" CellPadding="4" 
                       ForeColor="#333333" GridLines="None" Width="85%"  ShowFooter="True" AutoGenerateColumns="False" 
                       DataKeyNames="Category_pk" DataSourceID="odsrcAddNewProjCategory">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                <asp:BoundField DataField="Category_pk" HeaderText="Category_pk" InsertVisible="False" ReadOnly="True" SortExpression="Category_pk" Visible="False" />
                <asp:TemplateField HeaderText="Category Name" SortExpression="CategoryName"  HeaderStyle-HorizontalAlign="Left">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditProgCat" runat="server" Text='<%# Bind("CategoryName") %>' Width="250px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEdtProgCat" runat="server" ControlToValidate="txtEditProgCat" ErrorMessage="Required" ForeColor="Red" ValidationGroup="EdtProgCat"></asp:RequiredFieldValidator>
                         </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblProgCat" runat="server" Text='<%# Bind("CategoryName") %>'></asp:Label>
                    </ItemTemplate>
                     <FooterTemplate>
                         <asp:TextBox ID="txtAddProgCat" runat="server" Text='<%# Bind("CategoryName")%>' Width="250px"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server" ControlToValidate="txtAddProgCat" ErrorMessage="Required" ForeColor="Red" ValidationGroup="AddProgCat"></asp:RequiredFieldValidator>
                     </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Category Code" SortExpression="CategoryCode"  HeaderStyle-HorizontalAlign="Left">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditCatCode" runat="server" Text='<%# Bind("CategoryCode") %>' MaxLength="10" Width="50px" Enabled="false"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCatCode" runat="server" Text='<%# Bind("CategoryCode") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                         <asp:TextBox ID="txtAddCatCode" runat="server" Text='<%# Bind("CategoryCode")%>' Width="50px" MaxLength="10"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfvCategoryCode" runat="server" ControlToValidate="txtAddCatCode" ErrorMessage="Required" ForeColor="Red" ValidationGroup="AddProgCat"></asp:RequiredFieldValidator>
                     </FooterTemplate>
                </asp:TemplateField>
                 <asp:TemplateField ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">                              
                      <EditItemTemplate>
                          <asp:Button ID="btnUpdtCategory" runat="server" Text="Update" CausesValidation="True" CommandName="Update" CssClass="roundBtn" ValidationGroup="EdtProgCat"/>             
                        &nbsp;
                          <asp:Button ID="btnCnclCategory" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="roundBtn"/>                                        
                       </EditItemTemplate>
                       <ItemTemplate>
                          <asp:Button ID="btnEditCategory" runat="server" Text="Edit" CommandName="Edit" Font-Bold="False" Font-Size="12px" Width="40px" CssClass="roundBtn" />
                       </ItemTemplate>
                       <FooterTemplate>
                           <asp:Button ID="btnAddCategory" runat="server" Text="Add New"  Font-Bold="False" Font-Size="12px"  CssClass="roundBtn" ValidationGroup="AddProgCat" OnClick="btnAddCategory_Click"/>
                       </FooterTemplate>
                       <FooterStyle />
                      <ItemStyle HorizontalAlign="Right"></ItemStyle>
                 </asp:TemplateField>
            </Columns>
            <PagerTemplate>
                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled= '<%#IIf((gvProgCat.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="White">&lt;&lt; First</asp:LinkButton>
                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled= '<%#IIf((gvProgCat.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="White">&lt; Prev</asp:LinkButton> 
                    [Total Pg No: <%=gvProgCat.PageCount%>][Current pg: <%=gvProgCat.PageIndex + 1%>]
                    <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled= '<%#IIf((gvProgCat.PageCount)=(gvProgCat.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="White">Next &gt;</asp:LinkButton>
                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled= '<%#IIf((gvProgCat.PageCount)=(gvProgCat.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="White">Last &gt;&gt;</asp:LinkButton><br />
                    <asp:Label ID="lblCurrentPg" runat="server"></asp:Label>    
                </PagerTemplate>
                       <PagerStyle HorizontalAlign="Center"  BackColor="#284775" ForeColor="White" />
                        <EditRowStyle BackColor="#d8d8d8" />
                        <FooterStyle BackColor="#e2e1de" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
       
        <asp:ObjectDataSource ID="odsrcAddNewProjCategory" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="{0}" SelectMethod="GetProgramCatList" TypeName="FactSheetApp.FactSheetNewTableAdapters.lkProgramCategoryTableAdapter" UpdateMethod="UpdateProgCategory">
            <DeleteParameters>
                <asp:Parameter Name="Original_Category_pk" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="CategoryName" Type="String" />
                <asp:Parameter Name="CategoryCode" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="CategoryName" Type="String" />
                <asp:Parameter Name="CategoryCode" Type="String" />
                <asp:Parameter Name="Category_pk" Type="Int32" />
            </UpdateParameters>
        </asp:ObjectDataSource></div>
               </Content>
                   </cc1:AccordionPane>
                   <cc1:AccordionPane ID="apProjSubCategory" runat="server">
                        <Header>Project Sub Category List</Header>
               <Content>
                   <div style="padding-left:60px">
                  <asp:GridView ID="gvProgSubCat" runat="server" AllowPaging="True"  EmptyDataText="No match found" AllowSorting="True" CellPadding="4" 
            ForeColor="#333333" GridLines="None" Width="85%"  ShowFooter="True" AutoGenerateColumns="False" 
            DataKeyNames="SubCategory_pk" DataSourceID="odsrcProjSubCategory">
             <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
             <Columns>
                <asp:BoundField DataField="SubCategory_pk" HeaderText="SubCategory_pk" InsertVisible="False" ReadOnly="True" SortExpression="SubCategory_pk" Visible="False" />
                <asp:TemplateField HeaderText="Sub Category Name" SortExpression="SubCategoryName"  HeaderStyle-HorizontalAlign="Left">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEdtSubCat" runat="server" Text='<%# Bind("SubCategoryName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEdtSubCat" runat="server" ControlToValidate="txtEdtSubCat" ErrorMessage="Required" ForeColor="Red" ValidationGroup="EdtSubCat"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblSubCat" runat="server" Text='<%# Bind("SubCategoryName") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                         <asp:TextBox ID="txtAddSubCat" runat="server" Text='<%# Bind("SubCategoryName")%>' Width="250px"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfvSubCategoryName" runat="server" ControlToValidate="txtAddSubCat" ErrorMessage="Required" ForeColor="Red" ValidationGroup="AddSubCat"></asp:RequiredFieldValidator>
                     </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sub Category Code" SortExpression="SubCategoryNode"  HeaderStyle-HorizontalAlign="Left">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEdtSubCatCode" runat="server" Text='<%# Bind("SubCategoryNode") %>' Width="50px" Enabled="false"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblSubCatCode" runat="server" Text='<%# Bind("SubCategoryNode") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                         <asp:TextBox ID="txtAddSubCatCode" runat="server" Text='<%# Bind("SubCategoryNode")%>' Width="50px" MaxLength="10"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfvSubCategoryCode" runat="server" ControlToValidate="txtAddSubCatCode" ErrorMessage="Required" ForeColor="Red" ValidationGroup="AddSubCat"></asp:RequiredFieldValidator>
                     </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">                              
                      <EditItemTemplate>
                          <asp:Button ID="btnUpdtSubCategory" runat="server" Text="Update" CausesValidation="True" CommandName="Update" CssClass="roundBtn" ValidationGroup="EdtSubCat"/>             
                        &nbsp;
                          <asp:Button ID="btnCnclSubCategory" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="roundBtn"/>                                        
                       </EditItemTemplate>
                       <ItemTemplate>
                          <asp:Button ID="btnEdtSubCategory" runat="server" Text="Edit" CommandName="Edit" Font-Bold="False" Font-Size="12px" Width="40px" CssClass="roundBtn" />
                       </ItemTemplate>
                       <FooterTemplate>
                           <asp:Button ID="btnAddSubCategory" runat="server" Text="Add New"  Font-Bold="False" Font-Size="12px"  CssClass="roundBtn" ValidationGroup="AddSubCat" OnClick="btnAddSubCategory_Click" />
                       </FooterTemplate>
                       <FooterStyle />
                      <ItemStyle HorizontalAlign="Right"></ItemStyle>
                 </asp:TemplateField>
            </Columns>
            <PagerTemplate>
                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled= '<%#IIf((gvProgSubCat.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="White">&lt;&lt; First</asp:LinkButton>
                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled= '<%#IIf((gvProgSubCat.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="White">&lt; Prev</asp:LinkButton> 
                    [Total Pg No: <%=gvProgSubCat.PageCount%>][Current pg: <%=gvProgSubCat.PageIndex + 1%>]
                    <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled= '<%#IIf((gvProgSubCat.PageCount)=(gvProgSubCat.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="White">Next &gt;</asp:LinkButton>
                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled= '<%#IIf((gvProgSubCat.PageCount)=(gvProgSubCat.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="White">Last &gt;&gt;</asp:LinkButton><br />
                    <asp:Label ID="lblCurrentPg" runat="server"></asp:Label>    
                </PagerTemplate>
                       <PagerStyle HorizontalAlign="Center"  BackColor="#284775" ForeColor="White" />
                        <EditRowStyle BackColor="#d8d8d8" />
                        <FooterStyle BackColor="#e2e1de" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
       
        <asp:ObjectDataSource ID="odsrcProjSubCategory" runat="server" DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="GetProgramSubCatList" TypeName="FactSheetApp.FactSheetNewTableAdapters.lkProgramSubCategoryTableAdapter" UpdateMethod="UpdateProgSubCategory">
            <DeleteParameters>
                <asp:Parameter Name="Original_SubCategory_pk" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="SubCategoryName" Type="String" />
                <asp:Parameter Name="SubCategoryNode" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="SubCategoryName" Type="String" />
                <asp:Parameter Name="SubCategoryNode" Type="String" />
                <asp:Parameter Name="SubCategory_pk" Type="Int32" />
            </UpdateParameters>
        </asp:ObjectDataSource></div>
               </Content>
                   </cc1:AccordionPane>
                 <cc1:AccordionPane ID="apProjDeliveryMethod" runat="server">
                     <Header>Project Delivery Method List</Header>
               <Content>
                   <div style="padding-left:50px">
                       <asp:GridView ID="gvProjDeliveryMthd" runat="server"  AllowPaging="True"  EmptyDataText="No match found" AllowSorting="True" CellPadding="4" 
            ForeColor="#333333" GridLines="None" Width="98%"  ShowFooter="True" AutoGenerateColumns="False" 
            DataKeyNames="deliveryMethod_pk" DataSourceID="odsrcProjDeliveryMthd">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="deliveryMethod_pk" HeaderText="deliveryMethod_pk" InsertVisible="False" ReadOnly="True" SortExpression="deliveryMethod_pk" Visible="False" />
                <asp:TemplateField HeaderText="Delivery Method" SortExpression="deliveryMethodName" ItemStyle-VerticalAlign="Top">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEdtMethodName" runat="server" Text='<%# Bind("deliveryMethodName") %>' Width="80"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEdtMethodName" runat="server" ControlToValidate="txtEdtMethodName" ErrorMessage="Required" ForeColor="Red" ValidationGroup="EditDeliveryMthd"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblMethodName" runat="server" Text='<%# Bind("deliveryMethodName") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtAddMethodName" runat="server" Text='<%# Bind("deliveryMethodName")%>' Width="80px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDeliveryMthdName" runat="server" ControlToValidate="txtAddMethodName" ErrorMessage="Required" ForeColor="Red" ValidationGroup="AddDeliveryMethod"></asp:RequiredFieldValidator>
                    </FooterTemplate>
                    <HeaderStyle HorizontalAlign="Left" /><FooterStyle VerticalAlign="Top" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Code" SortExpression="deliveryMethodCode" ItemStyle-VerticalAlign="Top">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEdtMethodCode" runat="server" Text='<%# Bind("deliveryMethodCode") %>' Enabled="false" Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblMethodCode" runat="server" Text='<%# Bind("deliveryMethodCode") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtAddMethodCode" runat="server" Text='<%# Bind("deliveryMethodCode") %>' MaxLength="10" Width="50px" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvMthdCode" runat="server" ControlToValidate="txtAddMethodCode" ErrorMessage="Required" ForeColor="Red" ValidationGroup="AddDeliveryMethod"></asp:RequiredFieldValidator>
                    </FooterTemplate>
                    <HeaderStyle HorizontalAlign="Left" /><FooterStyle VerticalAlign="Top" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description" SortExpression="deliveryMethodDescription" ItemStyle-VerticalAlign="Top">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEdtDesc" runat="server" Text='<%# Bind("deliveryMethodDescription") %>'  Width="255px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblEdtDesc" runat="server" Text='<%# Bind("deliveryMethodDescription") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtAddMthdDesc" runat="server" Text='<%# Bind("deliveryMethodDescription") %>' Width="280px"></asp:TextBox>
                    </FooterTemplate>
                    <HeaderStyle HorizontalAlign="Left" /><FooterStyle VerticalAlign="Top" />
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                     <EditItemTemplate>
                          <asp:Button ID="btnUpdtDeliveryMthd" runat="server" Text="Update" CausesValidation="True" CommandName="Update" CssClass="roundBtn" ValidationGroup="EditDeliveryMthd"/>             
                        &nbsp;
                          <asp:Button ID="btnCnclDeliveryMthd" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="roundBtn"/>                                        
                       </EditItemTemplate>
                       <ItemTemplate>
                          <asp:Button ID="btnEdtDeliveryMthd" runat="server" Text="Edit" CommandName="Edit" Font-Bold="False" Font-Size="12px" Width="40px" CssClass="roundBtn" />
                       </ItemTemplate>
                       <FooterTemplate>
                           <asp:Button ID="btnAddDeliveryMthd" runat="server" Text="Add New"  Font-Bold="False" Font-Size="12px"  CssClass="roundBtn" ValidationGroup="AddDeliveryMethod" OnClick="btnAddDeliveryMthd_Click" />
                       </FooterTemplate>
                       <FooterStyle />
                      <ItemStyle HorizontalAlign="Right" Wrap="False"></ItemStyle>
                </asp:TemplateField>
            </Columns>
            <PagerTemplate>
                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled= '<%#IIf((gvProjDeliveryMthd.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="White">&lt;&lt; First</asp:LinkButton>
                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled= '<%#IIf((gvProjDeliveryMthd.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="White">&lt; Prev</asp:LinkButton> 
                    [Total Pg No: <%=gvProjDeliveryMthd.PageCount%>][Current pg: <%=gvProjDeliveryMthd.PageIndex + 1%>]
                    <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled= '<%#IIf((gvProjDeliveryMthd.PageCount)=(gvProjDeliveryMthd.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="White">Next &gt;</asp:LinkButton>
                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled= '<%#IIf((gvProjDeliveryMthd.PageCount)=(gvProjDeliveryMthd.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="White">Last &gt;&gt;</asp:LinkButton><br />
                    <asp:Label ID="lblCurrentPg" runat="server"></asp:Label>    
                </PagerTemplate>
                       <PagerStyle HorizontalAlign="Center"  BackColor="#284775" ForeColor="White" />
                        <EditRowStyle BackColor="#d8d8d8" />
                        <FooterStyle BackColor="#e2e1de" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
       
        <asp:ObjectDataSource ID="odsrcProjDeliveryMthd" runat="server" DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="GetDelivaryMethodList" TypeName="FactSheetApp.FactSheetNewTableAdapters.lkDeliveryMethodTableAdapter" UpdateMethod="UpdateProjDeliveryMethod">
            <DeleteParameters>
                <asp:Parameter Name="Original_deliveryMethod_pk" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="deliveryMethodName" Type="String" />
                <asp:Parameter Name="deliveryMethodCode" Type="String" />
                <asp:Parameter Name="deliveryMethodDescription" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="deliveryMethodName" Type="String" />
                <asp:Parameter Name="deliveryMethodCode" Type="String" />
                <asp:Parameter Name="deliveryMethodDescription" Type="String" />
                <asp:Parameter Name="deliveryMethod_pk" Type="Int32" />
            </UpdateParameters>
        </asp:ObjectDataSource>
                   </div>
               </Content>
                 </cc1:AccordionPane>
               </Panes>     
           </cc1:Accordion>
        </div>
        
       
    <br />
    <br />
    </div>
   
</asp:Content>
