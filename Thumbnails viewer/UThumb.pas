unit UThumb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, math, jpeg, UThumbs;

Type

  PThumb=^TThumb ;
  PBitmap=^TBitmap ;

  TThumb = class (TPanel)
    Private
      Image  : TImage;
      Titre  : TStaticText ;
      FCouleurtitre: TColor;
      Fcouleur : TColor ;
      FLargeur: smallint;
      FHauteur: smallint;
      FIsVisible: Boolean;
      FTitreAlignement: TAlign;
      FTitreVisible: boolean;
      FThumbsParent: TThumbs;
      Orientation : Boolean ;
      Decalage : smallint ;
      FTitreHint: string;
      FTitre: string;
      FImageHint: string;
      FImageTransparente: boolean;
      FBordureTitre: Boolean;
      FBordureThumb: Boolean;
      FIndex : Smallint ;

      procedure SetCouleurtitre(const Value: TColor);
      Procedure SetCouleur (C : TColor);
      procedure SetHauteur(const Value: smallint);
      procedure SetLargeur(const Value: smallint);
      procedure SetIsVisible(const Value: Boolean);
      procedure SetTitreAlignement(const Value: TAlign);
      procedure SetTitreVisible(const Value: boolean);
      procedure SetThumbsParent(const Value: TThumbs);
      procedure SetTitre(const Value: string);
      procedure SetTitreHint(const Value: string);
      procedure SetImageHint(const Value: string);
      procedure SetImageTransparente(const Value: Boolean);
      procedure SetBordureTitre(const Value: Boolean);
      procedure SetBordureThumb(const Value: Boolean);
      Procedure SetIndex(value:smallint);
      Procedure ClickItem (Sender:TObject);

    Public

      Constructor Create (AOwner : TComponent) ; override;
      Destructor  Destroy ; override;
      Procedure   RedimensionneImage (Source : TJpegImage ; Dest : TBitmap);
      Procedure   DessineImage (B:Tbitmap);
      Procedure   VideImage ;

    Published

      Property ThumbsParent: TThumbs
      Read     FThumbsParent
      Write    SetThumbsParent ;

      Property IsVisible: Boolean
      Read     FIsVisible
      Write    SetIsVisible ;

      Property TitreAlignement : TAlign
      Read     FTitreAlignement
      Write    SetTitreAlignement ;

      Property TitreVisible : boolean
      Read     FTitreVisible
      Write    SetTitreVisible ;

      Property Couleur: TColor
      Read     FCouleur
      Write    SetCouleur ;

      Property CouleurTitre: TColor
      Read     FCouleurtitre
      Write    SetCouleurtitre ;

      Property Hauteur : smallint
      Read     FHauteur
      Write    SetHauteur;

      Property Largeur : smallint
      Read     FLargeur
      Write    SetLargeur;

      Property Index : smallint
      Read     FIndex
      Write    SetIndex;

      Property TitreString : string
      Read     FTitre
      Write    SetTitre;

      Property TitreHint : string
      Read     FTitreHint
      Write    SetTitreHint;

      Property ImageHint : string
      Read     FImageHint
      Write    SetImageHint;

      Property ImageTransparente : Boolean
      Read     FImageTransparente
      Write    SetImageTransparente;

      Property BordureTitre : Boolean
      Read     FBordureTitre
      Write    SetBordureTitre;

      Property BordureThumb : Boolean
      Read     FBordureThumb
      Write    SetBordureThumb;

End;

implementation

{ TThumb }

constructor TThumb.Create (AOwner : TComponent);
begin
  inherited create(aowner);
  Onclick:=ClickItem;
  Cursor:=crHandPoint ;  

  ThumbsParent:=(AOwner as TThumbs);
  DoubleBuffered:=true ;

  visible:=true;
  ParentFont:=true ;

  Hauteur:=ThumbsParent.HauteurThumb;
  Largeur:=ThumbsParent.LargeurThumb ;

  Image:=TImage.Create(AOwner as TComponent);
  With Image do
  Begin
    Align:=alclient;
    Visible:=false;
    Showhint:=true;
    Center:=true ;
    Transparent:=ThumbsParent.ImagesTransparentes;
    Onclick:=ClickItem;
    cursor:=crHandPoint ;
  End ;
  Image.Parent:=Self ;

  Titre:=TStaticText.Create(AOwner as TComponent);
  With Titre do
  Begin
    TitreVisible:=ThumbsParent.TitreVisible;
    Align:=ThumbsParent.TitreAlignement;
    Alignment:=taCenter;
    Showhint:=true;
    If (Hauteur<=Titre.Height) then TitreVisible:=false;
    Parentfont:=true ;
    Onclick:=ClickItem;
    cursor:=crHandPoint ;
  End ;
  Titre.Parent:=Self ;

  If BordureThumb then BorderStyle:=bsSingle else BorderStyle:=bsnone ;
  If BordureTitre then Titre.BorderStyle:=sbsSingle else Titre.BorderStyle:=sbsnone ;

  BevelOuter:=bvNone ;
  BevelInner:=bvNone ;
  BorderWidth:=0 ;
  Couleur:=ThumbsParent.CouleurThumbs ;
  CouleurTitre:=ThumbsParent.CouleurTitre ;
  DoubleBuffered:=true ;
  
