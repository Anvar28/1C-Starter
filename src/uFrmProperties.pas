unit uFrmProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls, ComCtrls, Grids, uApxStringGrid,
  ToolWin;

type
  TfrmProperties = class(TForm)
    btnClose: TButton;
    btnOK: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    p1: TPanel;
    GroupBox1: TGroupBox;
    leUserName: TLabeledEdit;
    leUserPass: TLabeledEdit;
    Label1: TLabel;
    TabSheet3: TTabSheet;
    Panel1: TPanel;
    cbAutoSave: TCheckBox;
    seTimeSave: TSpinEdit;
    Label2: TLabel;
    p2: TPanel;
    cbBtnCloseAsMinimize: TCheckBox;
    cbWarningWhenRemoving: TCheckBox;
    cbCheckPresenceBase: TCheckBox;
    cbUseRelativePath: TCheckBox;
    cbShowWorkUser: TCheckBox;
    cbDelBaseRegistry: TCheckBox;
    Label4: TLabel;
    cbDefaultPath: TComboBox;
    p3: TPanel;
    hk1: THotKey;
    Label5: TLabel;
    hk2: THotKey;
    hk4: THotKey;
    hk5: THotKey;
    hk6: THotKey;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    hk3: THotKey;
    btnSelectPathWork: TButton;
    cbMinimizeAfterStartBase: TCheckBox;
    cbRegisterMD: TCheckBox;
    cbLoadTogetherWindows: TCheckBox;
    cbAutoExpand: TCheckBox;
    TabSheet4: TTabSheet;
    p4: TPanel;
    cbSelectPath: TComboBox;
    cbMinimizeAfterStart: TCheckBox;
    cbSaveBase: TCheckBox;
    sgrdPath1C: TapxStringGrid;
    ToolBar1: TToolBar;
    btnAdd: TToolButton;
    btnDelete: TToolButton;
    procedure ChangeHotKey(Sender: TObject);
    procedure cbAutoSaveClick(Sender: TObject);
    procedure btnSelectPath1CClick(Sender: TObject);
    procedure btnSelectPathWorkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sgrdPath1CDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
	procedure cbSelectPathDropDown(Sender: TObject);
	procedure cbSelectPathCloseUp(Sender: TObject);
	procedure btnAddClick(Sender: TObject);
  private
	procedure fillSgrdPath1C();
  public
  end;

var
  frmProperties: TfrmProperties;

function OpenWindowProperties(): boolean;

implementation
uses Unit1, Registry, uConst, uSystem, uString, Types, programm1c, uAddPath;
{$R *.dfm}
// -----------------------------------------------------------------
function OpenWindowProperties(): boolean;
var reg : TRegistry;
    i : integer;
