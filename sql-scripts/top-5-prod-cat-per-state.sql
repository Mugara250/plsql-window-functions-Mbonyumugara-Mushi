-- Top 5 product categories per state
WITH ranked_categories AS (
    SELECT c.customer_state,
        COALESCE(
            t.product_category_name_english,
            p.product_category_name
        ) as category_name,
        SUM(oi.price) as total_revenue,
        RANK() OVER (
            PARTITION BY c.customer_state
            ORDER BY SUM(oi.price) DESC
        ) as state_rank
    FROM olist_order_items oi
        JOIN olist_orders o ON oi.order_id = o.order_id
        JOIN olist_customers c ON o.customer_id = c.customer_id
        JOIN olist_products p ON oi.product_id = p.product_id
        LEFT JOIN olist_product_category_name_translation t ON p.product_category_name = t.product_category_name
    GROUP BY c.customer_state,
        p.product_category_name,
        t.product_category_name_english
)
SELECT customer_state,
    category_name,
    total_revenue,
    state_rank
FROM ranked_categories
WHERE state_rank <= 5
ORDER BY customer_state,
    state_rank;