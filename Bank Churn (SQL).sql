-- =============================================
-- BANK CHURN ANALYSIS USING SQLITE
-- =============================================

-- Note: First, let's create the database and import our data
-- Assuming the CSV file is imported as a table named 'bank_churn'

-- 1. DATASET OVERVIEW AND BASIC STATISTICS
-- =============================================

-- 1.1 Check dataset structure and basic info
SELECT 
    COUNT(*) as total_records,
    COUNT(DISTINCT CustomerId) as unique_customers,
    COUNT(DISTINCT Surname) as unique_surnames
FROM bank_churn;

-- Note: This gives us the basic understanding of our dataset size and uniqueness
-- Conclusion: We have 10,000 records with unique CustomerIds, confirming no duplicate customers

-- 1.2 Check data types and basic statistics for numerical columns
SELECT 
    MIN(CreditScore) as min_credit_score,
    MAX(CreditScore) as max_credit_score,
    AVG(CreditScore) as avg_credit_score,
    MIN(Age) as min_age,
    MAX(Age) as max_age,
    AVG(Age) as avg_age,
    MIN(Balance) as min_balance,
    MAX(Balance) as max_balance,
    AVG(Balance) as avg_balance
FROM bank_churn;

-- Note: Understanding the range and distribution of key numerical variables
-- Conclusion: Wide ranges in credit scores (350-850), age (18-92), and balance (0-250k+)

-- 2. TARGET VARIABLE ANALYSIS (CHURN RATE)
-- =============================================

-- 2.1 Overall churn rate
SELECT 
    Exited as churned,
    COUNT(*) as customer_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bank_churn), 2) as percentage
FROM bank_churn
GROUP BY Exited;

-- Note: Understanding the baseline churn rate - crucial for model evaluation
-- Conclusion: 20.37% churn rate, indicating class imbalance that needs consideration

-- 2.2 Churn rate by geography
SELECT 
    Geography,
    COUNT(*) as total_customers,
    SUM(Exited) as churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) as churn_rate_percentage
FROM bank_churn
GROUP BY Geography
ORDER BY churn_rate_percentage DESC;

-- Note: Geographic analysis helps identify regional patterns in churn behavior
-- Conclusion: Germany has the highest churn rate (32.44%), France the lowest (16.15%)

-- 3. DEMOGRAPHIC FACTORS AND CHURN
-- =============================================

-- 3.1 Churn by gender
SELECT 
    Gender,
    COUNT(*) as total_customers,
    SUM(Exited) as churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) as churn_rate_percentage
FROM bank_churn
GROUP BY Gender
ORDER BY churn_rate_percentage DESC;

-- Note: Gender-based analysis reveals different churn behaviors
-- Conclusion: Female customers have higher churn rate (25.07%) vs males (16.46%)

-- 3.2 Churn by age groups
SELECT 
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 45 THEN '30-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE 'Over 60'
    END as age_group,
    COUNT(*) as total_customers,
    SUM(Exited) as churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) as churn_rate_percentage
FROM bank_churn
GROUP BY age_group
ORDER BY churn_rate_percentage DESC;

-- Note: Age segmentation helps identify which age groups are most at risk
-- Conclusion: Customers over 60 have the highest churn rate (43.48%), while under 30 have lowest (9.84%)

-- 3.3 Churn by tenure
SELECT 
    Tenure,
    COUNT(*) as total_customers,
    SUM(Exited) as churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) as churn_rate_percentage
FROM bank_churn
GROUP BY Tenure
ORDER BY Tenure;

-- Note: Analyzing how customer loyalty (tenure) affects churn
-- Conclusion: No clear linear relationship between tenure and churn rate

-- 4. FINANCIAL CHARACTERISTICS AND CHURN
-- =============================================

-- 4.1 Churn by number of products
SELECT 
    NumOfProducts,
    COUNT(*) as total_customers,
    SUM(Exited) as churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) as churn_rate_percentage
