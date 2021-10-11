object FThumb: TFThumb
  Left = 236
  Top = 128
  Width = 723
  Height = 552
  Caption = 'Thumbnails viewer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clNavy
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 17
  object Panel1: TPanel
    Left = 0
    Top = 309
    Width = 715
    Height = 215
    Align = alBottom
    TabOrder = 0
    object ProgressBar1: TProgressBar
      Left = 1
      Top = 192
      Width = 713
      Height = 22
      Align = alBottom
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 502
      Height = 191
      Align = alLeft
      TabOrder = 1
      object Label5: TLabel
        Left = 180
        Top = 166
        Width = 128
        Height = 17
        Caption = 'les lignes incompletes'
      end
      object SpinEdit1: TSpinEdit
        Left = 357
        Top = 3
        Width = 69
        Height = 27
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 100
      end
      object SpinEdit2: TSpinEdit
        Left = 428
        Top = 3
        Width = 69
        Height = 27
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 100
      end
      object ColorBox1: TColorBox
        Left = 144
        Top = 4
        Width = 144
        Height = 22
        Selected = 14155775
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbIncludeDefault, cbCustomColor, cbPrettyNames]
        Color = clWhite
        ItemHeight = 16
        TabOrder = 2
        OnChange = ColorBox1Change
      end
      object ColorBox2: TColorBox
        Left = 144
        Top = 38
        Width = 144
        Height = 22
        Selected = clSilver
        ItemHeight = 16
        TabOrder = 3
        OnChange = ColorBox2Change
      end
      object ColorBox3: TColorBox
        Left = 144
        Top = 72
        Width = 144
        Height = 22
        Selected = clNavy
        ItemHeight = 16
        TabOrder = 4
        OnChange = ColorBox3Change
      end
      object StaticText1: TStaticText
        Left = 4
        Top = 8
        Width = 51
        Height = 21
        Caption = 'Couleur'
        TabOrder = 5
      end
      object StaticText2: TStaticText
        Left = 4
        Top = 43
        Width = 127
        Height = 21
        Caption = 'Couleur des thumbs'
        TabOrder = 6
      end
      object StaticText3: TStaticText
        Left = 4
        Top = 77
        Width = 99
        Height = 21
        Caption = 'Couleur du titre'
        TabOrder = 7
      end
      object ColorBox4: TColorBox
        Left = 144
        Top = 103
        Width = 144
        Height = 22
        Selected = clWhite
        ItemHeight = 16
        TabOrder = 8
        OnChange = ColorBox4Change
      end
      object StaticText4: TStaticText
        Left = 4
        Top = 109
        Width = 128
        Height = 21
        Caption = 'Couleur font du titre'
        TabOrder = 9
      end
      object StaticText5: TStaticText
        Left = 293
        Top = 8
        Width = 56
        Height = 21
        Caption = 'Taille X,Y'
        TabOrder = 10
      end
      object StaticText7: TStaticText
        Left = 293
        Top = 41
        Width = 61
        Height = 21
        Caption = 'Inter. X,Y'
        TabOrder = 11
      end
      object SpinEdit3: TSpinEdit
        Left = 357
        Top = 35
        Width = 69
        Height = 27
        MaxValue = 0
        MinValue = 0
        TabOrder = 12
        Value = 10
      end
      object SpinEdit4: TSpinEdit
        Left = 428
        Top = 35
        Width = 69
        Height = 27
        MaxValue = 0
        MinValue = 0
        TabOrder = 13
        Value = 10
      end
      object CheckBox2: TCheckBox
        Left = 5
        Top = 145
        Width = 75
        Height = 17
        Caption = 'Titre'
        Checked = True
        State = cbChecked
        TabOrder = 14
        OnClick = CheckBox2Click
      end
      object CheckBox1: TCheckBox
        Left = 5
        Top = 166
        Width = 166
        Height = 17
        Caption = 'Titre en haut / en bas'
        TabOrder = 15
        OnClick = CheckBox1Click
      end
      object CheckBox3: TCheckBox
        Left = 154
        Top = 145
        Width = 153
        Height = 21
        Caption = 'Afficher / masquer'
        TabOrder = 16
        OnClick = CheckBox3Click
      end
      object CheckBox4: TCheckBox
        Left = 296
        Top = 116
        Width = 119
        Height = 23
        Caption = 'Transparence'
        TabOrder = 17
        OnClick = CheckBox4Click
      end
      object CheckBox5: TCheckBox
        Left = 296
        Top = 71
        Width = 126
        Height = 22
        Caption = 'Bordure thumb'
        TabOrder = 18
        OnClick = CheckBox5Click
      end
      object CheckBox6: TCheckBox
        Left = 296
        Top = 94
        Width = 126
        Height = 22
        Caption = 'Bordure titre'
        TabOrder = 19
        OnClick = CheckBox6Click
      end
    end
    object Panel4: TPanel
      Left = 503
      Top = 1
      Width = 211
      Height = 191
      Align = alClient
      TabOrder = 2
      object Label1: TLabel
        Left = 10
        Top = 10
        Width = 105
        Height = 17
        Caption = 'Nombre de lignes'
      end
      object Label2: TLabel
        Left = 10
        Top = 31
        Width = 91
        Height = 17
        Caption = 'Ligne courante'
      end
      object lblignes: TLabel
        Left = 196
        Top = 10
        Width = 4
        Height = 17
      end
      object lbcourante: TLabel
        Left = 196
        Top = 31
        Width = 4
        Height = 17
      end
      object Label3: TLabel
        Left = 10
        Top = 52
        Width = 162
        Height = 17
        Caption = 'Nombre d'#39'images affichees'
      end
      object Label4: TLabel
        Left = 10
        Top = 72
        Width = 113
        Height = 17
        Caption = 'Nombre de fichiers'
      end
      object nbimages: TLabel
        Left = 196
        Top = 52
        Width = 4
        Height = 17
      end
      object nbfichiers: TLabel
        Left = 196
        Top = 73
        Width = 4
        Height = 17
      end
      object Label6: TLabel
        Left = 1
        Top = 173
        Width = 209
        Height = 17
        Align = alBottom
        Caption = 'Repertoire :'
      end
      object Button1: TButton
        Left = 255
        Top = 51
        Width = 157
        Height = 33
        Caption = 'Go !'
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 256
        Top = 9
        Width = 40
        Height = 33
        Caption = '<<'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 335
        Top = 9
        Width = 39
        Height = 33
        Caption = '>'
        TabOrder = 2
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 296
        Top = 9
        Width = 39
        Height = 33
        Caption = '<'
        TabOrder = 3
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 374
        Top = 9
        Width = 39
        Height = 33
        Caption = '>>'
        TabOrder = 4
        OnClick = Button5Click
      end
    end
  end
  object Thumbs: TThumbs
    Left = 0
    Top = 0
    Width = 715
    Height = 309
    Align = alClient
    Caption = 'Thumbs'
    TabOrder = 1
    OnClick = ThumbsClick
    OnProgress = ThumbsProgress
    Current = 0
    Maximum = 0
    Position = 0
    Lignes = 0
    LignesIncompletes = False
    TitreAlignement = alNone
    NombreFichiers = 0
    EspaceX = 0
    EspaceY = 0
    IsInited = False
    TitreVisible = False
    LargeurThumb = 64
    HauteurThumb = 64
    Largeur = 715
    Hauteur = 309
    CouleurThumbs = clBlack
    CouleurTitre = clBlack
    ThumbsVisible = False
    ImagesTransparentes = False
    BordureTitre = False
    BordureThumbs = False
  end
  object OpenDialog1: TOpenDialog
    Left = 238
    Top = 176
  end
end
