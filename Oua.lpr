program Oua;

uses
  Forms, Interfaces,
  _Oua_ in '_Oua_.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
