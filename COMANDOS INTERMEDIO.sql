USE jugos_ventas;

SELECT DNI, NOMBRE, DIRECCION1, DIRECCION2, BARRIO, CIUDAD, ESTADO, 
CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA,
PRIMERA_COMPRA FROM tbcliente;

SELECT * FROM tbcliente;

SELECT DNI, NOMBRE FROM tbcliente;

SELECT DNI AS IDENTIFICACION, NOMBRE AS CLIENTE FROM tbcliente;

SELECT * FROM tbproducto;

SELECT * FROM tbproducto WHERE  SABOR = 'Uva';

SELECT * FROM tbproducto WHERE  SABOR = 'Mango';

SELECT * FROM tbproducto WHERE  ENVASE = 'Botella PET';

SELECT * FROM tbproducto WHERE  ENVASE = 'botella pet';

SELECT * FROM tbproducto WHERE PRECIO_DE_LISTA > 16;

SELECT * FROM tbproducto WHERE PRECIO_DE_LISTA <= 17;

SELECT * FROM tbproducto WHERE PRECIO_DE_LISTA BETWEEN 16 AND 16.02;

/* CONSULTAS CONDICIONALES */

SELECT * FROM tbproducto;

SELECT * FROM tbproducto WHERE SABOR='mango' AND TAMANO='470 ml';

SELECT * FROM tbproducto WHERE SABOR='mango' OR TAMANO='470 ml';

SELECT * FROM tbproducto WHERE NOT (SABOR='mango') OR TAMANO='470 ml';

SELECT * FROM tbproducto WHERE NOT (SABOR='mango' AND TAMANO='470 ml');

SELECT * FROM tbproducto WHERE SABOR='mango' AND NOT(TAMANO='470 ml');

SELECT * FROM tbproducto WHERE SABOR IN ('MANGO', 'UVA');

SELECT * FROM tbproducto WHERE SABOR = 'MANGO' OR  SABOR ='UVA';

SELECT * FROM tbclientes WHERE CIUDAD IN ('ciudad de México', 'Guadalajara');

SELECT * FROM tbcliente WHERE CIUDAD IN ('ciudad de México', 'Guadalajara')
AND EDAD > 21;

SELECT * FROM tbclientes WHERE CIUDAD IN ('ciudad de México', 'Guadalajara')
AND EDAD BETWEEN 20 AND 25;

SELECT * FROM tbclientes WHERE CIUDAD IN ('ciudad de México', 'Guadalajara')
AND (EDAD BETWEEN 20 AND 25);

/*CONSULTAS LIKE*/

SELECT * FROM tbproducto WHERE SABOR LIKE '%manzana';

SELECT * FROM tbproducto WHERE SABOR LIKE '%manzana'
AND ENVASE = 'Botella PET';

/*DISTINCT*/
/*solo te muestra una vez un registro, no los duplicados?*/
SELECT ENVASE, TAMANO FROM tbproducto;
SELECT ENVASE, TAMANO FROM tbproducto
WHERE SABOR='Naranja';

/*LIMIT*/
SELECT *FROM tbproducto LIMIT 5;
#muestra del indice 5, 4 registros
SELECT *FROM tbproducto LIMIT 5,4;

/*ORDER BY*/
SELECT *FROM tbproducto ORDER BY PRECIO_LISTA;
# EL MAS CARO AL MAS BARATO DESC
SELECT *FROM tbproducto ORDER BY PRECIO_LISTA DESC;
SELECT *FROM tbproducto ORDER BY NOMBRE;
SELECT *FROM tbproducto ORDER BY NOMBRE DESC;
SELECT *FROM tbproducto ORDER BY ENVASE DESC, NOMBRE ASC;

Select *from tbcliente;

