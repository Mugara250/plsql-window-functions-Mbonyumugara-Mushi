-- Running monthly revenue totals
SELECT TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') as month,
    SUM(SUM(oi.price)) OVER (
        ORDER BY TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM')
    ) as running_total
FROM olist_order_items oi
    JOIN olist_orders o ON oi.order_id = o.order_id
GROUP BY TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM');