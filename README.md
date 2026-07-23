# Marketing_Analytics_Project
# Marketing Performance & Customer Analytics Platform

End-to-end marketing analytics project: customer segmentation, campaign response analysis, and predictive modeling using Python, SQL, and data visualization.

## Business Problem

A retail company ran 6 marketing campaigns targeting 2,212 customers but only converts **15%** of them on average. The business needs to know:
- Which customers are worth targeting in the next campaign
- What actually drives a customer to respond to an offer
- How to segment the customer base for more efficient marketing spend

## Dataset

[Customer Personality Analysis](https://www.kaggle.com/datasets/imakash3011/customer-personality-analysis) — 2,240 customers with demographics, purchase history across 6 product categories, purchase channels, and response history to 6 marketing campaigns.

## Project Structure

```
├── data/
│   ├── marketing_campaign.csv                  # raw data
│   ├── marketing_campaign_cleaned.csv          # cleaned + feature engineered
│   └── marketing_campaign_with_segments.csv    # + RFM segments
├── scripts/
│   ├── 01_eda.py                  # initial data exploration
│   ├── 02_clean_features.py       # cleaning + feature engineering
│   ├── 03_marketing_kpis.py       # campaign & channel KPI analysis
│   ├── 04_response_model.py       # predictive model (Random Forest)
│   ├── 05_rfm_segmentation.py     # RFM customer segmentation
│   └── 06_visualizations.py       # chart generation
├── sql/
│   └── marketing_analysis.sql     # 10 business-question SQL queries
├── visuals/                       # 6 exported charts (PNG)
└── outputs/
    └── feature_importance.csv
```

## Methodology

**1. Data Cleaning** — Removed 24 rows with missing income, 1 income outlier ($666K), invalid birth years; normalized inconsistent marital-status labels; parsed enrollment dates into customer tenure.

**2. Feature Engineering** — Built `Total_Spend`, `Total_Purchases`, `Total_Children`, `Customer_Tenure_Days`, and campaign-loyalty count across the 6 historical campaigns.

**3. Marketing KPI Analysis (SQL + Python)** — Response rate broken down by income, household composition, education, marital status, recency, and purchase channel.

**4. RFM Segmentation** — Customers scored on Recency, Frequency, and Monetary value into 5 segments: Champions, Loyal Customers, Potential Loyalists, At Risk, Hibernating.

**5. Predictive Modeling** — Random Forest classifier to predict campaign response, benchmarked against a Logistic Regression baseline.

## Key Findings

| Insight | Detail |
|---|---|
| Income drives response | High-income customers respond at **27%** vs **10%** for mid/low income |
| Children reduce response | Households with 0 children respond at **26.6%** vs **4–11%** with 1+ children |
| Recency matters | Customers active in the last 25 days respond at **26.2%** vs **7.3%** for 76–99 days |
| Spend predicts loyalty | Campaign responders spend **$986** on average vs **$540** for non-responders |
| Most campaigns underperform | Campaigns 1–5 converted at 1.4%–7.4%; only the most recent campaign hit 15.1% |
| 72.7% never respond | Nearly 3 in 4 customers have not accepted a single campaign in 6 attempts — a major re-targeting opportunity |

## Model Performance

| Model | Accuracy | ROC-AUC |
|---|---|---|
| Baseline (majority class) | 85.0% | — |
| Logistic Regression | 83.0% | 0.793 |
| **Random Forest** | 83.0% | **0.847** |

Top predictive features: **Total Spend, Customer Tenure, Recency, Income, Catalog Purchases** — confirming that engagement history and financial capacity outweigh demographics (age, education) in predicting response.

## Customer Segments (RFM)

| Segment | Customers | Avg Income | Avg Spend | Response Rate |
|---|---|---|---|---|
| Champions | 529 | $69,834 | Highest | 29.9% |
| Loyal Customers | 637 | $61,128 | High | 16.3% |
| Potential Loyalists | 510 | $40,838 | Medium | 10.2% |
| At Risk | 420 | $33,902 | Low | 4.3% |
| Hibernating | 116 | $34,367 |
