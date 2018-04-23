'
'{************************************************************************************}
'{                                                                                    }
'{   DO NOT MODIFY THIS FILE!                                                         }
'{                                                                                    }
'{   It will be overwritten without prompting when a new version becomes              }
'{   available. All your changes will be lost.                                        }
'{                                                                                    }
'{   This file contains the default template and is required for the form             }
'{   rendering. Improper modifications may result in incorrect behavior of            }
'{   dialog forms.                                                                    }
'{                                                                                    }
'{************************************************************************************}
'

Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports DevExpress.Web.ASPxHtmlEditor
Imports DevExpress.Web.ASPxHtmlEditor.Localization
Imports DevExpress.Web.ASPxClasses
Imports DevExpress.Web.ASPxEditors

Partial Public Class ImagePropertiesForm
	Inherits HtmlEditorUserControl
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		ckbCreateThumbnail.ClientVisible = Not String.IsNullOrEmpty(HtmlEditor.SettingsImageUpload.UploadImageFolder)
		CreateConstrainProportionsImages()
		Localize()
	End Sub
	Private Sub Localize()
		lblSize.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_Size) & ":"
		cmbSize.Items.Add(ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_OriginalSize), "original")
		cmbSize.Items.Add(ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_CustomSize), "custom")
		cmbSize.SelectedIndex = 0
		lblWidth.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_Width) & ":"
		lblPixelWidth.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_Pixels)
		lblHeight.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_Height) & ":"
		lblPixelHeight.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_Pixels)
		ckbCreateThumbnail.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_CreateThumbnail)
		lblThumbnailFileName.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_NewImageName) & ":"
		txbThumbnailFileName.ValidationSettings.RequiredField.ErrorText = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.RequiredFieldError)
		lblImagePosition.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_Position) & ":"
		cmbImagePosition.Items.Add(ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_PositionLeft), "left")
		cmbImagePosition.Items.Add(ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_PositionCenter), "center")
		cmbImagePosition.Items.Add(ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_PositionRight), "right")
		cmbImagePosition.SelectedIndex = 0
		lblImageDescription.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_Description) & ":"
		ckbWrapTextArroundImage.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.InsertImage_UseFloat)
	End Sub
	Protected Overrides Function GetChildDxEdits() As ASPxEditBase()
		Return New ASPxEditBase() {lblSize, cmbSize, lblWidth, spnWidth, lblPixelWidth, lblHeight, spnHeight, lblPixelHeight, lblImagePosition, cmbImagePosition, lblImageDescription, txbDescription, ckbCreateThumbnail, lblThumbnailFileName, txbThumbnailFileName, ckbWrapTextArroundImage }
	End Function
	Protected Sub CreateConstrainProportionsImages()
		Dim imgTop As New Image()
		HtmlEditor.GetInsertImageDialogConstrainProportionsTop().AssignToControl(imgTop, False)
		cellContarainTop.Controls.Add(imgTop)

		Dim imgBottom As New Image()
		HtmlEditor.GetInsertImageDialogConstrainProportionsBottom().AssignToControl(imgBottom, False)
		cellContarainBottom.Controls.Add(imgBottom)

		Dim imgSwitcherOn As New Image()
		imgSwitcherOn.ID = "imgOn"
		HtmlEditor.GetInsertImageDialogConstrainProportionsMiddleOn().AssignToControl(imgSwitcherOn, False)
		cellContarainSwitcher.Controls.Add(imgSwitcherOn)

		Dim imgSwitcherOff As New Image()
		imgSwitcherOff.ID = "imgOff"
		HtmlEditor.GetInsertImageDialogConstrainProportionsMiddleOff().AssignToControl(imgSwitcherOff, False)
		cellContarainSwitcher.Controls.Add(imgSwitcherOff)

		imgSwitcherOn.Attributes.Add("onclick", "aspxConstrainProportionsSwitchClick(event, '" & imgSwitcherOff.ClientID & "')")
		imgSwitcherOff.Attributes.Add("onclick", "aspxConstrainProportionsSwitchClick(event,'" & imgSwitcherOn.ClientID & "')")
		imgSwitcherOff.Style.Add("display", "none")
	End Sub
End Class
