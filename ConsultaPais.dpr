program ConsultaPais;

uses
  Vcl.Forms,
  uTelaPrincipal in 'uTelaPrincipal.pas' {GeoInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TGeoInfo, GeoInfo);
  Application.Run;
end.
