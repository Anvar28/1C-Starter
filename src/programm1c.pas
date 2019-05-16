unit programm1c;

interface
uses Classes;

const
	fileName = 'prg.ini';
	strSeparator = #9;

type

	TProgramm = class
	public
		path: String;
		name: String;
	end;

	TProgramm1Cnew = class
	private
		flist: TStringList;
    function getCount: Integer;
	protected
		function Load(): Boolean;
		function Save(): Boolean;
	public
		constructor Create();
		destructor Destroy();
		function getPath(aName: string): String;
		function setPath(aName: string; aPath: String): String;
		property count: Integer read getCount;
		function getProgrammI(aIndex: Integer):TProgramm;
		function getProgrammN(aName: string):TProgramm;
		function add(aName, aPath: String): TProgramm;
		procedure delete(aName: String);
	end;

var
	Programm1Cnew : TProgramm1Cnew;

implementation
uses uConst, IniFiles, uString;

{ TProgramm1Cnew }

constructor TProgramm1Cnew.Create;
begin
	flist := TStringList.Create;
	Load;
end;

destructor TProgramm1Cnew.Destroy;
begin
	flist.Destroy();
end;

function TProgramm1Cnew.getCount: Integer;
begin
	Result := flist.Count;
end;

function TProgramm1Cnew.getProgrammI(aIndex: Integer): TProgramm;
begin
	Result := flist.Objects[aIndex] as TProgramm;
end;

function TProgramm1Cnew.getPath(aName: string): string;
var
	tmp: TProgramm;
begin
	tmp := getProgrammN(aName);
	if tmp <> nil
	then Result := tmp.path;
end;

function TProgramm1Cnew.getProgrammN(aName: string): TProgramm;
var
	i: Integer;
begin
	i := flist.IndexOf(aName);
	if i >= 0
	then Result := getProgrammI(i)
	else Result := nil;
end;

function TProgramm1Cnew.Load: Boolean;
var
	sl: TStringList;
	i:Integer;
	str: String;
	tmp: TProgramm;
begin
	sl := TStringList.Create;
	try
		try
			sl.LoadFromFile(CurrentPath()+FileName);
			for i := 0 to sl.Count-1 do
			begin
				str := sl.Strings[i];
				tmp := add('', '');
				tmp.name := GetNextSubStr(str, strSeparator);
				tmp.path := GetNextSubStr(str, strSeparator);
			end;
		except
		end;
	finally
	  sl.Free;
	end;
end;

function TProgramm1Cnew.Save: Boolean;
var
	sl: TStringList;
	i:Integer;
	tmp: TProgramm;
begin
	sl := TStringList.Create;
	try
		try
			for i := 0 to flist.Count-1 do
			begin
				tmp := getProgrammI(i);
				sl.Add(tmp.name + strSeparator + tmp.path);
			end;
			sl.SaveToFile(CurrentPath()+FileName);
		except
		end;
	finally
		sl.Free;
	end;
end;

function TProgramm1Cnew.setPath(aName, aPath: String): String;
var
	tmp: TProgramm;
begin
	tmp := getProgrammN(aName);
	if tmp <> nil
	then tmp.path := aPath;
end;

function TProgramm1Cnew.add(aName, aPath: String): TProgramm;
var
	tmp: TProgramm;
begin
	tmp := TProgramm.Create;
	tmp.path := aPath;
	tmp.name := aName;
	flist.AddObject(aName, TObject(tmp));
    Result := tmp;
end;

procedure TProgramm1Cnew.delete(aName: String);
var
	tmp: TProgramm;
	i: Integer;
begin
	i := flist.IndexOf(aName);
	if i >= 0
	then begin
		tmp := getProgrammI(i);
		tmp.Free;
		flist.Delete(i);
	end;
end;

end.
