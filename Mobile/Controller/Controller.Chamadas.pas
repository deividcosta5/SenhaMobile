unit Controller.Chamadas;

interface

uses
  System.Generics.Collections;

type
  TChamada = class
  private
    FID: Integer;
    FIDSenha: Integer;
    FSetor: String;
    FSala: String;
    FDataHora: TDateTime;
  public
    property ID: Integer read FID write FID;
    property IDSenha: Integer read FIDSenha write FIDSenha;
    property Setor: String read FSetor write FSetor;
    property Sala: String read FSala write FSala;
    property DataHora: TDateTime read FDataHora write FDataHora;
    constructor Create(AID, AIDSenha: Integer; ASetor, ASala: String; ADataHora: TDateTime);
  end;

var
  ListaChamadas: TList<TChamada>;

implementation

{ TChamada }

constructor TChamada.Create(AID, AIDSenha: Integer; ASetor, ASala: String; ADataHora: TDateTime);
begin
  ID := AID;
  IDSenha := AIDSenha;
  Setor := ASetor;
  Sala := ASala;
  DataHora := ADataHora;
end;

end.
