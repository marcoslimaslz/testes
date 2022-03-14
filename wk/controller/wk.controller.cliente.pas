unit wk.controller.cliente;

interface

uses wk.model.cliente, wk.dao.cliente, SysUtils, System.Classes;

type TControllerCliente = class
     private
       { private declarations }
     protected
       { protected declarations }
     public
       { public declarations }
       procedure CadastroExiste(pCodigo: String; var pDescricao: String);
       procedure Carregar(pCliente: TCliente; pCodigo: Integer);
     end;

implementation

procedure TControllerCliente.CadastroExiste(pCodigo: String; var pDescricao: String);
begin
  dmCliente.CadastroExiste(pCodigo, pDescricao);
end;

procedure TControllerCliente.Carregar(pCliente: TCliente; pCodigo: Integer);
begin
  dmCliente.Carregar(pCliente, pCodigo);
end;

end.
