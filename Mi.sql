-- primera de cometnar
/*
 segunda forma de comentar
*/

SELECT * FROM emp
ORDER BY dept_no, oficio DESC -- REFDJD

-- SELECT se escribe una sola vez por consulta 
-- WHERE siempre se escribe una sola vez Y luego del from

SELECT * 
FROM emp
 WHERE
 dept_no = 10; -- Números siempre sin comillas

SELECT * 
FROM emp
 WHERE
 oficio = 'DIRECTOR'; -- String siempre entre comillas simples



SELECT * 
FROM emp
 WHERE
 oficio != 'DIRECTOR'; -- String siempre entre comillas simples

SELECT * 
FROM emp
 WHERE
 oficio <> 'DIRECTOR'; -- La diferencia entre != y <> son exactamente igual pero "<>" funciona en cualquier base de datos



-- OPERADORES RELACIONALES (realiza mas de una condición dentro de una consulta)
SELECT * 
FROM emp
 WHERE
  dept_no = 10 and
  oficio = 'DIRECTOR';

SELECT * 
FROM emp
 WHERE
  dept_no = 10 OR
  oficio = 'DIRECTOR';



SELECT * 
FROM emp
 WHERE
 salario BETWEEN 251000 AND 390000; --incluye los valores
 
 SELECT * 
FROM emp
 WHERE
 salario >= 251000 AND 
 salario <= 390000;--incluye los valores
 
 
 
 SELECT * 
FROM emp
 WHERE NOT
  oficio = 'DIRECTOR'; --evitar usar el NOT porque hace doble consulta de manera interna

 SELECT * 
FROM emp
 WHERE 
  oficio != 'DIRECTOR'; --equivale al NOT pero es más eficioente
  
  
  
SELECT *
FROM emp
 WHERE 
  apellido LIKE 's%'; -- LIKE siempre va debe ir con % y entre comillas ej LIKE 's%', LIKE '%s' , LIKE'%s%'
  
SELECT *
FROM emp
 WHERE 
  apellido LIKE '____'; -- LIKE con subguión sirve para coincidir número de caracteres. Cada subguión equivale a un caracter. Ej _ un caracter; ___ tres carateres
  


SELECT *
FROM emp
 WHERE
  dept_no NOT IN(10, 20, 30, 77)

FROM emp
 WHERE
SELECT *
  dept_no NOT IN(10, 20, 30, 77);


--==========================================================================================================
-- CAMPOS CALCULADOS (es una herramienta en una consulta para crear campos en una tabla para obtener resultados tras algún calculo. Se usan en SELECT)
SELECT apellido, salario, comision, (salario +  comision) AS total
FROM emp
 ORDER BY total;



SELECT DISTINCT oficio -- valores únicos (borra duplicados)
FROM emp;


 
--====================================================================================================================================================================================================================
--PRÁCTICA
-- 1    
SELECT * FROM EMP;
-- 2
SELECT APELLIDO, OFICIO, SALARIO*14 AS "SALARIO ANUAL" 
FROM EMP
 WHERE
  COMISION > 100000;
--3
SELECT APELLIDO, OFICIO, SALARIO*14 AS "SALARIO ANUAL" 
FROM EMP 
 WHERE
  (SALARIO*14 + COMISION) > 750000;
--4
SELECT APELLIDO, OFICIO, SALARIO*14 AS "SALARIO ANUAL" 
FROM EMP
 WHERE
  (SALARIO*14 + COMISION) = 1000000;
--5
SELECT *
FROM EMP
 ORDER BY
  DEPT_NO,
  OFICIO;
--6
SELECT *
FROM ENFERMO
 WHERE
  FECHA_NAC < '11-01-1970'
 ORDER BY INSCRIPCION DESC;
 --7
SELECT *
FROM ENFERMO
 WHERE
  FECHA_NAC < '01-01-1970'
 ORDER BY FECHA_NAC DESC;
--8
SELECT *
FROM PLANTILLA;
 WHERE
  TURNO = 'M';
