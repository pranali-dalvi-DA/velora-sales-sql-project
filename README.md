# Velora Sales Analysis — SQL Project

This is a practice project where I explored business-related questions using SQL on a fictional automotive dataset. The database stores market-wise, dealer-wise, nameplate-wise, and sales-wise data, all connected through common IDs across tables.

Through this project, I learned how to fetch data from a database and connect multiple tables using JOINs. I also learned the difference between `COUNT(*)` and `COUNT(column)`, and how revenue and quantity sold can tell different stories about the same data — a nameplate can generate high revenue with fewer units sold, or high volume with lower revenue, depending on pricing.

The biggest takeaway was realizing that raw data only becomes useful when viewed from a business perspective. Without any charts or visualizations, just by querying the data, I was able to identify which markets performed best and which configuration types customers preferred most.

## About the Data

The database (`velora_sales.db`) contains the following:

**Tables:**
- `nameplates` — vehicle models
- `markets` — countries/regions where sales happen
- `dealers` — dealer locations, linked to markets
- `sales` — individual sale transactions

**Records:**
- 300 sales
- 4 nameplates (Velora Grand, Sport, Trailhawk, Coupe)
- 6 markets (India, UK, USA, Germany, UAE, China)
- 10 dealers

**Key columns used in analysis:**
- `sale_price` (from `sales`)
- `market_name` (from `markets`)
- `nameplate_name` (from `nameplates`)
- `configuration_type` (from `sales`)

## Business Questions Explored

### 1. Which nameplate generates the most revenue and volume?
```sql
SELECT n.nameplate_name, 
       COUNT(*) AS total_sales,
       SUM(s.sale_price) AS total_revenue
FROM sales AS s
INNER JOIN nameplates AS n
ON n.nameplate_id = s.nameplate_id
GROUP BY n.nameplate_name
```
**Finding:** Velora Trailhawk sold the highest number of units, while Velora Grand generated the highest total revenue despite selling fewer units — because it's priced higher. This showed me that revenue and volume tell two different stories, and which nameplate counts as the "best performer" depends on whether the business is optimizing for market share (volume) or profit (revenue).

### 2. Which markets perform best?
```sql
SELECT m.market_name, 
       COUNT(*) AS total_car_sell,
       SUM(s.sale_price) AS total_revenue
FROM dealers AS d
INNER JOIN sales AS s
ON d.dealer_id = s.dealer_id
INNER JOIN markets AS m
ON d.market_id = m.market_id
GROUP BY market_name
```
**Approach note:** This required chaining two JOINs, since `sales` doesn't connect directly to `markets` — `dealers` acts as the bridge table (sales → dealers → markets). This showed me how real-world schemas often require multiple joins to connect data that isn't directly linked.

### 3. Do customers prefer premium or budget configurations?
```sql
SELECT configuration_type, 
       COUNT(*) AS total_sell, 
       AVG(sale_price) AS avg_selling_price
FROM sales
GROUP BY configuration_type
```
**Finding:** Autobiography, the premium trim, had the highest unit volume — not just the highest average price. This suggested customers in this dataset leaned toward premium configurations rather than budget ones, which is the kind of signal a pricing or product team would want to investigate further.

## Tools Used
- SQLite (database)
- DB Browser for SQLite (query execution)

## What I'd Explore Next
Next, I would explore dealer-wise sales to identify which dealers are performing well and where more focus is needed.

## Notes
This is a personal practice project built using self-generated data, not real company data. It reflects my current SQL learning stage — I'm actively building toward more advanced topics like subqueries and window functions.
