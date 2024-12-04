<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SiteEnv.Master" CodeBehind="EnvironmentalStaffForm.aspx.vb" Inherits="CFMISNew.EnvironmentalStaffForm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" />
    <link href="Content/bootstrap-grid.css" rel="stylesheet" />
    <script type="text/javascript" src="Scripts/jquery-3.0.0.js"></script>

<style type="text/css">
       lblHdg {
           font-size: 100px
       }
 
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
               font-size: 14px;
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainMenu" runat="server">
    <table class="mainHeader">
        <tr>
            <td style="text-align: right; vertical-align: top; padding: 5px;">
                <p>

                    <asp:Label ID="lblUserNm" runat="server"></asp:Label>

                </p>
            </td>
        </tr>
    </table>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cphQuickMenu" runat="server">
    <table>
        <tr>
            <td align="right" style="padding-left: 25px">
                <asp:ImageButton ID="ibHome" runat="server" ImageUrl="~/Images/Home.png" CssClass="ImgButton" CausesValidation="false" ToolTip="Home" />
            </td>
            <td align="right" style="padding-left: 5px">
                <asp:ImageButton ID="ibSearch" runat="server" ImageUrl="~/Images/Search.png" CssClass="ImgButton" CausesValidation="false" ToolTip="Search" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

     <div style="text-align: center; background-color: #b3ccff;padding-top:5px;padding-bottom:5px;font-size:15px">
        <b> Environmental Staff SME’s Form  </b>
    </div>
    <div style="width: 88%; padding-left: 5%; font-size: 15px">
           

        <div class="accordionMenu">
            <!-- 1st menu -->
            <input type="radio" id="acc1" onclick="toggleconntent('content1')" />
            <label for="acc1"><b>PROJECT OVERVIEW</b></label>
            <div class="content" id="content1">
                <div class="inner" style="background-color: white">
                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblPojectoffice" runat="server" Text="Project Office:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtProjectOffice" runat="server" CssClass="txtwidth" disabled Width="100%"></asp:TextBox>
                            </div>
                            <div class="col">
                                <asp:Label ID="lblProjectnumber" runat="server" Text="Project Number:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtProjectnumber" runat="server" CssClass="txtwidth" disabled Width="100%"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="container" style="padding-top: 15px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblLocation" runat="server" Text="Location:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtLocation" runat="server" CssClass="txtwidth" disabled Width="100%"></asp:TextBox>
                            </div>
                            <div class="col">
                                <asp:Label ID="lblPm" runat="server" Text="Project Manager(PM):" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtPm" runat="server" CssClass="txtwidth" disabled Width="100%"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="container" style="padding-top: 15px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblDescription" runat="server" Text="Description:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtDescription" runat="server" CssClass="txtwidth" disabled Width="100%"></asp:TextBox>
                            </div>
                            <div class="col">
                                <asp:Label ID="lblPrjbookawarddate" runat="server" Text="Project Book Award Date:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                <textarea id="txtPrjbookawarddate" runat="server" cols="10" rows="5" style="width: 100%;" disabled></textarea>

                            </div>
                        </div>
                    </div>
                    <div class="container" style="padding-top: 15px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblPrjbookcompletiondate" runat="server" Text="Project Book Completion Date:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                <textarea id="txtPrjbookcompletiondate" runat="server" cols="10" rows="5" style="width: 100%;" disabled></textarea>
                            </div>
                            <div class="col">
                                <asp:Label ID="Label1" runat="server" Text="Design Award Date:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
<%--                                <asp:TextBox ID="txtDesignawrddate" runat="server" CssClass="txtwidth" disabled></asp:TextBox>--%>
                                <textarea id="txtDesignawrddate" runat="server" cols="10" rows="5" style="width: 100%;" disabled></textarea>

                            </div>
                        </div>
                    </div>
                    <div class="container" style="padding-top: 15px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblFyantcptaedconstawddate" runat="server" Text="Anticipated Construction Award Date:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
