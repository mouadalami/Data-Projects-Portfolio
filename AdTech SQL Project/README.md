# AdTech SQL Challenges

**Author:** Mouad A

**Assisted by:** [ChatGPT](https://openai.com/) for initial brainstorming and scenario setup

## Overview

This repository presents a series of SQL challenges designed around a **programmatic display advertising marketplace** scenario. The aim is to demonstrate proficiency in:

- Database schema design and data setup
- Retrieval and aggregation of data from multiple tables
- Use of joins, subqueries, CTEs, and window functions
- Real-world AdTech analytics: analyzing SSPs, campaign budgets, and performance metrics

## Scenario Context

In this scenario, you are working for a Demand-Side Platform (**DSP**) named **AdMaven**, purchasing display ad inventory from various Supply-Side Platforms (**SSPs**). Each campaign has unique goals and budgets, and you must help identify top-performing SSPs, ensure budget optimization, and uncover patterns in user engagement.

## Files and Structure

- **`01_setup_tables.sql`**:  
  Contains `CREATE TABLE` statements to define the schema:  
  - `ssp_details`  
  - `campaigns`  
  - `campaign_performance`

- **`02_insert_data.sql`**:  
  Inserts sample data into the three tables, providing a realistic dataset to query against.

- **`03_challenges.md`**:  
  A list of SQL challenges (Easy → Intermediate → Advanced → Expert), each with a narrative, learning objectives, and step-by-step reasoning. The challenges cover:
  - Basic `SELECT` and `WHERE` filters
  - Aggregations with `GROUP BY` and `HAVING`
  - Various `JOIN` operations
  - Subqueries, CTEs, and window functions (`RANK`, `LAG`, `LEAD`, `ROW_NUMBER`)
  - Data cleansing and filtering techniques
  - Real-world AdTech performance metrics (CTR, CPC, conversions, budget pacing)

## How to Use This Repository

1. **Set Up a Database Environment**:  
   This code is Oracle-compatible. For convenience, use [Oracle Live SQL](https://livesql.oracle.com/) or any local Oracle Database instance.  
   *Note: If using another SQL dialect (MySQL, PostgreSQL), minor syntax adjustments may be required.*

2. **Create and Populate Tables**:  
   - Run the statements in **`01_setup_tables.sql`** to create the tables.
   - Run the statements in **`02_insert_data.sql`** to insert sample data.
   - Verify data insertion with a query like:  
     ```sql
     SELECT * FROM ssp_details;
     ```

3. **Attempt the Challenges**:  
   Refer to **`03_challenges.md`** for a progression of SQL challenges. Each challenge includes:
   - A business scenario and objective.
   - Approach and logic steps (without revealing the final SQL immediately).
   - After understanding the approach, confirm your readiness, and then review the final SQL solution.
   
   This approach encourages reasoning and skill-building before seeing the final answer.

## Example Challenge Topics

- **Easy:**  
  - Identify all `premium` SSPs in the US.  
  - Filter campaigns running in a given month.
  
- **Intermediate:**  
  - Aggregate daily spend per campaign and compare it to the daily budget.  
  - Find the top 3 SSPs by conversion rate across all retail campaigns.
  
- **Advanced:**  
  - Use window functions to rank SSPs by CTR (Click-Through Rate).  
  - Employ subqueries to identify campaigns exceeding their budget consistently.

- **Expert:**  
  - Combine multiple tables and use CTEs to calculate multi-step KPIs (e.g., impressions → clicks → conversions).  
  - Data cleansing: exclude incomplete records and derive insights from the cleaned dataset.

## Notes on Creation

This repository was inspired and guided by initial prompts provided to **ChatGPT**, an AI language model by OpenAI. The tool assisted in brainstorming the scenario, data setup, and challenge outlines. All SQL code and documentation were then refined and validated for this repository.

