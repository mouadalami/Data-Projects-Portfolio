-- Easy (Focus: Basic SELECT, Filtering, Simple Aggregations)

-- Which SSPs operate in a premium marketplace segment and are located in the US?
SELECT ssp_id, ssp_name
FROM ssp_details
WHERE marketplace_segment = 'premium' AND region = 'US';

-- Which retail vertical campaigns started during November 2024?
SELECT campaign_id, start_date
FROM campaigns
WHERE vertical = 'retail' AND EXTRACT(MONTH FROM start_date) = 11 AND EXTRACT(YEAR FROM start_date) = 2024;

-- On 2024-11-01, what is the sum of all impressions delivered by each SSP across all campaigns?
SELECT ssp_id, SUM(impressions) AS total_impressions
FROM campaign_performance
WHERE perf_date = DATE '2024-11-01'
GROUP BY ssp_id;

-- Intermediate (Focus: JOINs, Aggregations, GROUP BY/HAVING)

-- On 2024-11-03, for each campaign, what is the total spend compared to its daily budget, and which campaigns exceeded 80% of their daily budget?
SELECT c.campaign_id, daily_budget, SUM(cp.spend)
FROM campaigns c
LEFT JOIN campaign_performance cp
ON c.campaign_id = cp.campaign_id
WHERE perf_date = DATE '2024-11-03' 
GROUP BY c.campaign_id, c.daily_budget
HAVING SUM(cp.spend) > 0.8 * c.daily_budget;

-- Across all dates, which are the top 3 SSPs by conversion rate (conversions/clicks), excluding those with fewer than 5,000 total impressions?
SELECT s.ssp_id, ROUND((SUM(cp.conversions)/SUM(cp.clicks)),2) AS conversion_rate
FROM ssp_details s 
LEFT JOIN campaign_performance cp
ON s.ssp_id = cp.ssp_id
GROUP BY s.ssp_id
HAVING SUM(cp.impressions) > 5000
ORDER BY conversion_rate DESC
FETCH FIRST 3 ROWS ONLY;

-- How can we aggregate total conversions and total spend per vertical, and which verticals have more than 10 total conversions?
SELECT c.vertical, SUM(cp.conversions) AS total_conversions, SUM(cp.spend) AS total_spend
FROM campaigns c
LEFT JOIN campaign_performance cp
ON c.campaign_id = cp.campaign_id
GROUP BY c.vertical
HAVING SUM(cp.conversions) > 10;

-- Advanced (Focus: Subqueries, Window Functions, CTEs)

-- Using a CTE, how do we calculate each SSP's overall average CTR (clicks/impressions) and compare it to the global average CTR, returning only SSPs whose CTR is above the global average?
WITH avg_CTR AS(
    SELECT ssp_id, ROUND((SUM(clicks)/SUM(impressions))*100,2) AS avg_CTR
    FROM campaign_performance
    GROUP BY ssp_id
),
global_avg_CTR AS(
    SELECT ROUND(SUM(clicks)/SUM(impressions)*100,2) AS global_avg_CTR
    FROM campaign_performance
)
SELECT ac.ssp_id, ac.avg_CTR, gac.global_avg_CTR
FROM avg_CTR ac
CROSS JOIN global_avg_CTR gac
WHERE ac.avg_CTR > gac.global_avg_CTR;

-- For each campaign, compute its average daily conversion rate (conversion/impressions) and then use a window function to rank campaigns by this metric, returning only the top
WITH CR AS(
    SELECT campaign_id, ROUND(SUM(conversions)/SUM(impressions)*100,2) AS CR
	FROM campaign_performance
    GROUP BY campaign_id
)
SELECT campaign_id, CR AS conversion_rate, ROW_NUMBER() OVER(ORDER BY CR DESC) AS rank
FROM CR
ORDER BY rank ASC;

-- For each SSP, show daily conversions and the day-to-day change in conversions using a window function (LAG)
WITH daily_conversions AS (
    SELECT ssp_id,
           perf_date,
           SUM(conversions) AS daily_conversions
    FROM campaign_performance
    GROUP BY ssp_id, perf_date
)
SELECT ssp_id,
       perf_date,
       daily_conversions,
       daily_conversions 
         - LAG(daily_conversions, 1, 0) OVER (PARTITION BY ssp_id ORDER BY perf_date) AS day_to_day_change
FROM daily_conversions
ORDER BY ssp_id, perf_date;

-- Expert (Focus: Complex Joins, Data Cleansing, Multiple CTEs)

-- Which campaign_id meets a CTR > 1% & CPA < 50, and what are their CTR, CPA, and associated SSPs ?
WITH dated_CTE AS(
    SELECT cp.perf_date, cp.campaign_id, cp.ssp_id, cp.impressions, cp.clicks, cp.spend, cp.conversions
    FROM campaign_performance cp
    JOIN campaigns c
    ON cp.campaign_id = c.campaign_id
    AND c.end_date >= DATE '2024-11-05'
), 
metrics_CTE AS(
    SELECT d.campaign_id, d.ssp_id, ROUND(SUM(d.clicks)/SUM(d.impressions)*100,2) AS CTR, ROUND(SUM(d.spend)/SUM(d.conversions)*100,2) AS CPA
    FROM dated_CTE d
    GROUP BY campaign_id, ssp_id
)
SELECT campaign_id, ssp_id, CTR, CPA
FROM metrics_CTE 
WHERE CTR > 1 AND CPA < 50;

-- Which ssp_id achieves the highest total conversions after removing noisy days?
WITH noisy_days AS(
	SELECT campaign_id, impressions
	FROM campaign_performance
	WHERE impressions <= 100
), 
clean_data AS(
	SELECT ssp_id, SUM(conversions) AS total_conversions
	FROM campaign_performance cp
	WHERE (cp.campaign_id, cp.perf_date) NOT IN (
			SELECT campaign_id, perf_date FROM noisy_days
    )
	GROUP BY ssp_id
)
SELECT ssp_id, total_conversions, RANK() OVER(ORDER BY total_conversions DESC) AS rank
FROM clean_data
ORDER BY rank ASC;

-- Which campaigns have the best funnel performance and lowest cost, and in what order do they appear?
WITH agg AS (
    SELECT cp.campaign_id,
           SUM(cp.clicks) AS total_clicks,
           SUM(cp.conversions) AS total_conversions,
           SUM(cp.spend) AS total_spend
    FROM campaign_performance cp
    GROUP BY cp.campaign_id
),
funnel AS (
    SELECT a.campaign_id,
           CASE WHEN a.total_clicks = 0 THEN 0 
                ELSE a.total_conversions*1.0 / a.total_clicks 
           END AS conversions_per_click,
           a.total_spend
    FROM agg a
),
joined AS (
    SELECT f.campaign_id,
           f.conversions_per_click,
           f.total_spend,
           c.daily_budget
    FROM funnel f
    JOIN campaigns c ON f.campaign_id = c.campaign_id
)
SELECT campaign_id,
       ROUND(conversions_per_click,4) AS conversions_per_click,
       total_spend,
       daily_budget,
       ROW_NUMBER() OVER(ORDER BY conversions_per_click DESC, total_spend ASC) AS rank
FROM joined
ORDER BY rank;
