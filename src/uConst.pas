unit uConst;
interface
uses uSystem;
Const

	gVer = '2.2.2';
	gDate = '18.09.2012';

  gCharRelative = '.';
  StRazdelitel = #9;                // Tab ����������� � ������
  CharGroup = #179;                 // ��������� ��� ��� ������ � �����
	gCountPath1C = 8;                 // ���������� ����� � ���������� ��� ������� 1�

  //gNamePath1C : Array [1..gCountPath1C] of string = ('������������� ����', '������', '����������� ����', '8��');

	PathRegistry = 'Software\APXi\Run1C';

  FileNameBase1C80 = '1Cv8.1CD';
	FileNameBase1C77 = '1cv7.md';

	urlSite = 'http://apxi2.pioner-plus.ru';
	url1CrunLic = '/lic/lic.php';
	
	FileNameProperties = 'Init.ini';      // ��� ����� ��������

Type

  // ���� ����������� ��������, 77, 8 ���� �������� ������ �� 
	TTypeProgramm1C = (tp77, tp80);

  TProgramm1C = Record
    TypeProgramm: TTypeProgramm1C;
    Name: string;
    Path: string;
	end;

  // ���� ���
  TTypeBase1C = (tbNone, tb77, tb80);

  // ������ ���������� ����
  PBase = ^TBase;
  TBase = Record
    Group : Boolean;
    Path : String;
		UserName : String;
		UserPass : String;
		ProgrammStart : byte; // ����� ��������� � ������� ����� ���������� ���� 1..gCountPath1C
		StrCmd : string; // ��������� ������ �������, ���� ����������� �� ����� ���� ���������� ������  ����� �����
  end;

	// ������� ���������� ���� � ������������� � �������
  function GetRelativePath(aPath: String): String;
  function GetNotRelativePath(aPath: String): String;

  // ����������� � ������������� ������
  function CryptingPassword(aPass: String): String;
  function EnCryptingPassword(aPass: String): String;

  // ���������� ����� ��� ���� ���������� �� ����� ����. tb77 tb80
  function GetTypeBaseFromPath(aPath: string): TTypeBase1C;

  function CurrentPath(): String;

  function GetProgramFilesDir(dirSystemName:String): string;

var
  // ������ �������� � ���� � ���
	Program1C: array [1..gCountPath1C] of TProgramm1C =
  ((TypeProgramm: tp77; Name: '������������� ����'; Path: ''),
   (TypeProgramm: tp77; Name: '������'; Path: ''),
	 (TypeProgramm: tp77; Name: '����������� ����'; Path: ''),
	 (TypeProgramm: tp80; Name: '8��'; Path: ''),
	 (TypeProgramm: tp80; Name: '8��'; Path: ''),
	 (TypeProgramm: tp80; Name: '8��'; Path: ''),
	 (TypeProgramm: tp80; Name: '8��'; Path: ''),
	 (TypeProgramm: tp80; Name: '8��'; Path: ''));

const
  ProgrammBuch77 = 1;
  ProgrammCalc77 = 2;
  ProgrammTrade77 = 3;
  Programm80 = 4;

implementation
uses SysUtils, Registry, uMyCript, Windows;

function GetProgramFilesDir(dirSystemName:string): string;
var
	reg: TRegistry;
begin
	reg := TRegistry.Create;
	try
		reg.RootKey := HKEY_LOCAL_MACHINE;
		reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion');
		Result := reg.ReadString(dirSystemName);
	finally
		reg.Free;
	end;
end;


function CurrentPath(): String;
begin
    Result := ExtractFilePath(ParamStr(0));
end;

// -----------------------------------------------------------------
function GetTypeBaseFromPath(aPath: string): TTypeBase1C;
begin
  // ���������� ����� ��� ���� ���������� �� ����� ����.
  // ���� �� ���� aPath ������� ���� 1�80 (1Cv8.1CD), ���� �������
  // �� ���������� ��� tb80, ����� ���� 1cv7.md, ���� ������� �� ���������� tb77 ����� tbNone
  if FileExists(aPath+''+FileNameBase1C80)
  then Result := tb80
  else
    if FileExists(aPath+''+FileNameBase1C77)
    then Result := tb77
    else Result := tbNone;
end;

// -----------------------------------------------------------------
// ����������� ���� � �������������
function GetRelativePath(aPath: String): String;
begin
  Result := '';
  if length(aPath)>0
  then begin
    Result := GetNormalPath(aPath);
    if UpCase(aPath[1]) = UpCase(ParamStr(0)[1])
    then Result[1] := gCharRelative;
  end;
end;

// -----------------------------------------------------------------
// �� �������������� ���� ����������� � ����������
function GetNotRelativePath(aPath: String): String;
begin
  Result := '';
  if Length(aPath) > 0
  then begin
    Result := GetNormalPath(aPath);
    if aPath[1] = gCharRelative
    then Result[1] := ParamStr(0)[1];
  end;
end;

// -----------------------------------------------------------------
// ���������� ������
function CryptingPassword(aPass: String): String;
var i, l, t1: byte;
begin
  l := Length(aPass);
  if l <> 0 then begin
    for i := 1 to l do
    begin
      t1 := ord(aPass[i]);
      t1 := t1 xor l;
      aPass[i] := chr(t1);
    end;
    Result := aPass;
  end
  else Result := '';
end;

// -----------------------------------------------------------------
// ����������� ������
function EnCryptingPassword(aPass: String): String;
var i, l, t1: byte;
begin
  l := Length(aPass);
  if l <> 0 then begin
    for i := 1 to l do
    begin
      t1 := ord(aPass[i]);
      t1 := t1 xor l;
      aPass[i] := chr(t1);
		end;
		Result := aPass;
	end
	else Result := '';
end;
end.
