CREATE TABLE products (
product_id NUMBER PRIMARY KEY,
product_name VARCHAR2(200) NOT NULL,
category VARCHAR2(100) NOT NULL,
unit_price NUMBER(10,2) NOT NULL CHECK (unit_price > 0),
stock NUMBER DEFAULT 0 CHECK (stock >= 0)
);

CREATE TABLE customers (
customer_id NUMBER PRIMARY KEY,
first_name VARCHAR2(100) NOT NULL,
last_name VARCHAR2(100) NOT NULL,
email VARCHAR2(320) NOT NULL UNIQUE,
phone VARCHAR2(30)
);


CREATE TABLE orders (
order_id NUMBER PRIMARY KEY,
customer_id NUMBER NOT NULL,
order_date DATE DEFAULT SYSDATE,
total_order_amount NUMBER CHECK (total_order_amount >=1),
CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
);

CREATE TABLE order_details(
order_detail_record NUMBER PRIMARY KEY,
order_id NUMBER NOT NULL,
product_id NUMBER NOT NULL,
quantity NUMBER CHECK (quantity >= 1),
CONSTRAINT fk_od_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
CONSTRAINT fk_od_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);





PRODUCTS
INSERT INTO products VALUES (1, 'Laptop', 'Electronics', 60000, 25);
INSERT INTO products VALUES (2, 'Headphones', 'Electronics', 2000, 15);

CUSTOMERS
INSERT INTO customers VALUES(1, 'Meera', 'Patel', 'meerapatel@mail.com', '8395662909');
INSERT INTO customers VALUES(2, 'Aarav', 'Sharma', 'aaravsharma@mail.com', '9878986248');

ORDERS
INSERT INTO orders VALUES(101, 1, SYSDATE, 62000);
INSERT INTO orders VALUES(102, 2, SYSDATE, 4000);

ORDER DETAILS
INSERT INTO order_details VALUES(1001, 101, 1, 1);
INSERT INTO order_details VALUES(1002, 101, 2, 1);
INSERT INTO order_details VALUES(1003, 102, 2, 2);

RETRIVE PRODUCTS WITH LESS STOCK
SELECT product_id, product_name, stock
From products
WHERE stock<20;

CALCULATE TOTAL AMOUNT SPENT BY EACH CUSTOMER
SELECT c.customer_id, c.first_name || ''|| c.last_name AS customer_name, 
SUM(o.total_order_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

UPDATE STOCK AFTER ORDERS ARE PLACED
UPDATE products p
SET stock = stock - (
SELECT SUM(od.quantity)
FROM order_details od
WHERE od.product_id = p.product_id
)
WHERE p.product_id IN (
SELECT product_id FROM order_details
);















