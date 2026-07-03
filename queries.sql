-- ============================================
-- Velora Sales Analytics — SQL Queries
-- ============================================

-- Query 1: Which nameplate generates the most revenue and volume?
SELECT n.nameplate_name, 
       COUNT(*) AS total_sales,
       SUM(s.sale_price) AS total_revenue
FROM sales AS s
INNER JOIN nameplates AS n
ON n.nameplate_id = s.nameplate_id
GROUP BY n.nameplate_name;


-- Query 2: Which markets perform best?
-- Note: requires chaining two joins since sales doesn't connect directly to markets
-- (sales -> dealers -> markets)
SELECT m.market_name, 
       COUNT(*) AS total_car_sell,
       SUM(s.sale_price) AS total_revenue
FROM dealers AS d
INNER JOIN sales AS s
ON d.dealer_id = s.dealer_id
INNER JOIN markets AS m
ON d.market_id = m.market_id
GROUP BY market_name;


-- Query 3: Do customers prefer premium or budget configurations?
SELECT configuration_type, 
       COUNT(*) AS total_sell, 
       AVG(sale_price) AS avg_selling_price
FROM sales
GROUP BY configuration_type;