--9
SELECT APELLIDO
FROM PLANTILLA
 WHERE
  TURNO = 'N';
--10
SELECT APELLIDO
FROM DOCTOR
 WHERE
  SALARIO*14 > 3000000;
--11
SELECT APELLIDO
FROM PLANTILLA
 WHERE
  TURNO = 'M' AND
  SALARIO BETWEEN 2000000 AND 2250000;
--12
SELECT *
FROM EMP
 WHERE 
  NOT FECHA_ALT BETWEEN '01/01/1986' AND '12/12/1994';
-- NOT BETWEEN quivale a where fecha <= XXX OR fecha >= XXX
-- BETWEEN  esquivale a where fecha >= XXX AND fecha <= XXX
  
--13
SELECT *
FROM DEPT
 WHERE
  LOC IN ('MADRID', 'BARCELONA');



--====================================================================================================================================================================================================================
-- CNSULTAS DE AGRUPACIÓN
-- COUNT(*) considera los campos vacíos
-- COUNT(CAMPO) no considera los campos nulos
-- SUM(CAMPO) suma los valores de un campo tipo número
-- AVG(CAMPO) promedio de los valores de un campo tipo número
-- MAX(CAMPO) 
-- MIN(CAMPO) 

SELECT COUNT(*) AS "NUMERO DOCTORES" -- se usa con doble comilla
FROM DOCTOR;

SELECT COUNT(APELLIDO) AS NUMERO_DOCTORES -- en vez de espacio se debe colocar subguion
FROM DOCTOR;

SELECT * FROM DOCTOR;

SELECT COUNT(*) AS DOCOTOR, ESPECIALIDAD
FROM DOCTOR
 GROUP BY
  ESPECIALIDAD;

SELECT 
 COUNT(*) AS N_PERSONAS, 
 MAX(SALARIO) AS MAX_SALARIO, 
 MIN(SALARIO), 
 SALA_COD, 
 FUNCION,
 TURNO
FROM PLANTILLA
 GROUP BY
  SALA_COD, 
  FUNCION,
  TURNO;




--====================================================================================================================================================================================================================
-- FILTRANDO CONSULTAS DE AGRUPACIÓN
-- WHERE: para campos que esten EN LA TABLA (se usa ANTES del GROUP BY) -- PARA GRANDES VOLUMNES
-- HAVING: para campos que esten EN EL SELECT (se usa LUEGO del GROUP BY) -- PARA INMENSOS VOLUMNES
-- WHERE y HAVING NO trabajan con ALIAS
-- GROUP BY trabaja con ALIAS

SELECT
 COUNT(*) AS N_EMPLEADOS, 
 OFICIO
FROM EMP
 WHERE
  SALARIO > 0
 GROUP BY
  OFICIO
 HAVING
  OFICIO IN ('ANALISTA', 'VENDEDOR');
  


SELECT 
 COUNT(*) AS n_EMPLEADOS,
 OFICIO
FROM EMP
 GROUP BY OFICIO
 HAVING COUNT(*) > 2;
  


--====================================================================================================================================================================================================================
-- EJERCICIOS JOIN

--1
SELECT 
 EMP.APELLIDO, 
 EMP.OFICIO, 
 EMP.SALARIO,
 EMP_NO, 
 DEPT.DNOMBRE
FROM EMP
 LEFT JOIN DEPT
  ON EMP.DEPT_NO = DEPT.DEPT_NO;

--2
SELECT 
HOSPITAL.NOMBRE,
SALA.NOMBRE
FROM HOSPITAL
 LEFT JOIN SALA
  ON HOSPITAL.HOSPITAL_COD = SALA.HOSPITAL_COD;

--3
SELECT
COUNT(EMP.APELLIDO),
DEPT.LOC
FROM EMP
 LEFT JOIN DEPT
  ON EMP.DEPT_NO = DEPT.DEPT_NO
 GROUP BY
  DEPT.LOC;

