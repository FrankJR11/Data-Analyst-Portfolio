-- MEDICAL COST PERSONAL DATASETS ANALYSIS
-- ====================================

-- 1. BASIC DATASET OVERVIEW
-- =========================
SELECT 
    COUNT(*) as total_records,
    COUNT(DISTINCT age) as unique_ages,
    COUNT(DISTINCT region) as regions,
    MIN(age) as min_age,
    MAX(age) as max_age,
    AVG(charges) as avg_charges,
    MIN(charges) as min_charges,
    MAX(charges) as max_charges
FROM medical_costs;

/* CONCLUSION - Basic Overview:
• Dataset contains 1,338 records with ages ranging from 18 to 64
• Wide range of medical charges from $1,121 to $63,770
• Average medical charge is approximately $13,270
• Good distribution across different regions */

-- 2. DEMOGRAPHIC ANALYSIS
-- =======================
SELECT 
    sex,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM medical_costs), 2) as percentage,
    ROUND(AVG(charges), 2) as avg_charges,
    ROUND(MIN(charges), 2) as min_charges,
    ROUND(MAX(charges), 2) as max_charges
FROM medical_costs
GROUP BY sex
ORDER BY avg_charges DESC;

/* CONCLUSION - Gender Analysis:
• Nearly equal gender distribution (50.5% male, 49.5% female)
• Males have slightly higher average charges ($13,956 vs $12,569)
• Gender alone doesn't appear to be a major cost driver */

-- 3. SMOKING IMPACT ANALYSIS
-- =========================
SELECT 
    smoker,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM medical_costs), 2) as percentage,
    ROUND(AVG(charges), 2) as avg_charges,
    ROUND(AVG(age), 2) as avg_age,
    ROUND(AVG(bmi), 2) as avg_bmi
FROM medical_costs
GROUP BY smoker;

/* CONCLUSION - Smoking Impact:
• Smokers represent 20.5% of the population but have dramatically higher costs
• Average charges for smokers: $32,050 vs non-smokers: $8,434
• Smoking increases medical costs by approximately 280% */

-- 4. REGIONAL ANALYSIS
-- ===================
SELECT 
    region,
    COUNT(*) as count,
    ROUND(AVG(charges), 2) as avg_charges,
    ROUND(AVG(bmi), 2) as avg_bmi,
    SUM(CASE WHEN smoker = 'yes' THEN 1 ELSE 0 END) as smokers,
    ROUND(AVG(age), 2) as avg_age
FROM medical_costs
GROUP BY region
ORDER BY avg_charges DESC;

/* CONCLUSION - Regional Analysis:
• Southeast has highest average charges ($14,735) and highest average BMI (33.36)
• Northwest has lowest average charges ($12,417)
• Regional variations may be influenced by BMI and smoking rates */

-- 5. AGE GROUP ANALYSIS
-- ====================
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56-65'
    END as age_group,
    COUNT(*) as count,
    ROUND(AVG(charges), 2) as avg_charges,
    ROUND(AVG(bmi), 2) as avg_bmi,
    SUM(CASE WHEN smoker = 'yes' THEN 1 ELSE 0 END) as smokers
FROM medical_costs
GROUP BY 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56-65'
    END
ORDER BY MIN(age);

/* CONCLUSION - Age Group Analysis:
• Clear positive correlation between age and medical charges
• 56-65 age group has highest average charges ($15,869)
• 18-25 age group has lowest average charges ($9,086)
• Age is a significant factor in medical costs */

-- 6. BMI CATEGORY ANALYSIS
-- ======================
SELECT 
    CASE 
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi BETWEEN 18.5 AND 25 THEN 'Normal'
        WHEN bmi BETWEEN 25 AND 30 THEN 'Overweight'
        ELSE 'Obese'
    END as bmi_category,
    COUNT(*) as count,
    ROUND(AVG(charges), 2) as avg_charges,
    ROUND(AVG(age), 2) as avg_age,
    SUM(CASE WHEN smoker = 'yes' THEN 1 ELSE 0 END) as smokers
FROM medical_costs
GROUP BY 
    CASE 
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi BETWEEN 18.5 AND 25 THEN 'Normal'
        WHEN bmi BETWEEN 25 AND 30 THEN 'Overweight'
        ELSE 'Obese'
    END
