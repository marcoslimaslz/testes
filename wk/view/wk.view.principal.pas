unit wk.view.principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.UITypes, wk.dao.principal, wk.controller.produto,
  wk.model.produto, wk.view.mensagem, wk.dao.pedido, wk.model.pedido,
  wk.controller.pedido, wk.model.pedidoitem, wk.model.cliente, wk.controller.cliente;

type
  TFPrincipal = class(TForm)
    dsPedidoItem: TDataSource;
    pgcGeral: TPageControl;
    tabVenda: TTabSheet;
    tabFinalizar: TTabSheet;
    grdVenda: TDBGrid;
    pnlVendaSuperior: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtProduto: TEdit;
    edtProdutoDesc: TEdit;
    btnInserir: TButton;
    btnExcluir: TButton;
    edtValor: TEdit;
    edtQtde: TEdit;
    pnlFinalizarInferior: TPanel;
    btnFinalizar: TButton;
    btnVoltarVenda: TButton;
    pnlVendaInferior: TPanel;
    btnAvancar: TButton;
    pnlFinalizarSuperior: TPanel;
    Label5: TLabel;
    Label4: TLabel;
    edtFinTotal: TEdit;
    edtCliente: TEdit;
    edtClienteDesc: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure edtProdutoExit(Sender: TObject);
    procedure edtProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure dsPedidoItemDataChange(Sender: TObject; Field: TField);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure btnVoltarVendaClick(Sender: TObject);
    procedure btnAvancarClick(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtClienteExit(Sender: TObject);
    procedure edtClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtQtdeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FCliente: TCliente;
    FPedido: TPedido;
    FPedidoItem: TPedidoItem;
    procedure Inicializacao;
    procedure Finalizacao;
    procedure PesquisarProduto;
    procedure PesquisarCliente;
    procedure Inserir;
    procedure Excluir;
    procedure CarregarProduto(pCodigo: Integer);
    procedure CarregarCliente(pCodigo: Integer);
    procedure Passo(fTabSheet: TTabSheet);
    procedure LimparProduto;
    procedure SomarVenda;
    procedure GravarVenda;
    procedure NovaVenda;
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

procedure TFPrincipal.btnAvancarClick(Sender: TObject);
begin
  Passo(tabFinalizar);
  SomarVenda;
end;

procedure TFPrincipal.btnFinalizarClick(Sender: TObject);
begin
  if (edtCliente.Text <> EmptyStr) and (FCliente.Codigo > 0) then
  begin
    GravarVenda;
  end
  else
  begin
    MensagemAviso('Informe um cliente válido!');
    if edtCliente.CanFocus then
    begin
      edtCliente.SetFocus;
    end;
  end;
end;

procedure TFPrincipal.btnExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TFPrincipal.btnVoltarVendaClick(Sender: TObject);
begin
  Passo(tabVenda);
end;

procedure TFPrincipal.btnInserirClick(Sender: TObject);
begin
  if edtProduto.Text <> EmptyStr then
  begin
    if edtQtde.Text = EmptyStr then
    begin
      edtQtde.Text := '1';
    end;
    Inserir;
  end;
  LimparProduto;
end;

procedure TFPrincipal.CarregarCliente(pCodigo: Integer);
var
  fControle: TControllerCliente;
begin
  fControle := TControllerCliente.Create;
  try
    fControle.Carregar(FCliente, pCodigo);
    if FCliente.Codigo > 0 then
    begin
      edtClienteDesc.Text := FCliente.Nome;
    end;
  finally
    FreeAndNil(fControle);
  end;
end;

procedure TFPrincipal.CarregarProduto(pCodigo: Integer);
var
  fClasse: TProduto;
  fControle: TControllerProduto;
begin
  fClasse := TProduto.Create;
  fControle := TControllerProduto.Create;
  try
    fControle.Carregar(fClasse, pCodigo);
    if fClasse.Codigo > 0 then
    begin
      edtProdutoDesc.Text := fClasse.Descricao;
      edtValor.Text := FloatToStr(fClasse.Preco);
      edtQtde.Text := '1';
    end;
  finally
    FreeAndNil(fClasse);
    FreeAndNil(fControle);
  end;
end;

procedure TFPrincipal.dsPedidoItemDataChange(Sender: TObject; Field: TField);
begin
  btnExcluir.Enabled := not dsPedidoItem.DataSet.IsEmpty;
  btnAvancar.Enabled := not dsPedidoItem.DataSet.IsEmpty;
end;

procedure TFPrincipal.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  if not (CharInSet(key, ['0','1','2','3','4','5','6','7','8','9',',',#8])) then
  begin
    key := #0;
  end;
end;

procedure TFPrincipal.Excluir;
var
  fControllerPedido: TControllerPedido;
  sMsgErro: String;
begin
  if not dsPedidoItem.DataSet.IsEmpty then
  begin
    fControllerPedido := TControllerPedido.Create;
    try
      if dsPedidoItem.DataSet.Active then
      begin
        if MensagemPergunta('Deseja excluir o registro?') = IDYES then
        begin
          if not fControllerPedido.Excluir(dsPedidoItem.DataSet.FieldByName('codigo').AsInteger, sMsgErro) then
          begin
            MensagemErro(sMsgErro);
          end;
        end;
      end
      else
      begin
        MensagemAviso('Não existe registro para exclusão.');
      end;
    finally
      FreeAndNil(fControllerPedido);
    end;
  end;
end;

procedure TFPrincipal.edtClienteExit(Sender: TObject);
begin
  PesquisarCliente;
end;

procedure TFPrincipal.edtClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    PesquisarCliente;
    perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFPrincipal.edtProdutoExit(Sender: TObject);
begin
//  PesquisarProduto;
end;

procedure TFPrincipal.edtProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key =  VK_RETURN then
  begin
    PesquisarProduto;
    perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFPrincipal.edtProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (CharInSet(key, ['0','1','2','3','4','5','6','7','8','9',#8])) then
  begin
    key := #0;
  end;
end;

procedure TFPrincipal.edtQtdeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFPrincipal.Finalizacao;
begin
  if Assigned(dmConexao) then
  begin
    FreeAndNil(dmConexao);
    FreeAndNil(FCliente);
  end;
end;

procedure TFPrincipal.SomarVenda;
var
  bTotal: Double;
begin
  bTotal := 0;
  dmPedido.fdmPedidoItem.First;
  while not dmPedido.fdmPedidoItem.Eof do
  begin
    bTotal := bTotal + dmPedido.fdmPedidoItemTotal.AsFloat;
    dmPedido.fdmPedidoItem.Next;
  end;

  edtFinTotal.Text := FloatToStr(bTotal);
  FPedido.Total := bTotal;
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  Inicializacao;
end;

procedure TFPrincipal.FormDestroy(Sender: TObject);
begin
  Finalizacao;
end;

procedure TFPrincipal.GravarVenda;
var
  fControle: TControllerPedido;
  sMsgErro: String;
begin
  fControle := TControllerPedido.Create;
  FPedido.IDCliente := FCliente.Codigo;

  try
    if not fControle.Gravar(FPedido, FPedidoItem, sMsgErro) then
    begin
      MensagemErro(sMsgErro);
    end
    else
    begin
      MensagemInformativa('Venda realizada com sucesso!');
      NovaVenda;
    end;
  finally
    FreeAndNil(fControle);
  end;
end;

procedure TFPrincipal.grdVendaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_DELETE then
  begin
    Excluir;
  end;
end;

procedure TFPrincipal.Inicializacao;
begin
  dmConexao := TdmConexao.Create(Self);
  FCliente := TCliente.Create;
  FPedido := TPedido.Create;
  FPedidoItem := TPedidoItem.Create;

  tabVenda.TabVisible := False;
  tabFinalizar.TabVisible := False;

  pgcGeral.ActivePage := tabVenda;
end;

procedure TFPrincipal.Inserir;
var
  fProduto: TProduto;
  fControllerProduto: TControllerProduto;
  fControle: TControllerPedido;
  sMsgErro: String;
begin
  fProduto := TProduto.Create;
  fControllerProduto := TControllerProduto.Create;
  fControllerProduto.Carregar(fProduto, StrToInt(edtProduto.Text));

  fControle := TControllerPedido.Create;
  try
    if not fControle.Inserir(FPedido, FPedidoItem, FCliente, fProduto, StrToFloat(edtQtde.Text), sMsgErro) then
    begin
      MensagemErro(sMsgErro);
    end;
  finally
    FreeAndNil(fProduto);
    FreeAndNil(fControllerProduto);
    FreeAndNil(fControle);
  end;
end;

procedure TFPrincipal.LimparProduto;
begin
  edtProduto.Clear;
  edtProdutoDesc.Clear;
  edtValor.Clear;
  edtQtde.Text := '1';
  if edtProduto.CanFocus then
  begin
    edtProduto.SetFocus;
  end;
end;

procedure TFPrincipal.NovaVenda;
begin
  edtCliente.Clear;
  edtClienteDesc.Clear;
  edtFinTotal.Clear;
  Passo(tabVenda);
  LimparProduto;
end;

procedure TFPrincipal.Passo(fTabSheet: TTabSheet);
begin
  pgcGeral.ActivePage := fTabSheet;
end;

procedure TFPrincipal.PesquisarCliente;
var
 pCodigo: Integer;
begin
  if Trim(edtCliente.Text) <> EmptyStr then
  begin
    try
      pCodigo := StrToInt(edtCliente.Text)
    except
      on e: Exception do
      begin
        raise Exception.Create('Código do cliente é inválido!');
      end;
    end;

    if pCodigo > 0 then
    begin
      CarregarCliente(pCodigo);
    end
    else
    begin
      edtCliente.Clear;
      if edtCliente.CanFocus then
      begin
        edtCliente.SetFocus;
      end;
      MensagemAviso('Código do cliente é inválido!');
    end;
  end
  else
  begin
    edtClienteDesc.Clear;
  end;
end;

procedure TFPrincipal.PesquisarProduto;
var
 pCodigo: Integer;
begin
  if Trim(edtProduto.Text) <> EmptyStr then
  begin
    try
      pCodigo := StrToInt(edtProduto.Text)
    except
      on e: Exception do
      begin
        raise Exception.Create('Código do produto é inválido!');
      end;
    end;

    if pCodigo > 0 then
    begin
      CarregarProduto(pCodigo);
    end;
  end
  else
  begin
    edtProdutoDesc.Clear;
  end;
end;

end.
