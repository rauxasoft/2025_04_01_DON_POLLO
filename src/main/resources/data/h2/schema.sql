-- ******************************************************
-- 
--                    SECUENCIADORES
-- 
-- ******************************************************

CREATE SEQUENCE "PERSONA_SEQ"
	MINVALUE 1
	MAXVALUE 999999999
	INCREMENT BY 50
	START WITH 5000
	NOCACHE
	NOCYCLE;

CREATE SEQUENCE "PRODUCTO_SEQ"
	MINVALUE 1 
    MAXVALUE 999999999 
    INCREMENT BY 50 
    START WITH 5000 
    NOCACHE 
    NOCYCLE;
        
CREATE SEQUENCE "PEDIDO_SEQ"
	MINVALUE 1 
    MAXVALUE 999999999 
    INCREMENT BY 50 
    START WITH 5000 
    NOCACHE 
    NOCYCLE;
    
CREATE SEQUENCE "FAMILIA_SEQ"
	MINVALUE 1 
    MAXVALUE 999999999 
    INCREMENT BY 50 
    START WITH 5000 
    NOCACHE 
    NOCYCLE;
    
-- ******************************************************
-- 
--                       MODEL 
-- 
-- ******************************************************

CREATE TABLE FAMILIAS(
	ID				BIGINT			NOT NULL,
	NOMBRE			VARCHAR(100)	,
	PRIMARY KEY(ID)
);    
    
CREATE TABLE PRODUCTOS(
	CODIGO							BIGINT			NOT NULL,
	NOMBRE							VARCHAR(50)		,
	DESCRIPCION						VARCHAR(150)	,
	FECHA_ALTA						DATE			,
	PRECIO							DOUBLE			,
	ID_FAMILIA						BIGINT			,
	DESCATALOGADO					BOOLEAN			NOT NULL,
	PRIMARY KEY(CODIGO),
	FOREIGN KEY (ID_FAMILIA) REFERENCES FAMILIAS (ID)
);

CREATE TABLE ESTABLECIMIENTOS(
	ID 								BIGINT	        NOT NULL,
	NOMBRE_COMERCIAL				VARCHAR(100)	,
	DIRECCION						VARCHAR(100)	,
	POBLACION						VARCHAR(100)	,
	CODIGO_POSTAL					VARCHAR(10)		,
	PROVINCIA						VARCHAR(100)	,
	PAIS							VARCHAR(100)	,
	TELEFONO						VARCHAR(25)		,
	MOVIL							VARCHAR(25)		,
	EMAIL							VARCHAR(250)	,
	PRIMARY KEY (ID)
);

CREATE TABLE PERSONAS(
	CODIGO							BIGINT			NOT NULL,
	DNI								VARCHAR(20)		UNIQUE,
	NOMBRE							VARCHAR(100)	,
	APELLIDO1						VARCHAR(100)	,
	APELLIDO2						VARCHAR(100)	,
	DIRECCION						VARCHAR(100)	,
	POBLACION						VARCHAR(100)	,
	CODIGO_POSTAL					VARCHAR(10)		,
	PROVINCIA						VARCHAR(100)	,
	PAIS							VARCHAR(100)	,
	TELEFONO						VARCHAR(25)		,
	MOVIL							VARCHAR(25)		,
	EMAIL							VARCHAR(250)	,
	PRIMARY KEY(CODIGO)
);

CREATE TABLE CLIENTES(
	CODIGO							BIGINT			NOT NULL,
	GOLD							BOOLEAN			NOT NULL,
	PRIMARY KEY(CODIGO),
	FOREIGN KEY(CODIGO) REFERENCES PERSONAS(CODIGO)
);

CREATE TABLE EMPLEADOS(
	CODIGO							BIGINT			NOT NULL,
	LICENCIA_MANIPULADOR_ALIMENTOS	VARCHAR(10)		,
	PRIMARY KEY(CODIGO),
	FOREIGN KEY(CODIGO) REFERENCES PERSONAS(CODIGO)
);

CREATE TABLE PEDIDOS(
	CODIGO							BIGINT			NOT NULL,
	FECHA_HORA						TIMESTAMP		NOT NULL,
	CODIGO_EMPLEADO					BIGINT			NOT NULL,
	CODIGO_CLIENTE		    		BIGINT			,
	ID_ESTABLECIMIENTO				BIGINT			NOT NULL,
	ESTADO							VARCHAR(20)		NOT NULL,
	COMENTARIO                      VARCHAR(250)    ,
	PRIMARY KEY (CODIGO),
	FOREIGN KEY (CODIGO_EMPLEADO) REFERENCES EMPLEADOS (CODIGO),
	FOREIGN KEY (CODIGO_CLIENTE) REFERENCES CLIENTES (CODIGO),
	FOREIGN KEY (ID_ESTABLECIMIENTO) REFERENCES ESTABLECIMIENTOS (ID)
);

CREATE TABLE LINEAS_PEDIDO(
	CODIGO_PEDIDO					BIGINT			NOT NULL,
	ORDEN							INTEGER			NOT NULL,
	CODIGO_PRODUCTO					BIGINT			NOT NULL,
	CANTIDAD						INTEGER			NOT NULL,
	PRECIO							DOUBLE			,
	FOREIGN KEY (CODIGO_PEDIDO) REFERENCES PEDIDOS (CODIGO),
	FOREIGN KEY (CODIGO_PRODUCTO) REFERENCES PRODUCTOS (CODIGO)
);

-- ******************************************************
-- 
--                  SPRING SECURITY 
-- 
-- ******************************************************

CREATE TABLE ROLES (
    ID 					       		BIGINT			    NOT NULL,
    NAME                       		VARCHAR(50) 		NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE USERS (
    ID 								BIGINT		        NOT NULL,
    USERNAME 						VARCHAR(50) 		NOT NULL UNIQUE,
    PASSWORD 						VARCHAR(100) 		NOT NULL,
    EMAIL 							VARCHAR(150) 		,
    TELEFONO						VARCHAR(50)			,
    ENABLED 						BOOLEAN 			NOT NULL,
    FIRST_NAME 						VARCHAR(50) 		NOT NULL,
    LAST_NAME 						VARCHAR(50) 		NOT NULL,
    LAST_PASSWORD_RESET_DATE 		DATETIME 			NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE USER_ROLES (
    ID_USER                     	BIGINT              NOT NULL,
    ID_ROL                      	BIGINT              NOT NULL,
    FOREIGN KEY (ID_USER) REFERENCES USERS (ID),
    FOREIGN KEY (ID_ROL) REFERENCES ROLES (ID)
);