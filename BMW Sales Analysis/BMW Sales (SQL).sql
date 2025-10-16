-- ANALYSIS 1: OVERVIEW OF SALES PERFORMANCE BY MODEL

SELECT 
    Model,
    COUNT(*) as Total_Units_Sold,
    AVG(Price_USD) as Avg_Price,
    SUM(Sales_Volume) as Total_Sales_Volume,
    ROUND(AVG(Mileage_KM), 2) as Avg_Mileage_KM
FROM bmw_sales 
GROUP BY Model
ORDER BY Total_Sales_Volume DESC;

/*
Explanation: This query provides an overview of sales performance by BMW model, showing which models are the best sellers 
and their average pricing and mileage characteristics.

Conclusion: The results will reveal BMW's top-selling models and their market positioning. Models with high sales volume 
but lower average prices might be entry-level offerings, while high-priced models with lower volumes could be luxury or 
performance variants.
*/

-- ANALYSIS 2: SALES TRENDS OVER YEARS
SELECT 
    Year,
    COUNT(*) as Units_Sold,
    SUM(Sales_Volume) as Total_Sales,
    AVG(Price_USD) as Avg_Price,
    ROUND((SUM(Sales_Volume) - LAG(SUM(Sales_Volume)) OVER (ORDER BY Year)) / 
          LAG(SUM(Sales_Volume)) OVER (ORDER BY Year) * 100, 2) as Sales_Growth_Percent
FROM bmw_sales
GROUP BY Year
ORDER BY Year;

/*
Explanation: This analyzes sales trends over time, showing year-over-year growth and pricing evolution. The window 
function calculates percentage growth from previous year.

Conclusion: This reveals BMW's sales trajectory - whether the brand is growing, stable, or declining. Significant 
growth spikes might correlate with new model launches or market expansions.
*/

-- ANALYSIS 3: REGIONAL MARKET ANALYSIS
SELECT 
    Region,
    COUNT(*) as Total_Transactions,
    SUM(Sales_Volume) as Total_Sales_Volume,
    AVG(Price_USD) as Avg_Price,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bmw_sales), 2) as Market_Share_Percent
FROM bmw_sales
GROUP BY Region
ORDER BY Total_Sales_Volume DESC;

/*
Explanation: This examines BMW's market presence across different regions, showing where the brand has the 
strongest sales and highest average prices.

Conclusion: Identifies BMW's strongest markets geographically. Some regions might show premium positioning 
(higher prices), while others might be volume-focused markets.
*/

-- ANALYSIS 4: FUEL TYPE PREFERENCES BY REGION
SELECT 
    Region,
    Fuel_Type,
    COUNT(*) as Units_Sold,
    AVG(Price_USD) as Avg_Price,
    SUM(Sales_Volume) as Total_Sales
FROM bmw_sales
GROUP BY Region, Fuel_Type
ORDER BY Region, Total_Sales DESC;

/*
Explanation: Analyzes consumer preferences for different fuel types (Petrol, Diesel, Electric, Hybrid) across 
various regions.

Conclusion: Reveals regional preferences for powertrain technologies. Some markets might strongly prefer electric 
vehicles, while others still favor traditional fuel types, indicating different stages of EV adoption.
*/

-- ANALYSIS 5: PRICE SEGMENTATION AND SALES CLASSIFICATION
SELECT 
    Sales_Classification,
    COUNT(*) as Number_of_Listings,
    AVG(Price_USD) as Avg_Price,
    AVG(Engine_Size_L) as Avg_Engine_Size,
    AVG(Mileage_KM) as Avg_Mileage
FROM bmw_sales
GROUP BY Sales_Classification
ORDER BY Avg_Price DESC;

/*
Explanation: Compares the "High" vs "Low" sales classification categories to understand what factors drive premium 
positioning.

Conclusion: Shows the characteristics that differentiate high-performing sales from low-performing ones. High 
classification might correlate with newer models, larger engines, or specific features.
*/

