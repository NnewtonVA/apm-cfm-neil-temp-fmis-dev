<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ProjectDetails.aspx.vb" Inherits="CFMISNew.ProjectDetails" MaintainScrollPositionOnPostback="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!DOCTYPE HTML>
    <style type="text/css">
        .auto-style1 {
            width: 493px;
        }

        .auto-style36 {
            width: 130px;
            height: 42px;
        }

        .auto-style41 {
            width: 536px;
            height: 42px;
        }

        .auto-style53 {
            height: 41px;
        }

        .auto-style55 {
            height: 19px;
            width: 237px;
        }

        .auto-style56 {
            width: 236px;
            height: 41px;
        }

        .auto-style59 {
            width: 58px;
        }

        .auto-style60 {
            width: 61px;
        }

        .auto-style61 {
            width: 146px;
        }

        .auto-style71 {
            height: 20px;
        }

        .auto-style77 {
        }

        .auto-style78 {
            width: 175px;
        }

        .auto-style80 {
            width: 63px;
        }

        .auto-style103 {
            width: 405px;
            height: 19px;
        }

        .auto-style104 {
            height: 19px;
        }

        .auto-style108 {
            width: 76px;
        }

        .auto-style109 {
            width: 215px;
        }

        .auto-style112 {
            width: 130px;
        }

        .auto-style113 {
            width: 127px;
        }

        .auto-style114 {
            width: 126px;
        }

        .auto-style116 {
            height: 40px;
        }

        .auto-style117 {
            height: 40px;
            width: 80px;
        }

        .auto-style118 {
            width: 8px;
        }

        .abc {
            height: auto;
        }
    </style>
    <style type="text/css">
        body {
            background: #e6eeff;
            font-family: 'source sans pro';
            font-weight: 400;
        }

        h1 {
            font-size: 35px;
            color: #2c97de;
            text-align: center;
        }

        .accordionMenu {
            width: 100%;
            margin: 0 auto;
        }

            .accordionMenu > input[type=radio] {
                display: none;
            }

            .accordionMenu > label {
                display: block;
                height: 40px;
                line-height: 47px;
                padding: 0 25px 0 30px;
                background: #e6ecff;
                font-size: 10px;
                color: black;
                position: relative;
                cursor: pointer;
                border-bottom: 1px solid #e6e6e6;
            }

            .accordionMenu label::after {
                display: block;
                content: "";
                width: 0;
                height: 0;
                border-style: solid;
                border-width: 5px 0 5px 10px;
                border-color: transparent transparent transparent black;
                position: absolute;
                left: 10px;
                top: 20px;
                z-index: 10;
                -webkit-transition: all 0.3s ease-in-out;
                -moz-transition: all 0.3s ease-in-out;
                -ms-transition: all 0.3s ease-in-out;
                -o-transition: all 0.3s ease-in-out;
                transition: all 0.3s ease-in-out;
            }

            .accordionMenu .content {
                /*display: none;*/
                -webkit-transition: all 2s ease-in-out;
                -moz-transition: all 2s ease-in-out;
                -o-transition: all 2s ease-in-out;
                transition: all 2s ease-in-out;
            }
    </style>
    <script language="javascript" type="text/javascript">
        function openNewWin(url) {
            var x = window.location(url);
            x.focus();
        }
        //Neil Newton

        function handleClick(myRadio) {

            //alert('Old value: ' + currentValue);
            //alert('New value: ' + myRadio.value);
            //currentValue = myRadio.value;l
            //alert(document.getElementByID("rdoProjectedLeedSilver").checked);
            //var reasons = document.getElementsByName("<%=rdoProjectedLeedSilver.UniqueID%>");
            var selectedvalue = $('#<%= rdoProjectedLeedSilver.ClientID %> input:checked').val()
            alert(selectedvalue)
            if (selectedvalue === "No") {
                alert('NoPicked');
                $("#<%=rdoLeedWaiver.ClientID %>").find('input').prop('disabled', 'true');
                var elementRef = document.getElementById('<%= rdoProjectedLeedSilver.ClientID %>');
                var inputElementArray = elementRef.getElementsByTagName('input');

                for (var i = 0; i < inputElementArray.length; i++) {
                    var inputElement = inputElementArray[i];

                    inputElement.checked = false;
                }
                //return false;
            }
            else
            { 
                alert('picked');
                $("#<%=rdoLeedWaiver.ClientID %>").find('input').prop('disabled', false); 
            }
            return false;

        }

        //Neil Sustainbility
        function handleleedrequired(myRadio) {
            var selectedvalue = $('#<%= rdoLEEDRequired.ClientID %> input:checked').val()
            alert('LeedRequired');
            alert(selectedvalue)
            if (selectedvalue === "No") {
                alert('NoPicked');
                $("#<%=rdRegisteredOnline.ClientID %>").find('input').prop('disabled', 'true');
                //$("#<%=txtLeedRegistration.ClientID %>").find('input').prop('disabled', 'true');
                //document.getElementById('txtLeedRegistration').disabled = true;
                //$('#txtLeedRegistration').prop('disabled', 'disabled');
                var inputBox = $("#<%=txtLeedRegistration.ClientID%>");
                inputBox.prop('disabled', true);
                $("#<%=rdoProjectedLeedSilver.ClientID %>").find('input').prop('disabled', 'true');
                $("#<%=rdoLeedWaiver.ClientID %>").find('input').prop('disabled', 'true');
                $("#<%=rdoCertStatus.ClientID %>").find('input').prop('disabled', 'true');
                var elementRef = document.getElementById('<%= rdoProjectedLeedSilver.ClientID %>');
                var inputElementArray = elementRef.getElementsByTagName('input');

                for (var i = 0; i < inputElementArray.length; i++) {
                    var inputElement = inputElementArray[i];

                    inputElement.checked = false;
                }
                //return false;
            }
            else
            { 
                alert('picked');
                $("#<%=rdRegisteredOnline.ClientID %>").find('input').prop('disabled', '');
                var inputBox = $("#<%=txtLeedRegistration.ClientID%>");
                inputBox.prop('disabled', false);
                $("#<%=rdoProjectedLeedSilver.ClientID %>").find('input').prop('disabled', '');
                $("#<%=      rdoLeedWaiver.ClientID %>").find('input').prop('disabled', '');
                $("#<%=rdoCertStatus.ClientID %>").find('input').prop('disabled', '');
                
            }
            return false;          
        }

        //Neil Sustainbility
        function handleleedregistered(myRadio) {
            var selectedvalue = $('#<%= rdRegisteredOnline.ClientID %> input:checked').val()
            alert('leed registered')
            alert(selectedvalue)
             if (selectedvalue === "No") {
               alert('NoPicked');
        var inputBox = $("#<%=txtLeedRegistration.ClientID%>");
        inputBox.prop('disabled', true);
        

        
        //return false;
    }
    else
    { 
        alert('picked');
        $("#<%=rdRegisteredOnline.ClientID %>").find('input').prop('disabled', '');
        var inputBox = $("#<%=txtLeedRegistration.ClientID%>");
        inputBox.prop('disabled', false);
        $("#<%=rdoProjectedLeedSilver.ClientID %>").find('input').prop('disabled', '');
        $("#<%=      rdoLeedWaiver.ClientID %>").find('input').prop('disabled', '');
        $("#<%=rdoCertStatus.ClientID %>").find('input').prop('disabled', '');

    }
    return false;
        }

        //Neil Sustainbility
        function handleashraefinal(myChk) {
            alert('Final Ashrae');
            alert($("#chkFinal").prop('checked'))
            chkstatus = $("#chkFinal").prop('checked')
            //alert('Finalchk');
           <%-- if (chkstatus) {
                alert('Finalcheck');
                var inputBox = $("#<%=txtDateDesignComplete.ClientID%>");
                inputBox.prop('disabled', false);
             }
            else
            {
                alert('finalnocheck');
                var inputBox = $("#<%=txtDateDesignComplete.ClientID%>");
                inputBox.prop('disabled', true);
            }--%>
           
            return false;
        }
        function handleleedCertStat(myRadio) {

            alert('cert');
            var selectedvalue = $('#<%= rdoCertStatus.ClientID %> input:checked').val()
            alert(selectedvalue);
            alert('Cert2')
            if (selectedvalue === "Certified") {
                alert('Certified');
            }
            else
            {
                alert('Not Certified');
            }
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
elementRef
                        case 2:
                            ddl.style.backgroundColor = 'Red';
                            return;

                    }
                }
            }
        }

    </script>
    <script type="text/javascript">
        function checkDate(sender, args) {
            if (sender._selectedDate > new Date()) {
                alert("Actual date cannot be future date!");
                //sender._selectedDate = new Date();
                // set the date back to the current date
                //sender._textbox.set_Value(sender._selectedDate.format(sender._format))
                sender._textbox.set_Value('');
            }
        }

    </script>
    <script language="javascript" type="text/javascript">
        function expand(tb) {
            $(tb).attr('rows', 20);
        }
        function collapse(tb) {
            $(tb).attr('rows', 6);
        }

        var maxLength = 675;
        function validateLength(ta) {
            if (ta.value.length > maxLength) {
                ta.value = ta.value.substring(0, maxLength);
                alert("You have exceeded the 675 characters limit!");
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%--Neil Sustanability--%>
    <asp:HiddenField    id="confirm_value" runat="server"/>.
    <%--Neil Sustainabiity--%>
    <asp:Label ID="lblUserNm" runat="server" Visible="False"></asp:Label>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="float: right; padding-right: 30px; padding-bottom: 5px; padding-top: 5px">
        <asp:HyperLink ID="hlFactsheetPage" runat="server" ForeColor="#003399" Font-Size="10pt" Font-Bold="True" Visible="False">Go To Factsheet details Page</asp:HyperLink>
    </div>
    <br />
    <asp:FormView ID="fvAllTabInfo" runat="server" DataSourceID="odsrcAllTabInfo" Width="99%">
        <EditItemTemplate>
        </EditItemTemplate>
        <InsertItemTemplate>
        </InsertItemTemplate>
        <ItemTemplate>
            <div style="padding-left: 10px; padding-right: 10px;">
                <table width="99%" bgcolor="#A2ACC4" style="border: 1px outset #5C5C5C; font-size: 10pt; font-weight: bold;">
                    <tr>
                        <td width="50%">
                            <table>
                                <tr>
                                    <td>Project Description: </td>
                                    <td style="padding-left: 5px;">
                                        <asp:Label ID="lblShowProjDesc" runat="server" Text='<%# Bind("projectDesc") %>' /></td>
                                </tr>
                                <tr>
                                    <td>Project Name: </td>
                                    <td style="padding-left: 5px;">
                                        <asp:Label ID="lblShowProjNm" runat="server" Text='<%# Bind("ProjectName") %>' /></td>
                                </tr>
                            </table>
                        </td>
                        <td align="left" width="20%">
                            <asp:Label ID="lblSubPorj" runat="server" Text="This is a Sub Project" Visible='<%# IIf(Eval("subProjectFlag") = "True", "true", "false")%>'></asp:Label>
                        </td>
                        <td align="right" valign="top" width="29%">
                            <table>
                                <tr>
                                    <td>Project Code: 
                                    </td>
                                    <td style="padding-left: 5px;">
                                        <asp:Label ID="lblShowProjCode" runat="server" Text='<%# Bind("projectCode") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style71">Project Type: 
                                    </td>
                                    <td class="auto-style71" style="padding-left: 5px;">
                                        <asp:Label ID="lblShowProjTp" runat="server" Text='<%# Bind("projectTypeName") %>' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%--<tr><td align="center" class="auto-style40" colspan="2">
					   <asp:Label ID="lblSubPorj" runat="server" Text="This is a Sub Project" Visible='<%# IIf(Eval("subProjectFlag") = "True", "true", "false")%>' ></asp:Label>
								   </td></tr>--%>
                </table>
            </div>
            <asp:Label ID="lblProjId" runat="server" Text='<%# Bind("project_pk") %>' Visible="False"></asp:Label>
            <asp:CheckBox ID="subProjectFlagCheckBox" runat="server" Checked='<%# Bind("subProjectFlag") %>' Enabled="false" Visible="False" />
            <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>' Visible="False"></asp:Label>
        </ItemTemplate>
    </asp:FormView>
    <asp:ObjectDataSource ID="odsrcAllTabInfo" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetInfoForProjectDetails"
        TypeName="FactSheetApp.FactSheetNewTableAdapters.ProjectSearchTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <table style="height: 861px; width: 100%"><tr><td valign="top" width="90px">
                <br />
                <asp:GridView ID="gvSubProj" runat="server" AutoGenerateColumns="False" DataKeyNames="project_pk"
                    DataSourceID="odsrcGetSubProj" Width="135px" ForeColor="#333333" GridLines="None" EmptyDataText="Sub Project not found">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="project_pk" HeaderText="Sub Projects" InsertVisible="False" ReadOnly="True" SortExpression="project_pk" Visible="False" />
                        <%--<asp:BoundField DataField="projectCode" HeaderText="Sub Project #" SortExpression="projectCode" />--%>
                        <asp:HyperLinkField DataNavigateUrlFields="project_pk" DataNavigateUrlFormatString="ProjectDetails.aspx?project_pk={0}" DataTextField="projectCode"
                            HeaderText="Related Project #" ItemStyle-ForeColor="#0000CC" SortExpression="projectCode">
                            <ItemStyle Font-Bold="False" Font-Underline="True" ForeColor="Blue" CssClass="gvPadding" />
                        </asp:HyperLinkField>
                        <asp:BoundField DataField="mainProject_fk" HeaderText="Main Project" SortExpression="mainProject_fk" Visible="False" />
                        <asp:CheckBoxField DataField="subProjectFlag" HeaderText="subProjectFlag" SortExpression="subProjectFlag" Visible="False" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <EmptyDataRowStyle BackColor="#B3B3FF" Font-Bold="True" Font-Size="11pt" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                </asp:GridView>
                <asp:ObjectDataSource ID="odsrcGetSubProj" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetMainAndSubProject" TypeName="FactSheetApp.FactSheetNewTableAdapters.GetSubProjByMainProjTableAdapter" InsertMethod="Insert" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_project_pk" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="mainProject_fk" Type="Int32" />
                        <asp:Parameter Name="subProjectFlag" Type="Boolean" />
                        <asp:Parameter Name="projectCode" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="mainProject_fk" Type="Int32" />
                        <asp:Parameter Name="subProjectFlag" Type="Boolean" />
                        <asp:Parameter Name="projectCode" Type="String" />
                        <asp:Parameter Name="Original_project_pk" Type="Int32" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <br />
                <asp:Button ID="btnAddSubProj" runat="server" Text="Add Sub Project" Font-Bold="True" CausesValidation="false" />
            </td>
            <td width="95%">			
                <cc1:TabContainer ID="tcProjectDetails" runat="server" Width="98%" Height="3500px" ActiveTabIndex="7">
                    
					<cc1:TabPanel ID="tpMainInfo" runat="server"><HeaderTemplate>Main Project Information</HeaderTemplate>
                        
						<ContentTemplate><asp:UpdatePanel ID="tab1" runat="server">
                                <ContentTemplate>
                                    <div style="background-color: #e6eeff; padding-top: 15px; padding-bottom: 15px; padding-left: 10px;">
                                        <div class="wideBox" style="overflow: auto; padding-left: 10px;">
                                            <table width="90%">
                                                <tr>
                                                    <td class="auto-style103">
                                                        <asp:Label ID="lblMainInfoHdg" runat="server" Font-Bold="True" Font-Size="12px"></asp:Label></td>
                                                    <td class="auto-style104">
                                                        <asp:Label ID="lblDistrictReq" runat="server" ForeColor="Red"></asp:Label></td>
                                                </tr>
                                            </table>
                                            <br />
                                            <asp:FormView ID="fvMainInfo" runat="server" DataSourceID="odsrcMainInfo" Width="90%" DefaultMode="Edit">
                                                <EditItemTemplate>
                                                    <div>
                                                        <table style="width: 98%">
                                                            <tr>
                                                                <td>
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <b>Project Description:</b> </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtProjDesc" runat="server" Text='<%# Bind("projectDesc") %>' Width="300px" /></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><b>Project Name:</b> </td>
                                                                            <td>
                                                                                <asp:Label ID="lblProjName" runat="server" Text='<%# Bind("projectName") %>'></asp:Label>
                                                                                <asp:TextBox ID="txtProjName" runat="server" Text='<%# Bind("projectName") %>' Width="95%" Visible="False" /></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><b>Project Code:</b> </td>
                                                                            <td>
                                                                                <asp:Label ID="lblProjCode" runat="server" Text='<%# Bind("projectCode") %>'></asp:Label>
                                                                                <asp:TextBox ID="txtProjCode" runat="server" Text='<%# Bind("projectCode") %>' Width="95%" Visible="False" /></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><b>Station:</b> </td>
                                                                            <td>
                                                                                <asp:Label ID="lblStation" runat="server" Text='<%# String.Concat(Eval("stationNo"), " - ", Eval("Location"))%>'></asp:Label>
                                                                                <asp:DropDownList ID="ddlStation" runat="server" DataSourceID="odsrcStationList" DataTextField="Station"
                                                                                    DataValueField="station_pk" SelectedValue='<%# Bind("station_fk") %>' Width="95%" Visible="False">
                                                                                </asp:DropDownList>
                                                                                <asp:ObjectDataSource ID="odsrcStationList" runat="server" OldValuesParameterFormatString="original_{0}"
                                                                                    SelectMethod="GetStationsList" TypeName="FactSheetApp.FactSheetNewTableAdapters.StationListTableAdapter"></asp:ObjectDataSource>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <br />
                                                                    <table>
                                                                        <tr>
                                                                            <td><b>Project Status:</b> </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlStatus" runat="server" DataSourceID="odsrcStatusList" DataTextField="statusName"
                                                                                    DataValueField="status_pk" Width="95%" SelectedValue='<%# Bind("status_fk")%>'>
                                                                                </asp:DropDownList>
                                                                                <asp:ObjectDataSource ID="odsrcStatusList" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
                                                                                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetStatusList" TypeName="FactSheetApp.FactSheetNewTableAdapters.lkProjectStatusTableAdapter"
                                                                                    UpdateMethod="Update">
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
                                                                        </tr>
                                                                        <tr>
                                                                            <td><b>Program Category:</b> </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="odsrcCategoryList" DataTextField="CategoryName"
                                                                                    DataValueField="Category_pk" Width="95%" SelectedValue='<%# Bind("Category_fk")%>'>
                                                                                </asp:DropDownList>
                                                                                <asp:ObjectDataSource ID="odsrcCategoryList" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
                                                                                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetProgramCatList" TypeName="FactSheetApp.FactSheetNewTableAdapters.lkProgramCategoryTableAdapter"
                                                                                    UpdateMethod="Update">
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
                                                                        </tr>
                                                                        <tr>
                                                                            <td><b>Program Sub Category:</b> </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlSubCategory" runat="server" DataSourceID="odsrcSubCategoryList"
                                                                                    DataTextField="SubCategoryName" DataValueField="SubCategory_pk" Width="95%"
                                                                                    SelectedValue='<%# Bind("subCategory_fk")%>'>
                                                                                </asp:DropDownList>
                                                                                <asp:ObjectDataSource ID="odsrcSubCategoryList" runat="server" DeleteMethod="Delete"
                                                                                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetProgramSubCatList"
                                                                                    TypeName="FactSheetApp.FactSheetNewTableAdapters.lkProgramSubCategoryTableAdapter" UpdateMethod="Update">
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
                                                                        </tr>
                                                                        <tr>
                                                                            <td><b>Delivery Method:</b> </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlDeliveryM" runat="server" DataSourceID="odsrcDelivaryMethodList" DataTextField="deliveryMethodName"
                                                                                    DataValueField="deliveryMethod_pk" Width="95%" SelectedValue='<%# Bind("delivery_Method_fk")%>' AppendDataBoundItems="True">
                                                                                    <asp:ListItem Text="-Select-" Value="0"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                                <asp:RequiredFieldValidator ID="rfvDeliveryM" runat="server" ControlToValidate="ddlDeliveryM" InitialValue="0" ErrorMessage="Select a Delivery Method" ForeColor="Red" ValidationGroup="VGEditProj"></asp:RequiredFieldValidator>
                                                                                <asp:ObjectDataSource ID="odsrcDelivaryMethodList" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}"
                                                                                    SelectMethod="GetDelivaryMethodList" TypeName="FactSheetApp.FactSheetNewTableAdapters.lkDeliveryMethodTableAdapter" UpdateMethod="Update">
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
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblShowProjTp" runat="server" Font-Bold="True" Text="Project Type:"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlType" runat="server" DataSourceID="odsrcProjTypeList" DataTextField="projectTypeName"
                                                                                    DataValueField="projectType_pk" SelectedValue='<%# Bind("projectType_fk") %>' Width="95%">
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
                                                                        </tr>

                                                                        <tr>
                                                                            <td colspan="2">
                                                                        <fieldset>
                                                                            <legend>Execution Agent</legend>

                                                                                <asp:Label ID="lblShowDesignAgent" runat="server" Font-Bold="True" Text="Design:"></asp:Label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                                                <asp:DropDownList ID="ddlEditDesignAgent" runat="server" AppendDataBoundItems="True" DataSourceID="sdsrcExecutionAgent"
                                                                                      DataTextField="ExecAgentDesc" DataValueField="ExecAgentID" SelectedValue='<%# Bind("ExecDesignAgentID")%>' Height="21px" Width="50%" AutoPostBack="True" OnSelectedIndexChanged="ddlEditDesignAgent_SelectedIndexChanged">
                                                                     <%--                <asp:ListItem Text="-Select from list-" Value=""></asp:ListItem>--%>
                                                                                </asp:DropDownList>
                                                                                <br />
                                                                                <br />
                                                                                <asp:Label ID="lblShowConstructions" runat="server" Font-Bold="True" Text="Construction:"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                <asp:DropDownList ID="ddlEditConstructionAgent" runat="server" AppendDataBoundItems="True" DataSourceID="sdsrcExecutionAgent"
                                                                                      DataTextField="ExecAgentDesc" DataValueField="ExecAgentID" SelectedValue='<%# Bind("ExecConstructionAgentID")%>' Height="21px" Width="50%" AutoPostBack="True" OnSelectedIndexChanged="ddlEditConstructionAgent_SelectedIndexChanged">
                                                                     <%--                <asp:ListItem Text="-Select from list-" Value=""></asp:ListItem>--%>
                                                                                </asp:DropDownList>

                                                                            </fieldset>
                                                                                <asp:SqlDataSource ID="sdsrcExecutionAgent" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>"
                      SelectCommand="SELECT ExecAgentID, ExecAgentDesc FROM lkExecutionAgent Order By ExecAgentDesc"></asp:SqlDataSource>

                                                                            </td>
                                                                        </tr>
                                                                        

                                                                    </table>
                                                                    <asp:CheckBox ID="cbSubProjectFlag" runat="server" Checked='<%# Bind("subProjectFlag") %>' Visible="False" /><asp:Label ID="lblProjId" runat="server" Text='<%# Bind("project_pk") %>' Visible="False"></asp:Label></td>																													  
                                                                <td valign="top">
                                                                <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblProgYr" runat="server" Font-Bold="True" Text="Program Year:"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtProgYr" runat="server" Text='<%# Bind("programYear") %>' Width="95px" /></td>
                                                                            <td align="left">
                                                                                <asp:CompareValidator ID="cvProgYr" runat="server" ControlToValidate="txtProgYr" ErrorMessage="Integer only" ForeColor="Red" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>

                                                                            </td>

                                                                            <td style="width: 650px" align="right">
                                                                                <img id="ProjectHealthColor" runat="server" src="Images/projectHealthColorGreen.png" style="height: 80px; width: 230px;" /></td>
                                                                        </tr>
                                                            </tr>
                                                            <tr>
                                                                <td><b>Region:</b></td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlEditRegion" runat="server" AppendDataBoundItems="True" DataSourceID="sdsrcRegion"
                                                                        DataTextField="region" DataValueField="region" SelectedValue='<%# Bind("region")%>' Height="21px" Width="120px" AutoPostBack="True" OnSelectedIndexChanged="ddlEditRegion_SelectedIndexChanged">
                                                                        <asp:ListItem Text="-Select from list-" Value=""></asp:ListItem>
                                                                    </asp:DropDownList></td>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblNcaDistrict" runat="server" Font-Bold="True" Text="NCA District" Visible="False"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlNcaDistrict" runat="server" DataSourceID="sdsrcNcaDistrict" DataTextField="district" DataValueField="district_pk"
                                                                        Height="21px" Width="120px" SelectedValue='<%# Bind("ncaDistrict_fk") %>' AppendDataBoundItems="True" Visible="False">
                                                                        <asp:ListItem Text="-Select from list-" Value=""></asp:ListItem>
                                                                    </asp:DropDownList>

                                                                    <asp:SqlDataSource ID="sdsrcNcaDistrict" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>"
                                                                        SelectCommand="SELECT * FROM [lkNCAdistrict] Order By district"></asp:SqlDataSource>
                                                                </td>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td><b>Created Date:</b> </td>
                                                                <td>
                                                                    <asp:Label ID="lblCreatedDt" runat="server" Text='<%# Bind("creationDate", "{0:d}") %>'></asp:Label></td>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td><b>VISN:</b> </td>
                                                                <td>
                                                                    <asp:Label ID="lblVisn" runat="server" Text='<%# Bind("VISN") %>' /></td>
                                                                <td>&nbsp;</td>
                                                            </tr>
															
                                            <tr><td><b>Last CPRMP:</b> </td>
                                                <td>
                                                    <asp:TextBox ID="txtlastCPRMP" runat="server" Text='<%# Bind("lastCPRMP", "{0:MM/dd/yyyy}")%>' Height="15px" Width="70px"></asp:TextBox>
                                                     <cc1:CalendarExtender ID="celastCPRMP" runat="server" TargetControlID="txtlastCPRMP"></cc1:CalendarExtender>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>

																												   
																																																				
																			 
																 
																
                                            <tr><td><b>Next CPRMP:</b> </td>
                                                <td>
                                                    <asp:TextBox ID="txtnextCPRMP" runat="server" Text='<%# Bind("nextCPRMP", "{0:MM/dd/yyyy}")%>' Height="15px" Width="70px"></asp:TextBox>
                                                     <cc1:CalendarExtender ID="cenextCPRMP" runat="server" TargetControlID="txtnextCPRMP"></cc1:CalendarExtender>
																																		
																							
																			   
																 
																
																	
																																												   
                                                </td>
                                                <td>&nbsp;</td>
																																																			  
																																															  
																																		
                                            </tr>

															
															
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                                <td>
                                                                    <asp:SqlDataSource ID="sdsrcRegion" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>"
                                                                        SelectCommand="SELECT DISTINCT region FROM Project Where region is not null Order By region"></asp:SqlDataSource>
                                                                </td>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                        </table>
                                                        <table style="width: 290px">
                                                            <tr>
                                                                <td class="auto-style117">
                                                                    <b>Design Funding Yr: </b>
                                                                </td>
                                                                <td class="auto-style116">
                                                                    <asp:TextBox ID="txtDesignFund" runat="server" Height="35px" TextMode="MultiLine" Text='<%# Bind("designFundingYear") %>' Width="350px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="auto-style117">
                                                                    <b>Construction Funding Yr: </b>
                                                                </td>
                                                                <td class="auto-style116">
                                                                    <asp:TextBox ID="txtConstructionFund" runat="server" Height="35px" TextMode="MultiLine" Text='<%# Bind("constFundingYear") %>' Width="350px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        </td></tr>
</table>
                                                    </div>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td>Project Description: </td>
                                                            <td>
                                                                <asp:Label ID="lblShowProjDesc" runat="server" Text='<%# Bind("projectDesc") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Project Name: </td>
                                                            <td>
                                                                <asp:Label ID="lblShowProjNm" runat="server" Text='<%# Bind("ProjectName") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Station: </td>
                                                            <td>
                                                                <asp:Label ID="lblShowStation" runat="server" Text='<%# Bind("stationName") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Project Code: </td>
                                                            <td>
                                                                <asp:Label ID="lblShowProjCode" runat="server" Text='<%# Bind("projectCode") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Current FMS Number: </td>
                                                            <td>
                                                                <asp:Label ID="lblShowFmsNo" runat="server" Text='<%# Bind("fms_number") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>VISN: </td>
                                                            <td>
                                                                <asp:Label ID="lblShowVisn" runat="server" Text='<%# Bind("VISN") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Status: </td>
                                                            <td>
                                                                <asp:Label ID="lblShowStatus" runat="server" Text='<%# Bind("statusName") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Project Type: </td>
                                                            <td>
                                                                <asp:Label ID="lblShowProjTp" runat="server" Text='<%# Bind("projectTypeName") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Delivery Type: </td>
                                                            <td>
                                                                <asp:Label ID="lblShowDelivery" runat="server" Text='<%# Bind("deliveryMethodName") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Category Name: </td>
                                                            <td>
                                                                <asp:Label ID="lblShowCategory" runat="server" Text='<%# Bind("CategoryName") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Sub Category Name: </td>
                                                            <td>
                                                                <asp:Label ID="lblShowSubCat" runat="server" Text='<%# Bind("SubCategoryName") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Program Year: </td>
                                                            <td>
                                                                <asp:Label ID="lblShowProgYr" runat="server" Text='<%# Bind("programYear") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Region: </td>
                                                            <td>
                                                                <asp:Label ID="lblShowMouDt" runat="server" Text='<%# Bind("region")%>' /></td>

                                                        </tr>
                                                    </table>
                                                    <asp:Label ID="lblProjId" runat="server" Text='<%# Bind("project_pk") %>' Visible="False"></asp:Label>
                                                    <asp:Label ID="lblCancelDt" runat="server" Text='<%# Bind("cancelDate") %>' Visible="False" />
                                                    <asp:CheckBox ID="cbFlag" runat="server" Checked='<%# Bind("subProjectFlag") %>' Enabled="false" />
                                                    <asp:Label ID="lblMainProjId" runat="server" Text='<%# Bind("mainProject_fk") %>' Visible="False" />
                                                    <asp:Label ID="lblCreatedDt" runat="server" Text='<%# Bind("creationDate") %>' />
                                                </ItemTemplate>
                                            </asp:FormView>
                                            <asp:ObjectDataSource ID="odsrcMainInfo" runat="server" OldValuesParameterFormatString="original_{0}"
                                                SelectMethod="GetInfoForProjectDetails"
                                                TypeName="CFMISNew.FactSheetNewTableAdapters.vw_ProjectTableAdapter">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="ProjectId"
                                                        QueryStringField="project_pk" Type="Int32" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                            <br />
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnEditProj" runat="server" Text="Save Update" CssClass="submitBtn" CausesValidation="true" ValidationGroup="VGEditProj" /></td>
                                                    <td>
                                                        <asp:Label ID="lblUpdtProj" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <br />
										
<!-- begin rvb -->
    <table>
        <tr>
            <td style="width:40%">
<!-- end rvb -->										
										
                                        <div class="wideBox" style="overflow: auto; padding-left: 10px;">
                                            <asp:Label ID="lblPersonnelHdg" runat="server" Text="Personnel Info:" Font-Bold="True" Font-Size="13px"></asp:Label><br />
                                            <br />
                                            <asp:GridView ID="gvCurrentPersonnel" runat="server" Width="570px" ForeColor="#333333" GridLines="None"
                                                DataSourceID="odsrcCurrentPersonnelByProjId" OnRowDataBound="gvCurrentPersonnel_RowDataBound" AutoGenerateColumns="False" PageSize="4" EmptyDataText="No personnel selected">
                                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="projectPersonnel_pk" SortExpression="projectPersonnel_pk" Visible="False">
                                                        <EditItemTemplate></EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblProjPersonId" runat="server" Text='<%# Bind("projectPersonnel_pk") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="project_fk" HeaderText="project_fk" SortExpression="project_fk" Visible="False" />
                                                    <asp:BoundField DataField="personnel_fk" HeaderText="personnel_fk" SortExpression="personnel_fk" Visible="False" />
                                                    <asp:BoundField DataField="ManagerRole_fk" HeaderText="ManagerRole_fk" SortExpression="ManagerRole_fk" Visible="False" />
                                                    <asp:BoundField DataField="name" HeaderText="Role" SortExpression="name" ShowHeader="False">
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle CssClass="gvPadding" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="FullName" HeaderText="Personnel Name" ReadOnly="True" SortExpression="FullName" ShowHeader="False">
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle CssClass="gvPadding" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnDelete" runat="server" Text="Remove from list" OnClick="btnDelete_Click" ValidationGroup="VGDeletePersonnel" />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>

                                                </Columns>
                                                <PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White" />
                                                <EditRowStyle BackColor="#999999" />
                                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                            </asp:GridView>
                                            <asp:ObjectDataSource ID="odsrcCurrentPersonnelByProjId" runat="server" OldValuesParameterFormatString="original_{0}"
                                                SelectMethod="GetCurrentPersonnelByProjectId" TypeName="FactSheetApp.FactSheetNewTableAdapters.ProjectPersonnelTableAdapter">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                            <br />
                                            <asp:Label ID="lblPersonnelAddMsg" runat="server" Text="Select User Role For Project:" Font-Bold="True" Font-Size="13px"></asp:Label>
                                            <table style="width: 590px">
                                                <tr>
                                                    <td valign="top">                                                       
                                                        <asp:DropDownList ID="ddlManagerRoles" runat="server" AutoPostBack="True" Height="21px" Width="178px"></asp:DropDownList>
                                                        <br />
                                                        <asp:Label ID="lblErrorRole" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label></td>
                                                    <td valign="top">
                                                        <asp:DropDownList ID="ddlPersonnel" runat="server" Visible="False" Height="21px" Width="178px"></asp:DropDownList></td>
                                                    <td valign="top">
                                                        <asp:Button ID="btnAddPersonnel" runat="server" Text="Add Personnel" CssClass="submitBtn" ValidationGroup="VGAddPersonnel" /></td>
                                                </tr>
                                            </table>

                               </div>

		
<!-- begin rvb -->

    </td>

    <td style="width:40%; vertical-align:top">
         
<!--begin rvb-->

<!--end rvb-->
																																																																 
<!-- begin rvb -->					

    <div id="divPOC" runat="server" class="wideBox" style="overflow:auto; padding-left:10px;">
																 
         <asp:Label ID="lblPOCs" runat="server" Text="Point of Contact(s):" Font-Bold="True" Font-Size="13px"></asp:Label>
         <asp:Label ID="lblPOCNote" runat="server" Text=" **Use this section to add a person you cannot add to the Personnel Info section**" Font-Size="11px"></asp:Label><br /><br />																																																				  
																											  																			  
        <contenttemplate><asp:UpdatePanel ID="upPOC" runat="server">
        <contenttemplate>
            <div style="background-color:#ffffff;padding-top:0px;padding-left:0px;">
                <div id="div1" style="clear:both;padding-left:0px;" runat="server">
                    <asp:GridView ID="gvPOC" runat="server" AutoGenerateColumns="False" DataKeyNames="projectPOCID" Width="98%" OnDataBound="gvPOC_DataBound" OnRowDeleting="gvPOC_RowDeleting" 
                        DataSourceID="odsrcPOCFromSDS"  ForeColor="#333333" EmptyDataText="Point of Contact information not available" AllowPaging="True" Font-Size="12px" >
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>                            
							<asp:BoundField DataField="firstName" HeaderText="First Name" SortExpression="FirstName" >
                                                            <ItemStyle CssClass="gvPadding" Width="90px" />
                                                        </asp:BoundField>
							<asp:BoundField DataField="lastName" HeaderText="Last Name" SortExpression="LastName" >
                                                            <ItemStyle CssClass="gvPadding" Width="90px" />
                                                        </asp:BoundField>
                            <asp:BoundField DataField="name" HeaderText="Title" SortExpression="name" >
                                                            <ItemStyle CssClass="gvPadding" Width="150px" />
                                                        </asp:BoundField>
							<asp:BoundField DataField="phoneNumber" HeaderText="Phone Number" SortExpression="PhoneNumber" >
                                                            <ItemStyle CssClass="gvPadding" Width="90px" />
                                                        </asp:BoundField>
                            
                            <asp:BoundField DataField="managerRoles_FK" HeaderText="Manager Roles" SortExpression="managerRoles_FK" Visible="False" />
                            <asp:BoundField DataField="projectPOCID" HeaderText="projectPOCID" SortExpression="projectPOCID" Visible="False"/>
                            <asp:BoundField DataField="project_FK" HeaderText="project_FK" SortExpression="project_FK" Visible="False" />
                            <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnEditPOC" runat="server" Text="Edit" CommandName="Select" Font-Bold="False" OnClick="btnEditPOC_Click" Font-Size="12px" />
                                                            </ItemTemplate>
                                                            <ItemStyle CssClass="gvPadding" Width="30px" Font-Size="12px" />
                                                        </asp:TemplateField>
                            <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnDeletePOC" runat="server" Text="Delete" CommandName="Delete" Font-Bold="False" CausesValidation="False" OnClientClick="return confirm('Are you sure to delete this POC?');" Font-Size="12px" />
                                                            </ItemTemplate>
                                                            <ItemStyle CssClass="gvPadding" Width="30px" Font-Size="12px" />
                                                        </asp:TemplateField>
                        </Columns>
                    <PagerTemplate>
                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled= '<%#IIf((gvPOC.PageIndex) < 1, "false", "true")%>'
                        CommandName="Page" ForeColor="White">&lt;&lt; First</asp:LinkButton>
                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled= '<%#IIf((gvPOC.PageIndex) < 1, "false", "true")%>'
                        CommandName="Page" ForeColor="White">&lt; Prev</asp:LinkButton> 
                    [Total Pg No: <%=gvPOC.PageCount%>][Current pg: <%=gvPOC.PageIndex + 1%>]
                    <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled= '<%#IIf((gvPOC.PageCount) = (gvPOC.PageIndex + 1), "false", "true")%>'
                        CommandName="Page" ForeColor="White">Next &gt;</asp:LinkButton>
                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled= '<%#IIf((gvPOC.PageCount) = (gvPOC.PageIndex + 1), "false", "true")%>'
                        CommandName="Page" ForeColor="White">Last &gt;&gt;</asp:LinkButton><br />
                         <asp:Label ID="lblGoTo" runat="server" Text="Go to Pg:"></asp:Label>    
                    <asp:DropDownList ID="ddlPOCPaging" runat="server" AutoPostBack="True" 
                        Height="21px" OnSelectedIndexChanged="ddlPOCPaging_SelectedIndexChanged" 
                        Width="45px">
                    </asp:DropDownList>
                    <asp:Label ID="lblCurrentPg" runat="server"></asp:Label>    
                </PagerTemplate>
                        <PagerStyle HorizontalAlign="Center"  BackColor="#284775" ForeColor="White" />
                        <EditRowStyle BackColor="#999999" /><FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" /><RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" /><SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>

                    <asp:ObjectDataSource ID="odsrcPOCFromSDS" runat="server" DeleteMethod="DeletePOC" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetPOCByProjectId" TypeName="CFMISNew.FactSheetDataSetTableAdapters.projectPOCTableAdapter" UpdateMethod="Update">
                        <DeleteParameters>
                                <asp:QueryStringParameter Name="projectPOCID" QueryStringField="projectPOCID" Type="Int32" />
                        </DeleteParameters>
                       <InsertParameters>
                            <asp:Parameter Name="firstName" Type="String" />
                            <asp:Parameter Name="lastName" Type="String" />
                            <asp:Parameter Name="managerRoles_FK" Type="Int32" />
                            <asp:Parameter Name="phoneNumber" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="firstName" Type="String" />
                            <asp:Parameter Name="lastName" Type="String" />
                            <asp:Parameter Name="managerRoles_FK" Type="Int32" />
                            <asp:Parameter Name="phoneNumber" Type="String" />
                            <asp:Parameter Name="Original_projectPOCID" Type="Int32" />
                        </UpdateParameters>
                        <SelectParameters>
                            <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                        </SelectParameters>
                    </asp:ObjectDataSource>

																										 
                    <table>
					   <tr>
                           <td>
                             <asp:Button ID="btnAddPOCNew" runat="server" Text="Add Point of Contact" Font-Bold="True" CausesValidation="False" />                           
                           </td>
                           <td>															
                             <asp:Label ID="lblAddMsgPOC" runat="server" Font-Bold="True" ForeColor="#009900"></asp:Label>																																						  
                           </td>
					    </tr>
					</table>
																												
																				  																																																																				 																																											 
                    <asp:Panel ID="pnlAddPOCNew" runat="server"  CssClass="modalPopup" Width="550px" BackColor="#E6EDF4" style="display:none">
                        <asp:UpdatePanel ID="mupAddPOCNew" runat="server">
                            <ContentTemplate>
                                <asp:FormView ID="fvAddPOCNew" runat="server" DataKeyNames="projectPOCID" DataSourceID="odsrcPOCNew" DefaultMode="Insert" Width="528px">
                                    <EditItemTemplate></EditItemTemplate>
                                    <InsertItemTemplate><br />
                                        <asp:Label ID="lblAddPOCHdng" runat="server" Text="Enter Point of Contact Information: " Font-Bold="True"></asp:Label><br /><br />
                                        <table style="width: 99%">      
                                            <tr><td class="auto-style78">First Name: </td>
                                                <td class="auto-style77" colspan="2">
                                                    <asp:TextBox ID="txtfirstName" runat="server" Text='<%# Bind("firstName") %>' Width="98%" />
												</td>
											</tr>
                                            <tr><td class="auto-style78">Last Name: </td>
																					   
                                                <td class="auto-style77" colspan="2">
                                                    <asp:TextBox ID="txtlastName" runat="server" Text='<%# Bind("lastName") %>' Width="98%" />
												</td>
											</tr>
                                            <tr><td class="auto-style78">Title: </td>
                                                <td class="auto-style77">
                                                    <asp:DropDownList ID="ddlManagerRole" runat="server" DataSourceID="sdsrcManagerRole" DataTextField="name" DataValueField="lkmanagerRoles_pk" 
                                    Height="21px" Width="170px" SelectedValue='<%# Bind("lkmanagerRoles_pk") %>' AppendDataBoundItems="True">
                                                        <asp:ListItem Value="" Text="-Select-"></asp:ListItem></asp:DropDownList></td>
                                                <td>&nbsp;</td></tr>
                                            <tr><td class="auto-style78">Phone Number: </td>
                                                <td class="auto-style77" colspan="2">
																 
                                                    <asp:TextBox ID="txtphoneNumber" runat="server" Text='<%# Bind("phoneNumber") %>' Width="98%" />
												</td>
											</tr>
                                        </table>
                                        <asp:Label ID="lblmanagerRoles_FK" runat="server" Text='<%# Bind("managerRoles_FK") %>'></asp:Label>
                                        <asp:Label ID="lblProjId" runat="server" Text='<%# Bind("project_FK") %>'></asp:Label>
                                        <asp:SqlDataSource ID="sdsrcManagerRole" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                                            SelectCommand="SELECT * FROM [lkManagerRoles] WHERE Code <> 'EE' order by Name "></asp:SqlDataSource></InsertItemTemplate>
                                    <ItemTemplate></ItemTemplate>

                                </asp:FormView>
																			  																																																								 															 
                                <asp:ObjectDataSource ID="odsrcPOCNew" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetPOCByprojectIdPOCID" 
                                     TypeName="CFMISNew.FactSheetDataSetTableAdapters.projectPOCTableAdapter">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvPOC" Name="projectPOCID" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>

                            </ContentTemplate></asp:UpdatePanel>
                        <table align="center" style="width: 112px">
                            <tr>
                            <td align="center">
                            <asp:LinkButton ID="lbAddPOCNew" runat="server"  Text="Save" CommandName="Insert" Font-Bold="True" ValidationGroup="POC"/>
                            </td>
                            <td align="center">
                                <asp:LinkButton ID="lbCancelAddPOCNew" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" Font-Bold="True"/></td>
                            </tr>
                        </table>
																					  																														
                    </asp:Panel>

                    <asp:Button id="btnInertPOCNew" runat="server" style="display:none;"/>
                    <cc1:ModalPopupExtender ID="mpeAddPOCNew" runat="server" DropShadow ="True" X="300" Y="250"
	cancelcontrolid="lbCancelAddPOCNew" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupAddPOCNew"
	targetcontrolid="btnInertPOCNew" popupcontrolid="pnlAddPOCNew"  Enabled="True" DynamicServicePath="">
                    </cc1:ModalPopupExtender>
																															   																				   																					  
                    <asp:Panel ID="pnlEditPOC" runat="server"  CssClass="modalPopup" Width="550px" BackColor="#E6EDF4" style="display:none">
                        <asp:UpdatePanel ID="mupEditPOC" runat="server">
                            <ContentTemplate>
                                <asp:FormView ID="fvEditPOC" runat="server" DataKeyNames="projectPOCID" DataSourceID="odsrcEditPOC" 
                                    DefaultMode="Edit" Width="528px">
                                    <EditItemTemplate><br />
                                        <asp:Label ID="lblUpdtHdgMsgPOC" runat="server" Text="Update Point of Contact Information: " Font-Bold="True"></asp:Label><br />
                                        <br />
                                        <table style="width: 99%">
                                            <tr><td class="auto-style78">First Name: </td>
                                                <td class="auto-style77" colspan="2">
                                                    <asp:TextBox ID="txtfirstNameEdit" runat="server" Text='<%# Bind("firstName") %>' Height="20px" Width="98%" />
											    </td>
											</tr>
                                            <tr><td class="auto-style78">Last Name: </td>
                                                <td class="auto-style77" colspan="2">
                                                    <asp:TextBox ID="txtlastNameEdit" runat="server" Text='<%# Bind("lastName") %>' Height="20px" Width="98%" />
												</td>
                                            </tr>

                                            <tr><td class="auto-style78">Approval Type: </td>
                                                <td class="auto-style77">
                                                    <asp:DropDownList ID="ddlManagerRoleEdit" runat="server" DataSourceID="sdsrcManagerRoleEdit" DataTextField="name" DataValueField="lkmanagerRoles_pk" 
														Height="21px" Width="90%" SelectedValue='<%# Bind("lkmanagerRoles_pk") %>' AppendDataBoundItems="True">
                                                        <asp:ListItem Value="" Text="-Select-">
                                                        </asp:ListItem>
                                                    </asp:DropDownList>
												</td>
                                                <td>&nbsp;</td>
											</tr>
                                            <tr><td class="auto-style78">Phone Number: </td>
                                                <td class="auto-style77" colspan="2">
                                                    <asp:TextBox ID="txtphoneNumberEdit" runat="server" Text='<%# Bind("phoneNumber") %>' Height="20px" Width="98%" /> 
												</td>
                                            </tr>
									</table>
                                    <asp:Label ID="lblPOCId" runat="server" Text='<%# Bind("projectPOCID") %>' Visible="False"></asp:Label>
                                    <asp:Label ID="lblproject_FK" runat="server" Text='<%# Bind("project_FK") %>' Visible="False"></asp:Label>

                                    <asp:SqlDataSource ID="sdsrcManagerRoleEdit" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                                    SelectCommand="SELECT * FROM [lkManagerRoles] WHERE Code <> 'EE' order by Name"></asp:SqlDataSource></EditItemTemplate>
                                    <InsertItemTemplate></InsertItemTemplate>
                                    <ItemTemplate></ItemTemplate></asp:FormView>

                                <asp:ObjectDataSource ID="odsrcEditPOC" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetPOCByprojectIdPOCID" 
                                     TypeName="CFMISNew.FactSheetDataSetTableAdapters.projectPOCTableAdapter">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvPOC" Name="projectPOCID" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                                            
                            </ContentTemplate>
                        </asp:UpdatePanel>
   

                        <table align="center" style="width: 124px"><tr><td align="center">
                            <asp:LinkButton ID="lbEditPOC" runat="server"  Text="Save" CommandName="Update" Font-Bold="True" ValidationGroup="POCEdt" Font-Size="12px" /></td>
                            <td align="center">
                                <asp:LinkButton ID="lbCnclEditPOC" runat="server" CausesValidation="False" Text="Cancel" Font-Bold="True" Font-Size="12px"/></td></tr>
	   
                        </table>

                    </asp:Panel>
    
                   <asp:Button id="btnUpdtPOC" runat="server" style="display:none;"/>
                    <cc1:ModalPopupExtender ID="mpeEditPOC" runat="server" DropShadow ="True"  X="300" Y="250" 
                CancelControlID="lbCnclEditPOC" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupEditPOC" 
                targetcontrolid="btnUpdtPOC" popupcontrolid="pnlEditPOC"  Enabled="True" DynamicServicePath="">
                    </cc1:ModalPopupExtender>

                </div>
            </div>
           </contenttemplate>
          </asp:UpdatePanel>
        </contenttemplate>            
    </div>
																																																				
<!-- end rvb -->


     </td>
   </tr>
</table>
												  																	 
<!-- end rvb  -->
				
                                    </div>			  
                                </ContentTemplate>			   																								  			
                            </asp:UpdatePanel>
                        </ContentTemplate>
                    </cc1:TabPanel>
                    <cc1:TabPanel ID="tpScopeStatusComment" runat="server">
                        <HeaderTemplate>Scope/Comments</HeaderTemplate>
                        <ContentTemplate>
                            <asp:UpdatePanel ID="tab2" runat="server">
                                <ContentTemplate>
                                    <div style="background-color: #e6eeff; padding-top: 15px; padding-bottom: 15px; padding-left: 10px;">
                                        <div class="wideBox" style="overflow: auto; padding-left: 10px;">
                                            <p align="right" style="width: 712px">
                                                <asp:Label ID="lblUpdtMsg" runat="server" ForeColor="#009900"></asp:Label>
                                            </p>
                                            <asp:FormView ID="fvEditScope" runat="server" DataKeyNames="Comment_PK" OnDataBound="fvEditScope_DataBound"
                                                DataSourceID="odsrcScopeDetails"
                                                DefaultMode="Edit" Width="98%">
                                                <EditItemTemplate>
                                                    <asp:Label ID="lblEditScpHdng" runat="server" Text="Edit Scope Information: " Font-Bold="True"></asp:Label>
                                                    <br />
                                                    <table style="width: 99%">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtScope" runat="server" Text='<%# Bind("Comment")%>' TextMode="MultiLine" Height="90px" Width="98%" CssClass="txtPadding" onfocus="javascipt:this.style.height = '250px'" /></td>
                                                        </tr>
                                                    </table>
                                                    <asp:RequiredFieldValidator ID="rfvEditScope" runat="server" ControlToValidate="txtScope" ErrorMessage="Please enter some scope. " ForeColor="Red" ValidationGroup="Scope"></asp:RequiredFieldValidator><asp:Label ID="lblScopeId" runat="server" Text='<%# Eval("Comment_PK") %>' Visible="false"></asp:Label><asp:Label ID="lblProjNo" runat="server" Text='<%# Eval("Project_FK")%>' Visible="False" />
                                                    <table align="center" style="width: 272px">
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Button ID="btnUpdtScope" runat="server" Text="Save" Width="100px" CssClass="saveButton" ValidationGroup="Scope"
                                                                    OnClick="btnUpdtScope_Click" /></td>
                                                            <td align="right">
                                                                <asp:Button ID="btnCnclEditScope" runat="server" Text="Reset" Width="100px" CssClass="saveButton"
                                                                    OnClick="btnCnclEditScope_Click" CausesValidation="False" /></td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:Label ID="lblAddScpHdng" runat="server" Text="Add Scope Information: " Font-Bold="True"></asp:Label>
                                                    <br />
                                                    <table style="width: 99%">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtAddScope" runat="server" Text='<%# Bind("Comment")%>' Height="90px" TextMode="MultiLine" Width="98%" CssClass="txtPadding" onfocus="javascipt:this.style.height = '250px'" />
                                                                <br />
                                                                <asp:RequiredFieldValidator ID="rfvAddScope" runat="server" ControlToValidate="txtAddScope" ErrorMessage="Please enter some scope." ForeColor="Red" ValidationGroup="Scope"></asp:RequiredFieldValidator>

                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table align="center" style="width: 272px" id="tblAddScp">
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Button ID="btnAddNewScope" runat="server" Text="Save" Width="100px" CssClass="saveButton" OnClick="btnAddNewScope_Click" ValidationGroup="Scope" />
                                                            </td>
                                                            <td align="right">
                                                                <asp:Button ID="btnCnclAddScope" runat="server" Text="Reset" Width="100px" CssClass="saveButton" OnClick="btnCnclAddScope_Click" /></td>
                                                        </tr>
                                                    </table>
                                                </InsertItemTemplate>


                                                <ItemTemplate>
                                                    <b style="text-decoration: underline">Scope Information:</b><br />
                                                    <br />
                                                    <asp:Label ID="lblShowScope" runat="server" Text='<%# Bind("Comment") %>' /><br />
                                                    <asp:Label ID="lblShowCommentPk" runat="server" Text='<%# Eval("Comment_PK") %>' Visible="False" /><br />
                                                    <asp:Label ID="lblShowProjId" runat="server" Text='<%# Bind("Project_FK") %>' Visible="False" />
                                                </ItemTemplate>
                                            </asp:FormView>

                                            <asp:ObjectDataSource ID="odsrcScopeDetails" runat="server" DeleteMethod="Delete"
                                                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetScopeByProjectId"
                                                TypeName="FactSheetApp.FactSheetNewTableAdapters.CommentScopeTableAdapter" UpdateMethod="Update">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="Original_Comment_PK" Type="Int32" />
                                                </DeleteParameters>
                                                <InsertParameters>
                                                    <asp:Parameter Name="Comment" Type="String" />
                                                    <asp:Parameter Name="CommentType_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedBy_FK" Type="Int32" />
                                                    <asp:Parameter Name="ModifyBy_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedDate" Type="DateTime" />
                                                    <asp:Parameter Name="modifyDate" Type="DateTime" />
                                                    <asp:Parameter Name="Project_FK" Type="Int32" />
                                                </InsertParameters>
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                                                </SelectParameters>
                                                <UpdateParameters>
                                                    <asp:Parameter Name="Comment" Type="String" />
                                                    <asp:Parameter Name="CommentType_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedBy_FK" Type="Int32" />
                                                    <asp:Parameter Name="ModifyBy_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedDate" Type="DateTime" />
                                                    <asp:Parameter Name="modifyDate" Type="DateTime" />
                                                    <asp:Parameter Name="Project_FK" Type="Int32" />
                                                    <asp:Parameter Name="Original_Comment_PK" Type="Int32" />
                                                </UpdateParameters>
                                            </asp:ObjectDataSource>
                                            <asp:ObjectDataSource ID="odsrcExternalScopeDetails" runat="server" DeleteMethod="Delete"
                                                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetScopeByProjectId"
                                                TypeName="CFMISNew.FactSheetDataSetTableAdapters.ExternalCommentScopeTableAdapter" UpdateMethod="Update">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="Original_Comment_PK" Type="Int32" />
                                                </DeleteParameters>
                                                <InsertParameters>
                                                    <asp:Parameter Name="Comment" Type="String" />
                                                    <asp:Parameter Name="CommentType_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedBy_FK" Type="Int32" />
                                                    <asp:Parameter Name="ModifyBy_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedDate" Type="DateTime" />
                                                    <asp:Parameter Name="modifyDate" Type="DateTime" />
                                                    <asp:Parameter Name="Project_FK" Type="Int32" />
                                                </InsertParameters>
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                                                </SelectParameters>
                                                <UpdateParameters>
                                                    <asp:Parameter Name="Comment" Type="String" />
                                                    <asp:Parameter Name="CommentType_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedBy_FK" Type="Int32" />
                                                    <asp:Parameter Name="ModifyBy_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedDate" Type="DateTime" />
                                                    <asp:Parameter Name="modifyDate" Type="DateTime" />
                                                    <asp:Parameter Name="Project_FK" Type="Int32" />
                                                    <asp:Parameter Name="Original_Comment_PK" Type="Int32" />
                                                </UpdateParameters>
                                            </asp:ObjectDataSource>
                                            <br />
                                        </div>

                                        <div class="wideBox" style="overflow: auto; padding-left: 10px;">
                                            <asp:FormView ID="fvAddEditStatus" runat="server" DataKeyNames="Comment_PK" Width="98%"
                                                DefaultMode="Edit" DataSourceID="odsrcStatusInfo" OnDataBound="fvAddEditStatus_DataBound">
                                                <EditItemTemplate>
                                                    <asp:Label ID="lblEditStatusHedng" runat="server" Text="Edit Current Status info: " Font-Bold="True"></asp:Label>
                                                    <br />
                                                    <table style="width: 99%">
                                                        <tr>
                                                            <td>
                                                                <asp:DropDownList ID="ddlEditStage" runat="server" DataSourceID="odsrcStageTpToEditStatus"
                                                                    DataTextField="stageCode" DataValueField="stage_PK"
                                                                    SelectedValue='<%# Bind("StageType_FK") %>'>
                                                                </asp:DropDownList>
                                                                <asp:ObjectDataSource ID="odsrcStageTpToEditStatus" runat="server" DeleteMethod="Delete"
                                                                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}"
                                                                    SelectMethod="GetStageTypeList" TypeName="FactSheetApp.FactSheetNewTableAdapters.lkStageTypeTableAdapter"
                                                                    UpdateMethod="Update">
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
                                                                <asp:CompareValidator ID="cvStageTypeEdit" runat="server" ErrorMessage="Select a Type" ControlToValidate="ddlEditStage"
                                                                    Type="Integer" ValueToCompare="0" Operator="NotEqual" ForeColor="Red" ValidationGroup="EditStatus"></asp:CompareValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtEditStatus" runat="server" Text='<%# Bind("Comment")%>'
                                                                    Height="90px" TextMode="MultiLine" Width="98%" CssClass="txtPadding" onfocus="javascipt:this.style.height = '250px'"></asp:TextBox>
                                                                <br />
                                                                <asp:RequiredFieldValidator ID="rfvStatusEdit" runat="server" ErrorMessage="Please enter status." ControlToValidate="txtEditStatus"
                                                                    ForeColor="Red" ValidationGroup="EditStatus"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <asp:Label ID="lblStatusID" runat="server" Text='<%# Bind("Comment_PK")%>' Visible="False" />
                                                    <asp:Label ID="lblModUser" runat="server" Text='<%# Bind("ModifyBy")%>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblProjId" runat="server" Text='<%# Bind("Project_FK")%>' Visible="False"></asp:Label>
                                                    <asp:Label ID="lblUpdtDate" runat="server" Text='<%# Bind("modifyDate")%>' Visible="false"></asp:Label>

                                                    <table align="center" style="width: 272px">
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Button ID="btnEditStatus" runat="server" Text="Save" Width="100px" CssClass="saveButton" OnClick="btnEditStatus_Click" ValidationGroup="EditStatus" /></td>
                                                            <td align="right">
                                                                <asp:Button ID="btnCnclEditStatus" runat="server" Text="Reset" Width="100px" CssClass="saveButton" CausesValidation="false" OnClick="btnCnclEditStatus_Click" /></td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:Label ID="lblAddStatus" runat="server" Text="Add Current Status Info:" Font-Bold="True"></asp:Label>
                                                    <asp:Image ID="iInformationAddStatus" runat="server" ImageUrl="~/Images/InformationIcon.png" onmouseover="$find('behaviorIDofPopopAddStatus').showPopup()" 
                                                         onmouseout="$find('behaviorIDofPopopAddStatus').hidePopup();" Height="21px" Width="21px" />       
														   
                                                     <cc1:popupcontrolextender runat="server" ID="pceGropAddStatus" 
                                                          BehaviorID="behaviorIDofPopopAddStatus" TargetControlID="iInformationAddStatus" 
                                                          PopupControlID="pnlPopUpAddStatus" Position="Right"></cc1:popupcontrolextender>
                                                          <asp:Panel ID="pnlPopUpAddStatus" runat="server" BorderStyle="Solid" BorderWidth="1px" 
                                                             HorizontalAlign="Left" Direction="NotSet"  style="display:none;" CssClass="HowTo" Width="400px">
                                                             Brief, descriptive status of projects last 30 days events <br />
                                                      </asp:Panel>
													
                                                    <br />
                                                    <table style="width: 99%">
                                                        <tr>
                                                            <td>
                                                                <asp:DropDownList ID="ddlStage" runat="server" AppendDataBoundItems="True" DataSourceID="odsrcStageTpToAddStatus"
                                                                    DataTextField="stageCode" DataValueField="stage_PK" SelectedValue='<%# Bind("StageType_FK") %>' Height="17px" Width="105px">
                                                                    <asp:ListItem Value="0" Text="-Select-"></asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:ObjectDataSource ID="odsrcStageTpToAddStatus" runat="server" DeleteMethod="Delete"
                                                                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetStageTypeList"
                                                                    TypeName="FactSheetApp.FactSheetNewTableAdapters.lkStageTypeTableAdapter" UpdateMethod="Update">
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
                                                                <asp:CompareValidator ID="cvStageType" runat="server" ErrorMessage="Select a Type" ControlToValidate="ddlStage"
                                                                    Type="Integer" ValueToCompare="0" Operator="NotEqual" ForeColor="Red" ValidationGroup="AddStatus"></asp:CompareValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtAddStatus" runat="server" Text='<%# Bind("Comment") %>' TextMode="MultiLine" Width="98%" Height="90px" CssClass="txtPadding" onfocus="javascipt:this.style.height = '250px'" />
                                                                <br />
                                                                <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ErrorMessage="Please enter status." ControlToValidate="txtAddStatus"
                                                                    ForeColor="Red" ValidationGroup="AddStatus"></asp:RequiredFieldValidator></td>
                                                        </tr>
                                                    </table>
                                                    <table align="center" style="width: 272px">
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Button ID="btnAddStatus" runat="server" Text="Save" Width="100px" CssClass="saveButton"
                                                                    OnClick="btnAddStatus_Click" ValidationGroup="AddStatus" /></td>
                                                            <td align="right">
                                                                <asp:Button ID="btnCnclAddStatus" runat="server" Text="Reset" Width="100px" CssClass="saveButton"
                                                                    CausesValidation="false" OnClick="btnCnclAddStatus_Click" /></td>
                                                        </tr>
                                                    </table>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <b style="text-decoration: underline">Current Status:</b><br />
                                                    <br />
                                                    <asp:Label ID="lblShowStageCode" runat="server" Text='<%# Bind("stageCode") %>' />
                                                    &nbsp; - &nbsp;
			<asp:Label ID="lblShowStatus" runat="server" Text='<%# Bind("Comment") %>' /><br />
                                                    <asp:Label ID="lblShowStatusId" runat="server" Text='<%# Eval("Comment_PK") %>' Visible="False" />
                                                    <asp:Label ID="lblShowStageId" runat="server" Text='<%# Bind("StageType_FK") %>' Visible="False" />
                                                    <asp:Label ID="lblShowAddUser" runat="server" Text='<%# Bind("CreatedBy") %>' Visible="False" />
                                                    <asp:Label ID="lblShowModUser" runat="server" Text='<%# Bind("ModifyBy") %>' Visible="False" />
                                                    <asp:Label ID="lblShowModifyDt" runat="server" Text='<%# Bind("modifyDate") %>' Visible="False" />
                                                    <asp:Label ID="lblShowProjectId" runat="server" Text='<%# Bind("Project_FK") %>' Visible="False" /><br />

                                                </ItemTemplate>
                                            </asp:FormView>
                                            <asp:ObjectDataSource ID="odsrcStatusInfo" runat="server" OldValuesParameterFormatString="original_{0}"
                                                SelectMethod="GetStatusInfo" TypeName="FactSheetApp.FactSheetNewTableAdapters.CommentStatusTableAdapter">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                            <br />
                                        </div>

                                        <div class="wideBox" style="overflow: auto; padding-left: 10px;">
                                            <asp:FormView ID="fvAddEditWkCom" runat="server" DataKeyNames="Comment_PK"
                                                DataSourceID="odsrcWeeklyComment" OnDataBound="fvAddEditWkCom_DataBound"
                                                DefaultMode="Edit" Width="98%">
                                                <EditItemTemplate>
                                                    <asp:Label ID="lblEditComntHdg" runat="server" Text="Edit Comment: " Font-Bold="True"></asp:Label>

                                                    <br />
                                                    <table style="width: 99%">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtEdtProjCom" runat="server" Text='<%# Bind("Comment")%>' Height="90px" TextMode="MultiLine" Width="98%" CssClass="txtPadding" onfocus="javascipt:this.style.height = '250px'" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <asp:Label ID="lblEdtProjId" runat="server" Text='<%# Eval("Project_FK")%>' Visible="False" />
                                                    <asp:Label ID="lblEdtComPk" runat="server" Text='<%# Eval("Comment_PK")%>' Visible="False" />
                                                    <asp:Label ID="lblEdtWkComUsr" runat="server" Text='<%# Bind("ModifyBy")%>' Visible="False"></asp:Label>
                                                    <table align="center" style="width: 272px">
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Button ID="btnUpdtWkCom" runat="server" Text="Save" Width="100px" CssClass="saveButton"
                                                                    OnClick="btnUpdtWkCom_Click" ValidationGroup="EdtProjComment" /></td>
                                                            <td align="right">
                                                                <asp:Button ID="btnCnclEdtWkCom" runat="server" Text="Reset" Width="100px" CssClass="saveButton"
                                                                    OnClick="btnCnclEdtWkCom_Click" /></td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:Label ID="lblAddComntHdgn" runat="server" Text="Add Comment: " Font-Bold="True"></asp:Label>

                                                    <table style="width: 99%">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtAddWkComNote" runat="server" Text='<%# Bind("Comment") %>' Height="90px" TextMode="MultiLine" Width="98%" CssClass="txtPadding" onfocus="javascipt:this.style.height = '250px'" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table align="center" style="width: 272px">
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Button ID="btnAddNewWkCom" runat="server" Text="Save" Width="100px" CssClass="saveButton" OnClick="btnAddNewWkCom_Click"
                                                                    ValidationGroup="AddProjComment" /></td>
                                                            <td align="right">
                                                                <asp:Button ID="btnCnclAddWkCom" runat="server" Text="Reset" Width="100px" CssClass="saveButton" OnClick="btnCnclAddWkCom_Click" /></td>
                                                        </tr>
                                                    </table>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <b style="text-decoration: underline">Comments:</b><br />
                                                    <br />
                                                    <asp:Label ID="note_textLabel" runat="server" Text='<%# Bind("Comment")%>' /><br />
                                                    <asp:Label ID="project_pkLabel" runat="server" Text='<%# Eval("Project_FK")%>' Visible="False" />
                                                    <asp:Label ID="note_pkLabel" runat="server" Text='<%# Eval("Comment_PK")%>' Visible="False" />
                                                    <asp:Label ID="modification_user_fkLabel" runat="server" Text='<%# Bind("ModifyBy")%>' Visible="False" />
                                                </ItemTemplate>
                                            </asp:FormView>

                                            <asp:FormView ID="fvAddEditExternalWkCom" runat="server" DataKeyNames="Comment_PK"
                                                DataSourceID="odsrcWeeklyExternalComment" OnDataBound="fvAddEditExternalWkCom_DataBound"
                                                DefaultMode="Edit" Width="98%">
                                                <EditItemTemplate>

                                                    <asp:Label ID="lblEditProjectHealth" runat="server" Text="Edit Project Health: " Font-Bold="True"></asp:Label>
                                                    <asp:Image ID="iInformationEditProjectHealth" runat="server" ImageUrl="~/Images/InformationIcon.png" onmouseover="$find('behaviorIDofPopopEditProjectHealth').showPopup()"
                                                        onmouseout="$find('behaviorIDofPopopEditProjectHealth').hidePopup();" Height="21px" Width="21px" />

                                                    <cc1:PopupControlExtender runat="server" ID="pceProjectHealth"
                                                        BehaviorID="behaviorIDofPopopEditProjectHealth" TargetControlID="iInformationEditProjectHealth"
                                                        PopupControlID="pnlPopUpEditProjectHealth" Position="Right">
                                                    </cc1:PopupControlExtender>
                                                    <asp:Panel ID="pnlPopUpEditProjectHealth" runat="server" BorderStyle="Solid" BorderWidth="1px"
                                                        HorizontalAlign="Left" Direction="NotSet" Style="display: none;" CssClass="HowTo" Width="400px">
                                                        -	Red: Project (Scope/Schedule/Budget) at High Risk
														<br />
                                                        -	Yellow: Project (Scope/Schedule/Budget) at Moderate Risk
														<br />
                                                        -	Green: Project (Scope/Schedule/Budget) at Low Risk
														<br />
                                                    </asp:Panel>

                                                    <br />
                                                    <table style="width: 99%">
                                                        <tr>
                                                            <td>
                                                                <asp:DropDownList ID="ddlEditRiskType" SelectedValue='<%# Bind("RiskType") %>' runat="server" onchange="SetDropDownListColor(this);" Style="width: 140px;">
                                                                    <asp:ListItem style="background-color: Green !important;" Value="3">Green</asp:ListItem>
                                                                    <asp:ListItem style="background-color: Yellow !important;" Value="2">Yellow</asp:ListItem>
                                                                    <asp:ListItem style="background-color: Red !important;" Value="1">Red</asp:ListItem>
                                                                </asp:DropDownList>

                                                            </td>
                                                        </tr>
                                                    </table>

                                                    <asp:Label ID="lblEditExternalComntHdg" runat="server" Text="Edit Leadership Highlights: (limit up to 675 chars) " Font-Bold="True"></asp:Label>
                                                    <asp:Image ID="iInformationExternalCommentEdt" runat="server" ImageUrl="~/Images/InformationIcon.png" onmouseover="$find('behaviorIDofPopopExternalComment').showPopup()"
                                                        onmouseout="$find('behaviorIDofPopopExternalComment').hidePopup();" Height="21px" Width="21px" />
                                                    <cc1:PopupControlExtender runat="server" ID="pceGrop"
                                                        BehaviorID="behaviorIDofPopopExternalComment" TargetControlID="iInformationExternalCommentEdt"
                                                        PopupControlID="pnlPopUpExternalCommentEdt" Position="Right">
                                                    </cc1:PopupControlExtender>
                                                    <asp:Panel ID="pnlPopUpExternalCommentEdt" runat="server" BorderStyle="Solid" BorderWidth="1px"
                                                        HorizontalAlign="Left" Direction="NotSet" Style="display: none;" CssClass="HowTo" Width="400px">
                                                        Concisely explain the Risk assessment that correlates with the color selected, the impacts or potential impacts and way  forward (who’s accountable and timeline).   For “Green Projects” tell the good news story (Cost, Schedule, Quality, what do we want leadership to know.  Provide Risk Assessment in the following format:<br />
                                                        <br />
                                                        -	Bottom Line Up Front (BLUF): What is the issue (Scope/Schedule/Budget/Political implication, etc.)<br />
                                                        -	DISCUSSION: Provide any background or suggest a brief to cover material in depth and or any actions taken or planned to address/mitigate identified risk
														<br />
                                                        -	RECOMMENDATION: What you want leadership to do (For Information Only; receive a briefing; make a decision etc.)
														<br />

                                                    </asp:Panel>

                                                    <br />
                                                    <table style="width: 99%">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtEdtExternalProjCom" runat="server" Text='<%# Bind("Comment")%>' Height="90px" TextMode="MultiLine" Width="98%" CssClass="txtPadding" onfocus="javascipt:this.style.height = '250px'" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <asp:Label ID="lblEdtExternalProjId" runat="server" Text='<%# Eval("Project_FK")%>' Visible="False" />
                                                    <asp:Label ID="lblEdtExternalComPk" runat="server" Text='<%# Eval("Comment_PK")%>' Visible="False" />
                                                    <asp:Label ID="lblEdtExternalWkComUsr" runat="server" Text='<%# Bind("ModifyBy")%>' Visible="False" />
                                                    <asp:Label ID="lblEdtCreatedDate" runat="server" Text='<%# Bind("CreatedDate")%>' Visible="False" />
                                                    <table align="center" style="width: 272px">
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Button ID="btnUpdtExternalWkCom" runat="server" Text="Save" Width="100px" CssClass="saveButton"
                                                                    OnClick="btnUpdtExternalWkCom_Click" ValidationGroup="EdtProjExternalComment" /></td>
                                                            <td align="right">
                                                                <asp:Button ID="btnCnclEdtExternalWkCom" runat="server" Text="Reset" Width="100px" CssClass="saveButton"
                                                                    OnClick="btnCnclEdtExternalWkCom_Click" /></td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:Label ID="lblAddProjectHealth" runat="server" Text="Add Project Health:" Font-Bold="True"></asp:Label>
                                                    <asp:Image ID="iInformationProjectHealth" runat="server" ImageUrl="~/Images/InformationIcon.png" onmouseover="$find('behaviorIDofPopopProjectHealth').showPopup()"
                                                        onmouseout="$find('behaviorIDofPopopProjectHealth').hidePopup();" Height="21px" Width="21px" />

                                                    <cc1:PopupControlExtender runat="server" ID="pceGropProjectHealth"
                                                        BehaviorID="behaviorIDofPopopProjectHealth" TargetControlID="iInformationProjectHealth"
                                                        PopupControlID="pnlPopUpProjectHealth" Position="Right">
                                                    </cc1:PopupControlExtender>
                                                    <asp:Panel ID="pnlPopUpProjectHealth" runat="server" BorderStyle="Solid" BorderWidth="1px"
                                                        HorizontalAlign="Left" Direction="NotSet" Style="display: none;" CssClass="HowTo" Width="400px">
                                                        -	Red: Project (Scope/Schedule/Budget) at High Risk
														<br />
                                                        -	Yellow: Project (Scope/Schedule/Budget) at Moderate Risk
														<br />
                                                        -	Green: Project (Scope/Schedule/Budget) at Low Risk
														<br />
                                                    </asp:Panel>
                                                    <br />
                                                    <table style="width: 99%">
                                                        <tr>
                                                            <td>
                                                                <asp:DropDownList ID="ddlAddRiskType" SelectedValue='<%# Bind("RiskType") %>' runat="server" onchange="SetDropDownListColor(this);" Style="width: 140px;">
                                                                    <asp:ListItem style="background-color: Green !important;" Value="3">Green</asp:ListItem>
                                                                    <asp:ListItem style="background-color: Yellow !important;" Value="2">Yellow</asp:ListItem>
                                                                    <asp:ListItem style="background-color: Red !important;" Value="1">Red</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>

                                                    </table>

                                                    <asp:Label ID="lblAddExternalComntHdgn" runat="server" Text="Add Leadership Highlights: (limit up to 675 chars) " Font-Bold="True"></asp:Label>
                                                    <asp:Image ID="iInformationExternalCommentAdd" runat="server" ImageUrl="~/Images/InformationIcon.png" onmouseover="$find('behaviorIDofPopopExternalComment').showPopup()"
                                                        onmouseout="$find('behaviorIDofPopopExternalComment').hidePopup();" Height="21px" Width="21px" />

                                                    <cc1:PopupControlExtender runat="server" ID="pceGropExternalComment"
                                                        BehaviorID="behaviorIDofPopopExternalComment" TargetControlID="iInformationExternalCommentAdd"
                                                        PopupControlID="pnlPopUpExternalCommentAdd" Position="Right">
                                                    </cc1:PopupControlExtender>
                                                    <asp:Panel ID="pnlPopUpExternalCommentAdd" runat="server" BorderStyle="Solid" BorderWidth="1px"
                                                        HorizontalAlign="Left" Direction="NotSet" Style="display: none;" CssClass="HowTo" Width="400px">
                                                        Concisely explain the Risk assessment that correlates with the color selected, the impacts or potential impacts and way  forward (who’s accountable and timeline).   For “Green Projects” tell the good news story (Cost, Schedule, Quality, what do we want leadership to know.  Provide Risk Assessment in the following format:<br />
                                                        <br />
                                                        -	Bottom Line Up Front (BLUF): What is the issue (Scope/Schedule/Budget/Political implication, etc.)<br />
                                                        -	DISCUSSION: Provide any background or suggest a brief to cover material in depth and or any actions taken r planned to address/mitigate identified risk
														<br />
                                                        -	RECOMMENDATION: What you want leadership to do (For Information Only; receive a briefing; make a decision etc.)
														<br />
                                                    </asp:Panel>

                                                    <br />
                                                    <table style="width: 99%">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtAddExternalWkComNote" runat="server" Text='<%# Bind("Comment") %>' Height="90px" TextMode="MultiLine" Width="98%" CssClass="txtPadding" onfocus="javascipt:this.style.height = '250px'" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table align="center" style="width: 272px">
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Button ID="btnAddNewExternalWkCom" runat="server" Text="Save" Width="100px" CssClass="saveButton" OnClick="btnAddNewExternalWkCom_Click"
                                                                    ValidationGroup="AddProjComment" /></td>
                                                            <td align="right">
                                                                <asp:Button ID="btnCnclAddExternalWkCom" runat="server" Text="Reset" Width="100px" CssClass="saveButton" OnClick="btnCnclAddExternalWkCom_Click" /></td>
                                                        </tr>
                                                    </table>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <br />
                                                    <b style="text-decoration: underline">Leadership Highlights:</b><br />
                                                    <br />
                                                    <asp:Label ID="note_textLabel" runat="server" Text='<%# Bind("Comment")%>' /><br />
                                                    <asp:Label ID="project_pkLabel" runat="server" Text='<%# Eval("Project_FK")%>' Visible="False" />
                                                    <asp:Label ID="note_pkLabel" runat="server" Text='<%# Eval("Comment_PK")%>' Visible="False" />
                                                    <asp:Label ID="modification_user_fkLabel" runat="server" Text='<%# Bind("ModifyBy")%>' Visible="False" />                     
                                                </ItemTemplate>
                                            </asp:FormView>
                                            
                                            <asp:ObjectDataSource ID="odsrcWeeklyComment" runat="server"
                                                OldValuesParameterFormatString="original_{0}"
                                                SelectMethod="GetProjCommentByProjectId"
                                                TypeName="FactSheetApp.FactSheetNewTableAdapters.ProjectCommentTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="Original_Comment_PK" Type="Int32" />
                                                </DeleteParameters>
                                                <InsertParameters>
                                                    <asp:Parameter Name="Comment" Type="String" />
                                                    <asp:Parameter Name="CommentType_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedDate" Type="DateTime" />
                                                    <asp:Parameter Name="modifyDate" Type="DateTime" />
                                                    <asp:Parameter Name="Project_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedBy" Type="String" />
                                                    <asp:Parameter Name="ModifyBy" Type="String" />
                                                </InsertParameters>
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                                                </SelectParameters>
                                                <UpdateParameters>
                                                    <asp:Parameter Name="Comment" Type="String" />
                                                    <asp:Parameter Name="CommentType_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedDate" Type="DateTime" />
                                                    <asp:Parameter Name="modifyDate" Type="DateTime" />
                                                    <asp:Parameter Name="Project_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedBy" Type="String" />
                                                    <asp:Parameter Name="ModifyBy" Type="String" />
                                                    <asp:Parameter Name="Original_Comment_PK" Type="Int32" />
                                                </UpdateParameters>
                                            </asp:ObjectDataSource>
                                            <asp:ObjectDataSource ID="odsrcWeeklyExternalComment" runat="server"
                                                OldValuesParameterFormatString="original_{0}"
                                                SelectMethod="GetProjCommentByProjectId"
                                                TypeName="CFMISNew.FactSheetDataSetTableAdapters.ExternalProjectCommentTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="Original_Comment_PK" Type="Int32" />
                                                </DeleteParameters>
                                                <InsertParameters>
                                                    <asp:Parameter Name="Comment" Type="String" />
                                                    <asp:Parameter Name="CommentType_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedDate" Type="DateTime" />
                                                    <asp:Parameter Name="modifyDate" Type="DateTime" />
                                                    <asp:Parameter Name="Project_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedBy" Type="String" />
                                                    <asp:Parameter Name="ModifyBy" Type="String" />
                                                </InsertParameters>
                                                <SelectParameters>
                                                    <asp:QueryStringParameter DefaultValue="" Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                                                </SelectParameters>
                                                <UpdateParameters>
                                                    <asp:Parameter Name="Comment" Type="String" />
                                                    <asp:Parameter Name="CommentType_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedDate" Type="DateTime" />
                                                    <asp:Parameter Name="modifyDate" Type="DateTime" />
                                                    <asp:Parameter Name="Project_FK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedBy" Type="String" />
                                                    <asp:Parameter Name="ModifyBy" Type="String" />
                                                    <asp:Parameter Name="Original_Comment_PK" Type="Int32" />
                                                </UpdateParameters>
                                            </asp:ObjectDataSource>

                                        </div>

                                        <div class="wideBox" style="overflow: auto; padding-left: 10px;">


                                            <!-- Environmental Notes -->
                                            <asp:FormView ID="fvAddEditEnvironmentalNotes" runat="server" DataKeyNames="project_PK"
                                                DataSourceID="odsrcEnvironmentalNotes"  OnDataBound="fvAddEditEnvironmentalNotes_DataBound"
                                                DefaultMode="Edit" Width="98%">
                                                
                                                <EditItemTemplate>
                                                    <asp:Label ID="lblEditEnvironmentalNotes" runat="server" Text="Environmental Notes: " Font-Bold="True"></asp:Label>
                                                    <br />
                                                    <table style="width: 99%">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtEdtEnvironmentalNotes" runat="server" Text='<%# Bind("environmentalOverviewNote")%>' Height="90px" TextMode="MultiLine" Width="98%" CssClass="txtPadding" onfocus="javascipt:this.style.height = '250px'" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <asp:Label ID="lblEdtEnvironmentalNotesProjId" runat="server" Text='<%# Eval("Project_PK")%>' Visible="False" />
                                                    <asp:Label ID="lblEdtEnvironmentalNotesWkComUsr" runat="server" Text='<%# Bind("ModifyBy")%>' Visible="False" />
                                                    <asp:Label ID="lblEdtCreatedDate" runat="server" Text='<%# Bind("CreationDate")%>' Visible="False" />
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:Label ID="lblAddEnvironmentalNotes" runat="server" Text="Environmental Notes: " Font-Bold="True"></asp:Label>
                                                    <br />
                                                    <table style="width: 99%">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtAddEnvironmentalNotes" runat="server" Text='<%# Bind("environmentalOverviewNote") %>' Height="90px" TextMode="MultiLine" Width="98%" CssClass="txtPadding" onfocus="javascipt:this.style.height = '250px'" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </InsertItemTemplate>

                                                <ItemTemplate>
                                                    <br />
                                                    <b style="text-decoration: underline">Environmental Notes</b><br />
                                                    <br />
                                                    <br />
                                                    <asp:Label ID="note_textLabel" runat="server" Text='<%# Bind("environmentalOverviewNote")%>' /><br />
                                                    <asp:Label ID="project_pkLabel" runat="server" Text='<%# Eval("Project_PK")%>' Visible="False" />
                                                    <asp:Label ID="modification_user_fkLabel" runat="server" Text='<%# Bind("ModifyBy")%>' Visible="False" />
                                                </ItemTemplate>
                                            </asp:FormView>

                                            <!-- End of Environmental Notes -->

                                            <asp:ObjectDataSource ID="odsrcEnvironmentalNotes" runat="server"
                                                OldValuesParameterFormatString="original_{0}"
                                                SelectMethod="GetEnvNotes"
                                                TypeName="CFMISNew.FactSheetDataSetTableAdapters.ProjectTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="Original_Comment_PK" Type="Int32" />
                                                </DeleteParameters>
                                                <InsertParameters>
<%--                                                    <asp:Parameter Name="Comment" Type="String" />
                                                    <asp:Parameter Name="CommentType_FK" Type="Int32" />--%>
                                                    <asp:Parameter Name="CreationDate" Type="DateTime" />
                                                    <asp:Parameter Name="modificationDate" Type="DateTime" />
                                                    <asp:Parameter Name="Project_PK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedBy" Type="String" />
                                                    <asp:Parameter Name="ModifyBy" Type="String" />
                                                </InsertParameters>
                                                <SelectParameters>
                                                    <asp:QueryStringParameter DefaultValue="" Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                                                </SelectParameters>
                                                <UpdateParameters>
<%--                                                    <asp:Parameter Name="Comment" Type="String" />
                                                    <asp:Parameter Name="CommentType_FK" Type="Int32" />--%>
                                                    <asp:Parameter Name="CreationDate" Type="DateTime" />
                                                    <asp:Parameter Name="modificationDate" Type="DateTime" />
                                                    <asp:Parameter Name="Project_PK" Type="Int32" />
                                                    <asp:Parameter Name="CreatedBy" Type="String" />
                                                    <asp:Parameter Name="ModifyBy" Type="String" />
                                                    <asp:Parameter Name="Original_Project_PK" Type="Int32" />
                                                </UpdateParameters>
                                            </asp:ObjectDataSource>
                                        </div>

                                    </div>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </ContentTemplate>

                    </cc1:TabPanel>
                    <cc1:TabPanel ID="tpCostFunding" runat="server">
                        <HeaderTemplate>Cost Estimate</HeaderTemplate>

                        <ContentTemplate>
                            <div style="background-color: #e6eeff; padding-top: 15px; padding-bottom: 15px; padding-left: 5px;">
                                <div class="wideBox" style="overflow: auto;">
                                    <div style="float: right; padding-top: 35px; padding-right: 20px; width: 300px;">
                                        <asp:MultiView ID="mvCost" runat="server" ActiveViewIndex="0">
                                            <asp:View ID="vCostFms" runat="server">
                                                <div align="left" style="border: 1px solid black; padding-left: 5px; display:none">
                                                    <br />
                                                    <asp:Label ID="lblFMSHdgMsg" runat="server" Text="Daily Refreshed Data from FMS: " Font-Bold="True"></asp:Label><br />
                                                    <asp:Label ID="lblDataRefreshOn" runat="server" Font-Italic="True"></asp:Label>
                                                    <asp:FormView ID="fvFmsCost" runat="server" DataKeyNames="project_pk" DataSourceID="odsrcPMDRICost" EmptyDataText="Matching project not found in FMS" Width="275px">
                                                        <EditItemTemplate></EditItemTemplate>
                                                        <InsertItemTemplate></InsertItemTemplate>
                                                        <ItemTemplate>
                                                            <table style="height: 76px; width: 98%;">
                                                                <tr>
                                                                    <td><b>Available Fund:</b> </td>
                                                                    <td align="right">
                                                                        <asp:Label ID="lblAvailableFnd" runat="server" Text='<%# Bind("SUBALLW", "{0:C}")%>' /></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><b>Total Obligation:</b> </td>
                                                                    <td align="right">
                                                                        <asp:Label ID="lblTotalOblig" runat="server" Text='<%# Bind("OBLIG", "{0:C}")%>' /></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><b>Total Expenditure:</b> </td>
                                                                    <td align="right">
                                                                        <asp:Label ID="lblTotalExpnd" runat="server" Text='<%# Bind("EXPAMT", "{0:C}")%>' /></td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:FormView>
                                                    <asp:ObjectDataSource ID="odsrcPMDRICost" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataFromPMDRI"
                                                        TypeName="FactSheetApp.FactSheetNewTableAdapters.OverView_SAS2TableAdapter" InsertMethod="Insert">
                                                        <InsertParameters>
                                                            <asp:Parameter Name="SUBALLW" Type="Decimal" />
                                                            <asp:Parameter Name="OBLIG" Type="Decimal" />
                                                            <asp:Parameter Name="EXPAMT" Type="Decimal" />
                                                            <asp:Parameter Name="project_pk" Type="Int32" />
                                                            <asp:Parameter Name="Project_code_PMDRI" Type="String" />
                                                        </InsertParameters>
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                            </asp:View>

                                            <asp:View ID="vCostCfmis" runat="server">
                                                <div align="left" style="border: 1px solid black; padding-left: 5px">
                                                    <br />
                                                    <asp:Label ID="lblCfmisHdgMsg" runat="server" Text="Static Cost Data for Inactive Projects:" Font-Bold="True"></asp:Label><br />
                                                    <asp:FormView ID="fvCfmisCost" runat="server" DataSourceID="sdsrcCfmisCost" Width="275px">
                                                        <EditItemTemplate></EditItemTemplate>
                                                        <InsertItemTemplate></InsertItemTemplate>
                                                        <ItemTemplate>
                                                            <table style="height: 76px; width: 98%;">
                                                                <tr>
                                                                    <td><b>Available Fund:</b> </td>
                                                                    <td align="right">
                                                                        <asp:Label ID="lblavailableFund" runat="server" Text='<%# Bind("availableFund", "{0:C}")%>' /></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><b>Total Expenditure:</b> </td>
                                                                    <td align="right">
                                                                        <asp:Label ID="lbltotalExpenditure" runat="server" Text='<%# Bind("totalExpenditure", "{0:C}")%>' /></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><b>Total Obligation:</b> </td>
                                                                    <td align="right">
                                                                        <asp:Label ID="lbltotalObligation" runat="server" Text='<%# Bind("totalObligation", "{0:C}")%>' /></td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:FormView>
                                                    <asp:SqlDataSource ID="sdsrcCfmisCost" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>"
                                                        SelectCommand="SELECT availableFund, totalExpenditure, totalObligation FROM CostEstimate where project_fk=@ProjectId">
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </div>
                                            </asp:View>

                                        </asp:MultiView>
                                    </div>

                                    <div style="float: left; padding-left: 10px;">
                                        <table style="width: 95%">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblProjCostHdng" runat="server" Text="Project Cost Estimate" Font-Bold="True"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblUpdtCostMsg" runat="server" ForeColor="#009900"></asp:Label></td>
                                            </tr>
                                        </table>
                                        <asp:MultiView ID="mvCostView" runat="server" ActiveViewIndex="0">
                                            <asp:View ID="vUpdt" runat="server">
                                                <asp:FormView ID="fvCost" runat="server" DataKeyNames="costEstimate_PK" OnDataBound="fvCost_DataBound"
                                                    DataSourceID="odsrcUpdateCost" DefaultMode="Edit">
                                                    <EditItemTemplate>
                                                        <b>Update Cost Information:</b>
                                                        <table>
                                                            <tr>
                                                                <td>Total Estimated Cost: </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtTotalEstCost" runat="server" Text='<%# Bind("totalEstimatedCost", "{0:C}")%>' Style="text-align: right" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Approved: </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtApproved" runat="server" Text='<%# Bind("Approved", "{0:C}")%>' Style="text-align: right" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Current Estimated Cost: </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCurrentEstCost" runat="server" Text='<%# Bind("currentEstimatedCost", "{0:C}")%>' Style="text-align: right" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Initial Cost: </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtInitialCost" runat="server" Text='<%# Bind("initialCost", "{0:C}")%>' Style="text-align: right" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>USACE Initial Award Amount: </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtUSACEinitialAwardAmn" runat="server" Text='<%# Bind("USACEinitialAwardAmount", "{0:C}")%>' Style="text-align: right" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>USACE Contingencies: </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtUSACEcontingencies" runat="server" Text='<%# Bind("USACEcontingencies", "{0:C}")%>' Style="text-align: right" /></td>
                                                            </tr>
                                               <tr>
                                            <td>USACE Total Award Amount: </td>
                                            <td align="right">
                                                <asp:Label ID="lblUsaceTotalAwrd" runat="server" Text='<%# Bind("USACEtotalAwardAmount", "{0:C}")%>'></asp:Label></td>
                                        </tr>
                                                        </table>
                                                        <asp:Label ID="lblCostId" runat="server" Text='<%# Eval("costEstimate_PK") %>' Visible="False" />
                                                        <asp:Label ID="lblProjId" runat="server" Text='<%# Bind("project_FK") %>' Visible="False"></asp:Label><br />
                                                        <table align="left" style="width: 346px">
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:Button ID="btnEditCostEst" runat="server" Text="Save" OnClick="btnEditCostEst_Click" Width="100px" Font-Bold="True" ValidationGroup="VGEditCostEst" /></td>
                                                                <td align="center">
                                                                    <asp:Button ID="btnCancelEdt" runat="server" Text="Reset" Width="100px" Font-Bold="True" CommandName="Cancel" ValidationGroup="VGCancelEdt" /></td>
                                                            </tr>
                                                        </table>
                                                        <br />

                                                    </EditItemTemplate>
                                                    <InsertItemTemplate></InsertItemTemplate>
                                                    <ItemTemplate>
                                                        <b>Cost Information</b>
                                                        <table>
                                                            <tr>
                                                                <td>Total Estimated Cost: </td>
                                                                <td align="right">
                                                                    <asp:Label ID="lblTotalEstCost" runat="server" Text='<%# Bind("totalEstimatedCost", "{0:C}")%>'></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Approved: </td>
                                                                <td align="right">
                                                                    <asp:Label ID="lblApproved" runat="server" Text='<%# Bind("Approved", "{0:C}")%>'></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Current Estimated Cost: </td>
                                                                <td align="right">
                                                                    <asp:Label ID="lblCurrentEstCost" runat="server" Text='<%# Bind("currentEstimatedCost", "{0:C}")%>'></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>initialCost: </td>
                                                                <td align="right">
                                                                    <asp:Label ID="lblInitialCost" runat="server" Text='<%# Bind("initialCost", "{0:C}")%>'></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>futureNeed: </td>
                                                                <td align="right">
                                                                    <asp:Label ID="lblFutureNeed" runat="server" Text='<%# Bind("futureNeed", "{0:C}")%>'></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>USACE Initial Award Amount: </td>
                                                                <td align="right">
                                                                    <asp:Label ID="lblUSACEinitialAwardAmn" runat="server" Text='<%# Bind("USACEinitialAwardAmount", "{0:C}")%>'></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>USACE Contingencies: </td>
                                                                <td align="right">
                                                                    <asp:Label ID="lblUSACEcontingencies" runat="server" Text='<%# Bind("USACEcontingencies", "{0:C}")%>'></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>USACE Total Award Amount: </td>
                                                                <td align="right">
                                                                    <asp:Label ID="lblUSACEtotalAwardAmn" runat="server" Text='<%# Bind("USACEtotalAwardAmount", "{0:C}")%>'></asp:Label></td>
                                                            </tr>

                                                        </table>
                                                    </ItemTemplate>
                                                </asp:FormView>
                                                <asp:ObjectDataSource ID="odsrcUpdateCost" runat="server" OldValuesParameterFormatString="original_{0}"
                                                    SelectMethod="GetCostEstimateByProjectId" TypeName="FactSheetApp.FactSheetNewTableAdapters.CostEstimateTableAdapter">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                            </asp:View>
                                            <asp:View ID="vAdd" runat="server">
                                                <asp:FormView ID="fvAddCost" runat="server" DataKeyNames="costEstimate_PK" DataSourceID="odsrcCostEstimateByProjId"
                                                    DefaultMode="Insert" OnDataBound="fvAddCost_DataBound">
                                                    <EditItemTemplate></EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <b>Add Cost Information</b>
                                                        <table>
                                                            <tr>
                                                                <td>Total Estimated Cost: </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtTotalEstCostAdd" runat="server" Text='<%# Bind("totalEstimatedCost", "{0:C}")%>' Style="text-align: right"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Approved: </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtApprovedAdd" runat="server" Text='<%# Bind("Approved", "{0:C}")%>' Style="text-align: right"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Current Estimated Cost: </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCurrentEstCostAdd" runat="server" Text='<%# Bind("currentEstimatedCost", "{0:C}")%>' Style="text-align: right"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Initial Cost: </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtInitialCostAdd" runat="server" Text='<%# Bind("initialCost", "{0:C}")%>' Style="text-align: right"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td>USACE Initial Award Amount: </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtUSACEinitialAwardAmnAdd" runat="server" Text='<%# Bind("USACEinitialAwardAmount", "{0:C}")%>' Style="text-align: right"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td>USACE Contingencies: </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtUSACEcontingenciesAdd" runat="server" Text='<%# Bind("USACEcontingencies", "{0:C}")%>' Style="text-align: right"></asp:TextBox></td>
                                                            </tr>
                                                        </table>
                                                        <asp:Label ID="lblCostIdAdd" runat="server" Text='<%# Eval("costEstimate_PK") %>' Visible="False" />
                                                        <asp:Label ID="lblProjIdAdd" runat="server" Text='<%# Bind("project_FK") %>' Visible="False"></asp:Label><br />
                                                        <table align="left" style="width: 336px">
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:Button ID="btnAddCostEst" runat="server" Text="Save" OnClick="btnAddCostEst_Click" Width="100px" Font-Bold="True" /></td>
                                                                <td align="center">
                                                                    <asp:Button ID="btnCancle" runat="server" Text="Reset" Width="100px" Font-Bold="True" CommandName="Cancel" /></td>
                                                            </tr>
                                                        </table>
                                                    </InsertItemTemplate>
                                                    <ItemTemplate></ItemTemplate>

                                                </asp:FormView>

                                            </asp:View>
                                        </asp:MultiView>
                                        <asp:ObjectDataSource ID="odsrcCostEstimateByProjId" runat="server"
                                            OldValuesParameterFormatString="original_{0}" SelectMethod="GetCostEstimateByProjectId"
                                            TypeName="FactSheetApp.FactSheetNewTableAdapters.CostEstimateTableAdapter">
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                        <asp:FormView ID="fvSubProjCost" runat="server" DataKeyNames="costEstimate_PK"
                                            DataSourceID="odsrcCostEstimateByProjId" DefaultMode="Edit" Width="342px">
                                            <EditItemTemplate>
                                                <b>Update Cost for this Sub Project:<br />
                                                </b>&nbsp;
					  <table>
                          <tr>
                              <td class="auto-style53" valign="top">Total Estimated Cost: </td>
                              <td class="auto-style53">
                                  <asp:TextBox ID="txtEditTecSub" runat="server" Text='<%# Bind("totalEstimatedCost", "{0:C}")%>' Style="text-align: right" /><br />
                                  <asp:RequiredFieldValidator ID="rfvEditTec" runat="server" ControlToValidate="txtEditTecSub" ValidationGroup="EditTec" ErrorMessage="Value cannot be empty" ForeColor="Red"></asp:RequiredFieldValidator></td>
                          </tr>
                      </table>

                                                <asp:Label ID="lblSubCostId" runat="server" Text='<%# Eval("costEstimate_PK") %>' Visible="False" /><asp:Label ID="lblMainProjId" runat="server" Text='<%# Bind("project_FK") %>' Visible="False"></asp:Label><br />
                                                <table align="left" style="width: 313px">
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Button ID="btnEditSubCostEst" runat="server" Text="Save" OnClick="btnEditSubCostEst_Click" Width="100px" Font-Bold="True" ValidationGroup="EditTec" /></td>
                                                        <td align="center">
                                                            <asp:Button ID="btnCnclSubEdt" runat="server" Text="Reset" Width="100px" Font-Bold="True" CommandName="Cancel" /></td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <b>Add Cost for this Sub Project:<br />
                                                </b>
                                                <table>
                                                    <tr>
                                                        <td valign="top">Total Estimated Cost: </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAddTecSub" runat="server" Text='<%# Bind("totalEstimatedCost", "{0:C}")%>'></asp:TextBox><br />
                                                            <asp:RequiredFieldValidator ID="rfvAddTec" runat="server" ControlToValidate="txtAddTecSub" ValidationGroup="AddTec" ErrorMessage="Enter value to save" ForeColor="Red"></asp:RequiredFieldValidator></td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <table align="left" style="width: 317px">
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Button ID="btnAddSubCostEst" runat="server" Text="Save" ValidationGroup="AddTec" OnClick="btnAddSubCostEst_Click" Width="100px" Font-Bold="True" /></td>
                                                        <td align="center">
                                                            <asp:Button ID="btnCnclAddSubCost" runat="server" Text="Reset" CommandName="Cancel" Width="100px" Font-Bold="True" /></td>
                                                    </tr>
                                                </table>
                                            </InsertItemTemplate>
                                            <ItemTemplate>
                                                <b style="text-decoration: underline;">Sub Project Cost Information:</b><br />
                                                <br />
                                                Total Estimated Cost: 
					  <asp:Label ID="lblVwTEC" runat="server" Text='<%# Bind("totalEstimatedCost", "{0:C}")%>' Style="text-align: right"></asp:Label>
                                            </ItemTemplate>

                                        </asp:FormView>
                                    </div>
                                </div>
                                <div id="CostComment" class="wideBox" style="clear: both; padding-left: 10px;" runat="server">
                                    <table style="height: 43px;" width="95%">
                                        <tr>
                                            <td width="200px"><b>Cost related comments:</b> </td>
                                            <td width="130px">
                                                <asp:Button ID="btnAddCostComment" runat="server" Text="Add Comment" Font-Bold="True" ValidationGroup="VGAddCostComment" /></td>
                                            <td>
                                                <asp:Label ID="lblAddCostComMsg" runat="server" ForeColor="#009900"></asp:Label></td>
                                        </tr>
                                    </table>
                                    <asp:FormView ID="fvLatestComment" runat="server" DataKeyNames="comment_PK" DataSourceID="sdsrcLatestCostCom" DefaultMode="Edit" EmptyDataText="No comments on Cost has been added." Width="99%">
                                        <EditItemTemplate>
                                            <b>Latest Comment on Cost:</b>
                                            <table width="99%" style="height: 26px">
                                                <tr>
                                                    <td class="auto-style59"><b>Created:</b> </td>
                                                    <td class="auto-style61">
                                                        <asp:Label ID="lblCreatedCostCom" runat="server" Text='<%# Bind("createdDate", "{0:d}")%>'></asp:Label></td>
                                                    <td class="auto-style60"><b>Modified:</b> </td>
                                                    <td>
                                                        <asp:Label ID="lblModifiedCostCom" runat="server" Text='<%# Bind("modifyDate", "{0:d}") %>'></asp:Label></td>
                                                </tr>
                                            </table>
                                            <table style="width: 99%; height: 66px">
                                                <tr>
                                                    <td valign="top">
                                                        <asp:TextBox ID="txtCostCommentEdt" runat="server" Text='<%# Bind("comment") %>' TextMode="MultiLine" Height="52px" Width="99%" CssClass="txtPadding" /></td>
                                                </tr>
                                            </table>
                                            <asp:Label ID="lblCommentId" runat="server" Text='<%# Eval("comment_PK") %>' Visible="False" />
                                            <asp:Label ID="lblProjId" runat="server" Text='<%# Bind("project_FK") %>' Visible="False"></asp:Label>
                                            <table align="left" style="width: 346px">
                                                <tr>
                                                    <td align="center">
                                                        <asp:Button ID="btnEditCostCom" runat="server" Text="Save" Width="100px" Font-Bold="True" OnClick="btnEditCostCom_Click" ValidationGroup="VGEditCostCom" /></td>
                                                    <td align="center">
                                                        <asp:Button ID="btnCnclEdtCostComment" runat="server" Text="Reset" Width="100px" Font-Bold="True" CommandName="Cancel" ValidationGroup="VGCnclEdtCostComment" /></td>
                                                </tr>
                                            </table>
                                        </EditItemTemplate>

                                        <InsertItemTemplate></InsertItemTemplate>
                                        <ItemTemplate></ItemTemplate>
                                    </asp:FormView>
                                    <asp:SqlDataSource ID="sdsrcLatestCostCom" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>"
                                        SelectCommand="SELECT Top(1)comment_PK, comment, commentType_FK, createdDate, modifyDate, project_FK, createdBy, modifyBy
									  FROM Comment Where project_FK = @ProjId and commentType_FK = 4 Order by comment_PK desc">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="ProjId" QueryStringField="project_pk" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                    <asp:Panel ID="pnlAddCostComment" runat="server" CssClass="modalPopup" Width="483px" BackColor="#E6EDF4" Style="display: none; padding-left: 10px;">
                                        <asp:UpdatePanel ID="mupAddCostComment" runat="server">
                                            <ContentTemplate>

                                                <asp:FormView ID="fvAddCostComment" runat="server" DefaultMode="Insert" Width="451px" DataSourceID="sdsrcLatestCostCom">
                                                    <EditItemTemplate></EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td class="auto-style55">Add New Comment on Cost for this Project: </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="auto-style56">
                                                                    <asp:TextBox ID="txtCostCommentAdd" runat="server" TextMode="MultiLine" Height="61px" Width="421px" CssClass="txtPadding"></asp:TextBox></td>
                                                            </tr>
                                                        </table>
                                                    </InsertItemTemplate>
                                                    <ItemTemplate></ItemTemplate>
                                                </asp:FormView>

                                            </ContentTemplate>
                                        </asp:UpdatePanel>

                                        <table align="center" style="width: 154px">
                                            <tr>
                                                <td align="center">
                                                    <asp:LinkButton ID="lbAddCostComment" runat="server" Text="Save" CommandName="Insert" Font-Bold="True" Font-Size="14px" ValidationGroup="VGAddCostComment" /></td>
                                                <td align="center">
                                                    <asp:LinkButton ID="lbCnclAddCostCom" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" Font-Bold="True" Font-Size="14px" /></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Button ID="btnInertCostCom" runat="server" Style="display: none;" /><cc1:ModalPopupExtender ID="mpeAddCostComment" runat="server" DropShadow="True" X="300" Y="250"
                                        CancelControlID="lbCnclAddCostCom" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupAddCostComment"
                                        TargetControlID="btnInertCostCom" PopupControlID="pnlAddCostComment" Enabled="True" DynamicServicePath="">
                                    </cc1:ModalPopupExtender>
                                </div>

                                <div id="CostCommentHistory" class="wideBox" style="clear: both; padding-left: 10px;" runat="server">
                                    <div style="padding-left: 25px;">
                                        <asp:Panel ID="pnlClick" runat="server" BackColor="#5D7B9D" ForeColor="White" Width="95%">
                                            <table width="95%">
                                                <tr>
                                                    <td width="45%"><b>Cost Related Comment History</b> </td>
                                                    <td align="right">
                                                        <asp:Label ID="lblMsg" runat="server" Font-Bold="True"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                    <br />

                                    <asp:Panel ID="pnlCostComment" runat="server" Height="200px">
                                        <asp:GridView ID="gvCostCommentHistory" runat="server" AutoGenerateColumns="False" DataKeyNames="comment_PK"
                                            DataSourceID="sdsrcCostComHistory" Width="99%" ForeColor="#333333" AllowSorting="True">
                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                            <Columns>
                                                <asp:BoundField DataField="createdDate" DataFormatString="{0:d}" HeaderText="Created" SortExpression="createdDate">
                                                    <ItemStyle VerticalAlign="Top" Width="80px" CssClass="gvPadding" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="comment" HeaderText="Comment" SortExpression="comment">
                                                    <ItemStyle CssClass="gvPadding" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="modifyDate" DataFormatString="{0:d}" HeaderText="Modified" SortExpression="modifyDate">
                                                    <ItemStyle VerticalAlign="Top" Width="80px" CssClass="gvPadding" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="comment_PK" HeaderText="comment_PK" InsertVisible="False" ReadOnly="True" SortExpression="comment_PK" Visible="False" />
                                                <asp:BoundField DataField="project_FK" HeaderText="project_FK" SortExpression="project_FK" Visible="False" />
                                                <asp:BoundField DataField="createdBy" HeaderText="createdBy" SortExpression="createdBy" Visible="False" />
                                                <asp:BoundField DataField="modifyBy" HeaderText="modifyBy" SortExpression="modifyBy" Visible="False" />

                                            </Columns>
                                            <PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White" />
                                            <EditRowStyle BackColor="#999999" />
                                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsrcCostComHistory" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>"
                                            SelectCommand="SELECT comment_PK, comment, commentType_FK, createdDate, modifyDate, project_FK, createdBy, modifyBy
									  FROM Comment Where project_FK = @ProjId and commentType_FK = 4 Order by comment_PK desc">
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ProjId" QueryStringField="project_pk" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </asp:Panel>
                                    <cc1:CollapsiblePanelExtender ID="cpeCostComment" runat="server" TargetControlID="pnlCostComment"
                                        Collapsed="True" CollapsedText="Show History" ExpandedText="Hide History" CollapseControlID="pnlClick"
                                        ExpandControlID="pnlClick" ScrollContents="True" TextLabelID="lblMsg" Enabled="True">
                                    </cc1:CollapsiblePanelExtender>
                                </div>
                            </div>

                        </ContentTemplate>
                    </cc1:TabPanel>
                    <cc1:TabPanel ID="tpFunding" runat="server">
                        <HeaderTemplate>Funding</HeaderTemplate>
                        <ContentTemplate>
                            <asp:UpdatePanel ID="tab4" runat="server">
                                <ContentTemplate>
                                    <div style="background-color: #e6eeff; padding-top: 3px; padding-left: 10px;">
                                        <div id="Funding" class="wideBox" style="clear: both; padding-left: 10px;" runat="server">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <h4>Project Funding</h4>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnAddFunding" runat="server" Text="Add Funding" Font-Bold="True" CausesValidation="False" />
                                                        <%--                            <asp:Label ID="blnAddFundingClick" runat="server" Visible="false" EnableViewState="true"></asp:Label>--%>
							
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblAddMsg" runat="server" Font-Bold="True" ForeColor="#009900"></asp:Label>

                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:GridView ID="gvFunding" runat="server" AutoGenerateColumns="False" DataKeyNames="funding_PK" Width="98%" OnDataBound="gvFunding_DataBound"
                                                DataSourceID="odsrcFundingFromFSDS" ForeColor="#333333" EmptyDataText="Funding information not available" AllowPaging="True" Font-Size="12px">
                                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Year" SortExpression="fundingYr">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblYear" runat="server" Text='<%# Eval("fundingYr")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="gvPadding" Width="30px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="requestedFund" HeaderText="Requested" SortExpression="requestedFund" DataFormatString="{0:C}">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="appropriationFund" HeaderText="Appropriation" SortExpression="appropriationFund" DataFormatString="{0:C}">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="authorizationFund" HeaderText="Authorization" SortExpression="authorizationFund" DataFormatString="{0:C}">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="appropriationPublicLaw" HeaderText="Appropriation Public Law" SortExpression="appropriationPublicLaw">
                                                        <ItemStyle CssClass="gvPadding" Width="90px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="authorizationPubliclaw" HeaderText="Authorization Public Law" SortExpression="authorizationPubliclaw">
                                                        <ItemStyle CssClass="gvPadding" Width="90px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="purpose" HeaderText="Purpose" SortExpression="purpose">
                                                        <ItemStyle CssClass="gvPadding" Width="180px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="approvalType" HeaderText="Approval Type" SortExpression="approvalType">
                                                        <ItemStyle CssClass="gvPadding" Width="80px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="approvalType_FK" HeaderText="approvalType_FK" SortExpression="approvalType_FK" Visible="False" />
                                                    <asp:BoundField DataField="funding_PK" HeaderText="funding_PK" SortExpression="funding_PK" Visible="False" InsertVisible="False" ReadOnly="True" />
                                                    <asp:BoundField DataField="project_FK" HeaderText="project_FK" SortExpression="project_FK" Visible="False" />
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnEditFund" runat="server" Text="Edit" CommandName="Select" Font-Bold="False" OnClick="btnEditFund_Click" Font-Size="12px" ValidationGroup="VGEditFund" />
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="gvPadding" Width="30px" Font-Size="12px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnDeleteFund" runat="server" Text="Delete" CommandName="Delete" Font-Bold="False" CausesValidation="False" OnClientClick="return confirm('Are you sure to delete this funding?');" Font-Size="12px" />
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="gvPadding" Width="30px" Font-Size="12px" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerTemplate>
                                                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled='<%#IIf((gvFunding.PageIndex) < 1, "false", "true")%>'
                                                        CommandName="Page" ForeColor="White">&lt;&lt; First</asp:LinkButton>
                                                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled='<%#IIf((gvFunding.PageIndex) < 1, "false", "true")%>'
                                                        CommandName="Page" ForeColor="White">&lt; Prev</asp:LinkButton>
                                                    [Total Pg No: <%=gvFunding.PageCount%>][Current pg: <%=gvFunding.PageIndex + 1%>]
					<asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled='<%#IIf((gvFunding.PageCount) = (gvFunding.PageIndex + 1), "false", "true")%>'
                        CommandName="Page" ForeColor="White">Next &gt;</asp:LinkButton>
                                                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled='<%#IIf((gvFunding.PageCount) = (gvFunding.PageIndex + 1), "false", "true")%>'
                                                        CommandName="Page" ForeColor="White">Last &gt;&gt;</asp:LinkButton><br />
                                                    <asp:Label ID="lblGoTo" runat="server" Text="Go to Pg:"></asp:Label>
                                                    <asp:DropDownList ID="ddlFundPaging" runat="server" AutoPostBack="True"
                                                        Height="21px" OnSelectedIndexChanged="ddlFundPaging_SelectedIndexChanged"
                                                        Width="45px">
                                                    </asp:DropDownList>
                                                    <asp:Label ID="lblCurrentPg" runat="server"></asp:Label>
                                                </PagerTemplate>
                                                <PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White" />
                                                <EditRowStyle BackColor="#999999" />
                                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

                                            </asp:GridView>
                                            <asp:ObjectDataSource ID="odsrcFunding" runat="server" OldValuesParameterFormatString="original_{0}"
                                                SelectMethod="GetFundingByProjectId" DeleteMethod="DeleteFunding" TypeName="FactSheetApp.FactSheetNewTableAdapters.FundingTableAdapter">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                            <asp:ObjectDataSource ID="odsrcFundingFromFSDS" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetFundingByProjectId" TypeName="CFMISNew.FactSheetDataSetTableAdapters.FundingTableAdapter" UpdateMethod="Update">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="Original_funding_PK" Type="Int32" />
                                                </DeleteParameters>
                                                <InsertParameters>
                                                    <asp:Parameter Name="fundingYr" Type="Int32" />
                                                    <asp:Parameter Name="requestedFund" Type="Decimal" />
                                                    <asp:Parameter Name="appropriationFund" Type="Decimal" />
                                                    <asp:Parameter Name="authorizationFund" Type="Decimal" />
                                                    <asp:Parameter Name="appropriationPublicLaw" Type="String" />
                                                    <asp:Parameter Name="authorizationPubliclaw" Type="String" />
                                                    <asp:Parameter Name="approvalType_FK" Type="Int32" />
                                                    <asp:Parameter Name="purpose" Type="String" />
                                                    <asp:Parameter Name="project_FK" Type="Int32" />
                                                    <asp:Parameter Name="creationDate" Type="DateTime" />
                                                    <asp:Parameter Name="modificationDate" Type="DateTime" />
                                                    <asp:Parameter Name="createdBy" Type="String" />
                                                    <asp:Parameter Name="modifiedBy" Type="String" />
                                                </InsertParameters>
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                                                </SelectParameters>
                                                <UpdateParameters>
                                                    <asp:Parameter Name="fundingYr" Type="Int32" />
                                                    <asp:Parameter Name="requestedFund" Type="Decimal" />
                                                    <asp:Parameter Name="appropriationFund" Type="Decimal" />
                                                    <asp:Parameter Name="authorizationFund" Type="Decimal" />
                                                    <asp:Parameter Name="appropriationPublicLaw" Type="String" />
                                                    <asp:Parameter Name="authorizationPubliclaw" Type="String" />
                                                    <asp:Parameter Name="approvalType_FK" Type="Int32" />
                                                    <asp:Parameter Name="purpose" Type="String" />
                                                    <asp:Parameter Name="project_FK" Type="Int32" />
                                                    <asp:Parameter Name="creationDate" Type="DateTime" />
                                                    <asp:Parameter Name="modificationDate" Type="DateTime" />
                                                    <asp:Parameter Name="createdBy" Type="String" />
                                                    <asp:Parameter Name="modifiedBy" Type="String" />
                                                    <asp:Parameter Name="Original_funding_PK" Type="Int32" />
                                                </UpdateParameters>
                                            </asp:ObjectDataSource>
                                            <asp:Panel ID="pnlAddFund" runat="server" CssClass="modalPopup" Width="550px" BackColor="#E6EDF4" Style="display: none">
                                                <asp:UpdatePanel ID="mupAddFund" runat="server">
                                                    <ContentTemplate>
                                                        <asp:FormView ID="fvAddFund" runat="server" DataKeyNames="funding_PK" DataSourceID="odsrcFunding" DefaultMode="Insert" Width="528px">
                                                            <EditItemTemplate></EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <br />
                                                                <asp:Label ID="lblAddFundHdng" runat="server" Text="Enter Funding Information: " Font-Bold="True"></asp:Label><br />
                                                                <br />
                                                                <table style="width: 99%">
                                                                    <tr>
                                                                        <td class="auto-style78">Funding Year: </td>
                                                                        <td class="auto-style77">
                                                                            <asp:TextBox ID="txtFundingYr" runat="server" Text='<%# Bind("fundingYr") %>' Style="text-align: right" /><br />
                                                                        </td>
                                                                        <td>
                                                                            <asp:RequiredFieldValidator ID="rfvAddYear" runat="server" ControlToValidate="txtFundingYr" ErrorMessage="Required" Font-Bold="True"
                                                                                Font-Size="10px" ForeColor="Red" ValidationGroup="Funding"></asp:RequiredFieldValidator><br />
                                                                            <asp:CompareValidator ID="cvFundYr" runat="server" ControlToValidate="txtFundingYr" ErrorMessage="Number only" Font-Bold="True"
                                                                                Font-Size="10px" ForeColor="Red" Operator="DataTypeCheck" Type="Integer" ValidationGroup="Funding"></asp:CompareValidator></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style78">Requested: </td>
                                                                        <td class="auto-style77">
                                                                            <asp:TextBox ID="txtRequestedFund" runat="server" Text='<%# Bind("requestedFund") %>' Style="text-align: right" Width="170px" /></td>
                                                                        <td></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style78">Appropriation: </td>
                                                                        <td class="auto-style77">
                                                                            <asp:TextBox ID="txtAppropriationFund" runat="server" Text='<%# Bind("appropriationFund") %>' Style="text-align: right" Width="170px" /></td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style78">Authorization: </td>
                                                                        <td class="auto-style77">
                                                                            <asp:TextBox ID="txtAuthorizationFund" runat="server" Text='<%# Bind("authorizationFund") %>' Style="text-align: right" Width="170px" /></td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style78">Appropriation Public Law: </td>
                                                                        <td class="auto-style77" colspan="2">
                                                                            <asp:TextBox ID="txtAppropriationPL" runat="server" Text='<%# Bind("appropriationPublicLaw") %>' Width="98%" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style78">Authorization Public Law: </td>
                                                                        <td class="auto-style77" colspan="2">
                                                                            <asp:TextBox ID="txtAuthorizationPL" runat="server" Text='<%# Bind("authorizationPubliclaw") %>' Width="98%" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style78">Purpose: </td>
                                                                        <td class="auto-style77" colspan="2">
                                                                            <asp:TextBox ID="txtPurpose" runat="server" Text='<%# Bind("purpose") %>' Height="64px" TextMode="MultiLine" Width="98%" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style78">Approval Type: </td>
                                                                        <td class="auto-style77">
                                                                            <asp:DropDownList ID="ddlApprovalTp" runat="server" DataSourceID="sdsrcApprovalTp" DataTextField="approvalType" DataValueField="approvalType_PK"
                                                                                Height="21px" Width="170px" SelectedValue='<%# Bind("approvalType_FK") %>' AppendDataBoundItems="True">
                                                                                <asp:ListItem Value="" Text="-Select-"></asp:ListItem>
                                                                            </asp:DropDownList></td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>
                                                                </table>
                                                                <asp:Label ID="lblApprovalTp" runat="server" Text='<%# Bind("approvalType_FK") %>'></asp:Label>
                                                                <asp:Label ID="lblProjId" runat="server" Text='<%# Bind("project_FK") %>'></asp:Label>
                                                                <asp:SqlDataSource ID="sdsrcApprovalTp" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>"
                                                                    SelectCommand="SELECT * FROM [lkApprovalType]"></asp:SqlDataSource>
                                                            </InsertItemTemplate>
                                                            <ItemTemplate></ItemTemplate>

                                                        </asp:FormView>

                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                                <table align="center" style="width: 112px">
                                                    <tr>
                                                        <td align="center">
                                                            <asp:LinkButton ID="lbAddFund" runat="server" Text="Save" CommandName="Insert" Font-Bold="True" ValidationGroup="Funding" /></td>
                                                        <td align="center">
                                                            <asp:LinkButton ID="lbCancelAddFnd" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" Font-Bold="True" /></td>
                                                    </tr>

                                                </table>

                                            </asp:Panel>
                                            <asp:Button ID="btnInertFnd" runat="server" Style="display: none;" />
                                            <cc1:ModalPopupExtender ID="mpeAddFund" runat="server" DropShadow="True" X="300" Y="250"
                                                CancelControlID="lbCancelAddFnd" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupAddFund"
                                                TargetControlID="btnInertFnd" PopupControlID="pnlAddFund" Enabled="True">
                                            </cc1:ModalPopupExtender>
                                            <asp:Panel ID="pnlEditFund" runat="server" CssClass="modalPopup" Width="550px" BackColor="#E6EDF4" Style="display: none">
                                                <asp:UpdatePanel ID="mupEditFund" runat="server">
                                                    <ContentTemplate>
                                                        <asp:FormView ID="fvEditFund" runat="server" DataKeyNames="funding_PK" DataSourceID="odsrcEditFund"
                                                            DefaultMode="Edit" Width="528px">
                                                            <EditItemTemplate>
                                                                <br />
                                                                <asp:Label ID="lblUpdtHdgMsg" runat="server" Text="Update Fund Information: " Font-Bold="True"></asp:Label><br />
                                                                <br />
                                                                <table style="width: 99%">
                                                                    <tr>
                                                                        <td class="auto-style78">Funding Year: </td>
                                                                        <td valign="top" class="auto-style77">
                                                                            <asp:TextBox ID="txtFundingYrEdit" runat="server" Text='<%# Bind("fundingYr") %>' Style="text-align: right" /><br />
                                                                        </td>
                                                                        <td valign="top">
                                                                            <asp:CompareValidator ID="cvFundYrEdit" runat="server" ControlToValidate="txtFundingYrEdit" ErrorMessage="Number only" Font-Bold="True"
                                                                                ForeColor="Red" Operator="DataTypeCheck" Type="Integer" ValidationGroup="FundingEdt" Font-Size="10px"></asp:CompareValidator><br />
                                                                            <asp:RequiredFieldValidator ID="rfvEditYr" runat="server" ControlToValidate="txtFundingYrEdit" ErrorMessage="Required"
                                                                                Font-Bold="True" ForeColor="Red" ValidationGroup="FundingEdt" Font-Size="10px"></asp:RequiredFieldValidator></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style78">Requested: </td>
                                                                        <td class="auto-style77">
                                                                            <asp:TextBox ID="txtRequestedFundEdit" runat="server" Text='<%# Bind("requestedFund", "{0:C}")%>' Style="text-align: right" Width="90%" /></td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style78">Appropriation: </td>
                                                                        <td class="auto-style77">
                                                                            <asp:TextBox ID="txtAppropriationFundEdit" runat="server" Text='<%# Bind("appropriationFund", "{0:C}")%>' Style="text-align: right" Width="90%" /></td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style78">Authorization: </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtAuthorizationFundEdit" runat="server" Text='<%# Bind("authorizationFund", "{0:C}") %>' Style="text-align: right" Width="90%" /></td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style78">Appropriation Public Law: </td>
                                                                        <td class="auto-style77" colspan="2">
                                                                            <asp:TextBox ID="txtAppropriationPLEdit" runat="server" Text='<%# Bind("appropriationPublicLaw") %>' Height="20px" Width="98%" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style78">Authorization Public Law: </td>
                                                                        <td class="auto-style77" colspan="2">
                                                                            <asp:TextBox ID="txtAuthorizationPLEdit" runat="server" Text='<%# Bind("authorizationPubliclaw") %>' Height="20px" Width="98%" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style78">Purpose: </td>
                                                                        <td class="auto-style77" colspan="2">
                                                                            <asp:TextBox ID="txtPurposeEdit" runat="server" Text='<%# Bind("purpose") %>' Height="64px" TextMode="MultiLine" Width="98%" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style78">Approval Type: </td>
                                                                        <td class="auto-style77">
                                                                            <asp:DropDownList ID="ddlApprovalTpEdit" runat="server" DataSourceID="sdsrcApprovalTp" DataTextField="approvalType" DataValueField="approvalType_PK"
                                                                                Height="21px" Width="90%" SelectedValue='<%# Bind("approvalType_FK") %>' AppendDataBoundItems="True">
                                                                                <asp:ListItem Value="" Text="-Select-">
                                                                                </asp:ListItem>

                                                                            </asp:DropDownList></td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>
                                                                </table>
                                                                <asp:Label ID="lblFundId" runat="server" Text='<%# Bind("funding_PK") %>' Visible="False"></asp:Label>
                                                                <asp:SqlDataSource ID="sdsrcApprovalTp" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>"
                                                                    SelectCommand="SELECT * FROM [lkApprovalType]"></asp:SqlDataSource>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate></InsertItemTemplate>
                                                            <ItemTemplate></ItemTemplate>
                                                        </asp:FormView>
                                                        <asp:ObjectDataSource ID="odsrcEditFund" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetFundingByFundId"
                                                            TypeName="FactSheetApp.FactSheetNewTableAdapters.FundingTableAdapter">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="gvFunding" Name="FundId" PropertyName="SelectedValue" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:ObjectDataSource>

                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                                <table align="center" style="width: 124px">
                                                    <tr>
                                                        <td align="center">
                                                            <asp:LinkButton ID="lbEditFund" runat="server" Text="Save" CommandName="Update" Font-Bold="True" ValidationGroup="FundingEdt" Font-Size="12px" /></td>
                                                        <td align="center">
                                                            <asp:LinkButton ID="lbCnclEditFnd" runat="server" CausesValidation="False" Text="Cancel" Font-Bold="True" Font-Size="12px" /></td>
                                                    </tr>
                                                </table>

                                            </asp:Panel>
                                            <asp:Button ID="btnUpdtFnd" runat="server" Style="display: none;" />
                                            <cc1:ModalPopupExtender ID="mpeEditFund" runat="server" DropShadow="True" X="300" Y="250"
                                                CancelControlID="lbCnclEditFnd" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="mupEditFund"
                                                TargetControlID="btnUpdtFnd" PopupControlID="pnlEditFund" Enabled="True" DynamicServicePath="">
                                            </cc1:ModalPopupExtender>
                                            <br />

                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </ContentTemplate>
                    </cc1:TabPanel>
                    <cc1:TabPanel ID="tpSchedule" runat="server">
                        <HeaderTemplate>Schedule</HeaderTemplate>

                        <ContentTemplate>
                            <asp:UpdatePanel ID="tab5" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table style="width: 900px">
                                        <tr>
                                            <td class="auto-style41">
                                                <h4>Schedule Information(Highlighted Schedules are for Factsheet Review)</h4>
                                            </td>
                                            <td class="auto-style36">
                                                <asp:Button ID="btnUpdateSchedule" runat="server" Text="Save Update" CssClass="submitBtn" ValidationGroup="Validation" /></td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="lblScheduleUpdtMsg" runat="server" ForeColor="#009900"></asp:Label></td>
                                            <td></td>
                                        </tr>
                                    </table>
                                    <cc1:ConfirmButtonExtender runat="server" ID="cbeSchedule" TargetControlID="btnUpdateSchedule"
                                        ConfirmText="Please make sure the Actual date is right. Only admin can modify it once it's entered.">
                                    </cc1:ConfirmButtonExtender>
                                    <table style="width: 100%">
                                        <tr>
                                            <th class="auto-style80" align="left">Stage </th>
                                            <th class="auto-style109" align="left">Schedule </th>
                                            <th align="left" class="auto-style112">Prospectus<br />
                                                (Baseline) </th>
                                            <th align="left" class="auto-style113">Original<br />
                                                (Projected) </th>
                                            <th align="left" class="auto-style114">Revised </th>
                                            <th align="left" class="auto-style108">Actual </th>
                                            <%--<th class="auto-style72">Projected</th>--%><%--<th> </th>--%>
                                        </tr>
                                        <asp:Repeater ID="rptSchedule" runat="server" OnItemDataBound="rptSchedule_ItemDataBound">
                                            <ItemTemplate>
                                                <tr onmouseover="style.backgroundColor='LightBlue'" onmouseout="style.backgroundColor=''">
                                                    <td>
                                                        <div>
                                                            <asp:Label ID="lblStage" runat="server" Text='<%# Eval("milestoneStage")%>' Visible="true" Font-Bold="True"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <div>
                                                            <asp:Label ID="lblSchedule" runat="server" Text='<%# Eval("Milestone")%>'></asp:Label>
                                                            <asp:HiddenField ID="hdnMilestoneId" runat="server" Value='<%# Eval("milestone_PK")%>' />
                                                            <asp:HiddenField ID="hdnshowinFactsheet" runat="server" Value='<%# Eval("showinFactsheet")%>' />
                                                            <asp:HiddenField ID="hdnenvironmentalMilestone" runat="server" Value='<%# Eval("environmentalMilestone")%>' />
                                                            <asp:Label ID="lblMilestoneFk" runat="server" Text='<%# Eval("milestone_PK")%>' Font-Size="Smaller" Visible="False"></asp:Label>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div>
                                                            <asp:TextBox ID="txtProspectus" runat="server" Text='<%# Bind("prospectus", "{0:MM/dd/yyyy}")%>' Height="15px" Width="70px"></asp:TextBox>
                                                            <cc1:CalendarExtender ID="ceProspectus" runat="server" TargetControlID="txtProspectus"></cc1:CalendarExtender>
                                                            <asp:CompareValidator ID="cvProspectus" runat="server" ErrorMessage="Invalid" ControlToValidate="txtProspectus" Operator="DataTypeCheck" Type="Date" ForeColor="Red" ValidationGroup="Validation"></asp:CompareValidator>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div>
                                                            <asp:TextBox ID="txtOriginal" runat="server" Text='<%# Bind("orignal", "{0:MM/dd/yyyy}")%>' Height="15px" Width="70px"></asp:TextBox>
                                                            <cc1:CalendarExtender ID="ceOriginal" runat="server" TargetControlID="txtOriginal"></cc1:CalendarExtender>
                                                            <asp:CompareValidator ID="cvOriginal" runat="server" ErrorMessage="Invalid" ControlToValidate="txtOriginal" Operator="DataTypeCheck" Type="Date" ForeColor="Red" ValidationGroup="Validation"></asp:CompareValidator>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div>
                                                            <asp:TextBox ID="txtRevised" runat="server" Text='<%# Bind("revised", "{0:MM/dd/yyyy}")%>' Height="15px" Width="70px"></asp:TextBox>
                                                            <cc1:CalendarExtender ID="ceRevised" runat="server" TargetControlID="txtRevised"></cc1:CalendarExtender>
                                                            <asp:CompareValidator ID="cvRevised" runat="server" ErrorMessage="Invalid" ControlToValidate="txtRevised" Operator="DataTypeCheck" Type="Date" ForeColor="Red" ValidationGroup="Validation"></asp:CompareValidator>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div>
                                                            <asp:TextBox ID="txtActual" runat="server" Text='<%# Bind("actual", "{0:MM/dd/yyyy}")%>' Height="15px" Width="70px"></asp:TextBox>
                                                            <cc1:CalendarExtender ID="ceActual" runat="server" TargetControlID="txtActual"></cc1:CalendarExtender>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <asp:CompareValidator ID="cvActual" runat="server" ErrorMessage="Invalid" ControlToValidate="txtActual" Operator="DataTypeCheck" Type="Date" ForeColor="Red" Visible="True" ValidationGroup="Validation"></asp:CompareValidator>
                                                        <asp:CompareValidator ID="cvFutureActual" runat="server" ControlToValidate="txtActual" ForeColor="Red"
                                                            Operator="LessThanEqual" Type="Date" ErrorMessage="This can't be future date" ValidationGroup="Validation"></asp:CompareValidator>

                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </ContentTemplate>

                    </cc1:TabPanel>
                    <!-- begin .... this is for Environmental -->
                    <!-- begin .... this is for Environmental -->
                    <cc1:TabPanel ID="tpEnvironmental" runat="server">
                        <HeaderTemplate>Environmental</HeaderTemplate>
                        <ContentTemplate>
                            <asp:UpdatePanel ID="tab7" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <center>
                                        <h4>Environmental Project Initiation Form</h4>
                                    </center>
                                    <div style="text-align: right">
                                        <asp:Label ID="lblReqIndex" runat="server" Text="* Required Field" ForeColor="#ff0000"></asp:Label>
                                    </div>
                                    <div class="accordionMenu">
                                        <!-- 1st menu  -->
                                        <input type="radio" id="acc1" onclick="toggleconntent('content1')">
                                        <label for="acc1"><b>GENERAL PROJECT QUESTION</b></label>
                                        <div class="content" id="content1">
                                            <div class="inner">
                                                <table style="width: 100%">
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <asp:HiddenField ID="hdnSurvey_fk_1" runat="server" Value="1" />
                                                        <td style="width: 80%">
                                                            <asp:Label ID="lblReuiredmessage" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            1. Is the Project Share Point Accessible to Environmental?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="rblsharepointaccessible" runat="server" ForeColor="Red" Display="Dynamic" />
                                                            <td colspan="2">
                                                                <asp:RadioButtonList ID="rblsharepointaccessible" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdbnselection" AutoPostBack="true">
                                                                    <asp:ListItem Text="Yes" Value="1" />
                                                                    <asp:ListItem Text="No" Value="2" />
                                                                    <asp:ListItem Text="Unknown" Value="3" />
                                                                </asp:RadioButtonList>
                                                            </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_49" runat="server" Value="49" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" id="firsthdnquestion" visible="false">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label9" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            1a.	Please provide link and access to Envi SME to Project Share Point here
														<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="envsubmit" ErrorMessage=" (Please provide the link)" ControlToValidate="txtPinNo" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox type="text" ID="txtPinNo" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <asp:HiddenField ID="hdnSurvey_fk_2" runat="server" Value="2" />
                                                        <td colspan="1">
                                                            <asp:Label ID="lblRequiredmessage2" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2. Has this been documented in SEPS coordination with OCFM Regional Office Planners? <span id="msgSEPSCordination" style="color: red"></span>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="chkseps" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="chkseps" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_3" runat="server" Value="3" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:Label ID="lblRequiredmessage9" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            3. Is there a Recent Facility Master Plan? <span id="msgRcntfacilitymstrplan" style="color: red"></span>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="chkMp" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="chkMp" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="recentmstrplan">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_4" runat="server" Value="4" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" id="landusehdnquestion" visible="false">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label22" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            3a.	Is the project proposed for an existing site that is consistent with the land use/project in the Master Plan? <span id="msgLanduseoptions" style="color: red"></span>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="chkcnslnd" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="chkcnslnd" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_5" runat="server" Value="5" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" id="lnkmstrplanhdnquestion" visible="false">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label23" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            3b. Please provide link to Master Plan.
														<asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="txtPinNo2" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox type="text" ID="txtPinNo2" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:HiddenField ID="hdnSurvey_fk_6" runat="server" Value="6" />
                                                            <asp:Label ID="Label21" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            4.	Is the Project site consistent with the Market Study (VHA)?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="consistentwithmarketstudy" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="consistentwithmarketstudy" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:HiddenField ID="hdnSurvey_fk_50" runat="server" Value="50" />
                                                            <asp:Label ID="Label16" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            5.	Does the site has an "Outlease" through ORP? <span id="msgoutleaseORP" style="color: red"></span>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="Outleasethroughorp" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="Outleasethroughorp" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdbtnoutleaseselection" AutoPostBack="true">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_51" runat="server" Value="51" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" id="orphdnfirstquestion" visible="false">
                                                        <td colspan="1" style="padding-left: 12px">

                                                            <asp:Label ID="Label17" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            5a.	Who is the ORP PM handling the "Outlease"? <span id="msgOrphandlingpm" style="color: red"></span>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="orphandlingpm" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox type="text" ID="orphandlingpm" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_52" runat="server" Value="52" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" id="orphdnsecondquestion" visible="false">
                                                        <td colspan="1" style="padding-left: 12px">

                                                            <asp:Label ID="Label18" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            5b.	What is the expiration date of "Outlease"?
													<asp:RequiredFieldValidator ID="RequiredFieldValidator11" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="outleaseexpirationdate" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox type="text" ID="outleaseexpirationdate" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:HiddenField ID="hdnSurvey_fk_53" runat="server" Value="53" />
                                                            <asp:Label ID="Label19" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            6.	Are there known easements for the site?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator10" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="knowneasement" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="knowneasement" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:HiddenField ID="hdnSurvey_fk_54" runat="server" Value="54" />
                                                            <asp:Label ID="Label20" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            7.	Where are the records of easements and who is the responsible ORP PM? 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator12" ValidationGroup="envsubmit" ErrorMessage=" (Please provide the link)" ControlToValidate="txtOrprecordsofeasement" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox type="text" ID="txtOrprecordsofeasement" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                        <!-- 2nd menu -->
                                        <input type="radio" name="trg2" id="acc2" onclick="toggleconntent('content2')">
                                        <label for="acc2"><b>GENERAL ENVIRONMENTAL SITE CARACTERISTICS, RESOURCES, POTENTIAL IMPACTS</b></label>
                                        <div class="content" id="content2">
                                            <div class="inner">
                                                <table style="width: 100%">
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1" style="width: 80%">
                                                            <asp:Label ID="lblRequiredmessage3" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_90" runat="server" Value="90" />
                                                            1.	Please provide the link to the general site map or project boundary map of the proposed project area.
															<asp:RequiredFieldValidator ID="RequiredFieldValidator13" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="dvRealestateaction" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <div id="dvGnrlenv">
                                                                <asp:TextBox type="text" ID="dvRealestateaction" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                        <!-- 3rd menu -->
                                        <input type="radio" name="trg3" id="acc3" onclick="toggleconntent('content3')">
                                        <label for="acc3"><b>LAND USE</b></label>
                                        <div class="content" id="content3">
                                            <div class="inner">
                                                <table style="width: 100%">
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1" style="width: 80%">
                                                            <asp:Label ID="lblRequiredmessage4" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_7" runat="server" Value="7" />
                                                            1. Will the proposed action alter the present land use of the site?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator14" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="proposedaction" runat="server" ForeColor="Red" Display="Dynamic" />
                                                            <td colspan="2">
                                                                <asp:RadioButtonList ID="proposedaction" runat="server" RepeatDirection="Horizontal">
                                                                    <asp:ListItem Text="Yes" Value="1" />
                                                                    <asp:ListItem Text="No" Value="2" />
                                                                    <asp:ListItem Text="Unknown" Value="3" />
                                                                </asp:RadioButtonList>
                                                            </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:Label ID="lblRequiremessage5" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_8" runat="server" Value="8" />
                                                            2. Does the proposed action involve a real estate action (e.g., purchase, lease, easement, permit, or license, disposal)?  <span id="msgPairea" style="color: red"></span>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="pairea" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="pairea" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="realestateinvolvment">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="lndusefirsthiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_9" runat="server" Value="9" />
                                                            <asp:Label ID="Label24" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2a. Is ORP leading this effort, who is the ORP PM - Name, email and phone # ?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator16" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="rpeffortchk" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox type="text" ID="rpeffortchk" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="lndusesecondhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_10" runat="server" Value="10" />
                                                            <asp:Label ID="Label26" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2b. Require new purchase of additional acres using federal funds?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator17" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="adnacres" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="adnacres" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="lndusethirdhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_11" runat="server" Value="11" />
                                                            <asp:Label ID="Label27" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2c. Provide size of additional acres needed.     
															<asp:RequiredFieldValidator ID="RequiredFieldValidator18" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="txtSizeofadnacres" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox type="text" ID="txtSizeofadnacres" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="lndusefourthhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_12" runat="server" Value="12" />
                                                            <asp:Label ID="Label28" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2d. Require a new lease, license, and/or land use permit? 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator19" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="requirenew" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">

                                                            <asp:RadioButtonList ID="requirenew" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>

                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="lndusefifthhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_13" runat="server" Value="13" />
                                                            <asp:Label ID="Label29" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2e. Would the action Require an increase of acreage/amendment to an existing lease or license? 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator20" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="increaseofacreagechk" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="increaseofacreagechk" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="lndusesixthhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_14" runat="server" Value="14" />
                                                            <asp:Label ID="Label30" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2f. From a Realestate standpoint will the project replace or dispose of existing federal facilities? 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator21" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="realestatepointchk" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="realestatepointchk" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:Label ID="lblRequiredmessage6" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_15" runat="server" Value="15" />
                                                            3. Will the project include procurement or leasing of temporary swing space off campus for staff or functions during the project?		
															<asp:RequiredFieldValidator ID="RequiredFieldValidator22" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="procurmentorleasing" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="procurmentorleasing" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:Label ID="lblReuiredmessage7" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_16" runat="server" Value="16" />
                                                            4. Will any demolition be required as part of the project?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator23" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="demolition" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="demolition" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="anydemolition">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="lnduseseventhhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_17" runat="server" Value="17" />
                                                            <asp:Label ID="Label31" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            4a. Provide square footage of demolition. 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator24" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="txtSqrfootagedemolition" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox type="text" ID="txtSqrfootagedemolition" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:HiddenField ID="hdnSurvey_fk_18" runat="server" Value="18" />
                                                            <asp:Label ID="lblRequiredmessage7" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            5. Is the construction laydown footprint captured in the project area proposed footprint?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator25" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="footprintcaptured" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="footprintcaptured" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:HiddenField ID="hdnSurvey_fk_19" runat="server" Value="19" />
                                                            <asp:Label ID="lblRequiredmessage8" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            6. Will a parking structure be needed?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator26" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="pkngstructure" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="pkngstructure" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="Pkngstructureneeds">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="lnduseeighthhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_20" runat="server" Value="20" />
                                                            <asp:Label ID="Label61" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            6a. Is the additional Sq footage and parking structure taken into consideration in the overall project scope?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator27" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="adnsqftgoverallprojectscope" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="adnsqftgoverallprojectscope" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="lnduseninthhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_21" runat="server" Value="21" />
                                                            <asp:Label ID="Label33" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            6b. What is the approximate Sq footage of the needed parking structure?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator28" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="txtAppropriatesqfootage" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox type="text" ID="txtAppropriatesqfootage" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="lndusetenthhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_22" runat="server" Value="22" />
                                                            <asp:Label ID="Label32" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            6c. What is the project height of parking struture?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator29" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="txtProjectheight" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox type="text" ID="txtProjectheight" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                        <!-- 4th menu -->
                                        <input type="radio" name="trg4" id="acc4" onclick="toggleconntent('content4')">
                                        <label for="acc4"><b>SITE GEOLOGY AND SOIL SUITABILITY</b></label>
                                        <div class="content" id="content4">
                                            <div class="inner">
                                                <table style="width: 100%">
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td style="width: 80%">
                                                            <asp:Label ID="lblReuiredmessage10" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_23" runat="server" Value="23" />
                                                            1. Does the site have a current Environmental Site Assessment (ESA) Phase 1 (within last 2 yrs.)?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator30" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="envsiteassement" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="envsiteassement" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtnenvsiteassement">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="sitegeologyfirsthiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_24" runat="server" Value="24" />
                                                            <asp:Label ID="Label34" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            1a. Please attach or provide link to report.
															<asp:RequiredFieldValidator ID="RequiredFieldValidator31" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="txtLnktoreport" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox type="text" ID="txtLnktoreport" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="sitegeologysecondhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_25" runat="server" Value="25" />
                                                            <asp:Label ID="Label35" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            1b. Are there any Recognized Environmental Condition (REC) indicated in the Phase I ESA?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator32" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="recenvcondition" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="recenvcondition" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="sitegeologythirdhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_26" runat="server" Value="26" />
                                                            <asp:Label ID="Label36" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            1c. Please provide brief description if known. 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator33" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="txtbriefdscpn" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox type="text" ID="txtbriefdscpn" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:Label ID="lblrequiredmessage10" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_27" runat="server" Value="27" />
                                                            2. Have soil borings been conducted  to evaluate sub surface suitability for construction?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator34" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="subsurfacesuitability" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="subsurfacesuitability" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtnsubsurfacesuitability">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="sitegeologyfourthhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_28" runat="server" Value="28" />
                                                            <asp:Label ID="Label37" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2a. Please attached or provide link to report.
															<asp:RequiredFieldValidator ID="RequiredFieldValidator35" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="txtReportSoil" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox type="text" ID="txtReportSoil" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_29" runat="server" Value="29" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="sitegeologyfifthhhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label38" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2b. If borings were done did it identify high groundwater levels?
														<asp:RequiredFieldValidator ID="RequiredFieldValidator36" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="highgrndlevels" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="highgrndlevels" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_30" runat="server" Value="30" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="sitegeologysixthhhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label39" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2c. Will this effect construction? 
														<asp:RequiredFieldValidator ID="RequiredFieldValidator37" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="effectconstruction" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="effectconstruction" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="sitegeologyseventhhhiddenquestion">
                                                       <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="lblrequiredmessage11" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_31" runat="server" Value="31" />
                                                            2d. Where any known contaminants identified during soil borings or as part of the ESA Phase I that could impact construction or require mitigation prior to  or after construction?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator38" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="containmentssoil" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="containmentssoil" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                        <!-- 5th menu -->
                                        <input type="radio" name="trg5" id="acc5" onclick="toggleconntent('content5')">
                                        <label for="acc5"><b>HAZARDOUS MATERIAL</b></label>
                                        <div class="content" id="content5">
                                            <div class="inner">
                                                <table style="width: 100%">
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td style="width: 80%">
                                                            <asp:Label ID="lblrequiredmessage12" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            1. Is there any known contamination onsite?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator39" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="hazordousmtrl" runat="server" ForeColor="Red" Display="Dynamic" />
                                                            <asp:HiddenField ID="hdnSurvey_fk_32" runat="server" Value="32" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="hazordousmtrl" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtnknowncontaminations">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="hazardousknowncontainment">
                                                        <td colspan="1">
                                                            <asp:Label ID="lblrequiredmessage13" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            1a. Is there any documentation of the known contamination?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator40" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="dcmntlimits" runat="server" ForeColor="Red" Display="Dynamic" />
                                                            <asp:HiddenField ID="hdnSurvey_fk_33" runat="server" Value="33" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="dcmntlimits" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtndocumentationonknowncontainments">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                     <asp:HiddenField ID="hdnSurvey_fk_91" runat="server" Value="91" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="rdbtnlinktoknowncontainments">
                                                        <td colspan="1">
                                                            <asp:Label ID="Label62" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            1b. Please provide the link to the documentation.
                                            <span id="msglinktocontaminationdocs" style="color: red"></span>
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox type="text" ID="txtlinktocontainmentsdocuments" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:Label ID="lblrequiredmessage14" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_34" runat="server" Value="34" />
                                                            2. As part of the site/building study has there been a full Asbestos (ACM) Lead Based Paint(LBP) analysis of the project area and effected buildings to determine the extent of potential LBP and Asbestos contamination?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator41" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="fullasbestos" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="fullasbestos" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtnfullasbetos">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_35" runat="server" Value="35" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="hazordousfirsthiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label40" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2a. Please provide the link to copies of all previous LBP and ACM analysis reports for the site or effected buildings. 
														<asp:RequiredFieldValidator ID="RequiredFieldValidator42" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="txtPreviouselbpandacmanalysis" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox type="text" ID="txtPreviouselbpandacmanalysis" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:Label ID="lblrequiredmessage16" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_36" runat="server" Value="36" />
                                                            3. Are  any known Polychlorinated biphenyls (PCBs) present in any of the buildings on the site that will be impacted as part of the project? (Current generators, elevators, other old oil containing machinery)
															<asp:RequiredFieldValidator ID="RequiredFieldValidator43" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="polychlorinatepiphenyls" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="polychlorinatepiphenyls" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                        <!-- 6th menu -->
                                        <input type="radio" name="trg6" id="acc6" onclick="toggleconntent('content6')">
                                        <label for="acc6"><b>HISTORICAL AND CULTURAL</b></label>
                                        <div class="content" id="content6">
                                            <div class="inner">
                                                <table style="width: 100%">
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td style="width: 80%">
                                                            <asp:HiddenField ID="hdnSurvey_fk_37" runat="server" Value="37" />
                                                            <asp:Label ID="lblRequiredmessage21" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            1. Is the facility, building or VA campus 50 yrs. old or is it a National Cemetery?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator44" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="bldngfiftyyears" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="bldngfiftyyears" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td>
                                                            <asp:Label ID="lblRequiredmessage23" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_38" runat="server" Value="38" />
                                                            2. Has the facility, building, VA campus or National Cemetery or site been evaluated under the National Historic Preservation Act (NHPA) for listing on the National Register of Historic Places (NRHP)? 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator45" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="nhpaevaluation" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="nhpaevaluation" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td>
                                                            <asp:Label ID="lblRequiredmessage17" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_39" runat="server" Value="39" />
                                                            3. Is the site listed on the Historic Register?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator46" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="lstedhistoricregister" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="lstedhistoricregister" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtnlstedhistoricregister">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="historicalculturalfirsthiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_40" runat="server" Value="40" />
                                                            <asp:Label ID="Label41" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            3a. Are there any historic or archeological site reports available for the current project or for past projects at the site?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator47" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="hsitoricarcheolgical" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="hsitoricarcheolgical" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>

                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="historicalculturalsecondhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">

                                                            <asp:HiddenField ID="hdnSurvey_fk_41" runat="server" Value="41" />
                                                            <asp:Label ID="Label42" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            3b. Please provide a link to the reports or attach past reports.
															<asp:RequiredFieldValidator ID="RequiredFieldValidator48" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="txtLinktopastreports" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox type="text" ID="txtLinktopastreports" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="historicalculturalthirdhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_42" runat="server" Value="42" />
                                                            <asp:Label ID="Label43" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            3c. Is there a preservation plan for the property?  
															<asp:RequiredFieldValidator ID="RequiredFieldValidator49" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="preservationplan" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="preservationplan" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="historicalculturalfourthhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_43" runat="server" Value="43" />
                                                            <asp:Label ID="Label44" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            3d. Please provide a link to the preservation plan. 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator50" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="txtLinktopreservationplan" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox type="text" ID="txtLinktopreservationplan" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td>
                                                            <asp:Label ID="lblRequiredmessage18" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_44" runat="server" Value="44" />
                                                            4. Are there any existing NHPA agreements in effect for the property (see: achp.gov/va) or Native American Graves Protection and Repatriation Act (NAGPRA) Plans of Action or Agreements?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator51" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="exstnhpaagreement" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="exstnhpaagreement" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtnexstnhpaagreement">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_45" runat="server" Value="45" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="historicalculturalfifthhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label46" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            4a. Please provide a link to any agreements.
														<asp:RequiredFieldValidator ID="RequiredFieldValidator52" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="Txtlnktoanyagreement" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox type="text" ID="Txtlnktoanyagreement" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td>
                                                            <asp:Label ID="lblRequiredmessage19" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_46" runat="server" Value="46" />
                                                            5. Does the facility have existing relationships with likely consulting parties (i.e. State Historic Preservation Office (SHPO), local government, Tribes)?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator53" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="exstrelnwithconsuparties" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="exstrelnwithconsuparties" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtnlnktoannualrptsreuirement">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="historicalculturalsixthhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_47" runat="server" Value="47" />
                                                            <asp:Label ID="Label47" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            5a. Are there any annual reports requirements?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator54" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="lnktoannualrptsreuirement" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="lnktoannualrptsreuirement" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_48" runat="server" Value="48" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="historicalculturalseventhhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label48" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            5b. Please provide link to the latest annual report?  
														<asp:RequiredFieldValidator ID="RequiredFieldValidator55" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="Txtlinktolatestannualreports" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox type="text" ID="Txtlinktolatestannualreports" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                        <!-- 7th menu -->
                                        <input type="radio" name="trg7" id="acc7" onclick="toggleconntent('content7')">
                                        <label for="acc7"><b>NATURAL RESOURCES</b></label>
                                        <div class="content" id="content7">
                                            <div class="inner">
                                                <table style="width: 100%">
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td style="width: 80%">
                                                            <asp:HiddenField ID="hdnSurvey_fk_55" runat="server" Value="55" />
                                                            <asp:Label ID="Label1" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            1. Will the proposed action alter, destroy, or significantly impact environmentally sensitive areas (wetlands and/or existing fish or wildlife habitat, coastal zones, flood plains)
															<asp:RequiredFieldValidator ID="RequiredFieldValidator56" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="envsensitive" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="3">
                                                            <asp:RadioButtonList ID="envsensitive" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                        <td colspan="2"></td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td>
                                                            <asp:Label ID="Label2" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_56" runat="server" Value="56" />
                                                            2. Are there any known state or federal listed threatened or endangered species on this site?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator57" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="stateorfederalthreatened" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="stateorfederalthreatened" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbnstateorfederalthreatenedprevreport">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="naturalresourcesfirsthiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_57" runat="server" Value="57" />
                                                            <asp:Label ID="Label45" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2a. Are any previous reports available? 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator58" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="stateorfederalthreatenedprevreport" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="stateorfederalthreatenedprevreport" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="Subrdbnendangeredspeciesreport">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="naturalresourcessecondhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_58" runat="server" Value="58" />
                                                            <asp:Label ID="Label49" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2b. Please provide link or attach ESA report.
														<asp:RequiredFieldValidator ID="RequiredFieldValidator59" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="Txtlnktoattachesarpt" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox type="text" ID="Txtlnktoattachesarpt" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td style="width: 80%">
                                                            <asp:Label ID="Label3" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_59" runat="server" Value="59" />
                                                            3. Does the project site fall within the FEMA 500 yr. Floodplain? 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator60" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="femafloodplain" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="femafloodplain" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtngeafloodplain">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="naturalresourcesthirdhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_60" runat="server" Value="60" />
                                                            <asp:Label ID="Label50" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            3a. How much of the project falls within the 500 yr. floodplain? 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator61" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="Txtpercentageinfloodplain" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox type="text" ID="Txtpercentageinfloodplain" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td>
                                                            <asp:Label ID="Label4" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_61" runat="server" Value="61" />
                                                            4. Are there known or mapped wetlands on site?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator62" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="knownormappedwetlands" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="knownormappedwetlands" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtnknownormappedwetlands">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_62" runat="server" Value="62" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="naturalresourcesfourthhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label51" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            4a. Are wetland likely to be impacted as a result of the project? 
														<asp:RequiredFieldValidator ID="RequiredFieldValidator63" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="wetlandimpacted" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="wetlandimpacted" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtnlikelyimpactsowetlands">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>

                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_63" runat="server" Value="63" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="naturalresourcesfifthiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label52" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            4b. Is it anticipated that a Wetlands permit will be required at the State or Federal level for the project? 
														<asp:RequiredFieldValidator ID="RequiredFieldValidator64" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="anticpatedwetlandspermit" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="anticpatedwetlandspermit" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_64" runat="server" Value="64" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="naturalresourcessixthiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label53" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            4c. Is there existing wetland permits or agreement for the development of this site?
														<asp:RequiredFieldValidator ID="RequiredFieldValidator65" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="exstwetlandpermitsoragreement" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="exstwetlandpermitsoragreement" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>

                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_65" runat="server" Value="65" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="naturalresourcesseventhhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label54" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            4d. Please provide link to exciting permit or agreement.
														<asp:RequiredFieldValidator ID="RequiredFieldValidator66" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="txtwetlandsexcitingpermits" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox type="text" ID="txtwetlandsexcitingpermits" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                        <!-- 8th menu -->
                                        <input type="radio" name="trg8" id="acc8" onclick="toggleconntent('content8')">
                                        <label for="acc8"><b>STORMWATER AND COASTAL ZONE</b></label>
                                        <div class="content" id="content8">
                                            <div class="inner">
                                                <table style="width: 100%">
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td style="width: 80%">
                                                            <asp:Label ID="Label5" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_66" runat="server" Value="66" />
                                                            1. Are current Stormwater (SW) Facilities on site adequate to handle additional flow?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator67" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="currentstormwateradequate" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="currentstormwateradequate" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:Label ID="Label6" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_67" runat="server" Value="67" />
                                                            2. Will the site be able to handle the 24 hr. retention of SW associated with the change in impervious surface?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator68" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="retentionofsw" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="retentionofsw" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:Label ID="Label7" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_68" runat="server" Value="68" />
                                                            3. Does the project fall within 1000 ft of the Coastal Zone ( Coastline)or tidal waters?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator69" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="fallcoastalzone" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="fallcoastalzone" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                        <!-- 9th menu -->
                                        <input type="radio" name="trg9" id="acc9" onclick="toggleconntent('content9')">
                                        <label for="acc9"><b>UTILITIES</b></label>
                                        <div class="content" id="content9">
                                            <div class="inner">
                                                <table style="width: 100%">
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td style="width: 80%">
                                                            <asp:Label ID="Label8" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_70" runat="server" Value="70" />
                                                            1. Are there sufficient utilities (with capacity) to support the proposed project on site? Only answer yes, if it is known that all utilities have sufficent capacity 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator70" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="sufficesntutilities" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="sufficesntutilities" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtnutilities">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" id="utilities_1" runat="server" visible="false">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_71" runat="server" Value="71" />
                                                            1a. Please inidcate which utilities could require modifications or changes to support the project.							
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:CheckBox ID="chkElectrical" runat="server" Text="Electrical" />
                                                            <asp:HiddenField ID="hdnElectricalfk_1" runat="server" Value="1" />
                                                            <br />
                                                            <asp:CheckBox ID="chkSanitarysewer" runat="server" Text="Sanitary Sewer" />
                                                            <asp:HiddenField ID="hdnSanitarySewerfk_2" runat="server" Value="2" />
                                                            <br />
                                                            <asp:CheckBox ID="chkStormsewer" runat="server" Text="Storm Sewer" />
                                                            <asp:HiddenField ID="hdnstormwaterfk_3" runat="server" Value="3" />
                                                            <br />
                                                            <asp:CheckBox ID="chkSteam" runat="server" Text="Steam" />
                                                            <asp:HiddenField ID="hdnSteamfk_4" runat="server" Value="4" />
                                                            <br />
                                                            <asp:CheckBox ID="chkPortablewater" runat="server" Text="Portable Water" />
                                                            <asp:HiddenField ID="hdnPoratbalewaterfk_5" runat="server" Value="5" />
                                                            <br />
                                                            <asp:CheckBox ID="chkChilledWater" runat="server" Text="Chilled Water" />
                                                            <asp:HiddenField ID="hdnChilledwaterfk_6" runat="server" Value="6" />
                                                            <br />
                                                            <asp:CheckBox ID="chkNaturalgas" runat="server" Text="Natural Gas" />
                                                            <asp:HiddenField ID="hdnNaturalgasfk_7" runat="server" Value="7" />
                                                            <br />
                                                            <asp:CheckBox ID="chkRelaimedwater" runat="server" Text="Irrigation" />
                                                            <asp:HiddenField ID="hdnReclaimedwaterfk_8" runat="server" Value="8" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" id="utilities_2" runat="server" visible="false">
                                                        <td style="width: 80%; padding-left: 12px">
                                                            <asp:HiddenField ID="hdnSurvey_fk_72" runat="server" Value="72" />
                                                            1b. If there is not sufficent capacity , will the project require utilities to be brought in from off site? 
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="utilitiestobebroughtfrmsite" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtnutilitydistances">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" id="utilities_3" runat="server" visible="false">
                                                        <td style="width: 80%; padding-left: 12px">1c. Please indicate estimated distance for each needed utility. 	
														<asp:HiddenField ID="hdnSurvey_fk_73" runat="server" Value="73" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox type="text" ID="txtElectrical" runat="server" placeholder="Electrical" />
                                                            <br />
                                                            <asp:TextBox type="text" ID="txtSanitarysewer" runat="server" placeholder="Sanitary Sewer" />
                                                            <br />
                                                            <asp:TextBox type="text" ID="txtStormsewer" runat="server" placeholder="Storm Sewer" />
                                                            <br />
                                                            <asp:TextBox type="text" ID="txtSteam" runat="server" placeholder="Steam" />
                                                            <br />
                                                            <asp:TextBox type="text" ID="txtPortablewater" runat="server" placeholder="Portable Water" />
                                                            <br />
                                                            <asp:TextBox type="text" ID="txtChilledwater" runat="server" placeholder="Chilled Water" />
                                                            <br />
                                                            <asp:TextBox type="text" ID="txtNaturalgas" runat="server" placeholder="Natural Gas" />
                                                            <br />
                                                            <asp:TextBox type="text" ID="txtReclaimedwatersource" runat="server" placeholder="Reclaimed Water Source" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" id="utilities_4" runat="server" visible="false">
                                                        <td style="width: 80%; padding-left: 12px">1d. Is proposed routing of utilities known?
														<asp:HiddenField ID="hdnSurvey_fk_74" runat="server" Value="74" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="proposedroutingofutilities" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td style="width: 80%">
                                                            <asp:Label ID="Label25" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_75" runat="server" Value="75" />
                                                            2. Are there any overhead utilities, underground utilities or easements that would need to be evaluated as part of the developability of the site? 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator71" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="utilitiesevaluationofsite" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="utilitiesevaluationofsite" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                        <!-- 10th menu -->
                                        <input type="radio" name="trg10" id="acc10" onclick="toggleconntent('content10')">
                                        <label for="acc10"><b>TRAFFIC</b></label>
                                        <div class="content" id="content10">
                                            <div class="inner">
                                                <table style="width: 100%">
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td style="width: 80%">
                                                            <asp:Label ID="Label10" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_76" runat="server" Value="76" />
                                                            1. Are there known traffic issues in the immediate area? 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator72" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="trafficissue" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="trafficissue" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:Label ID="Label11" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_77" runat="server" Value="77" />
                                                            2. Will the project impact traffic and site access during construction or during operation?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator73" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="impacttrafficsiteaccess" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="impacttrafficsiteaccess" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtnimpacttrafficsiteaccess">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_78" runat="server" Value="78" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="trafficfirsthiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label57" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2a. Will traffic impacts be limited only during construction?
														<asp:RequiredFieldValidator ID="RequiredFieldValidator74" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="trafficimpactsduringconstn" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="trafficimpactsduringconstn" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_79" runat="server" Value="79" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="trafficsecondhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label56" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2b. Has a traffic study been completed for after construction/ during operation of the facility and traffic Level of Service(LOS)															
														<asp:RequiredFieldValidator ID="RequiredFieldValidator75" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="trafficstudycompleted" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="trafficstudycompleted" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_80" runat="server" Value="80" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="trafficthirdhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label55" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2c. Please provide link or attached previously completed traffic study 
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator83" ValidationGroup="envsubmit" ErrorMessage=" (Please provide link)" ControlToValidate="txtProvidelnkotrafficstudy" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox type="text" ID="txtProvidelnkotrafficstudy" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:Label ID="Label12" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_81" runat="server" Value="81" />
                                                            3. Is there mass transit in close proximity which could be utilized to alleviate traffic impacts?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator76" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="masstransitcloseproximity" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="masstransitcloseproximity" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                        <!-- 11th menu -->
                                        <input type="radio" name="trg11" id="acc11" onclick="toggleconntent('content11')">
                                        <label for="acc11"><b>NATIONAL ENVIRONMENTAL POLICY ACT (NEPA)  PREVIOUS COMPLETED DOCUMENTS (ENVIRONMENTAL ASSESSMENTS(EA), ENVIRONMENTAL IMPACT STATEMENTS (EIS))</b></label>
                                        <div class="content" id="content11">
                                            <div class="inner">
                                                <table style="width: 100%">
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td style="width: 80%">
                                                            <asp:Label ID="Label13" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_82" runat="server" Value="82" />
                                                            1. Has an previous NEPA EA or EIS  been completed for the project?
															<asp:RequiredFieldValidator ID="RequiredFieldValidator77" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="previousnepaeaoreis" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="previousnepaeaoreis" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtnpreviousnepaeaoreis">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_83" runat="server" Value="83" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="nepafirsthiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label60" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            1a. Is there a Final EA and signed Finding of No Significant Impact (FONSI) for the project? <span id="msgFinaleasignedfonsi" style="color: red"></span>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator78" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="finaleasignedfonsi" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="finaleasignedfonsi" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_84" runat="server" Value="84" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="nepasecondhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label59" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            1b. Please provide link of previous NEPA EA or EIS and signed FONSI. <span id="msgTxtpreviousnepaeaoreis" style="color: red"></span>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator79" ValidationGroup="envsubmit" ErrorMessage=" (Please provide link)" ControlToValidate="txtpreviousnepaeaoreis" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox type="text" ID="txtpreviousnepaeaoreis" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:Label ID="Label14" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_85" runat="server" Value="85" />
                                                            2. Does the site have any previously completed NEPA documents for past projects that are available? (This can help to frame the potential resource areas or concern) 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator80" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="prevcomplnepadocnavailable" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <div id="dvChkprevcomplnepadocnavailable">
                                                                <asp:RadioButtonList ID="prevcomplnepadocnavailable" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdbtnprevcomplnepadocnavailable">
                                                                    <asp:ListItem Text="Yes" Value="1" />
                                                                    <asp:ListItem Text="No" Value="2" />
                                                                    <asp:ListItem Text="Unknown" Value="3" />
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <asp:HiddenField ID="hdnSurvey_fk_86" runat="server" Value="86" />
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" visible="false" id="nepathirdhiddenquestion">
                                                        <td colspan="1" style="padding-left: 12px">
                                                            <asp:Label ID="Label58" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            2a. Please provide site POC for past NEPA documentation  or attach past NEPA documentation 
														<asp:RequiredFieldValidator ID="RequiredFieldValidator81" ValidationGroup="envsubmit" ErrorMessage=" (Please provide link)" ControlToValidate="txtLnksitepocpastnepadocn" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox type="text" ID="txtLnksitepocpastnepadocn" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                                        </td>
                                                    </tr>
                                                    <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                                        <td colspan="1">
                                                            <asp:Label ID="Label15" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                            <asp:HiddenField ID="hdnSurvey_fk_87" runat="server" Value="87" />
                                                            3. Are there other projects underway or planned for the near term at the property (Minors)? <span id="msgOtherprojectunderwayorplanned" style="color: red"></span>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator82" ValidationGroup="envsubmit" ErrorMessage=" (Please select one)" ControlToValidate="otherprojectunderwayorplanned" runat="server" ForeColor="Red" Display="Dynamic" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="otherprojectunderwayorplanned" runat="server" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="Yes" Value="1" />
                                                                <asp:ListItem Text="No" Value="2" />
                                                                <asp:ListItem Text="Unknown" Value="3" />
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                        <!-- 12th menu -->
                                        <input type="radio" name="trg12" id="acc12" onclick="toggleconntent('content12')">
                                        <label for="acc12"><b>PHYSICAL SECURITY</b></label>
                                        <div class="content" id="content12">
                                            <div class="inner">
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 80%">Will the proposed impacts Physical Security requirements that may require other actions? What are those potential actions?<br>
                                                            <asp:HiddenField ID="hdnSurvey_fk_88" runat="server" Value="88" />
                                                            <br />
                                                            <asp:TextBox ID="txtImpactsofphysicalsecurity" runat="server" Width="80%" TextMode="MultiLine" Height="75px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 80%">Will the proposed potentially impact Physical Security requirements require and cause other actions? What are those potential actions?<br>
                                                            <asp:HiddenField ID="hdnSurvey_fk_89" runat="server" Value="89" />
                                                            <br />
                                                            <asp:TextBox ID="txtProposedpotentiallyimpacts" runat="server" Width="80%" TextMode="MultiLine" Height="75px"></asp:TextBox>
                                                            <br />
                                                            <br />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                        <br>
                                        <br>
                                        <div style="text-align: center">
                                            <asp:Button ID="btnSave" runat="server" OnClientClick="if (!confirm('Are you sure you want save the records?')) return false;" CausesValidation="false" Text="Save" Style="width: 15%; padding-top: 10px; padding-bottom: 10px;" OnClick="btnEnvironmentalSave_Click" />
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" UseSubmitBehavior="false" Style="width: 15%; padding-top: 10px; padding-bottom: 10px;" CausesValidation="true" ValidationGroup="envsubmit" OnClick="btnSubmit_Click"
                                                OnClientClick="if (!confirm('Are you sure you want to submit? Once you submit this form will go to Environmental Engineer and you will not be able to make any changes or updates.')) return false;" />
                                        </div>
                                        <br>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </ContentTemplate>
                    </cc1:TabPanel>
                    <!-- end ....  Environmental Tab-->
                    <!-- end ....  Environmental Tab-->
                    <cc1:TabPanel ID="tpUpload" runat="server" Visible="False">
                        <HeaderTemplate>Upload</HeaderTemplate>
                        <ContentTemplate>
                            <asp:UpdatePanel runat="server" ID="tab6">
                                <ContentTemplate>
                                    <table align="center" style="width: 508px">
                                        <tr>
                                            <td align="left">
                                                <asp:Label ID="lblDocType" runat="server" Visible="False"></asp:Label></td>
                                            <td align="center"></td>
                                            <td>
                                                <asp:Label ID="lblDoc" runat="server" Visible="False"></asp:Label></td>
                                            <td>
                                                <asp:Label ID="lblFileSize" runat="server" Visible="False"></asp:Label></td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <br />
                            <asp:Label ID="lblUploadHdgMsg" runat="server" Text="Choose a document to upload:"></asp:Label>
                            <asp:DetailsView ID="dtvUpload" runat="server" AutoGenerateRows="False"
                                DefaultMode="Insert" Height="27px" Width="90%" CssClass="data" DataSourceID="odsrcDocument">
                                <Fields>
                                    <asp:TemplateField HeaderText="Choose the document to upload:" SortExpression="docName" ShowHeader="False">
                                        <InsertItemTemplate>
                                            <asp:FileUpload ID="fuUpload" runat="server" Height="24px" Width="98%" />
                                        </InsertItemTemplate>
                                        <HeaderStyle Font-Bold="True" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <InsertItemTemplate>
                                            <table align="right" style="width: 118px">
                                                <tr>
                                                    <td align="center">
                                                        <asp:LinkButton ID="lbInsert" runat="server" CausesValidation="True"
                                                            CommandName="Insert" CssClass="LinkButton" Text="Upload" OnClick="lbInsert_Click"></asp:LinkButton></td>
                                                    <td align="right">
                                                        <asp:LinkButton ID="lbCancel" runat="server" CausesValidation="False"
                                                            CommandName="Cancel" CssClass="LinkButton" Text="Cancel"></asp:LinkButton></td>
                                                </tr>
                                            </table>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <InsertItemTemplate>
                                            <asp:Label ID="lblShowGridMsg" runat="server" CssClass="LabelMsg"
                                                Text="Uploaded document will appear in the grid below."></asp:Label>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                </Fields>
                            </asp:DetailsView>

                            <asp:ObjectDataSource ID="odsrcDocument" runat="server" SelectMethod="GetDocumentByProjectId" TypeName="FactSheetApp.FactSheetNewTableAdapters.CFMIS_docTableAdapter" DeleteMethod="DeleteDocument" InsertMethod="Insert">
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="gvUpload" Name="DocId" PropertyName="SelectedValue" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="docName" Type="String" />
                                    <asp:Parameter Name="docType" Type="String" />
                                    <asp:Parameter Name="Description" Type="String" />
                                    <asp:Parameter Name="createdBy" Type="String" />
                                    <asp:Parameter Name="createdDate" Type="DateTime" />
                                    <asp:Parameter Name="doc" Type="Object" />
                                    <asp:Parameter Name="ProjectID" Type="Int32" />
                                    <asp:Parameter Name="DocSize" Type="Double" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="ProjectId" QueryStringField="project_pk" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>

                            <asp:Label ID="lblFileName" runat="server" Visible="False"></asp:Label>
                            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
                            <br />
                            <asp:UpdateProgress runat="server" ID="PageUpdateProgress" AssociatedUpdatePanelID="upAttachment">
                                <ProgressTemplate>
                                    <div align="center"><span class="text-alert" style="font-size: medium;">Please wait ...</span></div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>

                            <asp:UpdatePanel ID="upAttachment" runat="server">
                                <ContentTemplate>
                                    <br />
                                    <table style="width: 80%">
                                        <tr>
                                            <td align="left">Showing records <%=gvUpload.PageIndex * gvUpload.PageSize + 1%>- <%=(gvUpload.PageIndex * gvUpload.PageSize + gvUpload.Rows.Count)%>
                                                <asp:Label ID="lblTotalRec" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>

                                    <asp:GridView ID="gvUpload" runat="server" AutoGenerateColumns="False" DataKeyNames="docID"
                                        AllowPaging="True" AllowSorting="True" OnDataBound="gvUpload_DataBound" ForeColor="#333333"
                                        EmptyDataText="No data available" DataSourceID="odsrcDocument" Width="90%">
                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                        <Columns>
                                            <asp:BoundField DataField="docID" HeaderText="docID" InsertVisible="False" ReadOnly="True" SortExpression="docID" Visible="False" />
                                            <%--<asp:BoundField DataField="docName" HeaderText="Name" SortExpression="docName" />--%>
                                            <asp:TemplateField HeaderText="Document Name" SortExpression="docName">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDocName" runat="server" Text='<%# Bind("docName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="View File">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="hlViewFile" runat="server" Font-Underline="True"
                                                        NavigateUrl='<%# Eval("docID", "~/ShowDoc.aspx?docID={0}") %>' Target="_blank">View File</asp:HyperLink>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="docType" HeaderText="docType" SortExpression="docType" Visible="False" />
                                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" Visible="False" />
                                            <asp:BoundField DataField="createdBy" HeaderText="createdBy" SortExpression="createdBy" Visible="False" />
                                            <asp:BoundField DataField="createdDate" HeaderText="createdDate" SortExpression="createdDate" Visible="False" />
                                            <asp:BoundField DataField="ProjectID" HeaderText="ProjectID" SortExpression="ProjectID" Visible="False" />
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbDelete" runat="server" CausesValidation="False"
                                                        CommandName="Delete" CssClass="LinkButton" OnClientClick="return confirm('Are you certain you want to delete this Document?');"
                                                        Text="Delete"></asp:LinkButton>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="60px" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="DocSize" HeaderText="DocSize" SortExpression="DocSize" Visible="False" />
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White" />
                                        <EditRowStyle BackColor="#999999" />
                                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                        <PagerTemplate>
                                            <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" ForeColor="White" Enabled='<%#IIf((gvUpload.PageIndex) < 1, "false", "true")%>' CommandName="Page" OnClick="lbFirst_Click">&lt;&lt; First</asp:LinkButton>
                                            <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" ForeColor="White" Enabled='<%#IIf((gvUpload.PageIndex) < 1, "false", "true")%>' CommandName="Page" OnClick="lbPrev_Click">&lt; Prev</asp:LinkButton>
                                            [Records <%=gvUpload.PageIndex * gvUpload.PageSize + 1%> <%=gvUpload.PageIndex * gvUpload.PageSize + gvUpload.Rows.Count%><%=gvUpload.PageIndex + 1%>
                                            <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" ForeColor="White" Enabled='<%#IIf((gvUpload.PageCount) = (gvUpload.PageIndex + 1), "false", "true")%>' CommandName="Page" OnClick="lbNext_Click">Next &gt;</asp:LinkButton>
                                            <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" ForeColor="White" Enabled='<%#IIf((gvUpload.PageCount) = (gvUpload.PageIndex + 1), "false", "true")%>' CommandName="Page" OnClick="lbLast_Click">Last &gt;&gt;</asp:LinkButton>
                                            <asp:Label ID="lblGoTo" runat="server" Text="Go to Pg:"></asp:Label>
                                            <asp:DropDownList ID="ddlPaging" runat="server" AutoPostBack="True" Height="21px" OnSelectedIndexChanged="ddlPaging_SelectedIndexChanged" Width="60px"></asp:DropDownList>
                                            <asp:Label ID="lblCurrentPg" runat="server"></asp:Label>
                                        </PagerTemplate>
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </ContentTemplate>

                      
                    </cc1:TabPanel>
                    <!-- end ....  Upload Tab-->
                    <!-- Sustainability tab Start Neil ....-->
                     <cc1:TabPanel ID="tpPanelSustainability" runat="server">
                        <HeaderTemplate>Sustainability</HeaderTemplate>
                         <ContentTemplate>
                                    <center>
                                         <h2>Construction and Facilities Management Information System</h2>
                                    </center>
                                    <center>
                                        <h3 style="background-color:deepskyblue; font-size:x-large">Sustainability Questionnaire</h3>
                                        <div style="background-color:aqua">
                                    </center>
                            <div style="background-color:#e6ecff">
                             <asp:panel ID="PnlNumberOfBuildings" runat="server">
                             <span style="width:300px;font-size:x-large;">Instructions to Users:</span><br /><span>Please report the following information to help validate compliance with sustainability.</span><br /><span>requirements. This information is required for BUILDINGS ONLY. Please report on </span>
                                    <span style="border-bottom: 3px solid grey;">each building </span><span>of the project phase</span><br />
                                    <span style="color:red;">* Required</span><br /><br />
    </form>                         <span style="color:red;">* </span>&nbsp;&nbsp;<span style="font-size:large;">Number of buildings in this phase</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                        <span style="font-size:large;width:400px;">
                                            <asp:DropDownList ID="ddSustCoord" OnSelectedIndexChanged_="ddSustCoord_OnSelectedIndexChanged" AutoPostBack="True" runat="server">
                                                  <asp:ListItem Value="O"> Please select </asp:ListItem>
                                                  <asp:ListItem Value="1">1</asp:ListItem>
                                                  <asp:ListItem Value="2">2</asp:ListItem>
                                                  <asp:ListItem Value="3">3</asp:ListItem>
                                                  <asp:ListItem Value="4">4</asp:ListItem>
                                                <asp:ListItem Value="5">5</asp:ListItem>
                                                <asp:ListItem Value="6">6</asp:ListItem>
                                                <asp:ListItem Value="7">7</asp:ListItem>
                                                <asp:ListItem Value="8">8</asp:ListItem>
                                                <asp:ListItem Value="9">9</asp:ListItem>
                                                <asp:ListItem Value="10">10</asp:ListItem>
                                                <asp:ListItem Value="11">11</asp:ListItem>
                                                <asp:ListItem Value="12">12</asp:ListItem>
                                                <asp:ListItem Value="13">13</asp:ListItem>
                                                <asp:ListItem Value="14">14</asp:ListItem>
                                                <asp:ListItem Value="15">15</asp:ListItem>
                                                <asp:ListItem Value="16">16</asp:ListItem>
                                                <asp:ListItem Value="17">17</asp:ListItem>
                                                <asp:ListItem Value="18">18</asp:ListItem>
                                                <asp:ListItem Value="19">19</asp:ListItem>
                                                <asp:ListItem Value="20">20</asp:ListItem>
                                                <asp:ListItem Value="21">21</asp:ListItem>
                                                <asp:ListItem Value="22">22</asp:ListItem>
                                                <asp:ListItem Value="23">23</asp:ListItem>
                                                <asp:ListItem Value="24">24</asp:ListItem>
                                                <asp:ListItem Value="25">25</asp:ListItem>
                                            </asp:DropDownList></span><br />
                                        <br/><br/>
                                 </asp:Panel>
                                        <div style="background-color:#e6ecff;color:#000">
                                        <div style="background-color:#e6ecff">
                           
                            <asp:Panel ID="PnlGeneralInfo" BackColor="#E6ECFF" BorderStyle="Solid" runat="server">
                                 <br/>
                                <span style="font-size:x-large">  Building <% Response.Write((HttpContext.Current.Session("BldgNbr"))) %></span>&nbsp;
                               
                                <span style="color:red;">* </span>&nbsp;<span style="width:400px"><asp:TextBox ID="txtBuildingName" runat ="server"></asp:TextBox></span><br />
                                
                                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="vertical-align:top">Building Name</span><br />
                                <span style="font-size:x-large;float:left;width:400px">General Information</span>&nbsp;<br /><br />
                                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:large;float:left;margin-left:5px;">Building Description:</span>
                                 <span style="float:right;vertical-align:middle;margin-right:5px">
                                    <asp:textbox  ID="txtBldgDesc" Width="500px" TextMode="MultiLine"  Height="40px" runat="server"></asp:textbox>
                                 </span><br /><br />
                                    
                                  <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="float:left;vertical-align:auto;margin-left:5px;font-size:large;">Square Footage of construction work</span>
                                 <span style="float:right;margin-top:10px;margin-right:5px">
                                    <asp:textbox  ID="txtSqFtConst" Width="300px"  TextMode="Number" MaxLength="14"   runat="server"></asp:textbox>
                                 </span><br />

                                 <br /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="float:left;vertical-align:auto;margin-left:5px;font-size:large;">Square Footage of renovation work</span>
                                 <span style="float:right;margin-top:10px;margin-right:5px">
                                    <asp:textbox  ID="txtSqFtRenovation" Width="300px"  TextMode="Number"   runat="server"></asp:textbox>
                                 </span><br />

                                  <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="float:left;vertical-align:auto;margin-left:5px;font-size:large;">Square Footage of all work</span>
                                 <span style="float:right;margin-right:5px;margin-top:10px">
                                    <asp:textbox  ID="txtSqFtAll" Width="300px"  TextMode="Number"   runat="server" enabled="False"></asp:textbox>
                                 </span><br />

                                  <br /><span style="color:red;float:left">* </span>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="float:left;vertical-align:auto;margin-left:5px;font-size:large;">Date building design started</span>
                                 <span style="float:right;margin-top:10px;margin-right:5px">
                                    <asp:textbox  ID="txtDateDesignStarted" Width="300px"  TextMode="Date"   runat="server"></asp:textbox>
                                 </span><br/> <br/><br/>
                                <span style="margin-left:5px">

                                 <asp:Button ID="btnSaveGenInfo" runat="server" OnClick="btnSaveGenInfo_Click" Text="SAVE" Height="40px" Width="60px" Font-Bold="True" />                           
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </span>
                                  <asp:Button ID="btnNextBuilding" runat="server" OnClick="btnNext_Click" Text="Next Bldg" Height="40px" Width="80px" Font-Bold="True" />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                  <asp:Button ID="btnPrevBuilding" runat="server" OnClick="btnPrev_Click" Text="Prev Bldg"  Height="40px" Width="80px" Font-Bold="True" />
                                
                                <br/><br/>
                                </asp:Panel>
                               </div>
                              </div>
                              </div>
                             <br /><br />
                             <div style="background-color:#e6ecff"> 
                             <div style="background-color:#e6ecff">
                             <asp:Panel ID="PnlLeeds" BorderStyle="Solid" runat="server">
                                <p></p><p></p> <p></p>
                                <span style="font-size:x-large;float:left;width:400px">LEED Certification Requirements</span>&nbsp;<br /><br />
                               <span style="font-size:large;float:left;margin-left:5px">(For all buildings entering design on/after August 3, 2021)</span><br /><br />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="float:left;vertical-align:top;margin-left:5px;font-size:large;">Is the building required to achieve LEED certification?</span>
                                <span style="font-size:medium;float:right;margin-right:5px" >
                                    
                                        <asp:RadioButtonList ID="rdoLEEDRequired" runat="server"  RepeatDirection="Horizontal" OnSelectedIndexChanged="rdoLEEDRequired_OnSelectedIndexChanged" AutoPostBack="false">
                                            <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                            <asp:ListItem Value="No">No</asp:ListItem>
                                            <asp:ListItem Value="Unknown">Unknown</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </span>
                                    <br /><br />
                                    <span style="float:left;vertical-align:auto;margin-left:5px;font-size:large">Is the building registered in LEED online?</span>
                                 <span style="font-size:medium;float:right;margin-right:5px">
                                     <asp:RadioButtonList ID="rdRegisteredOnline" runat="server"  RepeatDirection="Horizontal" AutoPostBack="false">
                                            <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                            <asp:ListItem Value="No">No</asp:ListItem>
                                            <asp:ListItem Value="Unknown">Unknown</asp:ListItem>
                                        </asp:RadioButtonList>                                    
                                    </span>
                                    <br /><br />
                                     <span style="float:left;vertical-align:auto;margin-left:5px;font-size:large;">Provide the LEED registration number.</span>
                                 <span style="float:right;vertical-align:auto;margin-right:5px">
                                    <asp:textbox  ID="txtLeedRegistration"  Width="300px"  TextMode="Number"   runat="server"></asp:textbox>
                                 </span><br /><br />

                                 <span style="float:left;vertical-align:auto;margin-left:5px;font-size:large;">Is the project currently projected to achieve a minimum of LEED Silver certification?</span>
                                 <span style="font-size:medium;float:right;margin-right:5px" >
                                    <asp:RadioButtonList ID="rdoProjectedLeedSilver" runat="server"  RepeatDirection="Horizontal">
                                   <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                   <asp:ListItem Value="No">No</asp:ListItem>
                                   <asp:ListItem Value="Unknown">Unknown</asp:ListItem>
                               </asp:RadioButtonList>  
                                </span>
                                <br /><br />

                                     <span style="float:left;vertical-align:auto;margin-left:5px;font-size:large;">If the building is required to achieve LEED certification but is not projected to <br />achieve LEED Silver certification, has a waiver been approved by OFP  AED?</span><br /><br />
                                 <span style="font-size:medium;float:right;vertical-align:top;margin-right:5px" >
                                         <asp:RadioButtonList ID="rdoLeedWaiver" runat="server"  RepeatDirection="Horizontal">
                                            <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                            <asp:ListItem Value="No">No</asp:ListItem>
                                            <asp:ListItem Value="Unknown">Unknown</asp:ListItem>
                                        </asp:RadioButtonList>  
                                 </span>
                                          <br /><br /><br />

                                 <span style="float:left;vertical-align:auto;margin-left:5px;font-size:large">Certification status</span>
                                 <span style="font-size:medium;float:right;margin-right:5px" >
                                         <asp:RadioButtonList ID="rdoCertStatus" runat="server"  RepeatDirection="Horizontal">
                                            <asp:ListItem Value="Not Registered">Not Registered</asp:ListItem>
                                            <asp:ListItem Value="Registered">Registered</asp:ListItem>
                                            <asp:ListItem Value="Review">Review</asp:ListItem>
                                            <asp:ListItem Value="Certified">Certified</asp:ListItem>
                                        </asp:RadioButtonList> 
                                 </span><br /><br>

                                 <span style="float:left;width:150px;font-size:large;margin-left:5px; margin-bottom:0px">Date Certified</span><br />
                                 <span style="float:right;margin-bottom:50px;">

                                 <asp:textbox ID="txtDateCertifed" Width="100px" TextMode="Date"  runat="server"></asp:textbox>&nbsp;<br /><br />

                                 </span><br /><br />

                                <%--<span style=" font-size:large;float:left;margin-left:3px;">Certification Level Achieved</span>--%>
                                  <span style="float:left;width:250px;font-size:large;margin-left:5px">Certification Level Achieved</span>
                                 
 <span style="float:right;margin-bottom:40px;width:0PX">
 

   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddLEEDCertLevelAcheived" Width="105px"  runat="server">
        <asp:ListItem Value="0"> Please select </asp:ListItem>
             <asp:ListItem Value="Certified">Certified</asp:ListItem>
             <asp:ListItem Value="Silver">Silver</asp:ListItem>
             <asp:ListItem Value="Gold">Gold</asp:ListItem>
             <asp:ListItem Value="Platinum">Platinum</asp:ListItem>
   </asp:DropDownList>
</span><br /><br /><br /><br />

                                 <%--<h2 id="Leedbottom">Leedbottom</h2>
                                     <br /><br /><br />--%>
                                 <span style="margin-left:5px">
                                      <asp:Button ID="btnSaveLeed" runat="server" OnClick="btnSaveLEED_Click" Text="SAVE" Height="40px" Width="60px" Font-Bold="True" /> 
                                       </span>
                                       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                   
                                      <asp:Button ID="btnNextLEED" runat="server" OnClick="btnNext_Click" Text="Next Bldg" Height="40px" Width="80px" Font-Bold="True" />
                                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      <asp:Button ID="btnPrevLEED" runat="server" OnClick="btnPrev_Click" Text="Prev Bldg" Height="40px" Width="80px" Font-Bold="True" />
                                 <br /><br />
                               </asp:Panel>
                               </div>
                               </div>




                                
                       
                               <br /><br />
                             <div style="background-color:#e6ecff"> 
                             <div style="background-color:#e6ecff">
                               <asp:Panel ID="PnlNetZero" BorderStyle="Solid" runat="server">
                                   <span style="font-size:x-large;float:left;">Net-Zero Greenhouse Gas Emissions Design</span><br /><br /><br />
                                   <span style="float:left;vertical-align:auto;margin-left:5px;font-size:large;">Is this requirement applicable to this building?</span>
                                 <span style="font-size:medium;float:right;margin-right:5px" >
                                     <asp:RadioButtonList ID="rdoNetZApplicable" runat="server"  RepeatDirection="Horizontal">
                                            <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                            <asp:ListItem Value="No">No</asp:ListItem>
                                            <asp:ListItem Value="Unknown">Unknown</asp:ListItem>
                                        </asp:RadioButtonList> 
                                    </span>
                                  <br /><br />

                                    <span style="font-size:large;float:left;margin-left:5px;">If No, please explain?</span>
                                    <span style="float:right;vertical-align:middle;margin-right:5px">
                                       <asp:textbox  ID="txtNetZeroApplicableNoExplain" Width="300px" TextMode="MultiLine"  Height="80px" runat="server"></asp:textbox>
                                    </span><br /><br /><br /><br /><br />
                                    <br /><br /><br />
                                    

                                      <span style="float:left;vertical-align:auto;margin-left:5px;font-size:large;">is this building designed to utilize 100% carbon emissions-free energy?</span>
                                 <span style="font-size:medium;float:right;margin-right:5px" >
                                         <asp:radiobuttonlist id="rdonet100percentutilize" runat="server"  repeatdirection="horizontal">
                                            <asp:listitem value="Yes">Yes</asp:listitem>
                                            <asp:listitem value="No">No</asp:listitem>
                                            <asp:listitem value="Unknown">Unknown</asp:listitem>
                                        </asp:radiobuttonlist>
                                    </span>
                                   <br /><br />

                                     <%--<span style="font-size:large;float:left;margin-left:5px;">If No, please explain?</span>
                                    <span style="float:right;vertical-align:middle;margin-right:5px">
                                       <asp:textbox  ID="txtNetZero100PerCentNo" Width="300px" TextMode="MultiLine"  Height="80px" runat="server"></asp:textbox>
                                    </span><br /><br /><br /><br /><br />
                                    <br /><br /><br />--%>

                                    <span style="font-size:large;float:left;margin-left:5px;">Provide a narrative describing the building's Net-zero emissions strategy.</span>
                                 <span style="float:right;vertical-align:middle;margin-right:5px">
                                    <asp:textbox  ID="txtNarrative" Width="300px" TextMode="MultiLine"  Height="80px" runat="server"></asp:textbox>
                                 </span><br /><br /><br /><br /><br />
                                 <br /><br /><br />
                                    <span style="margin-left:5px">
                                      <asp:Button ID="btnSaveNetZero" runat="server" OnClick="btnSaveNetZero_Click" Text="SAVE" Height="40px" Width="60px" Font-Bold="True" />                           
                                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </span>
                                      <asp:Button ID="btnNextNetZero" runat="server" OnClick="btnNext_Click" Text="Next Bldg" Height="40px" Width="80px" Font-Bold="True" />
                                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      <asp:Button ID="btnPrevNetZero" runat="server" OnClick="btnPrev_Click" Text="Prev Bldg" Height="40px" Width="80px" Font-Bold="True" />
                                 <br /><br />
                                <br /><br />
                               </asp:Panel> 
                            </div>
                            </div>
                              <br /><br />
                            <div style="background-color:#e6ecff"> 
                            <div style="background-color:#e6ecff">
                               <asp:Panel id="PnlASHRAE" runat="server" BorderStyle="Solid">
    
      <span style="font-size:x-large;float:left;">Energy Efficient Design</span><br /><br />

     <span style=" font-size:large;float:left;margin-left:20px;">Applicable version of ASHRAE 90.1<br />See VA Sustainable Design manual and/CFR 433.3</span>


      <span style="float:left;margin-top:25px">

         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddASHRAEVersion" Width="150px"  runat="server">
              <asp:ListItem Value="0"> Please select </asp:ListItem>
                   <asp:ListItem Value="2004">2004</asp:ListItem>
                   <asp:ListItem Value="2007">2007</asp:ListItem>
                   <asp:ListItem Value="2010">2010</asp:ListItem>
                   <asp:ListItem Value="2013">2013</asp:ListItem>
                   <asp:ListItem Value="2019">2019</asp:ListItem>
         </asp:DropDownList>
      </span><br /><br /><br /><br />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=" font-size:large;float:left;margin-left:20px;">Is the building required to perform at least 30% better than the<br /> applicable version as ASHRAE 90.1 as required by 10 CFR 433.100</span><br /><br />
      
       <span style="font-size:medium;float:right;margin-right:5px;margin-top:2px" >
          <asp:RadioButtonList ID="rdoASHRAE30PerCent" runat="server"  RepeatDirection="Horizontal">
             <asp:ListItem Value="Yes">Yes</asp:ListItem>
             <asp:ListItem Value="No">No</asp:ListItem>
             <asp:ListItem Value="Unknown">Unknown</asp:ListItem>
         </asp:RadioButtonList>
     </span>
    <br /><br /><br />

     &nbsp;<span style=" font-size:large;float:left;margin-left:20px;">If the building will not to perform 30% better than the applicable<br /> version as ASHRAE 90.1 please enter an explanation.</span><br />
          <span style="float:right;vertical-align:middle;margin-right:5px">
       <asp:textbox  ID="txtNot30PerCentBetterExplanation" Width="300px" TextMode="MultiLine"  Height="80px" runat="server"></asp:textbox>
       </span><br /><br /><br /><br /><br />
       <br /><br /><br />
       <span style="margin-left:5px">


      <span style="float:left;width:800px;vertical-align:auto;font-size:large;margin-left:20px;">Percentage by which the energy design exceeds ASHRAE 90.1 baseline performance</span>



      <span style="float:right;vertical-align:auto;margin-right:5px;margin-bottom:40px;">

          <asp:textbox ID="txtExceedsBaseline" Width="100px" TextMode="Number" Text="None" runat="server"></asp:textbox>%

      </span><br /><br />

      <span style="float:left;width:900px;vertical-align:auto;font-size:large;margin-left:20px">If design does not meet 30% reduction requirement, is the design as<br /> energy efficient as determined to be cost-effective?</span>



      <span style="font-size:medium;float:right;margin-right:5px;margin-top:2px" >
          <asp:RadioButtonList ID="rdoCostEffective" runat="server"  RepeatDirection="Horizontal">
             <asp:ListItem Value="Yes">Yes</asp:ListItem>
             <asp:ListItem Value="No">No</asp:ListItem>
         </asp:RadioButtonList>
     </span><br /><br /><br /><br /><br />

       <span style="font-size:large;float:left;margin-left:20px;">If energy efficient is NOT determined to be cost-effective please provide an explanation below.</span>
         <span style="float:right;vertical-align:middle;margin-right:5px">
            <asp:textbox  ID="txtDesignNotCostEffective" Width="300px" TextMode="MultiLine"  Height="80px" runat="server"></asp:textbox>
         </span><br /><br /><br /><br /><br />
         <br /><br /><br />

      <span style="float:left;width:800px;vertical-align:auto;font-size:large;margin-left:20px">Check here if final<br /></span>

        
       <span style="float:right;">

          <asp:Checkbox ID="chkFinal" Font-Size="X-Large"  Width="10px" runat="server"   ClientIDMode="Static"/></asp:Checkbox>
          &nbsp; &nbsp; &nbsp;
       </span><br /><br />
       <span style="float:left;width:900px;vertical-align:auto;font-size:large;margin-left:20px">Date Design Completed<br /></span>
      <span style="float:right;vertical-align:auto;margin-right:5px;margin-bottom:40px;">

          <asp:textbox ID="txtDateDesignComplete" Width="100px" TextMode="Date"  runat="server"></asp:textbox><br /><br /><br /><br />

      </span><br /><br /><br /><br />
      <span style="margin-left:5px">
       <asp:Button ID="btnSaveASHRAE" runat="server" OnClick="btnSaveASHRAE_Click" Text="SAVE" Height="40px" Width="100px" Font-Bold="True" />                           
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         </span>
       <asp:Button ID="btnNextASHRAE" runat="server" OnClick="btnNext_Click" Text="Next Bldg" Height="40px" Width="100px" Font-Bold="True" />
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <asp:Button ID="btnPrevASHRAE" runat="server" OnClick="btnPrev_Click" Text="Prev Bldg" Height="40px" Width="100px" Font-Bold="True" /><br /><br /><br /><br />
</asp:Panel>
                               </div>
                               </div>
                              </div>
                             </div>
                            </div>
                         </ContentTemplate>
                      </cc1:TabPanel>LEED_
                </cc1:TabContainer>
            </td>
        </tr>
    </table>
    <%--<script src="Content/js/projectDetails.js" type="text/javascript"></script>--%>
    <script type="text/javascript">
        function toggleconntent(menu1) {
            $('#' + menu1).toggle();
        }
        function EndRequestHandler(sender, args) {
            $("#MainContent_tcProjectDetails_tpMainInfo_ddlManagerRoles").See VA Sustainable Design manual 2();
            $("#MainContent_tcProjectDetails_tpMainInfo_ddlPersonnel").select2();
        }

        $(document).ready(function () {
            $("#MainContent_tcProjectDetails_tpMainInfo_ddlManagerRoles").select2();
            $("#MainContent_tcProjectDetails_tpMainInfo_ddlPersonnel").select2();
        });

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

        var acc = document.getElementsByClassName("accordion");
        var i;

        for (i = 0; i < acc.length; i++) {
            acc[i].addEventListener("click", function () {
                this.classList.toggle("active");
                var panel = this.nextElementSibling;
                if (panel.style.display === "block") {
                    panel.style.display = "none";
                } else {
                    panel.style.display = "block";
                }
            });
        }
    </script>
</asp:Content>