/*GRUOU BY*/
SELECT ESTADO, LIMITE_CREDITO FROM tbcliente;
SELECT ESTADO, SUM(LIMITE_CREDITO) AS LIMITE_TOTAL FROM tbcliente GROUP BY ESTADO;
SELECT*FROM tbproducto;
SELECT ENVASE, PRECIO_LISTA FROM tbproducto;
SELECT ENVASE, MAX(PRECIO_LISTA) AS MAYOR_PRECIO FROM tbproducto GROUP BY ENVASE;
#contar todos los elementos de envase?
SELECT ENVASE, COUNT(*) FROM tbproducto Group BY ENVASE;
#VA A AGREGAR POR BARRIO EL LIMITE DE CREDITO
SELECT CIUDAD, BARRIO, SUM(LIMITE_CREDITO) AS LIMITE FROM tbcliente 
WHERE CIUDAD='CIUDAD DE MÉXICO' GROUP BY BARRIO;

#VA A AGREGAR POR BARRIO EL LIMITE DE CREDITO
SELECT CIUDAD, BARRIO, MAX(LIMITE_CREDITO) AS LIMITE FROM tbcliente 
WHERE CIUDAD='CIUDAD DE MÉXICO' GROUP BY BARRIO;
SELECT ESTADO, BARRIO, EDAD FROM tbcliente;

SELECT ESTADO, BARRIO, MAX(LIMITE_CREDITO) AS LIMITE, 
EDAD FROM tbcliente 
WHERE EDAD>=20
GROUP BY ESTADO, BARRIO
ORDER BY EDAD;

/*HAVING*/
SELECT ESTADO, SUM(LIMITE_CREDITO) AS LIMITE_TOTAL FROM tbcliente GROUP BY ESTADO;

SELECT ENVASE, MAX(PRECIO_LISTA) AS PRECIO_MAXIMO,
MIN(PRECIO_LISTA) AS PRECIO_MINIMO
 FROM tbproducto GROUP BY ENVASE;
 
 
SELECT ENVASE, MAX(PRECIO_LISTA) AS PRECIO_MAXIMO,
MIN(PRECIO_LISTA) AS PRECIO_MINIMO,
SUM(PRECIO_LISTA) AS SUMA_PRECIO
FROM tbproducto GROUP BY ENVASE
HAVING SUM(PRECIO_LISTA)>=80 AND MAX(PRECIO_LISTA)>=5;
 
SELECT DNI, COUNT(*) FROM facturas
WHERE YEAR(FECHA_VENTA) = 2016
GROUP BY DNI
HAVING COUNT(*) > 2000;


/*CASE */
#Se realiza un test en uno o más campos y dependiendo del resultado, obtendremos un valor especifico
/* sintaxis
SELECT CAMPO
Case
WHEN <condicion_1> THEN <Value_1>
WHEN <condicion_2> THEN <Value_2>
WHEN <condicion_n> THEN <Value_n>
ELSE <Value_ELSE>
END 
FROM TABLA */
SELECT *FROM tbproducto;


SELECT NOMBRE, PRECIO_LISTA,
CASE 
WHEN PRECIO_LISTA>=12 THEN "COSTOSO"
WHEN PRECIO_LISTA>=5 AND PRECIO_LISTA<12 THEN "ACCESIBLE "
ELSE "BARATO"
END AS PRECIO
FROM tbproducto;


SELECT ENVASE, SABOR,
CASE
   WHEN PRECIO_LISTA >= 12 THEN 'Costoso'
   WHEN PRECIO_LISTA >= 5 AND PRECIO_LISTA < 12 THEN 'Asequible'
   ELSE 'Barato'
END AS PRECIO, MIN(PRECIO_LISTA) AS PRECIO_MINIMO
FROM tbproducto
WHERE TAMANO = '700 ml'
GROUP BY ENVASE,
CASE
   WHEN PRECIO_LISTA >= 12 THEN 'Costoso'
   WHEN PRECIO_LISTA >= 5 AND PRECIO_LISTA < 12 THEN 'Asequible'
   ELSE 'Barato'
END
ORDER BY ENVASE;


SELECT NOMBRE,
CASE 
    WHEN YEAR(fecha_nacimiento) < 1990 THEN 'Viejos'
    WHEN YEAR(fecha_nacimiento) >= 1990 
    AND YEAR(fecha_nacimiento) <= 1995 THEN 'Jóvenes' 
    ELSE 'Niños' 
