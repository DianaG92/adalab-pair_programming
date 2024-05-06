-- Pair Programming lección 09 Union Tablas (Joins)

/* 1. Pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK. 
Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos. */
SELECT customers.CustomerID, customers.CompanyName, COUNT(OrderID) AS NumeroPedidos
FROM customers
INNER JOIN orders
ON customers.CustomerID = orders.CustomerID
WHERE customers.country = "UK"
GROUP BY customers.CustomerID, customers.CompanyName;

/* 2. Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido pedirnos una serie de consultas adicionales. 
La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año. 
Nos piden concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. 
Para ello hará falta hacer 2 joins. */
SELECT customers.CompanyName, YEAR(orders.OrderDate) AS "Año", SUM(orderdetails.Quantity) AS NumObjetos
FROM customers
CROSS JOIN orders
ON customers.CustomerID = orders.CustomerID
CROSS JOIN orderdetails
ON orders.OrderID = orderdetails.OrderID
WHERE customers.country = "UK"
GROUP BY customers.CompanyName, YEAR(orders.OrderDate); 

/* 3. Mejorad la query anterior:
Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de dinero que han pedido por esa cantidad de objetos, teniendo en cuenta los descuentos, etc. 
Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 15% nos sale como 0.15. */
SELECT customers.CompanyName, YEAR(orders.OrderDate) AS "Año", SUM(orderdetails.Quantity) AS NumObjetos, SUM((orderdetails.UnitPrice * orderdetails.Quantity) * (1 - orderdetails.Discount)) AS DineroTotal
FROM customers
CROSS JOIN orders
ON customers.CustomerID = orders.CustomerID
CROSS JOIN orderdetails
ON orders.OrderID = orderdetails.OrderID
WHERE customers.country = "UK"
GROUP BY customers.CompanyName, YEAR(orders.OrderDate); 

/* 4. BONUS: Pedidos que han realizado cada compañía y su fecha:
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, desde la central nos han pedido una consulta que indique el nombre de cada compañia cliente junto con cada pedido que han realizado y su fecha. */
SELECT orders.OrderID, customers.CompanyName, orders.OrderDate
FROM orders
NATURAL JOIN customers;

/* 5. BONUS: Tipos de producto vendidos:
Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la categoría y el nombre del producto, y el total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos).
Pista Necesitaréis usar 3 joins. */
SELECT categories.CategoryID, categories.CategoryName, products.ProductName, SUM((orderdetails.UnitPrice * orderdetails.Quantity) * (1 - orderdetails.Discount)) AS ProductSales
FROM categories
NATURAL JOIN products
NATURAL JOIN orderdetails
GROUP BY categories.CategoryID, categories.CategoryName, products.ProductName;

-- SIN TERMINAR --

/* 6. Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las empresas cliente, los ID de sus pedidos y las fechas. */
SELECT orders.OrderID, customers.CompanyName, 


/* 7. Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que ha realizado cada cliente del propio Reino Unido de cara a conocerlos mejor y poder adaptarse al mercado actual. 
Especificamente nos piden el nombre de cada compañía cliente junto con el número de pedidos. */

/* 8. Empresas de UK y sus pedidos:
También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido (tengan pedidos o no) junto con los ID de todos los pedidos que han realizado y la fecha del pedido. */

/* 9. Empleadas que sean de la misma ciudad:
Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla los datos de todas las empleadas y sus supervisoras. 
Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de las jefas. 
Investiga el resultado, ¿sabes decir quién es el director? */

-- ESTE EJERCICIO NO SE EVALUARÁ SI NO ES ENTREGADO
/* 10. BONUS: FULL OUTER JOIN
Pedidos y empresas con pedidos asociados o no:
Selecciona todos los pedidos, tengan empresa asociada o no, y todas las empresas tengan pedidos asociados o no. 
Muestra el ID del pedido, el nombre de la empresa y la fecha del pedido (si existe). */