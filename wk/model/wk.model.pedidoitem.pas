unit wk.model.pedidoitem;

interface

type
  TPedidoItem = class
  private
    { private declarations }
    FCodigo: Integer;
    FIDPedido: Integer;
    FIDProduto: Integer;
    FQuantidade: Double;
    FPreco: Double;
  public
    { public declarations }
    property Codigo: Integer read FCodigo write FCodigo;
    property IDPedido: Integer read FIDPedido write FIDPedido;
    property IDProduto: Integer read FIDProduto write FIDProduto;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property Preco: Double read FPreco write FPreco;
  end;

implementation

end.
