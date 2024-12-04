Imports System.Data.SqlClient
Imports System.IO
Imports System.Net.Mail

Public Class WebForm1
    Inherits System.Web.UI.Page
    Dim varId As String
    Dim actualdate As String
    Dim checksubmitstatus As Boolean

    Protected WithEvents txtName As Global.System.Web.UI.WebControls.TextBox

    Private Sub WebForm1_Load(sender As Object, e As EventArgs) Handles Me.Load
        'to get the logged on user
        Dim Logon As String
        Logon = Request.LogonUserIdentity.Name
        Dim nIndex As Integer = Logon.IndexOf("\")
        Logon = Logon.Substring(nIndex + 1)
        lblUserNm.Text = Logon

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        varId = Convert.ToString(Request.QueryString("project_pk"))
        If Not IsPostBack Then
            BindGrid()
        End If
        Getinitialformanswers()
        If Not Page.IsPostBack Then
            'get the project id to pass it to open the factsheet details page
            varId = Convert.ToString(Request.QueryString("project_pk"))
            Getpotentialimpacts()
            GetCheckboxesrecord()
            GetSchedule()
            Dim conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
            Dim cmd As New SqlCommand
            cmd = New SqlCommand("select * FROM EnvironmentalStrategyAnticipatedTimeLine where project_fk=" + varId, conn)
            conn.Open()
            Using sdr As SqlDataReader = cmd.ExecuteReader()
                sdr.Read()
                If sdr.HasRows Then
                    txtareaEnvironmentaldataneedrequests.Text = sdr.GetString(2)
                    txtareaenvnprogramstrategy.Text = sdr.GetString(3)
                    If sdr.GetValue(4) = "1" Then
                        chkoverallenvnstrategyandtimelingfirstoption.Checked = True
                    Else
                        chkoverallenvnstrategyandtimelingsecondoption.Checked = True
                    End If
                    'chkoverallenvnstrategyandtimelingfirstoption.Checked = sdr.GetValue(4)
                    If sdr.GetValue(5) = "1" Then
                        ddlEnvncontractreuired.SelectedValue = 1
                    ElseIf sdr.GetValue(5) = "0" Then
                        ddlEnvncontractreuired.SelectedValue = 0
                    End If
                End If
            End Using
            conn.Close()
            Dim cmd2 As New SqlCommand
            cmd = New SqlCommand("select nepa_fk FROM ProjectNEPA where project_fk=" + varId, conn)
            conn.Open()
            Using sdr As SqlDataReader = cmd.ExecuteReader()
                sdr.Read()
                If sdr.HasRows Then
                    ddlAnticpatednepdocn.SelectedValue = sdr.GetValue(0)
                End If
            End Using
            conn.Close()

            If checksubmitstatus = True Then
                btnSubmit.Enabled = False
                btnSave.Enabled = False
                DisableInitialResponseFields()
            End If
            'End If
            'conn.Close()
        End If
    End Sub

    Private Sub DisableInitialResponseFields()

        ddlLandusepotentialimpact.Enabled = False
        txtLanduseimpactsnote.Enabled = False

        ddlSitegeologyandsoilsuitability.Enabled = False
        txtSitegeologyimpactsnote.Enabled = False

        ddlHazordousmaterial.Enabled = False
        txtHzordousmaterialimpactsnote.Enabled = False

        ddlCulturalandhistorical.Enabled = False
        txtCulturalhistoricimpactnote.Enabled = False

        ddlnaturalresources.Enabled = False
        txtNaturalresourcesimpactnote.Enabled = False

        ddlUtilities.Enabled = False
        txtPotentialImpactsnote.Enabled = False

        ddlstormwaterandcoastal.Enabled = False
        txtStormwaterandcoastalzoneimpactnote.Enabled = False

        ddlTraffic.Enabled = False
        txtTrafficimpactnote.Enabled = False

        chkAirquality.Enabled = False
        chkJointpermit.Enabled = False
        chkErosionpermit.Enabled = False
        chkAgriculturalPermit.Enabled = False

        chkNpdespermit.Enabled = False
        chkUsacewetlandpermit.Enabled = False
        chkwaterandsewagepermit.Enabled = False
        chkfueltankauthzn.Enabled = False

        chkleadabtementpermit.Enabled = False
        chkAsbestospermit.Enabled = False
        chkCoastalzonapproval.Enabled = False
        chkapeciesactpermit.Enabled = False

        FileUpload1.Enabled = False
        btnUpload.Enabled = False
        btnCancel.Enabled = False

        FileUpload2.Enabled = False
        btnuploadipacreport.Enabled = False
        Button2.Enabled = False

        FileUpload3.Enabled = False
        Button1.Enabled = False
        Button3.Enabled = False

        ddlAnticpatednepdocn.Enabled = False
        chkoverallenvnstrategyandtimelingfirstoption.Enabled = False
        chkoverallenvnstrategyandtimelingsecondoption.Enabled = False
        txtareaenvnprogramstrategy.Enabled = False
        ddlEnvncontractreuired.Enabled = False

        txtEnvcontractawardproswpectus.Enabled = False
        txtEnvcontractawardoriginal.Enabled = False
        txtEnvcontractawardrevised.Enabled = False
        txtEnvcontractawardactual.Enabled = False

        txtDuedilligeneceprospectus.Enabled = False
        txtDuedilligeneceoriginal.Enabled = False
        txtDuedilligenecerevised.Enabled = False
        txtDuedilligeneceactual.Enabled = False

        txtAnticipatednepadocumentationkickoffprospectus.Enabled = False
        txtAnticipatednepadocumentationkickofforiginal.Enabled = False
        txtAnticipatednepadocumentationkickoffrevised.Enabled = False
        txtAnticipatednepadocumentationkickoffactual.Enabled = False

        txtAnticipateddraftnepadocumentdateprospectus.Enabled = False
        txtAnticipateddraftnepadocumentdateoriginal.Enabled = False
        txtAnticipateddraftnepadocumentdaterevised.Enabled = False
        txtAnticipateddraftnepadocumentdateactual.Enabled = False

        txtAnticipatedfinalnepadocumentprospectus.Enabled = False
        txtAnticipatedfinalnepadocumentoriginal.Enabled = False
        txtAnticipatedfinalnepadocumentrevised.Enabled = False
        txtAnticipatedfinalnepadocumentactual.Enabled = False

        txtAnticipatednepadecisionfonsiprospectus.Enabled = False
        txtAnticipatednepadecisionfonsioriginal.Enabled = False
        txtAnticipatednepadecisionfonsirevised.Enabled = False
        txtAnticipatednepadecisionfonsiactual.Enabled = False
        txtareaEnvironmentaldataneedrequests.Enabled = False

    End Sub


    Private Sub BindGrid()
        Dim id As Integer = varId
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "select docID, docName from CFMIS_doc where projectID =@Id and docTypeNamePK=@pk"
        cmd.Parameters.AddWithValue("@Id", id)
        cmd.Parameters.AddWithValue("@pk", 1)
        cmd.Connection = conn
        conn.Open()
        grdnepaassistreport.DataSource = cmd.ExecuteReader()
        grdnepaassistreport.DataBind()
        conn.Close()
        Dim cmd2 As New SqlCommand
        cmd2.CommandText = "select docID, docName from CFMIS_doc where projectID =@Id and docTypeNamePK=@pk"
        cmd2.Parameters.AddWithValue("@Id", id)
        cmd2.Parameters.AddWithValue("@pk", 2)
        cmd2.Connection = conn
        conn.Open()
        grdipaclist.DataSource = cmd2.ExecuteReader()
        grdipaclist.DataBind()
        conn.Close()
        Dim cmd3 As New SqlCommand
        cmd3.CommandText = "select docID, docName from CFMIS_doc where projectID =@Id and docTypeNamePK=@pk"
        cmd3.Parameters.AddWithValue("@Id", id)
        cmd3.Parameters.AddWithValue("@pk", 3)
        cmd3.Connection = conn
        conn.Open()
        grdnwimap.DataSource = cmd3.ExecuteReader()
        grdnwimap.DataBind()
        conn.Close()
    End Sub
    Protected Sub DownloadFile(sender As Object, e As EventArgs)
        Dim id As Integer = Integer.Parse(TryCast(sender, LinkButton).CommandArgument)
        Dim bytes As Byte()
        Dim fileName As String, contentType As String
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "select docName, doc, docType from CFMIS_doc where docId=@Id"
        cmd.Parameters.AddWithValue("@Id", id)
        cmd.Connection = conn
        conn.Open()
        Using sdr As SqlDataReader = cmd.ExecuteReader()
            sdr.Read()
            bytes = DirectCast(sdr("doc"), Byte())
            contentType = sdr("docType").ToString()
            fileName = sdr("docName").ToString()
        End Using
        conn.Close()
        Response.Clear()
        Response.Buffer = True
        Response.Charset = ""
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.ContentType = contentType
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName)
        Response.BinaryWrite(bytes)
        Response.Flush()
        Response.End()
    End Sub
    Protected Sub DeleteFile(sender As Object, e As EventArgs)
        Dim id As Integer = Integer.Parse(TryCast(sender, LinkButton).CommandArgument)
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "delete from CFMIS_doc where docId=@Id"
        cmd.Parameters.AddWithValue("@Id", id)
        cmd.Connection = conn
        conn.Open()
        cmd.ExecuteReader()
        conn.Close()
        BindGrid()
    End Sub
    Protected Sub btnCancel_click(sender As Object, e As EventArgs)
        RequiredFieldValidator9.Text = ""
    End Sub
    Protected Sub ibHome_Click(sender As Object, e As ImageClickEventArgs) Handles ibHome.Click
        Response.Redirect("~/Default.aspx")
    End Sub
    Public Function Getinitialformanswers()
        varId = Convert.ToString(Request.QueryString("project_pk"))
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
        If ds.Tables(0).Rows.Count = 0 Then

        Else
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

            '71 not yet done
            Dim utility_1 As String = Getutilitiescheckedornot(strProjId, "1")
            If utility_1 = "1" Then
                chkElectrical.Checked = True
            End If
            Dim utility_2 As String = Getutilitiescheckedornot(strProjId, "2")
            If utility_2 = "2" Then
                chkSanitarysewer.Checked = True
            End If
            Dim utility_3 As String = Getutilitiescheckedornot(strProjId, "3")
            If utility_3 = "3" Then
                chkStormsewer.Checked = True

            End If
            Dim utility_4 As String = Getutilitiescheckedornot(strProjId, "4")
            If utility_4 = "4" Then
                chkPortablewater.Checked = True
            End If
            Dim utility_5 As String = Getutilitiescheckedornot(strProjId, "5")
            If utility_5 = "5" Then
                chkChilledWater.Checked = True
            End If
            Dim utility_6 As String = Getutilitiescheckedornot(strProjId, "6")
            If utility_6 = "6" Then
                chkSteam.Checked = True
            End If
            Dim utility_7 As String = Getutilitiescheckedornot(strProjId, "7")
            If utility_7 = "7" Then
                chkNaturalgas.Checked = True
            End If
            Dim utility_8 As String = Getutilitiescheckedornot(strProjId, "8")
            If utility_8 = "8" Then
                chkRelaimedwater.Checked = True

            End If

            txtElectrical.Text = Getutilitiesrecords(strProjId, "1")
            txtSanitarySewer.Text = Getutilitiesrecords(strProjId, "2")
            txtStormSewer.Text = Getutilitiesrecords(strProjId, "3")
            txtSteam.Text = Getutilitiesrecords(strProjId, "4")
            txtPortableWater.Text = Getutilitiesrecords(strProjId, "5")
            txtChilledWater.Text = Getutilitiesrecords(strProjId, "6")
            txtNaturalGas.Text = Getutilitiesrecords(strProjId, "7")
            txtReclaimedWaterSource.Text = Getutilitiesrecords(strProjId, "8")
            '    chkElectrical.Checked = True
            'chkSanitarysewer.Checked = True
            'chkStormsewer.Checked = True
            'chkSteam.Checked = True
            'chkPortablewater.Checked = True
            'chkChilledWater.Checked = True
            'chkNaturalgas.Checked = True
            'chkRelaimedwater.Checked = True


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
            'txtElectrical.Text = "Test"
            'txtSanitarySewer.Text = "Test"
            'txtStormSewer.Text = "Test"
            'txtSteam.Text = "Test"
            'txtPortableWater.Text = "Test"
            'txtChilledWater.Text = "Test"
            'txtNaturalGas.Text = "Test"
            'txtReclaimedWaterSource.Text = "Test"

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
        End If
    End Function
    Public Function Getpotentialimpacts()
        txtLanduseimpactsnote.Text = GetRecordsForEnviImpacts(varId, 1)
        txtSitegeologyimpactsnote.Text = GetRecordsForEnviImpacts(varId, 2)
        txtHzordousmaterialimpactsnote.Text = GetRecordsForEnviImpacts(varId, 3)
        txtCulturalhistoricimpactnote.Text = GetRecordsForEnviImpacts(varId, 4)
        txtNaturalresourcesimpactnote.Text = GetRecordsForEnviImpacts(varId, 5)
        txtPotentialImpactsnote.Text = GetRecordsForEnviImpacts(varId, 6)
        txtStormwaterandcoastalzoneimpactnote.Text = GetRecordsForEnviImpacts(varId, 7)
        txtTrafficimpactnote.Text = GetRecordsForEnviImpacts(varId, 8)


        ddlLandusepotentialimpact.SelectedIndex = GetDropdownReocrdsForEnviImpacts(varId, 1)
        ddlSitegeologyandsoilsuitability.SelectedIndex = GetDropdownReocrdsForEnviImpacts(varId, 2)
        ddlHazordousmaterial.SelectedIndex = GetDropdownReocrdsForEnviImpacts(varId, 3)
        ddlCulturalandhistorical.SelectedIndex = GetDropdownReocrdsForEnviImpacts(varId, 4)
        ddlnaturalresources.SelectedIndex = GetDropdownReocrdsForEnviImpacts(varId, 5)
        ddlUtilities.SelectedIndex = GetDropdownReocrdsForEnviImpacts(varId, 6)
        ddlstormwaterandcoastal.SelectedIndex = GetDropdownReocrdsForEnviImpacts(varId, 7)
        ddlTraffic.SelectedIndex = GetDropdownReocrdsForEnviImpacts(varId, 8)
    End Function
    Public Function GetCheckboxesrecord()
        Dim permit_1 As String = GetProjectEnviroPermitChkboxesRecords(1)
        If permit_1 = "1" Then
            chkAirquality.Checked = True
        End If
        Dim permit_2 As String = GetProjectEnviroPermitChkboxesRecords(2)
        If permit_2 = "2" Then
            chkJointpermit.Checked = True
        End If
        Dim permit_3 As String = GetProjectEnviroPermitChkboxesRecords(3)
        If permit_3 = "3" Then
            chkErosionpermit.Checked = True
        End If
        Dim permit_4 As String = GetProjectEnviroPermitChkboxesRecords(4)
        If permit_4 = "4" Then
            chkAgriculturalPermit.Checked = True
        End If
        Dim permit_5 As String = GetProjectEnviroPermitChkboxesRecords(5)
        If permit_5 = "5" Then
            chkNpdespermit.Checked = True
        End If
        Dim permit_6 As String = GetProjectEnviroPermitChkboxesRecords(6)
        If permit_6 = "6" Then
            chkUsacewetlandpermit.Checked = True
        End If
        Dim permit_7 As String = GetProjectEnviroPermitChkboxesRecords(7)
        If permit_7 = "7" Then
            chkwaterandsewagepermit.Checked = True
        End If
        Dim permit_8 As String = GetProjectEnviroPermitChkboxesRecords(8)
        If permit_8 = "8" Then
            chkfueltankauthzn.Checked = True
        End If
        Dim permit_9 As String = GetProjectEnviroPermitChkboxesRecords(9)
        If permit_9 = "9" Then
            chkleadabtementpermit.Checked = True
        End If
        Dim permit_10 As String = GetProjectEnviroPermitChkboxesRecords(10)
        If permit_10 = "10" Then
            chkAsbestospermit.Checked = True
        End If
        Dim permit_11 As String = GetProjectEnviroPermitChkboxesRecords(11)
        If permit_11 = "11" Then
            chkCoastalzonapproval.Checked = True
        End If
        Dim permit_12 As String = GetProjectEnviroPermitChkboxesRecords(12)
        If permit_12 = "12" Then
            chkapeciesactpermit.Checked = True
        End If
    End Function
    Public Function GetSchedule()
        'propsectus
        Dim schedule1_propsectus As String = GetProspectusScheduleforEnvironmental(varId, 36)
        If schedule1_propsectus = "" Then
        Else
            txtEnvcontractawardproswpectus.Text = Convert.ToDateTime(schedule1_propsectus)
        End If

        Dim schedule2_propsectus As String = GetProspectusScheduleforEnvironmental(varId, 37)
        If schedule2_propsectus = "" Then
        Else
            txtDuedilligeneceprospectus.Text = Convert.ToDateTime(schedule2_propsectus)
        End If
        Dim schedule3_propsectus As String = GetProspectusScheduleforEnvironmental(varId, 38)
        'If schedule3_propsectus = "" Then
        'Else
        '    txtNepadocumentationmilestonescheduleprospectus.Text = Convert.ToDateTime(schedule3_propsectus)
        'End If
        Dim schedule4_propsectus As String = GetProspectusScheduleforEnvironmental(varId, 39)
        If schedule4_propsectus = "" Then
        Else
            txtAnticipatednepadocumentationkickoffprospectus.Text = Convert.ToDateTime(schedule4_propsectus)
        End If
        Dim schedule5_propsectus As String = GetProspectusScheduleforEnvironmental(varId, 40)
        If schedule5_propsectus = "" Then
        Else
            txtAnticipateddraftnepadocumentdateprospectus.Text = Convert.ToDateTime(schedule5_propsectus)
        End If
        Dim schedule6_propsectus As String = GetProspectusScheduleforEnvironmental(varId, 41)
        If schedule6_propsectus = "" Then
        Else
            txtAnticipatedfinalnepadocumentprospectus.Text = Convert.ToDateTime(schedule6_propsectus)
        End If
        Dim schedule7_propsectus As String = GetProspectusScheduleforEnvironmental(varId, 42)
        If schedule7_propsectus = "" Then
        Else
            txtAnticipatednepadecisionfonsiprospectus.Text = Convert.ToDateTime(schedule7_propsectus)
        End If
        'orignal
        Dim schedule1_orignal As String = GetOriginalScheduleforEnvironmental(varId, 36)
        If schedule1_orignal = "" Then
        Else
            txtEnvcontractawardoriginal.Text = Convert.ToDateTime(schedule1_orignal)
        End If

        Dim schedule2_orignal As String = GetOriginalScheduleforEnvironmental(varId, 37)
        If schedule2_orignal = "" Then
        Else
            txtDuedilligeneceoriginal.Text = Convert.ToDateTime(schedule2_orignal)
        End If
        Dim schedule3_orignal As String = GetOriginalScheduleforEnvironmental(varId, 38)
        'If schedule3_orignal = "" Then
        'Else
        '    txtNepadocumentationmilestonescheduleoriginal.Text = Convert.ToDateTime(schedule3_orignal)
        'End If
        Dim schedule4_orignal As String = GetOriginalScheduleforEnvironmental(varId, 39)
        If schedule4_orignal = "" Then
        Else
            txtAnticipatednepadocumentationkickofforiginal.Text = Convert.ToDateTime(schedule4_orignal)
        End If
        Dim schedule5_orignal As String = GetOriginalScheduleforEnvironmental(varId, 40)
        If schedule5_orignal = "" Then
        Else
            txtAnticipateddraftnepadocumentdateoriginal.Text = Convert.ToDateTime(schedule5_orignal)
        End If
        Dim schedule6_orignal As String = GetOriginalScheduleforEnvironmental(varId, 41)
        If schedule6_orignal = "" Then
        Else
            txtAnticipatedfinalnepadocumentoriginal.Text = Convert.ToDateTime(schedule6_orignal)
        End If
        Dim schedule7_orignal As String = GetOriginalScheduleforEnvironmental(varId, 42)
        If schedule7_orignal = "" Then
        Else
            txtAnticipatednepadecisionfonsioriginal.Text = Convert.ToDateTime(schedule7_orignal)
        End If
        'revised
        Dim schedule1_revised As String = GetRevisedScheduleforEnvironmental(varId, 36)
        If schedule1_revised = "" Then
        Else
            txtEnvcontractawardrevised.Text = Convert.ToDateTime(schedule1_revised)
        End If

        Dim schedule2_revised As String = GetRevisedScheduleforEnvironmental(varId, 37)
        If schedule2_revised = "" Then
        Else
            txtDuedilligenecerevised.Text = Convert.ToDateTime(schedule2_revised)
        End If
        Dim schedule3_revised As String = GetRevisedScheduleforEnvironmental(varId, 38)
        'If schedule3_revised = "" Then
        'Else
        '    txtNepadocumentationmilestoneschedulerevised.Text = Convert.ToDateTime(schedule3_revised)
        'End If
        Dim schedule4_revised As String = GetRevisedScheduleforEnvironmental(varId, 39)
        If schedule4_revised = "" Then
        Else
            txtAnticipatednepadocumentationkickoffrevised.Text = Convert.ToDateTime(schedule4_revised)
        End If
        Dim schedule5_revised As String = GetRevisedScheduleforEnvironmental(varId, 40)
        If schedule5_revised = "" Then
        Else
            txtAnticipateddraftnepadocumentdaterevised.Text = Convert.ToDateTime(schedule5_revised)
        End If
        Dim schedule6_revised As String = GetRevisedScheduleforEnvironmental(varId, 41)
        If schedule6_revised = "" Then
        Else
            txtAnticipatedfinalnepadocumentrevised.Text = Convert.ToDateTime(schedule6_revised)
        End If
        Dim schedule7_revised As String = GetRevisedScheduleforEnvironmental(varId, 42)
        If schedule7_revised = "" Then
        Else
            txtAnticipatednepadecisionfonsirevised.Text = Convert.ToDateTime(schedule7_revised)
        End If
        'actual
        Dim schedule1_actual As String = GetActualScheduleforEnvironmental(varId, 36)
        If schedule1_actual = "" Then
        Else
            txtEnvcontractawardactual.Text = Convert.ToDateTime(schedule1_actual)
        End If

        Dim schedule2_actual As String = GetActualScheduleforEnvironmental(varId, 37)
        If schedule2_actual = "" Then
        Else
            txtDuedilligeneceactual.Text = Convert.ToDateTime(schedule2_actual)
        End If
        Dim schedule3_actual As String = GetActualScheduleforEnvironmental(varId, 38)
        'If schedule3_actual = "" Then
        'Else
        '    txtNepadocumentationmilestonescheduleactual.Text = Convert.ToDateTime(schedule3_actual)
        'End If
        Dim schedule4_actual As String = GetActualScheduleforEnvironmental(varId, 39)
        If schedule4_actual = "" Then
        Else
            txtAnticipatednepadocumentationkickoffactual.Text = Convert.ToDateTime(schedule4_actual)
        End If
        Dim schedule5_actual As String = GetActualScheduleforEnvironmental(varId, 40)
        If schedule5_actual = "" Then
        Else
            txtAnticipateddraftnepadocumentdateactual.Text = Convert.ToDateTime(schedule5_actual)
        End If
        Dim schedule6_actual As String = GetActualScheduleforEnvironmental(varId, 41)
        If schedule6_actual = "" Then
        Else
            txtAnticipatedfinalnepadocumentactual.Text = Convert.ToDateTime(schedule6_actual)
        End If
        Dim schedule7_actual As String = GetActualScheduleforEnvironmental(varId, 42)
        If schedule7_actual = "" Then
        Else
            txtAnticipatednepadecisionfonsiactual.Text = Convert.ToDateTime(schedule7_actual)
        End If
    End Function
    Private Function ConvertToInteger(ByRef value As String) As Integer
        If String.IsNullOrEmpty(value) Then
            value = "0"
        End If
        Return Convert.ToInt32(value)
    End Function
    Public Function Getutilitiesrecords(strProjId As String, Survey_pk As String) As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim strResult As String
        Dim enviropk As String
        Using conn As New SqlConnection(connStr)
            Dim com2 As New SqlCommand With {
                                    .Connection = conn,
                                    .CommandType = CommandType.StoredProcedure,
                                    .CommandText = "GetProjectEnviroPK"
                    }
            com2.Parameters.Add(New SqlParameter("@Surveyfk", 71))
            com2.Parameters.Add(New SqlParameter("@projectfk", varId))
            conn.Open()
            Using sdr As SqlDataReader = com2.ExecuteReader()
                sdr.Read()
                If sdr.HasRows Then
                    enviropk = sdr("EnviroSurvey_pk").ToString()
                    conn.Close()
                    Dim command As New SqlCommand
                    command.Connection = conn
                    command.CommandText = "GetUtilitiesrecords"
                    command.CommandType = CommandType.StoredProcedure
                    command.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = enviropk
                    command.Parameters.AddWithValue("@utility", SqlDbType.Int).Value = Survey_pk
                    command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
                    command.Parameters.Add("@Result_utlchck", SqlDbType.NVarChar, 200)
                    command.Parameters("@Result").Direction = ParameterDirection.Output
                    command.Parameters("@Result_utlchck").Direction = ParameterDirection.Output
                    conn.Open()
                    command.ExecuteNonQuery()
                    conn.Close()
                    strResult = command.Parameters("@Result").Value.ToString
                    Return strResult
                End If

            End Using
        End Using
    End Function
    Public Function Getutilitiescheckedornot(strProjId As String, Survey_pk As String) As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim strResult As String
        Dim enviropk As String
        Using conn As New SqlConnection(connStr)
            Dim com2 As New SqlCommand With {
                                    .Connection = conn,
                                    .CommandType = CommandType.StoredProcedure,
                                    .CommandText = "GetProjectEnviroPK"
                    }
            com2.Parameters.Add(New SqlParameter("@Surveyfk", 71))
            com2.Parameters.Add(New SqlParameter("@projectfk", varId))
            conn.Open()
            Using sdr As SqlDataReader = com2.ExecuteReader()
                sdr.Read()
                If sdr.HasRows Then
                    enviropk = sdr("EnviroSurvey_pk").ToString()
                    conn.Close()
                    Dim command As New SqlCommand
                    command.Connection = conn
                    command.CommandText = "GetUtilitiesrecords"
                    command.CommandType = CommandType.StoredProcedure
                    command.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = enviropk
                    command.Parameters.AddWithValue("@utility", SqlDbType.Int).Value = Survey_pk
                    command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
                    command.Parameters.Add("@Result_utlchck", SqlDbType.NVarChar, 200)
                    command.Parameters("@Result").Direction = ParameterDirection.Output
                    command.Parameters("@Result_utlchck").Direction = ParameterDirection.Output
                    conn.Open()
                    command.ExecuteNonQuery()
                    conn.Close()
                    strResult = command.Parameters("@Result_utlchck").Value.ToString
                    If strResult = "" Then
                        Return strResult = "0"
                    Else
                        Return strResult
                    End If

                End If
            End Using
        End Using
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

    Protected Sub btnSave_Click(sender As Object, e As EventArgs)
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim struser As String = lblUserNm.Text

        Using conn As New SqlConnection(ConnStr)

            ' clean up temporary files
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = " delete From tempprojectEnvironmentalNote Where project_fk =" + varId + " and createdBy = '" + struser.Trim() + "'"
            command.CommandType = CommandType.Text
            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            Dim command2 As New SqlCommand
            command2.Connection = conn
            command2.CommandText = " delete From tempProjectEnvironmentalPermit Where project_fk =" + varId + " and createdBy = '" + struser.Trim() + "'"
            command2.CommandType = CommandType.Text
            conn.Open()
            command2.ExecuteNonQuery()
            conn.Close()
            Dim command3 As New SqlCommand
            command3.Connection = conn
            command3.CommandText = "Delete  FROM tempSchedule where project_fk=" + varId + " and mileStone_FK >= 36 and mileStone_FK <=42 and createdBy = '" + struser.Trim() + "'"
            command3.CommandType = CommandType.Text
            conn.Open()
            command3.ExecuteNonQuery()
            conn.Close()
            Dim command4 As New SqlCommand
            command4.Connection = conn
            command4.CommandText = " delete from tempEnvironmentalStrategyAnticipatedTimeLine where project_fk=" + varId + " and createdBy = '" + struser.Trim() + "'"
            command4.CommandType = CommandType.Text
            conn.Open()
            command4.ExecuteNonQuery()
            conn.Close()

        End Using
        btnSubmitInsertOperationforEnviImpactsTemp(txtLanduseimpactsnote.Text, ddlLandusepotentialimpact.SelectedValue, hdnlanduse.Value, 0)
        btnSubmitInsertOperationforEnviImpactsTemp(txtSitegeologyimpactsnote.Text, ddlSitegeologyandsoilsuitability.SelectedValue, hdnsitegeologyandsoilsuitability.Value, 0)
        btnSubmitInsertOperationforEnviImpactsTemp(txtHzordousmaterialimpactsnote.Text, ddlHazordousmaterial.SelectedValue, hdnHazordousmaterial.Value, 0)
        btnSubmitInsertOperationforEnviImpactsTemp(txtCulturalhistoricimpactnote.Text, ddlCulturalandhistorical.SelectedValue, hdnCultulturalandhistorical.Value, 0)
        btnSubmitInsertOperationforEnviImpactsTemp(txtNaturalresourcesimpactnote.Text, ddlnaturalresources.SelectedValue, hdnNaturalResources.Value, 0)
        btnSubmitInsertOperationforEnviImpactsTemp(txtPotentialImpactsnote.Text, ddlUtilities.SelectedValue, hdnUtilities.Value, 0)
        btnSubmitInsertOperationforEnviImpactsTemp(txtStormwaterandcoastalzoneimpactnote.Text, ddlstormwaterandcoastal.SelectedValue, hdnStormwaterandcoastal.Value, 0)
        btnSubmitInsertOperationforEnviImpactsTemp(txtTrafficimpactnote.Text, ddlTraffic.SelectedValue, hdnTraffic.Value, 0)
        InsertdataTemp()
        If chkoverallenvnstrategyandtimelingfirstoption.Checked Then
            btnSubmitInsertEnvStrategyAnticipatedtimelineTemp(txtareaEnvironmentaldataneedrequests.Text, txtareaenvnprogramstrategy.Text, 1, ddlEnvncontractreuired.SelectedValue)
        End If
        If chkoverallenvnstrategyandtimelingsecondoption.Checked Then
            btnSubmitInsertEnvStrategyAnticipatedtimelineTemp(txtareaEnvironmentaldataneedrequests.Text, txtareaenvnprogramstrategy.Text, 0, ddlEnvncontractreuired.SelectedValue)
        End If
        btnSubmitInsertProjectNepaSelection(ddlAnticpatednepdocn.SelectedValue)


        ' save data stored in temp tables to permanent table
        SaveEnvironmentalNote_EnvironmentalPermit_Schedule_AnticipatedTimeLine()

        ' send notification to the project manager 
        ' SendNotificationToProjectManager()

        ScriptManager.RegisterClientScriptBlock(Me, [GetType](), "Message", "SaveAlertMsg('Records Added Successfully.');", True)
        Dim pageUrl As String = "QuestionnaireForInitialResponseList.aspx"
        Response.Redirect(pageUrl)
    End Sub


    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)

        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim struser As String = lblUserNm.Text

        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = " delete From tempprojectEnvironmentalNote Where project_fk =" + varId + " and createdBy = '" + struser.Trim() + "'"
            command.CommandType = CommandType.Text
            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            Dim command2 As New SqlCommand
            command2.Connection = conn
            command2.CommandText = " delete From tempProjectEnvironmentalPermit Where project_fk =" + varId + " and createdBy = '" + struser.Trim() + "'"
            command2.CommandType = CommandType.Text
            conn.Open()
            command2.ExecuteNonQuery()
            conn.Close()
            Dim command3 As New SqlCommand
            command3.Connection = conn
            command3.CommandText = "Delete  FROM tempSchedule where project_fk=" + varId + " and mileStone_FK >= 36 and mileStone_FK <=42 and createdBy = '" + struser.Trim() + "'"
            '   command3.CommandText = "delete  FROM tempSchedule where project_fk=" + varId + " and mileStone_FK >= 36 and mileStone_FK <=42"
            command3.CommandType = CommandType.Text
            conn.Open()
            command3.ExecuteNonQuery()
            conn.Close()
            Dim command4 As New SqlCommand
            command4.Connection = conn
            command4.CommandText = " delete from tempEnvironmentalStrategyAnticipatedTimeLine where project_fk=" + varId + " and createdBy = '" + struser.Trim() + "'"
            command4.CommandType = CommandType.Text
            conn.Open()
            command4.ExecuteNonQuery()
            conn.Close()
        End Using
        ' btnSubmitInsertOperationforEnviImpacts(note, ddlimpactsselection, hdnissuetype)
        btnSubmitInsertOperationforEnviImpactsTemp(txtLanduseimpactsnote.Text, ddlLandusepotentialimpact.SelectedValue, hdnlanduse.Value, 1)
        btnSubmitInsertOperationforEnviImpactsTemp(txtSitegeologyimpactsnote.Text, ddlSitegeologyandsoilsuitability.SelectedValue, hdnsitegeologyandsoilsuitability.Value, 1)
        btnSubmitInsertOperationforEnviImpactsTemp(txtHzordousmaterialimpactsnote.Text, ddlHazordousmaterial.SelectedValue, hdnHazordousmaterial.Value, 1)
        btnSubmitInsertOperationforEnviImpactsTemp(txtCulturalhistoricimpactnote.Text, ddlCulturalandhistorical.SelectedValue, hdnCultulturalandhistorical.Value, 1)
        btnSubmitInsertOperationforEnviImpactsTemp(txtNaturalresourcesimpactnote.Text, ddlnaturalresources.SelectedValue, hdnNaturalResources.Value, 1)
        btnSubmitInsertOperationforEnviImpactsTemp(txtPotentialImpactsnote.Text, ddlUtilities.SelectedValue, hdnUtilities.Value, 1)
        btnSubmitInsertOperationforEnviImpactsTemp(txtStormwaterandcoastalzoneimpactnote.Text, ddlstormwaterandcoastal.SelectedValue, hdnStormwaterandcoastal.Value, 1)
        btnSubmitInsertOperationforEnviImpactsTemp(txtTrafficimpactnote.Text, ddlTraffic.SelectedValue, hdnTraffic.Value, 1)
        InsertdataTemp()

        btnSubmitInsertEnvStrategyAnticipatedtimelineTemp(txtareaEnvironmentaldataneedrequests.Text, txtareaenvnprogramstrategy.Text, chkoverallenvnstrategyandtimelingfirstoption.Checked, ddlEnvncontractreuired.SelectedValue)
        btnSubmitInsertProjectNepaSelection(ddlAnticpatednepdocn.SelectedValue)

        ' save data stored in temp tables to permanent table
        SaveEnvironmentalNote_EnvironmentalPermit_Schedule_AnticipatedTimeLine()

        btnSave.Enabled = False
        btnSubmit.Enabled = False

        ' send notification to the project manager 
        SendNotificationToProjectManager()

        Dim pageUrl As String = "QuestionnaireForInitialResponseList.aspx"
        Response.Redirect(pageUrl)
        ScriptManager.RegisterClientScriptBlock(Me, [GetType](), "Message", "SaveAlertMsg('Records Added Successfully.');", True)
    End Sub


    Private Sub SendNotificationToProjectManager()
        Dim strPMPersonnelEmail As String = ""
        Dim strProjectCode As String
        Dim strEnvironmentalProjectFromEmail As String = ConfigurationManager.AppSettings("EnvironmentalProjectFromEmail").ToString

        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim strPMPersonnelId As String = ""
        '       Dim strPersonnelName As String = ""

        'new line
        Dim uname As String = Context.User.Identity.Name
        Dim strLoggedUser As String = uname.Substring(uname.LastIndexOf("\") + 1)

        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "GetEnvironmentalPMPersonnelID"
            command.CommandType = CommandType.StoredProcedure
            '            command.Parameters.AddWithValue("@EnvStaff_personnel_pk", SqlDbType.Int).Value = strPersonnelId
            command.Parameters.AddWithValue("@EnvProject_PK", SqlDbType.Int).Value = strProjNum

            command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            command.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            strPMPersonnelId = command.Parameters("@Result").Value.ToString
        End Using

        If Not String.IsNullOrEmpty(strPMPersonnelId) Then
            Using conn As New SqlConnection(ConnStr)
                Dim command As New SqlCommand
                command.Connection = conn
                command.CommandText = "GetPersonnelEmail"
                command.CommandType = CommandType.StoredProcedure
                command.Parameters.AddWithValue("@personnel_pk", SqlDbType.Int).Value = strPMPersonnelId
                command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
                command.Parameters("@Result").Direction = ParameterDirection.Output

                conn.Open()
                command.ExecuteNonQuery()
                conn.Close()

                strPMPersonnelEmail = command.Parameters("@Result").Value.ToString
            End Using


            Using conn As New SqlConnection(ConnStr)
                Dim command As New SqlCommand
                command.Connection = conn
                command.CommandText = "GetprojectCode"
                command.CommandType = CommandType.StoredProcedure
                command.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = strProjNum
                command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
                command.Parameters("@Result").Direction = ParameterDirection.Output

                conn.Open()
                command.ExecuteNonQuery()
                conn.Close()

                strProjectCode = command.Parameters("@Result").Value.ToString
            End Using

            If ConfigurationManager.AppSettings("EnvironmentMode").ToString = "DEV" Then
                strPMPersonnelEmail = ConfigurationManager.AppSettings("EnvInitialResponseUpdatesPMRecipient").ToString
            End If


            If Not String.IsNullOrEmpty(strPMPersonnelEmail) Then

                Dim sb As New StringBuilder()
                'sb.Append(Convert.ToString("<p>Comments on project</p>"))
                sb.Append("<table>")
                sb.Append((Convert.ToString("<tr><td><br>An environmental response has been completed and submitted for this project.") + "</td></tr>"))
                sb.Append((Convert.ToString("<tr><td><br>To view the environmental response, click on this link: " + ConfigurationManager.AppSettings("EnviInitialResponseFormURL").ToString + strProjNum.ToString() + "</td></tr>")))

                Dim mm As New MailMessage()
                mm.IsBodyHtml = True
                mm.From = New MailAddress(strEnvironmentalProjectFromEmail)
                mm.[To].Add(strPMPersonnelEmail)
                mm.Subject = "CFMIS Environmental Response for Project # " + strProjectCode

                sb.Append("</table>")
                mm.Body = sb.ToString()
                Application("strIP") = "smtp.va.gov"
                Dim smtp As New SmtpClient(Application("strIP").ToString())
                smtp.Send(mm)
                mm.Dispose()
            End If
        End If

        '        End If
    End Sub


    Public Function btnSubmitInsertProjectNepaSelection(nepaselection) As Object
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "AddUpdateNEPASelection"
            }
            com.Parameters.AddWithValue("@project_fk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@NEPA_fk", SqlDbType.VarChar).Value = nepaselection
            com.Parameters.AddWithValue("@UserName", SqlDbType.VarChar).Value = struser
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Function
    Public Function btnSubmitInsertEnvStrategyAnticipatedtimeline(datarequest, programstrategy, programdivisionrequest, contractrequired) As Object
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "AddEnvAnticpatedTimeline"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@DataNeedRequests", SqlDbType.VarChar).Value = datarequest
            com.Parameters.AddWithValue("@ProgramStrategy", SqlDbType.VarChar).Value = programstrategy
            com.Parameters.AddWithValue("@DivisionRequests", SqlDbType.Bit).Value = programdivisionrequest
            com.Parameters.AddWithValue("@ContractRequired", SqlDbType.Bit).Value = contractrequired
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Function


    Public Function btnSubmitInsertEnvStrategyAnticipatedtimelineTemp(datarequest, programstrategy, programdivisionrequest, contractrequired) As Object
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "AddEnvAnticpatedTimelineTemp"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@DataNeedRequests", SqlDbType.VarChar).Value = datarequest
            com.Parameters.AddWithValue("@ProgramStrategy", SqlDbType.VarChar).Value = programstrategy
            com.Parameters.AddWithValue("@DivisionRequests", SqlDbType.Bit).Value = programdivisionrequest
            com.Parameters.AddWithValue("@ContractRequired", SqlDbType.Bit).Value = contractrequired
            com.Parameters.AddWithValue("@User", SqlDbType.VarChar).Value = struser
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Function


    Private Function Insertdata()
        If chkAirquality.Checked Then '1
            btnSubmitInsertOperationforCheckboxes(1)
        End If
        If chkJointpermit.Checked Then '2
            btnSubmitInsertOperationforCheckboxes(2)
        End If
        If chkErosionpermit.Checked Then '3
            btnSubmitInsertOperationforCheckboxes(3)
        End If
        If chkAgriculturalPermit.Checked Then '4
            btnSubmitInsertOperationforCheckboxes(4)
        End If
        If chkNpdespermit.Checked Then '5
            btnSubmitInsertOperationforCheckboxes(5)
        End If
        If chkUsacewetlandpermit.Checked Then '6
            btnSubmitInsertOperationforCheckboxes(6)
        End If
        If chkwaterandsewagepermit.Checked Then '7
            btnSubmitInsertOperationforCheckboxes(7)
        End If
        If chkfueltankauthzn.Checked Then '8
            btnSubmitInsertOperationforCheckboxes(8)
        End If
        If chkleadabtementpermit.Checked Then '9
            btnSubmitInsertOperationforCheckboxes(9)
        End If
        If chkAsbestospermit.Checked Then '10
            btnSubmitInsertOperationforCheckboxes(10)
        End If
        If chkCoastalzonapproval.Checked Then '11
            btnSubmitInsertOperationforCheckboxes(11)
        End If
        If chkapeciesactpermit.Checked Then '12
            btnSubmitInsertOperationforCheckboxes(12)
        End If
        'InsertScheduleforEnvironmental(prospectus, original, revised, actual, milestone)
        InsertScheduleforEnvironmental(txtEnvcontractawardproswpectus.Text, txtEnvcontractawardoriginal.Text, txtEnvcontractawardrevised.Text, txtEnvcontractawardactual.Text, 36)
        InsertScheduleforEnvironmental(txtDuedilligeneceprospectus.Text, txtDuedilligeneceoriginal.Text, txtDuedilligenecerevised.Text, txtDuedilligeneceactual.Text, 37)
        ' InsertScheduleforEnvironmental(txtNepadocumentationmilestonescheduleprospectus.Text, txtNepadocumentationmilestonescheduleoriginal.Text, txtNepadocumentationmilestoneschedulerevised.Text, txtNepadocumentationmilestonescheduleactual.Text, 38)
        InsertScheduleforEnvironmental(txtAnticipatednepadocumentationkickoffprospectus.Text, txtAnticipatednepadocumentationkickofforiginal.Text, txtAnticipatednepadocumentationkickoffrevised.Text, txtAnticipatednepadocumentationkickoffactual.Text, 39)
        InsertScheduleforEnvironmental(txtAnticipateddraftnepadocumentdateprospectus.Text, txtAnticipateddraftnepadocumentdateoriginal.Text, txtAnticipateddraftnepadocumentdaterevised.Text, txtAnticipateddraftnepadocumentdateactual.Text, 40)
        InsertScheduleforEnvironmental(txtAnticipatedfinalnepadocumentprospectus.Text, txtAnticipatedfinalnepadocumentoriginal.Text, txtAnticipatedfinalnepadocumentrevised.Text, txtAnticipatedfinalnepadocumentactual.Text, 41)
        InsertScheduleforEnvironmental(txtAnticipatednepadecisionfonsiprospectus.Text, txtAnticipatednepadecisionfonsioriginal.Text, txtAnticipatednepadecisionfonsirevised.Text, txtAnticipatednepadecisionfonsiactual.Text, 42)

    End Function


    Private Function InsertdataTemp()
        If chkAirquality.Checked Then '1
            btnSubmitInsertOperationforCheckboxesTemp(1)
        End If
        If chkJointpermit.Checked Then '2
            btnSubmitInsertOperationforCheckboxesTemp(2)
        End If
        If chkErosionpermit.Checked Then '3
            btnSubmitInsertOperationforCheckboxesTemp(3)
        End If
        If chkAgriculturalPermit.Checked Then '4
            btnSubmitInsertOperationforCheckboxesTemp(4)
        End If
        If chkNpdespermit.Checked Then '5
            btnSubmitInsertOperationforCheckboxesTemp(5)
        End If
        If chkUsacewetlandpermit.Checked Then '6
            btnSubmitInsertOperationforCheckboxesTemp(6)
        End If
        If chkwaterandsewagepermit.Checked Then '7
            btnSubmitInsertOperationforCheckboxesTemp(7)
        End If
        If chkfueltankauthzn.Checked Then '8
            btnSubmitInsertOperationforCheckboxesTemp(8)
        End If
        If chkleadabtementpermit.Checked Then '9
            btnSubmitInsertOperationforCheckboxesTemp(9)
        End If
        If chkAsbestospermit.Checked Then '10
            btnSubmitInsertOperationforCheckboxesTemp(10)
        End If
        If chkCoastalzonapproval.Checked Then '11
            btnSubmitInsertOperationforCheckboxesTemp(11)
        End If
        If chkapeciesactpermit.Checked Then '12
            btnSubmitInsertOperationforCheckboxesTemp(12)
        End If
        'InsertScheduleforEnvironmental(prospectus, original, revised, actual, milestone)
        InsertScheduleforEnvironmentalTemp(txtEnvcontractawardproswpectus.Text, txtEnvcontractawardoriginal.Text, txtEnvcontractawardrevised.Text, txtEnvcontractawardactual.Text, 36)
        InsertScheduleforEnvironmentalTemp(txtDuedilligeneceprospectus.Text, txtDuedilligeneceoriginal.Text, txtDuedilligenecerevised.Text, txtDuedilligeneceactual.Text, 37)
        InsertScheduleforEnvironmentalTemp(txtAnticipatednepadocumentationkickoffprospectus.Text, txtAnticipatednepadocumentationkickofforiginal.Text, txtAnticipatednepadocumentationkickoffrevised.Text, txtAnticipatednepadocumentationkickoffactual.Text, 39)
        InsertScheduleforEnvironmentalTemp(txtAnticipateddraftnepadocumentdateprospectus.Text, txtAnticipateddraftnepadocumentdateoriginal.Text, txtAnticipateddraftnepadocumentdaterevised.Text, txtAnticipateddraftnepadocumentdateactual.Text, 40)
        InsertScheduleforEnvironmentalTemp(txtAnticipatedfinalnepadocumentprospectus.Text, txtAnticipatedfinalnepadocumentoriginal.Text, txtAnticipatedfinalnepadocumentrevised.Text, txtAnticipatedfinalnepadocumentactual.Text, 41)
        InsertScheduleforEnvironmentalTemp(txtAnticipatednepadecisionfonsiprospectus.Text, txtAnticipatednepadecisionfonsioriginal.Text, txtAnticipatednepadecisionfonsirevised.Text, txtAnticipatednepadecisionfonsiactual.Text, 42)

    End Function



    Public Function btnSubmitInsertOperationforEnviImpacts(note, ddlimpactsselection, hdnissuetype, issubmitted) As Object
        'This is when Submit is Clicked.
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "AddProjectEnvironmentalNote"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@note", SqlDbType.VarChar).Value = note 'textarea
            com.Parameters.AddWithValue("@impact_pk", SqlDbType.Int).Value = ddlimpactsselection 'ddlvalue
            com.Parameters.AddWithValue("@issueType_pk", SqlDbType.Int).Value = hdnissuetype
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            com.Parameters.Add("@issubmitted", SqlDbType.VarChar).Value = issubmitted
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Function

    Public Function btnSubmitInsertOperationforEnviImpactsTemp(note, ddlimpactsselection, hdnissuetype, issubmitted) As Object
        'This is when Submit is Clicked.
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "AddProjectEnvironmentalNoteTemp"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@note", SqlDbType.VarChar).Value = note 'textarea
            com.Parameters.AddWithValue("@impact_pk", SqlDbType.Int).Value = ddlimpactsselection 'ddlvalue
            com.Parameters.AddWithValue("@issueType_pk", SqlDbType.Int).Value = hdnissuetype
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            com.Parameters.Add("@issubmitted", SqlDbType.VarChar).Value = issubmitted
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Function

    Public Function btnSubmitInsertOperationforCheckboxes(permitpk) As Object
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "AddCheckboxesValuesforPermits"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@permit_pk", SqlDbType.VarChar).Value = permitpk 'textarea
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Function

    Public Function btnSubmitInsertOperationforCheckboxesTemp(permitpk) As Object
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "AddCheckboxesValuesforPermitsTemp"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@permit_pk", SqlDbType.VarChar).Value = permitpk 'textarea
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Function


    Protected Sub UploadNepaassistreprot(sender As Object, e As EventArgs)
        Dim filename As String = Path.GetFileName(FileUpload1.PostedFile.FileName)
        Dim contentType As String = FileUpload1.PostedFile.ContentType
        Using fs As Stream = FileUpload1.PostedFile.InputStream
            Using br As New BinaryReader(fs)
                Dim bytes As Byte() = br.ReadBytes(CType(fs.Length, Integer))
                Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
                Using con As New SqlConnection(connStr)
                    Dim query As String = "INSERT INTO cfmis_doc VALUES (@docName, @docType,@Description, @createdBy,@createdDate,@doc,@ProjectID,@docSize,@envionmentDoc,@docTypeNamePK)"
                    Using cmd As New SqlCommand(query)
                        cmd.Connection = con
                        cmd.Parameters.Add("@docName", SqlDbType.VarChar).Value = filename
                        cmd.Parameters.Add("@docType", SqlDbType.VarChar).Value = contentType
                        cmd.Parameters.Add("@Description", SqlDbType.VarChar).Value = ""
                        cmd.Parameters.Add("@createdBy", SqlDbType.VarChar).Value = lblUserNm.Text
                        cmd.Parameters.Add("@createdDate", SqlDbType.VarChar).Value = ""
                        cmd.Parameters.Add("@doc", SqlDbType.VarBinary).Value = bytes
                        cmd.Parameters.Add("@ProjectID", SqlDbType.Int).Value = varId
                        cmd.Parameters.Add("@docSize", SqlDbType.Float).Value = DBNull.Value
                        cmd.Parameters.Add("@envionmentDoc", SqlDbType.Bit).Value = 1
                        cmd.Parameters.Add("@docTypeNamePK", SqlDbType.Int).Value = 1
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()

                    End Using
                End Using
            End Using
        End Using
        BindGrid()
        lblMessage.Text = "File uploaded successfully."
    End Sub
    Protected Sub UploadIpac(sender As Object, e As EventArgs)
        Dim filename As String = Path.GetFileName(FileUpload2.PostedFile.FileName)
        Dim contentType As String = FileUpload2.PostedFile.ContentType
        Using fs As Stream = FileUpload2.PostedFile.InputStream
            Using br As New BinaryReader(fs)
                Dim bytes As Byte() = br.ReadBytes(CType(fs.Length, Integer))
                Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
                Using con As New SqlConnection(connStr)
                    Dim query As String = "INSERT INTO cfmis_doc VALUES (@docName, @docType,@Description, @createdBy,@createdDate,@doc,@ProjectID,@docSize,@envionmentDoc,@docTypeNamePK)"
                    Using cmd As New SqlCommand(query)
                        cmd.Connection = con
                        cmd.Parameters.Add("@docName", SqlDbType.VarChar).Value = filename
                        cmd.Parameters.Add("@docType", SqlDbType.VarChar).Value = contentType
                        cmd.Parameters.Add("@Description", SqlDbType.VarChar).Value = ""
                        cmd.Parameters.Add("@createdBy", SqlDbType.VarChar).Value = lblUserNm.Text
                        cmd.Parameters.Add("@createdDate", SqlDbType.VarChar).Value = ""
                        cmd.Parameters.Add("@doc", SqlDbType.VarBinary).Value = bytes
                        cmd.Parameters.Add("@ProjectID", SqlDbType.Int).Value = varId
                        cmd.Parameters.Add("@docSize", SqlDbType.Float).Value = DBNull.Value
                        cmd.Parameters.Add("@envionmentDoc", SqlDbType.Bit).Value = 1
                        cmd.Parameters.Add("@docTypeNamePK", SqlDbType.Int).Value = 2
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()
                    End Using
                End Using
            End Using
        End Using
        BindGrid()
        lblMessageipac.Text = "File uploaded successfully."
    End Sub
    Protected Sub UploadNwimap(sender As Object, e As EventArgs)
        Dim filename As String = Path.GetFileName(FileUpload3.PostedFile.FileName)
        Dim contentType As String = FileUpload3.PostedFile.ContentType
        Using fs As Stream = FileUpload3.PostedFile.InputStream
            Using br As New BinaryReader(fs)
                Dim bytes As Byte() = br.ReadBytes(CType(fs.Length, Integer))
                Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
                Using con As New SqlConnection(connStr)
                    Dim query As String = "INSERT INTO cfmis_doc VALUES (@docName, @docType,@Description, @createdBy,@createdDate,@doc,@ProjectID,@docSize,@envionmentDoc,@docTypeNamePK)"
                    Using cmd As New SqlCommand(query)
                        cmd.Connection = con
                        cmd.Parameters.Add("@docName", SqlDbType.VarChar).Value = filename
                        cmd.Parameters.Add("@docType", SqlDbType.VarChar).Value = contentType
                        cmd.Parameters.Add("@Description", SqlDbType.VarChar).Value = ""
                        cmd.Parameters.Add("@createdBy", SqlDbType.VarChar).Value = lblUserNm.Text
                        cmd.Parameters.Add("@createdDate", SqlDbType.VarChar).Value = ""
                        cmd.Parameters.Add("@doc", SqlDbType.VarBinary).Value = bytes
                        cmd.Parameters.Add("@ProjectID", SqlDbType.Int).Value = varId
                        cmd.Parameters.Add("@docSize", SqlDbType.Float).Value = DBNull.Value
                        cmd.Parameters.Add("@envionmentDoc", SqlDbType.Bit).Value = 1
                        cmd.Parameters.Add("@docTypeNamePK", SqlDbType.Int).Value = 3
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()
                    End Using
                End Using
            End Using
        End Using
        BindGrid()
        lblMessagenwi.Text = "File uploaded successfully."
    End Sub

    Public Function InsertScheduleforEnvironmental(prospectus, original, revised, actual, milestone) As Object 'get note
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "InsertScheduleforEnvironmental"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            If prospectus = "" Then
                com.Parameters.AddWithValue("@prospectus", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@prospectus", SqlDbType.VarChar).Value = prospectus
            End If
            If original = "" Then
                com.Parameters.AddWithValue("@original", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@original", SqlDbType.VarChar).Value = original
            End If
            If revised = "" Then
                com.Parameters.AddWithValue("@revised", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@revised", SqlDbType.VarChar).Value = revised
            End If
            If actual = "" Then
                com.Parameters.AddWithValue("@actual", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@actual", SqlDbType.VarChar).Value = actual
            End If
            com.Parameters.AddWithValue("@milestone_pk", SqlDbType.VarChar).Value = milestone
            com.Parameters.AddWithValue("@mainProject_pk", SqlDbType.VarChar).Value = varId
            com.Parameters.AddWithValue("@IsActualProspectus", SqlDbType.VarChar).Value = ""
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Function


    Public Function InsertScheduleforEnvironmentalTemp(prospectus, original, revised, actual, milestone) As Object 'get note
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "InsertScheduleforEnvironmentalTemp"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            If prospectus = "" Then
                com.Parameters.AddWithValue("@prospectus", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@prospectus", SqlDbType.VarChar).Value = prospectus
            End If
            If original = "" Then
                com.Parameters.AddWithValue("@original", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@original", SqlDbType.VarChar).Value = original
            End If
            If revised = "" Then
                com.Parameters.AddWithValue("@revised", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@revised", SqlDbType.VarChar).Value = revised
            End If
            If actual = "" Then
                com.Parameters.AddWithValue("@actual", SqlDbType.VarChar).Value = DBNull.Value
            Else
                com.Parameters.AddWithValue("@actual", SqlDbType.VarChar).Value = actual
            End If
            com.Parameters.AddWithValue("@milestone_pk", SqlDbType.VarChar).Value = milestone
            com.Parameters.AddWithValue("@mainProject_pk", SqlDbType.VarChar).Value = varId
            com.Parameters.AddWithValue("@IsActualProspectus", SqlDbType.VarChar).Value = ""
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Function


    'pageload
    Public Function GetRecordsForEnviImpacts(varid, issuetype) As Object 'get note
        Dim strResult As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varid = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "GetRecordsForEnviImpacts"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varid
            com.Parameters.AddWithValue("@issuetype", SqlDbType.Int).Value = issuetype
            com.Parameters.Add("@Result", SqlDbType.NVarChar, 1000000)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
            strResult = com.Parameters("@Result").Value.ToString
            Return strResult
        End Using
    End Function
    Public Function GetDropdownReocrdsForEnviImpacts(varid, issuetype) As Object 'get note
        Dim strResult As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varid = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "GetDropdownReocrdsForEnviImpacts"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varid
            com.Parameters.AddWithValue("@issuetype", SqlDbType.Int).Value = issuetype
            com.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
            strResult = com.Parameters("@Result").Value.ToString
            If strResult = "" Then
            Else
                Return strResult
            End If
        End Using
    End Function
    Public Function GetProjectEnviroPermitChkboxesRecords(permitpk) As Object 'get note
        Dim strResult As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "GetProjectEnviroPermitChkboxesRecords"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@permittype", SqlDbType.Int).Value = permitpk
            com.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
            strResult = com.Parameters("@Result").Value.ToString
            If strResult = "" Then
                Return strResult = "0"
            Else
                Return strResult
            End If
        End Using
    End Function
    Public Function GetProspectusScheduleforEnvironmental(projectpk, milestonenumber) As Object 'get note
        Dim strResult As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim dt As New DataTable

            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "GetProspectusSchedule"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@milestone_pk", SqlDbType.Int).Value = milestonenumber

            com.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            strResult = com.Parameters("@Result").Value.ToString
            If strResult = "Jan  1 1900 12:00AM" Then
                conn.Close()
            Else
                Return strResult
                conn.Close()
            End If

        End Using
    End Function
    Public Function GetOriginalScheduleforEnvironmental(projectpk, milestonenumber) As Object 'get note
        Dim strResult As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim dt As New DataTable

            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "GetOriginalSchedule"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@milestone_pk", SqlDbType.Int).Value = milestonenumber

            com.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            strResult = com.Parameters("@Result").Value.ToString
            If strResult = "Jan  1 1900 12:00AM" Then
                conn.Close()
            Else
                Return strResult
                conn.Close()
            End If

        End Using
    End Function
    Public Function GetRevisedScheduleforEnvironmental(projectpk, milestonenumber) As Object 'get note
        Dim strResult As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim dt As New DataTable

            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "GetRevisedSchedule"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@milestone_pk", SqlDbType.Int).Value = milestonenumber

            com.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            strResult = com.Parameters("@Result").Value.ToString
            If strResult = "Jan  1 1900 12:00AM" Then
                conn.Close()
            Else
                Return strResult
                conn.Close()
            End If

        End Using
    End Function
    Public Function GetActualScheduleforEnvironmental(projectpk, milestonenumber) As Object 'get note
        Dim strResult As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim dt As New DataTable

            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "GetActualSchedule"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@milestone_pk", SqlDbType.Int).Value = milestonenumber

            com.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            strResult = com.Parameters("@Result").Value.ToString
            If strResult = "Jan  1 1900 12:00AM" Then
                conn.Close()
            Else
                Return strResult
                conn.Close()
            End If

        End Using
    End Function

    Protected Sub chkoverallenvnstrategyandtimelingfirstoption_checked(ByVal sender As Object, ByVal e As EventArgs)
        chkoverallenvnstrategyandtimelingsecondoption.Checked = False
    End Sub
    Protected Sub chkoverallenvnstrategyandtimelingsecondoption_checked(ByVal sender As Object, ByVal e As EventArgs)
        chkoverallenvnstrategyandtimelingfirstoption.Checked = False
    End Sub


    '   grdnepaassistreport
    Protected Sub grdnepaassistreport_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim btn As LinkButton = e.Row.FindControl("lnkDelete")
            If checksubmitstatus = True Then
                btn.Enabled = False
            End If
        End If
    End Sub


    '   grdipaclist
    Protected Sub grdipaclist_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim btn As LinkButton = e.Row.FindControl("lnkDelete")
            If checksubmitstatus = True Then
                btn.Enabled = False
            End If
        End If
    End Sub


    '   grdnwimap
    Protected Sub grdnwimap_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim btn As LinkButton = e.Row.FindControl("lnkDelete")
            If checksubmitstatus = True Then
                btn.Enabled = False
            End If
        End If
    End Sub

    Private Sub WebForm1_Init(sender As Object, e As EventArgs) Handles Me.Init
        '       Dim checksubmitstatus As String
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString

        varId = Convert.ToString(Request.QueryString("project_pk"))

        Dim command As New SqlCommand
        command.Connection = conn
        command.CommandText = "select distinct isSubmitted FROM projectEnvironmentalNote where project_fk=" + varId
        command.CommandType = CommandType.Text
        conn.Open()
        Dim reader As SqlDataReader = command.ExecuteReader()
        If reader.Read() Then
            checksubmitstatus = reader("isSubmitted").ToString
            reader.Close()
            conn.Close()
            '           If checksubmitstatus = True Then
            'btnSubmit.Enabled = False
            'btnSave.Enabled = False
            'DisableInitialResponseFields()
            '        End If

        End If
        If Not checksubmitstatus Then
            Dim Grp() As Int16 = {210, 220, 500, 600}
            If Not Grp.Contains(Session("GroupID")) Then
                checksubmitstatus = True
            End If
        End If

        conn.Close()

    End Sub

    Private Sub SaveEnvironmentalNote_EnvironmentalPermit_Schedule_AnticipatedTimeLine()
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "AddEnvironmentalNote_EnvironmentalPermit_Schedule_AnticipatedTimeLine"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Sub


End Class