-- ANALYSIS 6: TRANSMISSION PREFERENCES BY MODEL YEAR
SELECT 
    Year,
    Transmission,
    COUNT(*) as Units_Sold,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY Year), 2) as Yearly_Share_Percent
FROM bmw_sales
GROUP BY Year, Transmission
ORDER BY Year, Units_Sold DESC;

/*
Explanation: Tracks the evolution of transmission preferences (Manual vs Automatic) over time.

Conclusion: Reveals shifting consumer preferences toward automatic transmissions, especially in recent years, 
reflecting global automotive trends.
*/

-- ANALYSIS 7: COLOR PREFERENCES ANALYSIS
SELECT 
    Color,
    COUNT(*) as Units_Sold,
    AVG(Price_USD) as Avg_Price,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bmw_sales), 2) as Market_Share_Percent
FROM bmw_sales
GROUP BY Color
ORDER BY Units_Sold DESC;

/*
Explanation: Analyzes color preferences across BMW's vehicle lineup and how they relate to pricing.

Conclusion: Identifies the most popular colors and whether certain colors command premium pricing. Traditional 
colors like Black, White, and Silver typically dominate luxury car markets.
*/

-- ANALYSIS 8: ENGINE SIZE VS PRICE CORRELATION
SELECT 
    CASE 
        WHEN Engine_Size_L <= 2.0 THEN 'Small (<=2.0L)'
        WHEN Engine_Size_L <= 3.0 THEN 'Medium (2.1-3.0L)'
        WHEN Engine_Size_L <= 4.0 THEN 'Large (3.1-4.0L)'
        ELSE 'Extra Large (>4.0L)'
    END as Engine_Category,
    COUNT(*) as Units,
    AVG(Price_USD) as Avg_Price,
    AVG(Mileage_KM) as Avg_Mileage
FROM bmw_sales
GROUP BY Engine_Category
ORDER BY Avg_Price DESC;

/*
Explanation: Categorizes vehicles by engine size to understand how engine displacement correlates with pricing 
and other characteristics.

Conclusion: Shows the relationship between engine size and vehicle pricing. Larger engines typically command 
higher prices but may have different mileage patterns.
*/

-- ANALYSIS 9: RECENT VS OLDER MODEL COMPARISON (LAST 3 YEARS VS REST)
SELECT 
    CASE 
        WHEN Year >= 2021 THEN 'Recent Models (2021-2024)'
        ELSE 'Older Models (2010-2020)'
    END as Model_Age_Category,
    COUNT(*) as Total_Units,
    AVG(Price_USD) as Avg_Price,
    AVG(Mileage_KM) as Avg_Mileage,
    AVG(Engine_Size_L) as Avg_Engine_Size,
    ROUND(SUM(CASE WHEN Fuel_Type = 'Electric' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as Electric_Share_Percent
FROM bmw_sales
GROUP BY Model_Age_Category;

/*
Explanation: Compares recent models with older ones to identify trends in pricing, technology adoption, and 
specifications.

Conclusion: Reveals how BMW's product strategy has evolved - recent models might show higher electric vehicle 
adoption, different pricing strategies, or changing engine size preferences.
*/

-- ANALYSIS 10: TOP PERFORMING MODELS BY REGION
WITH RegionalRankings AS (
    SELECT 
        Region,
        Model,
        SUM(Sales_Volume) as Regional_Sales,
        RANK() OVER (PARTITION BY Region ORDER BY SUM(Sales_Volume) DESC) as Rank_In_Region
    FROM bmw_sales
    GROUP BY Region, Model
)
SELECT 
    Region,
    Model,
    Regional_Sales
FROM RegionalRankings
WHERE Rank_In_Region <= 3
ORDER BY Region, Rank_In_Region;

/*
Explanation: Identifies the top 3 best-selling models in each region using a window function for ranking.

Conclusion: Shows regional variations in model preferences. Some models might be universally popular, while 
others might have strong regional appeal due to specific market needs or marketing strategies.
*/
