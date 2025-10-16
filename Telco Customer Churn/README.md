# Telco Customer Churn Analysis Project

## 📊 Project Overview
This project analyzes customer churn patterns for a telecommunications company. The analysis identifies key factors contributing to customer attrition and develops predictive models to help the company reduce churn rates and improve customer retention strategies.

## 🎯 Project Scope
The analysis covers multiple dimensions of customer churn:
- **Demographic Analysis**: Customer tenure, senior citizen status, and partner/dependents
- **Service Usage**: Internet service types, phone services, and additional features
- **Billing Patterns**: Monthly charges, total charges, and payment methods
- **Contract Analysis**: Contract types and their impact on retention
- **Predictive Modeling**: Machine learning models to predict churn probability
- **Feature Importance**: Identifying strongest predictors of customer attrition

## 🛠️ Tools and Technologies
- **Python**: Primary programming language for data analysis
- **Pandas**: Data manipulation and cleaning
- **NumPy**: Numerical computations
- **Matplotlib & Seaborn**: Data visualization
- **Scikit-learn**: Machine learning modeling and evaluation
- **Jupyter Notebook**: Interactive development environment

## 📈 Data Exploration

### Dataset Characteristics
- **Rows**: 7,043 customer records (after cleaning)
- **Columns**: 21 attributes including customer demographics, services, and account information
- **Target Variable**: Churn (Yes/No)

### Key Data Cleaning Steps
- Handled missing values in TotalCharges column
- Converted TotalCharges to numeric data type
- Encoded categorical variables for machine learning
- Standardized numerical features for model convergence

### Core Metrics Calculated
- Overall Churn Rate: 26.6%
- Churn by Contract: Month-to-month (42.7%), Two year (2.8%)
- Churn by Payment: Electronic check (45.3%), Mailed check (19.2%)
- Model Performance: Random Forest AUC: 0.84, Logistic Regression AUC: 0.82

## 📋 Analysis Highlights

### 1. Contract Type Impact
- Month-to-month contracts showed highest churn rate (42.7%)
- Two-year contracts had lowest churn rate (2.8%)
- One-year contracts showed moderate churn (11.3%)

### 2. Payment Method Analysis
- Electronic check users had highest churn (45.3%)
- Automatic payment methods showed significantly lower churn
- Mailed checks showed moderate churn rates (19.2%)

### 3. Service Usage Patterns
- Fiber optic internet users showed higher churn than DSL users
- Customers with additional services (Online Security, Tech Support) had lower churn
- Phone service alone showed moderate impact on churn

### 4. Financial Factors
- Higher monthly charges correlated with increased churn risk
- Lower total charges (newer customers) showed higher churn rates
- Long-term customers (high total charges) showed better retention

### 5. Demographic Insights
- Senior citizens showed slightly higher churn rates
- Customers with partners and dependents showed better retention
- Tenure strongly negatively correlated with churn

## 🎯 Project Conclusion
The telco churn analysis reveals several critical insights:
1. **Contract Stability**: Long-term contracts significantly reduce churn risk
2. **Payment Convenience**: Automated payment methods improve retention
3. **Service Bundles**: Additional services increase customer stickiness
4. **Customer Tenure**: Longer-tenured customers are less likely to churn
5. **Predictive Power**: Machine learning models can effectively identify at-risk customers
