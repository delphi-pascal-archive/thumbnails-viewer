program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {FThumb},
  UThumb in 'UThumb.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFThumb, FThumb);
  Application.Run;
end.
