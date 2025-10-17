# BMW Sales Data Analysis (2010-2024)

## 🚗 Brief Background

BMW is a leading global automotive manufacturer known for its luxury vehicles, performance models, and innovative electric mobility solutions. This project analyzes **15 years of global sales data (2010-2024)** to understand market dynamics, consumer preferences, and business performance across different models, regions, and vehicle specifications. The insights derived can inform strategic decisions in marketing, inventory management, and product development.

## 📊 Project Overview

This project conducts an **exploratory data analysis (EDA)** on a dataset of 5,000 BMW vehicle sales records. The goal is to uncover patterns and trends in sales performance, pricing, and customer preferences across different dimensions like model type, region, fuel type, and time.

**Objective:** To transform raw sales data into actionable business intelligence that reveals BMW's market strengths, emerging trends, and potential areas for strategic focus.

## 🎯 Project Scope

The analysis focuses on answering key business questions across the following domains:

- **Temporal Analysis:** Sales trends from 2010 to 2024
- **Geographical Analysis:** Sales performance across regions (North America, Europe, Asia, etc.)
- **Product Analysis:** Performance of different model series (3 Series, 5 Series, X3, X5, i-Series, M-Series)
- **Customer Preference Analysis:** Popular choices in color, fuel type, and transmission
- **Pricing & Mileage Analysis:** Relationship between price, mileage, and other vehicle attributes
- **Sales Performance:** Factors differentiating 'High' and 'Low' sales volume classifications

## 📈 Data Exploration

The dataset was explored, cleaned, and validated. Key characteristics of the data include:

- **5,000 sales records** from 2010 to 2024
- **11 attributes** per record, including categorical (Model, Region) and numerical (Price, Mileage) data
- Data was checked for consistency; no major missing values or duplicates were found
- Features like `Engine_Size_L`, `Mileage_KM`, and `Price_USD` showed logical distributions, with newer models and high-performance variants at the higher end of the price spectrum

## 📋 Analysis Highlights

### 1. **Temporal Sales Trends**
- Sales volume has shown fluctuations over the years, with noticeable peaks for new model launches (e.g., i8 in 2014-2015, X3 refresh around 2017-2018)
- A significant **increase in the adoption of Electric and Hybrid vehicles** is evident post-2020, highlighting a strategic shift in BMW's portfolio and consumer demand

### 2. **Regional Market Dominance**
- **North America** and **Asia** are the largest markets for BMW, accounting for the highest volume of sales, particularly for the flagship **5 Series** and **X5** SUV
- **Europe** shows a stronger preference for **Diesel** engines and smaller models like the **1 Series** and **3 Series**
- The **Middle East** exhibits a high concentration of luxury models like the **7 Series** and high-performance **M5**

### 3. **Product Performance & Pricing**
- **Best-Selling Models:** The **5 Series** and **X3** are the consistent volume leaders, forming the backbone of BMW's sales
- **High-Performance Segment:** The **M-Series (M3, M5)** commands a significant price premium but operates in a lower volume niche
- **Electric & Hybrid Niche:** The **i-Series (i3, i8)**, while lower in volume, represents BMW's early foothold in the electric luxury segment, with the i8 achieving high sales prices as a halo car

### 4. **Customer Preferences**
- **Fuel Type:** **Petrol** is the dominant fuel type, but **Hybrid** and **Electric** powertrains are the fastest-growing segments
- **Transmission:** **Automatic transmissions** are overwhelmingly preferred over manual gearboxes across all regions (~75% of sales)
- **Color:** **White, Black, and Grey** are the most popular exterior colors globally, representing a preference for neutral and classic tones

### 5. **Pricing & Mileage Insights**
- A clear **negative correlation exists between `Mileage_KM` and `Price_USD`**. Higher mileage directly correlates with lower resale value
- **Larger engine sizes** and **newer model years** are the strongest positive influencers on vehicle price
- The **7 Series** and **i8** have the highest average selling prices, reflecting their luxury and technology positioning

### 6. **'High' vs. 'Low' Sales Classification**
- Models classified with **'High' sales volume** are typically:
  - Core models (3, 5 Series, X3, X1)
  - Equipped with popular fuel types for their region
  - Priced in the mid-range for their segment
  - Newer (lower average mileage)

## 🎯 Project Conclusion

**BMW's success is built on a balanced portfolio that caters to diverse global markets.** The core **5 Series** and **X3** models are the undisputed volume champions, providing stable revenue. The analysis confirms a strong and growing market for **SUV (X-Models)** and **performance vehicles (M-Series)**.

**The most critical strategic insight is the undeniable electrification of the fleet.** The rising sales of **Electric and Hybrid** vehicles, even in their early stages, signal a fundamental market shift that BMW is well-positioned to capitalize on with its evolving i-Series and upcoming electric models.
