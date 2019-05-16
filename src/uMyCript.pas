unit uMyCript;

interface

uses CryptoAPI, Base64;

const
	// ��� ������ ��������
	serverKey = '7=&d):U|K3'; //  ���� ���������� ��� ����� � ��������
	SOLT = ':VS@bA9ZhRoPKK?N';  // ���� ����� ��� ���������� ������� ����������� ������
	cKey = 'key';

type
	// ����� ��� ������ � ����������
	TMyCrypt = class
	private
		fKey: string;
		fIdentifikator: string;
		procedure SetKey(const Value: string);
	public
		property Key: string read fKey write SetKey;
		property Identifikator: string read fIdentifikator;
		constructor Create();
		function valid: boolean;
	end;

var
	lic: TMyCrypt;


// ���������� ������ ������
// �� �������� �������������� � UTF ���������� ���� ������ �� ���������
function MyCript(str, key :string):string;

// ���������� ����� md5 � �.�.
function CalcHache(var buf; len: Integer; Method: WORD = HASH_MD5): string;

// �������� ������������ ����� �����  �� ������� ��������
//function CheckKey(key:string):Boolean;

// ��������� ����� �� ������ ��������� ������
function GenerateKey(dataForGenerateKey:string):string;

// ���������� ������ ���������� � �������
function getSysteminfo: String;

implementation
uses  SysUtils, Registry, windows, uConst;

// ------------------------------------------------------------------------------
// ���������� ������ ���������� � �������

function getSysteminfo: String;
const
	KEY_WOW64_64KEY = $0100;
	pathToOSInfo = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion';
	rkInstallDate = 'InstallDate';
	rkProductId = 'ProductId';
	rkSystemRoot = 'SystemRoot';

var
	reg: TRegistry;
	str: String;
begin
	Result := '';
	reg := TRegistry.Create;
	try
		try
			reg.RootKey := HKEY_LOCAL_MACHINE;
			reg.Access := KEY_WOW64_64KEY or KEY_ALL_ACCESS;
			reg.OpenKey(pathToOSInfo,  False);
			str := {reg.ReadString(rkBuildLab) + }IntToStr(reg.ReadInteger(rkInstallDate)) + reg.ReadString(rkProductId) + reg.ReadString(rkSystemRoot);
			//log(str);
			//DONE: ������� ���������� ����������
			Result := EncodeBase64(MyCript(AnsiToUtf8(str),AnsiToUtf8(serverKey)));
		except
			// ���� �������� �������� ������ �� ������� �� winXP � ���������� �������, �� �������� � ��� �����
			// ��� ��������� ������� �� ��������, ��� ���� ������ ��� ����� 64 ���. ���������
			try
				reg.RootKey := HKEY_LOCAL_MACHINE;
				reg.OpenKeyReadOnly(pathToOSInfo);
				str := {reg.ReadString(rkBuildLab) + }IntToStr(reg.ReadInteger(rkInstallDate)) + reg.ReadString(rkProductId) + reg.ReadString(rkSystemRoot);
				//log(str);
				//DONE: ������� ���������� ����������
				Result := EncodeBase64(MyCript(AnsiToUtf8(str),AnsiToUtf8(serverKey)));
			except
				MessageBox(0, '������ ����������� ���������� ������������ �������', '������', 0);
			end;
		end;
	finally
		reg.free;
	end;
end;

// ------------------------------------------------------------------------------
// ���������� ��������� ������
// �� �������� �������������� � UTF ���������� ���� ������ �� ���������
function MyCript(str, key :string):string;
var position, str_len:integer;
    k,b:byte;
begin

    key := CalcHache(key[1], Length(key));
    position := 0;
    str_len := Length(str);
    k := $E7;
    while (position < str_len) do begin
        k := (k shr 1) xor ord(key[position mod 32 + 1]);
        b := ord(str[position + 1]);
        b := b xor k;
        str[position+1] := chr(b);
        Inc(position);
    end;
    Result :=  str;
end;

// ------------------------------------------------------------------------------
// ������� ��� ���������� MD5 � ������ �����
function CalcHache(var buf; len: Integer; Method: WORD = HASH_MD5): string;
begin
    HashBuf(Method, @buf, len, Result);
end;

// �������� ������������ ����� ����� �� ��������
// $key ������ � ������ ������� XXXX-XXXX-XXXX-XXXX
(*function CheckKey(key:string):Boolean;
var temp,h:string;
begin
    key := StringReplace(key, '-', '', [rfReplaceAll]);
    temp := StringReplace(EncodeBase64(AnsiToUtf8(mycript(copy(key, 1, 6), copy(key, 7, 6)))), '+','', [rfReplaceAll] );
    temp := StringReplace(temp, '=','', [rfReplaceAll] );
    temp := StringReplace(temp, '\','', [rfReplaceAll] );
    temp := StringReplace(temp, '/','', [rfReplaceAll] );
    h := UpperCase(copy(temp, Length(temp) - 3, 4));
    Result := copy(key, 13, 4) = h;
end;
*)

// ------------------------------------------------------------------------------
// ��������� �����
function GenerateKey(dataForGenerateKey:string):string;
var charid:string;
    buf, temp, h:string;
begin
    buf := dataForGenerateKey + SOLT;
    charid := UpperCase(CalcHache(buf[1], Length(buf)));
    temp := StringReplace(EncodeBase64(AnsiToUtf8(mycript(copy(charid, 1, 6), copy(charid, 7, 6)))), '+','', [rfReplaceAll] );
    temp := StringReplace(temp, '=','', [rfReplaceAll] );
    temp := StringReplace(temp, '\','', [rfReplaceAll] );
    temp := StringReplace(temp, '/','', [rfReplaceAll] );
    h := UpperCase(copy(temp, length(temp) - 3, 4));
    Result := copy(charid, 1, 4) + '-' + copy(charid, 5, 4) + '-' + copy(charid, 9, 4) + '-' + h;
end;


{ TMyCrypt }

constructor TMyCrypt.Create;
var
	reg: TRegistry;
begin
	// �������� ��������� ����
	fIdentifikator := getSysteminfo;

	// �������� ���� �� �������
	reg := TRegistry.Create;
	try
		try
			Reg.RootKey := HKEY_CURRENT_USER;
			if reg.OpenKey(PathRegistry, True)
			then fKey := reg.ReadString(cKey);
		except
		end;
	finally
		reg.Free;
	end;
end;

procedure TMyCrypt.SetKey(const Value: string);
var
	reg: TRegistry;
begin
	fKey := Value;
	// �������� ���� �� �������
	reg := TRegistry.Create;
	try
		try
			Reg.RootKey := HKEY_CURRENT_USER;
			if reg.OpenKey(PathRegistry, True)
			then reg.WriteString(cKey, fKey);
		except
		end;
	finally
		reg.Free;
	end;
end;

function TMyCrypt.valid: boolean;
begin
	Result :=  fKey = GenerateKey(MyCript(DecodeBase64(fIdentifikator),AnsiToUtf8(serverKey)));
end;
end.

