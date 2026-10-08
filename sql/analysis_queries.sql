USE telecom_churn;

-- Q1: Overall churn kitna hai?
SELECT COUNT(*) AS total_customers,
       SUM(churn_flag) AS churned,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined';

-- Q2: Kis contract mein churn zyada hai?
SELECT contract, COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined'
GROUP BY contract ORDER BY churn_rate_pct DESC;

-- Q3: Naye customers zyada churn karte hain ya purane?
SELECT tenure_group, COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined'
GROUP BY tenure_group ORDER BY churn_rate_pct DESC;

-- Q4: Kaunsi internet service mein churn zyada hai?
SELECT internet_type, COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined'
GROUP BY internet_type ORDER BY churn_rate_pct DESC;

-- Q5: Customers churn kyun karte hain?
SELECT churn_category, COUNT(*) AS churned
FROM customer_churn
WHERE customer_status = 'Churned'
GROUP BY churn_category ORDER BY churned DESC;

-- Q6: Churn se kitna revenue gaya?
SELECT contract, ROUND(SUM(total_revenue), 0) AS revenue_from_churned
FROM customer_churn
WHERE customer_status = 'Churned'
GROUP BY contract ORDER BY revenue_from_churned DESC;

-- Q7: Kaun sa offer kaam kar raha hai?
SELECT offer, COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined'
GROUP BY offer ORDER BY churn_rate_pct DESC;

-- Q8: Premium Tech Support ka asar?
SELECT premium_tech_support, COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined' AND internet_service = 'Yes'
GROUP BY premium_tech_support;

-- Q9: Kaun si age group sabse zyada churn karti hai?
SELECT age_group, COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined'
GROUP BY age_group ORDER BY churn_rate_pct DESC;

-- Q10: Sabse high-risk segment kaun sa hai?
SELECT contract, internet_type, tenure_group,
       COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined'
GROUP BY contract, internet_type, tenure_group
HAVING COUNT(*) >= 50
ORDER BY churn_rate_pct DESC
LIMIT 5;

-- Q11: Kaun si cities mein churn zyada hai?
SELECT city, COUNT(*) AS customers,
       ROUND(AVG(churn_flag)*100, 2) AS churn_rate_pct
FROM customer_churn
WHERE customer_status <> 'Joined'
GROUP BY city
HAVING COUNT(*) >= 30
ORDER BY churn_rate_pct DESC
LIMIT 5;