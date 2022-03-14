unit wk.model.produto;

interface

type
  TProduto = class
  private
    { private declarations }
    FCodigo: Integer;
    FDescricao: String;
    FPreco: Double;
  public
    { public declarations }
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property Preco: Double read FPreco write FPreco;
  end;

implementation

end.

