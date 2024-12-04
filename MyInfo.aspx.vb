Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Services
Imports AjaxControlToolkit
Imports System.Web.UI.HtmlControls
Imports System.DirectoryServices
Imports System.Net.Mail
Imports System.Net


Public Class MyInfo
    Inherits System.Web.UI.Page

    ''' <summary>
    ''' The Homw and Search Icons will be hidden for this page.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim menu As ContentPlaceHolder = CType(Master.FindControl("cphQuickMenu"), ContentPlaceHolder)
        menu.Visible = False
    End Sub
    ''' <summary>
    ''' The left side menu will be visible based on the logged on user group.
    ''' </summary>
    Private Sub MyInfo_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        'If Session("GroupID") >= 400 Then
        '    UCMenuAdmin.Visible = True
        '    UCMenuGeneral.Visible = False
        'Else
        '    UCMenuAdmin.Visible = False
        '    UCMenuGeneral.Visible = True
        'End If

        If Session("GroupID") >= 320 Then
            UCMenuAdmin.Visible = True
            UCMenuGeneral.Visible = False
            UCMenuEnvDirector.Visible = False
            UCMenuEnvEngineer.Visible = False
        ElseIf Session("GroupID") = 210 Then
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = False
            UCMenuEnvDirector.Visible = False
            UCMenuEnvEngineer.Visible = True
        ElseIf Session("GroupID") = 220 Then
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = False
            UCMenuEnvDirector.Visible = True
            UCMenuEnvEngineer.Visible = False
        Else
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = True
            UCMenuEnvDirector.Visible = False
            UCMenuEnvEngineer.Visible = False
        End If

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
    ''' The logged on user can update some of their information by clicking the Save button. It will
    ''' run the SP UpdatePersonalInfo to update the data.
    ''' </summary>
    Protected Sub lbUpdateInfo_Click(sender As Object, e As EventArgs)
        Dim strFirstNm As String = CType(fvPersonalInfo.FindControl("txtFirstNm"), TextBox).Text
        Dim strLastNm As String = CType(fvPersonalInfo.FindControl("txtLastNm"), TextBox).Text
        Dim strPhone As String = CType(fvPersonalInfo.FindControl("txtPhoneNum"), TextBox).Text
        Dim strUserNm As String = Session("UserNm")
        Dim strResult As String
        If strPhone = "(___) ___-____" Then
            strPhone = String.Empty
        End If
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "UpdatePersonalInfo"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@FirstName", DbNullOrStringValue(strFirstNm))
            cmd.Parameters.AddWithValue("@LastName", DbNullOrStringValue(strLastNm))
            cmd.Parameters.AddWithValue("@Phone", DbNullOrStringValue(strPhone))
            cmd.Parameters.AddWithValue("@Username", DbNullOrStringValue(strUserNm))
            cmd.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            cmd.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            'lblResult.Text = cmd.Parameters("@Result").Value.ToString()
            strResult = cmd.Parameters("@Result").Value.ToString()
            ClientScript.RegisterStartupScript(Me.GetType(), "ClientScript", "alert('" + strResult + "')", True)
        End Using
    End Sub
End Class