USE northwind; 

-- Crear una columna temporal:

SELECT  'Hola!'  AS tipo_nombre
	FROM customers;
    
-- Ciudades que empiezan con "A" o "B":

SELECT city, company_name, contact_name
	FROM customers
    WHERE city LIKE 'A%' OR city LIKE 'B%';
    
-- Número de pedidos que han hecho en las ciudades que empiezan con L.

SELECT c.city, c.company_name,c.contact_name,COUNT(o.order_id) AS "Número total" -- Es una buena práctica añadir de qué tabla vienen las columnas. 
	FROM customers as c
	INNER JOIN orders as o
    ON c.customer_id = o.customer_id
    WHERE city LIKE 'L%'
    GROUP BY c.city, c.company_name, c.contact_name
	; 
    
-- Todos los clientes cuyo "country" no incluya "USA".

SELECT contact_name, country,company_name
	FROM customers 
    WHERE country NOT IN ("USA"); 
    
-- Todos los clientes que no tengan una "A" en segunda posición en su nombre.

SELECT contact_name
	FROM customers
    WHERE contact_name NOT LIKE ("_A%");


    
