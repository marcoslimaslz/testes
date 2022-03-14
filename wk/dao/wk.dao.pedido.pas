unit wk.dao.pedido;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  wk.dao.principal, wk.model.produto, wk.model.cliente, wk.model.pedido,
  wk.model.pedidoitem;

type
  TdmPedido = class(TDataModule)
    fdmPedido: TFDMemTable;
    fdmPedidoIDCliente: TIntegerField;
    fdmPedidoCliente: TStringField;
    fdmPedidoItem: TFDMemTable;
    fdmPedidoItemCodigo: TIntegerField;
    fdmPedidoItemIDProduto: TIntegerField;
    fdmPedidoItemProduto: TStringField;
    fdmPedidoItemPreco: TFloatField;
    fdmPedidoItemQuantidade: TFloatField;
    fdmPedidoItemTotal: TFloatField;
    fdmPedidoCodigo: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure LimparSequencial;
  public
    { Public declarations }
    function Inserir(pPedido: TPedido; pPedidoItem: TPedidoItem; pCliente: TCliente;
      pProduto: TProduto; pQtde: Double; out pMsgErro: String): Boolean;
    function Excluir(pCodigo: Integer; out pMsgErro: String): Boolean;
    function RetornaCodigo(pTabela: String): Integer;
    function Gravar(pPedido: TPedido; pPedidoItem: TPedidoItem; out pMsgErro: String): Boolean;
  end;

var
  dmPedido: TdmPedido;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmPedido.DataModuleCreate(Sender: TObject);
begin
  fdmPedido.CreateDataSet;
  fdmPedidoItem.CreateDataSet;
end;

procedure TdmPedido.DataModuleDestroy(Sender: TObject);
begin
  LimparSequencial;
  fdmPedido.Close;
  fdmPedidoItem.Close;
end;

