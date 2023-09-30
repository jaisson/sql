create or replace function getTotalPedido(idPedido number) return real
DETERMINISTIC is
  vlrTotalPedido real;
begin
  select coalesce(sum(pp.vlrTotal), 0) total
    into vlrTotalPedido
    from pedido_produto pp
   where pp.cdPedido = idPedido;

  return vlrTotalPedido; 
end;

alter table pedido add vlrTotal REAL GENERATED ALWAYS AS (getTotalPedido(idPedido)) VIRTUAL;