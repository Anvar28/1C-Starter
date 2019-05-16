object frmAbout: TfrmAbout
  Left = 90
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsSingle
  Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077' ...'
  ClientHeight = 416
  ClientWidth = 590
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    590
    416)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 19
    Width = 153
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1072':'
  end
  object Label4: TLabel
    Left = 8
    Top = 51
    Width = 153
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1050#1083#1102#1095':'
  end
  object lblValid: TLabel
    Left = 416
    Top = 52
    Width = 33
    Height = 13
    Caption = 'lblValid'
  end
  object Button1: TButton
    Left = 506
    Top = 382
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object edtIdentifikator: TEdit
    Left = 168
    Top = 16
    Width = 409
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 1
  end
  object edtKey: TEdit
    Left = 168
    Top = 48
    Width = 241
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    OnChange = edtKeyChange
  end
  object pnl1: TPanel
    Left = 8
    Top = 80
    Width = 570
    Height = 289
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvLowered
    Caption = 'pnl1'
    TabOrder = 3
    object wb1: TWebBrowser
      Left = 1
      Top = 1
      Width = 568
      Height = 287
      Align = alClient
      TabOrder = 0
      ControlData = {
        4C000000B43A0000AA1D00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
end