function TdmPedido.Excluir(pCodigo: Integer; out pMsgErro: String): Boolean;
begin
  Result := False;
  if fdmPedidoItem.Locate('codigo', pCodigo, []) then
  begin
    try
      fdmPedidoItem.Delete;
      Result := True;
    except
      on E: Exception do
      begin
        pMsgErro := Format('Erro ao excluir produto = %s.' + #13 + E.Message, [pCodigo]);
        Result := False;
      end;
    end;
  end;
end;

function TdmPedido.Gravar(pPedido: TPedido; pPedidoItem: TPedidoItem;
  out pMsgErro: String): Boolean;
var
  qryAux: TFDQuery;
begin
  Result := True;
  qryAux := TFDQuery.Create(nil);
  try
    try
      //pedido
      qryAux.Connection := dmConexao.fdcConexao;
      qryAux.SQL.Clear;
      qryAux.SQL.Text := 'INSERT INTO pedido (codigo, idcliente, emissao, total) ' +
                         ' VALUES(:codigo, :idcliente, :emissao, :total)';
      qryAux.ParamByName('codigo').AsInteger := fdmPedidoCodigo.AsInteger;
      qryAux.ParamByName('idcliente').AsInteger := pPedido.IDCliente;
      qryAux.ParamByName('emissao').AsDate := Date;
      qryAux.ParamByName('total').AsFloat := pPedido.Total;
      qryAux.ExecSQL;
    except
      on E: Exception do
      begin
        pMsgErro := 'Erro ao inserir Serviço.'  + #13 + E.Message;
        Result := False;
      end;
    end;

    try
      //pedido_item
      qryAux.SQL.Clear;
      qryAux.SQL.Text := 'INSERT INTO pedido_item (codigo, idpedido, idproduto, quantidade, preco, total) ' +
                         ' VALUES(:codigo, :idpedido, :idproduto, :quantidade, :preco, :total)';
      fdmPedidoItem.First;
      while not fdmPedidoItem.Eof do
      begin
        qryAux.ParamByName('codigo').AsInteger := fdmPedidoItemCodigo.AsInteger;
        qryAux.ParamByName('idpedido').AsInteger := fdmPedidoCodigo.AsInteger;
        qryAux.ParamByName('idproduto').AsInteger := fdmPedidoItemIDProduto.AsInteger;
        qryAux.ParamByName('quantidade').AsFloat := fdmPedidoItemQuantidade.AsFloat;
        qryAux.ParamByName('preco').AsFloat := fdmPedidoItemPreco.AsFloat;
        qryAux.ParamByName('total').AsFloat := fdmPedidoItemTotal.AsFloat;
        qryAux.ExecSQL;

        fdmPedidoItem.Next;
      end;
    except
      on E: Exception do
      begin
        pMsgErro := 'Erro ao inserir Serviço.'  + #13 + E.Message;
        Result := False;
      end;
    end;
  finally
    qryAux.Free;
  end;

  if Result then
  begin
    fdmPedido.EmptyDataSet;
    fdmPedidoItem.EmptyDataSet;
    LimparSequencial;
  end;
end;

function TdmPedido.Inserir(pPedido: TPedido; pPedidoItem: TPedidoItem; pCliente: TCliente;
  pProduto: TProduto; pQtde: Double; out pMsgErro: String): Boolean;
begin
  try
    if fdmPedido.IsEmpty then
    begin
      fdmPedido.Append;
      fdmPedidoCodigo.AsInteger := RetornaCodigo('pedido');
      fdmPedidoIDCliente.AsInteger := pCliente.Codigo;
      fdmPedidoCliente.AsString := pCliente.Nome;
      fdmPedido.Post;
    end;
    Result := True;

    try
      fdmPedidoItem.Append;
      fdmPedidoItemCodigo.AsInteger := RetornaCodigo('pedido_item');
      fdmPedidoItemIDProduto.AsInteger := pProduto.Codigo;
      fdmPedidoItemProduto.AsString := pProduto.Descricao;
      fdmPedidoItemPreco.AsFloat := pProduto.Preco;
      fdmPedidoItemQuantidade.AsFloat := pQtde;
      fdmPedidoItemTotal.AsFloat := fdmPedidoItemPreco.AsFloat * fdmPedidoItemQuantidade.AsFloat;
      fdmPedidoItem.Post;
    except
      on E: Exception do
      begin
        pMsgErro := 'Erro ao inserir Serviço.'  + #13 + E.Message;
        Result := False;
      end;
    end;
  except
    on E: Exception do
    begin
      pMsgErro := 'Erro ao inserir Serviço.'  + #13 + E.Message;
      Result := False;
    end;
  end;
end;

procedure TdmPedido.LimparSequencial;
var
  qryAux: TFDQuery;
begin
  qryAux := TFDQuery.Create(nil);
  try
    qryAux.Connection := dmConexao.fdcConexao;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := 'UPDATE sequencial SET codigo = 1 WHERE tabela = :tabela';
    qryAux.ParamByName('tabela').AsString := 'pedido_item';
    qryAux.ExecSQL;
  finally
    qryAux.Free;
  end;
end;

function TdmPedido.RetornaCodigo(pTabela: String): Integer;
var
  qryAux: TFDQuery;
begin
  qryAux := TFDQuery.Create(nil);
  try
    qryAux.Connection := dmConexao.fdcConexao;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := 'SELECT codigo FROM sequencial WHERE tabela = :tabela';
    qryAux.ParamByName('tabela').AsString := pTabela;
    qryAux.Open;

    Result := qryAux.Fields[0].AsInteger;

    //Gravar
    qryAux.SQL.Clear;
    qryAux.SQL.Text := 'UPDATE sequencial SET codigo = :codigo WHERE tabela = :tabela';
    qryAux.ParamByName('codigo').AsInteger := Result + 1;
    qryAux.ParamByName('tabela').AsString := pTabela;
    qryAux.ExecSQL;
  finally
    qryAux.Free;
  end;
end;

end.
