unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, ComCtrls, UThumbs;

type
  TFThumb = class(TForm)
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    Panel3: TPanel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    ColorBox4: TColorBox;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText7: TStaticText;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    Panel4: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label1: TLabel;
    Label2: TLabel;
    lblignes: TLabel;
    lbcourante: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    nbimages: TLabel;
    nbfichiers: TLabel;
    CheckBox3: TCheckBox;
    Label5: TLabel;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Thumbs: TThumbs;
    Label6: TLabel;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure ColorBox2Change(Sender: TObject);
    procedure ColorBox3Change(Sender: TObject);
    procedure ColorBox4Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure ThumbsClick(Sender: TObject);
    procedure ThumbsProgress(Sender: TObject);
  private
  public
  end;

var
  FThumb: TFThumb;

implementation

{$R *.dfm}

procedure TFThumb.Button1Click(Sender: TObject);
begin
  If OpenDialog1.Execute then
  With Thumbs do
  Begin
    RepertoireCourant:=ExtractFileDir(OpenDialog1.FileName);
    nbfichiers.Caption:=Inttostr(NombreFichiers);  
    IsInited:=false ;
    EspaceX:=SpinEdit3.value ;
    EspaceY:=SpinEdit4.value ;
    HauteurThumb:=SpinEdit1.Value;
    LargeurThumb:=SpinEdit1.Value;
    Color:=colorBox1.Selected;
    CouleurThumbs:=colorBox2.Selected;
    CouleurTitre:=colorBox3.Selected ;
    Font.color:=colorBox4.Selected ;
    titreVisible:=checkBox2.checked ;
    ImagesTransparentes:=CheckBox4.Checked;
    BordureThumbs:=CheckBox5.Checked;
    BordureTitre:=CheckBox6.Checked ;
    if checkBox1.Checked then Thumbs.TitreAlignement:=albottom
    else Thumbs.TitreAlignement:=altop;
    Affiche ;
  End ;
end;

procedure TFThumb.CheckBox1Click(Sender: TObject);
begin
  if checkBox1.Checked then Thumbs.TitreAlignement:=alBottom else Thumbs.TitreAlignement:=altop;
end;

procedure TFThumb.CheckBox2Click(Sender: TObject);
begin
  Thumbs.TitreVisible:=checkBox2.checked;
end;

procedure TFThumb.ColorBox1Change(Sender: TObject);
begin
  thumbs.color:=Colorbox1.Selected;
end;

procedure TFThumb.ColorBox2Change(Sender: TObject);
begin
  thumbs.CouleurThumbs:=Colorbox2.Selected;
end;

procedure TFThumb.ColorBox3Change(Sender: TObject);
begin
  thumbs.CouleurTitre:=Colorbox3.Selected;
end;

procedure TFThumb.ColorBox4Change(Sender: TObject);
begin
  thumbs.Font.color:=Colorbox4.Selected;
end;

procedure TFThumb.Button2Click(Sender: TObject);
begin
  thumbs.DoBegin ;
end;

procedure TFThumb.Button4Click(Sender: TObject);
begin
  thumbs.DoUp ;
end;

procedure TFThumb.Button3Click(Sender: TObject);
begin
  thumbs.DoDown ;
end;

procedure TFThumb.Button5Click(Sender: TObject);
begin
  thumbs.DoEnd ;
end;

procedure TFThumb.CheckBox3Click(Sender: TObject);
begin
  Thumbs.LignesIncompletes:=CheckBox3.checked;
end;

procedure TFThumb.CheckBox4Click(Sender: TObject);
begin
  Thumbs.ImagesTransparentes:=Checkbox4.Checked;
end;

procedure TFThumb.CheckBox5Click(Sender: TObject);
begin
  Thumbs.BordureThumbs:=CheckBox5.Checked;
end;

procedure TFThumb.CheckBox6Click(Sender: TObject);
begin
  Thumbs.BordureTitre:=CheckBox6.Checked;
end;

procedure TFThumb.ThumbsClick(Sender: TObject);
begin
  If (Thumbs.ItemClick=0) then Showmessage ('Click')
  else Showmessage ('Thumb N°'+InttoStr(Thumbs.ItemClick+1)+#13+'Fichier '+Thumbs.Fichiers[Thumbs.ItemClick]+#13+'Taille '+Thumbs.Tailles[Thumbs.ItemClick]+#13+'Dimensions '+Thumbs.Dimensions[Thumbs.ItemClick]) ;
end;

procedure TFThumb.ThumbsProgress(Sender: TObject);
begin
  ProgressBar1.Max:=Thumbs.Maximum ;
  ProgressBar1.Position:=Thumbs.position;
  lblignes.caption:=InttoStr(Thumbs.Lignes);
  lbcourante.caption:=InttoStr(Thumbs.current+1);
  nbimages.caption:=InttoStr(Thumbs.Maximum);
end;

end.
