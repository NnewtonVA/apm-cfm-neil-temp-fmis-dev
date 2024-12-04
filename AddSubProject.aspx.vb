Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Services
Imports AjaxControlToolkit
Imports System.Web.UI.HtmlControls

Public Class AddSubProject
    Inherits System.Web.UI.Page

    ''' <summary>
    ''' The VA Logo at the top will be hidden for this page. When the page loads first time it
    ''' will run the NewForm method to populate some of the fields from the main project.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim menu As ContentPlaceHolder = CType(Master.FindControl("cphMainMenu"), ContentPlaceHolder)
        menu.Visible = False
        If Not Page.IsPostBack Then
            NewForm()
        End If
        Dim varId As String
        varId = CType(fvAddProject.FindControl("lblProjCode"), Label).Text
        lblProjnum.Text = "Add New Sub Project for Project Number " & varId
    End Sub
    ''' <summary>
    ''' This will make the project description, number and status fields empty so that user can 
    ''' enter information.
    ''' </summary>
    Private Sub NewForm()
        Dim textProjDesc As TextBox = CType(fvAddProject.FindControl("txtProjDesc"), TextBox)
        Dim textProjNo As TextBox = CType(fvAddProject.FindControl("txtProjCode"), TextBox)
        'Dim textProjYr As TextBox = CType(fvAddProject.FindControl("txtProgYr"), TextBox)
        Dim drpdlStatus As DropDownList = CType(fvAddProject.FindControl("ddlStatus"), DropDownList)

        textProjDesc.Text = String.Empty
        textProjNo.Text = String.Empty
        'textProjYr.Text = String.Empty
        drpdlStatus.SelectedValue = 0
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
    ''' Clicking the Submit button will run SP AddSubProject. It will check that the project number
    ''' field in not empty.
    ''' </summary>
    Protected Sub btnAddSubProj_Click(sender As Object, e As EventArgs)
        Dim varProjId As String = CType(fvAddProject.FindControl("lblProjId"), Label).Text
        Dim varStation As String = CType(fvAddProject.FindControl("lblStationFk"), Label).Text
        Dim varProjDes As String = CType(fvAddProject.FindControl("txtProjDesc"), TextBox).Text
        Dim varFmsNo As String = CType(fvAddProject.FindControl("txtFmsNo"), TextBox).Text
        Dim varProjCode As String = CType(fvAddProject.FindControl("txtProjCode"), TextBox).Text
        'Dim varProgmYr As String = CType(fvAddProject.FindControl("txtProgYr"), TextBox).Text
        Dim varRegion As String = CType(fvAddProject.FindControl("lblAddRegion"), Label).Text
        Dim varNcaDistrict As String = CType(fvAddProject.FindControl("lblNcaDistFk"), Label).Text
        Dim varStatus As String = CType(fvAddProject.FindControl("ddlStatus"), DropDownList).Text
        Dim varDelivary As String = CType(fvAddProject.FindControl("ddlDelivary"), DropDownList).Text
        Dim varProgCat As String = CType(fvAddProject.FindControl("ddlProgCat"), DropDownList).Text
        Dim varProgSubCat As String = CType(fvAddProject.FindControl("ddlSubCat"), DropDownList).Text
        Dim varProjType As String = CType(fvAddProject.FindControl("lblProjType"), Label).Text
        Dim varUser As String = Session("UserNm")

        If varProjCode = "___-___-_" Then
            varProjCode = String.Empty
            lblError.Text = "Project Number is Required"
            Exit Sub
        End If

        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "AddSubProject"
            command.CommandType = CommandType.StoredProcedure

            command.Parameters.AddWithValue("@ProjectId", DbNullOrStringValue(varProjId))
            command.Parameters.AddWithValue("@fmsNo", DbNullOrStringValue(varFmsNo))
            command.Parameters.AddWithValue("@projectDesc", DbNullOrStringValue(varProjDes))
            command.Parameters.AddWithValue("@projectCode", DbNullOrStringValue(varProjCode))
            'command.Parameters.AddWithValue("@programYr", DbNullOrStringValue(varProgmYr))
            command.Parameters.AddWithValue("@UserName", DbNullOrStringValue(varUser))
            command.Parameters.AddWithValue("@station", SqlDbType.Int).Value = varStation
            command.Parameters.AddWithValue("@status", SqlDbType.Int).Value = varStatus
            command.Parameters.AddWithValue("@DelivaryMethod", SqlDbType.Int).Value = varDelivary
            command.Parameters.AddWithValue("@ProgCat", SqlDbType.Int).Value = varProgCat
            command.Parameters.AddWithValue("@ProgSubCat", SqlDbType.Int).Value = varProgSubCat
            command.Parameters.AddWithValue("@projType", SqlDbType.Int).Value = varProjType
            command.Parameters.AddWithValue("@Region", SqlDbType.VarChar).Value = varRegion
            If varNcaDistrict = "" Then
                command.Parameters.AddWithValue("@NcaDistrict", SqlDbType.Int).Value = System.DBNull.Value
            Else
                command.Parameters.AddWithValue("@NcaDistrict", SqlDbType.Int).Value = varNcaDistrict
            End If
            command.Parameters.Add("@Result", SqlDbType.Int)
            command.Parameters("@Result").Direction = ParameterDirection.Output
            command.Parameters.Add("@ShowErrorMsg", SqlDbType.VarChar, 150)
            command.Parameters("@ShowErrorMsg").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            lblError.Text = command.Parameters("@ShowErrorMsg").Value.ToString()
            Dim varNewId As String
            varNewId = command.Parameters("@Result").Value.ToString()
            If varNewId <> String.Empty Then
                Response.Redirect("~/ProjectDetails.aspx?project_pk=" + varNewId)
            End If
        End Using
    End Sub
    ''' <summary>
    ''' Clicking the Exit button will transfer user to the landing page.
    ''' </summary>
    Protected Sub btnCanclSubProj_Click(sender As Object, e As EventArgs)
        Dim varProjId As String = CType(fvAddProject.FindControl("lblProjId"), Label).Text
        Response.Redirect("~/ProjectDetails.aspx?project_pk=" + varProjId)
    End Sub
    ''' <summary>
    ''' Clicking the Reset button will run the NewForm method and will make some fields empty for user
    ''' to enter data again.
    ''' </summary>
    Protected Sub btnClear_Click(sender As Object, e As EventArgs)
        NewForm()
    End Sub
End Class