--4
SELECT
 COUNT(APELLIDO),
 EMP.OFICIO,
 DEPT.DNOMBRE
FROM EMP
 LEFT JOIN DEPT
  ON EMP.DEPT_NO = DEPT.DEPT_NO
 GROUP BY
  EMP.OFICIO,
  DEPT.DNOMBRE;

--5
SELECT
HOSPITAL.NOMBRE,
SALA.NOMBRE,
COUNT(SALA.NOMBRE)
FROM HOSPITAL
 LEFT JOIN SALA
  ON HOSPITAL.HOSPITAL_COD = SALA.HOSPITAL_COD
 GROUP BY
  HOSPITAL.NOMBRE,
  SALA.NOMBRE;

--6
SELECT
COUNT(EMP.APELLIDO),
DEPT.DNOMBRE
FROM EMP
 LEFT JOIN DEPT
  ON EMP.DEPT_NO = DEPT.DEPT_NO
 WHERE
  EMP.FECHA_ALT BETWEEN '01-01-1997' AND '01-01-1998'
 GROUP BY
   DEPT.DNOMBRE;

--7
SELECT
DEPT.LOC,
COUNT(EMP.APELLIDO)
FROM DEPT
 LEFT JOIN EMP
  ON DEPT.DEPT_NO = EMP.DEPT_NO
 GROUP BY
   DEPT.LOC
 HAVING
  COUNT(EMP.APELLIDO) > 4;

--8
SELECT
 DEPT.LOC,
 AVG(SALARIO)
FROM DEPT
 LEFT JOIN EMP
  ON DEPT.DEPT_NO = EMP.DEPT_NO
 WHERE
  DEPT.LOC IN ('SEVILLA', 'MADRID')
 GROUP BY
  DEPT.LOC;
  
--9
SELECT
 DOCTOR.DOCTOR_NO,
 HOSPITAL.NOMBRE,
 HOSPITAL.TELEFONO,
 HOSPITAL.DIRECCION
FROM DOCTOR
 LEFT JOIN HOSPITAL
  ON DOCTOR.HOSPITAL_COD = HOSPITAL.HOSPITAL_COD;

--10
SELECT
MAX(DOCTOR.SALARIO),
HOSPITAL.NOMBRE
FROM DOCTOR
 LEFT JOIN HOSPITAL
  ON DOCTOR.HOSPITAL_COD = HOSPITAL.HOSPITAL_COD
 GROUP BY
  HOSPITAL.NOMBRE;
  
--11
SELECT
*
FROM DEPT;


SELECT
*
FROM HOSPITALL;

SELECT
*
FROM DEPT;



--====================================================================================================================================================================================================================
-- SUBCONSULTAS
-- CONSULTAS QUE REQUIEREN DE OTRA CONSULTA
-- NO SON AUTÓNOMAS
-- PUEDE RELENTIZAR SI EXISTE MUCHA ANIDACIÓN
-- GENERAN BLOQUEOS EN CONSULTAS SELECT
-- LAS UBCONSULTAS VAN ENTRE PARÉNTESIS
-- SI UNA SUBCONSULTA DA MAS DE UN VALRO SE UTILIZA "AND"
-- SI DOS TABLAS TIENE RELACIÓN NO USAR SUBCONSULTA, PERO SI NO TIENEN RELACIÓN SI UTILIZAR SUBCONSULTAS


-- PREMISOS PARA HACER LA CONSULTAS
SELECT * MAX(SALARIO) 
FROM EMP;

SELECT * 
FROM EMP WHERE SALARIO = 65000;
  
-- EN CONSULTA STANDAR
SELECT MAX(SALARIO) 
FROM EMP 
 WHERE SALARIO = 65000;
      
-- EN SUBCONSULTA
SELECT * FROM EMP WHERE SALARIO = 
 (SELECT MAX(SALARIO)FROM EMP);

