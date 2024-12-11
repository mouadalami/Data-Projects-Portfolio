-- Table 1: ssp_details
CREATE TABLE ssp_details (
    ssp_id INT PRIMARY KEY,
    ssp_name VARCHAR(100),
    marketplace_segment VARCHAR(50),
    region VARCHAR(50)
);

-- Table 2: campaigns
CREATE TABLE campaigns (
    campaign_id INT PRIMARY KEY,
    advertiser_id INT,
    vertical VARCHAR(50),
    daily_budget DECIMAL(10,2),
    start_date DATE,
    end_date DATE
);

-- Table 3: campaign_performance
CREATE TABLE campaign_performance (
    perf_date DATE,
    campaign_id INT,
    ssp_id INT,
    impressions INT,
    clicks INT,
    spend DECIMAL(10,2),
    conversions INT,
    PRIMARY KEY (perf_date, campaign_id, ssp_id),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id),
    FOREIGN KEY (ssp_id) REFERENCES ssp_details(ssp_id)
);







