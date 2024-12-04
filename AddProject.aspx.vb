Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Services
Imports AjaxControlToolkit
Imports System.Web.UI.HtmlControls

Public Class AddProject
    Inherits System.Web.UI.Page

    ''' <summary>
    ''' The VA Logo at the top will be hidden for this page and also the Hone and Search icons at the top.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim menu1 As ContentPlaceHolder = CType(Master.FindControl("cphMainMenu"), ContentPlaceHolder)
        menu1.Visible = False
        Dim menu As ContentPlaceHolder = CType(Master.FindControl("cphQuickMenu"), ContentPlaceHolder)
        menu.Visible = False
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
    ''' Clicking the Submit button will run the SP AddProject and will insert data in
    ''' the Project table to create a new record
    ''' </summary>
    Protected Sub btnAddProject_Click(sender As Object, e As EventArgs)
        'Dim varIsSubProj As CheckBox = CType(fvAddProject.FindControl("cbSubProjectFlag"), CheckBox)
        Dim varprojDesc As String = CType(fvAddProject.FindControl("txtProjDesc"), TextBox).Text
        Dim varStation As String = CType(fvAddProject.FindControl("ddlStation"), DropDownList).Text
        Dim varFmsNo As String = CType(fvAddProject.FindControl("txtFmsNo"), TextBox).Text
        Dim varProjCode As String = CType(fvAddProject.FindControl("txtProjCode"), TextBox).Text
        Dim varStatus As String = CType(fvAddProject.FindControl("ddlStatus"), DropDownList).Text
        Dim varDelivaryMethod As String = CType(fvAddProject.FindControl("ddlDelivary"), DropDownList).Text
        Dim varProgCat As String = CType(fvAddProject.FindControl("ddlProgCat"), DropDownList).Text
        Dim varProgSubCat As String = CType(fvAddProject.FindControl("ddlSubCat"), DropDownList).Text
        Dim varProjType As String = CType(fvAddProject.FindControl("ddlProjTp"), DropDownList).Text
        Dim varRegion As String = CType(fvAddProject.FindControl("ddlRegion"), DropDownList).Text
        Dim varNcaDistrict As String = CType(fvAddProject.FindControl("ddlNcaDistrict"), DropDownList).Text
        Dim varDistrictReq As Label = CType(fvAddProject.FindControl("lblNcaDistrict"), Label)
        Dim varProgYr As String = CType(fvAddProject.FindControl("txtProgYr"), TextBox).Text
        Dim varUser As String = Session("UserNm")

        If varProjCode = "___-___" Then
            varProjCode = String.Empty
            lblError.Text = "Project Number is Required"
            Exit Sub
        End If

        If varRegion = "Cemetery" And varNcaDistrict = "" Then
            varDistrictReq.Text = "District required"
            varDistrictReq.ForeColor = Drawing.Color.Red
            Exit Sub
        End If

        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "AddProject"
            command.CommandType = CommandType.StoredProcedure

            command.Parameters.AddWithValue("@fmsNo", DbNullOrStringValue(varFmsNo))
            command.Parameters.AddWithValue("@projectDesc", DbNullOrStringValue(varprojDesc))
            command.Parameters.AddWithValue("@projectCode", DbNullOrStringValue(varProjCode))
            command.Parameters.AddWithValue("@programYr", DbNullOrStringValue(varProgYr))
            command.Parameters.AddWithValue("@UserName", DbNullOrStringValue(varUser))
            command.Parameters.AddWithValue("@station", SqlDbType.Int).Value = varStation
            command.Parameters.AddWithValue("@status", SqlDbType.Int).Value = varStatus
            command.Parameters.AddWithValue("@DelivaryMethod", SqlDbType.Int).Value = varDelivaryMethod
            command.Parameters.AddWithValue("@ProgCat", SqlDbType.Int).Value = varProgCat
            command.Parameters.AddWithValue("@ProgSubCat", SqlDbType.Int).Value = varProgSubCat
            command.Parameters.AddWithValue("@projType", SqlDbType.Int).Value = varProjType
            command.Parameters.AddWithValue("@region", SqlDbType.VarChar).Value = varRegion
            command.Parameters.AddWithValue("@NcaDistrict", DbNullOrStringValue(varNcaDistrict))
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
            'the @Result output parameter will be null if the project number already exists.
            'In that case it will not go to the project details page
            If varNewId <> String.Empty Then
                Response.Redirect("~/ProjectDetails.aspx?project_pk=" + varNewId)
            End If

        End Using
    End Sub
    ''' <summary>
    ''' If the user select the region as Cemetery, the dropdownlist for NCA will be visible and the label.
    ''' </summary>
    Protected Sub ddlRegion_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlRegion As DropDownList = CType(fvAddProject.FindControl("ddlRegion"), DropDownList)
        Dim lblNcaDistrict As Label = CType(fvAddProject.FindControl("lblNcaDistrict"), Label)
        Dim ddlNcaDistrict As DropDownList = CType(fvAddProject.FindControl("ddlNcaDistrict"), DropDownList)

        If ddlRegion.SelectedItem.Text = "Cemetery" Then
            lblNcaDistrict.Text = "Select district"
            ddlNcaDistrict.Visible = True
        Else
            lblNcaDistrict.Text = ""
            ddlNcaDistrict.Visible = False
        End If
    End Sub
    ''' <summary>
    ''' Clicking the Exit button will transfer user to the landing page.
    ''' </summary>
    Protected Sub btnCanclProj_Click(sender As Object, e As EventArgs)
        Response.Redirect("Default.aspx")
    End Sub
End Class