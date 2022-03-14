unit wk.view.mensagem;

interface

uses
  Vcl.Dialogs, System.UITypes;

  procedure MensagemAviso(pTexto: String);
  procedure MensagemErro(pTexto: String);
  function MensagemPergunta(pTexto: String): Integer;
  procedure MensagemInformativa(pTexto: String);

implementation

procedure MensagemAviso(pTexto: String);
begin
  MessageDlg(pTexto, mtWarning, [mbok], 0);
end;

procedure MensagemErro(pTexto: String);
begin
  MessageDlg(pTexto, mtError, [mbok], 0);
end;

function MensagemPergunta(pTexto: String): Integer;
begin
  Result := MessageDlg(pTexto, mtConfirmation, [mbYes, mbNo], 0);
end;

procedure MensagemInformativa(pTexto: String);
begin
  MessageDlg(pTexto, mtInformation, [mbok], 0);
end;

end.