END AS CLASIFICACION_EDAD
FROM tbcliente;

/*JOINS*/
SELECT * FROM tabla_de_vendedores;
SELECT * FROM facturas;
#Podemos conectar estas dos tablas por un campo en común (MATRICULA). Digita:
SELECT * FROM tabla_de_vendedores A
INNER JOIN
facturas B
ON A.MATRICULA = B.MATRICULA;

#Podemos aplicar agrupamientos al resultado de la consulta que conecta una o más tablas:
SELECT A.NOMBE, B.MATRICULA, COUNT(*) FROM tabla_de_vendedores A
INNER JOIN
facturas B
ON A.MATRICULA = B.MATRICULA
GROUP BY A.NOMBE, B.MATRICULA;
#No siempre todos los registros pueden ser conectados. Existen otros tipos de JOIN que nos permiten identificar lo que no puede ser conectado. Observa la siguiente consulta:
SELECT count(*) FROM tbcliente;
# Vamos a realizar un JOIN con la tabla de facturas para ver cuántos clientes poseen facturas emitidas. Digita:
SELECT DISTINCT A.DNI, A.NOMBRE, B.DNI FROM tbcliente A
INNER JOIN
facturas B
ON A.DNI = B.DNI;
#Si cuentas a los clientes verás que, en la consulta acima, tenemos 12 registros. Existen tres clientes que están registrados pero nunca se les emitió facturas.

# Podemos usar un LEFT JOIN. Digita:
SELECT DISTINCT A.DNI, A.NOMBRE, A.CIUDAD, B.DNI FROM tbcliente A
LEFT JOIN
facturas B
ON A.DNI = B.DNI;

SELECT DISTINCT A.DNI, A.NOMBRE, A.CIUDAD, B.DNI FROM tbcliente A
LEFT JOIN
facturas B
ON A.DNI = B.DNI
WHERE B.DNI IS NULL;

# Podemos juntar dos o más consultas, Desde que los campos seleccionados sean los mismos. Digita:
SELECT DISTINCT BARRIO FROM tbcliente
UNION
SELECT DISTINCT BARRIO FROM tabla_de_vendedores;

#El comando UNION ALL no realiza la selección con un DISTINCT. Los registros se repiten si existen en ambas tablas. Digita:
#se puede repetir
SELECT DISTINCT BARRIO FROM tbcliente
UNION ALL
SELECT DISTINCT BARRIO FROM tabla_de_vendedores;

#11) Podemos simular el FULL JOIN, que no es soportado por MySQL, usando el LEFT JOIN y el RIGHT JOIN con UNION. Digita:
SELECT tbcliente.NOMBRE, tbcliente.CIUDAD, tbcliente.BARRIO,
tabla_de_vendedores.NOMBE, DE_VACACIONES
FROM tbcliente
LEFT JOIN
tabla_de_vendedores
ON tbcliente.BARRIO = tabla_de_vendedores.BARRIO
UNION
SELECT tbcliente.NOMBRE, tbcliente.CIUDAD, tbcliente.BARRIO,
tabla_de_vendedores.NOMBE, DE_VACACIONES
FROM tbcliente
RIGHT JOIN
tabla_de_vendedores
ON tbcliente.BARRIO = tabla_de_vendedores.BARRIO;

#Las subconsultas permiten realizar selecciones usando como criterios otras selecciones. Digita:
SELECT * FROM tbcliente
WHERE BARRIO IN (SELECT DISTINCT BARRIO FROM tabla_de_vendedores);

# Podemos aplicar una consulta sobre otra consulta directamente. Digita:
SELECT X.ENVASE, X.PRECIO_MAXIMO FROM
(SELECT ENVASE, MAX(PRECIO_LISTA) 
AS PRECIO_MAXIMO FROM tbproducto GROUP BY ENVASE) X
WHERE X.PRECIO_MAXIMO >=10;

