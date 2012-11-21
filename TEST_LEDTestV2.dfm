object Form_LEDTest: TForm_LEDTest
  Left = 959
  Top = 194
  Width = 123
  Height = 539
  AutoSize = True
  Caption = 'LED TEST'
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image_FrontLED: TImage
    Left = 0
    Top = 0
    Width = 95
    Height = 505
    AutoSize = True
  end
  object Shape_LED: TShape
    Left = 8
    Top = 8
    Width = 9
    Height = 13
    Brush.Color = clRed
    Shape = stCircle
  end
  object Timer_LED: TTimer
    Interval = 200
    OnTimer = Timer_LEDTimer
    Left = 96
    Top = 72
  end
end
