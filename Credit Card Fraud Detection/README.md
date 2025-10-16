# Credit Card Fraud Detection Project

## 📊 Project Overview
This project focuses on detecting fraudulent credit card transactions using machine learning techniques. The analysis addresses the significant class imbalance problem typical in fraud detection datasets and develops a robust model to identify fraudulent activities with high precision while minimizing false positives.

## 🎯 Project Scope
The analysis covers the complete fraud detection pipeline:
- **Data Preprocessing**: Handling missing values, scaling features, and data cleaning
- **Exploratory Data Analysis**: Understanding distributions and correlations
- **Class Imbalance Handling**: Implementing undersampling techniques
- **Model Development**: Building and evaluating multiple machine learning models
- **Feature Importance**: Identifying key predictors of fraudulent transactions
- **Performance Evaluation**: Assessing model effectiveness using appropriate metrics

## 🛠️ Tools and Technologies
- **Python**: Primary programming language for data analysis
- **Pandas**: Data manipulation and cleaning
- **NumPy**: Numerical computations
- **Matplotlib & Seaborn**: Data visualization
- **Scikit-learn**: Machine learning modeling and evaluation
- **Jupyter Notebook**: Interactive development environment
- **RobustScaler**: For handling outliers in financial data

## 📈 Data Exploration

### Dataset Characteristics
- **Rows**: 4,000 transaction records
- **Columns**: 31 attributes (28 anonymized features + Time, Amount, Class)
- **Target Variable**: Class (0: Normal, 1: Fraud)
- **Class Distribution**: Highly imbalanced (typical of fraud datasets)

### Key Data Cleaning Steps
- Scaled 'Time' and 'Amount' features using RobustScaler
- Handled potential missing values and duplicates
- Moved target variable to end for clarity
- Prepared data for machine learning algorithms

### Core Metrics Calculated
- Fraud Percentage: 0.6% (typical imbalance for fraud detection)
- Top Correlated Features: Identified V4, V11 (positive), V14, V17 (negative)
- Model Performance: Logistic Regression achieved strong detection capabilities

## 📋 Analysis Highlights

### 1. Data Preprocessing
- Applied RobustScaler to handle outliers in 'Time' and 'Amount' features
- Maintained anonymized features (V1-V28) which are PCA-transformed for privacy
- Ensured proper data formatting for machine learning algorithms

### 2. Correlation Analysis
- Identified strong positive correlations: V4 (0.43), V11 (0.35) with fraud
- Identified strong negative correlations: V14 (-0.41), V17 (-0.33) with fraud
- Created visualizations to understand feature relationships

### 3. Class Imbalance Handling
- Implemented strategic undersampling of majority class
- Balanced training data to improve model sensitivity to fraud patterns
- Maintained original test set distribution for realistic evaluation

### 4. Model Development
- Built Logistic Regression model with balanced class weighting
- Achieved strong performance metrics on imbalanced test data
- Generated probability scores for nuanced fraud detection

### 5. Feature Importance
- V4 identified as strongest positive predictor of fraud
- V14 identified as strongest negative predictor (protective factor)
- Comprehensive feature importance analysis guided model interpretation

## 🎯 Project Conclusion
The credit card fraud analysis achieved several key outcomes:
1. **Effective Data Preparation**: Successfully handled the unique challenges of financial transaction data
2. **Imbalance Management**: Implemented appropriate sampling techniques for rare fraud detection
3. **Strong Model Performance**: Developed a model capable of identifying fraudulent transactions
4. **Actionable Insights**: Identified key features that signal fraudulent activity
5. **Robust Framework**: Established a reproducible pipeline for fraud detection
