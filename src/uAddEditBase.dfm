object frmAddEditBase: TfrmAddEditBase
  Left = 112
  Top = 40
  BorderStyle = bsDialog
  Caption = 'frmAddEditBase'
  ClientHeight = 303
  ClientWidth = 561
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object eName: TLabeledEdit
    Left = 16
    Top = 27
    Width = 529
    Height = 21
    EditLabel.Width = 79
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1073#1072#1079#1099
    TabOrder = 0
  end
  object btnClose: TButton
    Left = 470
    Top = 267
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 2
    OnClick = btnCloseClick
  end
  object btnOK: TButton
    Left = 390
    Top = 267
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = btnOKClick
  end
  object pgc1: TPageControl
    Left = 16
    Top = 56
    Width = 529
    Height = 209
    ActivePage = tsCmd
    Style = tsFlatButtons
    TabOrder = 3
    OnChange = pgc1Change
    object ts1c: TTabSheet
      Caption = #1041#1072#1079#1072' 1'#1057
      object cbGroup: TCheckBox
        Left = 0
        Top = 5
        Width = 60
        Height = 17
        Caption = #1043#1088#1091#1087#1087#1072
        TabOrder = 0
        OnClick = cbGroupClick
      end
      object ePath: TLabeledEdit
        Left = 0
        Top = 46
        Width = 497
        Height = 21
        EditLabel.Width = 60
        EditLabel.Height = 13
        EditLabel.Caption = #1055#1091#1090#1100' '#1082' '#1073#1072#1079#1077
        TabOrder = 1
        OnExit = ePathExit
      end
      object btnSelectPath: TBitBtn
        Left = 499
        Top = 46
        Width = 22
        Height = 22
        Caption = '...'
        TabOrder = 2
        OnClick = btnSelectPathClick
      end
      object pnl1c: TPanel
        Left = 0
        Top = 80
        Width = 521
        Height = 105
        BevelOuter = bvNone
        TabOrder = 3
        object l1: TLabel
          Left = 0
          Top = 4
          Width = 73
          Height = 13
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        end
        object Label1: TLabel
          Left = 0
          Top = 52
          Width = 103
          Height = 13
          Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1079#1072#1087#1091#1089#1082#1072
        end
        object cbUserName: TComboBox
          Left = 0
          Top = 20
          Width = 255
          Height = 21
          ItemHeight = 0
          TabOrder = 0
        end
        object eUserPass: TLabeledEdit
          Left = 257
          Top = 20
          Width = 264
          Height = 21
          EditLabel.Width = 38
          EditLabel.Height = 13
          EditLabel.Caption = #1055#1072#1088#1086#1083#1100
          PasswordChar = '*'
          TabOrder = 1
        end
        object cbProgrammStart: TComboBox
          Left = 0
          Top = 68
          Width = 521
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 2
        end
      end
    end
    object tsCmd: TTabSheet
      Caption = #1055#1088#1086#1080#1079#1074#1086#1083#1100#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072
      ImageIndex = 1
      object Label2: TLabel
        Left = 0
        Top = 96
        Width = 29
        Height = 13
        Caption = #1060#1072#1081#1083
      end
      object Label4: TLabel
        Left = 0
        Top = 0
        Width = 51
        Height = 13
        Caption = #1055#1088#1080#1084#1077#1088#1099':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtStrCmd: TMemo
        Left = 0
        Top = 112
        Width = 521
        Height = 65
        TabOrder = 0
        OnKeyPress = edtStrCmdKeyPress
      end
      object mmo1: TMemo
        Left = 0
        Top = 16
        Width = 521
        Height = 65
        Color = clBtnFace
        Lines.Strings = (
          #1047#1072#1087#1091#1089#1082' '#1082#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088#1072':  calc.exe'
          
            #1047#1072#1087#1091#1089#1082' IE '#1089#1086' '#1089#1090#1088#1072#1085#1080#1094#1077#1081':  C:\Program Files\Internet Explorer\IEXP' +
            'LORE.EXE software-tracking.ru'
          
            #1054#1090#1082#1088#1099#1090#1080#1077' '#1092#1072#1081#1083#1072':  notepad.exe  "c:\windows\system32\drivers\etc\h' +
            'osts"'
          
            #1047#1072#1087#1091#1089#1082' 1'#1057' '#1089' '#1073#1072#1079#1086#1081' SQL: C:\1cv82\1cestart.exe ENTERPRISE /S"sqlSe' +
            'rver\base" /N"'#1040#1076#1084#1080#1085'" /P"123"')
        ReadOnly = True
        TabOrder = 1
      end
    end
  end
end
