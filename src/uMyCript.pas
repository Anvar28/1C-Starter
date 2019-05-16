unit uMyCript;

interface

uses CryptoAPI, Base64;

const
	// Для работы лицензий
	serverKey = '7=&d):U|K3'; //  ключ шифрования для связи с сервером
	SOLT = ':VS@bA9ZhRoPKK?N';  // соль нужна для усложнения анализа шифрованных данных
	cKey = 'key';

type
	// Класс для работы с лицензиями
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


// шифрование строки ключем
// не забываем предварительно в UTF перегонять чтоб сервер не подавился
function MyCript(str, key :string):string;

// вычисление хешей md5 и т.п.
function CalcHache(var buf; len: Integer; Method: WORD = HASH_MD5): string;

// проверка корректности ввода ключа  на наличие опечатки
//function CheckKey(key:string):Boolean;

// Генерация ключа на основе указанных данных
function GenerateKey(dataForGenerateKey:string):string;

// Возвращает строку информации о системе
function getSysteminfo: String;

implementation
uses  SysUtils, Registry, windows, uConst;

// ------------------------------------------------------------------------------
// Возвращает строку информации о системе

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
			//DONE: сделать шифрование информации
			Result := EncodeBase64(MyCript(AnsiToUtf8(str),AnsiToUtf8(serverKey)));
		except
			// Если пытаемся получить данные из реестра на winXP с урезанными правами, то попадаем в эту ветку
			// тут попробуем сделать по старинке, как было раньше без учета 64 бит. платформы
			try
				reg.RootKey := HKEY_LOCAL_MACHINE;
				reg.OpenKeyReadOnly(pathToOSInfo);
				str := {reg.ReadString(rkBuildLab) + }IntToStr(reg.ReadInteger(rkInstallDate)) + reg.ReadString(rkProductId) + reg.ReadString(rkSystemRoot);
				//log(str);
				//DONE: сделать шифрование информации
				Result := EncodeBase64(MyCript(AnsiToUtf8(str),AnsiToUtf8(serverKey)));
			except
				MessageBox(0, 'Ошибка определения параметров операционной системы', 'Ошибка', 0);
			end;
		end;
	finally
		reg.free;
	end;
end;

// ------------------------------------------------------------------------------
// шифрование строковых данных
// не забываем предварительно в UTF перегонять чтоб сервер не подавился
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
// Функция для вычисления MD5 и прочих хешей
function CalcHache(var buf; len: Integer; Method: WORD = HASH_MD5): string;
begin
    HashBuf(Method, @buf, len, Result);
end;

// Проверка правильности ключа чисто от опечатки
// $key строка с ключем формата XXXX-XXXX-XXXX-XXXX
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
// Генерация ключа
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
	// получаем системную инфу
	fIdentifikator := getSysteminfo;

	// Получаем ключ из реестра
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
	// Получаем ключ из реестра
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