begin
  frmProperties := TfrmProperties.Create(Application);
  with frmProperties, frm1CRun do
  begin

    //cbRemoveMonopolAfterStart.Checked := RemoveMonopolAfterStart;
    cbBtnCloseAsMinimize.Checked      := BtnCloseAsMinimize;
    cbWarningWhenRemoving.Checked     := WarningWhenRemoving;
    cbCheckPresenceBase.Checked       := CheckPresenceBase;
    cbUseRelativePath.Checked         := UseRelativePath;
    cbShowWorkUser.Checked            := ShowWorkUser;
    cbDelBaseRegistry.Checked         := DelBaseRegistry;
    cbMinimizeAfterStartBase.Checked  := MinimizeAfterStartBase;
    cbMinimizeAfterStart.Checked      := MinimizeAfterStart;
    cbAutoExpand.Checked              := AutoExpandTV;

    cbDefaultPath.Text                := DefaultPath;

    leUserName.Text                   := DefaultUser;
    leUserPass.Text                   := DefaultPassword;

    // ����� ����������
    cbAutoSave.Checked                := AutoSave;
    cbSaveBase.Checked                := fSaveBase;
    seTimeSave.Value                  := Round(TimerSave.Interval / 60000);
    cbAutoSaveClick(cbAutoSave);

    // ������� �������
    hk1.HotKey                        := HotKeys[1, 2];
    hk2.HotKey                        := HotKeys[2, 2];
    hk3.HotKey                        := HotKeys[3, 2];
    hk4.HotKey                        := HotKeys[4, 2];
    hk5.HotKey                        := HotKeys[5, 2];
    hk6.HotKey                        := HotKeys[6, 2];

    // ������ �������������� ��������� �� �������
    reg := TRegistry.Create();
    try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey(PathRegistry, false)
      then begin

        try
          cbRegisterMD.Checked := Reg.ReadBool('RegisterMD');
        except
          cbRegisterMD.Checked := True;
        end;

        Reg.CloseKey;

      end;

      // �������� �� ����������
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      if Reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', false)
      then begin
        try
          cbLoadTogetherWindows.Checked := Reg.ReadString('Run1C')=ParamStr(0);
        except
          cbLoadTogetherWindows.Checked := false;
        end;
        Reg.CloseKey;
      end;

    finally
      reg.Free;
    end;

	fillSgrdPath1C();

    Result := false;

    // ���� ������������ ����� OK ����� ��������� ��� � ����������
    if frmProperties.ShowModal = mrOK
    then begin
	  //RemoveMonopolAfterStart := cbRemoveMonopolAfterStart.Checked;
	  BtnCloseAsMinimize      := cbBtnCloseAsMinimize.Checked;
	  WarningWhenRemoving     := cbWarningWhenRemoving.Checked;
      CheckPresenceBase       := cbCheckPresenceBase.Checked;
      UseRelativePath         := cbUseRelativePath.Checked;
      ShowWorkUser            := cbShowWorkUser.Checked;
      DelBaseRegistry         := cbDelBaseRegistry.Checked;
      MinimizeAfterStartBase  := cbMinimizeAfterStartBase.Checked;
      MinimizeAfterStart      := cbMinimizeAfterStart.Checked;
      AutoExpandTV            := cbAutoExpand.Checked;

      DefaultPath             := cbDefaultPath.Text;

      DefaultUser             := leUserName.Text;
      DefaultPassword         := leUserPass.Text;

      // ����� ����������
      AutoSave                := cbAutoSave.Checked;
      fSaveBase               := cbSaveBase.Checked;
      TimerSave.Enabled       := AutoSave;
      TimerSave.Interval      := seTimeSave.Value * 60000;

	  // �������� �������������� ��������� � ������
	  reg := TRegistry.Create();
      try
		try
		  Reg.RootKey := HKEY_CURRENT_USER;
		  if Reg.OpenKey(PathRegistry, true)
		  then begin
			try
			  Reg.WriteBool('RegisterMD', cbRegisterMD.Checked);
			except
			end;

            Reg.CloseKey;
          end;
		except
        end;

		// ������������ ���������� �� ����� �����������
		try
		  Reg.RootKey := HKEY_CLASSES_ROOT;
		  if cbRegisterMD.Checked
		  then begin
			Reg.OpenKey('\.md', true);
			Reg.WriteString('', 'Run1C');
			Reg.CloseKey;
			Reg.OpenKey('\Run1C', true);
			Reg.WriteString('', '���� ����������');
			Reg.CloseKey;
			Reg.OpenKey('\Run1C\Shell\Open\Command', true);
			Reg.WriteString('', Application.ExeName + ' "%1"');
			Reg.CloseKey;
			Reg.OpenKey('\Run1C\DefaultIcon', true);
			Reg.WriteString('', Application.ExeName + ', 1');
		  end
		  else begin
			Reg.OpenKey('\.md', true);
			Reg.WriteString('', '');
		  end;
		  Reg.CloseKey;
        except
        end;

        // ������������� � ����������
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        if Reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', false)
        then begin
          try
            if cbLoadTogetherWindows.Checked
            then Reg.WriteString('Run1C', ParamStr(0))
            else Reg.DeleteValue('Run1C');     // �������� �� �����������
          except
          end;
          Reg.CloseKey;
        end;
      finally
        reg.Free;
      end;

      Result := true;

      SetHotKeys(hk1.HotKey,
                 hk2.HotKey,
                 hk3.HotKey,
                 hk4.HotKey,
                 hk5.HotKey,
                 hk6.HotKey);
    end;
  end;
  frmProperties.Free;
end;
// -----------------------------------------------------------------
procedure TfrmProperties.ChangeHotKey(Sender: TObject);
var CurrentHK: THotKey;

  // -----------------------------------------------------------------
  // �������� THotKey
  // ���� ������� ������� ����� ����� ������ � ����� �� ������� �������
  procedure CheckHotKey(var CheckHK: THotKey);
  begin
    if CurrentHK.Tag <> CheckHK.Tag
    then
      if CurrentHK.HotKey = CheckHK.HotKey
      then CheckHK.HotKey := 0;
  end;

begin
  CurrentHK := THotKey(Sender);
  CheckHotKey(hk1);
  CheckHotKey(hk2);
  CheckHotKey(hk3);
  CheckHotKey(hk4);
  CheckHotKey(hk5);
  CheckHotKey(hk6);
