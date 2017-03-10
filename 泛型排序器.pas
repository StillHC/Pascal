uses Generics.Collections, Generics.Defaults; {必需的泛型单元}

TArray.Sort<Integer>(arr) {它可以有 1个、2个、4个参数, 这里只用了一个参数, 其他是默认参数}

{使用了排序器的默认值排序, 这和忽略这个参数是一样的}
  TArray.Sort<Integer>(arr, TComparer<Integer>.Default);
var
  Comparer: IComparer<Integer>;

  Comparer := TComparer<Integer>.Default;
  TArray.Sort<Integer>(arr, Comparer);



  //如果要倒排序, 可以建立自己的排序器, 下面就是先构建并实现了一个 TMyComparer, 然后调用:
type
  TMyComparer = class(TComparer<Integer>)
  public
    function Compare(const Left, Right: Integer): Integer; override;
  end;

{ TMyComparer }
function TMyComparer.Compare(const Left, Right: Integer): Integer;
begin
  Result := Right - Left;
end;

Comparer := TMyComparer.Create;
TArray.Sort<Integer>(arr, Comparer);


// 也可以用 TComparer<T>.Construct 方法, 通过一个 TComparison 格式的函数构建排序器, 这样简单一些
function MyFunc1(const Left, Right: Integer): Integer;
begin
  Result := Right - Left;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  arr: array of Integer;
  i: Integer;
  Comparer: IComparer<Integer>;
begin
  Randomize;
  for i := 0 to 9 do begin
    SetLength(arr, Length(arr)+1);
    arr[i] := Random(10);
  end;

  Memo1.Clear;
  for i := 0 to Length(arr) - 1 do Memo1.Lines.Add(IntToStr(arr[i]));

  Comparer := TComparer<Integer>.Construct(MyFunc1);
  TArray.Sort<Integer>(arr, Comparer);
  Memo2.Clear;
  for i := 0 to Length(arr) - 1 do Memo2.Lines.Add(IntToStr(arr[i]));
end;


//如果是给自定义类型的元素排序, 只能是自建排序器
type
  TPerson = record
    name: string;
    age: Word;
  end;

function MyFunc2(const Left, Right: TPerson): Integer;
begin
  Result := Left.age - Right.age;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  arr: array of TPerson;
  i: Integer;
  Comparer: IComparer<TPerson>;
begin
  SetLength(arr, 4);
  arr[0].name := 'AA'; arr[0].age := 22;
  arr[1].name := 'BB'; arr[1].age := 33;
  arr[2].name := 'CC'; arr[2].age := 44;
  arr[3].name := 'DD'; arr[3].age := 11;

  Memo1.Clear;
  for i := 0 to Length(arr) - 1 do
    Memo1.Lines.Add(Format('%s : %d', [arr[i].name, arr[i].age]));

  Comparer := TComparer<TPerson>.Construct(MyFunc2);
  TArray.Sort<TPerson>(arr, Comparer);
  Memo2.Clear;
  for i := 0 to Length(arr) - 1 do
    Memo2.Lines.Add(Format('%s : %d', [arr[i].name, arr[i].age]));
end;

// TStringComparer.Ordinal 是官方实现的用于 string 的排序器, 可直接使用.
//但它好像有问题(Delphi 2010 - 14.0.3513.24210), 以后的版本应该能改过来.
procedure TForm1.Button8Click(Sender: TObject);
var
  arr: array of string;
  i: Integer;
begin
  SetLength(arr, 4);
  arr[0] := '222';
  arr[1] := '111';
  arr[2] := 'bbb';
  arr[3] := 'aaa';

  Memo1.Clear;
  for i := 0 to Length(arr) - 1 do Memo1.Lines.Add(arr[i]);

  TArray.Sort<string>(arr, TStringComparer.Ordinal);
  Memo2.Clear;
  for i := 0 to Length(arr) - 1 do Memo2.Lines.Add(arr[i]);
end;


Comparer := TComparer<string>.Construct(MyComparerFunc);
TArray.Sort<string>(arr, Comparer);

Comparer := TComparer<string>.Construct(
    function (const s1,s2: string): Integer
    begin
      Result := CompareText(s2, s1);
    end);
  TArray.Sort<string>(arr, Comparer);