'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated from a template.
'
'     Manual changes to this file may cause unexpected behavior in your application.
'     Manual changes to this file will be overwritten if the code is regenerated.
' </auto-generated>
'------------------------------------------------------------------------------

Imports System
Imports System.Collections.Generic

Partial Public Class Project
    Public Property project_pk As Integer
    Public Property deleted As Nullable(Of Boolean)
    Public Property fms_number As String
    Public Property projectCode As String
    Public Property projectDesc As String
    Public Property cancelDate As Nullable(Of Date)
    Public Property mouDate As Nullable(Of Date)
    Public Property programYear As Nullable(Of Integer)
    Public Property subProjectFlag As Nullable(Of Boolean)
    Public Property legacyProjectCode As String
    Public Property creationDate As Nullable(Of Date)
    Public Property modificationDate As Nullable(Of Date)
    Public Property mainProject_fk As Nullable(Of Integer)
    Public Property station_fk As Nullable(Of Integer)
    Public Property status_fk As Nullable(Of Integer)
    Public Property projectType_fk As Nullable(Of Integer)
    Public Property Category_fk As Nullable(Of Integer)
    Public Property subCategory_fk As Nullable(Of Integer)
    Public Property delegation_fk As Nullable(Of Integer)
    Public Property delivery_method_fk As Nullable(Of Integer)
    Public Property modifyBy As String
    Public Property createdBy As String
    Public Property region As String
    Public Property ncaDistrict_fk As Nullable(Of Integer)
    Public Property longitude As Nullable(Of Double)
    Public Property latitude As Nullable(Of Double)
    Public Property constFundingYear As String
    Public Property designFundingYear As String
    Public Property riskType_FK As Nullable(Of Integer)
    Public Property environmentalOverviewNote As String

End Class
