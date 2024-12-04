Imports System.Data.SqlClient
Imports CFMISNew.CFMIS.Services

Public Class _Default
    Inherits System.Web.UI.Page

    ''' <summary>
    ''' The icons for Home and Search pages will not be visible. This page will show different menu
    ''' in the left side based on logged on users access. When the page loads, it will run the GetUserGroup
    ''' function to get the groupid of the logged on user.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Dim menu As ContentPlaceHolder = CType(Master.FindControl("cphQuickMenu"), ContentPlaceHolder)
        menu.Visible = False

        If ConfigurationManager.AppSettings("SSOMode").ToString = "NO" Then

            Dim authenticationservice As New AuthenticationService()
            Dim ugResult As String = authenticationservice.GetUserGroup()
            authenticationservice.Dispose()
        Else
            '--- begin SSO

            Dim strfullname As String = Request("HTTP_FIRSTNAME") + " " + Request("HTTP_LASTNAME")
            Dim strSecID As String = Request("HTTP_SECID")
            Dim strNetworkID As String = Request("HTTP_NETWORKID")

            Session("UserNm") = strNetworkID
            Session("FullName") = strfullname

            ' begin SSO get RoleID

            Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
            Using conn As New SqlConnection(ConnStr)
                Dim command As New SqlCommand
                command.Connection = conn
                command.CommandText = "GetUserGroupID"
                command.CommandType = CommandType.StoredProcedure

                command.Parameters.AddWithValue("@networkID", DbNullOrStringValue(strNetworkID))
                command.Parameters.AddWithValue("@secID", DbNullOrStringValue(strSecID))
                command.Parameters.Add("@Result", SqlDbType.Int)
                command.Parameters("@Result").Direction = ParameterDirection.Output
                conn.Open()
                command.ExecuteNonQuery()
                conn.Close()

                Session("GroupID") = command.Parameters("@Result").Value.ToString()
                If String.IsNullOrEmpty(Session("GroupID")) Then
                    Session("GroupID") = Nothing
                End If
            End Using
            ' end SSO get RoleID

        End If

        '-----------------  end

        'Session("GroupID") = 600

        If Session("GroupID") Is Nothing Then
            Response.Redirect("~/Login.aspx")
        Else
            'Set the menu visible according to the group of logged on user
            If Session("GroupID") >= 320 Then
                UCMenuAdmin.Visible = True
                UCMenuGeneral.Visible = False
                UCMenuEnvDirector.Visible = False
                UCMenuEnvEngineer.Visible = False
                UCMenuSustainability.Visible = False
            ElseIf Session("GroupID") = 210 Then
                UCMenuAdmin.Visible = False
                UCMenuGeneral.Visible = False
                UCMenuEnvDirector.Visible = False
                UCMenuEnvEngineer.Visible = True
                UCMenuSustainability.Visible = False
            ElseIf Session("GroupID") = 220 Then
                UCMenuAdmin.Visible = False
                UCMenuGeneral.Visible = False
                UCMenuEnvDirector.Visible = True
                UCMenuEnvEngineer.Visible = False
            ElseIf Session("GroupID") = 225 Or Session("GroupID") = 230 Then
                UCMenuAdmin.Visible = False
                UCMenuGeneral.Visible = False
                UCMenuEnvDirector.Visible = False
                UCMenuEnvEngineer.Visible = False
                UCMenuSustainability.Visible = True
            Else
                UCMenuAdmin.Visible = False
                UCMenuGeneral.Visible = True
                UCMenuEnvDirector.Visible = False
                UCMenuEnvEngineer.Visible = False
                UCMenuSustainability.Visible = False
            End If
        End If

    End Sub
    <System.Web.Services.WebMethod, System.Web.Script.Services.ScriptMethod> _
    Public Shared Function GetSlides() As AjaxControlToolkit.Slide()

        Dim imgSlide(3) As AjaxControlToolkit.Slide

        imgSlide(0) = New AjaxControlToolkit.Slide("images/Slide/sliderConstruction.png", "Construction", "Construction Projects Plans")
        imgSlide(1) = New AjaxControlToolkit.Slide("images/Slide/sliderContract.png", "Contract", "Contract")
        imgSlide(2) = New AjaxControlToolkit.Slide("images/Slide/sliderCost.png", "Cost Estimate", "Cost Estimatation for Project")

        Return (imgSlide)
    End Function

    Public Function DbNullOrStringValue(ByVal value As String) As Object
        If String.IsNullOrEmpty(value) Then
            Return DBNull.Value
        Else
            Return value
        End If
    End Function
End Class