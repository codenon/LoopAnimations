Attribute VB_Name = "AddLoopAnimationPathUp"
'��Ӵ�ֱ����ѭ������
Sub AddLoopAnimationPathUp()

    Dim mSlide As Slide
    Dim mShape As Shape
    Dim mShapeCount As Single
    Dim mSequence As Sequence
    Dim mEffect As Effect
    
    Const mMotionEffectDuration As Single = 6 'alter this to suit
    Const mSlideShowShapeCount = 1 '����������ʾShape�ĸ�����Shape������ >= mSlideShowShapeCount + 2
    Const mDelayFactor = mSlideShowShapeCount + 1 '����������ʱ�Ͷ����ȴ���ʱ��
    
    
    On Error Resume Next
    Err.Clear
    
    Set mSlide = ActiveWindow.View.Slide
    Set mSequence = mSlide.TimeLine.MainSequence
    
    Debug.Print "Active Selection ShapeRange.Count��" & ActiveWindow.Selection.ShapeRange.Count
    If Err <> 0 Then
        MsgBox "Looks like no shape is selected!", vbCritical
        Exit Sub
    End If
    
     
    '��ÿһ��Shape���·����������ʱ�ȴ�ѭ����������
    mShapeCount = ActiveWindow.Selection.ShapeRange.Count
    For i = 1 To mShapeCount Step 1
        Set mShape = ActiveWindow.Selection.ShapeRange(i)
        Debug.Print "Shape " & i & " Id��" & mShape.Id & " Name��" & mShape.Name & " Type��" & mShape.Type & " Visible��" & mShape.Visible
        
        'ɾ��ѡ��Shapeԭ�ж���
        Dim effectFirst As Effect
        Set effectFirst = mSequence.FindFirstAnimationFor(mShape)
        Do While Not effectFirst Is Nothing
            Debug.Print "Delete MainSequence Effect " & " Index��" & effectFirst.Index & "��Shape Id��" & mShape.Id & "��Shape Name��" & mShape.Name
            effectFirst.Delete
            Set effectFirst = mSequence.FindFirstAnimationFor(mShape)
        Loop
        
        ' ���һ��msoAnimEffectCustom����
        Set mEffect = mSequence.AddEffect(Shape:=mShape, effectId:=msoAnimEffectCustom, Trigger:=msoAnimTriggerWithPrevious, Index:=-1)
       
        With mEffect
            '����Effect ����
            .Exit = msoFalse
            .Timing.SmoothStart = msoFalse
            .Timing.SmoothEnd = msoFalse
            .Timing.RewindAtEnd = msoTrue
            .Timing.RepeatCount = 1000 '-2147483648 û���ҵ����á�ֱ����һ�ε�������ֱ���õ�Ƭĩβ�������÷���
            .Timing.TriggerType = msoAnimTriggerWithPrevious
            .Timing.TriggerDelayTime = (i - 1) * (mMotionEffectDuration / mDelayFactor)
            
            
            '���msoAnimTypeMotion��ֱ����ѭ������
            .Behaviors.Add(msoAnimTypeMotion).MotionEffect.Path = "M 0 1 L 0 -1 E"
            .Behaviors(.Behaviors.Count).Timing.TriggerDelayTime = 0
            .Behaviors(.Behaviors.Count).Timing.Duration = mMotionEffectDuration
            
            '�����ʱ�ȴ�ѭ����������
            .Behaviors.Add(msoAnimTypeSet).SetEffect.Property = msoAnimVisibility
            .Behaviors(.Behaviors.Count).Timing.TriggerDelayTime = .Timing.Duration
            .Behaviors(.Behaviors.Count).Timing.Duration = (mShapeCount - mDelayFactor) * (mMotionEffectDuration / mDelayFactor)
            .Behaviors(.Behaviors.Count).SetEffect.To = 1 ' aShape not hidden use 0 for hidden while delayed
               
        End With
    Next
End Sub