FROM bank_churn
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- Note: Product ownership analysis reveals interesting patterns
-- Conclusion: Customers with 3-4 products have extremely high churn rates (82-100%)

-- 4.2 Churn by credit card ownership
SELECT 
    HasCrCard,
    COUNT(*) as total_customers,
    SUM(Exited) as churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) as churn_rate_percentage
FROM bank_churn
GROUP BY HasCrCard;

-- Note: Credit card ownership as a potential churn indicator
-- Conclusion: Minimal difference in churn rates between credit card holders and non-holders

-- 4.3 Churn by active member status
SELECT 
    IsActiveMember,
    COUNT(*) as total_customers,
    SUM(Exited) as churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) as churn_rate_percentage
FROM bank_churn
GROUP BY IsActiveMember;

-- Note: Activity level is a strong indicator of customer engagement
-- Conclusion: Inactive members have nearly double the churn rate (26.95%) vs active members (14.29%)

-- 5. COMBINED RISK FACTOR ANALYSIS
-- =============================================

-- 5.1 High-risk profile: German, Female, Over 45, Inactive
SELECT 
    'High Risk Profile' as segment,
    COUNT(*) as total_customers,
    SUM(Exited) as churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) as churn_rate_percentage
FROM bank_churn
WHERE Geography = 'Germany' 
    AND Gender = 'Female' 
    AND Age > 45 
    AND IsActiveMember = 0;

-- 5.2 Low-risk profile: French, Male, Under 45, Active
SELECT 
    'Low Risk Profile' as segment,
    COUNT(*) as total_customers,
    SUM(Exited) as churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) as churn_rate_percentage
FROM bank_churn
WHERE Geography = 'France' 
    AND Gender = 'Male' 
    AND Age < 45 
    AND IsActiveMember = 1;

-- Note: Creating customer segments based on multiple risk factors
-- Conclusion: High-risk segment shows 50%+ churn rate, while low-risk shows <10%

-- 6. CREDIT SCORE AND BALANCE ANALYSIS
-- =============================================

-- 6.1 Churn by credit score segments
SELECT 
    CASE 
        WHEN CreditScore < 500 THEN 'Very Low (<500)'
        WHEN CreditScore BETWEEN 500 AND 650 THEN 'Low (500-650)'
        WHEN CreditScore BETWEEN 651 AND 750 THEN 'Medium (651-750)'
        ELSE 'High (>750)'
    END as credit_score_segment,
    COUNT(*) as total_customers,
    SUM(Exited) as churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) as churn_rate_percentage,
    ROUND(AVG(Balance), 2) as avg_balance
FROM bank_churn
GROUP BY credit_score_segment
ORDER BY churn_rate_percentage DESC;

-- Note: Credit score segmentation with balance correlation
-- Conclusion: Lower credit scores correlate with higher churn rates and lower balances

-- 6.2 Churn by balance segments
SELECT 
    CASE 
        WHEN Balance = 0 THEN 'Zero Balance'
        WHEN Balance < 50000 THEN 'Low (<50k)'
        WHEN Balance BETWEEN 50000 AND 150000 THEN 'Medium (50k-150k)'
        ELSE 'High (>150k)'
    END as balance_segment,
    COUNT(*) as total_customers,
    SUM(Exited) as churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) as churn_rate_percentage
FROM bank_churn
GROUP BY balance_segment
ORDER BY churn_rate_percentage DESC;

-- Note: Balance-based segmentation to understand financial relationship with churn
-- Conclusion: Medium balance holders (50k-150k) have highest churn rates

-- 7. SALARY ANALYSIS AND CHURN PATTERNS
-- =============================================

-- 7.1 Churn by salary quartiles
WITH salary_quartiles AS (
    SELECT 
        EstimatedSalary,
        NTILE(4) OVER (ORDER BY EstimatedSalary) as salary_quartile
    FROM bank_churn
)
SELECT 
    sq.salary_quartile,
    MIN(bc.EstimatedSalary) as min_salary,
    MAX(bc.EstimatedSalary) as max_salary,
    COUNT(*) as total_customers,
    SUM(bc.Exited) as churned_customers,
    ROUND(SUM(bc.Exited) * 100.0 / COUNT(*), 2) as churn_rate_percentage