<%--                                <asp:TextBox ID="txtFyantcptaedconstawddate" runat="server" CssClass="txtwidth" disabled></asp:TextBox>--%>
                                <textarea id="txtFyantcptaedconstawddate" runat="server" cols="10" rows="5" style="width: 100%;" disabled></textarea>

                            </div>
                            <div class="col">

                            </div>
                            <div class="col">

                            </div>
                        </div>
                    </div>
                    <asp:Label ID="lblNotes" runat="server" Text="Notes:" Font-Bold="false" Font-Underline="true"></asp:Label>
                    <br />
                    <textarea id="txtNotes" runat="server" cols="15" rows="5" style="width: 99%;"></textarea>
                    <br />
                    <br />
                </div>
            </div>
            <!--2nd Menu -->
            <input type="radio" id="acc2" onclick="toggleconntent('content2')" />
            <label for="acc2"><b>CFM ENVIRONMENTAL CONTRACT SUMMARY</b></label>
            <div class="content" id="content2">
                <div class="inner" style="background-color: white">

<!-- begin rvb -->

                <div class="inner" style="background-color: white">
                    <table class="table" style="width:100%">
                        <thead>
                            <tr>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Schedule</th>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Prospectus <br />(Baseline)</th>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Original <br />(Projected)</th>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Revised</th>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Actual</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr  onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <th scope="row" style="text-align:left;font-weight:normal">Environmental Contract Award:</th>
                                <td>
                                    <asp:TextBox ID="txtEnvcontractawardproswpectus" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtEnvcontractawardoriginal" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtEnvcontractawardrevised" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtEnvcontractawardactual" runat="server" CssClass="datepicker"></asp:TextBox>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                    <br />

<!-- end rvb -->


                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblEnvcontracreq" runat="server" Text="Environmental Contract Required:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:DropDownList ID="ddlEnvvontracreq" runat="server" CssClass="txtwidth" Width="100%">
                                    <asp:ListItem Text="Please Select One"></asp:ListItem>
                                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col">
                                <asp:Label ID="lblEnvsowcompldate" runat="server" Text="Envi Contract SOW Completed Date:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                              <asp:TextBox ID="txtEnvsowcompldate" runat="server"  CssClass="datepicker" Width="100%"></asp:TextBox>

                            </div>
                        </div>
                    </div>
                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblContractstatus" runat="server" Text="Contract Status:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtContractstatus" runat="server" CssClass="txtwidth" Width="100%"></asp:TextBox>
                            </div>
                            
                            <div class="col">
                                <asp:Label ID="lblContractbaseawardamt" runat="server" Text="Contract Base Awarded Amount($):" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtContractbaseawardamt" runat="server" CssClass="txtwidth" Width="100%"></asp:TextBox>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" 
       ControlToValidate="txtContractbaseawardamt" 
       ValidationExpression="^(?:\d|[,\.])+$"
       runat="server" 
       Display="Dynamic" 
       CssClass="validator"
       SetFocusOnError="true"
       ForeColor="Red"
       Text="Contract Base Awarded Amount must be a valid number">
</asp:RegularExpressionValidator>

                            </div>

                        </div>
                    </div>
                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblContrbasedoptionawrd" runat="server" Text="Contract Base Awarded Amount($):" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtContrbasedoptionawrd" runat="server" CssClass="txtwidth" Width="100%"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RepRateRegExVal" 
       ControlToValidate="txtContrbasedoptionawrd" 
       ValidationExpression="^(?:\d|[,\.])+$"
       runat="server" 
       Display="Dynamic" 
       CssClass="validator"
       SetFocusOnError="true"
       ForeColor="Red"
       Text="Contract Base + Option must be a valid number">
</asp:RegularExpressionValidator>
                            </div>
                            <div class="col">
                            </div>
                            <div class="col">
                            </div>

                        </div>
                    </div>
                <br />

                    <asp:Label ID="lblNotesenvcontractsummary" runat="server" Text="Notes:" Font-Bold="false" Font-Underline="true"></asp:Label>
                    <br />
                    <textarea id="txtNotesenvcontractsummary" runat="server" cols="15" rows="5" style="width: 99%;"></textarea>
                    <br />
                    <br />
                </div>
            </div>

            <!--3rd Menu -->
            

            <input type="radio" id="acc3" onclick="toggleconntent('content3')" />
             <label for="acc3"><b>DUE DILIGENCE REPORTS</b></label>
            <div class="content" id="content3" style="background-color: white">

