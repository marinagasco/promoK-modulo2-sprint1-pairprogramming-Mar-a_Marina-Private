CREATE SCHEMA tienda; 
USE tienda;

-- Productos más baratos y caros de nuestra BBDD:

-- Desde la división de productos nos piden conocer el precio de los productos que tienen el precio más alto y más bajo. 
-- Dales el alias lowestPrice y highestPrice.

SELECT MIN(buy_price) AS lowestPrice, MAX(buy_price) AS highestPrice
	FROM products; 
    
-- Conociendo el número de productos y su precio medio:
-- Adicionalmente nos piden que diseñemos otra consulta para conocer el número de productos y el precio medio de todos ellos (en general, no por cada producto).

SELECT AVG (buy_price) AS media_total, COUNT(product_line) AS producto_total -- Aquí vemos todas las filas (con las categorías repetidas). 
	FROM products;
    
SELECT COUNT(product_name)
	FROM products; 

SELECT COUNT(product_code)payments
	FROM products; 

SELECT AVG (buy_price) AS media_total, SUM(quantity_in_stock) AS producto_total -- Awuí vemos el total de las unidades de todas las categorías de producto. 
	FROM products;
    
    
USE Northwind; 

-- Sacad la máxima y mínima carga de los pedidos de UK:

SELECT MIN(freight), MAX(freight)
	FROM orders
    WHERE ship_country = "UK";
    
-- Qué productos se venden por encima del precio medio:

SELECT AVG(unit_price * quantity)
	FROM order_details
    WHERE unit_price > AVG;
    
SELECT product_name, unit_price
	 FROM products
     WHERE unit_price > (SELECT AVG(unit_price)FROM products) 
     ORDER BY unit_price DESC; 
     
SELECT AVG(unit_price)
	 FROM products;
     
SELECT product_name, unit_price
	 FROM products
     WHERE unit_price > 28.866363636363637
     ORDER BY unit_price DESC; 

-- Qué productos se han descontinuado:

SELECT discontinued
	FROM products
    WHERE discontinued = 1;

-- Detalles de los productos de la query anterior:

SELECT product_id, product_name
	FROM products
	WHERE discontinued = 0
    ORDER BY product_id DESC
    LIMIT 10; 

-- Relación entre número de pedidos y máxima carga:

SELECT employee_id, 
       COUNT(order_id) AS total_orders, 
       MAX(freight) AS max_freight
FROM orders
GROUP BY employee_id;






