DROP VIEW IF EXISTS dm_v21_sellers_regions;
CREATE VIEW dm_v21_sellers_regions AS
SELECT ci.seller_id,
       ci.seller_state,
       ci.seller_region,
       ds.state_name,                                 -- для подсказок на карте
       ds.state_lat,
       ds.state_lng,
       MIN(ci.purchase_month)            AS first_month,
       COUNT(DISTINCT ci.purchase_month) AS active_months,
       COUNT(*)                          AS items,
       ROUND(SUM(ci.price), 2)           AS revenue,
       ROUND(AVG(ci.review_score), 2)    AS avg_review
FROM core_item ci
LEFT JOIN dim_state ds ON ds.state = ci.seller_state
WHERE ci.order_status = 'delivered'
GROUP BY ci.seller_id, ci.seller_state, ci.seller_region,
         ds.state_name, ds.state_lat, ds.state_lng;