End;

destructor TThumb.Destroy ;
begin
  Image.free;
  Titre.Free;
  inherited destroy ;
end;

procedure TThumb.SetCouleur(C: TColor);
begin
  FCouleur:=C ;
  Self.Color:=C ;
  Image.Picture.Bitmap.Canvas.Brush.Color:=C ;
  invalidate ;
end;

procedure TThumb.SetCouleurtitre(const Value: TColor);
begin
  FCouleurtitre := Value;
  Titre.Color:=Value ;
  titre.Invalidate;
end;

procedure TThumb.SetHauteur(const Value: smallint);
begin
  FHauteur := Value;
  Self.Height:=Value ;
end;

procedure TThumb.SetLargeur(const Value: smallint);
begin
  FLargeur := Value;
  Self.Width:=Value ;
end;

procedure TThumb.RedimensionneImage (Source : TJpegImage ; Dest : TBitmap);
Var bit : TBitmap ;
    Coefh,CoefW : double ;
    dec : smallint;
Begin
  Bit:=Tbitmap.create ;
  Try
    Image.Canvas.Brush.Color:=Couleur ;
    Dest.Width  := Largeur;
    if TitreVisible then Dest.Height := Hauteur-Titre.Height
    Else Dest.Height := Hauteur ;

    coefH:=Source.Height/Dest.Height;
    coefW:=Source.Width/Dest.Width;

    If CoefW>CoefH then
    Begin
       Orientation:=True;
       Bit.Width:=Round(Source.Width/CoefW) ;
       Bit.Height:=Round(Source.Height/CoefW) ;
       dec:=Dest.height-Bit.Height;
       Decalage:=trunc((dec)/2) ;
       Bit.Canvas.StretchDraw(Bit.Canvas.ClipRect,Source);
       Dest.height:=Dest.height-Dec;
       Dest.Canvas.draw(0,0,Bit);
    end
    else
    Begin
       Orientation:=false;
       Bit.Width:=Round(Source.Width/CoefH) ;
       Bit.Height:=Round(Source.Height/CoefH) ;
       dec:=(Dest.Width-Bit.Width) ;
       Decalage:=trunc(dec/2) ;
       Bit.Canvas.StretchDraw(Bit.Canvas.ClipRect,Source);
       Dest.width:=Dest.width-(dec);
       Dest.Canvas.draw(0,0,Bit);
    End ;
    Image.Picture.bitmap.Assign(Dest);
  Finally
    bit.free ;
  End;
End;

procedure TThumb.SetIsVisible(const Value: Boolean);
begin
  FIsVisible := Value;
  Image.visible:=value ;
  Visible:=value ;
end;

procedure TThumb.SetTitreAlignement(const Value:TAlign);
begin
  FTitreAlignement:=Value;
  Titre.align:=Value;
End;

procedure TThumb.SetTitreVisible(const Value: boolean);
begin
  FTitreVisible := Value;
  Titre.Visible :=value ;
end;

procedure TThumb.SetThumbsParent(const Value: TThumbs);
begin
  FThumbsParent := Value;
  Parent:=Value ;
end;


procedure TThumb.SetTitre(const Value: string);
begin
  FTitre := Value;
  Titre.caption:=Value ;
end;

procedure TThumb.SetTitreHint(const Value: string);
begin
  FTitreHint := Value;
  Titre.Hint:=Value ;
end;

procedure TThumb.SetImageHint(const Value: string);
begin
  FImageHint := Value;
  Image.hint:=value ;
end;

procedure TThumb.DessineImage(B: Tbitmap);
begin
  Image.Picture.Bitmap.assign(B) ;
end;

procedure TThumb.VideImage;
begin
  Self.visible:=false ;  
end;

procedure TThumb.SetImageTransparente(const Value: Boolean);
begin
  FImageTransparente := Value;
  Image.Transparent:=value ;
end;

procedure TThumb.SetBordureTitre(const Value: Boolean);
begin
  FBordureTitre := Value;
  If value then Titre.BorderStyle:=sbsSingle else Titre.BorderStyle:=sbsNone;
end;

procedure TThumb.SetBordureThumb(const Value: Boolean);
begin
  FBordureThumb := Value;
  If value then BorderStyle:=bsSingle else BorderStyle:=bsNone;  
end;

procedure TThumb.ClickItem(Sender: TObject);
begin
  ThumbsParent.ItemClick:=Index ;
  ThumbsParent.OnClick (Sender);
  ThumbsParent.ItemClick:=0 ;
end;

procedure TThumb.SetIndex(Value: smallint);
begin
  FIndex:=Value ;
end;

end.
