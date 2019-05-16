unit uAddEditBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, uConst, ComCtrls;

type
  TfrmAddEditBase = class(TForm)
    eName: TLabeledEdit;
    btnClose: TButton;
    btnOK: TButton;
    pgc1: TPageControl;
    ts1c: TTabSheet;
    tsCmd: TTabSheet;
    cbGroup: TCheckBox;
    ePath: TLabeledEdit;
    btnSelectPath: TBitBtn;
    Label2: TLabel;
    pnl1c: TPanel;
    l1: TLabel;
    cbUserName: TComboBox;
    eUserPass: TLabeledEdit;
    cbProgrammStart: TComboBox;
    Label1: TLabel;
    Label4: TLabel;
    edtStrCmd: TMemo;
    mmo1: TMemo;
		procedure cbGroupClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnSelectPathClick(Sender: TObject);
		procedure ePathExit(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure FormKeyDown(Sender: TObject; var Key: Word;
			Shift: TShiftState);
		procedure edtStrCmdKeyPress(Sender: TObject; var Key: Char);
    procedure pgc1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
		Results: Boolean;
		fBase: TBase;
	public
		function  Execute(aCaption: String;
                       var aNameBase:String;
                       var aBase: PBase;
                       aEdit: Boolean = false): boolean;
    procedure FillUserList();
		procedure FillProgrammStart();

		procedure visibleComponent();

		procedure ExtractNameBase(aPath: String);

    // �� ���� ���������� ����� ���� ��� ���������� 77 ��� 80
    // � ������������� ������������� ��������� � ������� ������� ����� ����������� ����
    procedure CheckTypeBaseAndSetProgramm(aPath: String);
  end;

{var
  frmAddEditBase: TfrmAddEditBase;  }

function AddBase(var aName: String; var aBase:PBase; const aPath: String=''): Boolean;
function CopyBase(var aName: String; var aBase:PBase): Boolean;
function EditBase(var aName: String; var aBase:PBase): Boolean;

implementation
uses Unit1, uSystem, uString, Math;

{$R *.dfm}

// -----------------------------------------------------------------
function AddBase(var aName: String; var aBase:PBase; const aPath: String): Boolean;
begin
  with TfrmAddEditBase.Create(Application) do
  begin
		ePath.Text := aPath;
		Result := Execute('���� ������ ��������', aName, aBase);
  end;
end;
// -----------------------------------------------------------------
function CopyBase(var aName: String; var aBase:PBase): Boolean;
begin
	with TfrmAddEditBase.Create(Application) do
		Result := Execute('����������� ��������', aName, aBase);
end;
// -----------------------------------------------------------------
// ����������� �������� ������ aBase
function EditBase(var aName: String; var aBase:PBase): Boolean;
begin
  with TfrmAddEditBase.Create(Application) do
		Result := Execute('�������������� ������', aName, aBase, True);
end;

// -----------------------------------------------------------------
procedure TfrmAddEditBase.cbGroupClick(Sender: TObject);
begin
	fBase.Group := cbGroup.Checked;
	visibleComponent();
	eName.SetFocus;
end;

// -----------------------------------------------------------------
// ������� ������� ���� � ���������� ������������� ������������������
// � ����
procedure TfrmAddEditBase.FillUserList;

	// -----------------------------------------------------------------
  // �������������� ������ � ������� �� ��� ��� ������������
  procedure FindUserInStr(aString: String);
  Const FindStr = 'UserItemType';
  var tmpStr: String;
  begin
    aString := Trim(aString);
		if Length(aString)>0
    then begin
      // ������ � ������ ����� ������ (�� �������) ��� �� �����
      // ������� �� ������ ������
      // � ��� 3 ����� ��� ��� ������ ������������
      GetNextSubStr(aString, ',');
      GetNextSubStr(aString, ',');
      tmpStr := GetNextSubStr(aString, ',');
			if Length(Trim(tmpStr)) > 0  then
        cbUserName.Items.Add(tmpStr);
    end;
  end;

Const UsersFile = '\usrdef\users.usr';
      MaxSizeBuff = 512;
      NoAddSimbol : Set of char = ['{', '}', '"'];
      BeginContainer = 'Container';
var fs: TFileStream;
    buff : array [1..MaxSizeBuff] of char;
    i, l, cs, indexContainer: integer;
    tmpStr: String[250];
    fExit, fFindContainer: boolean;
begin
  cbUserName.Items.Clear;

  // ������� ��������� ����� ���� � ��������
  if FileExists(GetNotRelativePath(ePath.Text)+UsersFile)
  then begin
    // �������� ����������� ����� �������������
    fs := TFileStream.Create(GetNotRelativePath(ePath.Text)+UsersFile, fmOpenRead);
    try
      // ���������� ������
      // ���� ����������� ����������� ������ ����� inc(cs),
      // � ���� ����������� ����� dec(cs)
      // ���� ������ 2 ����� ���������� ���������� ������ � tmpStr
      cs := 0;
      tmpStr := '';
      fExit := false;
      fFindContainer := true;  // ���� ���������
      indexContainer := 1;
      repeat
        FillChar(buff, MaxSizeBuff, '0');
        l := fs.Read(buff, MaxSizeBuff);

        i := 1;
        while (i<=l)and(not fExit) do
        begin
          if buff[i] <> #0
          then
            // ������� ������ ���������, �.�. ������ ���������� ������ ������������
            if fFindContainer
            then begin
              if buff[i]=BeginContainer[indexContainer]
              then begin
                if indexContainer = 9
                then fFindContainer := false;

                inc(indexContainer);
              end
              else indexContainer := 1;
            end
            // � ����� ����� ���������� ������ ����� ���� ��� ������ ���������,
            // �� ���� ����� ���������� ����� ����� ���������� ������ �������������
            else begin
              if buff[i]='{'  // ������ ��������� �������� ������� ������ ����� ������ ������ � ������
              then inc(cs)
              else
                // ������ ��������� ������ ����� ������������� ������
                if buff[i]='}'
                then begin
                  FindUserInStr(tmpStr);
                  tmpStr := '';
                  if cs>0 then dec(cs);

                  // ���� ��������� ������ ��������� ����� ��������
                  // ����������� ������ ������ ��� �� ������ ����������
                  // � ���� ����������� ����������� ������, ����� ���������� ����� �� �����
                  // ������� ��������������.
                  if cs <= 0
                  then fExit := true;
                end
                else
                  if (cs>=2) and (not (buff[i] in NoAddSimbol))
                  then tmpStr := tmpStr + buff[i];
            end;
          inc(i);
        end;
      until (l<MaxSizeBuff) or (fExit);
    finally
      fs.Free;
    end;
  end;
end;
// -----------------------------------------------------------------
procedure TfrmAddEditBase.btnCloseClick(Sender: TObject);
begin
  Close;
end;
// -----------------------------------------------------------------
procedure TfrmAddEditBase.btnOKClick(Sender: TObject);
begin
	if Length(Trim(eName.Text))>0
	then begin
		Results := True;
		Close;
	end
  else begin
    MessageBox(handle, '���������� ������ �������� ����', '��������', 0);
		eName.SetFocus;
	end;
end;
// -----------------------------------------------------------------
procedure TfrmAddEditBase.btnSelectPathClick(Sender: TObject);
var
  tmpStr: String;
begin
  if length(Trim(ePath.Text))=0
  then tmpStr := frm1CRun.DefaultPath
  else tmpStr := ePath.Text;

  tmpStr := MySelectDirectory(GetNotRelativePath(tmpStr));

  if frm1CRun.UseRelativePath
  then tmpStr := GetRelativePath(tmpStr);

  ePath.Text := tmpStr;

  ExtractNameBase(tmpStr); // ������� ��� ��������� ���������� ��� ����� ��� ����

  FillUserList();

  CheckTypeBaseAndSetProgramm(tmpStr);
end;
// -----------------------------------------------------------------
procedure TfrmAddEditBase.ePathExit(Sender: TObject);
begin
  ExtractNameBase(ePath.Text);
  FillUserList();
end;
// -----------------------------------------------------------------
procedure TfrmAddEditBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;
// -----------------------------------------------------------------
function TfrmAddEditBase.Execute(aCaption: String;
                                  var aNameBase:String;
                                  var aBase: PBase;
                                  aEdit: Boolean = false): boolean;

	procedure FillControl(aBase: TBase);
	var tmpi: byte;
	begin
		with aBase do
		begin
			ePath.Text := Path;

			cbUserName.Items.Clear;
			cbUserName.Text := UserName;

			eUserPass.Text := UserPass;

			// �������������� ������ ������� �� ������
			with cbProgrammStart do
			begin
				if Items.Count > 0
				then begin
					cbProgrammStart.ItemIndex := 0;
					for tmpi := 0 to Items.Count-1 do
						if byte(Items.Objects[tmpi]) = ProgrammStart
						then begin
							ItemIndex := tmpi;
							Break;
						end;

				end;
			end;
			edtStrCmd.Text := StrCmd;
		end;
  end;

begin
	with TfrmAddEditBase(Self) do
	begin
		Caption := aCaption;
		eName.Text := aNameBase;

		FillProgrammStart();

		if aBase = nil
		then begin
			New(aBase);
			aBase^.Group := false;
			cbProgrammStart.ItemIndex := 0;
		end
		else
			FillControl(aBase^);

		fBase := aBase^;

		cbGroup.Enabled := Not aEdit;

		// �������� ��������� ������������� ��� �������
		visibleComponent();
		FillUserList();

		Results := false;

		ShowModal();

		Result := Results;

    if Result
    then begin
      aNameBase := eName.Text;
      aBase^.Group := cbGroup.Checked;
      aBase^.Path := ePath.Text;

      if Not aBase^.Group
      then begin
        aBase^.UserName := cbUserName.Text;
				aBase^.UserPass := eUserPass.Text;

				if (cbProgrammStart.Items.Count > 0)
				then aBase^.ProgrammStart := byte(cbProgrammStart.Items.Objects[cbProgrammStart.ItemIndex]);

				aBase^.StrCmd := Trim(edtStrCmd.Text);

//        if Program1C[aBase^.ProgrammStart].TypeProgramm = tp77
//        then aBase^.TypeBase := tb77
//        else
//          if Program1C[aBase^.ProgrammStart].TypeProgramm = tp80
//          then aBase^.TypeBase := tb80
//          else aBase^.TypeBase := tbNone;
      end;
    end;
  end;
end;
// -----------------------------------------------------------------
// �������� �� ���� � ���� ��������� ��� ���������� � ���������� ��
// � ������� eName ���� �� �� ������
procedure TfrmAddEditBase.ExtractNameBase(aPath: String);
var
  tmpStr: String;
  i, i2 : integer;
begin
  if Length(trim(eName.Text)) = 0
	then begin
    i := Length(aPath);
    tmpStr := '';
    if i > 0
    then
      repeat
        i2 := i;
        while (i>0) and (aPath[i]<>'\') do
          dec(i);
				tmpStr := Copy(aPath, i+1, i2-i);
        dec(i);
      until (i<=0) or (length(tmpStr)>0);

    eName.Text := tmpStr;
  end;
end;
// -----------------------------------------------------------------
procedure TfrmAddEditBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case key of
    27 : btnClose.Click;
    vk_f4 : btnSelectPath.Click;
  end;
end;
// -----------------------------------------------------------------
procedure TfrmAddEditBase.FillProgrammStart;
var
  i: byte;
  s: string;
begin
  // �������� ������ �������� ��� ������ �������������
  with cbProgrammStart.Items, frm1CRun do
  begin
    for i := 1 to gCountPath1C do
      if Length(Trim(Program1C[i].Path))<>0
      then begin
        if i = IndexProgramm1CDefault
        then s := '�� ��������� '+Program1C[i].Name+' ('+Program1C[i].Path+')'
        else s := Program1C[i].Name+' ('+Program1C[i].Path+')';
        AddObject(s, TObject(i));
      end;
  end;
end;

procedure TfrmAddEditBase.CheckTypeBaseAndSetProgramm(aPath: String);
var
  tmpTypeBase: TTypeBase1C;
  i: integer;
begin
  // DONE: ��������� ������� md ��� ������ 8��, ���� ���� ����� �� 8��, ���������� ��� ������ ���� ��������� 8��
	tmpTypeBase := GetTypeBaseFromPath(GetNotRelativePath(aPath));

	// ������ ���� ���� �� �������� ���������
	if cbProgrammStart.Items.Count = 0
	then Exit;

  // ���� ���� �� 8�� ������ ������� ��������� 8��
  if tmpTypeBase = tb80
  then begin
    for i := 0 to cbProgrammStart.Items.Count-1 do
      if Program1C[byte(cbProgrammStart.Items.Objects[i])].TypeProgramm = tp80
      then begin
        cbProgrammStart.ItemIndex := i;
        exit;
      end;
  end
  // ���� ���� �� 8������, � ��� ������� �������� 8��
  // ���������� ���������, ����� � �������� ����� ������ *.md ��� 77
  // ����� ���������� ���������� ��������� 77 ������� �� ���������
  else
		if (Program1C[byte(cbProgrammStart.Items.Objects[cbProgrammStart.ItemIndex])].TypeProgramm = tp80) and
       (FileExists(aPath+FileNameBase1C77))
    then
      for i := 0 to cbProgrammStart.Items.Count-1 do
        if byte(cbProgrammStart.Items.Objects[i]) = frm1CRun.IndexProgramm1CDefault
        then begin
          cbProgrammStart.ItemIndex := i;
          exit;
        end;
end;

procedure TfrmAddEditBase.visibleComponent;
begin
	if Trim(edtStrCmd.Text) <> ''
	then pgc1.ActivePage := tsCmd
	else pgc1.ActivePage := ts1c;

	if pgc1.ActivePage = ts1c
	then begin
		pnl1c.Visible := not fBase.Group;
		tsCmd.TabVisible := not fBase.Group;
	end;
end;

procedure TfrmAddEditBase.edtStrCmdKeyPress(Sender: TObject;
  var Key: Char);
begin
	if key=#13
	then Key:=#0;
end;

procedure TfrmAddEditBase.pgc1Change(Sender: TObject);
begin
	if pgc1.ActivePage = ts1c
	then ePath.SetFocus
	else edtStrCmd.SetFocus;
end;

procedure TfrmAddEditBase.FormShow(Sender: TObject);
begin
	cbGroup.Checked := fBase.Group;

	if pgc1.ActivePage = ts1c
	then ePath.SetFocus
	else edtStrCmd.SetFocus;
end;

end.
