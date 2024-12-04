<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ShowDoc.aspx.vb" Inherits="CFMISNew.ShowDoc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:DetailsView ID="dtvShow" runat="server" Height="332px" Width="723px" 
        AutoGenerateRows="False" DataSourceID="odsrcShowDoc">
        <Fields>
            <asp:TemplateField HeaderText="doc" SortExpression="doc">
                
                <ItemTemplate>
                    <asp:Image ID="iShowFile" runat="server"  
                        ImageUrl='<%# Eval("doc")%>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Fields>
    </asp:DetailsView>


    <asp:ObjectDataSource ID="odsrcShowDoc" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDocumentById" TypeName="FactSheetApp.FactSheetNewTableAdapters.CFMIS_docTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter Name="ID" QueryStringField="docID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>


</asp:Content>
