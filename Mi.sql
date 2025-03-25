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



-- CAMPOS CALCULADOS (es una herramienta en una consulta para crear campos en una tabla para obtener resultados tras algún calculo. Se usan en SELECT)
SELECT apellido, salario, comision, (salario +  comision) AS total
FROM emp
 ORDER BY total;



SELECT DISTINCT oficio -- valores únicos (borra duplicados)
FROM emp;



