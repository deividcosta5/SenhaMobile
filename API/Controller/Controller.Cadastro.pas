unit Controller.Cadastro;

interface

uses Horse,
     Horse.Jhonson,
     Horse.BasicAuthentication,
     Horse.CORS,
     DataModule.Global,
     System.JSON,
     System.SysUtils,
     Controller.Global;

procedure RegistrarRotas;
procedure CadastrarSenha(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure RegistrarRotas;
begin
  THorse.Post('/' + VersionAPI + '/registrarsenha', CadastrarSenha);
end;

procedure CadastrarSenha(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  DMGlobal: TDMGlobal;
  Body: TJSONObject;
begin
  try
    try
      DMGlobal := TDMGlobal.Create(nil);

      Body := Req.Body<TJSONObject>;

      Res.Send<TJSONObject>(DMGlobal.RegistrarSenha(Body)).Status(THTTPStatus.Created);
    except on E: Exception do
      Res.Send(E.Message).Status(THTTPStatus.InternalServerError)
    end;
  finally
    FreeAndNil(DMGlobal)
  end;
end;

end.
