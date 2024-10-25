USE northwind; 
-- Extraed el precio unitario máximo (unit_price)de cada producto vendido.
-- Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. 
-- De nuevo lo tendréis que hacer con queries correlacionadas.

SELECT product_id, MAX(unit_price) AS "Producto más vendidos"
	FROM order_details
    GROUP BY product_id; 
    
SELECT MAX(unit_price)
	FROM order_details
    WHERE product_id = 1;
    
SELECT product_id, unit_price AS "Producto más vendidos"
	 FROM order_details as o1
     WHERE (SELECT MAX(unit_price) AS "Producto más vendidos"
	 FROM order_details as o2
     WHERE o1.product_id = o2.product_id); 

SELECT *
	FROM order_details as o1
    INNER JOIN
(SELECT product_id, MAX(unit_price) AS "Producto más vendido"
	FROM order_details as o2
    GROUP BY product_id) as t
    ON o1.product_id = t.product_id; 
    
    
    