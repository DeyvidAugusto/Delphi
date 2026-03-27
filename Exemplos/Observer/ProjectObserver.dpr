program ProjectObserver;

{$APPTYPE CONSOLE}

uses
  ObserverPattern;

var
  OrderSystem : TOrderSystem;
  LogObs      : IObserver;
  EmailObs    : IObserver;
begin
  OrderSystem := TOrderSystem.Create;
  try
    // Cria os observers
    LogObs   := TLogObserver.Create;
    EmailObs := TEmailObserver.Create('cliente@exemplo.com');

    // Registra ambos no subject
    OrderSystem.Attach(LogObs);
    OrderSystem.Attach(EmailObs);

    // Muda o status — ambos são notificados automaticamente
    OrderSystem.OrderStatus := 'Confirmado';
    OrderSystem.OrderStatus := 'Em separação';

    // Remove o log e muda novamente — só o e-mail recebe
    OrderSystem.Detach(LogObs);
    OrderSystem.OrderStatus := 'Despachado';

  finally
    OrderSystem.Free;
  end;

  Readln;

{
**Saída esperada:**

[LOG] 27/03/2026 10:00:00 — Pedido atualizado: Confirmado
[EMAIL] Enviando para cliente@exemplo.com: Pedido atualizado: Confirmado
[LOG] 27/03/2026 10:00:00 — Pedido atualizado: Em separação
[EMAIL] Enviando para cliente@exemplo.com: Pedido atualizado: Em separação
[EMAIL] Enviando para cliente@exemplo.com: Pedido atualizado: Despachado
}
end.

