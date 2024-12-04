Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Web.Security
Imports System.Web.UI


Public Class SiteMaster
    Inherits MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        If ConfigurationManager.AppSettings("SSOMode").ToString = "NO" Then
            Dim uname As String = Context.User.Identity.Name
            lblUser.Text = uname.Substring(uname.LastIndexOf("\") + 1)
            btnLogout.Visible = False
        Else
            Dim strfullname As String = Request("HTTP_FIRSTNAME") + " " + Request("HTTP_LASTNAME")
            Dim strSecID As String = Request("HTTP_SECID")

            Dim uname As String = strfullname

            lblUser.Text = uname.Substring(uname.LastIndexOf("\") + 1)
            btnLogout.Visible = True

        End If

        If Session("GroupID") Is Nothing Then
            ibUser.Visible = False
            ibSearch.Visible = False
        End If

    End Sub
    ''' <summary>
    ''' The Home image button will open the Home page.
    ''' </summary>
    Protected Sub ibHome_Click(sender As Object, e As ImageClickEventArgs) Handles ibHome.Click
        Response.Redirect("~/Default.aspx")
    End Sub
    ''' <summary>
    ''' The Searh image button will open the Search page.
    ''' </summary>
    Protected Sub ibSearch_Click(sender As Object, e As ImageClickEventArgs) Handles ibSearch.Click
        Response.Redirect("~/SearchProject.aspx")
    End Sub
    ''' <summary>
    ''' The User Info image button will open the MyInfo page.
    ''' </summary>
    Protected Sub ibUser_Click(sender As Object, e As ImageClickEventArgs) Handles ibUser.Click
        Response.Redirect("~/MyInfo.aspx")
    End Sub

    Protected Sub btnLogout_Click(sender As Object, e As EventArgs) Handles btnLogout.Click
        ' begin get URL for IAM logout
        Dim strLogoutURL As String = ""
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "GetAppSettings"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@settingID", "IAMLogOut")
            command.Parameters.Add("@ResultSettingValue", SqlDbType.VarChar, 400)
            command.Parameters("@ResultSettingValue").Direction = ParameterDirection.Output
            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            strLogoutURL = command.Parameters("@ResultSettingValue").Value.ToString()
        End Using
        ' end get URL for IAM logout

        Response.Redirect(strLogoutURL)

    End Sub
End Class