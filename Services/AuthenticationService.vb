Imports System.Data.SqlClient

Namespace CFMIS.Services
    Public Class AuthenticationService
        Inherits System.Web.UI.Page
        Public Function GetUserGroup() As String
            Try
                Dim uname As String = Context.User.Identity.Name
                uname = uname.Substring(uname.LastIndexOf("\") + 1)
                Session("UserNm") = uname

                Dim conn As New SqlConnection()
                conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString

                Dim cmd As New SqlCommand
                cmd.CommandText = "SELECT userGroup As GroupID FROM Personnel WHERE username = @username"
                cmd.Connection = conn

                cmd.Parameters.Add(New SqlParameter("@username", uname))
                conn.Open()
                Session("GroupID") = cmd.ExecuteScalar().ToString()
                conn.Close()
                Return Nothing
            Catch ex As Exception
                Session("GroupID") = Nothing
                Return ex.Message
            End Try
        End Function

    End Class
End Namespace

