{自定义的类}
  TMyClass = class(TComponent)
  public
    procedure msg(const str: string);
    function Add(const a,b: Integer): Integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Rtti;

{ MyClass 类的实现 -----------------------------------------------------------}

procedure TMyClass.msg(const str: string);
begin
  MessageDlg(str, mtInformation, [mbYes], 0);
end;

function TMyClass.Add(const a, b: Integer): Integer;
begin
  Result := a + b;
end;

//通过 Rtti 的手段使用 TMyClass 类的方法 --------------------------------------
procedure TForm1.Button1Click(Sender: TObject);
var
  obj: TMyClass;
  t: TRttiType;
  m1,m2: TRttiMethod;
  r: TValue; //TRttiMethod.Invoke 的返回类型
begin
  t := TRttiContext.Create.GetType(TMyClass);

  {获取 TMyClass 类的两个方法}
  m1 := t.GetMethod('msg'); {procedure}
  m2 := t.GetMethod('Add'); {function}

  obj := TMyClass.Create(Self); {调用需要依赖一个已存在的对象}

  {调用 msg 过程}
  m1.Invoke(obj, ['Delphi 2010']); {将弹出信息框}

  {调用 Add 函数}
  r := m2.Invoke(obj, [1, 2]); {其返回值是个 TValue 类型的结构}
  ShowMessage(IntToStr(r.AsInteger)); {3}

  obj.Free;
end;

//通过 Rtti 的手段修改并获取 TMyClass 类的属性 --------------------------------
procedure TForm1.Button2Click(Sender: TObject);
var
  obj: TMyClass;
  t: TRttiType;
  p: TRttiProperty;
  r: TValue;
begin
  obj := TMyClass.Create(Self);

  t := TRttiContext.Create.GetType(TMyClass);

  p := t.GetProperty('Name');
  p.SetValue(obj, 'NewName');

  r := p.GetValue(obj);
  ShowMessage(r.AsString); {NewName}

  obj.Free;
end;

end.
