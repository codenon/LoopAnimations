Attribute VB_Name = "SetShapeSizePositionVertical"
Sub SetShapeSizePositionVertical()

    Dim mSlide As Slide
    Dim mShape As Shape
    Dim mShapeCount As Single
    Const mSlideShowShapeCount = 1 '����������ʾShape�ĸ���
    
    
    On Error Resume Next
    Err.Clear
    
    Debug.Print "ActiveWindow Width��" & ActiveWindow.Width
    Debug.Print "ActiveWindow Height��" & ActiveWindow.Height
    Debug.Print "ActivePresentation Width��" & ActivePresentation.PageSetup.SlideWidth
    Debug.Print "ActivePresentation Height��" & ActivePresentation.PageSetup.SlideHeight
    Debug.Print "------------------------------------------------------"
    
    Set mSlide = ActiveWindow.View.Slide
    Debug.Print "Active SlideID��" & mSlide.SlideID
    Debug.Print "Active SlideIndex��" & mSlide.SlideIndex
    Debug.Print "Active SlideNumber��" & mSlide.SlideNumber
    
    
    Debug.Print "Active Selection SlideRange.Count��" & ActiveWindow.Selection.SlideRange.Count
    Debug.Print "Active Selection ShapeRange.Count��" & ActiveWindow.Selection.ShapeRange.Count
    Debug.Print "------------------------------------------------------"
    
    If Err <> 0 Then
        MsgBox "Looks like no shape is selected!", vbCritical
        Exit Sub
    End If
    
    
     
    '��ÿһ��Shape���ÿ��ߡ�λ��
    mShapeCount = ActiveWindow.Selection.ShapeRange.Count
    For i = 1 To mShapeCount Step 1
        Set mShape = ActiveWindow.Selection.ShapeRange(i)
        Debug.Print "Shape " & i & " Id��" & mShape.Id & " Name��" & mShape.Name & " Type��" & mShape.Type & " Visible��" & mShape.Visible & " LockAspectRatio��" & mShape.LockAspectRatio
        
        mShape.LockAspectRatio = msoFalse
        
        '���ÿ���
        Debug.Print "Shape " & i & " Before Set Width��" & mShape.Width
        Debug.Print "Shape " & i & " Before Set Height��" & mShape.Height
        
        mShape.Height = ActivePresentation.PageSetup.SlideHeight / mSlideShowShapeCount
        mShape.Width = mShape.Height * 210 / 297 'A4 ratio
        
        
        Debug.Print "Shape " & i & " After Set Width��" & mShape.Width
        Debug.Print "Shape " & i & " After Set Height��" & mShape.Height
        
        
        '����λ��
        Debug.Print "Shape " & i & " Before Set Left��" & mShape.Left
        Debug.Print "Shape " & i & " Before Set Top��" & mShape.Top
        
        mShape.Left = ActivePresentation.PageSetup.SlideWidth - mShape.Width
        mShape.Top = 0
        
        Debug.Print "Shape " & i & " After Set Left��" & mShape.Left
        Debug.Print "Shape " & i & " After Set Top��" & mShape.Top
        
        Debug.Print "------------------------------------------------------"
        
    Next
     
End Sub





