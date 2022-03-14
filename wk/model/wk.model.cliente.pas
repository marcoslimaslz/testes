unit wk.model.cliente;

interface

type
  TCliente = class
  private
    { private declarations }
    FCodigo: Integer;
    FNome: String;
    FCidade: String;
    FUF: String;
  public
    { public declarations }
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Cidade: String read FCidade write FCidade;
    property UF: String read FUF write FUF;
  end;

implementation

end.

