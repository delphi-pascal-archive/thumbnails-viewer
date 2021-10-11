Thumbnails - afficher des images sous la forme de vignettes-----------------------------------------------------------
Url     : http://codes-sources.commentcamarche.net/source/25701-thumbnails-afficher-des-images-sous-la-forme-de-vignettesAuteur  : RUELEPICDate    : 03/08/2013
Licence :
=========

Ce document intitulé « Thumbnails - afficher des images sous la forme de vignettes » issu de CommentCaMarche
(codes-sources.commentcamarche.net) est mis à disposition sous les termes de
la licence Creative Commons. Vous pouvez copier, modifier des copies de cette
source, dans les conditions fixées par la licence, tant que cette note
apparaît clairement.

Description :
=============

Exemple de d&eacute;rivation d'un TPanel pour afficher des images en petit forma
t, en g&eacute;rant un scrolling progressif et donc &eacute;conomiseur de ressou
rces.
<br />Les images ne sont lues que lorsqu'elles sont affich&eacute;es et r
edimensionn&eacute;es au format d&eacute;fini avant de l'&ecirc;tre : utile si l
'on a des r&eacute;pertoires contenant beaucoup d'images.
<br />Les composants 
cr&eacute;es sont 
<br />- TThumbs : Le panel principal, &agrave; glisser sur u
ne fiche.
<br />- TThumb : La vignette elle-m&ecirc;me.
<br />
<br />Pour exe
mple, d&eacute;rivation de l'&eacute;v&eacute;nement OnClick du TPanel pour d&ea
cute;terminer quelle vignette a &eacute;t&eacute; cliqu&eacute;e.
<br />
<br /
>Voil&agrave;. Les autres propriet&eacute;s sont l&agrave; pour gestion minimale
 de la pr&eacute;sentation, &agrave; vous de d&eacute;velopper !
<br />
<br />
- Ev&eacute;nement OnProgress : permet d'afficher la progression du preview en c
ours.
<br />
<br />- TitreString : Le titre du label de la vignette.
<br />- 
TitreAlignement : Align&eacute; en haut ou en bas.
<br />- LargeurThumb, Hauteu
rThumb : La taille des vignettes.
<br />- BordureThumb : Bordure de la vignette
.
<br />- EspaceX, EspaceY : L'espace horizontal et vertical entre chaque vigne
tte.
<br />
<br />etc...
<br />
<br />La liste des propri&eacute;t&eacute;s 
est dans le code ci-dessous, issu du projet d'exemple.
<br /><a name='source-ex
emple'></a><h2> Source / Exemple : </h2>
<br /><pre class='code' data-mode='ba
sic'>
procedure TFThumb.Button1Click(Sender: TObject);
begin
  If OpenDialog1
.Execute then
  With Thumbs do
  Begin
    RepertoireCourant:=ExtractFileDir(
OpenDialog1.FileName);
    nbfichiers.Caption:=Inttostr(NombreFichiers);  
   
 IsInited:=false ;
    EspaceX:=SpinEdit3.value ;
    EspaceY:=SpinEdit4.value
 ;
    HauteurThumb:=SpinEdit1.Value;
    LargeurThumb:=SpinEdit1.Value;
    
Color:=colorBox1.Selected;
    CouleurThumbs:=colorBox2.Selected;
    CouleurT
itre:=colorBox3.Selected ;
    Font.color:=colorBox4.Selected ;
    TitreVisib
le:=checkBox2.checked ;
    ImagesTransparentes:=CheckBox4.Checked;
    Bordur
eThumbs:=CheckBox5.Checked;
    BordureTitre:=CheckBox6.Checked ;
    if check
Box1.Checked then Thumbs.TitreAlignement:=albottom
    else Thumbs.TitreAlignem
ent:=altop;
    Affiche ;
  End ;
end;
</pre>
<br /><a name='conclusion'></
a><h2> Conclusion : </h2>
<br />Pour utiliser les composants, ajouter les unit
&eacute;s UThumbs.pas et UThumb.pas en utilisant le menu &quot;Composants / Ajou
ter un composant&quot; dans un package existant ou dans un nouveau package.
<br
 />Le composant TThumbs est alors install&eacute;.
<br />
<br />Vous pouvez al
ors ouvrir le projet d'exemple Project1.dpr qui contient une fiche et des option
s a modifier.
<br />
<br />Voil&agrave;. C'est un d&eacute;but, &agrave; d&eac
ute;velopper, moi je vais m'en servir de base pour d&eacute;velopper un viewer d
e galeries d'images.
<br />
<br />Seules les images JPG sont reconnues, encore
 une fois c'est &agrave; titre d'exemple, il suffit d'utiliser autre chose qu'un
 TJPEGImage avant de convertir les images en un bitmap r&eacute;duit. (cf la Pro
cedure TThumbs.SetRepertoire(Repertoire: String) dans UThumbs et la Procedure TT
humb.RedimensionneImage (Source : TJpegImage ; Dest : TBitmap) dans UThumb.
<br
 />
<br />Voil&agrave;...
