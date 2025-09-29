-- Customer spending quartiles
WITH customer_spending AS (
    SELECT c.customer_unique_id,
        c.customer_state,
        SUM(oi.price) as total_spent
    FROM olist_order_items oi
        JOIN olist_orders o ON oi.order_id = o.order_id
        JOIN olist_customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id,
        c.customer_state
)
SELECT customer_unique_id,
    customer_state,
    total_spent,
    NTILE(4) OVER (
        ORDER BY total_spent
    ) as spending_quartile
FROM customer_spending