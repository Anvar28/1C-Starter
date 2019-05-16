object frmProperties: TfrmProperties
  Left = 197
  Top = 104
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 284
  ClientWidth = 399
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  DesignSize = (
    399
    284)
  PixelsPerInch = 96
  TextHeight = 13
  object btnClose: TButton
    Left = 320
    Top = 255
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 240
    Top = 255
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1050
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 5
    Top = 5
    Width = 391
    Height = 245
    ActivePage = TabSheet4
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1099#1077
      object p1: TPanel
        Left = 0
        Top = 0
        Width = 383
        Height = 217
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object GroupBox1: TGroupBox
          Left = 7
          Top = 5
          Width = 371
          Height = 116
          Caption = ' '#1047#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102' '
          TabOrder = 0
          object Label1: TLabel
            Left = 7
            Top = 95
            Width = 292
            Height = 13
            Caption = #1061#1088#1072#1085#1080#1090#1100' '#1080#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1080' '#1087#1072#1088#1086#1083#1100' '#1079#1076#1077#1089#1100' '#1085#1077' '#1073#1077#1079#1086#1087#1072#1089#1085#1086
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 7
            Top = 15
            Width = 177
            Height = 13
            Caption = #1050#1072#1090#1072#1083#1086#1075' '#1075#1076#1077' '#1083#1077#1078#1072#1090' '#1086#1089#1085#1086#1074#1085#1099#1077' '#1073#1072#1079#1099
          end
          object leUserName: TLabeledEdit
            Left = 7
            Top = 70
            Width = 176
            Height = 21
            EditLabel.Width = 96
            EditLabel.Height = 13
            EditLabel.Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
            TabOrder = 0
          end
          object leUserPass: TLabeledEdit
            Left = 187
            Top = 70
            Width = 176
            Height = 21
            EditLabel.Width = 38
            EditLabel.Height = 13
            EditLabel.Caption = #1055#1072#1088#1086#1083#1100
            PasswordChar = '*'
            TabOrder = 1
          end
          object cbDefaultPath: TComboBox
            Left = 7
            Top = 30
            Width = 337
            Height = 21
            ItemHeight = 13
            TabOrder = 2
            Text = 'cbDefaultPath'
          end
          object btnSelectPathWork: TButton
            Left = 345
            Top = 30
            Width = 21
            Height = 21
            Caption = '...'
            TabOrder = 3
            OnClick = btnSelectPathWorkClick
          end
        end
        object Panel1: TPanel
          Left = 7
          Top = 130
          Width = 131
          Height = 46
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          object Label2: TLabel
            Left = 96
            Top = 19
            Width = 23
            Height = 13
            Caption = #1084#1080#1085'.'
          end
          object seTimeSave: TSpinEdit
            Left = 10
            Top = 15
            Width = 81
            Height = 22
            MaxLength = 2
            MaxValue = 60
            MinValue = 5
            TabOrder = 0
            Value = 10
          end
        end
        object cbAutoSave: TCheckBox
          Left = 17
          Top = 123
          Width = 107
          Height = 17
          Caption = ' '#1040#1074#1090#1086#1089#1086#1093#1088#1072#1085#1077#1085#1080#1077
          TabOrder = 2
          OnClick = cbAutoSaveClick
        end
        object cbSaveBase: TCheckBox
          Left = 145
          Top = 130
          Width = 136
          Height = 17
          Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1073#1072#1079
          TabOrder = 3
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077
      ImageIndex = 1
      object p2: TPanel
        Left = 0
        Top = 0
        Width = 383
        Height = 217
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object cbBtnCloseAsMinimize: TCheckBox
          Left = 8
          Top = 5
          Width = 329
          Height = 17
          Caption = #1050#1085#1086#1087#1082#1072' '#1079#1072#1082#1088#1099#1090#1100' '#1088#1072#1073#1086#1090#1072#1077#1090' '#1082#1072#1082' "'#1052#1080#1085#1080#1084#1080#1079#1080#1088#1086#1074#1072#1090#1100'"'
          TabOrder = 0
        end
        object cbWarningWhenRemoving: TCheckBox
          Left = 8
          Top = 24
          Width = 329
          Height = 17
          Caption = #1047#1072#1087#1088#1072#1096#1080#1074#1072#1090#1100' '#1087#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077' '#1087#1088#1080' '#1091#1076#1072#1083#1077#1085#1080#1080
          TabOrder = 1
        end
        object cbCheckPresenceBase: TCheckBox
          Left = 8
          Top = 43
          Width = 329
          Height = 17
          Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1085#1072#1083#1080#1095#1080#1103' '#1073#1072#1079
          TabOrder = 2
        end
        object cbUseRelativePath: TCheckBox
          Left = 8
          Top = 62
          Width = 329
          Height = 17
          Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1086#1090#1085#1086#1089#1080#1090#1077#1083#1100#1085#1099#1077' '#1087#1091#1090#1080
          TabOrder = 3
        end
        object cbShowWorkUser: TCheckBox
          Left = 8
          Top = 81
          Width = 329
          Height = 17
          Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1088#1072#1073#1086#1090#1072#1102#1097#1080#1093' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
          TabOrder = 4
        end
        object cbDelBaseRegistry: TCheckBox
          Left = 8
          Top = 100
          Width = 329
          Height = 17
          Caption = #1059#1076#1072#1083#1077#1085#1080#1077' '#1073#1072#1079' '#1080#1079' '#1088#1077#1077#1089#1090#1088#1072' '#1087#1088#1080' '#1091#1076#1072#1083#1077#1085#1080#1080' '#1080#1093' '#1080#1079' '#1089#1087#1080#1089#1082#1072
          TabOrder = 5
        end
        object cbMinimizeAfterStartBase: TCheckBox
          Left = 8
          Top = 119
          Width = 329
          Height = 17
          Caption = #1057#1074#1086#1088#1072#1095#1080#1074#1072#1090#1100#1089#1103' '#1087#1086#1089#1083#1077' '#1079#1072#1087#1091#1089#1082#1072' '#1073#1072#1079#1099
          TabOrder = 6
        end
        object cbRegisterMD: TCheckBox
          Left = 8
          Top = 138
          Width = 329
          Height = 17
          Caption = #1056#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100' '#1088#1072#1089#1096#1080#1088#1077#1085#1080#1077' *.MD '#1079#1072' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077#1084
          TabOrder = 7
        end
        object cbLoadTogetherWindows: TCheckBox
          Left = 8
          Top = 157
          Width = 329
          Height = 17
          Caption = #1047#1072#1075#1088#1091#1078#1072#1090#1100#1089#1103' '#1074#1084#1077#1089#1090#1077' '#1089' Windows'
          TabOrder = 8
        end
        object cbAutoExpand: TCheckBox
          Left = 8
          Top = 195
          Width = 328
          Height = 17
          Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1088#1072#1079#1074#1077#1088#1090#1099#1074#1072#1085#1080#1077' '#1074#1077#1090#1086#1082
          TabOrder = 9
        end
        object cbMinimizeAfterStart: TCheckBox
          Left = 8
          Top = 176
          Width = 328
          Height = 17
          Caption = #1057#1074#1086#1088#1072#1095#1080#1074#1072#1090#1100#1089#1103' '#1087#1088#1080' '#1079#1072#1087#1091#1089#1082#1077
          TabOrder = 10
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1043#1086#1088#1103#1095#1080#1080' '#1082#1083#1072#1074#1080#1096#1080
      ImageIndex = 2
      object p3: TPanel
        Left = 0
        Top = 0
        Width = 383
        Height = 217
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object Label5: TLabel
          Left = 10
          Top = 13
          Width = 151
          Height = 13
          Caption = #1044#1083#1103' '#1074#1086#1086#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1103' '#1080#1079' '#1090#1088#1077#1103':'
        end
        object Label6: TLabel
          Left = 10
          Top = 38
          Width = 223
          Height = 13
          Caption = #1044#1083#1103' '#1079#1072#1087#1091#1089#1082#1072' "1'#1057'" '#1074' '#1088#1077#1078#1080#1084#1077' "'#1055#1088#1077#1076#1087#1088#1080#1103#1090#1080#1077'"'
        end
        object Label7: TLabel
          Left = 10
          Top = 88
          Width = 228
          Height = 13
          Caption = #1044#1083#1103' '#1079#1072#1087#1091#1089#1082#1072' "1'#1057'" '#1074' '#1088#1077#1078#1080#1084#1077' "'#1050#1086#1085#1092#1080#1075#1091#1088#1072#1090#1086#1088'"'
        end
        object Label8: TLabel
          Left = 10
          Top = 113
          Width = 204
          Height = 13
          Caption = #1044#1083#1103' '#1079#1072#1087#1091#1089#1082#1072' "1'#1057'" '#1074' '#1088#1077#1078#1080#1084#1077' "'#1054#1090#1083#1072#1076#1095#1080#1082'"'
        end
        object Label9: TLabel
          Left = 10
          Top = 138
          Width = 200
          Height = 13
          Caption = #1044#1083#1103' '#1079#1072#1087#1091#1089#1082#1072' "1'#1057'" '#1074' '#1088#1077#1078#1080#1084#1077' "'#1052#1086#1085#1080#1090#1086#1088'"'
        end
        object Label10: TLabel
          Left = 10
          Top = 63
          Width = 244
          Height = 13
          Caption = #1044#1083#1103' '#1079#1072#1087#1091#1089#1082#1072' "1'#1057'" '#1074' '#1088#1077#1078#1080#1084#1077' "'#1055#1088#1077#1076#1087#1088#1080#1103#1090#1080#1077' ('#1052')" '
        end
        object hk1: THotKey
          Tag = 1
          Left = 260
          Top = 10
          Width = 116
          Height = 19
          HotKey = 32833
          TabOrder = 0
          OnChange = ChangeHotKey
        end
        object hk2: THotKey
          Tag = 2
          Left = 260
          Top = 35
          Width = 116
          Height = 19
          HotKey = 32833
          TabOrder = 1
          OnChange = ChangeHotKey
        end
        object hk4: THotKey
          Tag = 4
          Left = 260
          Top = 85
          Width = 116
          Height = 19
          HotKey = 32833
          TabOrder = 2
          OnChange = ChangeHotKey
        end
        object hk5: THotKey
          Tag = 5
          Left = 260
          Top = 110
          Width = 116
          Height = 19
          HotKey = 32833
          TabOrder = 3
          OnChange = ChangeHotKey
        end
        object hk6: THotKey
          Tag = 6
          Left = 260
          Top = 135
          Width = 116
          Height = 19
          HotKey = 32833
          TabOrder = 4
          OnChange = ChangeHotKey
        end
        object hk3: THotKey
          Tag = 3
          Left = 260
          Top = 60
          Width = 116
          Height = 19
          HotKey = 32833
          TabOrder = 5
          OnChange = ChangeHotKey
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #1055#1091#1090#1080' '#1082' '#1087#1088#1086#1075#1088#1072#1084#1084#1072#1084
      ImageIndex = 3
      object p4: TPanel
        Left = 0
        Top = 0
        Width = 383
        Height = 217
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object sgrdPath1C: TapxStringGrid
          Left = 1
          Top = 30
          Width = 381
          Height = 186
          Align = alClient
          ColCount = 3
          DefaultRowHeight = 18
          FixedCols = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
          ParentFont = False
          TabOrder = 1
          OnDrawCell = sgrdPath1CDrawCell
          Labels.Strings = (
            #1057#1089#1099#1083#1082#1072
            ' '
            ' '
            ' '
            ' ')
          Titles.Strings = (
            #1057#1089#1099#1083#1082#1072
            ' '
            #1055#1091#1090#1100' '#1082' '#1087#1088#1086#1075#1088#1072#1084#1084#1077)
          ColWidths = (
            115
            23
            222)
          RowHeights = (
            18
            18
            18
            18
            18)
        end
        object cbSelectPath: TComboBox
          Left = 147
          Top = 64
          Width = 225
          Height = 21
          AutoDropDown = True
          ItemHeight = 13
          TabOrder = 0
          Visible = False
          OnCloseUp = cbSelectPathCloseUp
          OnDropDown = cbSelectPathDropDown
        end
        object ToolBar1: TToolBar
          Left = 1
          Top = 1
          Width = 381
          Height = 29
          Caption = 'ToolBar1'
          Images = frm1CRun.ImageList
          TabOrder = 2
          object btnAdd: TToolButton
            Left = 0
            Top = 2
            Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1091#1090#1100' '#1082' '#1080#1089#1087#1086#1083#1085#1103#1077#1084#1086#1084#1091' '#1092#1072#1081#1083#1091' 1'#1057
            Caption = 'btnAdd'
            ImageIndex = 4
            OnClick = btnAddClick
          end
          object btnDelete: TToolButton
            Left = 23
            Top = 2
            Hint = #1059#1076#1072#1083#1080#1090#1100
            Caption = 'btnDelete'
            ImageIndex = 7
          end
        end
      end
    end
  end
end
