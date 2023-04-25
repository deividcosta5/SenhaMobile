unit Commons.Global;

interface

uses Controller.Clientes, System.Generics.Collections;

procedure LoadClientes;

var
  ListaClientes: TList<TCliente>;
  TokenDevice: String;

const
  APIUsuario: String = 'deivid';
  APISenha: String = '2ExeY%G1`*J<[1:Z}e';

implementation

procedure LoadClientes;
begin
  ListaClientes := TList<TCliente>.Create;

  ListaClientes.Add(TCliente.Create(1, 'PR Sistemas', 'http://192.168.68.132:8030', '1234'));
end;

end.
