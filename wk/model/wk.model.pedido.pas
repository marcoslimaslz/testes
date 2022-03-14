unit wk.model.pedido;

interface

type
  TPedido = class
  private
    { private declarations }
    FCodigo: Integer;
    FIDCliente: Integer;
    FTotal: Double;
  public
    { public declarations }
    property Codigo: Integer read FCodigo write FCodigo;
    property IDCliente: Integer read FIDCliente write FIDCliente;
    property Total: Double read FTotal write FTotal;
  end;

implementation

end.