<!-- begin rvb -->

                <div class="inner" style="background-color: white">
                    <table class="table" style="width:100%">
                        <thead>
                            <tr>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Schedule</th>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Prospectus<br/>(Baseline)</th>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Original<br />(Projected)</th>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Revised</th>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Actual</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr  onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <th scope="row" style="text-align:left;font-weight:normal">Due diligence (Environmental Background Reports Completed):</th>
                                <td>
                                    <asp:TextBox ID="txtDuedilligeneceprospectus" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtDuedilligeneceoriginal" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtDuedilligenecerevised" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtDuedilligeneceactual" runat="server" CssClass="datepicker"></asp:TextBox></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                    <br />

<!-- end rvb -->

                <div class="inner">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="1">
                                <asp:CheckBox ID="chkTrafficReport" runat="server" />
                                Traffic Report<br />
                                <asp:CheckBox ID="chkRegulatoryReport" runat="server" />
                                Regulatory Report<br />
                                <asp:CheckBox ID="chkCulturalAndHistoric" runat="server" />
                                Cultural and Historic Resources Report<br />
                                <asp:CheckBox ID="chkUtilityReport" runat="server" />
                                Utility Report<br />
                                <asp:CheckBox ID="chkAirQualityReport" runat="server" />
                                Air Quality Report<br />
                                <asp:CheckBox ID="chkPhaseIEnvReport" runat="server" />
                                Phase I Environmental Condition of Property Report<br />

                            </td>
                            <td colspan="2">
                                <asp:CheckBox ID="chkStakeholderReport" runat="server" />
                                Stakeholder Report<br />
                                <asp:CheckBox ID="chkNoiseReport" runat="server" />
                                Noise Report
                                <br />
                                <asp:CheckBox ID="chkHydrologyStormwaterReport" runat="server" />
                                 Hydrology/Stormwater Report <br />
                                <asp:CheckBox ID="chkLBPReport" runat="server" />
                                LBP Report<br />
                                <asp:CheckBox ID="chkAsbestosReport" runat="server" />
                                Asbestos Report<br />
                            </td>
                            <td colspan="3">
                                <asp:CheckBox ID="chkWetlandsReport" runat="server" />
                                Wetlands Report<br />
                                <asp:CheckBox ID="chkEngSpeciesActReport" runat="server" />
                                Endangered Species Act Report<br />
                                <asp:CheckBox ID="chkGeoTechnicalReport" runat="server" />
                                Geo-technical Report
                                <br />
                                <asp:CheckBox ID="chkTopographicSurveyReport" runat="server" />Topographic Survey Report
                                <br />
                                <asp:CheckBox ID="chkPhaseIIESA" runat="server" />
                                Phase II ESA<br />
                            </td>
                        </tr>
                    </table>

                    <br />

                    <asp:Label ID="lblDueDiligenceReportsNote" runat="server" Text="Notes:" Font-Bold="false" Font-Underline="true"></asp:Label>
                    <br />
                    <textarea id="txtDueDiligenceReportsNote" runat="server" cols="15" rows="5" style="width: 99%;"></textarea>
                    <br />
                    <br />

                </div>
            </div>

            <!--4th Menu -->
            <input type="radio" id="acc4" onclick="toggleconntent('content4')" />
            <label for="acc4"><b>NEPA SUMMARY AND STATUS</b></label>
            <div class="content" id="content4">
                <div class="inner" style="background-color: white">

<!-- begin rvb -->

                <div class="inner" style="background-color: white">
                    <table class="table" style="width:100%">
                        <thead>
                            <tr>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Schedule</th>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Prospectus <br />(Baseline)</th>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Original <br />(Projected)</th>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Revised</th>
                                <th scope="col" style="text-align:left;font:bold 13px arial">Actual</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr  onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <th scope="row" style="text-align:left;font-weight:bold">NEPA Documentation Milestone Schedule:</th>
                                <td>
<%--                                    <asp:TextBox ID="txtNepadocumentationmilestonescheduleprospectus" runat="server" CssClass="datepicker"></asp:TextBox>--%>
                                </td>
                                <td>
<%--                                    <asp:TextBox ID="txtNepadocumentationmilestonescheduleoriginal" runat="server" CssClass="datepicker"></asp:TextBox>--%>
                                </td>
                                <td>
<%--                                    <asp:TextBox ID="txtNepadocumentationmilestoneschedulerevised" runat="server" CssClass="datepicker"></asp:TextBox>--%>
                                </td>
                                <td>
