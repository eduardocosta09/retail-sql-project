-- 1. Total de vendas por cliente
SELECT 
    c.customer_id,
    c.full_name,
    SUM(s.quantity * s.unit_price) AS total_spent
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_spent DESC;

-- 2. Produtos mais vendidos (por quantidade)
SELECT 
    p.product_id,
    p.product_name,
    SUM(s.quantity) AS total_quantity
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC;

-- 3. Faturamento por produto
SELECT 
    p.product_id,
    p.product_name,
    SUM(s.quantity * s.unit_price) AS revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC;

-- 4. Ticket médio por cliente
SELECT 
    c.customer_id,
    c.full_name,
    AVG(s.quantity * s.unit_price) AS avg_ticket
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY avg_ticket DESC;

-- 5. Vendas por mês
SELECT 
    DATE_TRUNC('month', sale_date) AS month,
    SUM(quantity * unit_price) AS revenue
FROM sales
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY month;

-- 6. Quantidade de clientes por cidade
SELECT 
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

-- 7. Produtos com maior preço médio de venda
SELECT 
    p.product_id,
    p.product_name,
    AVG(s.unit_price) AS avg_price
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY avg_price DESC;

-- 8. Ranking completo de clientes
SELECT 
    ROW_NUMBER() OVER (ORDER BY SUM(s.quantity * s.unit_price) DESC) AS rank,
    c.full_name,
    SUM(s.quantity * s.unit_price) AS total_spent
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name;

-- 9. Vendas totais por produto (quantidade + receita)
SELECT 
    p.product_name,
    SUM(s.quantity) AS total_quantity,
    SUM(s.quantity * s.unit_price) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 10. Perfil dos clientes (idade + total gasto)
SELECT 
    full_name,
    gender,
    birth_date,
    EXTRACT(YEAR FROM AGE(birth_date)) AS age,
    (SELECT SUM(quantity * unit_price)
     FROM sales
     WHERE sales.customer_id = customers.customer_id) AS total_spent
FROM customers
ORDER BY total_spent DESC NULLS LAST;