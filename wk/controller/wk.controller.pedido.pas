unit wk.controller.pedido;

interface

uses SysUtils, System.Classes, wk.model.pedido, wk.model.pedidoitem,
     wk.dao.pedido, wk.model.cliente, wk.model.produto;

type TControllerPedido = class
     private
       { private declarations }
     protected
       { protected declarations }
     public
       { public declarations }
       function Inserir(pPedido: TPedido; pPedidoItem: TPedidoItem; pCliente: TCliente;
         pProduto: TProduto; pQtde: Double; out pMsgErro: String): Boolean;
       function Excluir(pCodigo: Integer; out pMsgErro: String): Boolean;
       function Gravar(pPedido: TPedido; pPedidoItem: TPedidoItem; out pMsgErro: String): Boolean;
     end;

implementation

function TControllerPedido.Excluir(pCodigo: Integer; out pMsgErro: String): Boolean;
begin
  Result := dmPedido.Excluir(pCodigo, pMsgErro);
end;

function TControllerPedido.Gravar(pPedido: TPedido; pPedidoItem: TPedidoItem;
  out pMsgErro: String): Boolean;
begin
  Result := dmPedido.Gravar(pPedido, pPedidoItem, pMsgErro);
end;

function TControllerPedido.Inserir(pPedido: TPedido; pPedidoItem: TPedidoItem; pCliente: TCliente;
  pProduto: TProduto; pQtde: Double; out pMsgErro: String): Boolean;
begin
  Result := dmPedido.Inserir(pPedido, pPedidoItem, pCliente, pProduto, pQtde, pMsgErro);
end;

end.