<%--                                    <asp:TextBox ID="txtNepadocumentationmilestonescheduleactual" runat="server" CssClass="datepicker"></asp:TextBox>--%>
                                </td>
                            </tr>
                            <tr  onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <th scope="row" style="text-align:left;font-weight:normal">Anticipated NEPA documentation Kickoff:</th>
                                <td>
                                    <asp:TextBox ID="txtAnticipatednepadocumentationkickoffprospectus" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatednepadocumentationkickofforiginal" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatednepadocumentationkickoffrevised" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatednepadocumentationkickoffactual" runat="server" CssClass="datepicker"></asp:TextBox></td>
                            </tr>
                            <tr  onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <th scope="row" style="text-align:left;font-weight:normal">Anticipated Draft NEPA Document Date:</th>
                                <td>
                                    <asp:TextBox ID="txtAnticipateddraftnepadocumentdateprospectus" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipateddraftnepadocumentdateoriginal" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipateddraftnepadocumentdaterevised" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipateddraftnepadocumentdateactual" runat="server" CssClass="datepicker"></asp:TextBox></td>
                            </tr>
                            <tr  onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <th scope="row" style="text-align:left;font-weight:normal">Anticipated Final NEPA Document: </th>
                                <td>
                                    <asp:TextBox ID="txtAnticipatedfinalnepadocumentprospectus" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatedfinalnepadocumentoriginal" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatedfinalnepadocumentrevised" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatedfinalnepadocumentactual" runat="server" CssClass="datepicker"></asp:TextBox></td>
                            </tr>
                            <tr  onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <th scope="row" style="text-align:left;font-weight:normal">Anticipated NEPA Decision (FONSI/ROD):</th>
                                <td>
                                    <asp:TextBox ID="txtAnticipatednepadecisionfonsiprospectus" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatednepadecisionfonsioriginal" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatednepadecisionfonsirevised" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatednepadecisionfonsiactual" runat="server" CssClass="datepicker"></asp:TextBox></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <br />
<!-- end rvb  -->

                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblReuirednepadocnlevel" runat="server" Text="Required NEPA Documentation Level:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:DropDownList ID="ddlRequirednepadocnlevel" runat="server" CssClass="txtwidth" DataSourceID="sdsrclkNEPADoc"
                                        DataTextField="docName" DataValueField="NEPA_pk" AppendDataBoundItems="True" Width="100%">
                                    <asp:ListItem Text="Please Select One"></asp:ListItem>
                                </asp:DropDownList>

                                <asp:SqlDataSource ID="sdsrclkNEPADoc" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                                         SelectCommand="SELECT NEPA_pk, docName FROM lkNEPADoc ORDER BY docName"></asp:SqlDataSource>

                            </div>
                            <div class="col">
                                <asp:Label ID="Label3" runat="server" Text="NEPA Status:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:DropDownList ID="ddlNepastatus" runat="server" CssClass="txtwidth" Width="100%">
                                    <asp:ListItem Text="Please Select One"></asp:ListItem>
                                    <asp:ListItem Text="Not Started" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="In Progress" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Complete" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
<%--                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblKickoffmeetingdate" runat="server" Text="Kickoff Meeting Date NOI:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtKickoffmeetingdate" runat="server"  CssClass="datepicker" Width="100%"></asp:TextBox>
                            </div>
                            <div class="col">
                                <asp:Label ID="lblDrafteaeisdate" runat="server" Text="Draft EA/EIS Date:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtDrafteaeisdate" runat="server"  CssClass="datepicker" Width="100%"></asp:TextBox>
                            </div>
                        </div>
                    </div>--%>
<%--                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblNoadeadlinedate" runat="server" Text="NOA Deadline Date:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                    <asp:TextBox ID="txtNoadeadlinedate" runat="server"  CssClass="datepicker" Width="100%"></asp:TextBox>
                            </div>
                            <div class="col">
                                <asp:Label ID="lblFinaleaeisdate" runat="server" Text="Final EA/EIS Date:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                    <asp:TextBox ID="txtFinaleaeisdate" runat="server" CssClass="datepicker" Width="100%"></asp:TextBox>
                            </div>
                        </div>
                    </div>--%>
                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblFonsirodsigned" runat="server" Text="FONSI/ROD Signed:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:DropDownList ID="ddlfonsirodsigneddate" runat="server" CssClass="txtwidth" Width="100%">
                                    <asp:ListItem Text="Please Select One" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col">
                            </div>
                            <div class="col">
                            </div>

