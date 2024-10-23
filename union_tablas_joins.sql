USE northwind;
 -- Ejercicio 1:
 -- Cuántos pedidos ha realizado cada empresa cliente de UK. Nos piden el ID del cliente y el nombre de la empresa y el número de 
 -- pedidos.
 
 -- customers - > customer_id, company_name
 -- orders - > order_id, customer_id, ship_country = 'UK'
 -- order_details - > COUNT(order_id)
 
 SELECT c.customer_id, company_name, COUNT(order_id) AS pedidos
 FROM customers AS c
 INNER JOIN orders AS o
 ON c.customer_id = o.customer_id
 WHERE country = 'UK'
 GROUP BY company_name, customer_id;
 
 -- cuántos objetos ha pedido cada empresa cliente de UK durante cada año. Nombre de la empresa, el año, y la cantidad de objetos 
 -- que han pedido. Para ello hará falta hacer 2 joins.
 
 -- customers -> company_name, country = 'UK', customer_id
 -- orders -> order_date, order_id, customer_id
 -- order_details -> quantity, order_id
 
 SELECT c.company_name, YEAR(o.order_date) AS año, SUM(quantity) AS cantidad
 FROM customers AS c
 INNER JOIN orders AS o
 ON c.customer_id = o.customer_id
 INNER JOIN order_details AS od
 ON o.order_id = od.order_id
  WHERE country = 'UK'
  GROUP BY company_name, YEAR(o.order_date);
  
-- adición de la cantidad de dinero que han pedido por esa cantidad de objetos, teniendo en cuenta los descuentos, etc. 
-- Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 15% nos sale como 0.15

 SELECT c.company_name, YEAR(o.order_date) AS año, SUM(quantity) AS cantidad, ImporteTotal
 FROM customers AS c
 INNER JOIN orders AS o
 ON c.customer_id = o.customer_id
 INNER JOIN order_details AS od
 ON o.order_id = od.order_id
  WHERE country = 'UK'
  GROUP BY company_name, YEAR(o.order_date), ImporteTotal;