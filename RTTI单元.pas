uses Rtti,TypInfo;

procedure TForm1.Button1Click(Sender: TObject);
var
  ms: TArray<TRttiMethod>;
  m: TRttiMethod;
  mps: TArray<TRttiParameter>;
  mp: TRttiParameter;
begin
  Memo1.Clear;

  {先获取方法集合, 这里随便使用了 TButton 类}
  ms := TRttiContext.Create.GetType(TButton).GetMethods;
  for m in ms do
  begin
    {方法名称}
    Memo1.Lines.Add('方法名称: ' + m.Name);

    {方法类型: proceedure、function 等}
    Memo1.Lines.Add('方法类型: ' + GetEnumName(TypeInfo(TMethodKind), Ord(m.MethodKind)));

    {方法的返回值类型}
    if Assigned(m.ReturnType) then
      Memo1.Lines.Add('返回值: ' + GetEnumName(TypeInfo(TTypeKind), Ord(m.ReturnType.TypeKind)));

    {方法的参数列表}
    mps := m.GetParameters;
    if Length(mps) > 0 then
    begin
      Memo1.Lines.Add('参数:');
      for mp in mps do Memo1.Lines.Add(mp.ToString);
      //还可以通过 mp.ParamType 获取参数的数据类型
      //还可以通过 mp.Flags 获取参数的修饰符(譬如 var、const 等)
    end;

    Memo1.Lines.Add(EmptyStr);
  end;
end;