#Podemos transformar una consulta en una vista (View) que después puede ser usada en otras consultas como una tabla. 
#Crea la vista. Para ello, expande el árbol de la esquina superior izquierda, donde tenemos el nombre de la base, y vaya a Views.
/* CREATE VIEW ‘vw_envases_grandes’
AS SELECT ENVASE, MAX(PRECIO_LISTA) 
AS PRECIO_MAXIMO FROM tbproducto GROUP BY ENVASE; */

#Podemos manipular la vista como una tabla. Digita:
SELECT X.ENVASE, X. PRECIO_MAXIMO FROM
vw_envases_grandes X 
WHERE PRECIO_MAXIMO >=10;

#Podemos crear JOINs de tablas con views:
SELECT A.NOMBRE, A.ENVASE, A.PRECIO_LISTA, 
B.PRECIO_MAXIMO FROM tbproducto A
INNER JOIN
vw_envases_grandes B
ON A.ENVASE = B.ENVASE;


#FUNCIONES STRING
SELECT LTRIM("    MySQL es fácil") AS RESULTADO;
SELECT RTRIM("MySQL es fácil    ") AS RESULTADO;
SELECT TRIM("    MySQL es fácil    ") AS RESULTADO;
SELECT CONCAT("MySQL es fácil,", " no lo crees?") AS RESULTADO;
SELECT UPPER("mysql es una base de datos interesante.") AS RESULTADO;
SELECT LOWER("MYSQL ES UNA BASE DE DATOS INTERESANTE.") AS RESULTADO;
SELECT SUBSTRING("mysql es una base de datos interesante.", 14,4) AS RESULTADO;
SELECT CONCAT(NOMBRE, " ", DNI) AS RESULTADO FROM tbcliente;


#FUNCIONES DATE/FECHA
SELECT CURDATE();
SELECT CURRENT_TIMESTAMP();
SELECT YEAR(CURRENT_TIMESTAMP());
SELECT MONTH(CURRENT_TIMESTAMP());
SELECT DAY(CURRENT_TIMESTAMP());
SELECT MONTHNAME(CURRENT_TIMESTAMP());
SELECT DAYNAME(CURRENT_TIMESTAMP());
SELECT DATEDIFF(CURRENT_TIMESTAMP(), '2021-01-01') AS RESULTADO;
SELECT DATEDIFF(CURRENT_TIMESTAMP(), '1984-06-20') AS RESULTADO;
SELECT current_timestamp() AS DIA_HOY, 
DATE_SUB(current_timestamp(), INTERVAL 1 MONTH) AS RESULTADO;
SELECT DISTINCT FECHA_VENTA,
DAYNAME(FECHA_VENTA) AS DIA, MONTHNAME(FECHA_VENTA) AS MES, 
YEAR(FECHA_VENTA) AS AÑO FROM facturas;

#FUNCIONES MATEMATICAS
SELECT (34+346-67)/15 * 29 AS RESULTADO;
SELECT CEILING (23.1222);
SELECT FLOOR (23.999999);
SELECT RAND() AS RESULTADO;
SELECT ROUND(254.545,2); 
#SE DIFERENCIA POR LA CANTIDAD DE DECIMALES?
SELECT ROUND(254.545,1);
SELECT NUMERO, CANTIDAD, PRECIO, 
CANTIDAD * PRECIO AS FACTURACIÓN FROM items_facturas;
SELECT NUMERO, CANTIDAD, PRECIO, 
ROUND(CANTIDAD * PRECIO,2) AS FACTURACIÓN FROM items_facturas;

#FUNCIONES DE CONVERSION
SELECT CURRENT_TIMESTAMP() AS RESULTADO;
SELECT CONCAT("La fecha y la hora de hoy son: ", CURRENT_TIMESTAMP()) AS RESULTADO;
SELECT CONCAT("La fecha y el horario son: ",
DATE_FORMAT(CURRENT_TIMESTAMP(),"%W, %d/%m/%Y a las %T" )) AS RESULTADO;
SELECT CONVERT(23.45, CHAR) AS RESULTADO;
SELECT SUBSTRING(CONVERT(23.45, CHAR),3,1) AS RESULTADO;


/*REPORTES*/

