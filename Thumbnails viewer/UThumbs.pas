unit UThumbs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math, ExtCtrls,Jpeg;

type
   TThumbs = class (TPanel)
   Private
    FHauteurThumb: smallint;
    FLargeur: smallint;
    FLargeurThumb: smallint;
    FHauteur: smallint;
    Thumbs : TList ;
    Images : TList ;
    FNombreFichiers: integer;
    FRepertoireCourant: string;
    FCouleurtitre: TColor;
    FThumbsVisible: Boolean;
    IsDrawing : Boolean ;
    StopDrawing : Boolean ;
    nblarg  : smallint ;
    nbhaut  : smallint ;
    OldPosV : Smallint ;
    FTitreAlignement: TAlign;
    FOnProgress: TNotifyevent;
    FPosition: smallint;
    FMaximum: smallint;
    FCouleurThumbs: TColor;
    FTitreVisible: boolean;
    FEspaceY: smallint;
    FEspaceX: smallint;
    FIsInited: boolean;
    FNbLignes : smallint ;
    FOnresize : TNotifyEvent ;
    FLignesIncompletes: Boolean;
    FImagesTransparentes: Boolean;
    FBordureTitre: Boolean;
    FBordureThumbs: Boolean;
    FOnClick: TNotifyEvent;

    procedure SetHauteur(const Value: smallint);
    procedure SetHauteurThumb(const Value: smallint);
    procedure SetLargeur(const Value: smallint);
    procedure SetLargeurThumb(const Value: smallint);
    procedure SetNombreFichiers(const Value: integer);
    Procedure SetRepertoire (Repertoire : String) ;
    procedure SetCouleurtitre(const Value: TColor);
    procedure SetThumbsVisible(const Value: Boolean);
    Procedure DimensionneScrollBars ;
    Procedure Scrolling (nblignes:smallint);
    procedure SetTitreAlignement(const Value: TAlign);
    procedure SetCouleurThumbs(const Value: TColor);
    procedure SetEspaceX(const Value: smallint);
    procedure SetEspaceY(const Value: smallint);
    procedure SetTitreVisible(const Value: boolean);
    procedure SetIsInited(const Value: boolean);
    Procedure ViderItems;
    Procedure ViderThumbs;
    Procedure Doresize (Sender:TObject);
    procedure SetLignesIncompletes(const Value: Boolean);
    procedure SetImagesTransparentes(const Value: Boolean);
    procedure SetBordureThumbs(const Value: Boolean);
    procedure SetBordureTitre(const Value: Boolean);

  Public
   ItemClick : smallint ;
   Fichiers : TStringList;
   Tailles  : TStringList;
   Dimensions  : TStringList;
   Constructor Create (AOwner : TComponent); override;
   destructor  Destroy ; override ;
   Function    GetFichiers : TStringList ;
   Procedure   Affiche ;
   Procedure   UpdateImages (index:smallint);
   Procedure   DoDown ;
   Procedure   DoUp ;
   Procedure   DoBegin ;
   Procedure   DoEnd ;
   Procedure   ClickItem (Sender : TObject);

  Published
   Property OnProgress : TNotifyevent Read FOnProgress write FOnprogress ;
   property OnResize : TNotifyEvent read FOnResize write FOnresize;
   property OnClick : TNotifyEvent read FOnClick write FOnClick;

   Property Current : smallint Read OldPosV Write OldPosV ;
   Property Maximum : smallint Read FMaximum Write FMaximum ;
   Property Position : smallint Read FPosition Write FPosition;
   Property Lignes : smallint Read FNbLignes Write FNblignes ;

   Property LignesIncompletes : Boolean
   Read     FLignesIncompletes
   Write    SetLignesIncompletes ;

   Property RepertoireCourant :string
   Read     FRepertoireCourant
   Write    SetRepertoire;

   Property TitreAlignement : TAlign
   Read     FTitreAlignement
   Write    SetTitreAlignement ;

   Property NombreFichiers :integer
   Read     FNombreFichiers
   Write    SetNombreFichiers;

   Property EspaceX :smallint
   Read     FEspaceX
   Write    SetEspaceX;

   Property EspaceY :smallint
   Read     FEspaceY
   Write    SetEspaceY;

   Property IsInited : boolean
   Read     FIsInited
   Write    SetIsInited;

   Property TitreVisible : boolean
   Read     FTitreVisible
   Write    SetTitreVisible;

   Property LargeurThumb : smallint
   Read     FLargeurThumb
   Write    SetLargeurThumb ;

   Property HauteurThumb : smallint
   Read     FHauteurThumb
   Write    SetHauteurThumb ;

   Property Largeur : smallint
   Read     FLargeur
   Write    SetLargeur ;

   Property Hauteur : smallint
   Read     FHauteur
   Write    SetHauteur ;

   Property CouleurThumbs: TColor
   Read     FCouleurThumbs
   Write    SetCouleurThumbs ;

   Property CouleurTitre: TColor
   Read     FCouleurtitre
   Write    SetCouleurtitre ;

   Property ThumbsVisible : Boolean
   Read     FThumbsVisible
   Write    SetThumbsVisible ;

   Property ImagesTransparentes : Boolean
   Read     FImagesTransparentes
   Write    SetImagesTransparentes ;

   Property BordureTitre : Boolean
   Read     FBordureTitre
   Write    SetBordureTitre ;

   Property BordureThumbs : Boolean
   Read     FBordureThumbs
   Write    SetBordureThumbs ;

