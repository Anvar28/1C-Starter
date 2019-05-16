unit uFrmAbout;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, StdCtrls, ExtCtrls, OleCtrls, SHDocVw;

type
  TfrmAbout = class(TForm)
    Button1: TButton;
    Label2: TLabel;
		edtIdentifikator: TEdit;
    edtKey: TEdit;
    Label4: TLabel;
    pnl1: TPanel;
    wb1: TWebBrowser;
    lblValid: TLabel;
		procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtKeyChange(Sender: TObject);
	private
    { Private declarations }
	public
		procedure UpdateValid();
	end;

procedure OpenAbout;

implementation
uses uString, uStrings, uConst, ShellAPI, uMyCript;

{$R *.dfm}

procedure OpenAbout;
begin
  with TfrmAbout.Create(Application) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrmAbout.Button1Click(Sender: TObject);
begin
	Close;
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
var
	str: string;
begin
	edtIdentifikator.Text := lic.Identifikator;
	edtKey.Text := lic.Key;
	str := urlSite+url1CrunLic+'?ver='+gVer+'&ident='+lic.Identifikator;
  //showmessage(str);
	wb1.Navigate(str);
  UpdateValid();
end;

procedure TfrmAbout.UpdateValid;
begin
	if lic.valid
	then begin
		lblValid.Caption := 'Ключ рабочий';
		lblValid.Font.Color := clBlue;
	end
	else begin
		lblValid.Caption := 'Демо режим';
		lblValid.Font.Color := clRed;
	end;
end;

procedure TfrmAbout.edtKeyChange(Sender: TObject);
begin
	lic.Key := edtKey.Text;
  UpdateValid();
end;

end.
