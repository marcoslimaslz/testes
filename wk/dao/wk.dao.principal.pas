unit wk.dao.principal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet;

type
  TdmConexao = class(TDataModule)
    FDQuery1: TFDQuery;
    fdcConexao: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ProdutoExiste(pCodigo: String; var pDescricao: String): Boolean;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  try
    fdcConexao.Connected := True;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao abrir banco de dados!' + #13 + 'Error Message: ' + E.Message);
    end;
  end;
end;

function TdmConexao.ProdutoExiste(pCodigo: String; var pDescricao: String): Boolean;
var
  qryAux: TFDQuery;
begin
  Result := False;
  qryAux := TFDQuery.Create(nil);
  try
    qryAux.Connection := fdcConexao;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := 'SELECT descricao FROM produto WHERE codigo = :codigo';
    qryAux.ParamByName('codigo').AsInteger := StrToInt(pCodigo);
    qryAux.Open;

    if not qryAux.IsEmpty then
    begin
      pDescricao := qryAux.FieldByName('descricao').AsString;
      Result := True;
    end
    else
      pDescricao := EmptyStr;
  finally
    qryAux.Free;
  end;
end;

end.