/*Primero, generamos una selección que determina si las ventas mensuales 
por cliente son válidas o no. Consideramos válidas las ventas por debajo de la cantidad límite e inválidas
por encima de la cantidad límite existente en el registro del cliente. La consulta se muestra a continuación: */
SELECT A.DNI, A.NOMBRE, A.MES_AÑO, 
A.CANTIDAD_VENDIDA - A.CANTIDAD_MAXIMA AS DIFERENCIA,
CASE
   WHEN  (A.CANTIDAD_VENDIDA - A.CANTIDAD_MAXIMA) <= 0 THEN 'Venta Válida'
   ELSE 'Venta Inválida'
END AS STATUS_VENTA
 FROM(
SELECT F.DNI, TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y") AS MES_AÑO, 
SUM(IFa.CANTIDAD) AS CANTIDAD_VENDIDA, 
MAX(VOLUMEN_COMPRA)/10 AS CANTIDAD_MAXIMA  
FROM facturas F 
INNER JOIN 
items_facturas IFa
ON F.NUMERO = IFa.NUMERO
INNER JOIN 
tbcliente TC
ON TC.DNI = F.DNI
GROUP BY
F.DNI, TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y"))A;

/*Otro ejemplo de informe es el que determina la venta por sabores, para el año de 2016, 
presentando el porcentaje de participación de cada uno de estos sabores, ordenados.*/
SELECT VENTAS_SABOR.SABOR, VENTAS_SABOR.AÑO, VENTAS_SABOR.CANTIDAD_TOTAL,
ROUND((VENTAS_SABOR.CANTIDAD_TOTAL/VENTA_TOTAL.CANTIDAD_TOTAL)*100,2) 
AS PORCENTAJE FROM (
SELECT P.SABOR, SUM(IFa.CANTIDAD) AS CANTIDAD_TOTAL, 
YEAR(F.FECHA_VENTA) AS AÑO FROM
tbproducto P
INNER JOIN
items_facturas IFa

INNER JOIN
facturas F
ON F.NUMERO = IFa.NUMERO
WHERE YEAR(F.FECHA_VENTA) = 2016
GROUP BY P.SABOR, YEAR(F.FECHA_VENTA)
ORDER BY SUM(IFa.CANTIDAD) DESC) VENTAS_SABOR
INNER JOIN (
SELECT SUM(IFa.CANTIDAD) AS CANTIDAD_TOTAL, 
YEAR(F.FECHA_VENTA) AS AÑO FROM
tbproducto P
INNER JOIN
items_facturas IFa

INNER JOIN
facturas F
ON F.NUMERO = IFa.NUMERO
WHERE YEAR(F.FECHA_VENTA) = 2016
GROUP BY YEAR(F.FECHA_VENTA)) VENTA_TOTAL
ON VENTA_TOTAL.AÑO = VENTAS_SABOR.AÑO
ORDER BY VENTAS_SABOR.CANTIDAD_TOTAL DESC;
















SELECT A.DNI, A.NOMBRE, A.MES_AÑO, 
A.CANTIDAD_VENDIDA - A.CANTIDAD_MAXIMA AS DIFERENCIA,
CASE
   WHEN  (A.CANTIDAD_VENDIDA - A.CANTIDAD_MAXIMA) <= 0 THEN 'Venta Válida'
   ELSE 'Venta Inválida'
END AS STATUS_VENTA, ROUND((1 - (A.CANTIDAD_MAXIMA/A.CANTIDAD_VENDIDA)) * 100,2) AS PORCENTAJE
 FROM(
SELECT F.DNI, TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y") AS MES_AÑO, 
SUM(IFa.CANTIDAD) AS CANTIDAD_VENDIDA, 
MAX(VOLUMEN_DE_COMPRA)/10 AS CANTIDAD_MAXIMA  
FROM facturas F 
INNER JOIN 
items_facturas IFa
ON F.NUMERO = IFa.NUMERO
INNER JOIN 
tabla_de_clientes TC
ON TC.DNI = F.DNI
GROUP BY
F.DNI, TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y"))A
WHERE (A.CANTIDAD_MAXIMA - A.CANTIDAD_VENDIDA) < 0;
