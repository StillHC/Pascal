// 通过 Rtti 单元的 TRttiContext(是个 record), 可以方便地获取类的方法、属性、字段的列表.

uses Rtti;

//TRttiContext.GetTypes
procedure TForm1.Button1Click(Sender: TObject);
var
  ctx: TRttiContext;
  t: TRttiType;
begin
  Memo1.Clear;
  for t in ctx.GetTypes do Memo1.Lines.Add(t.Name);
end;

//获取 TButton 类的方法
procedure TForm1.Button2Click(Sender: TObject);
var
  ctx: TRttiContext;
  t: TRttiType;
  m: TRttiMethod;
begin
  Memo1.Clear;
  t := ctx.GetType(TButton);
  //for m in t.GetMethods do Memo1.Lines.Add(m.Name);
  for m in t.GetMethods do Memo1.Lines.Add(m.ToString);
end;

//获取 TButton 类的属性
procedure TForm1.Button3Click(Sender: TObject);
var
  ctx: TRttiContext;
  t: TRttiType;
  p: TRttiProperty;
begin
  Memo1.Clear;
  t := ctx.GetType(TButton);
  //for p in t.GetProperties do Memo1.Lines.Add(p.Name);
  for p in t.GetProperties do Memo1.Lines.Add(p.ToString);
end;

//获取 TButton 类的字段
procedure TForm1.Button4Click(Sender: TObject);
var
  ctx: TRttiContext;
  t: TRttiType;
  f: TRttiField;
begin
  Memo1.Clear;
  t := ctx.GetType(TButton);
  //for f in t.GetFields do Memo1.Lines.Add(f.Name);
  for f in t.GetFields do Memo1.Lines.Add(f.ToString);
end;

//获取获取 TButton 类的方法集合、属性集合、字段集合
procedure TForm1.Button5Click(Sender: TObject);
var
  ctx: TRttiContext;
  t: TRttiType;
  ms: TArray<TRttiMethod>;
  ps: TArray<TRttiProperty>;
  fs: TArray<TRttiField>;
begin
  Memo1.Clear;
  t := ctx.GetType(TButton);

  ms := t.GetMethods;
  ps := t.GetProperties;
  fs := t.GetFields;

  Memo1.Lines.Add(Format('%s 类共有 %d 个方法', [t.Name, Length(ms)]));
  Memo1.Lines.Add(Format('%s 类共有 %d 个属性', [t.Name, Length(ps)]));
  Memo1.Lines.Add(Format('%s 类共有 %d 个字段', [t.Name, Length(fs)]));
end;