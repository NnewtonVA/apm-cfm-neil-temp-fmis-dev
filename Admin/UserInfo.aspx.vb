Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Services
Imports AjaxControlToolkit
Imports System.Web.UI.HtmlControls
Imports System.DirectoryServices
Imports System.Net.Mail
Imports System.Net

Public Class UserInfo
    Inherits System.Web.UI.Page


    Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
    Public tr As Long
    Dim strLoggedUser As String
    ''' <summary>
    ''' Get the logged on user and group.Also the VA Logo at the top and the Home and Search imagebuttons from the
    ''' master page will be hidden.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim menu1 As ContentPlaceHolder = CType(Master.FindControl("cphMainMenu"), ContentPlaceHolder)
        menu1.Visible = False
        Dim menu As ContentPlaceHolder = CType(Master.FindControl("cphQuickMenu"), ContentPlaceHolder)
        menu.Visible = False

        lblUserRoleId.Text = Session("GroupID")
        strLoggedUser = Session("UserNm")
    End Sub
    ''' <summary>
    ''' This is Search button click event. If there is text in the text box for 
    ''' search by userid, then the filter will have a wild card to bring the matching
    ''' records. If the search text box is empty, the grid view will show all user.
    ''' </summary>
    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        If Not txtUser.Text = String.Empty Then

            '            odsrcUserInfo.FilterExpression = "FullName like '%" + txtUser.Text + "%'"
            odsrcUserInfoDS.FilterExpression = "FullName like '%" + txtUser.Text + "%'"

        ElseIf txtUser.Text = String.Empty Then
            gvUser.DataBind()
        End If
    End Sub
    ''' <summary>
    ''' Clicking the View All button will make the text box empty and
    ''' will bring all data.
    ''' </summary>
    Protected Sub btnVwAll_Click(sender As Object, e As EventArgs) Handles btnVwAll.Click
        txtUser.Text = String.Empty
        gvUser.DataBind()
    End Sub
    ''' <summary>
    ''' When the user selects different page size by clicking in the dropdownlist.
    ''' </summary>
    Protected Sub ddlPageSize_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddlPageSize As DropDownList = DirectCast(sender, DropDownList)
        gvUser.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue)

        Dim pageindex As Integer = gvUser.PageIndex
        gvUser.DataBind()
        If gvUser.PageIndex <> pageindex Then
            'if page index changed it means the previous page was not valid and was adjusted. Rebind to fill control with adjusted page
            gvUser.DataBind()
        End If
    End Sub
    ''' <summary>
    ''' Get the number of pages when the grid view databound happens.
    ''' </summary>
    Protected Sub gvUser_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        If gvUser.Rows.Count >= 1 Then
            Dim ddl As DropDownList = CType(gvUser.BottomPagerRow.Cells(0).FindControl("ddlPaging"), DropDownList)
            For cnt As Integer = 0 To gvUser.PageCount - 1
                Dim curr As Integer = cnt + 1
                Dim item As New ListItem(curr.ToString())
                If cnt = gvUser.PageIndex Then
                    item.Selected = True
                End If
                ddl.Items.Add(item)
            Next cnt
        End If
        lblTotalRec.Text = "of " & tr.ToString
    End Sub
    ''' <summary>
    ''' When the user selects different page number to go to that page by clicking in the dropdownlist.
    ''' </summary>
    Protected Sub ddlPaging_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim ddl As DropDownList = CType(gvUser.BottomPagerRow.Cells(0).FindControl("ddlPaging"), DropDownList)
        gvUser.PageIndex = ddl.SelectedIndex
    End Sub
    ''' <summary>
    ''' This is to count the total number of records to show in a label lblTotalRec in the
    ''' grid view data bound event.
    ''' </summary>
    'Protected Sub odsrcUserInfo_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsrcUserInfo.Selected
    '    Dim dt As Data.DataTable = CType(e.ReturnValue, Data.DataTable)
    '    tr = dt.Rows.Count
    'End Sub

    ''' <summary>
    ''' This is to count the total number of records to show in a label lblTotalRec in the
    ''' grid view data bound event.
    ''' </summary>
    Protected Sub odsrcUserInfoDS_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsrcUserInfoDS.Selected
        Dim dt As Data.DataTable = CType(e.ReturnValue, Data.DataTable)
        tr = dt.Rows.Count
    End Sub


    ''' <summary>
    ''' When the user clicks Add User button, it will open the mpeAddUser modal popup and 
    ''' will refresh the formview and lblErrorAddUser.
    ''' </summary>
    Protected Sub btnAddUser_Click(sender As Object, e As EventArgs) Handles btnAddUser.Click
        fvAddUser.DataBind()
        mpeAddUser.Show()
        lblErrorAddUser.Text = String.Empty
    End Sub
    ''' <summary>
    ''' This function is to insert null in the database in case the text box is empty.
    ''' </summary>
    Public Function DbNullOrStringValue(ByVal value As String) As Object
        If String.IsNullOrEmpty(value) Then
            Return DBNull.Value
        Else
            Return value
        End If
    End Function
    ''' <summary>
    ''' Clicking the Add user button will run the SP AddUser. The first name, last name and email
    ''' address will be populated from the GAL by userid. 
    ''' </summary>
    Protected Sub lbAddUser_Click(sender As Object, e As EventArgs) Handles lbAddUser.Click
        Dim strFirstNm As String = CType(fvAddUser.FindControl("txtAddFrstNm"), TextBox).Text
        Dim strLastNm As String = CType(fvAddUser.FindControl("txtAddLstNm"), TextBox).Text
        Dim strUserNm As String = CType(fvAddUser.FindControl("txtAddUserNm"), TextBox).Text
        Dim strPhone As String = CType(fvAddUser.FindControl("txtAddPhone"), TextBox).Text
        Dim strEmail As String = CType(fvAddUser.FindControl("txtAddEmail"), TextBox).Text
        Dim strGroup As String = CType(fvAddUser.FindControl("ddlGroup"), DropDownList).Text
        Dim cbSre As CheckBox = CType(fvAddUser.FindControl("cbAddSre"), CheckBox)
        Dim cbProjManager As CheckBox = CType(fvAddUser.FindControl("cbProjMangr"), CheckBox)
        Dim cbProjEng As CheckBox = CType(fvAddUser.FindControl("cbAddProjEng"), CheckBox)
        Dim cbContrctOfficer As CheckBox = CType(fvAddUser.FindControl("cbContOfficer"), CheckBox)
        Dim cbprojectPersonnel As CheckBox = CType(fvAddUser.FindControl("cbAddprojectPersonnel"), CheckBox)

        Dim varResult As String
        'Dim varEmailTo As String
        'Dim varEmailFrom As String
        'Dim intEmailLenght As Integer

        Dim strLDAP As String
        strLDAP = "dc=va,dc=gov"
        Dim de As DirectoryServices.DirectoryEntry = New System.DirectoryServices.DirectoryEntry("GC://" + strLDAP)
        Dim search As New DirectorySearcher(de)
        Dim result As SearchResult
        search.Filter = "(SAMAccountName=" + strUserNm + ")"
        Try
            search.PropertiesToLoad.Add("mail")
            search.PropertiesToLoad.Add("GivenName")
            search.PropertiesToLoad.Add("sn")
            'search.PropertiesToLoad.Add("telephonenumber")
        Catch ex As Exception

        End Try
        result = search.FindOne()
        If Not result Is Nothing Then
            Try
                strEmail = result.Properties("mail")(0).ToString()
                strFirstNm = result.Properties("GivenName")(0).ToString()
                strLastNm = result.Properties("sn")(0).ToString()
                'strPhone = result.Properties("telephonenumber")(0).ToString()
            Catch ex As Exception
            End Try
        Else
            If strFirstNm = String.Empty And strLastNm = String.Empty Then
                lblErrorAddUser.Text = "User not found"
                mpeAddUser.Show()
                Exit Sub
            Else
                'strLastNm = String.Empty
            End If
        End If
        If strPhone = "(___) ___-____" Then
            strPhone = String.Empty
        End If
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "AddUser"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@FirstName", DbNullOrStringValue(strFirstNm))
            cmd.Parameters.AddWithValue("@LastName", DbNullOrStringValue(strLastNm))
            cmd.Parameters.AddWithValue("@Phone", DbNullOrStringValue(strPhone))
            cmd.Parameters.AddWithValue("@Email", DbNullOrStringValue(strEmail))
            cmd.Parameters.AddWithValue("@Username", DbNullOrStringValue(strUserNm))
            cmd.Parameters.AddWithValue("@UserGroup", DbNullOrStringValue(strGroup))
            'cmd.Parameters.AddWithValue("@LoggedUserId", DbNullOrStringValue(strLoggedUser))
            If cbSre.Checked Then
                cmd.Parameters.AddWithValue("@Sre", SqlDbType.Bit).Value = 1
            Else
                cmd.Parameters.AddWithValue("@Sre", SqlDbType.Bit).Value = 0
            End If
            If cbProjManager.Checked Then
                cmd.Parameters.AddWithValue("@projManager", SqlDbType.Bit).Value = 1
            Else
                cmd.Parameters.AddWithValue("@projManager", SqlDbType.Bit).Value = 0
            End If
            If cbProjEng.Checked Then
                cmd.Parameters.AddWithValue("@ProjEng", SqlDbType.Bit).Value = 1
            Else
                cmd.Parameters.AddWithValue("@ProjEng", SqlDbType.Bit).Value = 0
            End If
            If cbContrctOfficer.Checked Then
                cmd.Parameters.AddWithValue("@ContrctOfficer", SqlDbType.Bit).Value = 1
            Else
                cmd.Parameters.AddWithValue("@ContrctOfficer", SqlDbType.Bit).Value = 0
            End If
            If cbprojectPersonnel.Checked Then
                cmd.Parameters.AddWithValue("@projectPersonnel", SqlDbType.Bit).Value = 1
            Else
                cmd.Parameters.AddWithValue("@projectPersonnel", SqlDbType.Bit).Value = 0
            End If

            cmd.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            cmd.Parameters("@Result").Direction = ParameterDirection.Output
            'cmd.Parameters.Add("@EmailTo", SqlDbType.VarChar, 100)
            'cmd.Parameters("@EmailTo").Direction = ParameterDirection.Output
            'cmd.Parameters.Add("@EmailFrom", SqlDbType.VarChar, 100)
            'cmd.Parameters("@EmailFrom").Direction = ParameterDirection.Output
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            'lblResult.Text = cmd.Parameters("@Result").Value.ToString()
            varResult = cmd.Parameters("@Result").Value.ToString()
            ClientScript.RegisterStartupScript(Me.GetType(), "ClientScript", "alert('" + varResult + "')", True)

            'varEmailTo = cmd.Parameters("@EmailTo").Value.ToString()
            'varEmailFrom = cmd.Parameters("@EmailFrom").Value.ToString()
        End Using
        gvUser.DataBind()

        'intEmailLenght = varEmailTo.Length
        'If intEmailLenght > 0 Then
        '    Dim strEmailTo = varEmailTo
        '    Dim ProjLink As New HyperLink
        '    ProjLink.NavigateUrl = "http://cfm.vaco.va.gov/CFMIS_Factsheet/Default.aspx"
        '    Dim sb As New StringBuilder()
        '    sb.Append("<table>")
        '    sb.Append((Convert.ToString("<tr><td>Hello, ") + "</td></tr>"))
        '    sb.Append((Convert.ToString("<tr><td>You have been granted access to CFMIS application. ") + "</td></tr>"))
        '    sb.Append((Convert.ToString("<tr><td>Click on the link to go to access the application.") + "</td></tr>"))
        '    sb.Append((Convert.ToString("<tr><td>") & ProjLink.NavigateUrl) + "</td></tr>")
        '    Dim mm As New MailMessage()
        '    mm.IsBodyHtml = True
        '    mm.From = New MailAddress(varEmailFrom)
        '    mm.[To].Add(strEmailTo)
        '    mm.Subject = "Automated email - New User Notification"

        '    sb.Append("</table>")
        '    mm.Body = sb.ToString()
        '    Application("strIP") = "smtp.va.gov"
        '    Dim smtp As New SmtpClient(Application("strIP").ToString())
        '    smtp.Send(mm)
        '    mm.Dispose()
        'End If
    End Sub
    ''' <summary>
    ''' When the user clicks Edit button in the grid, it will open the mpeEditUser modal popup and 
    ''' will refresh the edit formview and lblError.
    ''' </summary>
    Protected Sub lbEditUser_Click(sender As Object, e As EventArgs)
        mpeEditUser.Show()
        fvEditUser.DataBind()
        lblError.Text = String.Empty
    End Sub
    ''' <summary>
    ''' Clicking the Save button in editing popup will run the SP EditUser. 
    ''' </summary>
    Protected Sub lbUserEdit_Click(sender As Object, e As EventArgs) Handles lbUserEdit.Click
        Dim strId As String = CType(fvEditUser.FindControl("lblPersonnelId"), Label).Text
        Dim strFstnm As String = CType(fvEditUser.FindControl("txtEditFrstNm"), TextBox).Text
        Dim strLstnm As String = CType(fvEditUser.FindControl("txtEditLstNm"), TextBox).Text
        Dim strUsrnm As String = CType(fvEditUser.FindControl("txtEditUserNm"), TextBox).Text
        Dim strPhone As String = CType(fvEditUser.FindControl("txtEditPhone"), TextBox).Text
        Dim strEmail As String = CType(fvEditUser.FindControl("txtEditEmail"), TextBox).Text
        Dim strGrpNm As String = CType(fvEditUser.FindControl("ddlEditGroup"), DropDownList).Text
        Dim ChkSre As CheckBox = CType(fvEditUser.FindControl("cbEditSre"), CheckBox)
        Dim ChkProjEng As CheckBox = CType(fvEditUser.FindControl("cbEditProjEng"), CheckBox)
        Dim ChkProjMangr As CheckBox = CType(fvEditUser.FindControl("cbEditProjMangr"), CheckBox)
        Dim ChkContOfficer As CheckBox = CType(fvEditUser.FindControl("cbEditContOfficer"), CheckBox)
        Dim ChkprojectPersonnel As CheckBox = CType(fvEditUser.FindControl("cbEditprojectPersonnel"), CheckBox)

        Dim ChkInactive As CheckBox = CType(fvEditUser.FindControl("cbInactive"), CheckBox)
        Dim strResult As String
        If strPhone = "(___) ___-____" Then
            strPhone = String.Empty
        End If
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "EditUser"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@personnel_pk", DbNullOrStringValue(strId))
            cmd.Parameters.AddWithValue("@FirstName", DbNullOrStringValue(strFstnm))
            cmd.Parameters.AddWithValue("@LastName", DbNullOrStringValue(strLstnm))
            cmd.Parameters.AddWithValue("@Phone", DbNullOrStringValue(strPhone))
            cmd.Parameters.AddWithValue("@Email", DbNullOrStringValue(strEmail))
            cmd.Parameters.AddWithValue("@Username", DbNullOrStringValue(strUsrnm))
            cmd.Parameters.AddWithValue("@UserGroup", DbNullOrStringValue(strGrpNm))
            If ChkSre.Checked Then
                cmd.Parameters.AddWithValue("@Sre", SqlDbType.Bit).Value = 1
            Else
                cmd.Parameters.AddWithValue("@Sre", SqlDbType.Bit).Value = 0
            End If
            If ChkProjMangr.Checked Then
                cmd.Parameters.AddWithValue("@projManager", SqlDbType.Bit).Value = 1
            Else
                cmd.Parameters.AddWithValue("@projManager", SqlDbType.Bit).Value = 0
            End If
            If ChkProjEng.Checked Then
                cmd.Parameters.AddWithValue("@ProjEng", SqlDbType.Bit).Value = 1
            Else
                cmd.Parameters.AddWithValue("@ProjEng", SqlDbType.Bit).Value = 0
            End If
            If ChkContOfficer.Checked Then
                cmd.Parameters.AddWithValue("@ContrctOfficer", SqlDbType.Bit).Value = 1
            Else
                cmd.Parameters.AddWithValue("@ContrctOfficer", SqlDbType.Bit).Value = 0
            End If
            If ChkprojectPersonnel.Checked Then
                cmd.Parameters.AddWithValue("@projectPersonnel", SqlDbType.Bit).Value = 1
            Else
                cmd.Parameters.AddWithValue("@projectPersonnel", SqlDbType.Bit).Value = 0
            End If
            If ChkInactive.Checked Then
                cmd.Parameters.AddWithValue("@Deleted", SqlDbType.Bit).Value = 1
            Else
                cmd.Parameters.AddWithValue("@Deleted", SqlDbType.Bit).Value = 0
            End If
            cmd.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            cmd.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            'lblResult.Text = cmd.Parameters("@Result").Value.ToString()
            strResult = cmd.Parameters("@Result").Value.ToString()
            ClientScript.RegisterStartupScript(Me.GetType(), "ClientScript", "alert('" + strResult + "')", True)

        End Using
        '        gvUser.DataBind()
        If strUsrnm.ToUpper() = Session("UserNm").ToString.ToUpper() Then
            Response.Redirect("~/Default.aspx")
        Else
            Response.Redirect("~/Admin/UserInfo.aspx")
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selecting(sender As Object, e As ObjectDataSourceSelectingEventArgs) Handles odsrcUserInfoDS.Selecting

    End Sub
End Class