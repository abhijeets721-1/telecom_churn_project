USE telecom_churn;

-- Q1: What is the overall churn rate?
SELECT COUNT(*) AS total_customers,
       SUM(churn_flag) AS churned,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined';

-- Q2: Which contract type has the highest churn?
SELECT contract, COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined'
GROUP BY contract ORDER BY churn_rate_pct DESC;

-- Q3: Do newer customers churn more than long-term ones?
SELECT tenure_group, COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined'
GROUP BY tenure_group ORDER BY churn_rate_pct DESC;

-- Q4: Which internet type has the highest churn?
SELECT internet_type, COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined'
GROUP BY internet_type ORDER BY churn_rate_pct DESC;

-- Q5: Why do customers churn?
SELECT churn_category, COUNT(*) AS churned
FROM customer_churn
WHERE customer_status = 'Churned'
GROUP BY churn_category ORDER BY churned DESC;

-- Q6: How much revenue was lost to churn, by contract type?
SELECT contract, ROUND(SUM(total_revenue), 0) AS revenue_from_churned
FROM customer_churn
WHERE customer_status = 'Churned'
GROUP BY contract ORDER BY revenue_from_churned DESC;

-- Q7: Which offers are working (lowest churn)?
SELECT offer, COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined'
GROUP BY offer ORDER BY churn_rate_pct DESC;

-- Q8: Effect of Premium Tech Support (internet customers only)
SELECT premium_tech_support, COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined' AND internet_service = 'Yes'
GROUP BY premium_tech_support;

-- Q9: Which age group churns the most?
SELECT age_group, COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined'
GROUP BY age_group ORDER BY churn_rate_pct DESC;

-- Q10: Which segment is the highest risk? (groups with 50+ customers only)
SELECT contract, internet_type, tenure_group,
       COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined'
GROUP BY contract, internet_type, tenure_group
HAVING COUNT(*) >= 50
ORDER BY churn_rate_pct DESC
LIMIT 5;

-- Q11: Which cities have the highest churn? (cities with 30+ customers only)
SELECT city, COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined'
GROUP BY city
HAVING COUNT(*) >= 30
ORDER BY churn_rate_pct DESC
LIMIT 5;
