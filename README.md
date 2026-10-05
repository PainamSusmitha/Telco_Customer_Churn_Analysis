# Telco Customer Churn Analysis

## Problem Statement
Customer churn (customers leaving the service) is a major cost for telecom companies. This project analyzes a telecom customer dataset to identify which factors drive churn, and quantifies the revenue impact, so the business can take targeted retention action.

## Dataset
- Source: Kaggle (IBM Telco Customer Churn dataset)
- 7,043 customer records, 33 columns
- Includes demographics, services subscribed, contract/billing details, and churn status

## Tools Used
- **Excel** — data cleaning (fixing blank values, column formatting)
- **MySQL** — data cleaning validation, business-question analysis using JOINs, subqueries, window functions, CASE WHEN
- **Power BI** — interactive dashboard with KPI cards, charts, map, and slicers

## Key Insights
- Overall churn rate: **26.54%**
- Month-to-month contract customers churn at **42.71%**, vs just **2.83%** for two-year contracts
- Fiber optic users churn more (**41.89%**) than DSL users (**18.96%**)
- New customers (0-1 year tenure) churn at **47.44%**, dropping to **9.51%** after 4+ years
- Churned customers cost the company approximately **₹1.39 Lakh** in monthly revenue
- Electronic check users have the highest churn rate (**45.29%**) among all payment methods

## Dashboard
![Dashboard Screenshot](Telco_Customers_Churn_Analysis%20Dashboard.png)

## Files in this Repository
- `Queries.SQL` — all SQL queries used for analysis
- `Teleco_Churn_Cleaned_CSV.csv` — cleaned customer dataset
- `Teleco_customer_Churn_Population.csv` — city population data (used for JOIN analysis)
- `Telco Churn Project.pbix` — Power BI dashboard file
- `Telco_Customers_Churn_Analysis Dashboard.png` — dashboard preview image

## Author
Susmitha Painam — Aspiring Data Analyst
[LinkedIn](https://www.linkedin.com/in/susmitha-reddy-painam-b70a59307/) | susmithareddypainam@gmail.com
