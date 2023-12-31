
create table DEPARTAMENTO ( 
    idDepartamento NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE  PRIMARY KEY,
    nmDepartamento varchar2(100)
);

CREATE TABLE PRODUTO (
  idProduto NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE  PRIMARY KEY,
  cdDepartamento Number,
  dsProduto VARCHAR2(30)
);

CREATE TABLE CLIENTE ( /* 100 registros */
  idCliente NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE  PRIMARY KEY,
  nmCliente VARCHAR2(150) NOT NULL,
  dtNascimento DATE,
  dtCadastro DATE,
  tpCliente CHAR DEFAULT 'F'
);

CREATE TABLE PEDIDO ( /* 5000 registros */
  idPedido NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE  PRIMARY KEY,
  cdCliente NUMBER,
  dtEmissao TIMESTAMP DEFAULT SYSTIMESTAMP,
  stSitucao CHAR DEFAULT 'N'
);

CREATE TABLE PEDIDO_PRODUTO ( /* 15000 registros */
  idPedidoProduto NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE  PRIMARY KEY,
  cdPedido NUMBER,
  cdProduto NUMBER,
  qtdProduto REAL,
  vlrUnitario REAL,
  vlrTotal REAL GENERATED ALWAYS AS (qtdProduto * vlrUnitario) VIRTUAL
);