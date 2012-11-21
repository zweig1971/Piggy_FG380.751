object Test_AutomaticTesTForm: TTest_AutomaticTesTForm
  Left = 552
  Top = 207
  Width = 329
  Height = 627
  AutoSize = True
  Caption = 'AutomaticTesT FG380.751'
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 20
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 321
    Height = 593
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 72
      Top = 16
      Width = 65
      Height = 24
      Caption = 'Lfd.Nr.: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Panel3: TPanel
      Left = 0
      Top = 56
      Width = 321
      Height = 489
      BevelInner = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Bevel5: TBevel
        Left = 173
        Top = 97
        Width = 129
        Height = 41
      end
      object Bevel6: TBevel
        Left = 173
        Top = 145
        Width = 129
        Height = 41
      end
      object Bevel7: TBevel
        Left = 173
        Top = 193
        Width = 129
        Height = 41
      end
      object Bevel2: TBevel
        Left = 16
        Top = 145
        Width = 153
        Height = 41
      end
      object Bevel1: TBevel
        Left = 16
        Top = 193
        Width = 153
        Height = 41
      end
      object Test2Shape: TShape
        Left = 130
        Top = 152
        Width = 31
        Height = 26
        Shape = stCircle
      end
      object Label6: TLabel
        Left = 24
        Top = 153
        Width = 59
        Height = 24
        Caption = 'Test 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 24
        Top = 201
        Width = 59
        Height = 24
        Caption = 'Test 3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Test3Shape: TShape
        Left = 130
        Top = 200
        Width = 31
        Height = 26
        Shape = stCircle
      end
      object Bevel4: TBevel
        Left = 16
        Top = 97
        Width = 153
        Height = 41
      end
      object Label9: TLabel
        Left = 24
        Top = 105
        Width = 59
        Height = 24
        Caption = 'Test 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Test1Shape: TShape
        Left = 130
        Top = 104
        Width = 31
        Height = 26
        Shape = stCircle
      end
      object Label10: TLabel
        Left = 81
        Top = 13
        Width = 160
        Height = 25
        AutoSize = False
        Caption = ' -  Test Status - '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Test1Label: TLabel
        Left = 197
        Top = 105
        Width = 77
        Height = 24
        Caption = '..ready..'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Test2Label: TLabel
        Left = 197
        Top = 153
        Width = 77
        Height = 24
        Caption = '..ready..'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Test3Label: TLabel
        Left = 197
        Top = 201
        Width = 77
        Height = 24
        Caption = '..ready..'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 16
        Top = 299
        Width = 56
        Height = 16
        Caption = 'Legende'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel3: TBevel
        Left = 16
        Top = 240
        Width = 153
        Height = 41
      end
      object Test4Shape: TShape
        Left = 130
        Top = 247
        Width = 31
        Height = 26
        Shape = stCircle
      end
      object Bevel8: TBevel
        Left = 173
        Top = 240
        Width = 129
        Height = 41
      end
      object Label2: TLabel
        Left = 24
        Top = 248
        Width = 59
        Height = 24
        Caption = 'Test 4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Test4Label: TLabel
        Left = 197
        Top = 248
        Width = 77
        Height = 24
        Caption = '..ready..'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object NextIFKButton: TButton
        Left = 72
        Top = 428
        Width = 185
        Height = 41
        Caption = 'Nächstes Piggy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = NextIFKButtonClick
      end
      object ProgramTestVerPanel: TPanel
        Left = 16
        Top = 51
        Width = 285
        Height = 41
        BevelInner = bvLowered
        TabOrder = 1
        object ProgramTestVerLabel: TLabel
          Left = 16
          Top = 9
          Width = 212
          Height = 24
          Caption = '       Programmiere IFK'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object Legende_ListBox: TListBox
        Left = 16
        Top = 323
        Width = 289
        Height = 93
        Color = clBtnFace
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = [fsBold]
        ItemHeight = 13
        ParentFont = False
        TabOrder = 2
      end
    end
    object LfdNrPanel: TPanel
      Left = 136
      Top = 12
      Width = 112
      Height = 33
      BevelInner = bvLowered
      Caption = '1234567890'
      TabOrder = 1
    end
    object EndTesTButton: TButton
      Left = 184
      Top = 553
      Width = 129
      Height = 25
      Caption = 'END TEST'
      TabOrder = 2
      OnClick = EndTesTButtonClick
    end
  end
end
