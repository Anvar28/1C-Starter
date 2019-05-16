program Run1C;

{%ToDo 'Run1C.todo'}
{%File 'def.inc'}
{%File 'Ќе забыть.txt'}

uses
  Forms,
  Windows,
  Messages,
  SysUtils,
  Unit1 in 'Unit1.pas' {frm1CRun},
  uConst in 'uConst.pas',
  uFrmProperties in 'uFrmProperties.pas' {frmProperties},
  uAddEditBase in 'uAddEditBase.pas' {frmAddEditBase},
  uStrings in 'uStrings.pas',
  uFrmAbout in 'uFrmAbout.pas' {frmAbout},
  uMyCript in 'uMyCript.pas',
  Base64 in 'Base64.pas',
  programm1c in 'programm1c.pas',
  uAddPath in 'uAddPath.pas' {frmAddPath};

{$R *.res}
	// -----------------------------------------------------------------
  // »щим первый экземпл€р и выводим его на первый план
  Function CheckMyCopy(): Boolean;

    // -----------------------------------------------------------------
    Procedure SetDataInCopyApp(PrevInstance: THandle);
		var DataBufer: TCopyDataStruct;
        str: String;
    Begin
      str := ParamStr(1);

      DataBufer.cbData := Length(str);
      DataBufer.lpData := PChar(str);
      SendMessage(PrevInstance, WM_COPYDATA, Application.Handle, Longint(@DataBufer));
    End;

  var HandleCopyAPP: THandle;
  Begin
    HandleCopyAPP := FindWindow('Tfrm1CRun', nil);
    if HandleCopyAPP <> 0
    then begin
      if Length(ParamStr(1)) = 0
      then PostMessage(HandleCopyAPP, WM_NotifyRestoreWindow, 0, 0)
      else SetDataInCopyApp(HandleCopyAPP);
    end;
    Result := HandleCopyAPP = 0;
    Result := true;
  End;

begin
  if CheckMyCopy()
  then begin
    Application.Initialize;
    Application.Title := 'Run1C';
    Application.CreateForm(Tfrm1CRun, frm1CRun);
	Application.Run;
  end;  
end.
