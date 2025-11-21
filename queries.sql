/* -- 1. Total de vendas por cliente */


SELECT
    c.customer_id,
    c.full_name,
    SUM(oi.line_total) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_spent DESC;

/* -- 2. Produtos mais vendidos (por quantidade) */

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC;

/* -- 3. Faturamento por produto */

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.line_total) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;

/* -- 4. Ticket médio por cliente */

SELECT
    c.customer_id,
    c.full_name,
    AVG(o.total_amount) AS avg_ticket
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY avg_ticket DESC;

/* -- 5. Vendas por mês */

SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(o.total_amount) AS total_revenue
FROM orders o
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY month;

/* -- 6. Quantidade de clientes por cidade */

SELECT 
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

/* --7. Produtos com maior preço médio de venda */

SELECT
    p.product_id,
    p.product_name,
    AVG(oi.line_total / oi.quantity) AS avg_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY avg_price DESC;

/* -- 8. Ranking de clientes pelo total gasto */

SELECT
    ROW_NUMBER() OVER (ORDER BY SUM(oi.line_total) DESC) AS rank,
    c.full_name,
    SUM(oi.line_total) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.full_name;

/* -- 9. Vendas totais por produto (quantidade + receita) */

SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.line_total) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

/* -- 10. Perfil dos clientes (idade + total gasto) */

SELECT
    c.full_name,
    c.city,
    c.state,
    c.registration_date,
    (SELECT SUM(oi.line_total)
     FROM orders o
     JOIN order_items oi ON o.order_id = oi.order_id
     WHERE o.customer_id = c.customer_id) AS total_spent
FROM customers c
ORDER BY total_spent DESC;


