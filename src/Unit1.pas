{$I Def.Inc}

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ToolWin, ComCtrls, StdCtrls, ActnList, Buttons,
  ImgList, uConst, Menus, uMinimizeForm, UapxPopupMenu;

const
  WM_NotifyRestoreWindow = WM_USER + 124;

type
  Tfrm1CRun = class(TForm)
    ActionList1: TActionList;
    aStartEnterprise: TAction;
    aStartConfig: TAction;
    aStartDebug: TAction;
    aStartMonitor: TAction;
    aNewElement: TAction;
    aCopyElement: TAction;
    aEditElement: TAction;
    aDelElement: TAction;
    p2: TPanel;
    btnStartEnterprise: TBitBtn;
    btnStartConfig: TBitBtn;
    btnStartDebug: TBitBtn;
    btnStartMonitor: TBitBtn;
    btnNewElement: TBitBtn;
    btnCopyElement: TBitBtn;
    btnEditElement: TBitBtn;
		btnDelElement: TBitBtn;
    pTreeViewMemo: TPanel;
    cbeStartMode: TComboBoxEx;
    cbSelectUser: TCheckBox;
    l1: TLabel;
    btnBaseDown: TBitBtn;
    btnBaseUp: TBitBtn;
    btnSort: TBitBtn;
    btnOpenExplorer: TBitBtn;
    eFind: TComboBox;
    btnFindDown: TBitBtn;
    btnFindUp: TBitBtn;
    ImageList: TImageList;
    mDescription: TMemo;
    Splitter1: TSplitter;
    TreeView1: TTreeView;
    StatusBar1: TStatusBar;
    btnProperties: TBitBtn;
    btnExit: TBitBtn;
    aScanDisk: TAction;
    aDeleteIndex: TAction;
    aOpenExplorer: TAction;
    aSortBase: TAction;
    aBaseUp: TAction;
    aBaseDown: TAction;
    MinimizeForm1: TMinimizeForm;
    TimerSave: TTimer;
    pSplit: TPanel;
    btnAbout: TBitBtn;
    aScanReg: TAction;
    btnScanDisk: TBitBtn;
    BitBtn2: TBitBtn;
    btnStartEnterpriseMonopol: TBitBtn;
		aStartEnterpriseMonopol: TAction;
    aStartCmd: TAction;
    btnStartCmd: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnPropertiesClick(Sender: TObject);
    procedure aStartExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnExitClick(Sender: TObject);
    procedure TreeView1DblClick(Sender: TObject);
    procedure aNewElementExecute(Sender: TObject);
    procedure aCopyElementExecute(Sender: TObject);
    procedure aEditElementExecute(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure aDelElementExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TreeView1Expanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
    procedure SetPictureExpandeCollapsed(Sender: TObject; Node: TTreeNode);
    procedure pSplitClick(Sender: TObject);
    procedure TimerSaveTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure aScanDiskExecute(Sender: TObject);
    procedure aDeleteIndexExecute(Sender: TObject);
    procedure aOpenExplorerExecute(Sender: TObject);
    procedure aSortBaseExecute(Sender: TObject);
    procedure btnBaseUpClick(Sender: TObject);
    procedure btnBaseDownClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure eFindExit(Sender: TObject);
    procedure eFindKeyPress(Sender: TObject; var Key: Char);
    procedure TreeView1Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeView1DragDrop(Sender, Source: TObject; X, Y: Integer);
		procedure TreeView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure MinimizeForm1RightClickIconTray(Sender: TObject);
    procedure TreeView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure WMNotifyRestore(Var msg:Tmessage);message WM_NotifyRestoreWindow;
    procedure WMCopyData(Var msg:Tmessage);message WM_CopyData;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAboutClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TreeView1KeyPress(Sender: TObject; var Key: Char);
    procedure cbeStartModeChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fShowBtnCaption: boolean;            // ���������� ������� � �������
    //fRemoveMonopolAfterStart: boolean;   // ������� ������ "����������" ����� �������
    fBtnCloseAsMinimize: boolean;        // ������ ������� �������� ��� ��������������
    fWarningWhenRemoving: boolean;       // ������������� ��� ��������
    fDelBaseRegistry: boolean;           // ������� ���� �� ������� ��� �������� �� ������
    fCheckPresenceBase: boolean;         // �������� ������� ���
    fUseRelativePath: boolean;           // ������������ ������������� ����
    fShowWorkUser: boolean;              // ���������� ���������� �������������
    fMinimizeAfterStartBase: boolean;    // ���������������� ����� ������� ����
    fMinimizeAfterStart: boolean;        // ���������������� ��� �������

    FirstStart: boolean;

    procedure SetShowBtnCaption(const Value: Boolean);
    procedure WMHotKey(Var Msg : TWMHotKey); message WM_HOTKEY;
    function GetLoadDescriptionBase: boolean;
    function GetAutoExpandTV: boolean;
    procedure SetAutoExpandTV(const Value: boolean);
  public
    //Path1C : String;
		IndexProgramm1CDefault: integer;  // ������ ��������� ������������� �� ���������, ���� � ����� �� �������� ���������� ���������
	DefaultPath : String;

    //Path1Cm: array [1..gCountPath1C] of string;

    DefaultUser : String;
    DefaultPassword : String;

    AutoSave: Boolean;
    fSaveBase: boolean;         // ��������� ���� 
    fExit: Boolean;

    BeginNode: TTreeNode;
    ActiveScanDisk: boolean;
    ActiveDelIndex: boolean;

    // ��������� ������  ������� ��������� �����, ����� ��� ���� ����� ���
    // ������ ����� �����, ���� ���� ���������, �� ������������� ������ cbeStartMode
    // � �� ��������� � ��������� ����� ����������� ������ ������� 1�
    OldProgrammStart: integer;
    
    StartMode77: integer;       // ������ �������� � ComboBox  cbeStartMode ��� ��� ������ 77
    StartMode80: integer;       // ������ �������� � ComboBox  cbeStartMode ��� ��� ������ 80

    // ������ 1��� � ���������� �����
    procedure StartSelectBase(aMode: byte=255);
    // ������ 1�-�� � ���������� ����� � ������ ������
		procedure StartBase(aBase: PBase; aMode: byte);

		procedure StartCmd(strCmd: string);

    // �������� ��������
    procedure LoadProperties;
		// ���������� ����� � ������
    procedure SaveProperties;

    // �������� ����� � ������
    procedure LoadFileBase;
    // ���������� ����� � ������
    procedure SaveFileBase;

    // �������� �������� ������
    function CreateTreeNode(Const aParent: TTreeNode;
                             Const aText: String;
                             aBase: PBase;
                             Const aSetPicture: boolean = false): TTreeNode;
    // �������� ������ ���� � ����� CreateTreeNode
    function CreateBaseNode(Const aParent: TTreeNode;
                             Const aText: String;
                             Const aPath: String;
                             Const aGroup: Boolean;
                             const ProgrammStart: integer;
                             Const aUserName: String = '';
                             Const aUserPass: String = '';
                             Const aSetPicture: boolean = true):TTreeNode;

    // ���������� ���������� ������� ���� ��� ������, � ���� ���
    // ����� �������� ����� ��������
    function GetParentNodeGroup(aNode: TTreeNode): TTreeNode;
    // ���� ��� � GetParentNodeGroup ������ ��� �������� ��������
    function GetParentNodeGroupSelectNode(): TTreeNode;

    // �������� ���������
    procedure DeleteNode(aNode: TTreeNode);

    // ���������� ������ ��������
		procedure UpdateStatusBar(aNode: TTreeNode);
		// ���������� ������ �������� ������� �����
		procedure UpdateStatusBarSelectNode();

    // ���������� �������� ��������
    function SetPictireNode(aNode: TTreeNode): TTreeNode;

    // ��������� ������ �� TreeView
    procedure SetFocusTreeView;

    // ��������� ������� ������
    // ���������� ����� �������� ������� ���������� ����������.
    procedure SetHotKeys(NewHKRestore,
                         NewHKStartEnterprise,
                         NewHKStartEnterpriseM,
                         NewHKStartConfig,
                         NewHKStartDebug,
                         NewHKStartMonitor: integer
                         );

    // ���������� �������� � ������
    // ���������� �������� ����� ��� ��������� � � ����� ����������� �������
    Function AddMdInTreeView(const aDir: String; const BeginNode: TTreeNode; ProgrammStart: integer): TTreeNode;

    // ����� ����� �� ���� � ����
    // ���� ����� �� �������, ���������� ���������� ����� � ������� AddMdInTreeView
    procedure FindTreeNodeUnderPathOrCreate(aPath: string);

    // ���������� ��� ��� ������� � �������
    property ShowBtnCaption : Boolean
      read fShowBtnCaption write SetShowBtnCaption;

    // ������� ���� "����������" ����� ������� �����������
		//property RemoveMonopolAfterStart : boolean
    //  read fRemoveMonopolAfterStart write fRemoveMonopolAfterStart;

    // ������ ������� �������� ��� "��������������"
    property BtnCloseAsMinimize : boolean
      read fBtnCloseAsMinimize write fBtnCloseAsMinimize;

    // ������������� ��� ��������
    property WarningWhenRemoving : boolean
      read fWarningWhenRemoving write fWarningWhenRemoving;

    // ������� ���� �� ������� ��� �������� �� ������
    property DelBaseRegistry: boolean
      read fDelBaseRegistry write fDelBaseRegistry;

    // �������� ������� ���
    property CheckPresenceBase: boolean
      read fCheckPresenceBase write fCheckPresenceBase;

    // ������������ ������������� ����
    property UseRelativePath: boolean
      read fUseRelativePath write fUseRelativePath;

    // ���������� ���������� �������������
    property ShowWorkUser: boolean
      read fShowWorkUser write fShowWorkUser;

    // ���������������� ����� ������� ����
    property MinimizeAfterStartBase: boolean
      read fMinimizeAfterStartBase write fMinimizeAfterStartBase;

    // ��������� ��� ��� ���� �������� ������������
    property LoadDescriptionBase: boolean
			read GetLoadDescriptionBase;

    // �������������� ���������� ����� �� ������ �� ���
    property AutoExpandTV: boolean
      read GetAutoExpandTV write SetAutoExpandTV;

    // ���������������� ��� ������
    property MinimizeAfterStart: boolean
      read fMinimizeAfterStart write fMinimizeAfterStart;

    // ��������� �������� � ���������� �������� ������
    procedure LoadDescriptionBaseFile();
    procedure SaveDescriptionBaseFile();

    // ��������� ComboBox CbeStartMode ���������� ������� ������ ��� ���������� ����
    procedure FillCbeStartMode(aNode: TTreeNode);

  end;

var
  frm1CRun: Tfrm1CRun;
  // ���� ������� ������
  HotKeys : Array [1..6, 1..2] of word = ((101, 0),
                                          (102, 0),
                                          (103, 0),
                                          (104, 0),
                                          (105, 0),
                                          (106, 0));


implementation
uses Registry, IniFiles, uSystem, uString, uFrmProperties, uAddEditBase, uStrings, uFrmAbout,
	ListActns, ShellAPI, StrUtils, uMyCript, DateUtils, programm1c;
// -----------------------------------------------------------------
Const
	ModeStart : Array [0..3, 1..2] of string = (('�����������', 'enterprise'),
                                              ('������������', 'config'),
                                              ('��������', 'debug'),
                                              ('�������', 'monitor'));

	mCaption : Array [0..4] of string = ('�����', '����������', '�������������', '�������', '����������');

	captionCmd = '���������';

  WidthBtnShowCaption = 110;
  WidthBtnNonShowCaption = 25;

  // ����� ������
  FileNameBase = 'Bases.txt';
  FileNameBaseBack = 'Bases.bkp';
  FileDecriptionBase = 'DescBase.txt';  // ��� ����� �������� ���

  // ����� �������
  // ���� ��� ����� ������������ � ���� � �����
  RegTitles = 'SOFTWARE\1C\1Cv7\7.7\Titles';

  // ������ � ��� �����
  SecInterface = 'Position'; // ����������, ��� ������ ������� �� ����� ��� ������ ���������
  Sec1SProgs = '1S';
  SecOptions = 'Options';
  SecVer = 'Version';
  SecProgramm = 'programm';

  // ������ ��������
	numPicGroup = 8;
  numPicOpenGroup = 9;
	numPicElement = 10;
	numPicNoElement = 11;

	numPicElement80 = 18;
	numPicNoElement80 = 19;
	numPicCmd = 20;
	numPic1C = 0;
{$R *.dfm}
// -----------------------------------------------------------------
procedure Tfrm1CRun.FormCreate(Sender: TObject);
var Base: PBase;
begin
(*  {$IFDEF DEMO}
  Caption := Format(strCaption, [gVer, gDate])+' �� 31.05.2006';
  {$ELSE}
  Caption := Format(strCaption, [gVer, gDate]);
  {$ENDIF}*)
  Caption := Format(strCaption, [gVer, gDate]);

  fExit := false;
  ActiveScanDisk := false;

  cbeStartMode.ItemIndex := -1;
  OldProgrammStart := -1;

  btnStartEnterprise.Hint := ModeStart[0, 1];
  btnStartConfig.Hint := ModeStart[1, 1];
  btnStartDebug.Hint := ModeStart[2, 1];
  btnStartMonitor.Hint := ModeStart[3, 1];
  btnStartEnterpriseMonopol.Hint := mCaption[4];

  ShowBtnCaption := true;

  New(Base);
  Base^.Group := true;
  BeginNode := SetPictireNode(TreeView1.Items.AddObject(nil, '����', Base));

	IndexProgramm1CDefault := -1;

	lic := TMyCrypt.Create;

	Programm1Cnew := TProgramm1Cnew.Create;

	LoadProperties;

  LoadFileBase;

  // DONE: � ��� ���� ��� ���������, � ������ �������� ��� ���� � ����
  if ParamCount > 0
  then FindTreeNodeUnderPathOrCreate(ExtractFilePath(ParamStr(1)));

  // ������ �� ������ ��� ��������� ���������� ����������� ����������
  OnShow := FormShow;
  FirstStart := true;

	// � ��� ��������� ��������
	if not lic.valid
	then btnAbout.Click;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.SetShowBtnCaption(const Value: Boolean);

  // -----------------------------------------------------------------
  // ��������� ������� �������
  procedure SetPropertyBtn(var aBtn : TBitBtn; const aCaption: String;
             const aWidth: integer);
  begin
    with aBtn do
    begin
      Caption := aCaption;
      Width := aWidth;
    end;
  end;

begin
  if fShowBtnCaption <> Value
  then begin
    fShowBtnCaption := Value;
    if fShowBtnCaption
		then begin
			SetPropertyBtn(btnStartEnterprise, ModeStart[0, 1], WidthBtnShowCaption);
      SetPropertyBtn(btnStartConfig,     ModeStart[1, 1], WidthBtnShowCaption);
      SetPropertyBtn(btnStartDebug,      ModeStart[2, 1], WidthBtnShowCaption);
      SetPropertyBtn(btnStartMonitor,    ModeStart[3, 1], WidthBtnShowCaption);
      SetPropertyBtn(btnStartEnterpriseMonopol, mCaption[4], WidthBtnShowCaption);

      SetPropertyBtn(btnNewElement,      mCaption[0], WidthBtnShowCaption);
      SetPropertyBtn(btnCopyElement,     mCaption[1], WidthBtnShowCaption);
      SetPropertyBtn(btnEditElement,     mCaption[2], WidthBtnShowCaption);
      SetPropertyBtn(btnDelElement,      mCaption[3], WidthBtnShowCaption);

      p2.Left := ClientWidth - 116;
      p2.Width := WidthBtnShowCaption;
    end
    else begin
      SetPropertyBtn(btnStartEnterprise, '', WidthBtnNonShowCaption);
      SetPropertyBtn(btnStartConfig,     '', WidthBtnNonShowCaption);
      SetPropertyBtn(btnStartDebug,      '', WidthBtnNonShowCaption);
      SetPropertyBtn(btnStartMonitor,    '', WidthBtnNonShowCaption);
      SetPropertyBtn(btnStartEnterpriseMonopol, '', WidthBtnNonShowCaption);

      SetPropertyBtn(btnNewElement,      '', WidthBtnNonShowCaption);
      SetPropertyBtn(btnCopyElement,     '', WidthBtnNonShowCaption);
      SetPropertyBtn(btnEditElement,     '', WidthBtnNonShowCaption);
      SetPropertyBtn(btnDelElement,      '', WidthBtnNonShowCaption);

      p2.Left := ClientWidth - 31;
      p2.Width := WidthBtnNonShowCaption;
    end;

    pSplit.Left := p2.Left - 6;
    btnFindUp.Left := p2.Left - 32;
    btnFindDown.Left := p2.Left - 58;
    eFind.Width := btnFindDown.Left - eFind.Left - 1;

    pTreeViewMemo.Width := ClientWidth - p2.Width - 18;
  end;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.StartBase(aBase: PBase; aMode: byte);

  // -----------------------------------------------------------------
  // ���� � ������� HKEY_CURRENT_USER\Software\1C\1Cv7\7.7\Titles
  // ���������� � ������ aPath
  procedure CheckAssignTitleAndCreate(const aPath: string);
  var reg: TRegistry;
  begin
    reg := TRegistry.Create;
    try
      reg.RootKey := HKEY_CURRENT_USER;
      if reg.OpenKey('\Software\1C\1Cv7\7.7\Titles\', false)
      then begin
        if not reg.ValueExists(aPath)
        then reg.WriteString(aPath, ReplaceCharFunc(aPath, '\', ' '));
      end;
    finally
      reg.Free;
    end;
  end;

  // --------------------------------------------------------------
  // �������� ������� ��������� ������ cdx
  // ����� ������  ��� � sql �������� �������� ����
  Function CheckMonopolStart(aPath: String): Boolean;
  var sr: TSearchRec;
  Begin
    Result := false;

    // ����� sql ������, ��� ������� ���� ���� dds
    if FindFirst(aPath+'*.dds', faAnyFile, sr) <> 0
    then
      // ��� �� sql, ����� �������� �������
      if FindFirst(aPath+'*.cdx', faAnyFile, sr) <> 0
      then Result := True;

    FindClose(sr);
  End;

  // --------------------------------------------------------------
  // ������������ ����� ������� 1� �� ��� ������ 77;
  // ���������� 0 ���� ��� ������
  function FormatStringStarting1C77(aBase: TBase; aMode: byte; var CommandLine: string): longint;
  var
    PathBase: string;
  begin
    result := 1;

    PathBase := GetNotRelativePath(aBase.Path);

    // �������� ������� ���� �� ����� ����
    if not FileExists(GetNormalPath(PathBase) + FileNameBase1C77) and (aMode <> 1)
    then begin
      ShowMessage('������� ���� ������ �� ���������.' + #13 + PathBase);
      exit;
    end;

    // ���� ���� �� ������� ����� ������� � �������
    // DONE: ��������� �� ������� �������� � �������
    CheckAssignTitleAndCreate(PathBase);

    // ��������� ������ �������
    if aMode = 4 // ���� ���������� �����
    then begin
      CommandLine := ModeStart[0, 2];
      CommandLine := CommandLine + ' /m';
    end
    else begin
      CommandLine := ModeStart[aMode, 2];
      // �������� ���� �� ����������� ����������.
      if (aMode = 0) and (CheckMonopolStart(PathBase))
      then
          // 25/03/05
          // ������� ����� ������ Cancel � ������� ��������� ����������
          case MessageBox(Handle, '����������� ��������� �����. ��������� ����������?', '����������', MB_YESNOCANCEL) of
            IDYES: CommandLine := CommandLine + ' /m';
            IDCANCEL: Exit;
          end;
    end;

    CommandLine := ' ' + CommandLine + ' /d "' + PathBase+'"';

    // ����� ������������� ������������ ������� ������� �
    // ������� ��� � �� ������
    if not cbSelectUser.Checked then
    begin
      if Length(aBase.UserName) > 0
      then
        With aBase do
        begin
          CommandLine := CommandLine + ' /n "' + UserName + '"';
          if Length(UserPass) > 0 then
            CommandLine := CommandLine + ' /p "' + UserPass + '"';
        end
      else // ���������� ������������ �� ���������
        if Length(DefaultUser) > 0
        then begin
          CommandLine := CommandLine + ' /n "' + DefaultUser + '"';
          if Length(DefaultPassword) > 0 then
            CommandLine := CommandLine + ' /p "' + DefaultPassword + '"';
        end;
    end;

    result := 0;
  end;

  // --------------------------------------------------------------
  // ������������ ����� ������� 1� �� ��� ������ 80;
  // ���������� 0 ���� ��� ������
  function FormatStringStarting1C80(aBase: TBase; aMode: byte; var CommandLine: string): longint;
  var
    PathBase: string;
  begin
    result := 1;

    PathBase := GetNotRelativePath(aBase.Path);

    // �������� ������� ���� �� ����� ����
    if not DirectoryExists(GetNormalPath(PathBase))
    then begin
      ShowMessage('������� ���� ������ �� ���������.' + #13 + PathBase);
      exit;
    end;

    CommandLine := ModeStart[aMode, 2];

    CommandLine := ' ' + CommandLine + ' /f "' + PathBase+'"';

    // ����� ������������� ������������ ������� ������� �
    // ������� ��� � �� ������
    if not cbSelectUser.Checked then
    begin
      if Length(aBase.UserName) > 0
      then
        With aBase do
        begin
          CommandLine := CommandLine + ' /n "' + UserName + '"';
          if Length(UserPass) > 0 then
            CommandLine := CommandLine + ' /p "' + UserPass + '"';
        end
      else // ���������� ������������ �� ���������
        if Length(DefaultUser) > 0
        then begin
          CommandLine := CommandLine + ' /n "' + DefaultUser + '"';
          if Length(DefaultPassword) > 0 then
            CommandLine := CommandLine + ' /p "' + DefaultPassword + '"';
        end;
    end;

    result := 0;
  end;

Var StartUpInfo: TStartUpInfo;
		Processlnfo: TProcessInformation;
		Error: longint;
    CommandLine, Path1CStart: String;
    IndexProgramm: integer;
begin

	// ���������� ������� ���� ������ ������ �������
	if (not lic.valid) and (Odd(MinuteOf(Now)))
	then btnAbout.Click;

	If aBase = nil then Exit;

	if Length(Trim(aBase^.StrCmd)) > 0
	then begin
		StartCmd(aBase^.StrCmd);
		Exit;
	end;

	If aBase^.Group then exit; // ������ �� �����������

  IndexProgramm := aBase^.ProgrammStart;

  if (IndexProgramm<1) and (IndexProgramm>4)
  then IndexProgramm := IndexProgramm1CDefault;

  Path1CStart := Program1C[IndexProgramm].Path;

  // � ����������� �� ��������� ��������� ��������� ��������� �������
  case IndexProgramm of

    ProgrammBuch77, ProgrammCalc77, ProgrammTrade77:
      Error := FormatStringStarting1C77(aBase^, aMode, CommandLine);

    Programm80:
      Error := FormatStringStarting1C80(aBase^, aMode, CommandLine);

  else
    Error := 1;
    ShowMessage('��� ������ ���� �� �������� ��������� �������');
  end;

//  ShowMessage(Path1CStart+' '+CommandLine);
//  exit;
//
  if Error = 0
	then begin
		FillChar(StartUpInfo, Sizeof(StartUpInfo), #0);
		with StartUpInfo do
		begin
			cb := SizeOf(TStartupInfo);
			dwFlags := STARTF_USESHOWWINDOW;
			wShowWindow := SW_NORMAL;
		end;

		if not CreateProcess(PChar(Path1CStart),
												 PChar(CommandLine),
												 nil, nil, False,
												 NORMAL_PRIORITY_CLASS, nil,
												 nil, StartUpInfo,
												 Processlnfo)
		then begin
			Error := GetLastError;
			case Error of
				0: ; // ��� � �������
				2, 3: begin  // ����� �����������
								if not FileExists(Path1CStart)
								then ShowMessage('����������� ������ ���� � ��������� 1�.');
							end;
				5: ; // ����� ������������� 1�
			else
				ShowMessage('������ ������� �'+IntToStr(Error) + '  ' + SysErrorMessage(Error));
			end;
		end
    else
      if MinimizeAfterStartBase
      then MinimizeForm1.MinimizedToSystemTray
      else SetFocusTreeView();
  end;

end;
// -----------------------------------------------------------------
// ����� 1� �� � ��������� �����
procedure Tfrm1CRun.StartSelectBase(aMode: byte=255);
begin
  // ��������� � ����� ������ ���������
  if (aMode = 255) and (cbeStartMode.Items.Count > 0)
	then aMode := byte(cbeStartMode.ItemsEx[cbeStartMode.ItemIndex].Data);

  if TreeView1.Selected <> nil then
    StartBase(PBase(TreeView1.Selected.Data), aMode);
end;
// -----------------------------------------------------------------
// �������� ����� � ������
procedure Tfrm1CRun.LoadFileBase;

  // -----------------------------------------------------------------
  // ���������� ���������� StRazdelitel + 1 � ������ ������
  function GetRecordLevel(aStr: String): integer;
  var i: integer;
  begin
    i := 1;
    while (i<Length(aStr)) and (aStr[i] = StRazdelitel) do inc(i);
    Result := i;
  end;

  // -----------------------------------------------------------------
  // ��������� ������ � ������� � ������� �������� ��������
  function DecodeRecordAndCreate(aParent: TTreeNode; aStr: String): TTreeNode;
  var NameNode: String;
      Base: PBase;
      tmpStr: string;
  begin
    Result := nil;
    if aParent <> nil
    then begin
      aStr := Trim(aStr);
      NameNode := GetNextSubStr(aStr, StRazdelitel);

      New(Base);
      if NameNode[Length(NameNode)] = CharGroup
      then begin
        Base.Group := True;
        Delete(NameNode, Length(NameNode), 1);
      end
      else Base.Group := false;

      Base.Path := GetNextSubStr(aStr, StRazdelitel);
      Base.UserName := GetNextSubStr(aStr, StRazdelitel);
      Base.UserPass := EnCryptingPassword(GetNextSubStr(aStr, StRazdelitel));

      // ���� ��� ���� 8�� ������ ���� ��������� ��������� ������� �� ������� Program1C = Programm80
      if Base.Group
      then Base.ProgrammStart := 255
      else begin
        if GetTypeBaseFromPath(GetNotRelativePath(Base.Path)) = tb80
        then Base.ProgrammStart := Programm80
        else begin

          Base.ProgrammStart := 0;

          // ��������� ��� ��������� ��� �������
					tmpStr := GetNextSubStr(aStr, StRazdelitel);
					if Length(Trim(tmpStr)) > 0
					then begin
						try
							Base.ProgrammStart := Byte(StrToInt(tmpStr));
						except
							Base.ProgrammStart := IndexProgramm1CDefault;
						end;
					end;

					Base.StrCmd := GetNextSubStr(aStr, StRazdelitel);

        end;
      end;

      if (Base.ProgrammStart <= 0) or (Base.ProgrammStart > gCountPath1C)
      then Base.ProgrammStart := IndexProgramm1CDefault;

			Result := CreateTreeNode(aParent, NameNode, Base, false);
      if Result = nil then Dispose(Base);
    end;
  end;

  // -----------------------------------------------------------------
  //  ���� � �������� aNode ������ �� ������ aLevel
  function FindParentNode(aNode: TTreeNode; aLevel: integer): TTreeNode;
  begin
    while aNode.Level <> aLevel-1 do
      aNode := aNode.Parent;
    Result := aNode;
  end;

var f: TextFile;
    tmpStr: String;
    RecordLevel, CurrentLevel: integer;
    ParentNode : TTreeNode;
begin
  // ���� ����� ���� � ������ ����� ��������
  tmpStr := ExtractFilePath(ParamStr(0))+FileNameBase;
  if FileExists(tmpStr)
  then begin
    try
      AssignFile(f, tmpStr);
      Reset(f);

      ParentNode := BeginNode;
      while Not Eof(f) do
      begin
        Readln(f, tmpStr);

        // DONE: 26/11/05
        // ���������� �������� �� ������ ������
        if Length(Trim(tmpStr)) <> 0
        then begin
          RecordLevel := GetRecordLevel(tmpStr);
          CurrentLevel := ParentNode.Level;

          // �������� ����������� ������ ��� �� ��� � � ������� ������
          if RecordLevel = CurrentLevel
          then ParentNode := DecodeRecordAndCreate(ParentNode.Parent, tmpStr)
          else
            // ��������� �������� ������ �������� ������� �������
            if RecordLevel - 1 =  CurrentLevel
            then ParentNode := DecodeRecordAndCreate(ParentNode, tmpStr)
            else
              // ��������� �������� ����� �� ������� ��������, ��� ���� �����
              if RecordLevel < CurrentLevel
              then ParentNode := DecodeRecordAndCreate(FindParentNode(ParentNode, RecordLevel), tmpStr)
              // ����� ���� �������� RecordLevel-1 > CurrentLevel
              else Exit;
        end;
      end;
    finally
      CloseFile(f);
    end;
  end;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.LoadProperties;
var reg: TRegistry;
    ini : TIniFile;
    Ver: String;
    tmpI: integer;
begin
  // �������� �� ��� �����
  ini := TIniFile.Create(ExtractFilePath(ParamStr(0))+FileNameProperties);
  reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  try
    // ���������� ��������� ������ ���������������� ���������, ����
    // ���� ������������� 1-� ������ ����� ���������� ��������� ��������� ��������� �� �����
    Ver := ini.ReadString(SecVer, strVer, gVer)[1];

    // ������ ������, ��������� ��������� ����� �������� � �����, �������� �� ������
    // ��� ����� ������� ���������� ������ ��� ������ ������� ���������
    // � �������� ��� ������ ������ ������.
    if Ver = '1'
    then begin
      Width := ini.ReadInteger(SecInterface, strWidth, 491);
      Height := ini.ReadInteger(SecInterface, strHeight, 334);
      Top := ini.ReadInteger(SecInterface, strTop, (Screen.Height - Height) div 2);
      Left := ini.ReadInteger(SecInterface, strLeft, (Screen.Width - Width) div 2);

      // ������ ��� ������, ��� ������ ����� ��������� � �������
      ini.EraseSection(SecInterface);
      ini.EraseSection('FindMD'); // ������ ������ �� ����� frmFindMD
      ini.DeleteKey(Sec1SProgs, strDefaultPathBase);  // ������ �������������� ��������

      // ��� ������ ����� ����������, �� ����� ���������� ��������������
      AutoSave := ini.ReadBool(SecOptions, strOnOffTimeSave, true);
      ini.DeleteKey(SecOptions, strOnOffTimeSave);

      // �������� ������� �������
      HotKeys[1, 2] := ini.ReadInteger(SecOptions, strHotKey, VK_SNAPSHOT);
      ini.DeleteKey(SecOptions, strHotKey);

      if Reg.OpenKey(PathRegistry, false)
      then begin
        try
          DefaultPath := Reg.ReadString(strDefaultPathBase);
          Reg.DeleteValue(strDefaultPathBase);
        except
        end;

        Reg.CloseKey;
      end
      else DefaultPath := '.:\Work\';
    end

    // ������ ������, �������� ���� �� ������ �� �������
    else begin
      try
        Reg.OpenKey(PathRegistry, false);

        Width   := reg.ReadInteger(strWidth);
        Height  := reg.ReadInteger(strHeight);
        Top     := reg.ReadInteger(strTop);
        Left    := reg.ReadInteger(strLeft);

        DefaultPath := Reg.ReadString(strDefaultPath);
        
        IndexProgramm1CDefault := reg.ReadInteger(strIndexProgramm1CDefault);

        if (IndexProgramm1CDefault <=0) or (IndexProgramm1CDefault > gCountPath1C)
        then IndexProgramm1CDefault := 1;

      except
        // ���� ��������� ������ ��� ��������,
        // ����� ��������� ������ �� ���������
        Width   := 491;
        Height  := 334;
        Left    := (Screen.Width - Width) div 2;
        Top     := (Screen.Height - Height) div 2;

        DefaultPath := '.:\Work\';
        IndexProgramm1CDefault := 1;
      end;

      // �������� ���� � ���������� 1� �� �������
      for tmpI := 1 to gCountPath1C do
        try
          Program1C[tmpI].Path := reg.ReadString(strPath1c+IntToStr(tmpI));
        except
        end;

      // todo: ���� ��������� ���� �� ���������

      // ��������� ����
      try
        fSaveBase := reg.ReadBool(strSaveBase);
      except
        fSaveBase := true;
      end;

      Reg.CloseKey;

      AutoSave := ini.ReadBool(SecOptions, strAutoSave, true);

      SetHotKeys(ini.ReadInteger(SecOptions, strhkRestore, VK_SNAPSHOT),
                 ini.ReadInteger(SecOptions, strhkStartEnterprise, 16433),
                 ini.ReadInteger(SecOptions, strhkStartEnterpriseM, 16434),
                 ini.ReadInteger(SecOptions, strhkStartConfig, 16435),
                 ini.ReadInteger(SecOptions, strhkStartDebug, 16436),
                 ini.ReadInteger(SecOptions, strhkStartMonitor, 16437));
    end;

    tmpI := ini.ReadInteger(SecOptions, strTimeSave, 10);
    if tmpI > 60 then tmpI := 60;
    if tmpI < 5 then tmpI := 5;
    TimerSave.Interval := tmpI * 60000;
    TimerSave.Enabled := AutoSave;

    //RemoveMonopolAfterStart   := ini.ReadBool(SecOptions, strRemoveMonopolAfterStart, true);
    BtnCloseAsMinimize        := ini.ReadBool(SecOptions, strCloseMinimize, true);
    WarningWhenRemoving       := ini.ReadBool(SecOptions, strConfirmUnderDelete, true);
    CheckPresenceBase         := ini.ReadBool(SecOptions, strOnCheckExistencesBase, true);
    UseRelativePath           := ini.ReadBool(SecOptions, strRelativePath, true);
    ShowWorkUser              := ini.ReadBool(SecOptions, strShowWorkingUser, true);
    DelBaseRegistry           := ini.ReadBool(Sec1SProgs, strDelBaseInRegistry, true);
    MinimizeAfterStartBase    := ini.ReadBool(SecOptions, strMinimizeAfterStartBase, false);
    MinimizeAfterStart        := ini.ReadBool(SecOptions, strMinimizeAfterStart, false);
    ShowBtnCaption            := ini.ReadBool(SecOptions, strShowBtnCaption, true);
    AutoExpandTV              := ini.ReadBool(SecOptions, strAutoExpandTV, true);

    // ������������ � ������ �� ���������
    DefaultUser               := ini.ReadString(SecOptions, strDefaultUser, '');
    // DONE: ����������� ������
    DefaultPassword           := EnCryptingPassword(ini.ReadString(SecOptions, strDefaultPassword, ''));

    cbSelectUser.Checked      := not ini.ReadBool(SecOptions, strUseUser, true);

    try
      StartMode77             := ini.ReadInteger(SecOptions, strStartMode, 0);
      StartMode80             := ini.ReadInteger(SecOptions, strStartMode8, 0);
    except
      StartMode77             := 0;
      StartMode80             := 0;
    end;

    mDescription.Height       := ini.ReadInteger(SecOptions, strHeightDescription, 20);
  finally
    ini.Free;
    reg.Free;
  end;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.SaveFileBase;

  // ------------------------------------------------------------
  // ������� ������ � ����������� ����������� ������������ (�����)
  Function ReturnTab(Level:Byte):String;
  Var St:String;
  Begin
    St := '';
    While Level > 0 Do
    Begin
      St := St + StRazdelitel;
      Dec(Level);
    End;
		Result := St;
  End;

  // ------------------------------------------------------------
  // ������������� ��� PBASE � ������
  Function PBaseToString(aNode : TTreeNode):String;
  Begin
    Result := aNode.Text;
    with PBase(aNode.Data)^ do
    begin
      If Group Then
        Result := Result + CharGroup + StRazdelitel + Path
      Else
				 If (Path <> '') or (StrCmd <> '') then
            Result := Result +
                      StRazdelitel +
                      Path +
                      StRazdelitel +
                      UserName +
                      StRazdelitel +
                      CryptingPassword(UserPass) +
											StRazdelitel +
											IntToStr(ProgrammStart) +
											StRazdelitel +
											StrCmd;
    end;
  End;

const
  tmpFileName = 'Bases.tmp';
var
  Path: string;
  FullNameBackFile, tmpBackFile, FullNameBaseFile: String;
  F : System.Text;
  CountElem, NomElem: integer;
begin
  // ���� ��������� ������ ��� ������, ����� � �� �����
  if not fSaveBase
  then Exit;

  // DONE: ���������� ����� � ������
  // ������ ������ ����� ����� � ������
  try
    // 25/05/2007
    // ��� �� ��� ����� ����� �� ���� ����������

{    // DONE: 27/11/05
    // �����������: ������ ��� ���������� ����� � ������
    // ������� ������ ����� ���� ����������������� � Bases.tmp (�� ������ ������)
    // ����� ���� � ������ Bases.txt ����������������� � Bases.bkp
    // ��������� ����� ���� Bases.txt � ������ ����� ��������� ���� Bases.tmp

    // ������� ����������� ����� ����
    tmpBackFile      := ExtractFilePath(ParamStr(0));
    FullNameBackFile := tmpBackFile + FileNameBaseBack;
    tmpBackFile      := tmpBackFile + tmpFileName;
    FullNameBaseFile := tmpBackFile + FileNameBase;    }

    Path := ExtractFilePath(ParamStr(0));
    tmpBackFile := Path+tmpFileName;
    FullNameBackFile := Path + FileNameBaseBack;
    FullNameBaseFile := Path + FileNameBase;

    if FileExists(FullNameBackFile)
    then RenameFile(PChar(FullNameBackFile), PChar(tmpBackFile));

    // ������ ����������� ���� � ������ � �����
    RenameFile(PChar(FullNameBaseFile), PChar(FullNameBackFile));

    // �������� ����� ���� � ������
    AssignFile(F, PChar(FullNameBaseFile));
    Rewrite(F);
    with TreeView1.Items do
    begin
      CountElem := Count-1;
      for NomElem := 1 to CountElem do
        Writeln(F, ReturnTab(Item[NomElem].Level-1) + PBaseToString(Item[NomElem]));
    end;
    CloseFile(F);

    // ������ ������ ������ ����� ����
    if FileExists(tmpBackFile)
    then DeleteFile(tmpBackFile);
  except
  end;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.SaveProperties;
var reg: TRegistry;
    ini : TIniFile;
    tmpI: integer;
begin
  reg := TRegistry.Create;
  ini := TIniFile.Create(ExtractFilePath(ParamStr(0))+FileNameProperties);
  try
    reg.RootKey := HKEY_CURRENT_USER;
    try
      if reg.OpenKey(PathRegistry, true)
      then begin
        if WindowState = wsNormal
        then begin
          reg.WriteInteger(strWidth, Width);
          reg.WriteInteger(strHeight, Height);
          reg.WriteInteger(strTop, Top);
          reg.WriteInteger(strLeft, Left);
        end;

        reg.WriteInteger(strIndexProgramm1CDefault, IndexProgramm1CDefault);
        reg.WriteString(strDefaultPath, DefaultPath);

        // �������� ���� � ���������� 1� � ������
        for tmpI := 1 to gCountPath1C do
          reg.WriteString(strPath1c+IntToStr(tmpI), Program1C[tmpI].Path);

        reg.WriteBool(strSaveBase, fSaveBase);

        reg.CloseKey;
      end;
    except
    end;

    try
      ini.WriteBool(SecOptions, strAutoSave, AutoSave);
      ini.WriteInteger(SecOptions, strTimeSave, Round(TimerSave.Interval/60000));

      ini.WriteInteger(SecOptions, strhkRestore, HotKeys[1, 2]);
      ini.WriteInteger(SecOptions, strhkStartEnterprise, HotKeys[2, 2]);
      ini.WriteInteger(SecOptions, strhkStartEnterpriseM, HotKeys[3, 2]);
      ini.WriteInteger(SecOptions, strhkStartConfig, HotKeys[4, 2]);
      ini.WriteInteger(SecOptions, strhkStartDebug, HotKeys[5, 2]);
      ini.WriteInteger(SecOptions, strhkStartMonitor, HotKeys[6, 2]);

      //ini.WriteBool(SecOptions, strRemoveMonopolAfterStart, RemoveMonopolAfterStart);
      ini.WriteBool(SecOptions, strCloseMinimize, BtnCloseAsMinimize);
      ini.WriteBool(SecOptions, strConfirmUnderDelete, WarningWhenRemoving);
      ini.WriteBool(SecOptions, strOnCheckExistencesBase, CheckPresenceBase);
      ini.WriteBool(SecOptions, strRelativePath, UseRelativePath);
      ini.WriteBool(SecOptions, strShowWorkingUser, ShowWorkUser);
      ini.WriteBool(Sec1SProgs, strDelBaseInRegistry, DelBaseRegistry);
      ini.WriteBool(SecOptions, strMinimizeAfterStartBase, MinimizeAfterStartBase);
      ini.WriteBool(SecOptions, strMinimizeAfterStart, MinimizeAfterStart);
      ini.WriteBool(SecOptions, strShowBtnCaption, ShowBtnCaption);
      ini.WriteBool(SecOptions, strAutoExpandTV, AutoExpandTV);

      ini.WriteString(SecOptions, strDefaultUser, DefaultUser);
      ini.WriteString(SecOptions, strDefaultPassword, CryptingPassword(DefaultPassword));
      ini.WriteBool(SecOptions, strUseUser, not cbSelectUser.Checked);
      ini.WriteInteger(SecOptions, strStartMode, StartMode77);
      ini.WriteInteger(SecOptions, strStartMode8, StartMode80);
      ini.WriteInteger(SecOptions, strHeightDescription, mDescription.Height);

      ini.WriteString(SecVer, 'Ver', gVer);
    except
    end;
  finally
    reg.Free;
    ini.Free;
  end;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.btnPropertiesClick(Sender: TObject);
begin
  if OpenWindowProperties
  then SaveProperties;
  SetFocusTreeView();
end;
// -----------------------------------------------------------------
function Tfrm1CRun.CreateBaseNode(Const aParent: TTreeNode;
  const aText, aPath: String; const aGroup: Boolean; const ProgrammStart: integer;
  const aUserName, aUserPass: String; Const aSetPicture: boolean): TTreeNode;
var tmp: PBase;
begin
  New(tmp);

  tmp.Group := aGroup;
  tmp.Path := aPath;
  tmp.UserName := aUserName;
  tmp.UserPass := aUserPass;
  tmp.ProgrammStart := ProgrammStart;

  Result := CreateTreeNode(aParent, aText, tmp, aSetPicture);

  if Result = nil then Dispose(tmp);
end;
// -----------------------------------------------------------------
function Tfrm1CRun.CreateTreeNode(Const aParent: TTreeNode;
  Const aText: String; aBase: PBase; Const aSetPicture: boolean = false): TTreeNode;
begin
	// ���������� ��������� ������� ���� ��������
  if (aParent<>nil) and (aParent.Data <> nil) and (PBase(aParent.Data)^.Group) and (aBase<>nil)
  then begin
    Result := TreeView1.Items.AddChildObject(aParent, aText, aBase);

    // ���������� ��� �� ���������� ������������� ����
    if UseRelativePath
    then aBase.Path := GetRelativePath(aBase.Path)
    else aBase.Path := GetNotRelativePath(aBase.Path);

    if aSetPicture
		then SetPictireNode(Result);
	end
  else Result := nil;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.aStartExecute(Sender: TObject);
begin
	StartSelectBase((Sender as TAction).Tag);
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  SaveProperties;
  SaveFileBase;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.btnExitClick(Sender: TObject);
begin
  fExit := True;
  ActiveScanDisk := false;
  ActiveDelIndex := false;
  Close;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.TreeView1DblClick(Sender: TObject);
var p: TPoint;
    tmpNode: TTreeNode;
begin
  GetCursorPos(p);
  p := TreeView1.ScreenToClient(p);
  tmpNode := TreeView1.GetNodeAt(p.X, p.Y);
  if tmpNode <> nil
  then begin
    TreeView1.Selected := tmpNode;
    StartSelectBase();
  end;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.aNewElementExecute(Sender: TObject);
var NameNode: String;
    BaseNode: PBase;
    tmpPath : String;
    tmpTreeNode: TTreeNode;
begin
  BaseNode := nil;
  NameNode := '';
  tmpTreeNode := nil;

  if (TreeView1.Selected<>nil) and (TreeView1.Selected.Data<>nil)
  then tmpPath := PBase(TreeView1.Selected.Data)^.Path
  else tmpPath := '';

  if AddBase(NameNode, BaseNode, tmpPath)
  then begin
    tmpTreeNode := CreateTreeNode(GetParentNodeGroupSelectNode(), NameNode, BaseNode, True);
    UpdateStatusBarSelectNode;;
  end;

  if tmpTreeNode <> nil
  then TreeView1.Selected := tmpTreeNode;

  SetFocusTreeView();
end;
// -----------------------------------------------------------------
function Tfrm1CRun.GetParentNodeGroup(aNode: TTreeNode): TTreeNode;
begin
  Result := nil;
  if (aNode<>nil)and(aNode.Data<>nil)
  then
    if PBase(aNode.Data)^.Group
    then Result := aNode
    else Result := aNode.Parent;
end;
// -----------------------------------------------------------------
function Tfrm1CRun.GetParentNodeGroupSelectNode: TTreeNode;
begin
  Result := GetParentNodeGroup(TreeView1.Selected);
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.aCopyElementExecute(Sender: TObject);
var NameNode: String;
    BaseNode: PBase;
begin
  if (TreeView1.Selected<>nil) and (TreeView1.Selected.Data <> nil)
  then begin
    New(BaseNode);
    with PBase(TreeView1.Selected.Data)^ do
    begin
      BaseNode.Group := Group;
      BaseNode.Path := Path;
      BaseNode.UserName := UserName;
			BaseNode.UserPass := UserPass;
      BaseNode.StrCmd := StrCmd;
    end;
    NameNode := TreeView1.Selected.Text;

    if CopyBase(NameNode, BaseNode)
    then CreateTreeNode(GetParentNodeGroupSelectNode(), NameNode, BaseNode, True);

    UpdateStatusBarSelectNode;
  end;
  SetFocusTreeView();
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.SetFocusTreeView;
begin
  // 25/05/07 ���� ����� ���� ��������, �� �������� ������, �.� ���������� ���� ���������� �����
  if WindowState <> wsMinimized
  then TreeView1.SetFocus;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.aEditElementExecute(Sender: TObject);
var NameNode: String;
    Base: PBase;
begin
  if (TreeView1.Selected<>nil) and (TreeView1.Selected.Data <> nil)
  then begin
    NameNode := TreeView1.Selected.Text;
    Base := PBase(TreeView1.Selected.Data);

    if EditBase(NameNode, Base)
    then begin
      TreeView1.Selected.Text := NameNode;
      SetPictireNode(TreeView1.Selected);
    end;

		UpdateStatusBarSelectNode;
		LoadDescriptionBaseFile;
  end;
	SetFocusTreeView();
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
	UpdateStatusBar(Node);
  //DONE: ������������� ���������� ������ � ���������� �� ��������
  with TreeView1 do
  begin

		if BeginNode = Selected
    then begin
      aCopyElement.Enabled := false;
      aEditElement.Enabled := false;
      aDelElement.Enabled := false;

			aScanDisk.Enabled := false;
			aDeleteIndex.Enabled := false;
			aOpenExplorer.Enabled := false;

			aStartEnterprise.Enabled := false;
			aStartConfig.Enabled := false;
      aStartDebug.Enabled := false;
      aStartMonitor.Enabled := false;
			aStartEnterpriseMonopol.Enabled := false;

    end
    else
      if Selected.Data<>nil
      then
				with PBase(Selected.Data)^ do
				begin

					aCopyElement.Enabled := true;
					aEditElement.Enabled := true;
					aDelElement.Enabled := true;

					if Length(StrCmd) = 0
					then begin
						aScanDisk.Enabled := Group;
						aDeleteIndex.Enabled := Group or (ProgrammStart <> Programm80);
						aOpenExplorer.Enabled := True;

						btnStartEnterprise.Visible := True;
						btnStartCmd.Visible := False;
						aStartEnterprise.Enabled := Not Group;
						aStartConfig.Enabled := Not Group;
						aStartDebug.Enabled := (Not Group) and (ProgrammStart <> Programm80);
						aStartMonitor.Enabled := (Not Group) and (ProgrammStart <> Programm80);
						aStartEnterpriseMonopol.Enabled := (Not Group) and (ProgrammStart <> Programm80);
					end
					else begin
						aScanDisk.Enabled := false;
						aDeleteIndex.Enabled := false;
						aOpenExplorer.Enabled := false;
						cbSelectUser.Enabled := false;

						btnStartCmd.Top := btnStartEnterprise.Top;
						btnStartEnterprise.Visible := false;
						btnStartCmd.Visible := true;

						aStartConfig.Enabled := false;
						aStartDebug.Enabled := false;
						aStartMonitor.Enabled := false;
						aStartEnterpriseMonopol.Enabled := false;
					end;
				end;

    // done: ��� �� ���� ������� � ����� ������ cbeStartMode ���� ������� 8��, �.�. ���� �������� ������ �������, �� ��� ������� 8�� ����� ������
		// �������� ������ CbeStartMode ���������� �������� �������
		FillCbeStartMode(Selected);
	end;

	// ��������� ���� �������� ����
	LoadDescriptionBaseFile();
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.UpdateStatusBar(aNode: TTreeNode);

  // -----------------------------------------------------------------
  // ���������� ���� ���������� ������� � MD
  function GetDateMD(aPath: String): String;

    // -----------------------------------------------------------------
    // ��������� �� ����� ������ � ���� ����� ������ 10 ��������� ������� 0
    Function GetNumberZero2(aNum:Word): String;
    Begin
      if aNum < 10
      then Result := '0'+IntToStr(aNum)
      else Result := IntToStr(aNum);
    End;

  var
    SearchRec : TSearchRec;
    Success : integer;
    DT : TFileTime;
		ST : TSystemTime;
  begin
    Result := '';
    if FileExists(aPath+'1Cv7.MD') then
    begin
      Success := SysUtils.FindFirst(aPath+'1Cv7.MD', faAnyFile, SearchRec);
      if (Success = 0) and
         (( SearchRec.FindData.ftLastWriteTime.dwLowDateTime <> 0) or
          ( SearchRec.FindData.ftLastWriteTime.dwHighDateTime <> 0))
      then
      begin
				FileTimeToLocalFileTime(SearchRec.FindData.ftLastWriteTime,DT);
				FileTimeToSystemTime(DT,ST);
				With st do
					Result := Format('%s.%s.%d (%s:%s)', [GetNumberZero2(wDay),
																								GetNumberZero2(wMonth),
                                                wYear,
																								GetNumberZero2(wHour),
																								GetNumberZero2(wMinute)]);
      end;
      SysUtils.FindClose(SearchRec);
    end;
	end;

	function GetTextStatusBar(base: tBase): String;
	begin
		if Length(base.StrCmd) = 0
		then result := base.Path
		else Result := base.StrCmd;
	end;


begin
	if (aNode<>nil)and(aNode.Data<>nil)
	then
		with PBase(aNode.Data)^, StatusBar1 do
		begin

			if Not Group
			then Panels[0].Text := GetDateMD(GetNotRelativePath(Path))
			else Panels[0].Text := '';

			Panels[1].Text := '';
			Panels[2].Text := GetTextStatusBar(PBase(aNode.Data)^);

    end;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.DeleteNode(aNode: TTreeNode);
Var Reg : TRegistry;

  // ------------------------------------------------------------
  // �������� ��������
  Procedure DeleteElement(aNode : TTreeNode);
  var strPath: String;
  Begin
    if DelBaseRegistry then
      if Reg.OpenKey(RegTitles, false)
      then begin
        strPath := GetNotRelativePath(PBase(aNode.Data)^.Path);
        // ��������� ������� �� ������� ����
        if Not Reg.DeleteValue(strPath)
        then begin
          // �� ������� ���������, ��������� ������ ������ ������ \
          // ����� ��� ���������
          Delete(strPath, Length(strPath), 1);
          Reg.DeleteValue(strPath);
        end;
      end;
    Dispose(PBase(aNode.Data));
    aNode.Delete;
  End;

  // ------------------------------------------------------------
  // �������� ������
  Procedure DeleteGroup(aNode : TTreeNode);
  Var Level : integer;
      NextNode : TTreeNode;
  Begin
    Level :=aNode.Level;
    NextNode := aNode.GetNext;
    While (NextNode <> nil) and (Level < NextNode.Level) do Begin
      If PBase(NextNode.Data)^.Group
      then DeleteGroup(NextNode)
      Else DeleteElement(NextNode);
      NextNode := aNode.GetNext;
    End;
    DeleteElement(aNode);
  End;

var tmpStr : String;
begin
  if (aNode = nil)or(aNode = BeginNode) then Exit;

  if WarningWhenRemoving then
  Begin

    if PBase(aNode.Data)^.Group
    then tmpStr := '������'
    else tmpStr := '�������';

    if MessageBox(Handle, PChar('�� ������������� ������ ������� '+tmpStr+' ?'), PChar('�������������'), MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON1 or MB_APPLMODAL) <> IDYES
      then Exit;
  end;

  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  If PBase(aNode.Data)^.Group
  then DeleteGroup(aNode)
  Else DeleteElement(aNode);
  Reg.Free;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.aDelElementExecute(Sender: TObject);
var tmpAutoExpand: Boolean;
begin
  If TreeView1.Selected <> nil then     // ���� �� ������� �� � �� ��������
    If TreeView1.Selected.Level <> 0    // ������ ������ ������� ������
    then begin
      tmpAutoExpand := TreeView1.AutoExpand;
      TreeView1.AutoExpand := false;

      DeleteNode(TreeView1.Selected);
      UpdateStatusBarSelectNode;

      TreeView1.AutoExpand := tmpAutoExpand;
    end;
  SetFocusTreeView();
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not ((mDescription.Focused)or(eFind.Focused))
  then
    Case Key of
      VK_DELETE : btnDelElement.Click;
      VK_INSERT : btnNewElement.Click;
      VK_RETURN : TreeView1DblClick(nil);
    end;
end;
// -----------------------------------------------------------------
function Tfrm1CRun.SetPictireNode(aNode: TTreeNode): TTreeNode;
var
  Index, SelectIndex: integer;
begin
	Result := aNode;
  if (aNode = nil) or (aNode.Data = nil) then Exit;
  if PBase(aNode.Data)^.Group
  then begin // ���������� �������� ��� ������
    if aNode.Expanded
    then begin
      Index := numPicOpenGroup;
      SelectIndex := numPicOpenGroup;
    end
    else begin
      Index := numPicGroup;
      SelectIndex := numPicGroup;
    end;
  end
	else begin// ���������� �������� ��� ��������
		with PBase(aNode.Data)^ do
			if Length(Trim(StrCmd)) = 0
			then begin
				case ProgrammStart of
					ProgrammBuch77, ProgrammCalc77, ProgrammTrade77 : begin
										Index := numPicElement;
										SelectIndex := numPicElement;
								 end;
					Programm80 : begin
										Index := numPicElement80;
										SelectIndex := numPicElement80;
								 end;
				else
					Index := 0;
					SelectIndex := 0;
				end;

				if CheckPresenceBase // ��������� ������� ��� ������
				then begin
					// �������� ����� ��� ���� 77 ��� 80
					if (ProgrammStart <> Programm80)
					then begin
						// �������� ������ ����
						if not FileExists(GetNotRelativePath(Path)+FileNameBase1C77)
						then begin
							Index := numPicNoElement;
							SelectIndex := numPicNoElement;
						end;
					end
					else begin
						// �������� ������ ����
						if not FileExists(GetNotRelativePath(Path)+FileNameBase1C80)
						then begin
							Index := numPicNoElement80;
							SelectIndex := numPicNoElement80;
						end;
					end
				end;
			end
			else begin
				Index := numPicCmd;
				SelectIndex := numPicCmd;
			end;
	end;

  // ��������� ������ � �����
  if aNode.ImageIndex <> Index
  then aNode.ImageIndex := Index;

  if aNode.SelectedIndex <> SelectIndex
  then aNode.SelectedIndex := SelectIndex;
end;
// -----------------------------------------------------------------
// ��������� ������� ��� ��� �������� �����
// � ����� ��������� ��������
procedure Tfrm1CRun.TreeView1Expanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);

  // -----------------------------------------------------------------
  // ��������� ��� ����������� ��������
  // ���� ������� ��� ������ � �� ��������� ����� �������� �������� ��
  //   ����� ������ ����� ��������� ��� �������� �������� ������ ������
  // ���� ��� �� ������ ����� ��������� ������� ���� � ����������
  Procedure CheckChildNode(aNode: TTreeNode);
  var i: Integer;
  Begin
    For i := 0 to aNode.Count - 1 do
    with PBase(aNode.Item[I].Data)^ do
    begin
      SetPictireNode(aNode.Item[I]);
      if Group
      then
        if aNode.Item[I].Expanded
        then CheckChildNode(aNode.Item[I]);  // �������� �� ����������� ������
    end;
  End;

begin
  CheckChildNode(Node);
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.SetPictureExpandeCollapsed(Sender: TObject; Node: TTreeNode);
begin
	SetPictireNode(Node);
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.pSplitClick(Sender: TObject);
begin
  ShowBtnCaption := Not ShowBtnCaption;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.TimerSaveTimer(Sender: TObject);
begin
	SaveProperties;
	SaveFileBase;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.FormActivate(Sender: TObject);
begin
  SetFocusTreeView();
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.FormPaint(Sender: TObject);
begin
  SetFocusTreeView();
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.SetHotKeys(NewHKRestore,
                              NewHKStartEnterprise,
                              NewHKStartEnterpriseM,
                              NewHKStartConfig,
                              NewHKStartDebug,
                              NewHKStartMonitor: integer);

  // -----------------------------------------------------------------
  // ��������� ������� �������
  procedure SetHotKey(Const Index, NewHotKey: integer);
  var fsModifiers, hk: Word;
  begin
    if NewHotKey <> HotKeys[Index, 2]
    then begin
      if NewHotKey = 0
      then begin // ��������������� ������� �������
        UnRegisterHotKey(Handle, HotKeys[Index, 1]);
      end
      else begin
        hk := Byte(NewHotKey);

        fsModifiers := 0;
        if (NewHotKey and 32768) = 32768 then fsModifiers := fsModifiers or MOD_ALT;
        if (NewHotKey and 16384) = 16384 then fsModifiers := fsModifiers or MOD_CONTROL;
        if (NewHotKey and 8192) = 8192 then fsModifiers := fsModifiers or MOD_SHIFT;

        RegisterHotKey(Handle, HotKeys[Index, 1], fsModifiers, hk);
      end;
      HotKeys[Index, 2] := NewHotKey;
    end;
  end;

begin
  SetHotKey(1, NewHKRestore);
  SetHotKey(2, NewHKStartEnterprise);
  SetHotKey(3, NewHKStartEnterpriseM);
  SetHotKey(4, NewHKStartConfig);
  SetHotKey(5, NewHKStartDebug);
  SetHotKey(6, NewHKStartMonitor);
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.WMHotKey(var Msg: TWMHotKey);
begin
  // ������� �� ������� ������� �������
  if Msg.HotKey = HotKeys[1, 1]
  then begin
    if Application.MainForm.Visible then
    begin
      // ���� ����� �� ������� �� ����������, � ���� ������� ����� �������
      if Not Application.Active then
        SetForegroundWindow(Application.Handle)
      else
        MinimizeForm1.MinimizedToSystemTray();
    end
    else
      MinimizeForm1.MaximizedFromSystemTray();
  end

  else if Msg.HotKey = HotKeys[2, 1]
  then StartSelectBase(0)

  else if Msg.HotKey = HotKeys[3, 1]
  then StartSelectBase(4)

  else if Msg.HotKey = HotKeys[4, 1]
  then StartSelectBase(1)

  else if Msg.HotKey = HotKeys[5, 1]
  then StartSelectBase(2)

  else if Msg.HotKey = HotKeys[6, 1]
  then StartSelectBase(3);
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.aScanDiskExecute(Sender: TObject);
var BeginNode: TTreeNode;

  // -----------------------------------------------------------------
  // ����� ������ dm
  Procedure FindFileMDIn(Const aDir: String);
  var hwnd : THandle;
      FindData : WIN32_FIND_DATA;
  Begin
    // ���� ���� 77
    FindData.dwFileAttributes := 0;
    hwnd := Windows.FindFirstFile(PChar(aDir+'\'+FileNameBase1C77), FindData);
    if hwnd <> INVALID_HANDLE_VALUE
    then begin
      repeat
        AddMdInTreeView(aDir, BeginNode, ProgrammBuch77);
      until (not Windows.FindNextFile(hwnd, FindData)) or (not ActiveScanDisk);
      Windows.FindClose(hwnd);
    end;

    // ���� ���� 80
    FindData.dwFileAttributes := 0;
    hwnd := Windows.FindFirstFile(PChar(aDir+'\'+FileNameBase1C80), FindData);
    if hwnd <> INVALID_HANDLE_VALUE
    then begin
      repeat
        AddMdInTreeView(aDir, BeginNode, Programm80);
      until (not Windows.FindNextFile(hwnd, FindData)) or (not ActiveScanDisk);
      Windows.FindClose(hwnd);
    end;
  End;

  // -----------------------------------------------------------------
  // ����� ���� ������������ � ���������� aDir
  Procedure FindDirectoryIn(Const aDir: String);
  var hwnd : THandle;
      FindData : WIN32_FIND_DATA;
  Begin
    FindFileMDIn(aDir);  // ����� ��������
    // DONE: ���������� ����� ��� API
    // �������� ����� ������������
    FindData.dwFileAttributes := FILE_ATTRIBUTE_DIRECTORY or FILE_ATTRIBUTE_HIDDEN;
    hwnd := Windows.FindFirstFile(PChar(aDir+'*'), FindData);

    if hwnd <> INVALID_HANDLE_VALUE
    then begin
      repeat
        if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0) and
           (String(FindData.cFileName) <> '.') and
           (String(FindData.cFileName) <> '..') and
           (AnsiUpperCase(FindData.cFileName) <> 'NEW_STRU')
        then begin
          StatusBar1.Panels[2].Text := aDir+FindData.cFileName;
          Application.ProcessMessages;
          FindDirectoryIn(aDir+FindData.cFileName+'\');
        end;
      until (not Windows.FindNextFile(hwnd, FindData)) or (not ActiveScanDisk);
      Windows.FindClose(hwnd);
    end;
  End;

begin
  if ActiveScanDisk
  then ActiveScanDisk := false
  else begin
    ActiveDelIndex := false;
    ActiveScanDisk := true;
    BeginNode := TreeView1.Selected;
    if BeginNode <> nil
    then begin
      With PBase(BeginNode.Data)^ do
        if Group and (Length(Path) > 0) and DirectoryExists(GetNotRelativePath(Path))
        then FindDirectoryIn(GetNotRelativePath(Path));

      UpdateStatusBarSelectNode;
    end;
    ActiveScanDisk := false;
  end;
  SetFocusTreeView;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.UpdateStatusBarSelectNode;
begin
  UpdateStatusBar(TreeView1.Selected);
end;

// -----------------------------------------------------------------
// �������� ��������
procedure Tfrm1CRun.aDeleteIndexExecute(Sender: TObject);
var
  CountDeleteFile : integer;
  CountDirectory : integer;

  // -----------------------------------------------------------------
  // ����������� ��������� �������� ��������
  Procedure FindDirectoryIn(Const aDir: String);

    // -----------------------------------------------------------------
    // ����� � �������� ���� CDX��
    Procedure FindFileCDXIn(Const aDir: String);
    var hwnd : THandle;
        FindData : WIN32_FIND_DATA;
    Begin
      FindData.dwFileAttributes := 0;
      hwnd := Windows.FindFirstFile(PChar(aDir+'*.cdx'), FindData);
      if hwnd <> INVALID_HANDLE_VALUE
      then begin
        repeat
          if DeleteFile(aDir+FindData.cFileName)
          then begin
            inc(CountDeleteFile);
            StatusBar1.Panels.Items[1].Text := IntToStr(CountDirectory);
          end;
        until (not Windows.FindNextFile(hwnd, FindData)) or (not ActiveDelIndex);
        Windows.FindClose(hwnd);
      end;
    End;

  var hwnd : THandle;
      FindData : WIN32_FIND_DATA;
  Begin
    // ������� ���������� � ���������� ��������� � ������� �������
    inc(CountDirectory);
    StatusBar1.Panels[0].Text := IntToStr(CountDirectory);
    StatusBar1.Panels[2].Text := aDir;
    FindFileCDXIn(aDir);
    Application.ProcessMessages;

    // ������� ������ ��� cdx � �� ������� ����������
    // � ����� ������ ������ �� ��������� �����������

    // DONE: ���������� ����� ��� API

    // �������� ����� ������������
    FindData.dwFileAttributes := FILE_ATTRIBUTE_DIRECTORY or FILE_ATTRIBUTE_HIDDEN;
    hwnd := Windows.FindFirstFile(PChar(aDir+'*'), FindData);
    if hwnd <> INVALID_HANDLE_VALUE
    then begin
      repeat
        if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0) and
           (String(FindData.cFileName) <> '.') and
           (String(FindData.cFileName) <> '..')
        then FindDirectoryIn(aDir+FindData.cFileName+'\');
      until (not Windows.FindNextFile(hwnd, FindData)) or (not ActiveDelIndex);
      Windows.FindClose(hwnd);
    end;
  End;

begin
  if ActiveDelIndex
  then ActiveDelIndex := false
  else begin
    ActiveScanDisk := false;
    ActiveDelIndex := true;
    if (BeginNode<>TreeView1.Selected)
    then
      if MessageBox(Handle, '�� ������������� ������ ������� ������� � ��������� ����������?', '��������', MB_YESNO or MB_ICONWARNING) = IDYES
      then
        // ����������� ��������� �������� ��������
        if (TreeView1.Selected<>nil)and(TreeView1.Selected.Data<>nil)
        then
          with PBase(TreeView1.Selected.Data)^ do
          begin
            CountDeleteFile := 0;
            CountDirectory := 0;
            FindDirectoryIn(GetNotRelativePath(Path));
            UpdateStatusBarSelectNode;
          end;
    ActiveDelIndex := false;
  end;
  SetFocusTreeView;
end;
// -----------------------------------------------------------------
// ������� ���� � Explorere
procedure Tfrm1CRun.aOpenExplorerExecute(Sender: TObject);
Var StartUpInfo : TStartUpInfo;
    Processlnfo : TProcessInformation;
begin
  If (TreeView1.Selected=nil)or(TreeView1.Selected.Data=nil) then Exit;

  FillChar(StartUpInfo, Sizeof(StartUpInfo), #0);
  with StartUpInfo do
  begin
    cb := SizeOf(TStartupInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := SW_NORMAL;
  end;

  with PBase(TreeView1.Selected.Data)^ do

    // 26/05/07 �����������, ����� �������� �����
    ShellExecute(0, 'explore', PChar(GetNotRelativePath(Path)), '', '', SW_SHOWNORMAL);
{    if Not CreateProcess(PChar(MyGetWindowsDirectory()+'explorer.exe'),
                         PChar(' "'+GetNotRelativePath(Path)+'"'),
                         nil,
                         nil,
                         False,
                         NORMAL_PRIORITY_CLASS,
                         nil,
                         nil,
                         StartUpInfo,
                         Processlnfo)
    then
      Case GetLastError of
        0: ;  // ���������
        2: ShowMessage('������ ����� Explorer.exe ('+MyGetWindowsDirectory()+')');
      else
        ShowMessage('������ ������� �'+IntToStr(Error) + '  ' + SysErrorMessage(Error));
      end;  }
      
  SetFocusTreeView;
end;
// -----------------------------------------------------------------
// ���������� ���
procedure Tfrm1CRun.aSortBaseExecute(Sender: TObject);
begin
  with TreeView1 do
    If Assigned(Selected)
    then begin
      if Selected <> BeginNode
      then Selected.Parent.AlphaSort()
      else Selected.AlphaSort();
    end;

  SetFocusTreeView;
end;
// -----------------------------------------------------------------
// ����������� ����� �����
procedure Tfrm1CRun.btnBaseUpClick(Sender: TObject);
var tn: TTreeNode;
    tmpAutoExpand: boolean;
begin
  With TreeView1 do
  begin
    tmpAutoExpand := TreeView1.AutoExpand;
    TreeView1.AutoExpand := false;

    tn := Selected.getPrevSibling;
    If Assigned(Selected) and
       Assigned(tn) and
       (Selected <> BeginNode) and
       (tn <> BeginNode)
    then Selected.MoveTo(tn, naInsert);

    TreeView1.AutoExpand := tmpAutoExpand;
    SetFocusTreeView;
  end;
end;
// -----------------------------------------------------------------
// ����������� ����� ����
procedure Tfrm1CRun.btnBaseDownClick(Sender: TObject);
var tn: TTreeNode;
    tmpAutoExpand: boolean;
begin
  With TreeView1 do
  begin
    tmpAutoExpand := TreeView1.AutoExpand;
    TreeView1.AutoExpand := false;

    if Assigned(Selected)
    then begin
      tn := Selected.getNextSibling;
      if not Assigned(tn) then Exit;
      // ��������� ������� ����� ���� �����, ��� �������� �.�.
      // ������� ����� �������� ������ ����� ����� ���� �����
      // ���� ������� ������ ��������� ����� ��� ������������ �����
      tn := Selected.getNextSibling.getNextSibling;
      if  Assigned(tn)
      then Selected.MoveTo(tn, naInsert)
      else begin
        // ���� �� ������� ����� �����, ����� �������� ���� ��
        // ��������� ����� ���� ����, �� ���������� ������������ �����
        // � ����� ������ (��� ����� ���������� ��� ���� �����������
        // ����� ���� ��������� �����)
        tn := Selected.getNextSibling;
        if  Assigned(tn)
        then Selected.MoveTo(tn, naAdd);
      end;
    end;

    TreeView1.AutoExpand := tmpAutoExpand;
    SetFocusTreeView;
  end;
end;
// -----------------------------------------------------------------
// ����� �� ������ ���
procedure Tfrm1CRun.btnFindClick(Sender: TObject);
var
  Find:Boolean;
  I, BeginI : Integer;
  CountI, iTag: Integer;
begin
  // ����� ������ �� ����������� ��������
  With TreeView1 do
  begin
    if Selected <> nil
    then I := Selected.AbsoluteIndex
    else i := 0;

    BeginI := I;
    CountI := Items.Count - 1;
    Find := False;

    iTag := (Sender as TBitBtn).tag;

    Repeat
      // ���� ������
      if iTag = 0
      then begin
        Inc(i);
        if I > CountI then i := 0;
        if I = BeginI then Find := True;
      end
      // ���� �����
      else begin
        Dec(i);
        if I < 0 then i := CountI;
        if I = BeginI then Find := True;
      end;

      if (Pos(AnsiUpperCase(eFind.Text), AnsiUpperCase(Items.Item[i].Text)) > 0) or
         (Pos(AnsiUpperCase(eFind.Text), AnsiUpperCase(PBase(Items.Item[i].Data)^.Path)) > 0)
      then
        Find := true;

    Until Find;
    Items.Item[i].Selected := true;
    SetFocus();
    TreeView1Change(nil, Selected);
  end;
end;
// -----------------------------------------------------------------
// ��� ������ �� ���� ������, ���� ��������� �������� �������� � ����
procedure Tfrm1CRun.eFindExit(Sender: TObject);
var i: integer;
begin
  with eFind do
  begin
    i := Items.IndexOf(Text);
    if i = -1
    then Items.Insert(0, Text)
    else Items.Exchange(i, 0);
  end;
end;
// -----------------------------------------------------------------
// ���� ������ Enter �������� �����
procedure Tfrm1CRun.eFindKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13
  then btnFindDown.Click;

  if key = #27
  then TreeView1.SetFocus;
end;
// -----------------------------------------------------------------
// ����������, ��������� ���� �������� ���� ��� ���
function Tfrm1CRun.GetLoadDescriptionBase: boolean;
begin
  Result := (mDescription.Height > 0);
end;
// -----------------------------------------------------------------
// �������� ����� �������� ����
procedure Tfrm1CRun.LoadDescriptionBaseFile;
begin
	with TreeView1 do
		if (LoadDescriptionBase) and
			 (Selected<>nil) and
			 (Selected.Data<>nil)
		then
			with PBase(Selected.Data)^ do
			begin
				mDescription.Enabled :=	Length(StrCmd) = 0;

				if mDescription.Enabled
				then begin
					if FileExists(GetNotRelativePath(Path)+FileDecriptionBase)
					then begin
						mDescription.Lines.LoadFromFile(GetNotRelativePath(Path)+FileDecriptionBase);
						mDescription.Modified := false;
					end;
				end
				else
					mDescription.Text := StrCmd;
			end;
end;
// -----------------------------------------------------------------
// ���������� ����� �������� ����
procedure Tfrm1CRun.SaveDescriptionBaseFile;
var tmpStr: String;
begin
  with TreeView1 do
    if (Selected<>nil) and
       (mDescription.Modified) and
       (Selected.Data<>nil)
    then
      // ���� ���������� ����������
      // ���� ���� ���������� ����� ������� ����� �����������
      // � ���� �� ����������, ����� �������� ���� � memo ����� ���� ����� �������
      with PBase(Selected.Data)^ do
      begin
        tmpStr := GetNotRelativePath(Path);
        if (DirectoryExists(tmpStr))and
           ((FileExists(tmpStr+FileDecriptionBase)) or
            (Length(Trim(mDescription.Text))>0))
        then mDescription.Lines.SaveToFile(tmpStr+FileDecriptionBase);

      end;
  mDescription.Clear;
  mDescription.Modified := false;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.TreeView1Changing(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
begin
  // �������� ������ ���� ���� � ��� ������� ��������� ����
  OldProgrammStart := -1;
  if TreeView1.Selected <> nil
  then OldProgrammStart := PBase(TreeView1.Selected.Data)^.ProgrammStart;

  SaveDescriptionBaseFile();
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.TreeView1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var p : TPoint;
    tmpNode : TTreeNode;
    apxMenu: TapxPopupMenu;
begin
	if Button = mbRight then
		with TreeView1 do
		begin
			tmpNode := GetNodeAt(x, y);
      if (tmpNode <> nil) and (tmpNode <> BeginNode)
			then
        with PBase(tmpNode.Data)^ do
        begin
          Selected := tmpNode;
          GetCursorPos(p);

          // �������� ����� ���� � �������� ��� ��������
          apxMenu := TapxPopupMenu.Create(frm1CRun);
          try
            apxMenu.Images := ImageList;

						if Length(StrCmd) = 0
						then begin
              if Not Group
							then begin
								apxMenu.AddItem(ModeStart[0, 1], 10, '', 0);      // �����������

								if ProgrammStart <> Programm80
								then apxMenu.AddItem(ModeStart[0, 1]+' '+mCaption[4], 14, '', 17);      // ����������� ����������

								apxMenu.AddItem(ModeStart[1, 1], 11, '', 1);      // ������������

								if ProgrammStart <> Programm80
								then begin
									apxMenu.AddItem(ModeStart[2, 1], 12, '', 2);      // ��������
									apxMenu.AddItem(ModeStart[3, 1], 13, '', 3);      // �������
								end;
								apxMenu.AddItem('-');                             // �����������
							end
							else
								apxMenu.AddItem(aScanDisk.Hint, 4, '', 12);     // ����� ���
						end
						else begin
							apxMenu.AddItem(aStartCmd.Caption, 10, '', 20);
							apxMenu.AddItem('-');                             // �����������
						end;

						apxMenu.AddItem(mCaption[2], 2, '', 6);    // �������������
						apxMenu.AddItem(mCaption[1], 1, '', 5);    // ����������
						apxMenu.AddItem(mCaption[3], 3, '', 7);    // �������
						apxMenu.AddItem(mCaption[0], 0, '', 4);    // �����

						apxMenu.AddItem('-');                      // �����������

						if Length(StrCmd) = 0
						then begin
              if ProgrammStart <> Programm80
							then apxMenu.AddItem(aDeleteIndex.Hint, 5, '', 13);   // �������� �������

							apxMenu.AddItem(aOpenExplorer.Hint, 6, '', 14);  // ������� �����
							apxMenu.AddItem(btnSort.Hint, 7, '', 15);          // �����������
						end;

						// ��������� ������ ������ ����
            if apxMenu.Popup(p.x, p.y)
            then begin
              Case apxMenu.ResultTag of
                0 : aNewElement.Execute;
                1 : aCopyElement.Execute;
                2 : aEditElement.Execute;
                3 : aDelElement.Execute;

                4 : aScanDisk.Execute;
                5 : aDeleteIndex.Execute;
                6 : aOpenExplorer.Execute;
                7 : aSortBase.Execute;

                10, 11, 12, 13, 14: StartSelectBase(apxMenu.ResultTag-10);
                //14: StartSelectBase(0, true);
              end;
            end;
          finally
            apxMenu.Free;
          end;
        end;
    end;
end;
// -----------------------------------------------------------------
// ���������� ��������������
procedure Tfrm1CRun.TreeView1DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  With TreeView1 do
    if (Selected <> nil) and (DropTarget.Data <> nil)
    then begin
      if PBase(DropTarget.Data)^.Group
      then Selected.MoveTo(DropTarget, naAddChildFirst)
      else Selected.MoveTo(DropTarget, naInsert);
    end;
end;
// -----------------------------------------------------------------
// ������ ��������������
procedure Tfrm1CRun.TreeView1DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if TreeView1.Selected = BeginNode
  then Accept := false
  else Accept := true;
end;
// -----------------------------------------------------------------
function Tfrm1CRun.GetAutoExpandTV: boolean;
begin
  Result := TreeView1.AutoExpand;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.SetAutoExpandTV(const Value: boolean);
begin
  if TreeView1.AutoExpand <> Value
  then TreeView1.AutoExpand := Value;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.MinimizeForm1RightClickIconTray(Sender: TObject);
var apxMenu: TapxPopupMenu;
    p: TPoint;
begin
  apxMenu := TapxPopupMenu.Create(self);
  apxMenu.AddItem(btnExit.Hint, 1);
  //apxMenu.AddItem(BeginNode.Text, 2);
  // todo: ������� ������������ ���� � ��������� � ������ ������
  GetCursorPos(p);
  if apxMenu.PopupTagAndFree(p.x, p.y)=1
  then begin
    fExit := True;
    btnExit.Click;
  end;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.TreeView1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);

  // -----------------------------------------------------------------
  // ���������� ������ � ������������� ����
  // ���������������1  ������������1  ������������1  �����������������  ����������
  // ���������������2  ������������2  ������������2  �����������������  ����������
  function GetWorkUsers(aPathBase: String): string;

    // -----------------------------------------------------------------
    // ������������� ���� � ����������� �� ���� ����� �������������,
    // � ����� � ����� ������� ��������� 1�
    function CheckUsersInFile(Const aFileName: String): String;

      // -----------------------------------------------------------------
      //
      function AnalisString(aStr: string): string;
      var tmpStr: String;
      begin
        Result := '';
        aStr := Trim(aStr);
        if Length(aStr)>0
        then begin
          GetNextSubStr(aStr, ',');            // Name
          Result := GetNextSubStr(aStr, ',');

          GetNextSubStr(aStr, ',');            // RunMode
          tmpStr := GetNextSubStr(aStr, ',');

          Result := Result+' ';

          if tmpStr = 'E'
          then Result := Result+''+ModeStart[0, 1]
          else if tmpStr = 'C'
          then Result := Result+''+ModeStart[1, 1]
          else if tmpStr = 'D'
          then Result := Result+''+ModeStart[2, 1]
          else if tmpStr = 'M'
          then Result := Result+''+ModeStart[3, 1];

          GetNextSubStr(aStr, ',');            // IsMono
          tmpStr := GetNextSubStr(aStr, ',');

          if tmpStr='Y'
          then Result := Result+'(M)';

          Result := Result+' ';

          GetNextSubStr(aStr, ',');            // Date&Time
          Result := Result+GetNextSubStr(aStr, ',')+' (';
          Result := Result+GetNextSubStr(aStr, ',')+') ';

          GetNextSubStr(aStr, ',');            // ComputerName
          Result := Result+GetNextSubStr(aStr, ',');

          Result := Result + #13;
        end;
      end;

    const MaxSizeBuff=512;
    var fs: TFileStream;
        LengthBuff, IndexBuff : integer;
        buff: Array [1..MaxSizeBuff] of char;
        cs: integer;
        tmpStr: String;
    begin
      fs := TFileStream.Create(aFileName, fmOpenRead or fmShareDenyNone);
      Result := '';
      try
        // ��������� ���� �� 512 ���� � �������� ������� ������ '{' '}'
        // ���� ������ ������������� ���� ����� �������� ������
        // � ������, ���� ������ ��������� �������� ������������ ������
        // �� ������, ����� ����� ���������� ���� �� ������� ���� ����.
        cs := 0;                                           // ���������� ������
        repeat
          LengthBuff := fs.Read(buff, MaxSizeBuff);        //
          IndexBuff := 1;                                  //
          while IndexBuff<=LengthBuff do                   // ��������� ���� �����
          begin
            Case Buff[IndexBuff] of
              '{': inc(cs);                                // �������� ����� �������� ������

              '}':
                begin
                  dec(cs);                                 // �������� ����� �������� ������
                  if cs = 0                                // � ���� ������ 0 �����
                  then begin
                    Result := Result + AnalisString(tmpStr); // �������� ������ �� ������
                    tmpStr := '';
                  end;
                end;

              '"', #10, #13:;                              // ���� ������ ��� ������
            else
              tmpStr := tmpStr +Buff[IndexBuff];
            end;

            inc(IndexBuff);
          end;
        until LengthBuff<MaxSizeBuff;

        Result := Trim(Result);
        
      finally
        fs.Free;
      end;
    end;

  begin
    aPathBase := GetNotRelativePath(aPathBase);

    if FileExists(aPathBase+'\SYSLOG\links.tmp')
    then Result := CheckUsersInFile(aPathBase+'\SYSLOG\links.tmp')
    else Result := '';
  end;

begin
  // DONE: �������� ���������� �������������
  TreeView1.Hint := '';
  if ShowWorkUser then
    if TreeView1.GetNodeAt(x, y) <> nil then
      with PBase(TreeView1.GetNodeAt(x, y).Data)^ do
        if not Group
        then TreeView1.Hint := GetWorkUsers(Path);
end;

//--------------------------------------------------------------
// �������� ��������� �� ������ ����������� �����, ���� �������������
procedure Tfrm1CRun.WMNotifyRestore(var msg: Tmessage);
begin
  if Application.MainForm.Visible
  then SetForegroundWindow(Handle)
  else MinimizeForm1.MaximizedFromSystemTray();
end;

//--------------------------------------------------------------
// �������� ��������� � ��������� ������ �� ������ �����
procedure Tfrm1CRun.WMCopyData(var msg: Tmessage);
var Str : String;
    tmpNode: TTreeNode;
begin
  with PCopyDataStruct(msg.LParam)^ do
    FindTreeNodeUnderPathOrCreate(ExtractFilePath(Copy(string(lpData), 1, cbData)));
  MinimizeForm1.MaximizedFromSystemTray;
end;

//--------------------------------------------------------------
procedure Tfrm1CRun.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if BtnCloseAsMinimize and Not fExit
  then begin
    Action := caNone;
    MinimizeForm1.MinimizedToSystemTray;
  end;
end;

// -----------------------------------------------------------------
// ���������� �������� � ������
Function Tfrm1CRun.AddMdInTreeView(const aDir: String; const BeginNode: TTreeNode; ProgrammStart: integer): TTreeNode;

  // -----------------------------------------------------------------
  // ����� �������� � ����� ������� �����
  // ���� aGroup=true ����� ����� ������ ����� ����� ��������
  Function FindElement(Const aTreeNode: TTreeNode; Const aName: String; Const aGroup: Boolean): TTreeNode;
  var tempNode: TTreeNode;
  Begin
    tempNode := aTreeNode.getFirstChild();
    Result := nil;
    While (tempNode <> nil) and (Result=nil) do
    begin
      if tempNode.Text = aName then
        if (aGroup and PBase(tempNode.Data)^.Group) or
           ((not aGroup) and (not PBase(tempNode.Data)^.Group))
        then Result := tempNode;
      tempNode := tempNode.getNextSibling();
    end;
  End;

  // -----------------------------------------------------------------
  // ����� ��� ������� ����� � ������� ���������� ������� ������� �������
  function FindOrCreateNode(aPathTreeView: String; const aBeginNode: TTreeNode; Const aFullPath: String): TTreeNode;
  var tempNode: TTreeNode;
      ElementName, NewPath: String;
  Begin
    Result := nil;
    if Length(aPathTreeView) > 0
    then begin
      ElementName := GetNextSubStr(aPathTreeView, '\'); // ������� ������������ ��������� ����������
      NewPath := aFullPath + ElementName+'\';           // ������� ������� ����
                                                        // ����� ������ ������� � ������ ElementName
      tempNode := FindElement(aBeginNode, ElementName, Length(aPathTreeView)<>0);
                                                        // ���� ����� �����
      if tempNode <> nil
      then Result := FindOrCreateNode(aPathTreeView, tempNode, NewPath)  // ����� ������ ��������� ��������
      else begin
        // ���� �� ����� ����� �������� ����� �������
        if length(aPathTreeView) = 0
        then Result := CreateBaseNode(aBeginNode, ElementName, NewPath, false, ProgrammStart)
        else begin
          tempNode := CreateBaseNode(aBeginNode, ElementName, NewPath, True, -1); // �������� ������
          Result := FindOrCreateNode(aPathTreeView, tempNode, NewPath);           // ��������
        end;
      end;
    end;
  End;

var BeginPath: string;
Begin
  Result := nil;
  if BeginNode <> nil
  then begin
    BeginPath := GetNotRelativePath(PBase(BeginNode.Data)^.Path);
    Result := FindOrCreateNode(Copy(aDir, Length(BeginPath)+1, Length(aDir)-Length(BeginPath)+1), BeginNode, GetRelativePath(BeginPath));
  end;
End;
// -----------------------------------------------------------------
// ����� ����� �� ���� � ����
// ���� ����� �� �������, ���������� ���������� ����� � ������� AddMdInTreeView
procedure Tfrm1CRun.FindTreeNodeUnderPathOrCreate(aPath: string);
var tmpNode: TTreeNode;
    tmpPath: string;
    programmStart: integer;
begin
  // DONE: �������� ������� ������ ���� � ������
  // ���� ���� ����� �������� ��� � BeginNode
  tmpPath := AnsiUpperCase(aPath);
  tmpNode := BeginNode;
  while (tmpNode <> nil) and
        (AnsiUpperCase(GetNotRelativePath(PBase(tmpNode.Data)^.Path)) <> tmpPath)
  do
    tmpNode := tmpNode.GetNext;

  ProgrammStart := IndexProgramm1CDefault;

  if GetTypeBaseFromPath(aPath) = tb80
  then ProgrammStart := Programm80;

  if tmpNode = nil
  then tmpNode := AddMdInTreeView(aPath, BeginNode, ProgrammStart);
  TreeView1.Selected := tmpNode;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.btnAboutClick(Sender: TObject);
begin
  OpenAbout;
end;
// -----------------------------------------------------------------
procedure Tfrm1CRun.FormShow(Sender: TObject);
begin
  if FirstStart
  then begin
    FirstStart := false;
    if MinimizeAfterStart
    then PostMessage(Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
  end;
end;

// -----------------------------------------------------------------
procedure Tfrm1CRun.TreeView1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
  then StartSelectBase();
end;

// -----------------------------------------------------------------
procedure Tfrm1CRun.FillCbeStartMode(aNode: TTreeNode);
var
  i: integer;
begin
	// ��������� ComboBox CbeStartMode ���������� �� ������� ModeStart
  // ��� 77, ��� �����������, ����������� ����������, ������������, �������, ��������
  // ��� 80, ��� �����������, ������������

  if aNode <> nil
  then
    with PBase(aNode.Data)^ do
    begin

			cbeStartMode.Enabled := not (Group or (length(StrCmd)<>0));
			if not cbeStartMode.Enabled
			then Exit;

      // ���� ������� ��������� ���� ���� ������ �� ����, �� ������ ������ ������
      if OldProgrammStart <> ProgrammStart
      then begin

        cbeStartMode.Clear;

        case ProgrammStart of

          // ��������� �� 77
          ProgrammBuch77, ProgrammCalc77, ProgrammTrade77 :
            begin
              for i := 0 to 3 do
                cbeStartMode.ItemsEx.AddItem(ModeStart[i, 1], i, i, -1, -1, Pointer(i));

              with cbeStartMode.ItemsEx.Insert(1) do
              begin
                Caption := ModeStart[0, 1]+' '+mCaption[4];
                ImageIndex := 0;
                SelectedImageIndex := 17;
                OverlayImageIndex := -1;
                Indent := -1;
                Data := Pointer(i);
              end;

              cbeStartMode.ItemIndex := StartMode77;
            end;

          // �������� �� 80
          Programm80:
            begin
              // �����������
              i := 0;
              cbeStartMode.ItemsEx.AddItem(ModeStart[i, 1], i, i, -1, -1, Pointer(i));

              // ������������
              i := 1;
              cbeStartMode.ItemsEx.AddItem(ModeStart[i, 1], i, i, -1, -1, Pointer(i));

              cbeStartMode.ItemIndex := StartMode80;
            end;
        end;
      end;
    end;
end;

procedure Tfrm1CRun.cbeStartModeChange(Sender: TObject);
begin
  // ��� ��������� ���� ������� ���� ��������� � ��������� ��� ��������
  if TreeView1.Selected <> nil
  then begin
    case PBase(TreeView1.Selected.Data)^.ProgrammStart of

      ProgrammBuch77, ProgrammCalc77, ProgrammTrade77:
        StartMode77 := cbeStartMode.ItemIndex;

      Programm80:
        StartMode80 := cbeStartMode.ItemIndex;
    end;
	end;
end;

procedure Tfrm1CRun.StartCmd(strCmd: string);
var
	StartUpInfo: TStartUpInfo;
	Processlnfo: TProcessInformation;
 	Error: Integer;
begin

	if Pos('.EXE', UpperCase(trim(strCmd))) > 0
	then begin
		FillChar(StartUpInfo, Sizeof(StartUpInfo), #0);
		with StartUpInfo do
		begin
			cb := SizeOf(TStartupInfo);
			dwFlags := STARTF_USESHOWWINDOW;
			wShowWindow := SW_NORMAL;
		end;

		if not CreateProcess(nil,
												 PChar(strCmd),
												 nil, nil, False,
												 NORMAL_PRIORITY_CLASS, nil,
												 nil, StartUpInfo,
												 Processlnfo)
		then begin
			Error := GetLastError;
			ShowMessage('������ ������� �'+IntToStr(Error) + '  ' + SysErrorMessage(Error));
		end;

	end
	else
		ShellExecute(0, 'open', PChar(strCmd), '', '', 0);
end;

procedure Tfrm1CRun.FormDestroy(Sender: TObject);
begin
	Programm1Cnew.Destroy;
end;

end.
