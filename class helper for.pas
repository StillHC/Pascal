Txxx = class helper for T... {T... 表示已存在的类}
  {可以替换已存在的方法}
  {也可以有新的方法、成员}
end;

//这之后再使用 T... 类及其子孙类时, 都会优先使用 Txxx 的修改.


//TControl 类增加了一个方法, 之后 TControl 及其所有子孙类就都拥有了这个方法

TMyClassHelper = class helper for TControl
    procedure MyMsg;
  end;