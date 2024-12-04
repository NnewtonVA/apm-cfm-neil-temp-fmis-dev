Imports System.Data.SqlClient
Imports System.Net.Mail

Public Class UnassignedSubmittedQuestionnaireForm_Backup
    Inherits System.Web.UI.Page
    Dim varId As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim varId As String = Convert.ToString(Request.QueryString("project_pk"))
    End Sub
    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)
        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))

        Dim strPersonnelId As String = ddlAssignTo.SelectedValue.ToString
        Dim strPersonnelName As String = ddlAssignTo.SelectedItem.Text.ToString
        Dim strRoleId As String = "10"       ' role for Environmental Engineer

        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString

        addInfo()

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
            ScriptManager.RegisterClientScriptBlock(Me, [GetType](), "Message", "SaveAlertAndCloseWindowMsg2('The questionnaire is submitted and assigned to an engineer for Initial Response.');", True)

            ' send notification to an engineer work on the questionnaire for initial response
            'SendNotificationToanEngineer(strPersonnelName, strPersonnelId, strProjNum)

        End Using

    End Sub
    Public Function addInfo() As Object
        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))

        Dim strPersonnelId As String = ddlAssignTo.SelectedValue.ToString
        Dim strPersonnelName As String = ddlAssignTo.SelectedItem.Text.ToString
        Dim strRoleId As String = "10"       ' role for Environmental Engineer
        Dim enviropk As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))

        Dim struser As String = lblUserNm.Text
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
                'enviropk = sdr("EnviroSurvey_pk").ToString()
                ' conn.Close()
                If sdr.HasRows Then
                    enviropk = sdr("EnviroSurvey_pk").ToString()
                    conn.Close()
                    Dim com As New SqlCommand With {
           .Connection = conn,
           .CommandType = CommandType.Text,
           .CommandText = "delete from projectUtility where ProjectEnviroSurvayID=" + enviropk
}
                    conn.Open()
                    com.ExecuteNonQuery()
                    conn.Close()
                End If
                conn.Close()
            End Using

            Dim com3 As New SqlCommand With {
            .Connection = conn,
            .CommandType = CommandType.StoredProcedure,
            .CommandText = "DeleteSurvey"
}
            com3.Parameters.AddWithValue("@projectid", SqlDbType.Int).Value = varId
            conn.Open()
            com3.ExecuteNonQuery()
            conn.Close()
        End Using

        btnSubmitInsertOperation(1, 3, "", "")
        btnSubmitInsertOperation(2, 3, "", "")
        btnSubmitInsertOperation(3, 3, "", "")
        btnSubmitInsertOperation(6, 3, "", "")
        btnSubmitInsertOperation(50, 3, "", "")
        btnSubmitInsertOperation(51, 3, "", "")
        btnSubmitInsertOperation(52, 3, "", "")
        btnSubmitInsertOperation(53, 3, "", "")
        btnSubmitInsertOperation(54, 3, "", "")
        btnSubmitInsertOperation(90, 3, "", "")
        btnSubmitInsertOperation(7, 3, "", "")
        btnSubmitInsertOperation(8, 3, "", "")
        btnSubmitInsertOperation(15, 3, "", "")
        btnSubmitInsertOperation(16, 3, "", "")
        btnSubmitInsertOperation(18, 3, "", "")
        btnSubmitInsertOperation(19, 3, "", "")
        btnSubmitInsertOperation(23, 3, "", "")
        btnSubmitInsertOperation(27, 3, "", "")
        btnSubmitInsertOperation(32, 3, "", "")
        btnSubmitInsertOperation(34, 3, "", "")
        btnSubmitInsertOperation(36, 3, "", "")
        btnSubmitInsertOperation(37, 3, "", "")
        btnSubmitInsertOperation(38, 3, "", "")
        btnSubmitInsertOperation(39, 3, "", "")
        btnSubmitInsertOperation(44, 3, "", "")
        btnSubmitInsertOperation(46, 3, "", "")
        btnSubmitInsertOperation(55, 3, "", "")
        btnSubmitInsertOperation(56, 3, "", "")
        btnSubmitInsertOperation(59, 3, "", "")
        btnSubmitInsertOperation(61, 3, "", "")
        btnSubmitInsertOperation(66, 3, "", "")
        btnSubmitInsertOperation(67, 3, "", "")
        btnSubmitInsertOperation(68, 3, "", "")

        'Utilities Start
        'answersurveyfk_70 	Are there sufficient utilities (with capacity) to support the proposed project on site? Only answer yes, if it is known that all utilities have sufficent capacity 
        btnSubmitInsertOperation(70, "3", "", "")
        'answersurveyfk_71 Please inidcate which utilities could require modifications or changes to support the project.
        ' Dim answer_71 As String = Request.Form("sufficesntutilities")
        'If chkElectrical.Checked Then
        '    btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        'ElseIf chkSanitarysewer.Checked Then
        '    btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        'ElseIf chkStormsewer.Checked Then
        '    btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        'ElseIf chkSteam.Checked Then
        '    btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        'ElseIf chkPortablewater.Checked Then
        '    btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        'ElseIf chkChilledWater.Checked Then
        '    btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        'ElseIf chkNaturalgas.Checked Then
        '    btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        'ElseIf chkRelaimedwater.Checked Then
        '    btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        'End If

        'If chkElectrical.Checked Then
        '    btnSubmitAddUtilities(hdnElectricalfk_1.Value, txtElectrical.Text)
        'End If
        'If chkSanitarysewer.Checked Then
        '    btnSubmitAddUtilities(hdnSanitarySewerfk_2.Value, txtSanitarysewer.Text)
        'End If
        'If chkStormsewer.Checked Then
        '    btnSubmitAddUtilities(hdnstormwaterfk_3.Value, txtStormsewer.Text)
        'End If
        'If chkSteam.Checked Then
        '    btnSubmitAddUtilities(hdnSteamfk_4.Value, txtSteam.Text)
        'End If
        'If chkPortablewater.Checked Then
        '    btnSubmitAddUtilities(hdnPoratbalewaterfk_5.Value, txtPortablewater.Text)
        'End If
        'If chkChilledWater.Checked Then
        '    btnSubmitAddUtilities(hdnChilledwaterfk_6.Value, txtChilledwater.Text)
        'End If
        'If chkNaturalgas.Checked Then
        '    btnSubmitAddUtilities(hdnNaturalgasfk_7.Value, txtNaturalgas.Text)
        'End If
        'If chkRelaimedwater.Checked Then
        '    btnSubmitAddUtilities(hdnReclaimedwaterfk_8.Value, txtReclaimedwatersource.Text)
        'End If


        'answersurveyfk_72 If there is not sufficent capacity , will the project require utilities to be brought in from off site? 

        'If utilitiestobebroughtfrmsite.SelectedValue = "" Then
        'Else
        '    btnSubmitInsertOperation(hdnSurvey_fk_72.Value, utilitiestobebroughtfrmsite.SelectedValue, "", "")
        'End If

        ''answersurveyfk_73 Please indicate estimated distance for each needed utility. 

        ''answersurveyfk_74 	Is proposed routing of utilities known?

        'If proposedroutingofutilities.SelectedValue = "" Then
        'Else
        '    btnSubmitInsertOperation(hdnSurvey_fk_74.Value, proposedroutingofutilities.SelectedValue, "", "")
        'End If
        'answersurveyfk_75 	Are there any overhead utilities, underground utilities or easements that would need to be evaluated as part of the developability of the site? 
        btnSubmitInsertOperation(75, 3, "", "")
        ''Utilities End
        btnSubmitInsertOperation(76, 3, "", "")
        btnSubmitInsertOperation(77, 3, "", "")
        btnSubmitInsertOperation(81, 3, "", "")
        btnSubmitInsertOperation(82, 3, "", "")
        btnSubmitInsertOperation(85, 3, "", "")
        btnSubmitInsertOperation(87, 3, "", "")
        btnSubmitInsertOperation(88, 3, "", "")
        btnSubmitInsertOperation(89, 3, "", "")

        SendNotificationToanEngineer(strPersonnelName, strPersonnelId, strProjNum)
        'SendNotificationToanEngineer()
        'ScriptManager.RegisterClientScriptBlock(Me, [GetType](), "Message", "SaveAlertAndCloseWindowMsg1('Records Submitted Successfully.');", True)

    End Function
    Public Function btnSubmitInsertOperation(hiddensurvey, answers, link, comment) As Object
        'This is when Submit is Clicked.

        Dim strPersonnelId As String = ddlAssignTo.SelectedValue.ToString
        Dim strPersonnelName As String = ddlAssignTo.SelectedItem.Text.ToString
        Dim strRoleId As String = "10"       ' role for Environmental Engineer
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "AddSurvay"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@survey_pk", SqlDbType.Int).Value = hiddensurvey
            com.Parameters.AddWithValue("@answer_pk", SqlDbType.Int).Value = answers
            com.Parameters.Add("@link", SqlDbType.VarChar).Value = link
            com.Parameters.Add("@comment", SqlDbType.VarChar).Value = comment
            com.Parameters.Add("@documents", SqlDbType.VarBinary).Value = DBNull.Value
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            com.Parameters.Add("@isSubmited", SqlDbType.Bit).Value = 1
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Function
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
        sb.Append((Convert.ToString("<tr><td><br>To view the project updated with environmental response, click on this link: " + ConfigurationManager.AppSettings("ProjectforInitialListURL").ToString + "</td></tr>")))

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

    Protected Sub ibHome_Click(sender As Object, e As ImageClickEventArgs) Handles ibHome.Click
        Response.Redirect("Default.aspx")
    End Sub
    Private Function DbNullOrStringValue(ByVal value As String) As Object
        If String.IsNullOrEmpty(value) Then
            Return DBNull.Value
        Else
            Return value
        End If
    End Function
End Class