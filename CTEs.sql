-- Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
-- Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers.

WITH info_compañias AS (SELECT customer_id, company_name
							FROM customers)
SELECT *
FROM info_compañias;

/* Selecciona solo los de que vengan de "Germany":
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, 
pero solo queremos los que pertezcan a "Germany". */

WITH info_compañias AS (SELECT customer_id, company_name, country
							FROM customers
                            WHERE country = 'Germany')
SELECT *
FROM info_compañias;

/* 3. Extraed el id de las facturas y su fecha de cada cliente.

En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia a la que pertenece. */

WITH facturas AS (SELECT c.customer_id, company_name, o.order_id, o.order_date
							FROM customers as c
                            INNER JOIN orders as o
                            ON c.customer_id = o.customer_id
						)
SELECT *
FROM facturas;

/* 4. Contad el número de facturas por cliente

Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente. */

WITH facturas AS (SELECT c.customer_id, company_name, COUNT(o.order_id) as num_facturas
							FROM customers as c
                            INNER JOIN orders as o
                            ON c.customer_id = o.customer_id
                            GROUP BY customer_id
						)
SELECT *
FROM facturas;

/* 5. Cuál la cantidad media pedida de todos los productos ProductID.

Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media. */

WITH suma AS (SELECT SUM(quantity) as cantidad_total, product_id
					FROM order_details
                    GROUP BY product_id)
SELECT AVG(cantidad_total), s.product_id, product_name
FROM suma as s
INNER JOIN products as p
ON s.product_id = p.product_id
GROUP BY product_id;

/* BONUSSS 
6. Usando una CTE, extraer el nombre de las diferentes categorías de productos, con su precio medio, máximo y mínimo. */

WITH info_cat AS (SELECT category_name, AVG(unit_price) as p_medio, MAX(unit_price) as p_max, MIN(unit_price) as p_min
					FROM categories as c
                    INNER JOIN products as p
                    USING (category_id)
                    GROUP BY category_name
                    )
SELECT *
FROM info_cat;

/* 7. La empresa nos ha pedido que busquemos el nombre de cliente, su teléfono y el número de pedidos que ha hecho cada uno de ellos. */

WITH info_cust AS (SELECT c.contact_name, c.phone, COUNT(o.order_id) as num_pedidos
						FROM customers as c
                        INNER JOIN orders as o
                        USING (customer_id)
                        GROUP BY c.contact_name, c.phone
                        )
SELECT *
FROM info_cust;

/* Modifica la cte del ejercicio anterior, úsala en una subconsulta para saber el nombre del cliente y su teléfono, para aquellos 
clientes que hayan hecho más de 6 pedidos en el año 1998. */
/* ESTE DA FALLO
WITH info_cust AS (SELECT c.contact_name as nombre, c.phone as tlf, COUNT(o.order_id) as num_pedidos
						FROM customers as c
                        INNER JOIN orders as o
                        USING (customer_id)
                        GROUP BY c.contact_name, c.phone
                        )
SELECT o.order_date, nombre, tlf, num_pedidos
FROM orders as o
INNER JOIN info_cust
USING (customer_id)
WHERE num_pedidos > 6 AND order_date LIKE '1998%'; */

-- Creo que hay que hacer una CTE con los pedidos realizados en el año 1998, y luego usar esa CTE con un JOIN para filtrar por num_pedidos > 6

WITH clientes AS (SELECT COUNT(order_date) as num_pedidos, customer_id
					FROM orders
                    WHERE order_date LIKE '1998%'
                    GROUP BY customer_id
                    
                    )

SELECT c.contact_name as nombre, c.phone as tlf, customer_id, num_pedidos
FROM customers as c
INNER JOIN clientes
USING (customer_id)
WHERE num_pedidos > 6;