unit wk.controller.produto;

interface

uses wk.model.produto, wk.dao.produto, SysUtils, System.Classes;

type TControllerProduto = class
     private
       { private declarations }
     protected
       { protected declarations }
     public
       { public declarations }
       procedure ProdutoExiste(pCodigo: String; var pDescricao: String);
       procedure Carregar(pProduto: TProduto; pCodigo: Integer);
     end;

implementation

procedure TControllerProduto.ProdutoExiste(pCodigo: String; var pDescricao: String);
begin
  dmProduto.CadastroExiste(pCodigo, pDescricao);
end;

procedure TControllerProduto.Carregar(pProduto: TProduto; pCodigo: Integer);
begin
  dmProduto.Carregar(pProduto, pCodigo);
end;

end.
