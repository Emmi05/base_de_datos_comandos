CREATE DATABASE jugos_ventas;
use jugos_ventas;
CREATE TABLE TBCLIENTES(
DNI VARCHAR(20),
NOMBRE VARCHAR(150),
DIRECCION1 VARCHAR(150),
DIRECCION2 VARCHAR(150),
BARRIO VARCHAR(50),
CIUDAD VARCHAR(50),
ESTADO VARCHAR(50),
CP VARCHAR(10),
EDAD SMALLINT,
SEXO VARCHAR(1),
LIMITE_CREDITO FLOAT,
VOLUMEN_COMPRA FLOAT,
PRIMERA_COMPRA BIT(1));

CREATE TABLE tbproductos
(PRODUCTO VARCHAR (20) ,
NOMBRE VARCHAR (150) ,
ENVASE VARCHAR (50) ,
VOLUMEN VARCHAR (50) ,
SABOR VARCHAR (50) ,
PRECIO FLOAT,
PRIMARY KEY(PRODUCTO));

DROP TABLE tbproductos;
DROP TABLE TABLA_DE_VENDEDORES;

CREATE TABLE TABLA_DE_VENDEDORES
( MATRICULA varchar(5),
NOMBE varchar(100),
PORCENTAJE_COMISION float,
FECHA_ADMISION date,
DE_VACACIONES bit,
PRIMARY KEY (MATRICULA));
SELECT *FROM TABLA_DE_VENDEDORES;
#ALTER TABLE TABLA_DE_VENDEDORES ADD PRIMARY KEY (MATRICULA);

ALTER TABLE TABLA_DE_VENDEDORES ADD COLUMN(BARRIO varchar(50));

INSERT INTO TABLA_DE_VENDEDORES
(MATRICULA, NOMBE, FECHA_ADMISION, PORCENTAJE_COMISION, DE_VACACIONES, BARRIO) VALUES ('00235','Miguel Pavón Savila','2014-08-15',0.08,0, "Condesa");

INSERT INTO TABLA_DE_VENDEDORES
(MATRICULA, NOMBE, FECHA_ADMISION, PORCENTAJE_COMISION, DE_VACACIONES, BARRIO) VALUES ('00236','Cláudia Morais','2013-09-17',0.08,1, "Del valle");

INSERT INTO TABLA_DE_VENDEDORES
(MATRICULA, NOMBE, FECHA_ADMISION, PORCENTAJE_COMISION, DE_VACACIONES, BARRIO) VALUES ('00237','Concepcion Martinez','2016-08-21',0.11,0, "Contadero");

INSERT INTO TABLA_DE_VENDEDORES
(MATRICULA, NOMBE, FECHA_ADMISION, PORCENTAJE_COMISION, DE_VACACIONES, BARRIO) VALUES ('00238','Patricia Sanchez','2016-08-21',0.11,0, "Oblatos");

DELETE FROM TABLA_DE_VENDEDORES WHERE MATRICULA ="00235";
DELETE FROM TABLA_DE_VENDEDORES WHERE MATRICULA ="00236";
DELETE FROM TABLA_DE_VENDEDORES WHERE MATRICULA ="00238";


DELETE FROM tbproductos WHERE producto = '773912';

/*
CREATE TABLE TABLA_DE_VENDEDORES2 (
    MATRICULA varchar(5), 
    NOMBRE varchar(100), 
    PORCENTAJE_COMISION float);
    
    DROP TABLE TABLA_DE_VENDEDORES2;
    
DROP TABLE TABLA_DE_VENDEDORES;