End ;

Procedure Register ;

implementation

Uses UThumb ;

{ TThumbs }

Constructor TThumbs.Create(AOwner : TComponent) ;
begin
  IsInited:=false ;

  inherited create(AOwner) ;

  inherited OnResize:=doResize;
  inherited OnClick:=ClickItem;

  Parent:=TWinControl (AOwner) ;
  Align:=alClient ;
  Visible:=true;
  Hauteur:=ClientRect.Bottom-ClientRect.Top ;
  Largeur:=ClientRect.Right-ClientRect.Left ;
  FOnProgress:=nil ;
  FOnClick:=nil ;
  ItemClick:=0 ;
  Fichiers:=TStringList.Create ;
  Tailles:=TStringList.Create ;
  Dimensions:=TStringList.Create ;

  Thumbs:=Tlist.Create ;
  Images:=Tlist.Create ;

  LargeurThumb:=64 ;
  HauteurThumb:=64 ;
  DoubleBuffered:=true ;

End;

destructor TThumbs.Destroy;
begin
  ViderItems ;
  Thumbs.Free ;
  Images.free ;
  Fichiers.Free;
  Tailles.free ;
  Dimensions.free;
  inherited destroy ;
end;

procedure TThumbs.DimensionneScrollBars;
begin
  Lignes:=trunc(Nombrefichiers/nblarg)+1;
  If LignesIncompletes then Maximum:=min (nbhaut*nblarg,nombreFichiers)
  Else Maximum:=min ((nbhaut-1)*nblarg,nombreFichiers) ;
End;

function TThumbs.GetFichiers: TStringList;
begin
  Result:=Fichiers ;
end;

procedure TThumbs.Affiche;
Var i : smallint;
    x,y:smallint ;
    imd : TJpegImage ;
    Image : PBitmap ;
    Thumb : PThumb ;
    mx : smallint ;