-- MOSTRAR LOS EMPLEADOS QUE TIENEN EL MISO OFICIO QUE EL EMPLEADO GIL
SELECT * FROM EMP WHERE OFICIO = 
 (SELECT OFICIO FROM EMP WHERE APELLIDO = 'GIL') AND SALARIO < (SELECT SALARIO FROM EMP WHERE APELLIDO = 'JIMENEZ')

-- MOSTRAR LOS EMPLEADOS QUE TIENEN EL MISO OFICIO QUE EL EMPLEADO GIL
SELECT * EMP WHERE OFICIO IN 
 (SELECT OFICIO FROM EMP WHERE APELLIDO 'GIL' AND 'APELLIDO' = "JIMENEZ");
  

--====================================================================================================================================================================================================================
-- CONSULTAS UNION
-- MUESTRAN EN UN MISMO CURSOS UN MISMO CONJUNTO DE RESULTADOS
-- ESTAS CONSULTAS SE UTILIZAN COMO CONCEPTOS, NO COMO RELACIONES
-- TRES NORMAS A SEGUIR:
-- -- LA PRIMERA CONSULTA ES LA CONSULTA PADRE
-- -- TODAS LAS CONSULTA DBE TNER EL MISNO NÚMERO DE CONSULTAS
-- -- TODAS LAS CONSULTAS DEBEN TENER EL MISMO TIP DE DATO ENTRE SÍ
-- EN NUESTRA BASE DE DATOS, TENEMOS DATOS DE PERSONAS EN DIFERENTES TABALAS


-- TABLAS RELACIONALES JOIN
-- TABLAS CONCEPTUALES CONSULTAS UNIÓN

SELECT APELLIDO, OFICIO, SALARIO FROM EMP;
SELECT APELLIDO, FUNCION, SALARIO FROM PLANTILLA;
 --VERIFICNDO LAS REGLAS
-- -- LA PRIMERA CONSULTA ES LA CONSULTA PADRE (APELLIDO, OFICIO, SALARIO)
-- -- TODAS LAS CONSULTA DBE TNER EL MISNO NÚMERO DE CONSULTA (APELLIDO, OFICIO, SALARIO) Y (APELLIDO, FUNCION, SALARIO)
-- -- TODAS LAS CONSULTAS DEBEN TENER EL MISMO TIP DE DATO ENTRE SÍ (APELLIDO, OFICIO) Y (APELLIDO, FUNCION) SON STRING Y (SALARIO) Y (SALARIO) SON NÚMERO
-- -- TODAS LAS CONSULTAS DEBEN TENER EL MISMO TIP DE DATO ENTRE SÍ

SELECT APELLIDO, OFICIO, SALARIO FROM EMP
UNION
SELECT APELLIDO, FUNCION, SALARIO FROM PLANTILLA
WHERE SALARIO = 123500 -- LOS "WHERE" APLICA AL SELECT QUE LE CORRESPONDA, ES DECIR APLICARÁ EL FILTRADO UNICAMENTE A ESTA SECCIÓN DE DATOS MIESTRAS QUE AL RESTO DE SELECT MANTENDRÁN INTACTOS LOS DATOS
UNION -- SE PUEDEN AÑADIR MÁS UNION, SIEMPRE Y CUANDO CUMPLAN CON LOAS TRES REGLAS
SELECT APELLIDO, ESPECIALIDAD, SALARIO FROM DOCTOR
ORDER BY 1; -- SE ACONSEJA ORDENA POR EL NÚMERO DE COLUMNA Y NO POR NOMBRE DE CAMPO PADRE. LOS ALIAS AQUI NO FUNCIONAN -- EL "ORDER BY" APLICA A TODOS LOS "SELECT" 


-- UNION ELIMINARÁ LOS DUPLICADOS
SELECT APELLIDO, SALARIO FROM EMP
UNION
SELECT APELLIDO, SALARIO FROM PLANTILLA;
-- UNION ALL MOSTRARÁ LOS DUPLICADOS
SELECT APELLIDO, SALARIO FROM EMP
UNION ALL
SELECT APELLIDO, SALARIO FROM PLANTILLA;











