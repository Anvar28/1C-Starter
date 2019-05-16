object frmAddPath: TfrmAddPath
  Left = 451
  Top = 328
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1087#1091#1090#1080' '#1082' '#1080#1089#1087#1086#1083#1085#1103#1077#1084#1086#1084#1091' '#1092#1072#1081#1083#1091' 1'#1057
  ClientHeight = 82
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 19
    Width = 27
    Height = 13
    Caption = #1055#1091#1090#1100':'
  end
  object Label1: TLabel
    Left = 8
    Top = 51
    Width = 76
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object btnSelect: TButton
    Left = 400
    Top = 16
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 0
    OnClick = btnSelectClick
  end
  object edtName: TEdit
    Left = 88
    Top = 48
    Width = 177
    Height = 21
    TabOrder = 1
  end
  object btnOk: TButton
    Left = 272
    Top = 48
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 352
    Top = 48
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object edtPath: TComboBox
    Left = 40
    Top = 16
    Width = 360
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    OnExit = edtPathExit
  end
end