begin
   If (nombreFichiers=0) then exit ;
   Begin
     Screen.cursor:=crAppstart ;
     Visible:=False ;

     Imd:=TJpegImage.Create ();
     ViderItems ;

     for i:=0 to (NombreFichiers-1) do
     Begin
       New(Image) ;
       Image^:=TBitmap.Create();
       Images.Add(Image);
     End ;

     Try
       nblarg:=trunc((Largeur)/(LargeurThumb+EspaceX+1)) ;
       nbhaut:=trunc((Hauteur)/(HauteurThumb+EspaceY+1))+1;
       x:=-1 ; y:=0 ;
       DimensionneScrollBars ;
       mx:=min(nombrefichiers,nblarg*nbhaut)-1 ;
       For i:=0 to mx do
       Begin
         x:=x+1 ; If x=nblarg then Begin x:=0 ; y:=y+1 ; end ;
         imd.loadFromFile (Fichiers[i]);
         Dimensions[i]:=inttostr(imd.Width)+' x '+Inttostr(imd.Height) ;
         Image:=images[i] ;
         New(Thumb);
         Thumb^:=TThumb.Create(Self);
         Thumb^.Index:=i;         
         Thumb^.Left:=(Thumb^.Largeur+EspaceX)*(x)+EspaceX;
         Thumb^.Top:=(Thumb^.Hauteur+EspaceY)*y+espacey ;
         If (y<nbhaut-1) or (lignesIncompletes) then
         Begin
           Thumb^.TitreString:=ExtractFileName(Fichiers[i]) ;
           Thumb^.TitreHint:=Fichiers[i] ;
           Thumb^.ImageHint:=Dimensions[i] ;
           Thumb^.RedimensionneImage(imd,Image^) ;
           Thumb^.IsVisible:=true ;           
         End
         Else Thumb^.VideImage ;
         Thumbs.Add(Thumb) ;
         Position:=i+1;
         If Assigned (FOnProgress) then FOnprogress (Self);
       End ;
     Finally
      Visible:=true ;
      Imd.free;
      OldPosV:=0 ;
      Position:=0;      
      If Assigned (FOnProgress) then FOnprogress (Self);
      Screen.cursor:=crDefault ;
      IsInited:=true ;            
     End ;
   End ;
End;

procedure TThumbs.UpdateImages(index:smallint);
Var i : smallint;
    x,y:smallint ;
    imd : TJpegImage ;
    Thumb : PThumb ;
    Imag : PBitmap ;
    mx : smallint ;
begin
   If (nombreFichiers=0) or (IsDrawing) or (not IsInited) then exit ;
   Imd:=TJpegImage.Create ();
   IsDrawing:=true ;
   Screen.cursor:=crAppstart ;
   Visible:=false;
   ViderThumbs ;
   Try
     nblarg:=trunc((Largeur)/(LargeurThumb+EspaceX+1)) ;
     nbhaut:=trunc((Hauteur)/(HauteurThumb+EspaceY+1))+1 ;
     x:=-1 ; y:=0 ;
     mx:=min(NombreFichiers,nblarg*nbhaut)-1;
     For i:=0 to mx do
     Begin
       x:=x+1 ; If (x=nblarg) then Begin x:=0 ; y:=y+1 ; end ;
       New(Thumb) ;
       Thumb^:=TThumb.Create(Self);
       Thumb^.Index:=i;       
       Thumb^.Left:=(Thumb^.Largeur+EspaceX)*(x)+EspaceX;
       Thumb^.Top:=(Thumb^.Hauteur+EspaceY)*y+espacey ;
       if ((y<nbhaut-1) or LignesIncompletes) And ((index*nblarg)+i<NombreFichiers) then
       Begin
         Thumb^.TitreString:=ExtractFileName(Fichiers[(index*nblarg)+i]) ;
         Thumb^.TitreHint:=Fichiers[(index*nblarg)+i] ;
         Imag:=Images[(index*nblarg)+i];
         If (Imag^.Empty) then
         Begin
           imd.LoadFromFile(Fichiers[(index*nblarg)+i]);
           Dimensions[(index*nblarg)+i]:=inttostr(imd.Width)+' x '+Inttostr(imd.Height);
           Thumb^.RedimensionneImage(imd,Imag^) ;
         End
         Else Thumb^.DessineImage (Imag^);
         Thumb^.ImageHint:=Dimensions[(index*nblarg)+i];
         Thumb^.IsVisible:=true ;
       End
       Else Thumb^.VideImage ;
       Thumbs.Add(Thumb) ;
       Position:=i+1;
       If Assigned (FOnProgress) then FOnprogress (Self);
     End ;
     Visible:=true ;
     DimensionneScrollBars ;
   Finally
    Imd.free;
    OldPosV:=index ;
    Position:=0;
    If Assigned (FOnProgress) then FOnprogress (Self);
    IsDrawing:=false ;
    Screen.cursor:=crDefault ;            
   End ;
End;

procedure TThumbs.Scrolling(nblignes:smallint);
Var i : smallint ;
    imd : TJpegImage ;
    Thumb : PThumb ;
    Imag : PBitmap ;
    mx : smallint ;
