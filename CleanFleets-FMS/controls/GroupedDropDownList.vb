

<Assembly: TagPrefix("cleanfleets", "CF")>


Public Class GroupedDropDownList
	Inherits System.Web.UI.WebControls.DropDownList
	Public Const OptionGroupTag As String = "optgroup"
	Private Const OptionTag As String = "option"
	Protected Overrides Sub RenderContents(writer As System.Web.UI.HtmlTextWriter)
		Dim items As ListItemCollection = Me.Items
		Dim count As Integer = items.Count
		Dim tag As String
		Dim optgroupLabel As String
		If count > 0 Then
			Dim flag As Boolean = False
			Dim prevOptGroup As String = Nothing
			For i As Integer = 0 To count - 1
				tag = OptionTag
				optgroupLabel = Nothing
				Dim item As ListItem = items(i)
				If item.Enabled Then
					If item.Attributes IsNot Nothing AndAlso item.Attributes.Count > 0 AndAlso item.Attributes(OptionGroupTag) IsNot Nothing Then
						optgroupLabel = item.Attributes(OptionGroupTag)

						If prevOptGroup <> optgroupLabel Then
							If prevOptGroup IsNot Nothing Then
								writer.WriteEndTag(OptionGroupTag)
							End If
							writer.WriteBeginTag(OptionGroupTag)
							If Not String.IsNullOrEmpty(optgroupLabel) Then
								writer.WriteAttribute("label", optgroupLabel)
							End If
							writer.Write(">"C)
						End If
						item.Attributes.Remove(OptionGroupTag)
						prevOptGroup = optgroupLabel
					Else
						If prevOptGroup IsNot Nothing Then
							writer.WriteEndTag(OptionGroupTag)
						End If
						prevOptGroup = Nothing
					End If

					writer.WriteBeginTag(tag)
					If item.Selected Then
						If flag Then
							Me.VerifyMultiSelect()
						End If
						flag = True
						writer.WriteAttribute("selected", "selected")
					End If
					writer.WriteAttribute("value", item.Value, True)
					If item.Attributes IsNot Nothing AndAlso item.Attributes.Count > 0 Then
						item.Attributes.Render(writer)
					End If
					If optgroupLabel IsNot Nothing Then
						item.Attributes.Add(OptionGroupTag, optgroupLabel)
					End If
					If Me.Page IsNot Nothing Then
						Me.Page.ClientScript.RegisterForEventValidation(Me.UniqueID, item.Value)
					End If

					writer.Write(">"C)
					HttpUtility.HtmlEncode(item.Text, writer)
					writer.WriteEndTag(tag)
					writer.WriteLine()
					If i = count - 1 Then
						If prevOptGroup IsNot Nothing Then
							writer.WriteEndTag(OptionGroupTag)
						End If
					End If
				End If
			Next
		End If
	End Sub

	Protected Overrides Function SaveViewState() As Object
		Dim state As Object() = New Object(Me.Items.Count) {}
		Dim baseState As Object = MyBase.SaveViewState()
		state(0) = baseState
		Dim itemHasAttributes As Boolean = False

		For i As Integer = 0 To Me.Items.Count - 1
			If Me.Items(i).Attributes.Count > 0 Then
				itemHasAttributes = True
				Dim attributes As Object() = New Object(Me.Items(i).Attributes.Count * 2 - 1) {}
				Dim k As Integer = 0

				For Each key As String In Me.Items(i).Attributes.Keys
					attributes(k) = key
					k += 1
					attributes(k) = Me.Items(i).Attributes(key)
					k += 1
				Next
				state(i + 1) = attributes
			End If
		Next

		If itemHasAttributes Then
			Return state
		End If
		Return baseState
	End Function

	Protected Overrides Sub LoadViewState(savedState As Object)
		If savedState Is Nothing Then
			Return
		End If

		If Not (savedState.[GetType]().GetElementType() Is Nothing) AndAlso (savedState.[GetType]().GetElementType().Equals(GetType(Object))) Then
			Dim state As Object() = DirectCast(savedState, Object())
			MyBase.LoadViewState(state(0))

			For i As Integer = 1 To state.Length - 1
				If state(i) IsNot Nothing Then
					Dim attributes As Object() = DirectCast(state(i), Object())
					For k As Integer = 0 To attributes.Length - 1 Step 2
						Me.Items(i - 1).Attributes.Add(attributes(k).ToString(), attributes(k + 1).ToString())
					Next
				End If
			Next
		Else
			MyBase.LoadViewState(savedState)
		End If
	End Sub
End Class


'=======================================================
'Service provided by Telerik (www.telerik.com)
'Conversion powered by NRefactory.
'Twitter: @telerik
'Facebook: facebook.com/telerik
'=======================================================

' (http://stackoverflow.com/questions/130020/dropdownlist-control-with-optgroups-for-asp-net-webforms?lq=1)


