Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Web.Security
Imports System.Web.UI


Public Class SiteEnvMaster
    Inherits MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        'Dim uname As String = Context.User.Identity.Name
        'lblUser.Text = uname.Substring(uname.LastIndexOf("\") + 1)

        ''Dim UsrGrp As String = Session("GroupNm")

        'If Session("GroupID") Is Nothing Then
        '    ibUser.Visible = False
        '    ibSearch.Visible = False
        'End If

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

