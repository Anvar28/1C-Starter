unit uMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, Buttons, ExtCtrls, ImgList,
  ActnList, RzGroupBar, RzPanel, RzRadGrp, RzButton;

type
  TForm1 = class(TForm)
    ControlBar1: TControlBar;
    p1: TPanel;
    tvBase: TTreeView;
    cbeStartMode: TComboBoxEx;
    cbMonopol: TCheckBox;
    pStartBtn: TPanel;
    btnStart0: TBitBtn;
    btnStart1: TBitBtn;
    btnStart2: TBitBtn;
    btnStart3: TBitBtn;
    pAction: TPanel;
    btnNewElement: TBitBtn;
    btnCopyElement: TBitBtn;
    btnEditElement: TBitBtn;
    btnDeleteElement: TBitBtn;
    ilStart: TImageList;
    ActionList1: TActionList;
    aNewElement: TAction;
    aCopyElement: TAction;
    aEditElement: TAction;
    aDeleteElement: TAction;
    aStart0: TAction;
    aStart1: TAction;
    aStart2: TAction;
    aStart3: TAction;
    RzToolbarButton1: TRzToolbarButton;
    RzMenuButton1: TRzMenuButton;
    RzToolButton1: TRzToolButton;
    RzCheckGroup1: TRzCheckGroup;
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    RzGroup2: TRzGroup;
    procedure FormCreate(Sender: TObject);
    procedure ControlBar1Resize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnNewElementClick(Sender: TObject);
  private
    gShowCaptionBtn : Boolean;
    FShowCaptionBtn: boolean;
    procedure SetShowCaptionBtn(const Value: boolean);
  public
    property ShowCaptionBtn: boolean read FShowCaptionBtn write SetShowCaptionBtn;
  end;

var
  Form1: TForm1;

implementation
Uses uConst;

Const
  ModeStart : Array [0..3, 1..2] of string = (('Предприятие', 'enterprise'),
                                              ('Конфигуратор', 'config'),
                                              ('Отладчик', 'debug'),
                                              ('Монитор', 'monitor'));

  WidthBtnShowCaption = 110;
  WidthBtnNonShowCaption = 25;

{$R *.dfm}
// -----------------------------------------------------------------
procedure TForm1.FormCreate(Sender: TObject);
var i : byte;
begin
  Caption := Format('APXi 1C-Run Ver. %s (%s) apxi@mail.ru', [gVer, gDate]);

  for i := 0 to 3 do
    cbeStartMode.ItemsEx.AddItem(ModeStart[i, 1], i, i, -1, -1, nil);

  aStart0.Caption := ModeStart[0, 1];
  aStart1.Caption := ModeStart[1, 1];
  aStart2.Caption := ModeStart[2, 1];
  aStart3.Caption := ModeStart[3, 1];

  cbeStartMode.ItemIndex := 0;

  btnStart0.Caption := ModeStart[0, 1];
  btnStart1.Caption := ModeStart[1, 1];
  btnStart2.Caption := ModeStart[2, 1];
  btnStart3.Caption := ModeStart[3, 1];
end;
// -----------------------------------------------------------------
procedure TForm1.ControlBar1Resize(Sender: TObject);
begin
  if ShowCaptionBtn
  then tvBase.Width := ControlBar1.Width - WidthBtnShowCaption - 27
  else tvBase.Width := ControlBar1.Width - 19;
end;
// -----------------------------------------------------------------
procedure TForm1.FormResize(Sender: TObject);
begin
  ControlBar1Resize(ControlBar1);
end;
// -----------------------------------------------------------------
// При изменении свойства показа надписей
// необходимо пересчитать положение и размер кнопок
procedure TForm1.SetShowCaptionBtn(const Value: boolean);
var tmpWidth, tmpTop, tmpLeft : integer;

  // -----------------------------------------------------------------
  // Установка Ширины, отступа сверху и слева.
  procedure SetWidthTopLeft(var aBtn: TBitBtn; aNom: byte);
  Begin
    aBtn.Width := tmpWidth;
    aBtn.Top := tmpTop * aNom;
    aBtn.Left := tmpLeft * aNom;
  End;

begin
  if Value <> FShowCaptionBtn
  then begin
    FShowCaptionBtn := Value;

    if FShowCaptionBtn
    then begin
      // Надо показывать заголовок кнопок
      tmpWidth := WidthBtnShowCaption;

      // Также разместим кпопки по вертикали
      tmpTop := 25;
      tmpLeft := 0;
    end
    else begin
      // НЕнадо показывать заголовки кнопок
      tmpWidth := WidthBtnNonShowCaption;

      // Разместим кнопки по горизонтали
      tmpTop := 0;
      tmpLeft := 25;
    end;
    SetWidthTopLeft(btnStart0, 0);
    SetWidthTopLeft(btnStart1, 1);
    SetWidthTopLeft(btnStart2, 2);
    SetWidthTopLeft(btnStart3, 3);

    SetWidthTopLeft(btnNewElement, 0);
    SetWidthTopLeft(btnCopyElement, 1);
    SetWidthTopLeft(btnEditElement, 2);
    SetWidthTopLeft(btnDeleteElement, 3);

    ControlBar1Resize(ControlBar1);
  end;
end;

procedure TForm1.btnNewElementClick(Sender: TObject);
begin
  ShowCaptionBtn := Not ShowCaptionBtn;
end;

end.
