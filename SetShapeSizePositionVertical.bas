Attribute VB_Name = "SetShapeSizePositionVertical"
'���ô�ֱ����ѭ��shape�Ŀ�ߺ�λ��
Sub SetShapeSizePositionVertical()

    Dim mSlide As Slide
    Dim mShape As Shape
    Dim mShapeCount As Single
    Const mSlideShowShapeCount = 1 '����������ʾShape�ĸ���
    
    
    On Error Resume Next
    Err.Clear
    
    Set mSlide = ActiveWindow.View.Slide
    Set mSequence = mSlide.TimeLine.MainSequence
    
    Debug.Print "Active Selection ShapeRange.Count��" & ActiveWindow.Selection.ShapeRange.Count
    If Err <> 0 Then
        MsgBox "Looks like no shape is selected!", vbCritical
        Exit Sub
    End If
    
    
     
    '��ÿһ��Shape���ÿ�ߡ�λ��
    mShapeCount = ActiveWindow.Selection.ShapeRange.Count
    For i = 1 To mShapeCount Step 1
        Set mShape = ActiveWindow.Selection.ShapeRange(i)
        Debug.Print "Shape " & i & " Id��" & mShape.Id & " Name��" & mShape.Name & " Type��" & mShape.Type & " Visible��" & mShape.Visible & " LockAspectRatio��" & mShape.LockAspectRatio
        
        mShape.LockAspectRatio = msoFalse
        
        '���ÿ��
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






