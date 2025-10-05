CREATE TABLE ADMINISTRATIVO 
    ( 
     id_empleado NUMBER (4)  NOT NULL 
    ) 
;

ALTER TABLE ADMINISTRATIVO 
    ADD CONSTRAINT ADMINISTRATIVO_PK PRIMARY KEY ( id_empleado ) ;

CREATE TABLE AFP 
    ( 
     id_afp  NUMBER (5)  GENERATED ALWAYS AS IDENTITY
		START WITH 210
		MINVALUE 210
		NOMAXVALUE
		INCREMENT BY 6
	 NOT NULL , 
     nom_afp VARCHAR2 (255)  NOT NULL 
    ) 
;

ALTER TABLE AFP 
    ADD CONSTRAINT AFP_PK PRIMARY KEY ( id_afp ) ;

CREATE TABLE CATEGORIA 
    ( 
     id_categoria     NUMBER (3)  NOT NULL , 
     nombre_categoria VARCHAR2 (255)  NOT NULL 
    ) 
;

ALTER TABLE CATEGORIA 
    ADD CONSTRAINT CATEGORIA_PK PRIMARY KEY ( id_categoria ) ;

CREATE TABLE COMUNA 
    ( 
     id_comuna  NUMBER (4)  NOT NULL , 
     nom_comuna VARCHAR2 (100)  NOT NULL , 
     cod_region NUMBER (4)  NOT NULL 
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_PK PRIMARY KEY ( id_comuna ) ;

CREATE TABLE DETALLE_VENTA 
    ( 
     cod_venta    NUMBER (4)  NOT NULL , 
     cod_producto NUMBER (4)  NOT NULL , 
     cantidad     NUMBER (6)  NOT NULL 
    ) 
;

ALTER TABLE DETALLE_VENTA 
    ADD CONSTRAINT DETALLE_VENTA_PK PRIMARY KEY ( cod_venta, cod_producto ) ;
ALTER TABLE DETALLE_VENTA 
		ADD CONSTRAINT ck_cantidad_minima CHECK (cantidad >=1) ;

CREATE TABLE EMPLEADO 
    ( 
     id_empleado        NUMBER (4)  NOT NULL , 
     rut_empleado       VARCHAR2 (10)  NOT NULL , 
     nombre_empleado    VARCHAR2 (25)  NOT NULL , 
     apellido_paterno   VARCHAR2 (25)  NOT NULL , 
     apellido_materno   VARCHAR2 (25)  NOT NULL , 
     fecha_contratacion DATE  NOT NULL , 
     sueldo_base        NUMBER (10)  NOT NULL , 
     bono_jefatura      NUMBER (10) , 
     activo             CHAR (1)  NOT NULL , 
     tipo_empleado      VARCHAR2 (25)  NOT NULL , 
     cod_empleado       NUMBER (4) , 
     cod_salud          NUMBER (4)  NOT NULL , 
     cod_afp            NUMBER (5)  NOT NULL 
    ) 
;

ALTER TABLE EMPLEADO 
    ADD CONSTRAINT EMPLEADO_PK PRIMARY KEY ( id_empleado ) ;

ALTER TABLE EMPLEADO 
	ADD CONSTRAINT ck_sueldo_minimo CHECK (sueldo_base >=400000) ;

CREATE TABLE MARCA 
    ( 
     id_marca     NUMBER (3)  NOT NULL , 
     nombre_marca VARCHAR2 (25)  NOT NULL 
    ) 
;

ALTER TABLE MARCA 
    ADD CONSTRAINT MARCA_PK PRIMARY KEY ( id_marca ) ;
	
ALTER TABLE MARCA 
	ADD CONSTRAINT marca_unica UNIQUE (nombre_marca);

CREATE TABLE MEDIO_PAGO 
    ( 
     id_mpago     NUMBER (3)  NOT NULL , 
     nombre_mpago VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE MEDIO_PAGO 
    ADD CONSTRAINT MEDIO_PAGO_PK PRIMARY KEY ( id_mpago ) ;

CREATE TABLE PRODUCTO 
    ( 
     id_producto     NUMBER (4)  NOT NULL , 
     nombre_producto VARCHAR2 (100)  NOT NULL , 
     precio_unitario NUMBER  NOT NULL , 
     origen_nacional CHAR (1)  NOT NULL , 
     stock_minimo   NUMBER (3)  NOT NULL , 
     activo          CHAR (1)  NOT NULL , 
     cod_marca       NUMBER (3)  NOT NULL , 
     cod_categoria   NUMBER (3)  NOT NULL , 
     cod_proveedor   NUMBER (5)  NOT NULL 
    ) 
;

ALTER TABLE PRODUCTO 
    ADD CONSTRAINT PRODUCTO_PK PRIMARY KEY ( id_producto ) ;
ALTER TABLE PRODUCTO 
	ADD CONSTRAINT ck_inventario CHECK (stock_minimo >= 3) ;	

CREATE TABLE PROVEEDOR 
    ( 
     id_proveedor     NUMBER (5)  NOT NULL , 
     nombre_proveedor VARCHAR2 (150)  NOT NULL , 
     rut_proveedor    VARCHAR2 (10)  NOT NULL , 
     telefono         VARCHAR2 (10)  NOT NULL , 
     email            VARCHAR2 (200)  NOT NULL , 
     direccion        VARCHAR2 (200)  NOT NULL , 
     cod_comuna       NUMBER (4)  NOT NULL 
    ) 
;

ALTER TABLE PROVEEDOR 
    ADD CONSTRAINT PROVEEDOR_PK PRIMARY KEY ( id_proveedor ) ;
ALTER TABLE PROVEEDOR 
	ADD CONSTRAINT un_email_por_proveedor UNIQUE (email);

CREATE TABLE REGION 
    ( 
     id_region  NUMBER (4)  NOT NULL , 
     nom_region VARCHAR2 (255)  NOT NULL 
    ) 
;

ALTER TABLE REGION 
    ADD CONSTRAINT REGION_PK PRIMARY KEY ( id_region ) ;

CREATE TABLE SALUD 
    ( 
     id_salud  NUMBER (4)  NOT NULL , 
     nom_salud VARCHAR2 (40)  NOT NULL 
    ) 
;

ALTER TABLE SALUD 
    ADD CONSTRAINT SALUD_PK PRIMARY KEY ( id_salud ) ;

CREATE TABLE VENDEDOR 
    ( 
     id_empleado    NUMBER (4)  NOT NULL , 
     comision_venta NUMBER (5,2) 
    ) 
;

ALTER TABLE VENDEDOR 
    ADD CONSTRAINT VENDEDOR_PK PRIMARY KEY ( id_empleado ) ;
ALTER TABLE VENDEDOR 	
	ADD CONSTRAINT ck_comision_maxima CHECK (comision_venta BETWEEN 0 AND 0.25) ;	

CREATE TABLE VENTA 
    ( 
     id_venta     NUMBER (4) GENERATED ALWAYS AS IDENTITY
		START WITH 5050
		MINVALUE 5050
		NOMAXVALUE
		INCREMENT BY 3
		NOT NULL , 
     fecha_venta  DATE  NOT NULL , 
     total_venta  NUMBER (10)  NOT NULL , 
     cod_mpago    NUMBER (3)  NOT NULL , 
     cod_empleado NUMBER (4)  NOT NULL 
    ) 
;

ALTER TABLE VENTA 
    ADD CONSTRAINT VENTA_PK PRIMARY KEY ( id_venta ) ;

ALTER TABLE ADMINISTRATIVO 
    ADD CONSTRAINT ADMINISTRATIVO_EMPLEADO_FK FOREIGN KEY 
    ( 
     id_empleado
    ) 
    REFERENCES EMPLEADO 
    ( 
     id_empleado
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_REGION_FK FOREIGN KEY 
    ( 
     cod_region
    ) 
    REFERENCES REGION 
    ( 
     id_region
    ) 
;

ALTER TABLE DETALLE_VENTA 
    ADD CONSTRAINT DETALLE_VENTA_PRODUCTO_FK FOREIGN KEY 
    ( 
     cod_producto
    ) 
    REFERENCES PRODUCTO 
    ( 
     id_producto
    ) 
;

ALTER TABLE DETALLE_VENTA 
    ADD CONSTRAINT DETALLE_VENTA_VENTA_FK FOREIGN KEY 
    ( 
     cod_venta
    ) 
    REFERENCES VENTA 
    ( 
     id_venta
    ) 
;

ALTER TABLE EMPLEADO 
    ADD CONSTRAINT EMPLEADO_AFP_FK FOREIGN KEY 
    ( 
     cod_afp
    ) 
    REFERENCES AFP 
    ( 
     id_afp
    ) 
;

ALTER TABLE EMPLEADO 
    ADD CONSTRAINT EMPLEADO_EMPLEADO_FK FOREIGN KEY 
    ( 
     cod_empleado
    ) 
    REFERENCES EMPLEADO 
    ( 
     id_empleado
    ) 
;

ALTER TABLE EMPLEADO 
    ADD CONSTRAINT EMPLEADO_SALUD_FK FOREIGN KEY 
    ( 
     cod_salud
    ) 
    REFERENCES SALUD 
    ( 
     id_salud
    ) 
;

ALTER TABLE PRODUCTO 
    ADD CONSTRAINT PRODUCTO_CATEGORIA_FK FOREIGN KEY 
    ( 
     cod_categoria
    ) 
    REFERENCES CATEGORIA 
    ( 
     id_categoria
    ) 
;

ALTER TABLE PRODUCTO 
    ADD CONSTRAINT PRODUCTO_MARCA_FK FOREIGN KEY 
    ( 
     cod_marca
    ) 
    REFERENCES MARCA 
    ( 
     id_marca
    ) 
;

ALTER TABLE PRODUCTO 
    ADD CONSTRAINT PRODUCTO_PROVEEDOR_FK FOREIGN KEY 
    ( 
     cod_proveedor
    ) 
    REFERENCES PROVEEDOR 
    ( 
     id_proveedor
    ) 
;

ALTER TABLE PROVEEDOR 
    ADD CONSTRAINT PROVEEDOR_COMUNA_FK FOREIGN KEY 
    ( 
     cod_comuna
    ) 
    REFERENCES COMUNA 
    ( 
     id_comuna
    ) 
;

ALTER TABLE VENDEDOR 
    ADD CONSTRAINT VENDEDOR_EMPLEADO_FK FOREIGN KEY 
    ( 
     id_empleado
    ) 
    REFERENCES EMPLEADO 
    ( 
     id_empleado
    ) 
;

ALTER TABLE VENTA 
    ADD CONSTRAINT VENTA_EMPLEADO_FK FOREIGN KEY 
    ( 
     cod_empleado
    ) 
    REFERENCES EMPLEADO 
    ( 
     id_empleado
    ) 
;

ALTER TABLE VENTA 
    ADD CONSTRAINT VENTA_MEDIO_PAGO_FK FOREIGN KEY 
    ( 
     cod_mpago
    ) 
    REFERENCES MEDIO_PAGO 
    ( 
     id_mpago
    ) 
;

INSERT INTO REGION VALUES (1, 'Region Metropolitana');
INSERT INTO REGION VALUES (2, 'Valparaiso');
INSERT INTO REGION VALUES (3, 'Biobio');
INSERT INTO REGION VALUES (4, 'Los Lagos');

INSERT INTO AFP (nom_afp) VALUES ('Habitat');
INSERT INTO AFP (nom_afp) VALUES ('Cuprum');
INSERT INTO AFP (nom_afp) VALUES ('Provida');
INSERT INTO AFP (nom_afp) VALUES ('PlanVital');

CREATE SEQUENCE
seq_salud
START WITH 2050
MINVALUE 2050
NOMAXVALUE
INCREMENT BY 10
NOCYCLE;

INSERT INTO SALUD VALUES (seq_salud.NEXTVAL, 'Fonasa');
INSERT INTO SALUD VALUES (seq_salud.NEXTVAL, 'Colmena');
INSERT INTO SALUD VALUES (seq_salud.NEXTVAL, 'Banmedica');
INSERT INTO SALUD VALUES (seq_salud.NEXTVAL, 'Cruz Blanca');

INSERT INTO MEDIO_PAGO VALUES (11, 'Efectivo');
INSERT INTO MEDIO_PAGO VALUES (12, 'Tarjeta Debito');
INSERT INTO MEDIO_PAGO VALUES (13, 'Tarjeta Credito');
INSERT INTO MEDIO_PAGO VALUES (14, 'Cheque');

CREATE SEQUENCE
seq_empleado
START WITH 750
MINVALUE 750
NOMAXVALUE
INCREMENT BY 3
NOCYCLE;

INSERT INTO EMPLEADO VALUES (seq_empleado.NEXTVAL, '11111111-1', 'Marcela', 'Gonzales', 'Peres', DATE '2022-03-15', 950000, 80000, 'S', 'Administrativo', NULL, 2050, 210);
INSERT INTO EMPLEADO VALUES (seq_empleado.NEXTVAL, '22222222-2', 'Jose', 'muñoz', 'Ramirez	', DATE '2021-07-10', 900000, 75000, 'S', 'Administrativo', NULL, 2060, 216);
INSERT INTO EMPLEADO VALUES (seq_empleado.NEXTVAL, '33333333-3', 'Veronica', 'Soto', 'Alarcon	', DATE '2020-01-05', 880000, 70000, 'S', 'Vendedor', 750, 2060, 228);
INSERT INTO EMPLEADO VALUES (seq_empleado.NEXTVAL, '44444444-4', 'Luis', 'Reyes', 'Fuentes	', DATE '2023-04-01', 560000, NULL, 'S', 'Vendedor', 750, 2070, 228);
INSERT INTO EMPLEADO VALUES (seq_empleado.NEXTVAL, '55555555-5', 'Claudia', 'Fernandez', 'Lagos	', DATE '2023-04-15', 600000, NULL, 'S', 'Vendedor', 753, 2070, 216);
INSERT INTO EMPLEADO VALUES (seq_empleado.NEXTVAL, '66666666-6', 'Carlos', 'Navarro', 'Vega	', DATE '2023-05-01', 610000, NULL, 'S', 'Administrativo', 753, 2060, 210);
INSERT INTO EMPLEADO VALUES (seq_empleado.NEXTVAL, '77777777-7', 'Javiera', 'Pino', 'Rojas	', DATE '2023-05-10', 650000, NULL, 'S', 'Administrativo', 750, 2050, 210);
INSERT INTO EMPLEADO VALUES (seq_empleado.NEXTVAL, '88888888-8', 'Diego', 'Mella', 'Contreras	', DATE '2023-05-12', 620000, NULL, 'S', 'Vendedor', 750, 2060, 216);
INSERT INTO EMPLEADO VALUES (seq_empleado.NEXTVAL, '99999999-9', 'Fernanda', 'Salas', 'Herrera	', DATE '2023-05-18', 570000, NULL, 'S', 'Vendedor', 753, 2070, 228);
INSERT INTO EMPLEADO VALUES (seq_empleado.NEXTVAL, '10101010-0', 'Tomas', 'Vidal', 'Espinoza	', DATE '2023-06-01', 530000, NULL, 'S', 'Vendedor', NULL, 2050, 222);

INSERT INTO VENTA (fecha_venta, total_venta, cod_mpago, cod_empleado) VALUES (DATE '2023-05-12', 225990, 12, 771);
INSERT INTO VENTA (fecha_venta, total_venta, cod_mpago, cod_empleado) VALUES (DATE '2023-10-23', 524990, 13, 777);
INSERT INTO VENTA (fecha_venta, total_venta, cod_mpago, cod_empleado) VALUES (DATE '2023-02-17', 466990, 11, 759);



SELECT 
id_empleado AS "IDENTIFICADOR",
nom_empleado || ' ' || apellido_paterno || ' ' || apellido_materno AS "NOMBRE COMPLETO",
sueldo_base AS "SALARIO",
bono_jefatura AS "BONIFICACION",
(sueldo_base + bono_jefatura) AS "SALARIO SIMULADO"

FROM 
EMPLEADO
WHERE  bono_jefatura IS NOT NULL
AND activo = 'S'
ORDER BY (sueldo_base + bono_jefatura) DESC,
apellido_paterno DESC;


SELECT 
nom_empleado || ' ' || apellido_paterno || ' ' || apellido_materno AS "EMPLEADO",
sueldo_base AS "SUELDO",
(sueldo_base * 0.08) AS "POSIBLE AUMENTO",
sueldo_base * 1.08 AS "SALARIO SIMULADO"
FROM 
EMPLEADO
WHERE sueldo_base BETWEEN 550000 AND 800000
ORDER BY sueldo_base ASC;