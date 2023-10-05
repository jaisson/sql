with
fonte as (
  select 'a' v1, 'e' v2, 'i' v3, 'o' v4, 'u' v5
    from dual
)

 select novo_coluna
   from fonte
unpivot (novo_coluna for value_type in (v1,v2,v3,v4,v5))
