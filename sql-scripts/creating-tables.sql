-- Core tables for window function analysis
CREATE TABLE olist_customers (
    customer_id VARCHAR2(50) PRIMARY KEY,
    customer_unique_id VARCHAR2(50),
    customer_zip_code_prefix VARCHAR2(10),
    customer_city VARCHAR2(50),
    customer_state VARCHAR2(2)
);
CREATE TABLE olist_products (
    product_id VARCHAR2(50) PRIMARY KEY,
    product_category_name VARCHAR2(100),
    product_name_lenght NUMBER,
    product_description_lenght NUMBER,
    product_photos_qty NUMBER,
    product_weight_g NUMBER,
    product_length_cm NUMBER,
    product_height_cm NUMBER,
    product_width_cm NUMBER
);
CREATE TABLE olist_orders (
    order_id VARCHAR2(50) PRIMARY KEY,
    customer_id VARCHAR2(50),
    order_status VARCHAR2(50),
    order_purchase_timestamp DATE,
    order_approved_at DATE,
    order_delivered_carrier_date DATE,
    order_delivered_customer_date DATE,
    order_estimated_delivery_date DATE
);
CREATE TABLE olist_order_items (
    order_id VARCHAR2(50),
    order_item_id NUMBER,
    product_id VARCHAR2(50),
    seller_id VARCHAR2(50),
    shipping_limit_date DATE,
    price NUMBER,
    freight_value NUMBER,
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES olist_orders(order_id),
    FOREIGN KEY (product_id) REFERENCES olist_products(product_id)
);
CREATE TABLE olist_order_payments (
    order_id VARCHAR2(50),
    payment_sequential NUMBER,
    payment_type VARCHAR2(50),
    payment_installments NUMBER,
    payment_value NUMBER,
    FOREIGN KEY (order_id) REFERENCES olist_orders(order_id)
);