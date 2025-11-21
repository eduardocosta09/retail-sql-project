-- Criar tabela de clientes
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(50),
    registration_date DATE
);

-- Criar tabela de produtos
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price NUMERIC(10,2)
);

-- Criar tabela de pedidos
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(10,2)
);

-- Criar tabela de itens do pedido
CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    line_total NUMERIC(10,2)
);

INSERT INTO customers (full_name, email, city, state, registration_date) VALUES
('Ana Souza', 'ana.souza@email.com', 'São Paulo', 'SP', '2023-01-10'),
('Carlos Lima', 'carlos.lima@email.com', 'Rio de Janeiro', 'RJ', '2023-02-15'),
('Beatriz Sales', 'bia.sales@email.com', 'Belo Horizonte', 'MG', '2023-03-18'),
('Marcos Dias', 'marcos.dias@email.com', 'Curitiba', 'PR', '2023-05-22');

INSERT INTO products (product_name, category, price) VALUES
('Notebook Dell Inspiron', 'Eletrônicos', 3500.00),
('Smartphone Samsung S22', 'Eletrônicos', 4200.00),
('Fone Bluetooth JBL', 'Acessórios', 350.00),
('Teclado Mecânico Redragon', 'Acessórios', 250.00);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-01-10', 3850.00),
(2, '2024-02-18', 4200.00),
(3, '2024-02-20', 600.00),
(4, '2024-03-05', 250.00);

INSERT INTO order_items (order_id, product_id, quantity, line_total) VALUES
(1, 1, 1, 3500.00),
(1, 3, 1, 350.00),
(2, 2, 1, 4200.00),
(3, 3, 2, 700.00),
(4, 4, 1, 250.00);

