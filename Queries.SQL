-- Q1: Overall churn rate
SELECT Churn_Label, COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_churn), 2) AS percentage
FROM customer_churn
GROUP BY Churn_Label;

-- Q2: Churn rate by contract type
SELECT Contract, COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_percent
FROM customer_churn
GROUP BY Contract
ORDER BY churn_rate_percent DESC;

-- Q3: Churn rate by internet service
SELECT Internet_Service, COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_percent
FROM customer_churn
GROUP BY Internet_Service
ORDER BY churn_rate_percent DESC;

-- Q4: Churn rate by senior citizen status
SELECT Senior_Citizen, COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_percent
FROM customer_churn
GROUP BY Senior_Citizen
ORDER BY churn_rate_percent DESC;

-- Q5: Churn rate by tenure group
SELECT 
    CASE 
        WHEN Tenure_Months <= 12 THEN '0-1 Year'
        WHEN Tenure_Months <= 24 THEN '1-2 Years'
        WHEN Tenure_Months <= 48 THEN '2-4 Years'
        ELSE '4+ Years'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_percent
FROM customer_churn
GROUP BY tenure_group
ORDER BY churn_rate_percent DESC;

-- Q6: Revenue impact of churn
SELECT Churn_Label, COUNT(*) AS total_customers,
    ROUND(SUM(Monthly_Charges), 2) AS total_monthly_revenue,
    ROUND(AVG(Monthly_Charges), 2) AS avg_monthly_charge
FROM customer_churn
GROUP BY Churn_Label;

-- Q7: Churn rate by payment method
SELECT Payment_Method, COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_percent
FROM customer_churn
GROUP BY Payment_Method
ORDER BY churn_rate_percent DESC;

-- Q8: Top 10 highest-value customers (CLTV)
SELECT Customer_ID, CLTV, Monthly_Charges, Churn_Label
FROM customer_churn
ORDER BY CLTV DESC
LIMIT 10;

-- Q9: Churn vs average city population (JOIN with population table)
SELECT c.Churn_Label,
    ROUND(AVG(p.Population), 0) AS avg_city_population,
    COUNT(*) AS customer_count
FROM customer_churn AS c
JOIN city_population AS p
ON c.Zip_Code = p.Zip_Code
GROUP BY c.Churn_Label;

-- Q10: Top 3 highest-paying churned customers per contract type (window function)
SELECT Customer_ID, Contract, Monthly_Charges, Churn_Label, rank_num
FROM (
    SELECT Customer_ID, Contract, Monthly_Charges, Churn_Label,
        RANK() OVER (PARTITION BY Contract ORDER BY Monthly_Charges DESC) AS rank_num
    FROM customer_churn
    WHERE Churn_Label = 'Yes'
) AS ranked_customers
WHERE rank_num <= 3;