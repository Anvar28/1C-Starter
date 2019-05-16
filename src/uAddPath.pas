unit uAddPath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, programm1c;

type
  TfrmAddPath = class(TForm)
    lbl1: TLabel;
    Label1: TLabel;
    btnSelect: TButton;
    edtName: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    edtPath: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure edtPathExit(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
  private
	  fProgramm:TProgramm;
	  procedure createName();
  public
    { Public declarations }
  end;

function AddPath(): TProgramm;

implementation
uses uConst, uStrings, uString, uSystem;

{$R *.dfm}

function AddPath():TProgramm;
begin
	with TfrmAddPath.Create(nil) do
	try
	    fProgramm := nil;
		if ShowModal = mrOk
		then Result := Programm1Cnew.add(edtName.Text, edtPath.Text)
		else Result := nil;
	finally
		Free;
	end;
end;


procedure TfrmAddPath.FormCreate(Sender: TObject);

  // -----------------------------------------------------------------
  // Поиск файлов exe
  Procedure FindFileExe(Const aDir: String);
  var hwnd : THandle;
	  FindData : WIN32_FIND_DATA;
	  fileName: string;
  Begin
	FindData.dwFileAttributes := 0;
	hwnd := Windows.FindFirstFile(PChar(aDir+'\*.exe'), FindData);
	if hwnd <> INVALID_HANDLE_VALUE
	then begin
	  repeat
		fileName := String(FindData.cFileName);
		edtPath.Items.Add(aDir+fileName);
	  until not Windows.FindNextFile(hwnd, FindData);
	  Windows.FindClose(hwnd);
	end;

  End;

  // -----------------------------------------------------------------
  // Поиск всех подкаталогов в директории aDir
  Procedure FindDirectoryIn(Const aDir: String);
  var hwnd : THandle;
	  FindData : WIN32_FIND_DATA;
  Begin
	FindData.dwFileAttributes := FILE_ATTRIBUTE_DIRECTORY or FILE_ATTRIBUTE_HIDDEN;
	hwnd := Windows.FindFirstFile(PChar(aDir+'*'), FindData);

	if hwnd <> INVALID_HANDLE_VALUE
	then begin
		repeat
			if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0) and
				(String(FindData.cFileName) <> '.') and
				(String(FindData.cFileName) <> '..') and
				(Pos('1c', aDir+FindData.cFileName) > 0)
			then begin
				FindFileExe(aDir+FindData.cFileName+'\');
				FindDirectoryIn(aDir+FindData.cFileName+'\');
			end;
		until not Windows.FindNextFile(hwnd, FindData);
		Windows.FindClose(hwnd);
	end;
  End;

var
    tmp: string;
begin
	// попробуем найти все программы 1С в каталогке programmFiles
	tmp := GetProgramFilesDir(strProgrammFiles86);

	if Length(tmp) = 0
	then tmp := GetProgramFilesDir(strProgrammFiles);
	
	if Length(tmp) <> 0
	then FindDirectoryIn(tmp+'\');
end;

procedure TfrmAddPath.edtPathExit(Sender: TObject);
begin
    createName();
end;

procedure TfrmAddPath.btnOkClick(Sender: TObject);
begin
	if fProgramm = nil
	then
		if Programm1Cnew.getProgrammN(edtName.Text) <> nil
		then begin
			ShowMessage('Программа с таким именем уже есть в списке, измените пожалуйста имя.');
			edtName.SetFocus;
			Exit;
		end;

    ModalResult := mrOk;
end;

procedure TfrmAddPath.btnSelectClick(Sender: TObject);
begin
	edtPath.Text := MySelectFile(edtPath.Text, '1С Предприятие|*.exe');
	createName();
end;

procedure TfrmAddPath.createName;
var
	i, c, i1: Integer;
	str: String;
begin
	if Length(edtName.text) <> 0
	then Exit;

	str := edtPath.Text;

	c := Length(str)-1;
	i := 0;
	i1 := 0;
	while c > 0 do
	begin
		if str[c] = '\'
		then begin
			i := i + 1;

			// запоминаем где первый слеш
			if i = 2
			then i1 := c;

			if i = 3
			then begin
				edtName.Text := Copy(str, c + 1, i1-c-1);
				Exit;
			end;
		end;
		c := c - 1;
	end;
end;

end.