begin
   If IsDrawing or (not IsInited) then exit ;
   Imd:=TJpegImage.Create ;
   Try
     OldPosV:=OldPosV+nblignes ;
     mx:=min(NombreFichiers,nblarg*nbhaut)-1;
     For i:=0 to mx do
     Begin
       Application.Processmessages ;
       Thumb:=Thumbs[i] ;
       if ((OldPosV*nblarg)+i>=nombreFichiers) or ((not LignesIncompletes) And (i>=(nblarg*(nbhaut-1)))) then Thumb^.VideImage
       Else
       Begin
         Thumb^.TitreString:=ExtractFileName(Fichiers[(OldPosV*nblarg)+i]) ;
         Thumb^.TitreHint:=Fichiers[(OldPosV*nblarg)+i] ;
         Imag:=Images[(OldPosV*nblarg)+i] ;
         If (Imag^.empty) then
         Begin
           imd.LoadFromFile(Fichiers[(OldPosV*nblarg)+i]);
           Dimensions[(OldPosV*nblarg)+i]:=inttostr(imd.Width)+' x '+Inttostr(imd.Height);
           Thumb^.RedimensionneImage(imd,Imag^) ;
         End
         Else
         Begin
           Thumb^.DessineImage(Imag^) ;
         End ;
         Thumb^.ImageHint:=Dimensions[(OldPosV*nblarg)+i];
         Thumb^.IsVisible:=true ;
       End ;
       Position:=i+1;
       If Assigned (FOnProgress) then FOnprogress (Self);
     End ;
     Position:=0;
     If Assigned (FOnProgress) then FOnprogress (Self);
   Finally
   Imd.free ;
   End ;
End;

procedure TThumbs.SetCouleurtitre(const Value: TColor);
var i : smallint ;
    Thumb : PThumb ;
begin
  FCouleurtitre := Value;
  For i:=0 to Thumbs.count-1 do
  Begin
    Thumb:=Thumbs[i] ;
    Thumb^.CouleurTitre:=Value ;
  End ;
end;

procedure TThumbs.SetHauteur(const Value: smallint);
begin
  FHauteur := Value;
End;

procedure TThumbs.SetHauteurThumb(const Value: smallint);
begin
  FHauteurThumb := Value;
end;

procedure TThumbs.SetLargeur(const Value: smallint);
begin
  FLargeur := Value;
end;

procedure TThumbs.SetLargeurThumb(const Value: smallint);
begin
  FLargeurThumb := Value;
end;

procedure TThumbs.SetNombreFichiers(const Value: integer);
begin
  FNombreFichiers := Value;
end;

Procedure TThumbs.SetRepertoire(Repertoire: String);
var sr : TSearchRec ;
begin
  FNombreFichiers:=0 ;
  If Copy(Repertoire,Length(Repertoire),1)='\' then FRepertoireCourant:=Repertoire
  Else FRepertoireCourant:=Repertoire+'\' ;
  if FindFirst(FRepertoireCourant+'*.*',faAnyFile,sr) = 0 then
  Try
    Fichiers.Clear ;
    Tailles.Clear ;
    Dimensions.Clear ;
    repeat
       If UPPERCASE(ExtractFileExt(sr.name))='.JPG' then
       Begin
         Fichiers.Add(RepertoireCourant+sr.Name);
         Tailles.Add(Inttostr(trunc(sr.Size/1024))+' ko');
         Dimensions.add('');
         FNombreFichiers:=FNombreFichiers+1;
       End ;
     until FindNext(sr) <> 0;
  Finally
    FindClose(sr);
  End ;
end;


procedure TThumbs.SetThumbsVisible(const Value: Boolean);
var i : smallint;
    Thumb : PThumb ;
begin
  FThumbsVisible := Value;
  For i:=0 to Thumbs.count-1 do
  Begin
    Thumb:=Thumbs[i] ;
    Thumb^.Isvisible:=Value ;
    If StopDrawing then Exit ;
    Application.Processmessages ;
  End ;
end;

procedure TThumbs.SetTitreAlignement(const Value: TAlign);
var i :smallint ;
    Thumb : PThumb ;
begin
  FTitreAlignement := Value;
  For i:=0 to Thumbs.count-1 do
  Begin
    Thumb:=Thumbs[i] ;
    Thumb^.TitreAlignement:=Value ;
  End ;
End;

