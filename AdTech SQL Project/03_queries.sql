-- Easy (Focus: Basic SELECT, Filtering, Simple Aggregations)

-- Identify all the SSPs with a premium marketplace segment located in the US
SELECT ssp_id, ssp_name
FROM ssp_details
WHERE marketplace_segment = 'premium' AND region = 'US';

-- Retrieve all retail vertical campaigns that started in November 2024
SELECT campaign_id, start_date
FROM campaigns
WHERE vertical = 'retail' AND EXTRACT(MONTH FROM start_date) = 11 AND EXTRACT(YEAR FROM start_date) = 2024;

-- For 2024-11-01, sum up total impressions per SSP across all campaigns
SELECT ssp_id, SUM(impressions) AS total_impressions
FROM campaign_performance
WHERE perf_date = DATE '2024-11-01'
GROUP BY ssp_id;

-- Intermediate (Focus: JOINs, Aggregations, GROUP BY/HAVING)

-- For 2024-11-03, show total spend per campaign alongside its daily budget, and list campaigns where spend exceeded 80% of the daily budget
SELECT c.campaign_id, daily_budget, SUM(cp.spend)
FROM campaigns c
LEFT JOIN campaign_performance cp
ON c.campaign_id = cp.campaign_id
WHERE perf_date = DATE '2024-11-03' 
GROUP BY c.campaign_id, c.daily_budget
HAVING SUM(cp.spend) > 0.8 * c.daily_budget;

-- Calculate the conversion rate (conversions/clicks) for each SSP across all dates. Return the top 3 SSPs by conversion rate, excluding SSPs with fewer than 5,000 impressions total.
SELECT s.ssp_id, ROUND((SUM(cp.conversions)/SUM(cp.clicks)),2) AS conversion_rate
FROM ssp_details s 
LEFT JOIN campaign_performance cp
ON s.ssp_id = cp.ssp_id
GROUP BY s.ssp_id
HAVING SUM(cp.impressions) > 5000
ORDER BY conversion_rate DESC
FETCH FIRST 3 ROWS ONLY;

-- Aggregate total conversions and total spend per vertical, and only show verticals with more than 10 total conversions
SELECT c.vertical, SUM(cp.conversions) AS total_conversions, SUM(cp.spend) AS total_spend
FROM campaigns c
LEFT JOIN campaign_performance cp
ON c.campaign_id = cp.campaign_id
GROUP BY c.vertical
HAVING SUM(cp.conversions) > 10;

-- to be continued...