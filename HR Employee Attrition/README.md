# HR Employee Attrition Analysis Project

## 📊 Project Overview
This project presents a comprehensive analysis of employee attrition patterns using HR data. The analysis identifies key factors contributing to employee turnover and provides actionable insights to help organizations develop effective retention strategies and reduce attrition costs.

## 🎯 Project Scope
The analysis covers multiple dimensions of employee attrition:
- **Demographic Analysis**: Age, marital status, gender, and education level impacts
- **Job-Related Factors**: Role, department, job satisfaction, and work-life balance
- **Compensation Analysis**: Monthly income, salary hikes, and financial incentives
- **Career Development**: Promotion history, years in role, and growth opportunities
- **Work Environment**: Overtime requirements, distance from home, and manager relationships
- **Correlation Analysis**: Identifying strongest predictors of attrition

## 🛠️ Tools and Technologies
- **Python**: Primary programming language for data analysis
- **Pandas**: Data manipulation and cleaning
- **NumPy**: Numerical computations
- **Matplotlib & Seaborn**: Data visualization
- **Jupyter Notebook**: Interactive development environment
- **CSV**: Data storage format

## 📈 Data Exploration

### Dataset Characteristics
- **Rows**: 1,470 employee records
- **Columns**: 35 attributes including demographic, job-related, and behavioral data
- **Target Variable**: Attrition (Yes/No)

### Key Data Cleaning Steps
- Handled missing values and inconsistent data types
- Converted categorical columns to appropriate data types
- Created derived features for enhanced analysis
- Standardized column names and values

### Core Metrics Calculated
- Overall Attrition Rate: 16.1%
- Attrition by Department: Highest in Sales (20.6%)
- Attrition by Role: Highest in Laboratory Technicians (23.8%)
- Key Correlations: Strongest with overtime, monthly income, and years at company

## 📋 Analysis Highlights

### 1. Demographic Patterns
- Younger employees (25-35) show highest attrition rates
- Single employees have significantly higher attrition than married counterparts
- Males show slightly higher attrition rates than females

### 2. Job Role Analysis
- Laboratory Technicians showed highest attrition rate (23.8%)
- Sales Representatives followed closely (20.0%)
- Research Directors showed lowest attrition (2.9%)

### 3. Compensation Impact
- Employees with lower monthly income (<$5,000) showed highest attrition
- Higher income brackets (>$10,000) showed minimal attrition
- Percent salary hike showed weak correlation with attrition

### 4. Career Development Factors
- Employees without promotions in 5+ years showed 3x higher attrition
- Years in current role negatively correlated with attrition
- Limited growth opportunities strongly predicted turnover

### 5. Work Environment
- Employees working overtime showed 2.5x higher attrition
- Longer distance from home correlated with higher attrition
- Poor relationships with current manager predicted turnover

### 6. Correlation Insights
- Strongest positive correlations: Overtime, DistanceFromHome
- Strongest negative correlations: MonthlyIncome, Age, TotalWorkingYears
- YearsWithoutPromotion showed moderate positive correlation (0.32)

## 🎯 Project Conclusion
The HR attrition analysis reveals several critical insights:
1. **Financial Factors**: Lower monthly income is the strongest predictor of attrition
2. **Work-Life Balance**: Overtime requirements significantly increase turnover risk
3. **Career Stagnation**: Lack of promotions and growth opportunities drive attrition
4. **Demographic Patterns**: Younger, single employees are most likely to leave
5. **Department Variations**: Sales and Research departments show highest attrition rates
