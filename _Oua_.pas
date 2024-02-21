unit _Oua_;

interface

uses
  LCLIntf, LCLType, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs,
  StdCtrls, Grids, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    buDefault: TButton;
    buProcess: TButton;
    cbNonZero: TCheckBox;
    edDuck: TEdit;
    edGoose: TEdit;
    edHen: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    sgResult: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure buProcessClick(Sender: TObject);
    procedure buDefaultClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  vector = array [1..1000] of integer;

function stringtoreal(t: string): real;
var
  x: real;
  c: integer;
begin
  val(t, x, c);
  if c = 0 then
    stringtoreal := x
  else
    stringtoreal := 0;
end;

function realtostring(x: real): string;
var
  t: string;
begin
  str(x, t);
  realtostring := t;
end;

procedure ouabani(a, b, c, d, e: real; var x, y, z: vector; var n: integer);
var
  i, j: integer;
  xx, yy, zz: real;
begin
  i := 0;
  with form1 do
  begin
    sgResult.Visible := True;
    label5.Visible := True;
    label6.Visible := True;
    label7.Visible := True;
  end;
  if b - c = 0 then
    with form1 do
    begin
      sgResult.Visible := False;
      label5.Visible := False;
      label6.Visible := False;
      label7.Visible := False;
    end
  else
    for j := 0 to trunc(e) do
    begin
      xx := j;
      yy := (d - c * e - (a - c) * xx) / (b - c);
      if (yy >= 0) and (frac(yy) = 0) then
      begin
        zz := e - (xx + yy);
        if (zz >= 0) and (frac(zz) = 0) then
        begin
          Inc(i);
          x[i] := trunc(xx);
          y[i] := trunc(yy);
          z[i] := trunc(zz);
          if (form1.cbNonZero.Checked) and
            ((x[i] = 0) or (y[i] = 0) or (z[i] = 0)) then
            Dec(i);
        end;
      end;
    end;
  n := i;
end;

procedure TForm1.buProcessClick(Sender: TObject);
var
  x, y, z: vector;
  i, n: integer;
begin
  ouabani(stringtoreal(edGoose.Text), stringtoreal(edDuck.Text),
    stringtoreal(edHen.Text), stringtoreal(edit4.Text),
    stringtoreal(edit5.Text), x, y, z, n);
  if n = 0 then
  begin
    sgResult.Visible := False;
    label5.Visible := False;
    label6.Visible := False;
    label7.Visible := False;
    label4.Caption := 'Problema nu are soluție!';
  end
  else
  begin
    sgResult.Visible := True;
    label5.Visible := True;
    label6.Visible := True;
    label7.Visible := True;
    if n = 1 then
      label4.Caption := 'Problema dată are doar o soluție'
    else
      label4.Caption := 'Problema dată are ' + IntToStr(n) + ' soluții';
    sgResult.rowcount := n;
    for i := 1 to n do
    begin
      sgResult.cells[0, pred(i)] := IntToStr(i);
      sgResult.Cells[1, pred(i)] := IntToStr(x[i]);
      sgResult.Cells[2, pred(i)] := IntToStr(y[i]);
      sgResult.Cells[3, pred(i)] := IntToStr(z[i]);
    end;
  end;

end;

procedure TForm1.buDefaultClick(Sender: TObject);
begin
  edGoose.Text := '3';
  edDuck.Text := '2';
  edHen.Text := '0.5';
  edit4.Text := '20';
  edit5.Text := '20';
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  if paramcount = 5 then
  begin
    edGoose.Text := ParamStr(1);
    edDuck.Text := ParamStr(2);
    edHen.Text := ParamStr(3);
    edit4.Text := ParamStr(4);
    edit5.Text := ParamStr(5);
  end;
  buDefaultClick(Sender);
end;

end.
