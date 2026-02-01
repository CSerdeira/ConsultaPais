object GeoInfo: TGeoInfo
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'GeoInfo'
  ClientHeight = 536
  ClientWidth = 869
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object pnlDados: TPanel
    Left = 432
    Top = 0
    Width = 437
    Height = 536
    Align = alRight
    TabOrder = 0
    object lblCapital: TLabel
      Left = 89
      Top = 176
      Width = 37
      Height = 15
      Caption = 'Capital'
    end
    object lblMoeda: TLabel
      Left = 89
      Top = 368
      Width = 89
      Height = 15
      Caption = 'Nome da moeda'
    end
    object lblNomeOficial: TLabel
      Left = 89
      Top = 112
      Width = 68
      Height = 15
      Caption = 'Nome oficial'
    end
    object lblPopulacao: TLabel
      Left = 89
      Top = 304
      Width = 56
      Height = 15
      Caption = 'Popula'#231#227'o'
    end
    object lblRegiao: TLabel
      Left = 89
      Top = 240
      Width = 36
      Height = 15
      Caption = 'Regi'#227'o'
    end
    object edtNomeOficial: TEdit
      Left = 84
      Top = 133
      Width = 273
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtMoeda: TEdit
      Left = 84
      Top = 389
      Width = 273
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtPopulacao: TEdit
      Left = 84
      Top = 325
      Width = 273
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 2
    end
    object edtCapital: TEdit
      Left = 84
      Top = 197
      Width = 273
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 3
    end
    object edtRegiao: TEdit
      Left = 84
      Top = 261
      Width = 273
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 4
    end
  end
  object pnlPesquisa: TPanel
    Left = 0
    Top = 0
    Width = 425
    Height = 536
    Align = alLeft
    TabOrder = 1
    object imgBandeira: TImage
      Left = 72
      Top = 215
      Width = 280
      Height = 146
      Center = True
      Proportional = True
      Stretch = True
    end
    object lblDigite: TLabel
      Left = 72
      Top = 114
      Width = 119
      Height = 15
      Caption = 'Digite o nome do Pa'#237's:'
    end
    object edtPais: TEdit
      Left = 72
      Top = 135
      Width = 200
      Height = 23
      TabOrder = 0
    end
    object btnConsultar: TButton
      Left = 72
      Top = 164
      Width = 200
      Height = 25
      Caption = 'Consultar'
      TabOrder = 1
      OnClick = btnConsultarClick
    end
    object btnLimpar: TButton
      Left = 278
      Top = 135
      Width = 74
      Height = 23
      Caption = 'Limpar'
      TabOrder = 2
      OnClick = btnLimparClick
    end
  end
end