procedure TThumbs.SetCouleurThumbs(const Value: TColor);
Var i :smallint ;
    Thumb : Pthumb ;
begin
  FCouleurThumbs := Value;
  For i:=0 to Thumbs.count-1 do
  Begin
    Thumb:=Thumbs[i] ;
    Thumb^.Couleur:=Value ;
  End ;
  UpdateImages(0);  
end;

procedure TThumbs.SetEspaceX(const Value: smallint);
begin
  FEspaceX := Value;
  UpdateImages (OldPosV);
end;

procedure TThumbs.SetEspaceY(const Value: smallint);
begin
  FEspaceY := Value;
  UpdateImages (OldPosV);
end;

procedure TThumbs.SetTitreVisible(const Value: boolean);
var i :smallint ;
    Thumb : PThumb ;
begin
  FTitreVisible := Value;
  For i:=0 to Thumbs.count-1 do
  Begin
    Thumb:=Thumbs[i] ;
    Thumb^.TitreVisible:=Value ;
  End ;
  UpdateImages (OldPosV);
end;

procedure TThumbs.SetIsInited(const Value: boolean);
begin
  FIsInited := Value;
end;

procedure TThumbs.ViderItems;
var i :smallint ;
    Imag : PBitmap ;
begin

 ViderThumbs ;

 For i:=Images.count-1 downto 0 do
 Begin
   If (Images[i]<>nil) then
   Begin
    Imag:=Images[i] ;
    Imag^.free ;
    Dispose (Images[i]) ;
   End ;
   Images.Delete(i);
 End ;
end;

procedure TThumbs.ViderThumbs;
var i :smallint ;
    Thumb : PThumb ;
begin
 For i:=Thumbs.count-1 downto 0 do
 Begin
   If (Thumbs[i]<>nil) then
   Begin
     Thumb:=Thumbs[i] ;
     thumb^.free ;
     Dispose (Thumbs[i]) ;
   End ;
   Thumbs.Delete(i);   
 End ;
end;

procedure TThumbs.DoResize;
begin
  if Assigned(FOnresize) then FOnResize(sender);
  Hauteur:=Self.height ;
  Largeur:=Self.Width ;
  UpdateImages(0);
end;

procedure TThumbs.DoBegin;
begin
  if (OldPosV>0) then Scrolling(-oldPosV);
end;

procedure TThumbs.DoDown;
begin
  If (oldPosv<Lignes-nbhaut+1) then Scrolling(+1);
end;

procedure TThumbs.DoEnd;
begin
  If (oldPosv<Lignes-nbhaut+1) then Scrolling (Lignes-nbhaut+1-OldPosV);
end;

procedure TThumbs.DoUp;
begin
  If (oldPosv>0) then Scrolling(-1);
end;

procedure Register;
begin
  RegisterComponents('Standard', [TThumbs]);
end;

procedure TThumbs.SetLignesIncompletes(const Value: Boolean);
begin
  FLignesIncompletes := Value;
  UpdateImages(OldPosV);
end;

procedure TThumbs.SetImagesTransparentes(const Value: Boolean);
var i :smallint ;
    Thumb : PThumb ;
begin
  FImagesTransparentes := Value;
  For i:=0 to Thumbs.count-1 do
  Begin
    Thumb:=Thumbs[i] ;
    Thumb^.ImageTransparente:=Value ;
  End ;
End;

procedure TThumbs.SetBordureThumbs(const Value: Boolean);
var i :smallint ;
    Thumb : PThumb ;
begin
  FBordureThumbs := Value;
  For i:=0 to Thumbs.count-1 do
  Begin
    Thumb:=Thumbs[i] ;
    Thumb^.BordureThumb:=Value ;
  End ;
end;

procedure TThumbs.SetBordureTitre(const Value: Boolean);
var i :smallint ;
    Thumb : PThumb ;
begin
  FBordureTitre := Value;
  For i:=0 to Thumbs.count-1 do
  Begin
    Thumb:=Thumbs[i] ;
    Thumb^.BordureTitre:=Value ;
  End ;
end;

procedure TThumbs.ClickItem(Sender: TObject);
begin
  If IsInited then
    if Assigned (FOnClick) then FOnclick (Sender);
end;

End.
