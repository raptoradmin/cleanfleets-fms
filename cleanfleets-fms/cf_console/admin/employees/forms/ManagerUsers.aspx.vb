
Public Class ManagerUsers
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            BindUserAccounts()

            BindFilteringUI()
        End If
    End Sub

    Private Sub BindFilteringUI()
        Dim filterOptions() As String = {"All", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
        FilteringUI.DataSource = filterOptions
        FilteringUI.DataBind()
    End Sub

    Private Sub BindUserAccounts()
        Dim totalRecords As Integer
        UserAccounts.DataSource = Membership.FindUsersByName(Me.UsernameToMatch + "%", Me.PageIndex, Me.PageSize, totalRecords)
        UserAccounts.DataBind()

        ' Enable/disable the paging interface
        Dim visitingFirstPage As Boolean = (Me.PageIndex = 0)
        lnkFirst.Enabled = Not visitingFirstPage
        lnkPrev.Enabled = Not visitingFirstPage

        Dim lastPageIndex As Integer = (totalRecords - 1) / Me.PageSize
        Dim visitingLastPage As Boolean = (Me.PageIndex >= lastPageIndex)
        lnkNext.Enabled = Not visitingLastPage
        lnkLast.Enabled = Not visitingLastPage
    End Sub

    Protected Sub FilteringUI_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles FilteringUI.ItemCommand
        If e.CommandName = "All" Then
            Me.UsernameToMatch = String.Empty
        Else
            Me.UsernameToMatch = e.CommandName
        End If

        BindUserAccounts()
    End Sub

#Region "Paging Interface Click Event Handlers"
    Protected Sub lnkFirst_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkFirst.Click
        Me.PageIndex = 0
        BindUserAccounts()
    End Sub

    Protected Sub lnkPrev_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkPrev.Click
        Me.PageIndex -= 1
        BindUserAccounts()
    End Sub

    Protected Sub lnkNext_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNext.Click
        Me.PageIndex += 1
        BindUserAccounts()
    End Sub

    Protected Sub lnkLast_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkLast.Click
        ' Determine the total number of records
        Dim totalRecords As Integer
        Membership.FindUsersByName(Me.UsernameToMatch + "%", Me.PageIndex, Me.PageSize, totalRecords)

        ' Navigate to the last page index
        Me.PageIndex = (totalRecords - 1) / Me.PageSize
        BindUserAccounts()
    End Sub
#End Region

#Region "Properties"
    Private Property UsernameToMatch() As String
        Get
            Dim o As Object = ViewState("UsernameToMatch")
            If o Is Nothing Then
                Return String.Empty
            Else
                Return o.ToString()
            End If
        End Get
        Set(ByVal Value As String)
            ViewState("UsernameToMatch") = Value
        End Set
    End Property

    Private Property PageIndex() As Integer
        Get
            Dim o As Object = ViewState("PageIndex")
            If o Is Nothing Then
                Return 0
            Else
                Return Convert.ToInt32(o)
            End If
        End Get
        Set(ByVal Value As Integer)
            ViewState("PageIndex") = Value
        End Set
    End Property

    Private ReadOnly Property PageSize() As Integer
        Get
            Return 10
        End Get
    End Property
#End Region
End Class
