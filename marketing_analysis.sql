/* =====================================================================
   Marketing Campaign & Customer Analytics — SQL Analysis
   Dataset: Customer Personality Analysis (2,212 customers after cleaning)
   Schema assumes a table `customers` loaded from marketing_campaign_cleaned.csv
   ===================================================================== */

-- 1. Overall campaign performance snapshot
SELECT
    COUNT(*)                                            AS total_customers,
    ROUND(AVG(Response) * 100, 1)                        AS last_campaign_response_pct,
    ROUND(AVG(Total_Spend), 2)                           AS avg_customer_spend,
    ROUND(AVG(Income), 0)                                AS avg_income
FROM customers;

-- 2. Response rate by income segment
SELECT
    Income_Segment,
    COUNT(*)                       AS customers,
    ROUND(AVG(Response) * 100, 1)  AS response_rate_pct,
    ROUND(AVG(Total_Spend), 2)     AS avg_spend
FROM customers
GROUP BY Income_Segment
ORDER BY response_rate_pct DESC;

-- 3. Response rate by household composition (children)
SELECT
    Total_Children,
    COUNT(*)                       AS customers,
    ROUND(AVG(Response) * 100, 1)  AS response_rate_pct
FROM customers
GROUP BY Total_Children
ORDER BY Total_Children;

-- 4. Acceptance rate across all 6 campaigns (unpivoted)
SELECT 'Campaign 1' AS campaign, ROUND(AVG(AcceptedCmp1)*100,1) AS acceptance_pct FROM customers
UNION ALL
SELECT 'Campaign 2', ROUND(AVG(AcceptedCmp2)*100,1) FROM customers
UNION ALL
SELECT 'Campaign 3', ROUND(AVG(AcceptedCmp3)*100,1) FROM customers
UNION ALL
SELECT 'Campaign 4', ROUND(AVG(AcceptedCmp4)*100,1) FROM customers
UNION ALL
SELECT 'Campaign 5', ROUND(AVG(AcceptedCmp5)*100,1) FROM customers
UNION ALL
SELECT 'Last Campaign', ROUND(AVG(Response)*100,1) FROM customers;

-- 5. Top spending product categories (average per customer)
SELECT 'Wines' AS category, ROUND(AVG(MntWines),2) AS avg_spend FROM customers
UNION ALL SELECT 'Meat', ROUND(AVG(MntMeatProducts),2) FROM customers
UNION ALL SELECT 'Gold Products', ROUND(AVG(MntGoldProds),2) FROM customers
UNION ALL SELECT 'Fish', ROUND(AVG(MntFishProducts),2) FROM customers
UNION ALL SELECT 'Sweets', ROUND(AVG(MntSweetProducts),2) FROM customers
UNION ALL SELECT 'Fruits', ROUND(AVG(MntFruits),2) FROM customers
ORDER BY avg_spend DESC;

-- 6. Channel preference: web vs catalog vs store
SELECT
    ROUND(AVG(NumWebPurchases), 2)      AS avg_web_purchases,
    ROUND(AVG(NumCatalogPurchases), 2)  AS avg_catalog_purchases,
    ROUND(AVG(NumStorePurchases), 2)    AS avg_store_purchases,
    ROUND(AVG(NumDealsPurchases), 2)    AS avg_deal_purchases
FROM customers;

-- 7. Customers who never responded to any of the 6 campaigns (re-engagement target list)
SELECT COUNT(*) AS never_responded_customers
FROM customers
WHERE Total_Campaigns_Accepted = 0;

-- 8. RFM segment profile (requires Segment column from Python RFM step)
SELECT
    Segment,
    COUNT(*)                        AS customers,
    ROUND(AVG(Income), 0)           AS avg_income,
    ROUND(AVG(Total_Spend), 2)      AS avg_spend,
    ROUND(AVG(Recency), 1)          AS avg_recency_days,
    ROUND(AVG(Response) * 100, 1)   AS response_rate_pct
FROM customers
GROUP BY Segment
ORDER BY avg_spend DESC;

-- 9. Recency buckets vs response rate (freshness of engagement matters?)
SELECT
    CASE
        WHEN Recency <= 25 THEN '0-25 days'
        WHEN Recency <= 50 THEN '26-50 days'
        WHEN Recency <= 75 THEN '51-75 days'
        ELSE '76-99 days'
    END AS recency_bucket,
    COUNT(*)                       AS customers,
    ROUND(AVG(Response) * 100, 1)  AS response_rate_pct
FROM customers
GROUP BY recency_bucket
ORDER BY recency_bucket;

-- 10. High-value customers with low campaign engagement (upsell/retention target list)
SELECT Segment, Income, Total_Spend, Total_Campaigns_Accepted, Recency
FROM customers
WHERE Total_Spend > 800 AND Total_Campaigns_Accepted = 0
ORDER BY Total_Spend DESC
LIMIT 50;
