unit uTelaPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.JSON, System.Net.HttpClient, System.Net.HttpClientComponent, System.NetEncoding,
  System.Net.URLClient, Vcl.Imaging.pngimage;

  //adicionado no uses para criar a bandeira
  //System.Net.URLClient,
  //Vcl.Imaging.pngimage,

type
  TGeoInfo = class(TForm)
    edtPais: TEdit;
    lblDigite: TLabel;
    edtNomeOficial: TEdit;
    edtMoeda: TEdit;
    edtPopulacao: TEdit;
    edtCapital: TEdit;
    edtRegiao: TEdit;
    lblNomeOficial: TLabel;
    lblCapital: TLabel;
    lblRegiao: TLabel;
    lblPopulacao: TLabel;
    lblMoeda: TLabel;
    pnlDados: TPanel;
    imgBandeira: TImage;
    pnlPesquisa: TPanel;
    btnConsultar: TButton;
    btnLimpar: TButton;
    procedure btnConsultarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    function GetCountryJson(const APais: string): string;

    //abaixo o método criado para chamar a BANDEIRA
    procedure LoadFlagFromUrl(const AUrl: string);

  public
    { Public declarations }
  end;

var
  GeoInfo: TGeoInfo;

implementation

{$R *.dfm}

function TGeoInfo.GetCountryJson(const APais: string): string;
var
  Http: TNetHTTPClient;
  Resp: IHTTPResponse;
begin
  Result := '';
  Http := TNetHTTPClient.Create(nil);
  try
    // Força TLS 1.2 (muito comum ser necessário em APIs HTTPS)
    Http.SecureProtocols := [THTTPSecureProtocol.TLS12];

    // 1) tenta por nome
    Resp := Http.Get(
      'https://restcountries.com/v3.1/name/' + TNetEncoding.URL.Encode(APais)
    );

    // 2) fallback se 404
    if Resp.StatusCode = 404 then
      Resp := Http.Get(
        'https://restcountries.com/v3.1/translation/' + TNetEncoding.URL.Encode(APais)
      );

    // 3) valida resposta final
    if Resp.StatusCode <> 200 then
      Exit;

    Result := Resp.ContentAsString(TEncoding.UTF8);
  finally
    Http.Free;
  end;
end;

//adicionado para a implementação da BANDEIRA
procedure TGeoInfo.LoadFlagFromUrl(const AUrl: string);
var
  Client: THTTPClient;
  MS: TMemoryStream;
begin
  imgBandeira.Picture := nil;

  if AUrl.Trim.IsEmpty then
    Exit;

  Client := THTTPClient.Create;
  try
    // Força TLS 1.2 também aqui
    Client.SecureProtocols := [THTTPSecureProtocol.TLS12];

    MS := TMemoryStream.Create;
    try
      // Baixa direto para o stream (compatível em várias versões)
      Client.Get(AUrl, MS);

      MS.Position := 0;

      if MS.Size > 0 then
      begin
        try
          imgBandeira.Picture.LoadFromStream(MS);
        except
          // Se der qualquer problema com a imagem, não quebra a tela
          imgBandeira.Picture := nil;
        end;
      end;
    finally
      MS.Free;
    end;
  finally
    Client.Free;
  end;
end;

procedure TGeoInfo.btnConsultarClick(Sender: TObject);
var
  Pais: string;
  JsonText: string;

  //adicionado para buscar a BANDEIRA
  FlagsObj: TJSONObject;
  UrlBandeira: string;

  JsonValue: TJSONValue;
  Arr: TJSONArray;
  Obj, NameObj, CurrObj, CurrInfo: TJSONObject;
  CapitalArr: TJSONArray;
  Pair: TJSONPair;
begin
  Pais := Trim(edtPais.Text);

  if Pais.IsEmpty then
  begin
    ShowMessage('Digite o nome de um país.');
    edtPais.SetFocus;
    Exit;
  end;

  // Limpa campos
  edtNomeOficial.Clear;
  edtCapital.Clear;
  edtRegiao.Clear;
  edtPopulacao.Clear;
  edtMoeda.Clear;
  imgBandeira.Picture := nil;

  // ✅ Aqui você busca o JSON com TNetHTTPClient
  JsonText := GetCountryJson(Pais);

  if JsonText = '' then
  begin
    ShowMessage('País não encontrado ou API indisponível.');
    Exit;
  end;

  // Parse do JSON
  JsonValue := TJSONObject.ParseJSONValue(JsonText);
  try
    if not Assigned(JsonValue) or not (JsonValue is TJSONArray) then
    begin
      ShowMessage('Resposta inválida da API.');
      Exit;
    end;

    Arr := TJSONArray(JsonValue);
    if Arr.Count = 0 then
    begin
      ShowMessage('País não encontrado.');
      Exit;
    end;

    Obj := Arr.Items[0] as TJSONObject;

    //BANDEIRA
    // Bandeira → flags.png (extra)
    FlagsObj := Obj.GetValue<TJSONObject>('flags');
    if Assigned(FlagsObj) then
    begin
      UrlBandeira := FlagsObj.GetValue<string>('png', '');
      LoadFlagFromUrl(UrlBandeira);
    end;

    // Nome oficial → name.official
    NameObj := Obj.GetValue<TJSONObject>('name');
    if Assigned(NameObj) then
      edtNomeOficial.Text := NameObj.GetValue<string>('official', '');

    // Capital → capital[0]
    CapitalArr := Obj.GetValue<TJSONArray>('capital');
    if Assigned(CapitalArr) and (CapitalArr.Count > 0) then
      edtCapital.Text := CapitalArr.Items[0].Value;

    // Região → region
    edtRegiao.Text := Obj.GetValue<string>('region', '');

    // População → population (pega como inteiro e formata)
    edtPopulacao.Text := FormatFloat('#,##0', Obj.GetValue<Int64>('population'));

    // Moeda → currencies (primeira encontrada)
    CurrObj := Obj.GetValue<TJSONObject>('currencies');
    if Assigned(CurrObj) and (CurrObj.Count > 0) then
    begin
      Pair := CurrObj.Pairs[0];
      CurrInfo := Pair.JsonValue as TJSONObject;

      if Assigned(CurrInfo) then
        edtMoeda.Text := CurrInfo.GetValue<string>('name', Pair.JsonString.Value)
      else
        edtMoeda.Text := Pair.JsonString.Value;
    end;

  finally
    JsonValue.Free;
  end;
end;

procedure TGeoInfo.btnLimparClick(Sender: TObject);
begin
  edtNomeOficial.Clear;
  edtCapital.Clear;
  edtRegiao.Clear;
  edtPopulacao.Clear;
  edtMoeda.Clear;

  edtPais.Clear;
  edtPais.SetFocus;

  imgBandeira.Picture := nil;
end;

end.

