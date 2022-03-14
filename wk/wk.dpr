program wk;

uses
  Vcl.Forms,
  wk.view.principal in 'view\wk.view.principal.pas' {FPrincipal},
  wk.dao.principal in 'dao\wk.dao.principal.pas' {dmConexao: TDataModule},
  wk.controller.produto in 'controller\wk.controller.produto.pas',
  wk.model.produto in 'model\wk.model.produto.pas',
  wk.dao.produto in 'dao\wk.dao.produto.pas' {dmProduto: TDataModule},
  wk.view.mensagem in 'view\wk.view.mensagem.pas',
  wk.dao.pedido in 'dao\wk.dao.pedido.pas' {dmPedido: TDataModule},
  wk.model.pedido in 'model\wk.model.pedido.pas',
  wk.controller.pedido in 'controller\wk.controller.pedido.pas',
  wk.model.pedidoitem in 'model\wk.model.pedidoitem.pas',
  wk.model.cliente in 'model\wk.model.cliente.pas',
  wk.controller.cliente in 'controller\wk.controller.cliente.pas',
  wk.dao.cliente in 'dao\wk.dao.cliente.pas' {dmCliente: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TdmProduto, dmProduto);
  Application.CreateForm(TdmPedido, dmPedido);
  Application.CreateForm(TdmCliente, dmCliente);
  Application.Run;
end.
