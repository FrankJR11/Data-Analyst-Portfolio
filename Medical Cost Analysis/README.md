# Medical Cost Personal Dataset Analysis

## Brief Background

The Medical Cost Personal Dataset is a collection of individual medical insurance billing records that includes demographic information, lifestyle factors, and geographic data along with corresponding medical charges. This dataset is commonly used for predictive modeling and analysis of healthcare costs, helping to understand the factors that drive medical expenses and enabling better risk assessment in the insurance industry.

## 📊 Project Overview

This project involves a comprehensive analysis of medical insurance charges data to identify key factors influencing healthcare costs. The dataset contains 1,338 records with 7 features including age, sex, BMI, number of children, smoking status, region, and insurance charges. The analysis aims to uncover patterns and relationships that can help understand what drives medical expenses and support data-driven decision making in healthcare pricing and risk assessment.

## 🎯 Project Scope

- **Data Exploration**: Comprehensive examination of dataset structure, distributions, and basic statistics
- **Demographic Analysis**: Investigation of how age, gender, and region affect medical costs
- **Lifestyle Factors**: Analysis of BMI and smoking status impact on charges
- **Family Structure**: Examination of how number of children influences medical expenses
- **Correlation Analysis**: Identification of relationships between different variables
- **Cost Drivers**: Determination of primary factors contributing to higher medical charges

## 📈 Data Exploration

### Dataset Structure
- **Total Records**: 1,338 individuals
- **Features**: 7 variables including charges as the target variable
- **Data Types**: Mixed (numerical and categorical)
- **Key Variables**:
  - Age: 18-64 years
  - BMI: 16.6-53.1 kg/m²
  - Children: 0-5 dependents
  - Charges: $1,121-$63,770

### Key Statistics
- **Average Age**: ~39 years
- **Average BMI**: ~30.6 (borderline obese)
- **Average Charges**: $13,270
- **Smoker Distribution**: 20% smokers, 80% non-smokers
- **Regional Distribution**: Relatively balanced across four US regions

## 📋 Analysis Highlights

### 1. Smoking Impact
- **Smokers pay 3-4x more** than non-smokers on average
- Highest individual charge: $63,770 (smoker with high BMI)
- Smoking is the single most significant cost driver

### 2. Age Correlation
- Strong positive correlation between age and charges
- Older individuals (55+) typically have charges 2-3x higher than younger individuals (18-25)

### 3. BMI Influence
- BMI > 30 (obese range) associated with 20-30% higher charges
- Extreme BMI values (<18 or >35) show significantly higher medical costs

### 4. Regional Variations
- Southeast region shows highest average charges
- Regional differences are moderate compared to lifestyle factors

### 5. Demographic Factors
- Gender shows minimal difference in charges
- Number of children has limited impact on overall costs

### 6. Interaction Effects
- Older smokers face the highest medical costs
- High BMI combined with smoking creates exponential cost increases

## 🎯 Project Conclusion

The analysis reveals that **lifestyle factors**, particularly **smoking status**, are the most significant drivers of medical insurance costs, far outweighing demographic factors like age, gender, or region. The key findings indicate:

1. **Smoking is the primary cost driver**, increasing medical charges by 300-400% on average
2. **Age is strongly correlated** with higher medical expenses, reflecting increased healthcare needs over time
3. **BMI plays a moderate role**, with obese individuals facing 20-30% higher costs
4. **Regional differences exist** but are secondary to lifestyle factors
5. **Gender and number of children** have minimal impact on insurance charges
