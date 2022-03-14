unit wk.dao.cliente;

interface

uses
  System.SysUtils, System.Classes, wk.model.cliente, wk.dao.principal,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdmCliente = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CadastroExiste(pCodigo: String; var pDescricao: String);
    procedure Carregar(pCliente: TCliente; pCodigo: Integer);
  end;

var
  dmCliente: TdmCliente;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses wk.view.mensagem;

{$R *.dfm}

procedure TdmCliente.Carregar(pCliente: TCliente; pCodigo: Integer);
var
  qryAux: TFDQuery;
begin
  qryAux := TFDQuery.Create(nil);
  try
    qryAux.Connection := dmConexao.fdcConexao;
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Append('SELECT codigo, nome, cidade, uf');
    qryAux.SQL.Append('FROM cliente');
    qryAux.SQL.Append('WHERE codigo = :codigo');
    qryAux.ParamByName('codigo').AsInteger := pCodigo;
    qryAux.Open;

    if not qryAux.IsEmpty then
    begin
      pCliente.Codigo := qryAux.FieldByName('codigo').AsInteger;
      pCliente.Nome := qryAux.FieldByName('nome').AsString;
      pCliente.Cidade := qryAux.FieldByName('cidade').AsString;
      pCliente.UF := qryAux.FieldByName('uf').AsString;
    end
    else
      MensagemAviso('Cliente não existe!');
  finally
    qryAux.Free;
  end;
end;

procedure TdmCliente.CadastroExiste(pCodigo: String; var pDescricao: String);
var
  qryAux: TFDQuery;
begin
  qryAux := TFDQuery.Create(nil);
  try
    qryAux.Connection := dmConexao.fdcConexao;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := 'SELECT descricao FROM cliente WHERE codigo = :codigo';
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