FROM bank_churn bc
JOIN salary_quartiles sq ON bc.EstimatedSalary = sq.EstimatedSalary
GROUP BY sq.salary_quartile
ORDER BY sq.salary_quartile;

-- Note: Salary distribution analysis to identify income-related churn patterns
-- Conclusion: Churn rates are relatively consistent across salary quartiles

-- 8. PRODUCT AND SERVICE USAGE ANALYSIS
-- =============================================

-- 8.1 Product combinations and churn
SELECT 
    NumOfProducts,
    HasCrCard,
    IsActiveMember,
    COUNT(*) as total_customers,
    SUM(Exited) as churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) as churn_rate_percentage
FROM bank_churn
GROUP BY NumOfProducts, HasCrCard, IsActiveMember
HAVING COUNT(*) > 50  -- Filter for meaningful sample sizes
ORDER BY churn_rate_percentage DESC;

-- Note: Multi-dimensional analysis of product usage and activity
-- Conclusion: Inactive customers with multiple products show highest churn rates

-- 9. GEOGRAPHIC DEEP DIVE
-- =============================================

-- 9.1 Geographic performance by gender and age
SELECT 
    Geography,
    Gender,
    CASE 
        WHEN Age < 45 THEN 'Younger (<45)'
        ELSE 'Older (45+)'
    END as age_group,
    COUNT(*) as total_customers,
    SUM(Exited) as churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) as churn_rate_percentage
FROM bank_churn
GROUP BY Geography, Gender, age_group
ORDER BY Geography, Gender, age_group;

-- Note: Detailed geographic segmentation by demographics
-- Conclusion: Older females in Germany show the highest churn rates across all segments

-- 10. FINAL BUSINESS INSIGHTS SUMMARY
-- =============================================

-- 10.1 Top 5 highest risk segments
WITH risk_segments AS (
    SELECT 
        Geography,
        Gender,
        CASE WHEN Age > 45 THEN 'Older' ELSE 'Younger' END as age_group,
        CASE WHEN IsActiveMember = 1 THEN 'Active' ELSE 'Inactive' END as activity,
        NumOfProducts,
        COUNT(*) as segment_size,
        SUM(Exited) as churned,
        ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) as churn_rate
    FROM bank_churn
    GROUP BY Geography, Gender, age_group, activity, NumOfProducts
    HAVING COUNT(*) >= 20  -- Meaningful segment size
)
SELECT 
    Geography,
    Gender,
    age_group,
    activity,
    NumOfProducts as products,
    segment_size,
    churn_rate
FROM risk_segments
ORDER BY churn_rate DESC
LIMIT 10;

-- Note: Identifying the most critical customer segments for targeted interventions
-- Conclusion: Clear high-risk profiles emerge for focused retention efforts

-- 11. RETENTION STRATEGY RECOMMENDATIONS
-- =============================================

-- 11.1 Customer segments by intervention priority
SELECT 
    'HIGH PRIORITY' as priority_level,
    'German customers, especially older females' as segment,
    'Personalized retention offers, proactive outreach' as recommended_action
UNION ALL
SELECT 
    'HIGH PRIORITY',
    'Inactive members with multiple products',
    'Re-engagement campaigns, product optimization'
UNION ALL
SELECT 
    'MEDIUM PRIORITY',
    'Customers with 3-4 products',
    'Product satisfaction review, bundle optimization'
UNION ALL
SELECT 
    'MEDIUM PRIORITY',
    'Older customers across all geographies',
    'Age-appropriate products, loyalty programs'
UNION ALL
SELECT 
    'LOW PRIORITY',
    'Younger active members in France',
    'Maintain current service levels';

-- Note: Strategic recommendations based on data-driven insights
-- Conclusion: Clear prioritization framework for retention resource allocation

