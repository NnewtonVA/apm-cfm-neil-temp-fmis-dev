Imports System.Data.SqlClient
Imports System.Net.Mail

Public Class UnassignedSubmittedQuestionnaireForm
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' convert the Project Environment Survey into pivot table to avoid looping
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "GetProjectEnviroSurvey"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@ProjectId", strProjId))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter

        adp.SelectCommand = cmd
        Dim ds As New DataSet
        adp.Fill(ds)
        If conn.State = ConnectionState.Open Then
            conn.Close()
        End If
        adp.Dispose()
        '1- chkPinNo
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("1").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("1").ToString()) = 1 Then
                chkYes.Checked = True
                dvPinNo.Attributes.Add("style", "display: normal")
                dvPinNo1.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("1").ToString()) = 2 Then
                chkNo.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("1").ToString()) = 3 Then
                chkunk.Checked = True
            End If
        End If
        txtPinNo.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "49", True)

        '2- chkseps
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("2").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("2").ToString()) = 1 Then
                chksepsyes.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("2").ToString()) = 2 Then
                chksepsno.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("2").ToString()) = 3 Then
                chksepsunk.Checked = True
            End If
        End If

        '3- chkMp
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("3").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("3").ToString()) = 1 Then
                chkYesmp.Checked = True
                dvlanduse.Attributes.Add("style", "display: normal")
                dvlanduseopt.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("3").ToString()) = 2 Then
                chkNomp.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("3").ToString()) = 3 Then
                chkunkmp.Checked = True
            End If
        End If

        '4- chkcnslnd
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("4").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("4").ToString()) = 1 Then
                chkYescnslnd.Checked = True
                dvlnktomap.Attributes.Add("style", "display: normal")
                dvlnkmp.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("4").ToString()) = 2 Then
                chkNocnslnd.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("4").ToString()) = 3 Then
                chkuncnslnd.Checked = True
            End If
        End If
        txtPinNo2.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "5", True)


        '6- consistentwithmarketstudy
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("6").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("6").ToString()) = 1 Then
                chkYesCcnsistentwithmarketstudy.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("6").ToString()) = 2 Then
                chkNoconsistentwithmarketstudy.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("6").ToString()) = 3 Then
                chkUnkconsistentwithmarketstudy.Checked = True
            End If
        End If

        '50- Outleasethroughorp
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("50").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("50").ToString()) = 1 Then
                chkYesoutleasethroughorp.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("50").ToString()) = 2 Then
                chkNooutleasethroughorp.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("50").ToString()) = 3 Then
                chkUnkoutleasethroughorp.Checked = True
            End If
        End If

        '51- orphandlingpm
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("51").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("51").ToString()) = 1 Then
                chkYesorphandlingpm.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("51").ToString()) = 2 Then
                chkNoorphandlingpm.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("51").ToString()) = 3 Then
                chkUnkorphandlingpm.Checked = True
            End If
        End If

        '52- outleaseexpirationdate
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("52").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("52").ToString()) = 1 Then
                chkYesoutleaseexpirationdate.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("52").ToString()) = 2 Then
                chkNooutleaseexpirationdate.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("52").ToString()) = 3 Then
                chkUnkoutleaseexpirationdate.Checked = True
            End If
        End If

        '53- knowneasement
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("53").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("53").ToString()) = 1 Then
                chkYesknowneasement.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("53").ToString()) = 2 Then
                chkNoknowneasement.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("53").ToString()) = 3 Then
                chkUnkknowneasement.Checked = True
            End If
        End If
        '54
        txtOrprecordsofeasement.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "54", True)

        '90 -
        dvRealestateaction.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "90", True)

        '7- proposedaction
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("7").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("7").ToString()) = 1 Then
                chkYespropactn.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("7").ToString()) = 2 Then
                chkNopropactn.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("7").ToString()) = 3 Then
                chkunkpropactn.Checked = True
            End If
        End If

        '8- pairea
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("8").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("8").ToString()) = 1 Then
                chkYespairea.Checked = True
                dvorpeffort.Attributes.Add("style", "display: normal")
                dvorpeffortchk.Attributes.Add("style", "display: normal")
                dvadnacres.Attributes.Add("style", "display: normal")
                dvchkadnacres.Attributes.Add("style", "display: normal")
                dvSizeofadnacres.Attributes.Add("style", "display: normal")
                dvSizeofadnacrestxtbox.Attributes.Add("style", "display: normal")
                dvRequirenew.Attributes.Add("style", "display: normal")
                dvRequirenewchk.Attributes.Add("style", "display: normal")
                dvIncreaseofacreage.Attributes.Add("style", "display: normal")
                dvIncreaseofacreagechk.Attributes.Add("style", "display: normal")
                dvRealestatepoint.Attributes.Add("style", "display: normal")
                dvRealestatepointchk.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("8").ToString()) = 2 Then
                chkNopairea.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("8").ToString()) = 3 Then
                chkunkpairea.Checked = True
            End If
        End If

        '9- rpeffortchk
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("9").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("9").ToString()) = 1 Then
                chkYesrpeffortchk.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("9").ToString()) = 2 Then
                chkNorpeffortchk.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("9").ToString()) = 3 Then
                chkunkrpeffortchk.Checked = True
            End If
        End If

        '10- adnacres
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("10").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("10").ToString()) = 1 Then
                chkYesadnacres.Checked = True
                dvSizeofadnacres.Attributes.Add("style", "display: normal")
                dvSizeofadnacrestxtbox.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("10").ToString()) = 2 Then
                chkNoadnacres.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("10").ToString()) = 3 Then
                chkunkadnacres.Checked = True
            End If
        End If
        '11
        txtSizeofadnacres.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "11", True)

        '12- requirenew
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("12").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("12").ToString()) = 1 Then
                chkYesrequirenew.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("12").ToString()) = 2 Then
                chkNorequirenew.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("12").ToString()) = 3 Then
                chkunkrequirenew.Checked = True
            End If
        End If

        '13- increaseofacreagechk
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("13").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("13").ToString()) = 1 Then
                chkYesincreaseofacreagechk.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("13").ToString()) = 2 Then
                chkNoincreaseofacreagechk.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("13").ToString()) = 3 Then
                chkunkincreaseofacreagechk.Checked = True
            End If
        End If

        '14- realestatepointchk
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("14").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("14").ToString()) = 1 Then
                chkYesrealestatepointchk.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("14").ToString()) = 2 Then
                chkNorealestatepointchk.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("14").ToString()) = 3 Then
                chkunkrealestatepointchk.Checked = True
            End If
        End If


        '15- procurmentorleasing
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("15").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("15").ToString()) = 1 Then
                chkYesprocurmentorleasing.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("15").ToString()) = 2 Then
                chkNoprocurmentorleasing.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("15").ToString()) = 3 Then
                chkunkprocurmentorleasing.Checked = True
            End If
        End If

        '16- demolition
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("16").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("16").ToString()) = 1 Then
                chkYesdemolition.Checked = True
                dvSqrfootagedemolition.Attributes.Add("style", "display: normal")
                dvSqrfootagedemolitiontxtbox.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("16").ToString()) = 2 Then
                chkNodemolition.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("16").ToString()) = 3 Then
                chkunkdemolition.Checked = True
            End If
        End If
        '17
        txtSqrfootagedemolition.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "17", True)

        '18- footprintcaptured
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("18").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("18").ToString()) = 1 Then
                chkYesfootprintcaptured.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("18").ToString()) = 2 Then
                chkNofootprintcaptured.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("18").ToString()) = 3 Then
                chkunkfootprintcaptured.Checked = True
            End If
        End If

        '19- pkngstructure
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("19").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("19").ToString()) = 1 Then
                chkYespkngstructure.Checked = True
                dvAdnsqftgoverallprojectscope.Attributes.Add("style", "display: normal")
                dvChkadnsqftgoverallprojectscope.Attributes.Add("style", "display: normal")
                dvAppropriatesqfootage.Attributes.Add("style", "display: normal")
                dvChkappropriatesqfootage.Attributes.Add("style", "display: normal")
                dvProjectheight.Attributes.Add("style", "display: normal")
                dvtxtprojectheight.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("19").ToString()) = 2 Then
                chkNopkngstructure.Checked = True

            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("19").ToString()) = 3 Then
                chkunkpkngstructure.Checked = True
            End If
        End If

        '20- adnsqftgoverallprojectscope
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("20").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("20").ToString()) = 1 Then
                chkYesAdnsqftgoverallprojectscope.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("20").ToString()) = 2 Then
                chkNoAdnsqftgoverallprojectscope.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("20").ToString()) = 3 Then
                chkunkAdnsqftgoverallprojectscope.Checked = True
            End If
        End If

        '21
        txtAppropriatesqfootage.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "21", True)

        '22
        txtProjectheight.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "22", True)

        '23- envsiteassement
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("23").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("23").ToString()) = 1 Then
                chkYesenvsiteassement.Checked = True
                dvlnktoreport.Attributes.Add("style", "display: normal")
                dvTxtlnktoreport.Attributes.Add("style", "display: normal")
                dvrecenvcondition.Attributes.Add("style", "display: normal")
                dvChkrecenvcondition.Attributes.Add("style", "display: normal")
                dvbriefdscpn.Attributes.Add("style", "display: normal")
                dvTxtbriefdscpn.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("23").ToString()) = 2 Then
                chkNoenvsiteassement.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("23").ToString()) = 3 Then
                chkunkenvsiteassement.Checked = True
            End If
        End If

        '24
        txtLnktoreport.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "24", True)

        '25- recenvcondition
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("25").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("25").ToString()) = 1 Then
                chkYesrecenvcondition.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("25").ToString()) = 2 Then
                chkNorecenvcondition.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("25").ToString()) = 3 Then
                chkunkrecenvcondition.Checked = True
            End If
        End If

        '26
        txtbriefdscpn.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "26", True)

        '27- subsurfacesuitability
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("27").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("27").ToString()) = 1 Then
                chkYessubsurfacesuitability.Checked = True
                dvreportsoil.Attributes.Add("style", "display: normal")
                dvChkreportsoil.Attributes.Add("style", "display: normal")
                dvhighgrndlevels.Attributes.Add("style", "display: normal")
                dvChkhighgrndlevels.Attributes.Add("style", "display: normal")
                dveffectconstruction.Attributes.Add("style", "display: normal")
                dvChkeffectconstruction.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("27").ToString()) = 2 Then
                chkNosubsurfacesuitability.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("27").ToString()) = 3 Then
                chkunksubsurfacesuitability.Checked = True
            End If
        End If

        '28
        txtReportSoil.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "28", True)

        '29- highgrndlevels
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("29").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("29").ToString()) = 1 Then
                chkYeshighgrndlevels.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("29").ToString()) = 2 Then
                chkNohighgrndlevels.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("29").ToString()) = 3 Then
                chkunkhighgrndlevels.Checked = True
            End If
        End If

        '30- effectconstruction
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("30").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("30").ToString()) = 1 Then
                chkYeseffectconstruction.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("30").ToString()) = 2 Then
                chkNoeffectconstruction.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("30").ToString()) = 3 Then
                chkunkeffectconstruction.Checked = True
            End If
        End If

        '31- containmentssoil
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("31").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("31").ToString()) = 1 Then
                chkYescontainmentssoil.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("31").ToString()) = 2 Then
                chkNocontainmentssoil.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("31").ToString()) = 3 Then
                chkunkcontainmentssoil.Checked = True
            End If
        End If

        '32- hazordousmtrl
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("32").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("32").ToString()) = 1 Then
                chkYeshazordousmtrl.Checked = True
                dvcontainmentsdocn.Attributes.Add("style", "display: normal")
                dvcontainmentsdocnanswers.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("32").ToString()) = 2 Then
                chkNohazordousmtrl.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("32").ToString()) = 3 Then
                chkunkhazordousmtrl.Checked = True
            End If
        End If

        '33- dcmntlimits
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("33").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("33").ToString()) = 1 Then
                chkYesdcmntlimits.Checked = True
                dvlink.Attributes.Add("style", "display: normal")
                dvlinktextbox.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("33").ToString()) = 2 Then
                chkNodcmntlimits.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("33").ToString()) = 3 Then
                chkNodcmntlimits.Checked = True
            End If
        End If
        '91 documents link
        txtlinktocontainmentsdocuments.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "91", True)
        '34- fullasbestos
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("34").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("34").ToString()) = 1 Then
                chkYesfullasbestos.Checked = True
                dvpreviouselbpandacmanalysis.Attributes.Add("style", "display: normal")
                dvpreviouselbpandacmanalysischkbox.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("34").ToString()) = 2 Then
                chkNofullasbestos.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("34").ToString()) = 3 Then
                chkunkfullasbestos.Checked = True
            End If
        End If

        '35
        txtPreviouselbpandacmanalysis.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "35", True)

        '36- polychlorinatepiphenyls
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("36").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("36").ToString()) = 1 Then
                chkYespolychlorinatepiphenyls.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("36").ToString()) = 2 Then
                chkNopolychlorinatepiphenyls.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("36").ToString()) = 3 Then
                chkunkpolychlorinatepiphenyls.Checked = True
            End If
        End If

        '37- bldngfiftyyears
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("37").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("37").ToString()) = 1 Then
                chkYesbldngfiftyyears.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("37").ToString()) = 2 Then
                chkNobldngfiftyyears.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("37").ToString()) = 3 Then
                chkunkbldngfiftyyears.Checked = True
            End If
        End If

        '38- nhpaevaluation
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("38").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("38").ToString()) = 1 Then
                chkYesnhpaevaluation.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("38").ToString()) = 2 Then
                chkNonhpaevaluation.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("38").ToString()) = 3 Then
                chkunknhpaevaluation.Checked = True
            End If
        End If

        '39- lstedhistoricregister
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("39").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("39").ToString()) = 1 Then
                chkYeslstedhistoricregister.Checked = True
                dvhsitoricarcheolgical.Attributes.Add("style", "display: normal")
                dvChkhsitoricarcheolgical.Attributes.Add("style", "display: normal")
                dvlnktoattachpastreeports.Attributes.Add("style", "display: normal")
                dvChklnktoattachpastreeports.Attributes.Add("style", "display: normal")
                dvPreservationplan.Attributes.Add("style", "display: normal")
                dvChkpreservationplan.Attributes.Add("style", "display: normal")
                dvlnkpreservationplan.Attributes.Add("style", "display: normal")
                dvChklnkpreservationplan.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("39").ToString()) = 2 Then
                chkNolstedhistoricregister.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("39").ToString()) = 3 Then
                chkunklstedhistoricregister.Checked = True
            End If
        End If

        '40 hsitoricarcheolgical
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("40").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("40").ToString()) = 1 Then
                chkYeshsitoricarcheolgical.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("40").ToString()) = 2 Then
                chkNohsitoricarcheolgical.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("40").ToString()) = 3 Then
                chkunkhsitoricarcheolgical.Checked = True
            End If
        End If

        '41
        txtLinktopastreports.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "41", True)

        '42 - preservationplan
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("42").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("42").ToString()) = 1 Then
                chkYespreservationplan.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("42").ToString()) = 2 Then
                chkNopreservationplan.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("42").ToString()) = 3 Then
                chkunkpreservationplan.Checked = True
            End If
        End If

        '43
        txtLinktopreservationplan.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "43", True)

        '44- exstnhpaagreement
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("44").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("44").ToString()) = 1 Then
                chkYesexstnhpaagreement.Checked = True
                dvlnktoanyagreement.Attributes.Add("style", "display: normal")
                dvChklnktoanyagreement.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("44").ToString()) = 2 Then
                chkNoexstnhpaagreement.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("44").ToString()) = 3 Then
                chkunkexstnhpaagreement.Checked = True
            End If
        End If

        '45
        Txtlnktoanyagreement.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "45", True)

        '46- exstrelnwithconsuparties
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("46").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("46").ToString()) = 1 Then
                chkYesexstrelnwithconsuparties.Checked = True
                dvlnktoannualrptsreuirement.Attributes.Add("style", "display: normal")
                dvChklnktoannualrptsreuirement.Attributes.Add("style", "display: normal")
                dvlnktolatestannualreports.Attributes.Add("style", "display: normal")
                dvTxtlnktolatestannualreports.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("46").ToString()) = 2 Then
                chkNoexstrelnwithconsuparties.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("46").ToString()) = 3 Then
                chkunkexstrelnwithconsuparties.Checked = True
            End If
        End If

        '47- lnktoannualrptsreuirement
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("47").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("47").ToString()) = 1 Then
                chkYeslnktoannualrptsreuirement.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("47").ToString()) = 2 Then
                chkNolnktoannualrptsreuirement.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("47").ToString()) = 3 Then
                chkunklnktoannualrptsreuirement.Checked = True
            End If
        End If

        '48
        Txtlinktolatestannualreports.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "48", True)

        '55- envsensitive
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("55").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("55").ToString()) = 1 Then
                chkYesenvsensitive.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("55").ToString()) = 2 Then
                chkNoenvsensitive.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("55").ToString()) = 3 Then
                chkunkenvsensitive.Checked = True
            End If
        End If

        '56- stateorfederalthreatened
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("56").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("56").ToString()) = 1 Then
                chkYesstateorfederalthreatened.Checked = True
                dvlnktostateorfederalthreatenedprevreport.Attributes.Add("style", "display: normal")
                dvChklnktostateorfederalthreatenedprevreport.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("56").ToString()) = 2 Then
                chkNostateorfederalthreatened.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("56").ToString()) = 3 Then
                chkUnkstateorfederalthreatened.Checked = True
            End If
        End If

        '57- stateorfederalthreatenedprevreport
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("57").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("57").ToString()) = 1 Then
                chkYesstateorfederalthreatenedprevreport.Checked = True
                dvLnktoattachesarpt.Attributes.Add("style", "display: normal")
                dvlnktoattachesarpttxt.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("57").ToString()) = 2 Then
                chkNostateorfederalthreatenedprevreport.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("57").ToString()) = 3 Then
                chkunkstateorfederalthreatenedprevreport.Checked = True
            End If
        End If
        '58
        Txtlnktoattachesarpt.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "58", True)


        '59- femafloodplain
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("59").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("59").ToString()) = 1 Then
                chkYesfemafloodplain.Checked = True
                dvpercentageinfloodplain.Attributes.Add("style", "display: normal")
                dvlnktopercentageinfloodplain.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("59").ToString()) = 2 Then
                chkNofemafloodplain.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("59").ToString()) = 3 Then
                chkunkfemafloodplain.Checked = True
            End If
        End If

        '60
        Txtpercentageinfloodplain.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "60", True)

        '61- knownormappedwetlands
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("61").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("61").ToString()) = 1 Then
                chkYesknownormappedwetlands.Checked = True
                dvlnktowetlandimpacted.Attributes.Add("style", "display: normal")
                dvChkwetlandimpacted.Attributes.Add("style", "display: normal")

            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("61").ToString()) = 2 Then
                chkNoknownormappedwetlands.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("61").ToString()) = 3 Then
                chkUnkknownormappedwetlands.Checked = True
            End If
        End If

        '62- wetlandimpacted
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("62").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("62").ToString()) = 1 Then
                chkYeswetlandimpacted.Checked = True
                dvlnktoanticpatedwetlandspermit.Attributes.Add("style", "display: normal")
                dvChklnktoanticpatedwetlandspermit.Attributes.Add("style", "display: normal")
                dvlnktoexstwetlandpermitsoragreement.Attributes.Add("style", "display: normal")
                dvChklnktoexstwetlandpermitsoragreement.Attributes.Add("style", "display: normal")
                dvlnktowetlandsexcitingpermits.Attributes.Add("style", "display: normal")
                dvChklnktowetlandsexcitingpermits.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("62").ToString()) = 2 Then
                chkNowetlandimpacted.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("62").ToString()) = 3 Then
                chkUnkwetlandimpacted.Checked = True
            End If
        End If

        '63- anticpatedwetlandspermit
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("63").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("63").ToString()) = 1 Then
                chkYesanticpatedwetlandspermit.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("63").ToString()) = 2 Then
                chkNoanticpatedwetlandspermit.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("63").ToString()) = 3 Then
                chkUnkanticpatedwetlandspermit.Checked = True
            End If
        End If

        '64- exstwetlandpermitsoragreement
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("64").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("64").ToString()) = 1 Then
                chkYesexstwetlandpermitsoragreement.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("64").ToString()) = 2 Then
                chkNoexstwetlandpermitsoragreement.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("64").ToString()) = 3 Then
                chkUnkexstwetlandpermitsoragreement.Checked = True
            End If
        End If

        '65
        txtwetlandsexcitingpermits.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "65", True)

        '66- currentstormwateradequate
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("66").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("66").ToString()) = 1 Then
                chkYescurrentstormwateradequate.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("66").ToString()) = 2 Then
                chkNocurrentstormwateradequate.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("66").ToString()) = 3 Then
                chkUnkcurrentstormwateradequate.Checked = True
            End If
        End If

        '67- retentionofsw
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("67").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("67").ToString()) = 1 Then
                chkYesretentionofsw.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("67").ToString()) = 2 Then
                chkNoretentionofsw.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("67").ToString()) = 3 Then
                chkUnkretentionofsw.Checked = True
            End If
        End If

        '68- fallcoastalzone
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("68").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("68").ToString()) = 1 Then
                chkYesfallcoastalzone.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("68").ToString()) = 2 Then
                chkNofallcoastalzone.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("68").ToString()) = 3 Then
                chkUnkfallcoastalzone.Checked = True
            End If
        End If


        '70- sufficesntutilities
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("70").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("70").ToString()) = 1 Then
                chkYessufficesntutilities.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("70").ToString()) = 2 Then
                chkNosufficesntutilities.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("70").ToString()) = 3 Then
                chkUnksufficesntutilities.Checked = True
            End If
        End If

        '71 
        chkElectrical.Checked = True
        chkSanitarysewer.Checked = True
        chkStormsewer.Checked = True
        chkSteam.Checked = True
        chkPortablewater.Checked = True
        chkChilledWater.Checked = True
        chkNaturalgas.Checked = True
        chkRelaimedwater.Checked = True


        '72- utilitiestobebroughtfrmsite
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("72").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("72").ToString()) = 1 Then
                chkYesutilitiestobebroughtfrmsite.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("72").ToString()) = 2 Then
                chkNoutilitiestobebroughtfrmsite.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("72").ToString()) = 3 Then
                chkUnkutilitiestobebroughtfrmsite.Checked = True
            End If
        End If

        '73 not yet done
        txtElectrical.Text = "Test"
        txtSanitarySewer.Text = "Test"
        txtStormSewer.Text = "Test"
        txtSteam.Text = "Test"
        txtPortableWater.Text = "Test"
        txtChilledWater.Text = "Test"
        txtNaturalGas.Text = "Test"
        txtReclaimedWaterSource.Text = "Test"

        '74- proposedroutingofutilities
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("74").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("74").ToString()) = 1 Then
                chkYesproposedroutingofutilities.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("74").ToString()) = 2 Then
                chkNoproposedroutingofutilities.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("74").ToString()) = 3 Then
                chkUnkproposedroutingofutilities.Checked = True
            End If
        End If

        '75- utilitiesevaluationofsite
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("75").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("75").ToString()) = 1 Then
                chkYesutilitiesevaluationofsite.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("75").ToString()) = 2 Then
                chkNoutilitiesevaluationofsite.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("75").ToString()) = 3 Then
                chkUnkutilitiesevaluationofsite.Checked = True
            End If
        End If

        '76- trafficissue
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("76").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("76").ToString()) = 1 Then
                chkYestrafficissue.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("76").ToString()) = 2 Then
                chkNotrafficissue.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("76").ToString()) = 3 Then
                chkUnktrafficissue.Checked = True
            End If
        End If

        '77- impacttrafficsiteaccess
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("77").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("77").ToString()) = 1 Then
                chkYesimpacttrafficsiteaccess.Checked = True
                dvlnktotrafficimpactsduringconstn.Attributes.Add("style", "display: normal")
                dvChklnktotrafficimpactsduringconstn.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("77").ToString()) = 2 Then
                chkNoimpacttrafficsiteaccess.Checked = True
                dvlnktotrafficstudycompleted.Attributes.Add("style", "display: normal")
                dvChklnktotrafficstudycompleted.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("77").ToString()) = 3 Then
                chkUnkimpacttrafficsiteaccess.Checked = True
            End If
        End If

        '78- trafficimpactsduringconstn
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("78").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("78").ToString()) = 1 Then
                chkYestrafficimpactsduringconstn.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("78").ToString()) = 2 Then
                chkNotrafficimpactsduringconstn.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("78").ToString()) = 3 Then
                chkUnktrafficimpactsduringconstn.Checked = True
            End If
        End If

        '79- trafficstudycompleted"
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("79").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("79").ToString()) = 1 Then
                chkYestrafficstudycompleted.Checked = True
                dvprovidelnkotrafficstudies.Attributes.Add("style", "display: normal")
                providelnkotrafficstudy.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("79").ToString()) = 2 Then
                chkNotrafficstudycompleted.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("79").ToString()) = 3 Then
                chkUnktrafficstudycompleted.Checked = True
            End If
        End If

        '80 ???????
        txtProvidelnkotrafficstudy.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "80", True)

        '81- masstransitcloseproximity
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("81").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("81").ToString()) = 1 Then
                chkYesmasstransitcloseproximity.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("81").ToString()) = 2 Then
                chkNomasstransitcloseproximity.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("81").ToString()) = 3 Then
                chkUnkmasstransitcloseproximity.Checked = True
            End If
        End If

        '82- previousnepaeaoreis
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("82").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("82").ToString()) = 1 Then
                chkYespreviousnepaeaoreis.Checked = True
                dvfinaleasignedfonsi.Attributes.Add("style", "display: normal")
                dvChkfinaleasignedfonsi.Attributes.Add("style", "display: normal")
                dvPLnkpreviousnepaeaoreis.Attributes.Add("style", "display: normal")
                dvpreviousnepaeaoreis.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("82").ToString()) = 2 Then
                chkNopreviousnepaeaoreis.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("82").ToString()) = 3 Then
                chkUnkpreviousnepaeaoreis.Checked = True
            End If
        End If

        '83- finaleasignedfonsi
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("83").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("83").ToString()) = 1 Then
                chkYesfinaleasignedfonsi.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("83").ToString()) = 2 Then
                chkNorfinaleasignedfonsi.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("83").ToString()) = 3 Then
                chkUnkfinaleasignedfonsi.Checked = True
            End If
        End If

        '84
        txtpreviousnepaeaoreis.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "84", True)


        '85- prevcomplnepadocnavailable
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("85").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("85").ToString()) = 1 Then
                chkYesprevcomplnepadocnavailable.Checked = True
                dvLnksitepocpastnepadocn.Attributes.Add("style", "display: normal")
                dvTxtlnksitepocpastnepadocn.Attributes.Add("style", "display: normal")
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("85").ToString()) = 2 Then
                chkNoprevcomplnepadocnavailable.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("85").ToString()) = 3 Then
                chkUnkprevcomplnepadocnavailable.Checked = True
            End If
        End If

        '86
        txtLnksitepocpastnepadocn.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "86", True)

        '87- otherprojectunderwayorplanned
        If ConvertToInteger(ds.Tables(0).Rows(0).Item("87").ToString()) <> 0 Then
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("87").ToString()) = 1 Then
                chkYesotherprojectunderwayorplanned.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("87").ToString()) = 2 Then
                chkNootherprojectunderwayorplanned.Checked = True
            ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("87").ToString()) = 3 Then
                chkUnkotherprojectunderwayorplanned.Checked = True
            End If
        End If

        '88
        txtImpactsofphysicalsecurity.InnerText = GetprojectEnviroSurveyLinkorComment(strProjId, "86", True)

        '89
        txtProposedpotentiallyimpacts.InnerText = GetprojectEnviroSurveyLinkorComment(strProjId, "86", True)
    End Sub



    Private Function ConvertToInteger(ByRef value As String) As Integer
        If String.IsNullOrEmpty(value) Then
            value = "0"
        End If
        Return Convert.ToInt32(value)
    End Function


    Private Function GetprojectEnviroSurveyLinkorComment(strProjId As String, Survey_pk As String, IsLink As Boolean) As String
        Dim strResult As String
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "GetprojectEnviroSurveyLinkorComment"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = strProjId
            command.Parameters.AddWithValue("@survey_pk", SqlDbType.Int).Value = Survey_pk
            command.Parameters.AddWithValue("@isLink", SqlDbType.Bit).Value = IsLink
            command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            command.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            strResult = command.Parameters("@Result").Value.ToString
        End Using

        Return strResult
    End Function

    ''' <summary>
    '''Clicking Save button in adding weekly comment form will run the SP AddLeadershipHighlights
    ''' </summary>
    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)
        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))

        Dim strPersonnelId As String = ddlAssignTo.SelectedValue.ToString
        Dim strPersonnelName As String = ddlAssignTo.SelectedItem.Text.ToString
        Dim strRoleId As String = "10"       ' role for Environmental Engineer

        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "AddPersonnelInProject"
            command.CommandType = CommandType.StoredProcedure

            command.Parameters.AddWithValue("@ProjectId", DbNullOrStringValue(strProjNum))
            command.Parameters.AddWithValue("@PersonnelId", DbNullOrStringValue(strPersonnelId))
            command.Parameters.AddWithValue("@RoleId", DbNullOrStringValue(strRoleId))
            command.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            command.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            '           Dim strUnassignedProjectListURL = "'" + ConfigurationManager.AppSettings("UnassignedProjectListURL").ToString() + "'"
            '           Dim strMsg As String = "'The questionnaire Is submitted And assigned To an engineer For Initial Response.', " + strUnassignedProjectListURL
            '            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "SaveAlertAndCloseWindowMsg(strMsg);", True)
            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "SaveAlertAndCloseWindowMsg('The questionnaire is submitted and assigned to an engineer for Initial Response.');", True)

            ' send notification to an engineer work on the questionnaire for initial response
            SendNotificationToanEngineer(strPersonnelName, strPersonnelId, strProjNum)

            Dim pageUrl As String = "UnassignedSubmittedQuestionnaireList.aspx"
            Response.Redirect(pageUrl)

        End Using

    End Sub

    Private Sub SendNotificationToanEngineer(strPersonnelName As String, strPersonnelId As String, strproject_pk As String)
        Dim strPersonnelEmail As String
        Dim strProjectCode As String
        Dim strEnvironmentalProjectFromEmail As String = ConfigurationManager.AppSettings("EnvironmentalProjectFromEmail").ToString

        'new line
        Dim uname As String = Context.User.Identity.Name
        Dim strLoggedUser As String = uname.Substring(uname.LastIndexOf("\") + 1)

        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "GetPersonnelEmail"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@personnel_pk", SqlDbType.Int).Value = strPersonnelId
            command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            command.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            strPersonnelEmail = command.Parameters("@Result").Value.ToString
        End Using

        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "GetprojectCode"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = strproject_pk
            command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            command.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            strProjectCode = command.Parameters("@Result").Value.ToString
        End Using

        '        strPersonnelEmail = "Richard.Belandres@va.gov"
        Dim sb As New StringBuilder()
        'sb.Append(Convert.ToString("<p>Comments on project</p>"))
        sb.Append("<table>")
        sb.Append((Convert.ToString("<tr><td>Hello ") & strPersonnelName) + ",</td></tr>")
        sb.Append((Convert.ToString("<tr><td><br>You have a new project assign to you for initial response in CFMIS. ") + "</td></tr>"))
        sb.Append((Convert.ToString("<tr><td><br>To view the list of project(s) for initial response, click on this link: " + ConfigurationManager.AppSettings("ProjectforInitialListURL").ToString + "</td></tr>")))

        Dim mm As New MailMessage()
        mm.IsBodyHtml = True
        mm.From = New MailAddress(strEnvironmentalProjectFromEmail)
        mm.[To].Add(strPersonnelEmail)
        mm.Subject = "CFMIS Project # " + strProjectCode

        sb.Append("</table>")
        mm.Body = sb.ToString()
        Application("strIP") = "smtp.va.gov"
        Dim smtp As New SmtpClient(Application("strIP").ToString())
        smtp.Send(mm)
        mm.Dispose()

        '        End If
    End Sub

    Private Function DbNullOrStringValue(ByVal value As String) As Object
        If String.IsNullOrEmpty(value) Then
            Return DBNull.Value
        Else
            Return value
        End If
    End Function

    ''' The Home image button will open the Home page.
    '''' </summary>
    Protected Sub ibHome_Click(sender As Object, e As ImageClickEventArgs) Handles ibHome.Click
        Response.Redirect("Default.aspx")
    End Sub
    ''' <summary>
    ''' The Searh image button will open the Search page.
    ''' </summary>
    Protected Sub ibSearch_Click(sender As Object, e As ImageClickEventArgs) Handles ibSearch.Click
        Response.Redirect("SearchProject.aspx")
    End Sub


End Class