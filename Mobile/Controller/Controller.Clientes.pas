unit Controller.Clientes;

interface

type
  TCliente = class
  private
    FID: Integer;
    FNome: String;
    FEnderecoAPI: String;
    FIDFirebase: String;
  public
    property ID: Integer read FID write FID;
    property Nome: String read FNome write FNome;
    property EnderecoAPI: String read FEnderecoAPI write FEnderecoAPI;
    property IDFirebase: String read FIDFirebase write FIDFirebase;
    constructor Create(AID: Integer; ANome, AEnderecoAPI, AIDFirebase: String);
  end;

implementation

{ TCliente }

constructor TCliente.Create(AID: Integer; ANome, AEnderecoAPI, AIDFirebase: String);
begin
  ID := AID;
  Nome := ANome;
  EnderecoAPI := AEnderecoAPI;
  IDFirebase := AIDFirebase;
end;

end.
