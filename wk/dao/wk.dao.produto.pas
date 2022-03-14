unit wk.dao.produto;

interface

uses
  System.SysUtils, System.Classes, wk.dao.principal, wk.model.produto,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdmProduto = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CadastroExiste(pCodigo: String; var pDescricao: String);
    procedure Carregar(pProduto: TProduto; pCodigo: Integer);
  end;

var
  dmProduto: TdmProduto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses wk.view.mensagem;

{$R *.dfm}

{ TdmProduto }

procedure TdmProduto.Carregar(pProduto: TProduto; pCodigo: Integer);
var
  qryAux: TFDQuery;
begin
  qryAux := TFDQuery.Create(nil);
  try
    qryAux.Connection := dmConexao.fdcConexao;
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Append('SELECT codigo, descricao, preco');
    qryAux.SQL.Append('FROM produto');
    qryAux.SQL.Append('WHERE codigo = :codigo');
    qryAux.ParamByName('codigo').AsInteger := pCodigo;
    qryAux.Open;

    if not qryAux.IsEmpty then
    begin
      pProduto.Codigo := qryAux.FieldByName('codigo').AsInteger;
      pProduto.Descricao := qryAux.FieldByName('descricao').AsString;
      pProduto.Preco := qryAux.FieldByName('preco').AsFloat;
    end
    else
      MensagemAviso('Produto não existe!');
  finally
    qryAux.Free;
  end;
end;

procedure TdmProduto.CadastroExiste(pCodigo: String; var pDescricao: String);
var
  qryAux: TFDQuery;
begin
  qryAux := TFDQuery.Create(nil);
  try
    qryAux.Connection := dmConexao.fdcConexao;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := 'SELECT descricao FROM produto WHERE codigo = :codigo';
    qryAux.ParamByName('codigo').AsInteger := StrToInt(pCodigo);
    qryAux.Open;

    if not qryAux.IsEmpty then
      pDescricao := qryAux.FieldByName('descricao').AsString
    else
      pDescricao := EmptyStr;
  finally
    qryAux.Free;
  end;
end;

end.