<%--                            <div class="col">
                                <asp:Label ID="lblFonsiroddate" runat="server" Text="FONSI/ROD Date:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtFonssiroddate" runat="server" CssClass="datepicker" Width="100%"></asp:TextBox>
                            </div>--%>
                        </div>
                    </div>
                    <br />


                    <br />
                    <asp:Label ID="lblNEPASumStatNotes" runat="server" Text="Notes:" Font-Bold="false" Font-Underline="true"></asp:Label>
                    <br />
                    <textarea id="txtNEPASumStatNotes" runat="server" cols="15" rows="5" style="width: 99%;"></textarea>
                    <br />
                    <br />

                </div>
            </div>
            <!--5th Menu -->
            <input type="radio" id="acc5" onclick="toggleconntent('content5')" />
            <label for="acc5"><b>PREVIOUSLY COMPLETED NEPA DOCUMENTATION</b></label>
            <div class="content" id="content5">
                <div class="inner" style="background-color: white">
                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblSupplementaleaeis" runat="server" Text="Is this a supplemental EA/EIS:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:DropDownList ID="ddlSupplemntaleaeis" runat="server" CssClass="txtwidth" Width="100%">
                                    <asp:ListItem Text="Please Select One"></asp:ListItem>
                                    <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                    <asp:ListItem Text="N/A" Value="NA"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col">
                                <asp:Label ID="lblPreviouseaseapea" runat="server" Text="Previous EA/SEA/PEA:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtpreviouseaseapea" runat="server" CssClass="txtwidth" Width="100%"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblDateofcompletionfinal" runat="server" Text="Date Of Completion Final:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtDateofcompletionfinal" runat="server" CssClass="datepicker" Width="100%"></asp:TextBox>
                            </div>
                            <div class="col">
                                <asp:Label ID="lblDateoffonsi" runat="server" Text="Date of FONSI:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtDateoffonsi" runat="server" CssClass="datepicker" Width="100%"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblEisfinal" runat="server" Text="EIS Final:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtEisfinal" runat="server" CssClass="txtwidth" Width="100%"></asp:TextBox>
                            </div>
                            <div class="col">
                                <asp:Label ID="lblEisrod" runat="server" Text="EIS ROD:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtEisrod" runat="server" CssClass="txtwidth" Width="100%"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblNepasignatory" runat="server" Text="NEPA Signatory:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtNepasignatory" runat="server" CssClass="txtwidth" Width="100%"></asp:TextBox>
                            </div>
                            <div class="col"></div>
                            <div class="col"></div>
                        </div>
                    </div>
                    <asp:Label ID="lblNepdocumentationcompletednotes" runat="server" Text="Notes:" Font-Bold="false" Font-Underline="true"></asp:Label>
                    <br />
                    <textarea id="txtNepdocumentationcompletednotes" runat="server" cols="15" rows="5" style="width: 99%;"></textarea>
                    <br />
                    <br />
                </div>
            </div>
             <!--6th Menu -->
            <input type="radio" id="acc6" onclick="toggleconntent('content6')" />
            <label for="acc6"><b>NHPA/ SECTION 106</b></label>
            <div class="content" id="content6">

                <div class="inner" style="background-color: white">



                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblNhpacosultation" runat="server" Text="NHPA Consultation Required:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:DropDownList ID="ddlNhpaconsultation" runat="server" CssClass="txtwidth" Width="100%">
                                    <asp:ListItem Text="Please Select One"></asp:ListItem>
                                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col">
                                <asp:Label ID="lblNhpaletterssent" runat="server" Text="NHPA Letters Sent:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtNhpalettersent" runat="server" CssClass="datepicker" Width="100%"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblnhpa30days" runat="server" Text="NHPA 30 Days:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtNhpa30days" runat="server" CssClass="datepicker" Width="100%"></asp:TextBox>
                            </div>
                            <div class="col">
                                <asp:Label ID="lblNhpamoapa" runat="server" Text="NHPA MOA/PA:" Font-Bold="false"></asp:Label>

                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtNhpamoapa" runat="server" CssClass="txtwidth" Width="100%"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="container" style="padding-top: 10px">
                        <div class="row">
                            <div class="col">
                                <asp:Label ID="lblNhpasignatory" runat="server" Text="NHPA Signatory:" Font-Bold="false"></asp:Label>
                            </div>
                            <div class="col">
                                <asp:TextBox ID="txtNhpasignatory" runat="server" CssClass="txtwidth" Width="100%"></asp:TextBox>
                            </div>
                            <div class="col">
                            </div>
                            <div class="col">
                            </div>
                            </div>
                    </div>
                  
                    <!-- begin rvb -->


										<div class="content" id="content1">
											<div class="inner">
												<table style="width: 100%">
													<tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
														<asp:HiddenField ID="hdnNHPA_fk_1" runat="server" Value="1" />
														<td style="width: 80%">
															<asp:Label ID="lblReuiredmessage" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
															Phase I Archaeological Survey
															<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage=" (Please select one)" ControlToValidate="rbPhase1" runat="server" ForeColor="Red" Display="Dynamic" />
														<td colspan="2">
															<asp:RadioButtonList ID="rbPhase1" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdbnselectionPhase1" AutoPostBack="true">
																<asp:ListItem Text="Yes" Value="1" />
																<asp:ListItem Text="No" Value="2" />
																<asp:ListItem Text="Unknown" Value="3" />
															</asp:RadioButtonList>
														</td>
													</tr>
													<asp:HiddenField ID="hdnNHPA_fk_4" runat="server" Value="4" />
													<tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" id="firsthdnquestionphase1" visible="false">
														<td colspan="1">
															<div id="dvPhase1" runat="server">
																Anticipated Date : 
															</div>
														</td>
														<td>
															<div id="dvPhase1AnticipatedDate" runat="server">
																<asp:TextBox type="text" ID="txtPhase1AnticipatedDate" runat="server" CssClass="datepicker"  />
															</div>
														</td>
													</tr>
													<tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" id="secondhdnquestionphase1" visible="false">
														<td colspan="1">
															<div id="dvPhase1ActualDate" runat="server">
																Actual Date : 
															</div>
														</td>
														<td>
															<div id="Div2" runat="server">
																<asp:TextBox type="text" ID="txtPhase1ActualDate" runat="server" CssClass="datepicker"/>
															</div>
														</td>
													</tr>


													<tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
														<asp:HiddenField ID="hdnNHPA_fk_2" runat="server" Value="2" />
														<td style="width: 80%">
															<asp:Label ID="Label2" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
															Phase II Archaeological Survey 
															<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage=" (Please select one)" ControlToValidate="rbPhase2" runat="server" ForeColor="Red" Display="Dynamic" />
														<td colspan="2">
															<asp:RadioButtonList ID="rbPhase2" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdbnselectionPhase2" AutoPostBack="true">
																<asp:ListItem Text="Yes" Value="1" />
																<asp:ListItem Text="No" Value="2" />
																<asp:ListItem Text="Unknown" Value="3" />
															</asp:RadioButtonList>
														</td>
													</tr>
													<asp:HiddenField ID="hdnNHPA_fk_5" runat="server" Value="5" />
													<tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" id="firsthdnquestionphase2" visible="false">
														<td colspan="1">
															<div id="dvPhase2Anticipated" runat="server">
																Anticipated Date : 
															</div>
														</td>
														<td>
															<div id="dvPhase2AnticipatedDate" runat="server">
																<asp:TextBox type="text" ID="txtPhase2AnticipatedDate" runat="server" CssClass="datepicker" />
															</div>
														</td>
													</tr>
													<tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" id="secondhdnquestionphase2" visible="false">
														<td colspan="1">
															<div id="dvPhase2Actual" runat="server">
																Actual Date : 
															</div>
														</td>
														<td>
															<div id="dvPhase2ActualDate" runat="server">
																<asp:TextBox type="text" ID="txtPhase2ActualDate" runat="server" CssClass="datepicker"/>
															</div>
														</td>
													</tr>

													<tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
														<asp:HiddenField ID="hdnNHPA_fk_3" runat="server" Value="3" />
														<td style="width: 80%">
															<asp:Label ID="Label4" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
															Additional Section 106 Consultation Requirements Resolution of Adverse Effects
															<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ErrorMessage=" (Please select one)" ControlToValidate="rbAdditionalSect106" runat="server" ForeColor="Red" Display="Dynamic" />
														<td colspan="2">
															<asp:RadioButtonList ID="rbAdditionalSect106" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdbnselectionAdditionalSect106" AutoPostBack="true">
																<asp:ListItem Text="Yes" Value="1" />
																<asp:ListItem Text="No" Value="2" />
																<asp:ListItem Text="Unknown" Value="3" />
															</asp:RadioButtonList>
														</td>
													</tr>
													<asp:HiddenField ID="hdnNHPA_fk_6" runat="server" Value="6" />
													<tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" id="firsthdnquestionAdditionalSect106" visible="false">
														<td colspan="1">
															<div id="dvAdditionalSectionAnticipated" runat="server">
																Anticipated Date : 
															</div>
														</td>
														<td>
															<div id="dvAdditionalSectionAnticipatedDate" runat="server">
																<asp:TextBox type="text" ID="txtAdditionalSect106AnticipatedDate" runat="server" CssClass="datepicker"/>
															</div>
														</td>
													</tr>
													<tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" runat="server" id="secondhdnquestionAdditionalSect106" visible="false">
														<td colspan="1">
															<div id="dvAdditionalSectionActual" runat="server">
																Actual Date : 
															</div>
														</td>
														<td>
															<div id="dvAdditionalSectionActualDate" runat="server">
																<asp:TextBox type="text" ID="txtAdditionalSect106ActualDate" runat="server" CssClass="datepicker"/>
															</div>
														</td>
													</tr>


												</table>

											</div>
										</div>
                    <br />
                    

                    <!-- end rvb -->
                    
                    <asp:Label ID="lblNhpanotes" runat="server" Text="NHPA Notes:" Font-Bold="false" Font-Underline="true"></asp:Label>
                    <br />
                    <textarea id="txtNhpanotes" runat="server" cols="15" rows="5" style="width: 99%;"></textarea>
                    <br />
                    <br />

                </div>
            </div>


            <!--7th Menu -->
            <input type="radio" id="acc7" onclick="toggleconntent('content7')" />
            <label for="acc7"><b>PROJECT COMMITMENTS AND ANNUAL REPORTING</b></label>
            <div class="content" id="content7">
                <div class="inner" style="background-color: white">
                    <br />

                    <asp:Label ID="lblWetlandmitigation" runat="server" Text="Wetland Mitigation:" Font-Bold="false" Font-Underline="true"></asp:Label>
                    <br />
                    <textarea id="txtWetlandmitigation" runat="server" cols="15" rows="5" style="width: 99%;"></textarea>
                    <br />
                    <br />

                    <asp:Label ID="lblNhpareportsstipulations" runat="server" Text="NHPA Reports/ Stipulations:" Font-Bold="false" Font-Underline="true"></asp:Label>
                    <br />
                    <textarea id="txtNhpareportsstipulations" runat="server" cols="15" rows="5" style="width: 99%;"></textarea>
                    <br />
                    <br />

                    <asp:Label ID="lblEsamitigation" runat="server" Text="ESA Mitigation:" Font-Bold="false" Font-Underline="true"></asp:Label>
                    <br />
                    <textarea id="txtEsamitigation" runat="server" cols="15" rows="5" style="width: 99%;"></textarea>
                    <br />
                    <br />

                    <asp:Label ID="lblCzma" runat="server" Text="CZMA:" Font-Bold="false" Font-Underline="true"></asp:Label>
                    <br />
                    <textarea id="txtCzma" runat="server" cols="15" rows="5" style="width: 99%;"></textarea>
                    <br />
                    <br />

                    <asp:Label ID="lblStormwater" runat="server" Text="Stormwater:" Font-Bold="false" Font-Underline="true"></asp:Label>
                    <br />
                    <textarea id="txtStormwater" runat="server" cols="15" rows="5" style="width: 99%;"></textarea>
                    <br />
                    <br />

                </div>
            </div>

            <br />
            <br />
            <br />
            <div style="text-align: center">

                    <asp:Button ID="btnSave" runat="server" Text="Save" Width="100px"  style="width: 25%; padding-top: 10px; padding-bottom: 10px;" OnClick="btnSave_Click" OnClientClick="if (!confirm('Are you sure you want save the records?')) return false;" />

            </div>


        </div>
    </div>
    <script type="text/javascript">
    function toggleconntent(menu1) {
        $('#' + menu1).toggle();
    }

    </script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript">
        $('.datepicker').each(function () {
            $(this).datepicker();
        });
    </script>

    </div>

</asp:Content>
