-- Month-over-month revenue growth by state
WITH monthly_revenue AS (
    SELECT c.customer_state,
        TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') as month,
        SUM(oi.price) as monthly_revenue
    FROM olist_order_items oi
        JOIN olist_orders o ON oi.order_id = o.order_id
        JOIN olist_customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_state,
        TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM')
)
SELECT customer_state,
    month,
    monthly_revenue,
    LAG(monthly_revenue) OVER (
        PARTITION BY customer_state
        ORDER BY month
    ) as prev_month_revenue,
    ROUND(
        (
            (
                monthly_revenue - LAG(monthly_revenue) OVER (
                    PARTITION BY customer_state
                    ORDER BY month
                )
            ) / LAG(monthly_revenue) OVER (
                PARTITION BY customer_state
                ORDER BY month
            )
        ) * 100,
        2
    ) as growth_percent
FROM monthly_revenue;