end;
// -----------------------------------------------------------------
procedure TfrmProperties.cbAutoSaveClick(Sender: TObject);
begin
  seTimeSave.Enabled := cbAutoSave.Checked;
end;
// -----------------------------------------------------------------
procedure TfrmProperties.btnSelectPath1CClick(Sender: TObject);
begin
  {cbPath1C.Text := MySelectFile(cbPath1C.Text, '���� ������� 1� (*.exe)|*.exe');
  AddStringListSHD(cbPath1C.Items, cbPath1C.Text);}
end;
// -----------------------------------------------------------------
procedure TfrmProperties.btnSelectPathWorkClick(Sender: TObject);
begin
  cbDefaultPath.Text := MySelectDirectory(cbDefaultPath.Text);
  if frm1CRun.UseRelativePath
  then cbDefaultPath.Text := GetRelativePath(cbDefaultPath.Text);
  AddStringListSHD(cbDefaultPath.Items, cbDefaultPath.Text);
end;
// -----------------------------------------------------------------
procedure TfrmProperties.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;
//-----------------------------------------------------------------
procedure TfrmProperties.sgrdPath1CDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var uState: integer;
begin
  with TStringGrid(Sender) do
    if (aCol = 1) and (aRow > 0)
    then begin

      Canvas.Brush.Color := clBtnFace;
      Canvas.FillRect(Rect);

      with Rect do
      begin
        Left := Left + 3;
        Top := Top + 3;
        Right := Right - 3;
        Bottom := Bottom - 3;
      end;

      uState := DFCS_BUTTONRADIO;
      if Cells[aCol, aRow] = '*'
      then uState := uState or DFCS_CHECKED;
      DrawFrameControl(Canvas.Handle, Rect, DFC_BUTTON, uState)
    end;
end;

//-----------------------------------------------------------------
// ��� ��������� ������ �������� ��� ������ �� ������� � �������
// ������ ��� ������ ������� ����
procedure TfrmProperties.cbSelectPathDropDown(Sender: TObject);
const PathRegistry = '\SOFTWARE\1C\1Cv7\7.7\';
var reg: TRegistry;
    ts: TStringList;
    i, j: integer;
    tmpStr: String;
begin
  with cbSelectPath.Items do
  begin
    Clear;
    // ������� ����� ��� ������ ��������� � ������� �������
    Add('������ ...');
    // ������ ���� � ������������� ���������� 1�
    // � ���� �� ���� � ������ cbPath1C ������� ����
    reg := TRegistry.Create;
    try
      reg.RootKey := HKEY_LOCAL_MACHINE;
      if reg.OpenKey(PathRegistry, false)
      then begin
        ts := TStringList.Create;
        try
          reg.GetKeyNames(ts);                // ������� ������ ��������� �������������

          for i := 0 to ts.Count-1 do         // �������� �� ���� ��������� �����������
            if reg.OpenKey(PathRegistry+ts.Strings[i], false)
            then
              try
                tmpStr := reg.ReadString('1CPath');  // � ��������� ������� ������ '1CPath'
                if length(Trim(tmpStr))>0
                then begin
                  j := IndexOf(tmpStr);
                  if j = -1
                  then Add(tmpStr);
                end;
              except
              end;
        finally
          ts.Free;
        end;
      end;
    finally
      reg.Free;
    end;
  end;
end;

//-----------------------------------------------------------------
procedure TfrmProperties.cbSelectPathCloseUp(Sender: TObject);
var str: string;
begin
  with cbSelectPath do
    if ItemIndex = 0
    then begin
      if Items.Count>1
      then str := Items.Strings[1]
      else str := '';
      str := MySelectFile(str, '1� �����������|*.exe');

      Items.Clear;
      Items.Add(str);
      ItemIndex := 0;
    end;
end;

procedure TfrmProperties.btnAddClick(Sender: TObject);
var
	tmp: TProgramm;
begin
	tmp := AddPath();
	if tmp <> nil
	then fillSgrdPath1C();
end;

procedure TfrmProperties.fillSgrdPath1C;
var
    i: Integer;
begin
	// ��������� ������� �����
	with sgrdPath1C do
	begin
		RowCount := Programm1Cnew.count+1;
		if RowCount > 1
		then FixedRows := 1;
		
		for i := 0 to Programm1Cnew.count-1 do
		begin
			with Programm1Cnew.getProgrammI(i) do
			begin
				Cells[2, i+1] := Path;
				Cells[0, i+1] := Name;
			end;
		end;
	end;
end;

end.