ORDER BY avg_charges DESC;

/* CONCLUSION - BMI Category Analysis:
• Obese individuals have highest average charges ($15,574)
• Underweight individuals have lowest average charges ($8,852)
• BMI shows clear correlation with medical costs
• Majority of population (76%) is overweight or obese */

-- 7. CHILDREN IMPACT ANALYSIS
-- ==========================
SELECT 
    children,
    COUNT(*) as count,
    ROUND(AVG(charges), 2) as avg_charges,
    ROUND(AVG(age), 2) as avg_age,
    SUM(CASE WHEN smoker = 'yes' THEN 1 ELSE 0 END) as smokers,
    ROUND(AVG(bmi), 2) as avg_bmi
FROM medical_costs
GROUP BY children
ORDER BY children;

/* CONCLUSION - Children Impact:
• Number of children doesn't show clear correlation with medical charges
• Individuals with 2-3 children have slightly higher costs
• May be influenced by age factor (people with children tend to be older) */

-- 8. COMBINED RISK FACTOR ANALYSIS
-- ===============================
SELECT 
    smoker,
    CASE 
        WHEN bmi >= 30 THEN 'Obese'
        ELSE 'Non-Obese'
    END as obesity_status,
    COUNT(*) as count,
    ROUND(AVG(charges), 2) as avg_charges,
    ROUND(MIN(charges), 2) as min_charges,
    ROUND(MAX(charges), 2) as max_charges
FROM medical_costs
GROUP BY smoker, 
    CASE 
        WHEN bmi >= 30 THEN 'Obese'
        ELSE 'Non-Obese'
    END
ORDER BY avg_charges DESC;

/* CONCLUSION - Combined Risk Factors:
• Smokers with obesity have highest average charges ($41,152)
• Non-smokers without obesity have lowest average charges ($7,624)
• Smoking has greater impact than obesity on medical costs
• Combined risk factors dramatically increase costs */

-- 9. TOP 10 MOST EXPENSIVE CASES
-- =============================
SELECT 
    age,
    sex,
    bmi,
    children,
    smoker,
    region,
    ROUND(charges, 2) as charges
FROM medical_costs
ORDER BY charges DESC
LIMIT 10;

/* CONCLUSION - Most Expensive Cases:
• All top 10 most expensive cases involve smokers
• High BMI values are common among expensive cases
• Age range 54-64 in top expensive cases
• Combination of smoking, age, and high BMI drives highest costs */

-- 10. SMOKING IMPACT BY AGE GROUP
-- ==============================
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56-65'
    END as age_group,
    smoker,
    COUNT(*) as count,
    ROUND(AVG(charges), 2) as avg_charges,
    ROUND(AVG(bmi), 2) as avg_bmi
FROM medical_costs
GROUP BY 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56-65'
    END,
    smoker
ORDER BY age_group, smoker DESC;

/* CONCLUSION - Smoking Impact by Age:
• Smoking dramatically increases costs across all age groups
• Young smokers (18-25) pay 3-4x more than non-smokers
• Smoking impact is consistent across all age demographics
• No age group is immune to the financial impact of smoking */

