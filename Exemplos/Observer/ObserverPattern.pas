unit ObserverPattern;

interface

uses
  System.Generics.Collections, System.SysUtils;

// ============================================================
// 1. INTERFACES — contrato entre Subject e Observers
// ============================================================

type
  // IObserver: qualquer objeto que queira ser notificado
  // deve implementar esta interface.
  IObserver = interface
    ['{A1B2C3D4-0000-0000-0000-000000000001}']
    procedure Update(const AData: string);
  end;

  // ISubject: o objeto observado expõe métodos para
  // registrar, remover e notificar os observers.
  ISubject = interface
    ['{A1B2C3D4-0000-0000-0000-000000000002}']
    procedure Attach(const AObserver: IObserver);
    procedure Detach(const AObserver: IObserver);
    procedure NotifyObservers(const AData: string);
  end;

// ============================================================
// 2. OBSERVERS CONCRETOS
// ============================================================

  // Observer que grava em log
  TLogObserver = class(TInterfacedObject, IObserver)
  public
    procedure Update(const AData: string);
  end;

  // Observer que simula envio de e-mail
  TEmailObserver = class(TInterfacedObject, IObserver)
  private
    FEmail: string;
  public
    constructor Create(const AEmail: string);
    procedure Update(const AData: string);
  end;

// ============================================================
// 3. SUBJECT CONCRETO
// ============================================================

  // TOrderSystem é o "sujeito observado".
  // Quando um pedido muda de estado, ele notifica todos.
  TOrderSystem = class(TInterfacedObject, ISubject)
  private
    FObservers: TList<IObserver>;
    FOrderStatus: string;
    procedure SetOrderStatus(const AStatus: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Attach(const AObserver: IObserver);
    procedure Detach(const AObserver: IObserver);
    procedure NotifyObservers(const AData: string);
    // Quando esta propriedade muda, a notificação dispara
    property OrderStatus: string write SetOrderStatus;
  end;

implementation

// ============================================================
// TLogObserver
// ============================================================

procedure TLogObserver.Update(const AData: string);
begin
  Writeln('[LOG] ' + DateTimeToStr(Now) + ' — ' + AData);
end;

// ============================================================
// TEmailObserver
// ============================================================

constructor TEmailObserver.Create(const AEmail: string);
begin
  inherited Create;
  FEmail := AEmail;
end;

procedure TEmailObserver.Update(const AData: string);
begin
  Writeln('[EMAIL] Enviando para ' + FEmail + ': ' + AData);
end;

// ============================================================
// TOrderSystem (Subject)
// ============================================================

constructor TOrderSystem.Create;
begin
  inherited;
  // TList gerenciada com interface — sem vazamentos
  FObservers := TList<IObserver>.Create;
end;

destructor TOrderSystem.Destroy;
begin
  FObservers.Free;
  inherited;
end;

procedure TOrderSystem.Attach(const AObserver: IObserver);
begin
  // Adiciona o observer apenas se ainda não estiver na lista
  if not FObservers.Contains(AObserver) then
    FObservers.Add(AObserver);
end;

procedure TOrderSystem.Detach(const AObserver: IObserver);
begin
  FObservers.Remove(AObserver);
end;

procedure TOrderSystem.NotifyObservers(const AData: string);
var
  Observer: IObserver;
begin
  // Percorre todos os observers e chama Update em cada um
  for Observer in FObservers do
    Observer.Update(AData);
end;

// O setter dispara a notificação automaticamente —
// é aqui que está o poder do padrão.
procedure TOrderSystem.SetOrderStatus(const AStatus: string);
begin
  FOrderStatus := AStatus;
  NotifyObservers('Pedido atualizado: ' + AStatus);
end;

end.
