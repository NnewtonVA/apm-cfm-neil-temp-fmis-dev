<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/SiteEnv.Master" CodeBehind="EnviInitialResponseForm.aspx.vb" Inherits="CFMISNew.WebForm1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/UserControl/UCMenuAdmin.ascx" TagPrefix="uc1" TagName="UCMenuAdmin" %>
<%@ Register Src="~/UserControl/UCMenuGeneral.ascx" TagPrefix="uc1" TagName="UCMenuGeneral" %>
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

        .center {
            /*z-index: 1000;
           
            margin: auto;
            padding: 10px;
            padding-top: 20px width: 130px;
            background-color: White;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;*/
            margin: auto;
            width: 25%;
            padding: 10px;
        }

            .center img {
                height: 128px;
                width: 128px;
            }

        .loader {
            border: 8px solid #f3f3f3; /* Light grey */
            border-top: 8px solid #3498db; /* Blue */
            border-radius: 50%;
            /*width: 50px;
            height: 50px;*/
            animation: spin 2s linear infinite;
            position: fixed;
            margin: auto;
            width: 50%;
            padding: 10px;
            /*margin-left: auto;
  margin-right: auto;*/
            display: block;
            width: 200px;
            height: 200px;
            /*top: 0;
  left: 0;*/
            /*text-align: center;*/
            opacity: 0.7;
            background-color: #fff;
            z-index: 100000;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainMenu" runat="server">
    <table class="mainHeader">
        <tr>
            <td style="text-align: right; vertical-align: top; padding: 5px;">
                <p>
                    <%--                           <asp:Label ID="lblUser" runat="server"></asp:Label>
                        <asp:Label ID="lblRole" runat="server" ></asp:Label>--%>
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
                <asp:ImageButton ID="ibHome" runat="server" ImageUrl="~/Images/Home.png" CssClass="ImgButton" CausesValidation="false" ToolTip="Home" OnClick="ibHome_Click" />
            </td>
            <td align="right" style="padding-left: 5px">
                <asp:ImageButton ID="ibSearch" runat="server" ImageUrl="~/Images/Search.png" CssClass="ImgButton" CausesValidation="false" ToolTip="Search" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function toggleconntent(menu1) {
            $('#' + menu1).toggle();
        }

    </script>
    <!--begin RVB -->

    <div style="text-align: center; background-color: #b3ccff; padding-top: 5px; padding-bottom: 5px; font-size: 15px">
        <b>Environmental Questionnaire </b>
    </div>
    <div id="progressloading" class="center">
        <div class="loader" style="display: none">
        </div>
    </div>

    <div style="width: 88%; padding-left: 5%; font-size: 15px">

        <div class="accordionMenu">
            <!-- 1st menu  -->
            <input type="radio" id="acc1" onclick="toggleconntent('content1')">
            <label for="acc1"><b>GENERAL PROJECT QUESTION</b></label>
            <div class="content" id="content1" style="display: none">
                <div class="inner">
                    <table style="width: 100%">
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <asp:HiddenField ID="hdnSurvey_fk_1" runat="server" Value="1" />
                            <td style="width: 80%">
                                <asp:Label ID="Label16" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                1. Is the Project Share Point Accessible to Environmental?  <span id="msgChkSharePointAccessibleToEnvironmental" style="color: red"></span>
                            </td>
                            <td>
                                <input type="radio" id="chkYes" groupname="chkPinNo" value="1" style="display: initial" onclick="chkBoxSPAChange()" runat="server" disabled />
                                Yes
                                            <input type="radio" id="chkNo" groupname="chkPinNo" value="2" style="display: initial" onclick="chkBoxSPAChange()" runat="server" disabled />
                                No
                                            <input type="radio" id="chkunk" groupname="chkPinNo" value="3" style="display: initial" onclick="chkBoxSPAChange()" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <asp:HiddenField ID="hdnSurvey_fk_49" runat="server" Value="49" />
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvPinNo" style="display: none" runat="server">
                                    <asp:Label ID="Label44" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    1a.   Please provide link and access to Envi SME to Project Share Point here <span id="msgLinkToEnviSME" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvPinNo1" style="display: none" runat="server">
                                    <asp:TextBox type="text" ID="txtPinNo" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <asp:HiddenField ID="hdnSurvey_fk_2" runat="server" Value="2" />
                            <td colspan="1">
                                <asp:Label ID="lblRequiredmessage2" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                2.  Has this been documented in SEPS coordination with OCFM Regional Office Planners? <span id="msgSEPSCordination" style="color: red"></span>
                            </td>
                            <td>
                                <input type="radio" id="chksepsyes" name="chkseps" value="1" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" id="chksepsno" name="chkseps" value="2" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" id="chksepsunk" name="chkseps" value="3" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <asp:HiddenField ID="hdnSurvey_fk_3" runat="server" Value="3" />
                            <td colspan="1">
                                <asp:Label ID="lblRequiredmessage9" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                3. Is there a Recent Facility Master Plan? <span id="msgRcntfacilitymstrplan" style="color: red"></span>
                            </td>
                            <td>
                                <input type="radio" id="chkYesmp" value="1" name="chkMp" style="display: initial" onclick="chkboxshowhiderecentfacilitymasterplan()" runat="server" disabled />
                                Yes
                                            <input type="radio" id="chkNomp" value="2" name="chkMp" style="display: initial" onclick="chkboxshowhiderecentfacilitymasterplan()" runat="server" disabled />
                                No
                                            <input type="radio" id="chkunkmp" value="3" name="chkMp" style="display: initial" onclick="chkboxshowhiderecentfacilitymasterplan()" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <asp:HiddenField ID="hdnSurvey_fk_4" runat="server" Value="4" />
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvlanduse" style="display: none" runat="server">
                                    <asp:Label ID="Label45" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    3a. Is the project proposed for an existing site that is consistent with the land use/project in the Master Plan? <span id="msgLanduseoptions" style="color: red"></span>
                                    <span id="msgExistingsiteconsistent" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvlanduseopt" style="display: none" runat="server">
                                    <input type="radio" id="chkYescnslnd" value="1" name="chkcnslnd" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" id="chkNocnslnd" value="2" name="chkcnslnd" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" id="chkuncnslnd" value="3" name="chkcnslnd" style="display: initial" runat="server" disabled />
                                    Unknown
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <asp:HiddenField ID="hdnSurvey_fk_5" runat="server" Value="5" />
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvlnktomap" style="display: none" runat="server">
                                    <asp:Label ID="Label82" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    3b. Please provide link to Master Plan <span id="msglandmasterplan" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvlnkmp" style="display: none" runat="server">
                                    <asp:TextBox type="text" ID="txtPinNo2" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                <asp:HiddenField ID="hdnSurvey_fk_6" runat="server" Value="6" />
                                <asp:Label ID="Label21" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                4. Is the Project site consistent with the Market Study (VHA)? <span id="msgConsistentwithmarketstudy" style="color: red"></span>
                            </td>
                            <td>
                                <input type="radio" id="chkYesCcnsistentwithmarketstudy" value="1" name="consistentwithmarketstudy" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" id="chkNoconsistentwithmarketstudy" value="2" name="consistentwithmarketstudy" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" id="chkUnkconsistentwithmarketstudy" value="3" name="consistentwithmarketstudy" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                <asp:HiddenField ID="hdnSurvey_fk_50" runat="server" Value="50" />
                                <asp:Label ID="Label17" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                5. Does the site has an "Outlease" through ORP? <span id="msgoutleaseORP" style="color: red"></span>
                            </td>
                            <td colspan="2">

                                <input type="radio" id="chkYesoutleasethroughorp" name="Outleasethroughorp" value="1" style="display: initial" runat="server" disabled />
                                Yes


                                            <input type="radio" id="chkNooutleasethroughorp" name="Outleasethroughorp" value="2" style="display: initial" runat="server" disabled />
                                No


                                            <input type="radio" id="chkUnkoutleasethroughorp" name="Outleasethroughorp" value="3" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                <asp:HiddenField ID="hdnSurvey_fk_51" runat="server" Value="51" />
                                <asp:Label ID="Label18" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                6. Who is the ORP PM handling the "Outlease"? <span id="msgOrphandlingpm" style="color: red"></span>
                            </td>
                            <td colspan="2">

                                <input type="radio" id="chkYesorphandlingpm" value="1" name="orphandlingpm" style="display: initial" runat="server" disabled />
                                Yes


                                            <input type="radio" id="chkNoorphandlingpm" value="2" name="orphandlingpm" style="display: initial" runat="server" disabled />
                                No


                                            <input type="radio" id="chkUnkorphandlingpm" value="3" name="orphandlingpm" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                <asp:HiddenField ID="hdnSurvey_fk_52" runat="server" Value="52" />
                                <asp:Label ID="Label19" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                7. What is the expiration date of "Outlease"?  <span id="msgOutleaseexpirationdate" style="color: red"></span>
                            </td>
                            <td colspan="2">

                                <input type="radio" id="chkYesoutleaseexpirationdate" value="1" name="outleaseexpirationdate" style="display: initial" runat="server" disabled />
                                Yes


                                            <input type="radio" id="chkNooutleaseexpirationdate" value="2" name="outleaseexpirationdate" style="display: initial" runat="server" disabled />
                                No


                                            <input type="radio" id="chkUnkoutleaseexpirationdate" value="3" name="outleaseexpirationdate" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                <asp:HiddenField ID="hdnSurvey_fk_53" runat="server" Value="53" />
                                <asp:Label ID="Label20" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                8. Are there known easements for the site? <span id="msgKnowneasement" style="color: red"></span>
                            </td>
                            <td colspan="2">

                                <input type="radio" id="chkYesknowneasement" value="1" name="knowneasement" style="display: initial" runat="server" disabled />
                                Yes


                                            <input type="radio" id="chkNoknowneasement" value="2" name="knowneasement" style="display: initial" runat="server" disabled />
                                No


                                            <input type="radio" id="chkUnkknowneasement" value="3" name="knowneasement" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                <asp:HiddenField ID="hdnSurvey_fk_54" runat="server" Value="54" />
                                <asp:Label ID="Label22" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                9.  Where are the records of easements and who is the responsible ORP PM? <span id="msgOrprecordsofeasement" style="color: red"></span>
                            </td>
                            <td>
                                <asp:TextBox type="text" ID="txtOrprecordsofeasement" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 2nd menu -->
            <input type="radio" name="trg2" id="acc2" onclick="toggleconntent('content2')">
            <label for="acc2"><b>GENERAL ENVIRONMENTAL SITE CARACTERISTICS, RESOURCES, POTENTIAL IMPACTS</b></label>
            <div class="content" id="content2" style="display: none">
                <div class="inner">
                    <table style="width: 100%">
                        <div>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="width: 80%">
                                    <asp:Label ID="lblRequiredmessage3" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hdnSurvey_fk_90" runat="server" Value="90" />
                                    1. Please attach a general site map or project boundary map of the proposed project area. <span id="msgRealestateaction" style="color: red"></span>
                                </td>
                                <td>
                                    <div id="dvGnrlenv">
                                        <asp:TextBox type="text" ID="dvRealestateaction" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                    </div>
                                </td>
                            </tr>
                        </div>
                    </table>
                </div>
            </div>
            <!-- 3rd menu -->
            <input type="radio" name="trg3" id="acc3" onclick="toggleconntent('content3')">
            <label for="acc3"><b>LAND USE</b></label>
            <div class="content" id="content3" style="display: none">
                <div class="inner">
                    <table style="width: 100%">
                        <div>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="width: 80%">
                                    <asp:Label ID="lblRequiredmessage4" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hdnSurvey_fk_7" runat="server" Value="7" />
                                    1. Will the proposed action alter the present land use of the site?  <span id="msgProposedaction" style="color: red"></span>
                                </td>
                                <td colspan="2">
                                    <input type="radio" id="chkYespropactn" value="1" name="proposedaction" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" id="chkNopropactn" value="2" name="proposedaction" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" id="chkunkpropactn" value="3" name="proposedaction" style="display: initial" runat="server" disabled />
                                    Unknown
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1">
                                    <asp:Label ID="lblRequiremessage5" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hdnSurvey_fk_8" runat="server" Value="8" />
                                    2. Does the proposed action involve a real estate action (e.g., purchase, lease, easement, permit, or license, disposal)?  <span id="msgPairea" style="color: red"></span>
                                </td>
                                <td colspan="2">
                                    <input type="radio" id="chkYespairea" value="1" name="pairea" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" id="chkNopairea" value="2" name="pairea" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" id="chkunkpairea" value="3" name="pairea" style="display: initial" runat="server" disabled />
                                    Unknown
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvorpeffort" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_9" runat="server" Value="9" />
                                        <asp:Label ID="Label46" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        2a. Is ORP leading this effort, whom is the ORP PM - Name, email and phone # ?  <span id="msgRpeffortchk" style="color: red"></span>
                                    </div>
                                </td>
                                <td colspan="2">
                                    <div id="dvorpeffortchk" style="display: none" runat="server">
                                        <input type="radio" id="chkYesrpeffortchk" value="1" name="rpeffortchk" style="display: initial" runat="server" disabled />
                                        Yes
                                                    <input type="radio" id="chkNorpeffortchk" value="2" name="rpeffortchk" style="display: initial" runat="server" disabled />
                                        No
                                                    <input type="radio" id="chkunkrpeffortchk" value="3" name="rpeffortchk" style="display: initial" runat="server" disabled />
                                        Unknown
                                    </div>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvadnacres" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_10" runat="server" Value="10" />
                                        <asp:Label ID="Label47" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        2b. Require new purchase of additional acres using federal funds?  <span id="msgAdnacres" style="color: red"></span>
                                    </div>
                                </td>
                                <td colspan="2">
                                    <div id="dvchkadnacres" style="display: none" runat="server">
                                        <input type="radio" id="chkYesadnacres" value="1" name="adnacres" style="display: initial" runat="server" disabled />
                                        Yes
                                                    <input type="radio" id="chkNoadnacres" value="2" name="adnacres" style="display: initial" runat="server" disabled />
                                        No
                                                    <input type="radio" id="chkunkadnacres" value="3" name="adnacres" style="display: initial" runat="server" disabled />
                                        Unknown
                                    </div>
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvSizeofadnacres" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_11" runat="server" Value="11" />
                                        <asp:Label ID="Label48" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        2c. Provide size of additional acres needed. <span id="msgSizeofadnacres" style="color: red"></span>
                                    </div>
                                    <td colspan="2">
                                        <div id="dvSizeofadnacrestxtbox" style="display: none" runat="server">
                                            <asp:TextBox type="text" ID="txtSizeofadnacres" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                        </div>
                                    </td>
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvRequirenew" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_12" runat="server" Value="12" />
                                        <asp:Label ID="Label49" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        2d. Require a new lease, license, and/or land use permit? <span id="msgRequirenew" style="color: red"></span>
                                    </div>
                                    <td colspan="2">
                                        <div id="dvRequirenewchk" style="display: none" runat="server">
                                            <input type="radio" id="chkYesrequirenew" value="1" name="requirenew" style="display: initial" runat="server" disabled />
                                            Yes
                                                    <input type="radio" id="chkNorequirenew" value="2" name="requirenew" style="display: initial" runat="server" disabled />
                                            No
                                                    <input type="radio" id="chkunkrequirenew" value="3" name="requirenew" style="display: initial" runat="server" disabled />
                                            Unknown
                                        </div>
                                    </td>
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvIncreaseofacreage" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_13" runat="server" Value="13" />
                                        <asp:Label ID="Label50" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        2e. Would the action Require an increase of acreage/amendment to an existing lease or license? <span id="msgIncreaseofacreagechk" style="color: red"></span>
                                    </div>
                                    <td colspan="2">
                                        <div id="dvIncreaseofacreagechk" style="display: none" runat="server">
                                            <input type="radio" id="chkYesincreaseofacreagechk" value="1" name="increaseofacreagechk" style="display: initial" runat="server" disabled />
                                            Yes
                                                    <input type="radio" id="chkNoincreaseofacreagechk" value="2" name="increaseofacreagechk" style="display: initial" runat="server" disabled />
                                            No
                                                    <input type="radio" id="chkunkincreaseofacreagechk" value="3" name="increaseofacreagechk" style="display: initial" runat="server" disabled />
                                            Unknown
                                        </div>
                                    </td>
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvRealestatepoint" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_14" runat="server" Value="14" />
                                        <asp:Label ID="Label51" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        2f. From a Realestate standpoint will the project replace or dispose of existing federal facilities? <span id="msgRealestatepointchk" style="color: red"></span>
                                    </div>
                                    <td colspan="2">
                                        <div id="dvRealestatepointchk" style="display: none" runat="server">
                                            <input type="radio" id="chkYesrealestatepointchk" value="1" name="realestatepointchk" style="display: initial" runat="server" disabled />
                                            Yes
                                                    <input type="radio" id="chkNorealestatepointchk" value="2" name="realestatepointchk" style="display: initial" runat="server" disabled />
                                            No
                                                    <input type="radio" id="chkunkrealestatepointchk" value="3" name="realestatepointchk" style="display: initial" runat="server" disabled />
                                            Unknown
                                        </div>
                                    </td>
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1">
                                    <asp:Label ID="lblRequiredmessage6" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hdnSurvey_fk_15" runat="server" Value="15" />
                                    3. Will the project include procurement or leasing of temporary swing space off campus for staff or functions during the project?
                                                <span id="msgProcurmentorleasing" style="color: red"></span>
                                </td>
                                <td colspan="2">
                                    <input type="radio" id="chkYesprocurmentorleasing" value="1" name="procurmentorleasing" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" id="chkNoprocurmentorleasing" value="2" name="procurmentorleasing" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" id="chkunkprocurmentorleasing" value="3" name="procurmentorleasing" style="display: initial" runat="server" disabled />
                                    Unknown
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1">
                                    <asp:Label ID="lblReuiredmessage7" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hdnSurvey_fk_16" runat="server" Value="16" />
                                    4. Will any demolition be required as part of the project? <span id="msgDemolition" style="color: red"></span>
                                </td>
                                <td colspan="2">
                                    <input type="radio" id="chkYesdemolition" value="1" name="demolition" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" id="chkNodemolition" value="2" name="demolition" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" id="chkunkdemolition" value="3" name="demolition" style="display: initial" runat="server" disabled />
                                    Unknown
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvSqrfootagedemolition" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_17" runat="server" Value="17" />
                                        <asp:Label ID="Label52" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        4a. Provide square footage of demolition. <span id="msgSqrfootagedemolition" style="color: red"></span>
                                    </div>
                                    <td colspan="2">
                                        <div id="dvSqrfootagedemolitiontxtbox" style="display: none" runat="server">
                                            <asp:TextBox type="text" ID="txtSqrfootagedemolition" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                        </div>
                                    </td>
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1">
                                    <asp:HiddenField ID="hdnSurvey_fk_18" runat="server" Value="18" />
                                    <asp:Label ID="lblRequiredmessage7" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    5. Is the construction laydown footprint captured in the project area proposed footprint? <span id="msgFootprintcaptured" style="color: red"></span>
                                </td>
                                <td colspan="2">
                                    <input type="radio" id="chkYesfootprintcaptured" value="1" name="footprintcaptured" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" id="chkNofootprintcaptured" value="2" name="footprintcaptured" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" id="chkunkfootprintcaptured" value="3" name="footprintcaptured" style="display: initial" runat="server" disabled />
                                    Unknown
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1">
                                    <asp:HiddenField ID="hdnSurvey_fk_19" runat="server" Value="19" />
                                    <asp:Label ID="lblRequiredmessage8" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    6. Will a parking structure be needed? <span id="msgPkngstructure" style="color: red"></span>
                                </td>
                                <td colspan="2">
                                    <input type="radio" id="chkYespkngstructure" value="1" name="pkngstructure" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" id="chkNopkngstructure" value="2" name="pkngstructure" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" id="chkunkpkngstructure" value="3" name="pkngstructure" style="display: initial" runat="server" disabled />
                                    Unknown
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvAdnsqftgoverallprojectscope" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_20" runat="server" Value="20" />
                                        <asp:Label ID="Label53" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        6a. Is the additional Sq footage and parking structure taken into consideration in the overall project scope? <span id="msgAdnsqftgoverallprojectscope" style="color: red"></span>

                                    </div>
                                    <td colspan="2">
                                        <div id="dvChkadnsqftgoverallprojectscope" style="display: none" runat="server">
                                            <input type="radio" id="chkYesAdnsqftgoverallprojectscope" value="1" name="adnsqftgoverallprojectscope" style="display: initial" runat="server" disabled />
                                            Yes
                                                    <input type="radio" id="chkNoAdnsqftgoverallprojectscope" value="2" name="adnsqftgoverallprojectscope" style="display: initial" runat="server" disabled />
                                            No
                                                    <input type="radio" id="chkunkAdnsqftgoverallprojectscope" value="3" name="adnsqftgoverallprojectscope" style="display: initial" runat="server" disabled />
                                            Unknown
                                        </div>
                                    </td>
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvAppropriatesqfootage" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_21" runat="server" Value="21" />
                                        <asp:Label ID="Label54" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        6b. What is the approximate Sq footage of the needed parking structure <span id="msgchkAppropriatesqfootage" style="color: red"></span>
                                    </div>
                                    <td colspan="2">
                                        <div id="dvChkappropriatesqfootage" style="display: none" runat="server">
                                            <asp:TextBox type="text" ID="txtAppropriatesqfootage" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                        </div>
                                    </td>
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvProjectheight" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_22" runat="server" Value="22" />
                                        <asp:Label ID="Label55" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        6c. What is the project height of parking struture <span id="msgProjectheight" style="color: red"></span>
                                    </div>
                                    <td colspan="2">
                                        <div id="dvtxtprojectheight" style="display: none" runat="server">
                                            <asp:TextBox type="text" ID="txtProjectheight" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                        </div>
                                    </td>
                                </td>
                            </tr>
                        </div>
                    </table>
                </div>
            </div>
            <!-- 4th menu -->
            <input type="radio" name="trg4" id="acc4" onclick="toggleconntent('content4')">
            <label for="acc4"><b>SITE GEOLOGY AND SOIL SUITABILITY</b></label>
            <div class="content" id="content4" style="display: none">
                <div class="inner">
                    <table style="width: 100%">
                        <div>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td style="width: 80%">
                                    <asp:Label ID="lblReuiredmessage10" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hdnSurvey_fk_23" runat="server" Value="23" />
                                    1. Does the site have a current Environmental Site Assessment (ESA) Phase 1 (within last 2 yrs.)? <span id="msgEnvsiteassement" style="color: red"></span>
                                </td>
                                <td colspan="2">
                                    <input type="radio" id="chkYesenvsiteassement" value="1" name="envsiteassement" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" id="chkNoenvsiteassement" value="2" name="envsiteassement" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" id="chkunkenvsiteassement" value="3" name="envsiteassement" style="display: initial" runat="server" disabled />
                                    Unknown
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvlnktoreport" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_24" runat="server" Value="24" />
                                        <asp:Label ID="Label56" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        1a. Please attach or provide link to report.  <span id="msgLnktoreport" style="color: red"></span>
                                    </div>
                                </td>
                                <td colspan="2">
                                    <div id="dvTxtlnktoreport" style="display: none" runat="server">
                                        <asp:TextBox type="text" ID="txtLnktoreport" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                    </div>
                                </td>


                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvrecenvcondition" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_25" runat="server" Value="25" />
                                        <asp:Label ID="Label57" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        1b.  Are there any Recognized Environmental Condition (REC) indicated in the Phase I ESA?  <span id="msgRecenvcondition" style="color: red"></span>
                                    </div>
                                </td>

                                <td colspan="2">
                                    <div id="dvChkrecenvcondition" style="display: none" runat="server">
                                        <input type="radio" id="chkYesrecenvcondition" value="1" name="recenvcondition" style="display: initial" runat="server" disabled />
                                        Yes
                                                    <input type="radio" id="chkNorecenvcondition" value="2" name="recenvcondition" style="display: initial" runat="server" disabled />
                                        No
                                                    <input type="radio" id="chkunkrecenvcondition" value="3" name="recenvcondition" style="display: initial" runat="server" disabled />
                                        Unknown
                                    </div>

                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvbriefdscpn" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_26" runat="server" Value="26" />
                                        <asp:Label ID="Label58" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        1c. Please provide brief description if known. <span id="msgBriefdescription" style="color: red"></span>
                                    </div>
                                </td>

                                <td colspan="2">
                                    <div id="dvTxtbriefdscpn" style="display: none" runat="server">
                                        <asp:TextBox type="text" ID="txtbriefdscpn" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                    </div>
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1">
                                    <asp:Label ID="lblrequiredmessage10" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hdnSurvey_fk_27" runat="server" Value="27" />
                                    2. Have soil borings been conducted  to evaluate sub surface suitability for construction? <span id="msgSubsurfacesuitability" style="color: red"></span>
                                </td>
                                <td colspan="2">
                                    <input type="radio" id="chkYessubsurfacesuitability" value="1" name="subsurfacesuitability" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" id="chkNosubsurfacesuitability" name="subsurfacesuitability" value="2" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" id="chkunksubsurfacesuitability" name="subsurfacesuitability" value="3" style="display: initial" runat="server" disabled />
                                    Unknown
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvreportsoil" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_28" runat="server" Value="28" />
                                        <asp:Label ID="Label59" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        2a.  Please attached or provide link to report <span id="msgReportSoil" style="color: red"></span>
                                    </div>
                                </td>
                                <td colspan="2">
                                    <div id="dvChkreportsoil" style="display: none" runat="server">
                                        <asp:TextBox type="text" ID="txtReportSoil" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                    </div>
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dvhighgrndlevels" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_29" runat="server" Value="29" />
                                        <asp:Label ID="Label60" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        2b. If borings were done did it identify high groundwater levels? <span id="msgHighgrndlevels" style="color: red"></span>
                                    </div>
                                </td>
                                <td colspan="2">
                                    <div id="dvChkhighgrndlevels" style="display: none" runat="server">
                                        <input type="radio" id="chkYeshighgrndlevels" value="1" name="highgrndlevels" style="display: initial" runat="server" disabled />
                                        Yes
                                                    <input type="radio" id="chkNohighgrndlevels" value="2" name="highgrndlevels" style="display: initial" runat="server" disabled />
                                        No
                                                    <input type="radio" id="chkunkhighgrndlevels" value="3" name="highgrndlevels" style="display: initial" runat="server" disabled />
                                        Unknown
                                    </div>
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1" style="padding-left: 12px">
                                    <div id="dveffectconstruction" style="display: none" runat="server">
                                        <asp:HiddenField ID="hdnSurvey_fk_30" runat="server" Value="30" />
                                        <asp:Label ID="Label61" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                        2c. Will this effect construction? <span id="msgEffectconstruction" style="color: red"></span>
                                    </div>

                                </td>
                                <td colspan="2">
                                    <div id="dvChkeffectconstruction" style="display: none" runat="server">
                                        <input type="radio" value="1" id="chkYeseffectconstruction" name="effectconstruction" style="display: initial" runat="server" disabled />
                                        Yes
                                                    <input type="radio" value="2" id="chkNoeffectconstruction" name="effectconstruction" style="display: initial" runat="server" disabled />
                                        No
                                                    <input type="radio" value="3" id="chkunkeffectconstruction" name="effectconstruction" style="display: initial" runat="server" disabled />
                                        Unknown
                                    </div>
                                </td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <td colspan="1">
                                    <asp:Label ID="lblrequiredmessage11" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hdnSurvey_fk_31" runat="server" Value="31" />
                                    3. Where any known contaminants identified during soil borings or as part of the ESA Phase I that could impact construction or require mitigation prior to  or after construction? <span id="msgContainmentssoil" style="color: red"></span>
                                </td>
                                <td colspan="2">
                                    <input type="radio" id="chkYescontainmentssoil" value="1" name="containmentssoil" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" id="chkNocontainmentssoil" value="2" name="containmentssoil" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" id="chkunkcontainmentssoil" value="3" name="containmentssoil" style="display: initial" runat="server" disabled />
                                    Unknown
                                </td>
                            </tr>
                        </div>
                    </table>
                </div>
            </div>
            <!-- 5th menu -->
            <input type="radio" name="trg5" id="acc5" onclick="toggleconntent('content5')">
            <label for="acc5"><b>HAZARDOUS MATERIAL</b></label>
            <div class="content" id="content5" style="display: none">
                <div class="inner">
                    <table style="width: 100%">
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td style="width: 80%">
                                <asp:Label ID="lblrequiredmessage12" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                1. Is there any known contamination on site? <span id="msgHazordousmtrl" style="color: red"></span>
                                <asp:HiddenField ID="hdnSurvey_fk_32" runat="server" Value="32" />
                            </td>
                            <td colspan="2">
                                <input type="radio" id="chkYeshazordousmtrl" value="1" name="hazordousmtrl" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" id="chkNohazordousmtrl" value="2" name="hazordousmtrl" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" id="chkunkhazordousmtrl" value="3" name="hazordousmtrl" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                 <div id="dvcontainmentsdocn" style="display: none" runat="server">
                                <asp:Label ID="lblrequiredmessage13" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                1a. Is there any documentation of the known contamination?
                                            <span id="msgDcmntlimits" style="color: red"></span>
                                <asp:HiddenField ID="hdnSurvey_fk_33" runat="server" Value="33" />
                                     </div>
                            </td>
                            <td colspan="2">
                                  <div id="dvcontainmentsdocnanswers" style="display: none" runat="server">
                                <input type="radio" id="chkYesdcmntlimits" value="1" name="dcmntlimits" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" id="chkNodcmntlimits" value="2" name="dcmntlimits" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" id="chkunkdcmntlimits" value="3" name="dcmntlimits" style="display: initial" runat="server" disabled />
                                Unknown
                                      </div>
                            </td>
                        </tr>
                         <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                 <div id="dvlink" style="display: none" runat="server">
                                <asp:Label ID="Label42" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                1b. Please provide the link to the documentation.
                                            <span id="msglinktocontaminationdocs" style="color: red"></span>
                                <asp:HiddenField ID="HiddenField1" runat="server" Value="33" />
                                     </div>
                            </td>
                            <td colspan="2">
                                 <div id="dvlinktextbox" style="display: none" runat="server">
                                 <asp:TextBox type="text" ID="txtlinktocontainmentsdocuments" runat="server" TextMode="multiline" Height="20px" Width="50%" />
                                     </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                <asp:Label ID="lblrequiredmessage14" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_34" runat="server" Value="34" />
                                2. As part of the site/building study has there been a full Asbestos (ACM) Lead Based Paint(LBP) analysis of the project area and effected buildings to determine the extent of potential LBP and Asbestos contamination?
                                            <span id="msgFullasbestos" style="color: red; padding-left: 2em"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" id="chkYesfullasbestos" value="1" name="fullasbestos" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" id="chkNofullasbestos" value="2" name="fullasbestos" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" id="chkunkfullasbestos" value="3" name="fullasbestos" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvpreviouselbpandacmanalysis" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_35" runat="server" Value="35" />
                                    <asp:Label ID="Label62" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    2a. Please provide the link to copies of all previous LBP and ACM analysis reports for the site or effected buildings.
                                                <span id="msgPreviouselbpandacmanalysis" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvpreviouselbpandacmanalysischkbox" style="display: none" runat="server">
                                    <asp:TextBox type="text" ID="txtPreviouselbpandacmanalysis" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                <asp:Label ID="lblrequiredmessage16" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_36" runat="server" Value="36" />
                                3. Are  any known Polychlorinated biphenyls (PCBs) present in any of the buildings on the site that will be impacted as part of the project? (Current generators, elevators, other old oil containing machinery)
                                            <span id="msgPolychlorinatepiphenyls" style="color: red"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYespolychlorinatepiphenyls" name="polychlorinatepiphenyls" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNopolychlorinatepiphenyls" name="polychlorinatepiphenyls" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkunkpolychlorinatepiphenyls" name="polychlorinatepiphenyls" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 6th menu -->
            <input type="radio" name="trg6" id="acc6" onclick="toggleconntent('content6')">
            <label for="acc6"><b>HISTORICAL AND CULTURAL</b></label>
            <div class="content" id="content6" style="display: none">
                <div class="inner">
                    <table style="width: 100%">
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td style="width: 80%">
                                <asp:HiddenField ID="hdnSurvey_fk_37" runat="server" Value="37" />
                                <asp:Label ID="lblRequiredmessage21" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                1. Is the facility, building or VA campus 50 yrs. old or is it a National Cemetery? <span id="msgBldngfiftyyears" style="color: red"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYesbldngfiftyyears" name="bldngfiftyyears" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNobldngfiftyyears" name="bldngfiftyyears" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkunkbldngfiftyyears" name="bldngfiftyyears" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td>
                                <asp:Label ID="lblRequiredmessage23" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_38" runat="server" Value="38" />
                                2. Has the facility, building, VA campus or National Cemetery or site been evaluated under the National Historic Preservation Act (NHPA) for listing on the National Register of Historic Places (NRHP)?
                                            <span id="msgNhpaevaluation" style="color: red"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYesnhpaevaluation" name="nhpaevaluation" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNonhpaevaluation" name="nhpaevaluation" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkunknhpaevaluation" name="nhpaevaluation" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td>
                                <asp:Label ID="lblRequiredmessage17" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_39" runat="server" Value="39" />
                                3. Is the site listed on the Historic Register? <span id="msgLstedhistoricregister" style="color: red"></span>

                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYeslstedhistoricregister" name="lstedhistoricregister" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNolstedhistoricregister" name="lstedhistoricregister" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkunklstedhistoricregister" name="lstedhistoricregister" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvhsitoricarcheolgical" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_40" runat="server" Value="40" />
                                    <asp:Label ID="Label63" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    3a. Are there any historic or archeological site reports available for the current project or for past projects at the site?
                                                <span id="msgHsitoricarcheolgical" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvChkhsitoricarcheolgical" style="display: none" runat="server">
                                    <input type="radio" value="1" id="chkYeshsitoricarcheolgical" name="hsitoricarcheolgical" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" value="2" id="chkNohsitoricarcheolgical" name="hsitoricarcheolgical" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" value="3" id="chkunkhsitoricarcheolgical" name="hsitoricarcheolgical" style="display: initial" runat="server" disabled />
                                    Unknown
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvlnktoattachpastreeports" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_41" runat="server" Value="41" />
                                    <asp:Label ID="Label64" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    3b.  Please provide a link to the reports or attach past reports. <span id="msgLinktopastreports" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvChklnktoattachpastreeports" style="display: none" runat="server">
                                    <asp:TextBox type="text" ID="txtLinktopastreports" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvPreservationplan" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_42" runat="server" Value="42" />
                                    <asp:Label ID="Label65" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    3c. Is there a preservation plan for the property?  <span id="msgPreservationplan" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvChkpreservationplan" style="display: none" runat="server">
                                    <input type="radio" value="1" id="chkYespreservationplan" name="preservationplan" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" value="2" id="chkNopreservationplan" name="preservationplan" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" value="3" id="chkunkpreservationplan" name="preservationplan" style="display: initial" runat="server" disabled />
                                    Unknown
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvlnkpreservationplan" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_43" runat="server" Value="43" />
                                    <asp:Label ID="Label66" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    3d. Please provide a link to the preservation plan.  <span id="msgLinktopreservationplan" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvChklnkpreservationplan" style="display: none" runat="server">
                                    <asp:TextBox type="text" ID="txtLinktopreservationplan" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td>
                                <asp:Label ID="lblRequiredmessage18" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_44" runat="server" Value="44" />
                                4. Are there any existing NHPA agreements in effect for the property (see: achp.gov/va) or Native American Graves Protection and Repatriation Act (NAGPRA) Plans of Action or Agreements?
                                            <span id="msgExstnhpaagreement" style="color: red"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYesexstnhpaagreement" name="exstnhpaagreement" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNoexstnhpaagreement" name="exstnhpaagreement" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkunkexstnhpaagreement" name="exstnhpaagreement" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvlnktoanyagreement" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_45" runat="server" Value="45" />
                                    <asp:Label ID="Label67" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    4a. Please provide a link to any agreements. <span id="msgLnktoanyagreement" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvChklnktoanyagreement" style="display: none" runat="server">
                                    <asp:TextBox type="text" ID="Txtlnktoanyagreement" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td>
                                <asp:Label ID="lblRequiredmessage19" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_46" runat="server" Value="46" />
                                5. Does the facility have existing relationships with likely consulting parties (i.e. State Historic Preservation Office (SHPO), local government, Tribes)?
                                            <span id="msgExstrelnwithconsuparties" style="color: red"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYesexstrelnwithconsuparties" name="exstrelnwithconsuparties" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNoexstrelnwithconsuparties" name="exstrelnwithconsuparties" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkunkexstrelnwithconsuparties" name="exstrelnwithconsuparties" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvlnktoannualrptsreuirement" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_47" runat="server" Value="47" />
                                    <asp:Label ID="Label68" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    5a. Are there any annual reports requirements? <span id="msgLnktoannualrptsreuirement" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvChklnktoannualrptsreuirement" style="display: none" runat="server">

                                    <input type="radio" value="1" id="chkYeslnktoannualrptsreuirement" name="lnktoannualrptsreuirement" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" value="2" id="chkNolnktoannualrptsreuirement" name="lnktoannualrptsreuirement" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" value="3" id="chkunklnktoannualrptsreuirement" name="lnktoannualrptsreuirement" style="display: initial" runat="server" disabled />
                                    Unknown
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvlnktolatestannualreports" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_48" runat="server" Value="48" />
                                    <asp:Label ID="Label69" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    5b.  Please provide latest annual report?  <span id="msgTxtlnktolatestannualreports1" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvTxtlnktolatestannualreports" style="display: none" runat="server">
                                    <asp:TextBox type="text" ID="Txtlinktolatestannualreports" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 7th menu -->
            <input type="radio" name="trg7" id="acc7" onclick="toggleconntent('content7')">
            <label for="acc7"><b>NATURAL RESOURCES</b></label>
            <div class="content" id="content7" style="display: none">
                <div class="inner">
                    <table style="width: 100%">
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td style="width: 80%">
                                <asp:HiddenField ID="hdnSurvey_fk_55" runat="server" Value="55" />
                                <asp:Label ID="Label23" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                1. Will the proposed action alter, destroy, or significantly impact environmentally sensitive areas (wetlands and/or existing fish or wildlife habitat, coastal zones, flood plains)
                                            <span id="msgEnvsensitive" style="color: red"></span>
                            </td>
                            <td colspan="3">
                                <input type="radio" value="1" id="chkYesenvsensitive" name="envsensitive" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNoenvsensitive" name="envsensitive" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkunkenvsensitive" name="envsensitive" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                            <td colspan="2"></td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td>
                                <asp:Label ID="Label24" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_56" runat="server" Value="56" />
                                2. Are there any known state or federal listed threatened or endangered species on this site?  <span id="msgStateorfederalthreatened" style="color: red"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYesstateorfederalthreatened" name="stateorfederalthreatened" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNostateorfederalthreatened" name="stateorfederalthreatened" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkUnkstateorfederalthreatened" name="stateorfederalthreatened" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvlnktostateorfederalthreatenedprevreport" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_57" runat="server" Value="57" />
                                    <asp:Label ID="Label70" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    2a.  Are any previous reports available? <span id="msgPrevreports" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvChklnktostateorfederalthreatenedprevreport" style="display: none" runat="server">
                                    <input type="radio" value="1" id="chkYesstateorfederalthreatenedprevreport" name="stateorfederalthreatenedprevreport" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" value="2" id="chkNostateorfederalthreatenedprevreport" name="stateorfederalthreatenedprevreport" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" value="3" id="chkunkstateorfederalthreatenedprevreport" name="stateorfederalthreatenedprevreport" style="display: initial" runat="server" disabled />
                                    Unknown
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvLnktoattachesarpt" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_58" runat="server" Value="58" />
                                    <asp:Label ID="Label71" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    2b.  Please provide link or attach ESA report <span id="msgLnktoattachesarpt" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvlnktoattachesarpttxt" style="display: none" runat="server">
                                    <asp:TextBox type="text" ID="Txtlnktoattachesarpt" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''" style="width: 100%">
                            <td style="width: 80%">
                                <asp:Label ID="Label25" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_59" runat="server" Value="59" />
                                3. Does the project site fall within the FEMA 500 yr. Floodplain? <span id="msgFemafloodplain" style="color: red"></span>
                            </td>
                            <td colspan="3">
                                <input type="radio" value="1" id="chkYesfemafloodplain" name="femafloodplain" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNofemafloodplain" name="femafloodplain" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkunkfemafloodplain" name="femafloodplain" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvpercentageinfloodplain" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_60" runat="server" Value="60" />
                                    3a. How much of the project falls within the 500 yr. floodplain? <span id="msgPercentageinfloodplain" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvlnktopercentageinfloodplain" style="display: none" runat="server">
                                    <asp:TextBox type="text" ID="Txtpercentageinfloodplain" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td>
                                <asp:Label ID="Label26" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_61" runat="server" Value="61" />
                                4. Are there known or mapped wetlands on site? <span id="msgKnownormappedwetlands" style="color: red"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYesknownormappedwetlands" name="knownormappedwetlands" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNoknownormappedwetlands" name="knownormappedwetlands" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkUnkknownormappedwetlands" name="knownormappedwetlands" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvlnktowetlandimpacted" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_62" runat="server" Value="62" />
                                    <asp:Label ID="Label72" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    4a.   Are wetland likely to be impacted as a result of the project? <span id="msgWetlandimpacted" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvChkwetlandimpacted" style="display: none" runat="server">
                                    <input type="radio" value="1" id="chkYeswetlandimpacted" name="wetlandimpacted" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" value="2" id="chkNowetlandimpacted" name="wetlandimpacted" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" value="3" id="chkUnkwetlandimpacted" name="wetlandimpacted" style="display: initial" runat="server" disabled />
                                    Unknown
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvlnktoanticpatedwetlandspermit" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_63" runat="server" Value="63" />
                                    <asp:Label ID="Label73" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    4b. Is it anticipated that a Wetlands permit will be required at the State or Federal level for the project?
                                                <span id="msgAnticpatedwetlandspermit" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvChklnktoanticpatedwetlandspermit" style="display: none" runat="server">
                                    <input type="radio" value="1" id="chkYesanticpatedwetlandspermit" name="anticpatedwetlandspermit" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" value="2" id="chkNoanticpatedwetlandspermit" name="anticpatedwetlandspermit" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" value="3" id="chkUnkanticpatedwetlandspermit" name="anticpatedwetlandspermit" style="display: initial" runat="server" disabled />
                                    Unknown
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvlnktoexstwetlandpermitsoragreement" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_64" runat="server" Value="64" />
                                    <asp:Label ID="Label74" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    4c. Is there existing wetland permits or agreement for the development of this site? <span id="msgExstwetlandpermitsoragreement" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvChklnktoexstwetlandpermitsoragreement" style="display: none" runat="server">
                                    <input type="radio" value="1" id="chkYesexstwetlandpermitsoragreement" name="exstwetlandpermitsoragreement" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" value="2" id="chkNoexstwetlandpermitsoragreement" name="exstwetlandpermitsoragreement" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" value="3" id="chkUnkexstwetlandpermitsoragreement" name="exstwetlandpermitsoragreement" style="display: initial" runat="server" disabled />
                                    Unknown
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvlnktowetlandsexcitingpermits" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_65" runat="server" Value="65" />
                                    <asp:Label ID="Label75" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    4d. Please provide exciting permit or agreement. <span id="msgYeswetlandsexcitingpermits" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvChklnktowetlandsexcitingpermits" style="display: none" runat="server">
                                    <asp:TextBox type="text" ID="txtwetlandsexcitingpermits" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 8th menu -->
            <input type="radio" name="trg8" id="acc8" onclick="toggleconntent('content8')">
            <label for="acc8"><b>STORMWATER AND COASTAL ZONE</b></label>
            <div class="content" id="content8" style="display: none">
                <div class="inner">
                    <table style="width: 100%">
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td style="width: 80%">
                                <asp:Label ID="Label27" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_66" runat="server" Value="66" />
                                1. Are current Stormwater (SW) Facilities on site adequate to handle additional flow? <span id="msgCurrentstormwateradequate" style="color: red"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYescurrentstormwateradequate" name="currentstormwateradequate" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNocurrentstormwateradequate" name="currentstormwateradequate" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkUnkcurrentstormwateradequate" name="currentstormwateradequate" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                <asp:Label ID="Label28" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_67" runat="server" Value="67" />
                                2. Will the site be able to handle the 24 hr. retention of SW associated with the change in impervious surface? <span id="msgRetentionofsw" style="color: red"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYesretentionofsw" name="retentionofsw" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNoretentionofsw" name="retentionofsw" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkUnkretentionofsw" name="retentionofsw" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                <asp:Label ID="Label29" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_68" runat="server" Value="68" />
                                3. Does the project fall within 1000 ft of the Coastal Zone ( Coastline)or tidal waters? <span id="msgFallcoastalzone" style="color: red"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYesfallcoastalzone" name="fallcoastalzone" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNofallcoastalzone" name="fallcoastalzone" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkUnkfallcoastalzone" name="fallcoastalzone" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 9th menu -->
            <input type="radio" name="trg9" id="acc9" onclick="toggleconntent('content9')">
            <label for="acc9"><b>UTILITIES</b></label>
            <div class="content" id="content9" style="display: none">
                <div class="inner">
                    <table style="width: 100%">
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td style="width: 80%">
                                <asp:Label ID="Label30" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_70" runat="server" Value="70" />
                                1. Are there sufficient utilities (with capacity) to support the proposed project on site? Only answer yes, if it is known that all utilities have sufficent capacity
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYessufficesntutilities" name="sufficesntutilities" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNosufficesntutilities" name="sufficesntutilities" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkUnksufficesntutilities" name="sufficesntutilities" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <asp:Label ID="Label31" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_71" runat="server" Value="71" />
                                1a.  Please inidcate which utilities could require modifications or changes to support the project.
                            </td>
                            <td colspan="2">
                                <input type="checkbox" id="chkElectrical" name="chkelectricalmodifications" style="display: initial" runat="server" disabled />
                                Electrical
                                            <br />
                                <input type="checkbox" id="chkSanitarysewer" name="chkSanitarysewer" style="display: initial" runat="server" disabled />
                                Sanitary Sewer
                                            <br />
                                <input type="checkbox" id="chkStormsewer" name="chkStormsewer" style="display: initial" runat="server" disabled />
                                Storm Sewer
                                            <br />
                                <input type="checkbox" id="chkSteam" name="chkSteam" style="display: initial" runat="server" disabled />
                                Steam
                                            <br />
                                <input type="checkbox" id="chkPortablewater" name="chkPortablewater" style="display: initial" runat="server" disabled />
                                Portable Water
                                            <br />
                                <input type="checkbox" id="chkChilledWater" name="chkChilledWater" style="display: initial" runat="server" disabled />
                                Chilled Water
                                            <br />
                                <input type="checkbox" id="chkNaturalgas" name="chkNaturalgas" style="display: initial" runat="server" disabled />
                                Natural Gas
                                            <br />
                                <input type="checkbox" id="chkRelaimedwater" name="chkRelaimedwater" style="display: initial" runat="server" disabled />
                                Reclaimed Water Source(Irrigation)
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td style="width: 80%; padding-left: 12px">
                                <asp:Label ID="Label32" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_72" runat="server" Value="72" />
                                1b. If there is not sufficent capacity , will the project require utilities to be brought in from off site?
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYesutilitiestobebroughtfrmsite" name="utilitiestobebroughtfrmsite" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNoutilitiestobebroughtfrmsite" name="utilitiestobebroughtfrmsite" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkUnkutilitiestobebroughtfrmsite" name="utilitiestobebroughtfrmsite" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td style="width: 80%; padding-left: 12px">
                                <asp:Label ID="Label33" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                1c.  Please indicate estimated distance for each needed utility.
                                            <asp:HiddenField ID="hdnSurvey_fk_73" runat="server" Value="73" />
                            </td>
                            <td colspan="2">
                                <asp:TextBox type="text" ID="txtElectrical" runat="server" placeholder="Electrical" runat="server" disabled />
                                <br />
                                <asp:TextBox type="text" ID="txtSanitarySewer" runat="server" placeholder="Sanitary Sewer" runat="server" disabled />
                                <br />
                                <asp:TextBox type="text" ID="txtStormSewer" runat="server" placeholder="Storm Sewer" runat="server" disabled />
                                <br />
                                <asp:TextBox type="text" ID="txtSteam" runat="server" placeholder="Steam" runat="server" disabled />
                                <br />
                                <asp:TextBox type="text" ID="txtPortableWater" runat="server" placeholder="Portable Water" runat="server" disabled />
                                <br />
                                <asp:TextBox type="text" ID="txtChilledWater" runat="server" placeholder="Chilled Water" runat="server" disabled />
                                <br />
                                <asp:TextBox type="text" ID="txtNaturalGas" runat="server" placeholder="Natural Gas" runat="server" disabled />
                                <br />
                                <asp:TextBox type="text" ID="txtReclaimedWaterSource" runat="server" placeholder="Reclaimed Water Source" runat="server" disabled />
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td style="width: 80%; padding-left: 12px">
                                <asp:Label ID="Label34" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                1d. Is proposed routing of utilities known?
                                            <asp:HiddenField ID="hdnSurvey_fk_74" runat="server" Value="74" />
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYesproposedroutingofutilities" name="proposedroutingofutilities" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNoproposedroutingofutilities" name="proposedroutingofutilities" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkUnkproposedroutingofutilities" name="proposedroutingofutilities" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td style="width: 80%">
                                <asp:Label ID="Label35" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_75" runat="server" Value="75" />
                                2. Are there any overhead utilities, underground utilities or easements that would need to be evaluated as part of the developability of the site?
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYesutilitiesevaluationofsite" name="utilitiesevaluationofsite" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNoutilitiesevaluationofsite" name="utilitiesevaluationofsite" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkUnkutilitiesevaluationofsite" name="utilitiesevaluationofsite" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 10th menu -->
            <input type="radio" name="trg10" id="acc10" onclick="toggleconntent('content10')">
            <label for="acc10"><b>TRAFFIC</b></label>
            <div class="content" id="content10" style="display: none">
                <div class="inner">
                    <table style="width: 100%">
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td style="width: 80%">
                                <asp:Label ID="Label36" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_76" runat="server" Value="76" />
                                1. Are there known traffic issues in the immediate area? <span id="msgTrafficissue" style="color: red"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYestrafficissue" name="trafficissue" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNotrafficissue" name="trafficissue" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkUnktrafficissue" name="trafficissue" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                <asp:Label ID="Label37" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_77" runat="server" Value="77" />
                                2.  Will the project impact traffic and site access during construction or during operation?  <span id="msgImpacttrafficsiteaccess" style="color: red"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYesimpacttrafficsiteaccess" name="impacttrafficsiteaccess" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNoimpacttrafficsiteaccess" name="impacttrafficsiteaccess" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkUnkimpacttrafficsiteaccess" name="impacttrafficsiteaccess" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvlnktotrafficimpactsduringconstn" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_78" runat="server" Value="78" />
                                    <asp:Label ID="Label76" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    2a.  Will traffic impacts be limited only during construction? <span id="msgTrafficimpactsduringconstn" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvChklnktotrafficimpactsduringconstn" style="display: none" runat="server">
                                    <input type="radio" value="1" id="chkYestrafficimpactsduringconstn" name="trafficimpactsduringconstn" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" value="2" id="chkNotrafficimpactsduringconstn" name="trafficimpactsduringconstn" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" value="3" id="chkUnktrafficimpactsduringconstn" name="trafficimpactsduringconstn" style="display: initial" runat="server" disabled />
                                    Unknown
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvlnktotrafficstudycompleted" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_79" runat="server" Value="79" />
                                    <asp:Label ID="Label77" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    2b.  Has a traffic study been completed for after construction/ during operation of the facility and traffic Level of Service(LOS)
                                                <span id="msgTrafficstudycompleted" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvChklnktotrafficstudycompleted" style="display: none" runat="server">
                                    <input type="radio" value="1" id="chkYestrafficstudycompleted" name="trafficstudycompleted" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" value="2" id="chkNotrafficstudycompleted" name="trafficstudycompleted" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" value="3" id="chkUnktrafficstudycompleted" name="trafficstudycompleted" style="display: initial" runat="server" disabled />
                                    Unknown
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvprovidelnkotrafficstudies" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_80" runat="server" Value="80" />
                                    <asp:Label ID="Label78" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    2c. Please provide link or attached previously completed traffic study <span id="msgProvidelnkotrafficstudy" style="color: red"></span>

                                </div>
                            </td>
                            <td>
                                <div id="providelnkotrafficstudy" style="display: none" runat="server">
                                    <asp:TextBox type="text" ID="txtProvidelnkotrafficstudy" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                <asp:Label ID="Label38" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_81" runat="server" Value="81" />
                                3. Is there mass transit in close proximity which could be utilized to alleviate traffic impacts? <span id="msgMasstransitcloseproximity" style="color: red"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYesmasstransitcloseproximity" name="masstransitcloseproximity" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNomasstransitcloseproximity" name="masstransitcloseproximity" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkUnkmasstransitcloseproximity" name="masstransitcloseproximity" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 11th menu -->
            <input type="radio" name="trg11" id="acc11" onclick="toggleconntent('content11')">
            <label for="acc11"><b>NATIONAL ENVIRONMENTAL POLICY ACT (NEPA),(EA),(EIS)</b></label>
            <div class="content" id="content11" style="display: none">
                <div class="inner">
                    <table style="width: 100%">
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td style="width: 80%">
                                <asp:Label ID="Label39" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:HiddenField ID="hdnSurvey_fk_82" runat="server" Value="82" />
                                1. Has an previous NEPA EA or EIS  been completed for the project?  <span id="msgPreviousnepaeaoreis" style="color: red"></span>
                            </td>
                            <td colspan="2">
                                <input type="radio" value="1" id="chkYespreviousnepaeaoreis" name="previousnepaeaoreis" style="display: initial" runat="server" disabled />
                                Yes
                                            <input type="radio" value="2" id="chkNopreviousnepaeaoreis" name="previousnepaeaoreis" style="display: initial" runat="server" disabled />
                                No
                                            <input type="radio" value="3" id="chkUnkpreviousnepaeaoreis" name="previousnepaeaoreis" style="display: initial" runat="server" disabled />
                                Unknown
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvfinaleasignedfonsi" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_83" runat="server" Value="83" />
                                    <asp:Label ID="Label79" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    1a.  Is there a Final EA and signed Finding of No Significant Impact (FONSI) for the project? <span id="msgFinaleasignedfonsi" style="color: red"></span>
                                </div>
                            </td>
                            <td colspan="2">
                                <div id="dvChkfinaleasignedfonsi" style="display: none" runat="server">
                                    <input type="radio" value="1" id="chkYesfinaleasignedfonsi" name="finaleasignedfonsi" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" value="2" id="chkNorfinaleasignedfonsi" name="finaleasignedfonsi" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" value="3" id="chkUnkfinaleasignedfonsi" name="finaleasignedfonsi" style="display: initial" runat="server" disabled />
                                    Unknown
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvPLnkpreviousnepaeaoreis" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_84" runat="server" Value="84" />
                                    <asp:Label ID="Label80" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    1b.  Please provide link of previous NEPA EA or EIS and signed FONSI. <span id="msgTxtpreviousnepaeaoreis" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvpreviousnepaeaoreis" style="display: none" runat="server">
                                    <asp:TextBox type="text" ID="txtpreviousnepaeaoreis" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                <div id="dvprevcomplnepadocnavailable">
                                    <asp:Label ID="Label40" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hdnSurvey_fk_85" runat="server" Value="85" />
                                    2. Does the site have any previously completed NEPA documents for past projects that are available? (This can help to frame the potential resource areas or concern)
                                                <span id="msgPrevcomplnepadocnavailable" style="color: red"></span>
                                </div>
                            </td>
                            <td colspan="2">
                                <div id="dvChkprevcomplnepadocnavailable">
                                    <input type="radio" value="1" id="chkYesprevcomplnepadocnavailable" name="prevcomplnepadocnavailable" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" value="2" id="chkNoprevcomplnepadocnavailable" name="prevcomplnepadocnavailable" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" value="3" id="chkUnkprevcomplnepadocnavailable" name="prevcomplnepadocnavailable" style="display: initial" runat="server" disabled />
                                    Unknown
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1" style="padding-left: 12px">
                                <div id="dvLnksitepocpastnepadocn" style="display: none" runat="server">
                                    <asp:HiddenField ID="hdnSurvey_fk_86" runat="server" Value="86" />
                                    <asp:Label ID="Label81" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    2a.  Please provide site POC for past NEPA documentation  or attach past NEPA documentation
                                                <span id="msgTxtLnksitepocpastnepadocn" style="color: red"></span>
                                </div>
                            </td>
                            <td>
                                <div id="dvTxtlnksitepocpastnepadocn" style="display: none" runat="server">
                                    <asp:TextBox type="text" ID="txtLnksitepocpastnepadocn" runat="server" TextMode="multiline" Height="20px" Width="60%" disabled />
                                </div>
                            </td>
                        </tr>
                        <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                            <td colspan="1">
                                <div>
                                    <asp:Label ID="Label41" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hdnSurvey_fk_87" runat="server" Value="87" />
                                    3. Are there other projects underway or planned for the near term at the property (Minors)? <span id="msgOtherprojectunderwayorplanned" style="color: red"></span>
                                </div>
                            </td>


                            <td colspan="2">
                                <div id="dvChkotherprojectunderwayorplanned">
                                    <input type="radio" value="1" id="chkYesotherprojectunderwayorplanned" name="otherprojectunderwayorplanned" style="display: initial" runat="server" disabled />
                                    Yes
                                                <input type="radio" value="2" id="chkNootherprojectunderwayorplanned" name="otherprojectunderwayorplanned" style="display: initial" runat="server" disabled />
                                    No
                                                <input type="radio" value="3" id="chkUnkotherprojectunderwayorplanned" name="otherprojectunderwayorplanned" style="display: initial" runat="server" disabled />
                                    Unknown
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 12th menu -->
            <input type="radio" name="trg12" id="acc12" onclick="toggleconntent('content12')">
            <label for="acc12"><b>PHYSICAL SECURITY</b></label>
            <div class="content" id="content12" style="display: none">
                <div class="inner">
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 80%">Will the proposed impacts Physical Security requirements that may require other actions? What are those potential actions?<br>
                                <asp:HiddenField ID="hdnSurvey_fk_88" runat="server" Value="88" />
                                <br />
                                <textarea id="txtImpactsofphysicalsecurity" runat="server" cols="20" rows="5" style="width: 80%" disabled></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 80%">Will the proposed potentially impact Physical Security requirements require and cause other actions? What are those potential actions?<br>
                                <asp:HiddenField ID="hdnSurvey_fk_89" runat="server" Value="89" />
                                <br />
                                <textarea id="txtProposedpotentiallyimpacts" runat="server" cols="20" rows="5" style="width: 80%" disabled></textarea>
                                <br />
                                <br />
                                <br />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

    </div>

    <!--end RVB-->
    <br />
    <br />
    <hr />
    <br />
    <br />

    <%--    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <div class="modal" style="position: fixed; height: 18%; width: 100%; top: 50%; background-color: Black; filter: alpha(opacity=60); opacity: 0.6; -moz-opacity: 0.8;">
                <div class="center" style="margin: auto; padding-top: 10px; width: 130px; background-color: White; border-radius: 10px; filter: alpha(opacity=100); opacity: 1; -moz-opacity: 1;">
                    <img src="Images/loader.gif" alt="" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
        <ProgressTemplate>
            <div class="modal" style="position: fixed; height: 18%; width: 100%; top: 50%; background-color: Black; filter: alpha(opacity=60); opacity: 0.6; -moz-opacity: 0.8;">
                <div class="center" style="margin: auto; padding-top: 10px; width: 130px; background-color: White; border-radius: 10px; filter: alpha(opacity=100); opacity: 1; -moz-opacity: 1;">
                    <img src="Images/loader.gif" alt="" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdateProgress ID="UpdateProgress3" runat="server">
        <ProgressTemplate>
            <div class="modal" style="position: fixed; height: 18%; width: 100%; top: 50%; background-color: Black; filter: alpha(opacity=60); opacity: 0.6; -moz-opacity: 0.8;">
                <div class="center" style="margin: auto; padding-top: 10px; width: 130px; background-color: White; border-radius: 10px; filter: alpha(opacity=100); opacity: 1; -moz-opacity: 1;">
                    <img src="Images/loader.gif" alt="" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>--%>

    <div style="text-align: center; background-color: #b3ccff; padding-top: 5px; padding-bottom: 5px; font-size: 15px">
        <b>Environmental Program Division Initial Response and Environmental Requirements Form </b>
    </div>
    <div style="width: 88%; padding-left: 5%; font-size: 15px">
        <div style="text-align: right">
            <asp:Label ID="lblReqIndex" runat="server" Text="* Required Field" ForeColor="#ff0000"></asp:Label>
        </div>
        <div class="accordionMenu">

            <!-- 1st menu  -->
            <input type="radio" id="acc1B" onclick="toggleconntent('content1B')" />
            <label for="acc1B"><b>LAND USE</b></label>
            <div class="content" id="content1B">
                <div class="inner">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="1" style="width: 50%; padding-right: 100px; padding-top: 11px;">
                                <asp:Label ID="lblReuiredmessage" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:Label ID="lblLandusepotentialimpact" runat="server" Text="Potential Impacts:" Font-Bold="false"></asp:Label>
                                <span style="padding-left: 100px">
                                    <asp:DropDownList ID="ddlLandusepotentialimpact" runat="server">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem Text="NA" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Negligible" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Moderate" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Potential Significant" Value="4"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage=" (Please select one)" ControlToValidate="ddlLandusepotentialimpact" runat="server" ForeColor="Red" Display="Dynamic" />
                                    <asp:HiddenField runat="server" Value="1" ID="hdnlanduse" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox ID="txtLanduseimpactsnote" runat="server" Width="100%" TextMode="MultiLine" Height="75px"></asp:TextBox>

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 2nd menu  -->
            <input type="radio" id="acc2B" onclick="toggleconntent('content2B')" />
            <label for="acc2B"><b>SITE GEOLOGY AN SOIL SUITABILITY</b></label>
            <div class="content" id="content2B">
                <div class="inner">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="1" style="width: 50%">
                                <asp:Label ID="Label8" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:Label ID="lblSitegeologyandsoilsuitabilitynote" runat="server" Text="Potential Impacts:" Font-Bold="false"></asp:Label>
                                <span style="padding-left: 100px">
                                    <asp:DropDownList ID="ddlSitegeologyandsoilsuitability" runat="server">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem Text="NA" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Negligible" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Moderate" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Potential Significant" Value="4"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage=" (Please select one)" ControlToValidate="ddlSitegeologyandsoilsuitability" runat="server" ForeColor="Red" Display="Dynamic" />
                                    <asp:HiddenField runat="server" Value="2" ID="hdnsitegeologyandsoilsuitability" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">

                                <asp:TextBox ID="txtSitegeologyimpactsnote" runat="server" Width="100%" TextMode="MultiLine" Height="75px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 3rd menu  -->
            <input type="radio" id="acc3B" onclick="toggleconntent('content3B')" />
            <label for="acc3B"><b>HAZARDOUS MATERIAL</b></label>
            <div class="content" id="content3B">
                <div class="inner">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="1" style="width: 50%">
                                <asp:Label ID="Label9" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:Label ID="Label1" runat="server" Text="Potential Impacts:" Font-Bold="false"></asp:Label>
                                <span style="padding-left: 100px">
                                    <asp:DropDownList ID="ddlHazordousmaterial" runat="server">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem Text="NA" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Negligible" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Moderate" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Potential Significant" Value="4"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ErrorMessage=" (Please select one)" ControlToValidate="ddlHazordousmaterial" runat="server" ForeColor="Red" Display="Dynamic" />
                                    <asp:HiddenField runat="server" Value="3" ID="hdnHazordousmaterial" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox ID="txtHzordousmaterialimpactsnote" runat="server" Width="100%" TextMode="MultiLine" Height="75px"></asp:TextBox>

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 4th menu  -->
            <input type="radio" id="acc4B" onclick="toggleconntent('content4B')" />
            <label for="acc4B"><b>CULTURAL AND HISTORIC RESOURCES</b></label>
            <div class="content" id="content4B">
                <div class="inner">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="1" style="width: 50%">
                                <asp:Label ID="Label10" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:Label ID="Label2" runat="server" Text="Potential Impacts:" Font-Bold="false"></asp:Label>
                                <span style="padding-left: 100px">
                                    <asp:DropDownList ID="ddlCulturalandhistorical" runat="server">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem Text="NA" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Negligible" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Moderate" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Potential Significant" Value="4"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ErrorMessage=" (Please select one)" ControlToValidate="ddlCulturalandhistorical" runat="server" ForeColor="Red" Display="Dynamic" />
                                    <asp:HiddenField runat="server" Value="4" ID="hdnCultulturalandhistorical" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox ID="txtCulturalhistoricimpactnote" runat="server" Width="100%" TextMode="MultiLine" Height="75px"></asp:TextBox>

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 5th menu  -->
            <input type="radio" id="acc5B" onclick="toggleconntent('content5B')" />
            <label for="acc5B"><b>NATURAL RESOURCES</b></label>
            <div class="content" id="content5B">
                <div class="inner">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="1" style="width: 50%">
                                <asp:Label ID="Label11" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:Label ID="Label3" runat="server" Text="Potential Impacts:" Font-Bold="false"></asp:Label>
                                <span style="padding-left: 100px">
                                    <asp:DropDownList ID="ddlnaturalresources" runat="server">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem Text="NA" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Negligible" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Moderate" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Potential Significant" Value="4"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ErrorMessage=" (Please select one)" ControlToValidate="ddlnaturalresources" runat="server" ForeColor="Red" Display="Dynamic" />
                                    <asp:HiddenField runat="server" Value="5" ID="hdnNaturalResources" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox ID="txtNaturalresourcesimpactnote" runat="server" Width="100%" TextMode="MultiLine" Height="75px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 6th menu  -->
            <input type="radio" id="acc6B" onclick="toggleconntent('content6B')" />
            <label for="acc6B"><b>UTILITIES</b></label>
            <div class="content" id="content6B">
                <div class="inner">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="1" style="width: 50%">
                                <asp:Label ID="Label12" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:Label ID="Label4" runat="server" Text="Potential Impacts:" Font-Bold="false"></asp:Label>
                                <span style="padding-left: 100px">
                                    <asp:DropDownList ID="ddlUtilities" runat="server">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem Text="NA" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Negligible" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Moderate" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Potential Significant" Value="4"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ErrorMessage=" (Please select one)" ControlToValidate="ddlUtilities" runat="server" ForeColor="Red" Display="Dynamic" />
                                    <asp:HiddenField runat="server" Value="6" ID="hdnUtilities" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox ID="txtPotentialImpactsnote" runat="server" Width="100%" TextMode="MultiLine" Height="75px"></asp:TextBox>

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 7th menu  -->
            <input type="radio" id="acc7B" onclick="toggleconntent('content7B')" />
            <label for="acc7B"><b>STORMWATER AND COASTAL ZONE</b></label>
            <div class="content" id="content7B">
                <div class="inner">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="1" style="width: 50%">
                                <asp:Label ID="Label13" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:Label ID="Label5" runat="server" Text="Potential Impacts:" Font-Bold="false"></asp:Label>
                                <span style="padding-left: 100px">
                                    <asp:DropDownList ID="ddlstormwaterandcoastal" runat="server">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem Text="NA" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Negligible" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Moderate" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Potential Significant" Value="4"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ErrorMessage=" (Please select one)" ControlToValidate="ddlstormwaterandcoastal" runat="server" ForeColor="Red" Display="Dynamic" />
                                    <asp:HiddenField runat="server" Value="7" ID="hdnStormwaterandcoastal" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox ID="txtStormwaterandcoastalzoneimpactnote" runat="server" Width="100%" TextMode="MultiLine" Height="75px"></asp:TextBox>

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 8th menu  -->
            <input type="radio" id="acc8B" onclick="toggleconntent('content8B')" />
            <label for="acc8B"><b>TRAFFIC</b></label>
            <div class="content" id="content8B">
                <div class="inner">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="1" style="width: 50%">
                                <asp:Label ID="Label14" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                <asp:Label ID="Label6" runat="server" Text="Potential Impacts:" Font-Bold="false"></asp:Label>
                                <span style="padding-left: 100px">
                                    <asp:DropDownList ID="ddlTraffic" runat="server">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem Text="NA" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Negligible" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Moderate" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Potential Significant" Value="4"></asp:ListItem>
                                    </asp:DropDownList></span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ErrorMessage=" (Please select one)" ControlToValidate="ddlTraffic" runat="server" ForeColor="Red" Display="Dynamic" />
                                <asp:HiddenField runat="server" Value="8" ID="hdnTraffic" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox ID="txtTrafficimpactnote" runat="server" Width="100%" TextMode="MultiLine" Height="75px"></asp:TextBox>

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 9th menu  -->
            <input type="radio" id="acc9B" onclick="toggleconntent('content9B')" />
            <label for="acc9B"><b>POTENTIAL ANTICIPATED ENVIRONMENTAL PERMITS, AUTHORIZATION OR PLANS</b></label>
            <div class="content" id="content9B" style="background-color: white">
                <div class="inner">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="1">
                                <asp:CheckBox ID="chkAirquality" runat="server" />
                                Air Quality General Permit to Construct<br />
                                <asp:CheckBox ID="chkJointpermit" runat="server" />
                                Joint Federal/State Wetland, Waterway Permit<br />
                                <asp:CheckBox ID="chkErosionpermit" runat="server" />
                                Erosion, Sediment and Stormwater Control Plans/Permits<br />
                                <asp:CheckBox ID="chkAgriculturalPermit" runat="server" />
                                Agricultural/Farmlands Land Use Permit/Authorization<br />
                            </td>
                            <td colspan="2">
                                <asp:CheckBox ID="chkNpdespermit" runat="server" />
                                NPDES Permit<br />
                                <asp:CheckBox ID="chkUsacewetlandpermit" runat="server" />
                                USACE Jurisdictional Determination (JD) Wetland Permit
                                <br />
                                <asp:CheckBox ID="chkwaterandsewagepermit" runat="server" />
                                Water and Sewage Construction Permit<br />
                                <asp:CheckBox ID="chkfueltankauthzn" runat="server" />
                                Fuel Tank Removal Authorization<br />

                            </td>
                            <td colspan="3">
                                <asp:CheckBox ID="chkleadabtementpermit" runat="server" />
                                Lead Abatement Plan/Permit<br />
                                <asp:CheckBox ID="chkAsbestospermit" runat="server" />
                                Asbestos Abatement Plan/Permit<br />
                                <asp:CheckBox ID="chkCoastalzonapproval" runat="server" />
                                Coastal Zone Management Project Review and Approval
                                <br />
                                <asp:CheckBox ID="chkapeciesactpermit" runat="server" />Endangered Species Act Take Permit
                                <br />

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 10th menu  -->
            <input type="radio" id="acc10B" onclick="toggleconntent('content10B')" />
            <label for="acc10B"><b>UPLOAD DOCUMENTS</b></label>
            <div class="content" id="content10B" style="background-color: white">
                <div class="inner">
                    <table style="width: 95%">
                        <tr>
                            <td colspan="1" style="width: 50%">
                                <asp:Label ID="lblnepaassistreprot" runat="server" Text="NEPA Assist Report"></asp:Label>
                            </td>

                            <td colspan="2">
                                <asp:FileUpload ID="FileUpload1" runat="server" />
                                <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="UploadNepaassistreprot" CausesValidation="true" ValidationGroup="nepassistreport" OnClientClick="show()" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_click" CausesValidation="false" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="(No Files Selected)" ValidationGroup="nepassistreport" ControlToValidate="FileUpload1" ForeColor="red "></asp:RequiredFieldValidator>
                                <asp:Label ID="lblMessage" ForeColor="Green" runat="server" />
                                <br />
                                <br />
                                <asp:GridView ID="grdnepaassistreport" runat="server" HeaderStyle-BackColor="#e6eeff" HeaderStyle-ForeColor="Black"
                                    RowStyle-BackColor="white" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000"
                                    AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="docName" HeaderText="File Name" HeaderStyle-Width="80%" />
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkDownload" runat="server" Text="Download" OnClick="DownloadFile"
                                                    CommandArgument='<%# Eval("docId") %>' CausesValidation="false"></asp:LinkButton>
                                                <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" OnClick="DeleteFile"
                                                    CommandArgument='<%# Eval("docId") %>' CausesValidation="false"
                                                    OnClientClick="if (!confirm('Are you sure you want to Delete?')) return false;"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="always">
                                    <ContentTemplate>
                                      
      
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="btnUpload" />
                                     
                                    </Triggers>
                                </asp:UpdatePanel>--%>


                                <hr />
                                <br />
                            </td>
                        </tr>



                        <tr>
                            <td colspan="1" style="width: 50%">
                                <asp:Label ID="lblipocunofficalspecies" runat="server" Text="IPAC Unoffical Species List"></asp:Label>
                            </td>
                            <td colspan="2">

                                <%-- <asp:UpdatePanel ID="UpdatePanel2" runat="server">--%>
                                <%-- <ContentTemplate>--%>
                                <asp:FileUpload ID="FileUpload2" runat="server" />    
                                <asp:Button ID="btnuploadipacreport" runat="server" Text="Upload" OnClick="UploadIpac" OnClientClick="showipac()" CausesValidation="true" ValidationGroup="ipacunofficalspecies" />
                                <asp:Button ID="Button2" runat="server" Text="Cancel" OnClick="btnCancel_click" CausesValidation="false" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="(No Files Selected)" ValidationGroup="ipacunofficalspecies" ControlToValidate="FileUpload2" ForeColor="red "></asp:RequiredFieldValidator>
                                <asp:Label ID="lblMessageipac" ForeColor="Green" runat="server" />
                                <br />
                                <br />
                                <asp:GridView ID="grdipaclist" runat="server" HeaderStyle-BackColor="#e6eeff" HeaderStyle-ForeColor="Black"
                                    RowStyle-BackColor="white" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000"
                                    AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="docName" HeaderText="File Name" HeaderStyle-Width="80%" />
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkDownload" runat="server" Text="Download" OnClick="DownloadFile" CausesValidation="false"
                                                    CommandArgument='<%# Eval("docId") %>'></asp:LinkButton>
                                                <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("docId") %>' OnClick="DeleteFile" CausesValidation="false"
                                                    OnClientClick="if (!confirm('Are you sure you want to Delete?')) return false;"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <%--  </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="btnuploadipacreport" />
                                    </Triggers>
                                </asp:UpdatePanel>--%>
                                <hr />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="width: 50%">
                                <asp:Label ID="lblnwimap" runat="server" Text="NWI Map"></asp:Label>
                            </td>
                            <td colspan="2">
                                <%-- <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>--%>
                                <asp:FileUpload ID="FileUpload3" runat="server" />
                                <asp:Button ID="Button1" runat="server" Text="Upload" OnClick="UploadNwimap" OnClientClick="shownwimap()"  CausesValidation="true" ValidationGroup="nwimap" />
                                <asp:Button ID="Button3" runat="server" Text="Cancel" OnClick="btnCancel_click" CausesValidation="false" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="(No Files Selected)" ValidationGroup="nwimap" ControlToValidate="FileUpload3" ForeColor="red "></asp:RequiredFieldValidator>
                                <asp:Label ID="lblMessagenwi" ForeColor="Green" runat="server" />
                                <br />
                                <br />
                                <asp:GridView ID="grdnwimap" runat="server" HeaderStyle-BackColor="#e6eeff" HeaderStyle-ForeColor="Black"
                                    RowStyle-BackColor="white" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000"
                                    AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="docName" HeaderText="File Name" HeaderStyle-Width="80%" />
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkDownload" runat="server" Text="Download" CausesValidation="false" OnClick="DownloadFile" CommandArgument='<%# Eval("docId") %>'></asp:LinkButton>
                                                <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("docId") %>' CausesValidation="false" OnClick="DeleteFile"
                                                    OnClientClick="if (!confirm('Are you sure you want to Delete?')) return false;"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <%-- </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="Button1" />
                                    </Triggers>
                                </asp:UpdatePanel>--%>
                                <hr />
                            </td>
                        </tr>
                        <%-- <tr>
                            <td colspan="1" style="width: 50%">
                                <asp:Label ID="Label42" runat="server" Text="Others"></asp:Label>
                            </td>
                            <td colspan="2">
                                <asp:FileUpload ID="FileUpload4" runat="server" />
                                <asp:Button ID="Button4" runat="server" Text="Upload" OnClick="UploadNwimap" CausesValidation="true" ValidationGroup="nwimap" />
                                <asp:Button ID="Button5" runat="server" Text="Cancel" OnClick="btnCancel_click" CausesValidation="false" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="(No Files Selected)" ValidationGroup="nwimap" ControlToValidate="FileUpload3" ForeColor="red "></asp:RequiredFieldValidator>
                                <asp:Label ID="Label43" ForeColor="Green" runat="server" />
                                <br />
                                <br />
                                <asp:GridView ID="GridView1" runat="server" HeaderStyle-BackColor="#e6eeff" HeaderStyle-ForeColor="Black"
                                    RowStyle-BackColor="white" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000"
                                    AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="docName" HeaderText="File Name" HeaderStyle-Width="80%" />
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkDownload" runat="server" Text="Download" OnClick="DownloadFile" CommandArgument='<%# Eval("docId") %>'></asp:LinkButton>
                                                <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("docId") %>' CausesValidation="false" OnClick="DeleteFile"
                                               OnClientClick="if (!confirm('Are you sure you want to Delete?')) return false;"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <hr />
                            </td>
                        </tr>--%>
                    </table>
                </div>
            </div>
            <!-- 11th menu  -->
            <input type="radio" id="acc11B" onclick="toggleconntent('content11B')" />
            <label for="acc11B"><b>ANTICIPATED LEVEL OF NEPA DOCUMENTATION</b></label>
            <div class="content" id="content11B" style="background-color: white">
                <div class="inner">
                    <table>
                        <tr>
                            <td colspan="1" style="width: 100%">
                                <asp:Label ID="Label15" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                Based on the information provided for the Project/Proposed Action the Environmental Programs Division anticipates this action will require to satisfy NEPA regulatory requirements:
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="(No Files Selected)" ControlToValidate="ddlAnticpatednepdocn" ForeColor="red "></asp:RequiredFieldValidator>
                            </td>
                            <td colspan="2">
                                <asp:DropDownList ID="ddlAnticpatednepdocn" runat="server">
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem Text="Categorical Exclusion" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Environmental Assessment (EA)" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Environmental Impact Statement (EIS) " Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- 12th menu  -->
            <input type="radio" id="acc12B" onclick="toggleconntent('content12B')" />
            <label for="acc12B"><b>OVERALL ENVIRONMENTAL STRATEGY AND ANTICIPATED TIMELINE</b></label>
            <div class="content" id="content12B" style="background-color: white">
                <div class="inner">
                    <table>
                        <tr>
                            <td>
                                <b>Please Select Your Answer (Only one selction can be made.) </b>
                            </td>
                        </tr>
                        <tr>

                            <td colspan="1" style="width: 100%; padding-bottom: 10px">

                                <asp:CheckBox ID="chkoverallenvnstrategyandtimelingfirstoption" runat="server" Style="height: 200px" AutoPostBack="true" OnCheckedChanged="chkoverallenvnstrategyandtimelingfirstoption_checked" />
                                The Envi Programs Division requests an Interdisciplinary 
                            Planning Team (IPT) meeting with regional and VA Division (VHA, NCA, VBA etc.) project personnel to discuss this
                            project in more detail and consider all potential impacts and alternatives. 
                               
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="width: 100%; padding-bottom: 10px">
                                <asp:CheckBox ID="chkoverallenvnstrategyandtimelingsecondoption" runat="server" Style="height: 200px" AutoPostBack="true" OnCheckedChanged="chkoverallenvnstrategyandtimelingsecondoption_checked" />
                                An Interdisciplinary Planning Team (IPT) meeting with regional and VA Division (VHA, NCA, VBA etc.) project personnel
                                is not required for this project. The assigned Environmental SME will coordinate appropriately with the CFM PM and Region
                                regarding the Environmental needs specific to this project.                               
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:TextBox ID="txtareaenvnprogramstrategy" runat="server" Width="100%" TextMode="MultiLine" Height="75px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="width: 100%; padding-top: 15px">New Envriornmental Contract Required:
                                 <span style="padding-left: 100px">
                                     <asp:DropDownList ID="ddlEnvncontractreuired" runat="server" Width="25%">
                                         <asp:ListItem></asp:ListItem>
                                         <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                         <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                     </asp:DropDownList>
                                 </span>
                            </td>
                        </tr>

                    </table>
                </div>
            </div>
            <!-- 13th menu  -->
            <input type="radio" id="acc13" onclick="toggleconntent('content13')" />
            <label for="acc13"><b>ANTICIPATED SCHEDULE FOR COMPLETION OF ENVIRONMENTAL DUE DILIGENCE AND NEPA DOCUMENTATION</b></label>
            <div class="content" id="content13">
                <div class="inner" style="background-color: white">
                    <table class="table" style="width: 100%">
                        <thead>
                            <tr>
                                <th scope="col">Schedule</th>
                                <th scope="col">Prospectus</th>
                                <th scope="col">Original</th>
                                <th scope="col">Revised</th>
                                <th scope="col">Actual</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <th scope="row" style="text-align: left; font-weight: normal">Environmental Contract Award:</th>
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
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <th scope="row" style="text-align: left; font-weight: normal">Due diligence (Environmental Background Reports Completed):</th>
                                <td>
                                    <asp:TextBox ID="txtDuedilligeneceprospectus" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtDuedilligeneceoriginal" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtDuedilligenecerevised" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtDuedilligeneceactual" runat="server" CssClass="datepicker"></asp:TextBox></td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <th scope="row" style="text-align: left; font-weight: normal"><b>NEPA Documentation Milestone Schedule:</b></th>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <th scope="row" style="text-align: left; font-weight: normal">Anticipated NEPA documentation Kickoff:</th>
                                <td>
                                    <asp:TextBox ID="txtAnticipatednepadocumentationkickoffprospectus" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatednepadocumentationkickofforiginal" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatednepadocumentationkickoffrevised" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatednepadocumentationkickoffactual" runat="server" CssClass="datepicker"></asp:TextBox></td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <th scope="row" style="text-align: left; font-weight: normal">Anticipated Draft NEPA Document Date:</th>
                                <td>
                                    <asp:TextBox ID="txtAnticipateddraftnepadocumentdateprospectus" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipateddraftnepadocumentdateoriginal" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipateddraftnepadocumentdaterevised" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipateddraftnepadocumentdateactual" runat="server" CssClass="datepicker"></asp:TextBox></td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <th scope="row" style="text-align: left; font-weight: normal">Anticipated Final NEPA Document: </th>
                                <td>
                                    <asp:TextBox ID="txtAnticipatedfinalnepadocumentprospectus" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatedfinalnepadocumentoriginal" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatedfinalnepadocumentrevised" runat="server" CssClass="datepicker"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtAnticipatedfinalnepadocumentactual" runat="server" CssClass="datepicker"></asp:TextBox></td>
                            </tr>
                            <tr onmouseover="style.backgroundColor='#b3ccff'" onmouseout="style.backgroundColor=''">
                                <th scope="row" style="text-align: left; font-weight: normal">Anticipated NEPA Decision (FONSI/ROD):</th>
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
            </div>
            <!-- 14th menu  -->
            <input type="radio" id="acc14" onclick="toggleconntent('content14')" />
            <label for="acc14"><b>ENVIRONMENTAL DATA NEED REQUESTS</b></label>
            <div class="content" id="content14">
                <div class="inner" style="background-color: white">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="1" style="width: 50%">
                                <asp:Label ID="Label7" runat="server" Text="General Environmental Information needs from the PM for Envi Contract Execution:" Font-Bold="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox ID="txtareaEnvironmentaldataneedrequests" runat="server" Width="100%" TextMode="MultiLine" Height="75px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <br />
            <br />
            <br />
            <div style="text-align: center">
                <asp:Button ID="btnSave" runat="server" Text="Save" Style="width: 15%; padding-top: 10px; padding-bottom: 10px;" OnClick="btnSave_Click" OnClientClick="if (!confirm('Are you sure you want save the records?')) return false;" />
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" Style="width: 15%; padding-top: 10px; padding-bottom: 10px;" CausesValidation="true" OnClick="btnSubmit_Click" OnClientClick="if (!confirm('Are you sure you want to submit? Once you submit this you will not be able to make any changes or updates.')) return false;" />
            </div>
        </div>
    </div>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript">
        function show() {
            if (typeof (window.Page_ClientValidate) == 'function') {
                if (window.Page_ClientValidate('nepassistreport') === false) {
                    return false;
                }
            }
            $(".loader").css("display", "block");
            return true;
        }
         function showipac() {
            if (typeof (window.Page_ClientValidate) == 'function') {
                if (window.Page_ClientValidate('ipacunofficalspecies') === false) {
                    return false;
                }
            }
            $(".loader").css("display", "block");
            return true;
        }
         function shownwimap() {
            if (typeof (window.Page_ClientValidate) == 'function') {
                if (window.Page_ClientValidate('nwimap') === false) {
                    return false;
                }
            }
            $(".loader").css("display", "block");
            return true;
        }
        $('.datepicker').each(function () {
            $(this).datepicker();
        });
    </script>

</asp:Content>