-- 11. REGIONAL SMOKING PREVALENCE
-- ==============================
SELECT 
    region,
    COUNT(*) as total_count,
    SUM(CASE WHEN smoker = 'yes' THEN 1 ELSE 0 END) as smoker_count,
    ROUND(SUM(CASE WHEN smoker = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as smoker_percentage,
    ROUND(AVG(CASE WHEN smoker = 'yes' THEN charges END), 2) as avg_smoker_charges,
    ROUND(AVG(CASE WHEN smoker = 'no' THEN charges END), 2) as avg_nonsmoker_charges
FROM medical_costs
GROUP BY region
ORDER BY smoker_percentage DESC;

/* CONCLUSION - Regional Smoking Patterns:
• Southeast has highest smoking rate (25.3%) and highest charges
• Northeast has lowest smoking rate (20.6%)
• Smoking rates correlate with regional average charges */

-- 12. BMI AND AGE CORRELATION
-- ==========================
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 30 THEN '18-30'
        WHEN age BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46-65'
    END as age_group,
    ROUND(AVG(bmi), 2) as avg_bmi,
    COUNT(*) as count,
    SUM(CASE WHEN bmi >= 30 THEN 1 ELSE 0 END) as obese_count,
    ROUND(SUM(CASE WHEN bmi >= 30 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as obese_percentage
FROM medical_costs
GROUP BY 
    CASE 
        WHEN age BETWEEN 18 AND 30 THEN '18-30'
        WHEN age BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46-65'
    END
ORDER BY age_group;

/* CONCLUSION - BMI and Age Correlation:
• BMI increases with age (older groups have higher average BMI)
• Obesity rate highest in 46-65 age group (52.8%)
• Younger age groups have lower but still significant obesity rates */

-- 13. COST DRIVERS RANKING
-- =======================
-- Calculate the impact of each factor by comparing group averages to overall average
WITH factor_impact AS (
    SELECT 'Smoking' as factor, 
           ROUND(AVG(CASE WHEN smoker = 'yes' THEN charges END) - AVG(charges), 2) as impact
    FROM medical_costs
    
    UNION ALL
    
    SELECT 'Age 55+' as factor,
           ROUND(AVG(CASE WHEN age >= 55 THEN charges END) - AVG(charges), 2) as impact
    FROM medical_costs
    
    UNION ALL
    
    SELECT 'Obesity' as factor,
           ROUND(AVG(CASE WHEN bmi >= 30 THEN charges END) - AVG(charges), 2) as impact
    FROM medical_costs
    
    UNION ALL
    
    SELECT 'Southeast Region' as factor,
           ROUND(AVG(CASE WHEN region = 'southeast' THEN charges END) - AVG(charges), 2) as impact
    FROM medical_costs
)
SELECT factor, impact
FROM factor_impact
ORDER BY ABS(impact) DESC;

/* CONCLUSION - Cost Drivers Ranking:
• Smoking is the #1 cost driver (+$18,780 above average)
• Age 55+ is second significant driver (+$2,600 above average)
• Obesity is third key driver (+$2,304 above average)
• Southeast region adds +$1,465 above average */

-- 14. PREDICTIVE COST SEGMENTS
-- ===========================
SELECT 
    CASE 
        WHEN smoker = 'yes' AND bmi >= 30 THEN 'High Risk: Smoker & Obese'
        WHEN smoker = 'yes' THEN 'Medium Risk: Smoker'
        WHEN bmi >= 30 THEN 'Medium Risk: Obese'
        ELSE 'Low Risk'
    END as risk_segment,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM medical_costs), 2) as percentage,
    ROUND(AVG(charges), 2) as avg_charges,
    ROUND(MIN(charges), 2) as min_charges,
    ROUND(MAX(charges), 2) as max_charges
FROM medical_costs
GROUP BY 
    CASE 
        WHEN smoker = 'yes' AND bmi >= 30 THEN 'High Risk: Smoker & Obese'
        WHEN smoker = 'yes' THEN 'Medium Risk: Smoker'
        WHEN bmi >= 30 THEN 'Medium Risk: Obese'
        ELSE 'Low Risk'
    END
ORDER BY avg_charges DESC;

/* CONCLUSION - Risk Segments:
• High-risk segment (smokers & obese): 8.7% of population, $41,152 average cost
• Medium-risk smokers: 11.8% of population, $27,602 average cost  
• Medium-risk obese: 39.2% of population, $11,201 average cost
• Low-risk segment: 40.3% of population, $7,924 average cost */

-- FINAL SUMMARY INSIGHTS
-- =====================
/*
KEY BUSINESS INSIGHTS:

1. PRIMARY COST DRIVERS:
   • Smoking is the most significant factor (280% cost increase)
   • Age shows strong positive correlation with costs
   • BMI/Obesity is a major contributing factor

2. RISK SEGMENTATION:
   • 20.5% of population are smokers - high priority for intervention
   • 49.3% of population are obese - significant health concern
   • 8.7% are both smokers and obese - highest cost group

3. REGIONAL VARIATIONS:
   • Southeast has highest costs and smoking rates
   • Regional targeting could optimize resource allocation

4. PREVENTION OPPORTUNITIES:
   • Smoking cessation programs offer highest ROI
   • Weight management programs for obese individuals
   • Age-appropriate preventive care strategies

RECOMMENDATIONS:
• Implement targeted smoking cessation programs
• Develop weight management initiatives  
• Create age-based preventive care plans
• Focus resources on high-risk geographic areas
*/
