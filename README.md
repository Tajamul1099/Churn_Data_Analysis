# 📉 Customer Churn Analysis

**Turning raw customer records into churn, revenue, and retention insights — using Python, SQL, and Power BI.**

![Python](https://img.shields.io/badge/Python-3.10-3776AB?logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Wrangling-150458?logo=pandas&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-Database-4479A1?logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi&logoColor=black)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-F37626?logo=jupyter&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

---

## 📌 About This Project

I built this project to answer a question every subscription-based business eventually has to ask: **who is actually churning, and is retention spend going to the right places?**

I ran it as a full analytics workflow, not a single-tool exercise — starting in **Python** to clean a messy raw customer export, moving into **MySQL** to answer structured business questions with SQL, and finishing in **Power BI** to package everything into an interactive dashboard a non-technical stakeholder could use to make decisions.

The goal wasn't just to report a churn rate — it was to find out *which* segments were churning more than they should, including a few results that go against the assumptions most churn programs are built on.

---

## 🎯 Business Problem

A subscription-based service provider was losing a meaningful share of its customer base, without a clear view of who was driving it:

- 📉 **23.7% overall churn rate** across the customer base, with no segmentation to explain it
- 💸 Churned customers were tied to **22% of total revenue** — a real, measurable loss, not a rounding error
- 🤔 Common assumptions (new customers churn most, long contracts retain best, tech support reduces churn) hadn't been tested against the actual data
- 🗺️ No visibility into whether churn was concentrated in specific contract types, subscription tiers, service types, or regions

**Objectives:**
1. Clean and standardize a messy raw customer export into an analysis-ready dataset
2. Quantify churn rate across contract type, subscription tier, service type, tenure, and geography
3. Identify which segments are contributing disproportionately to churn *and* revenue loss
4. Rule out factors that don't actually predict churn, so retention efforts aren't wasted on them
5. Package findings into a dashboard stakeholders can filter and act on directly

---

## 🧰 Tech Stack

| Layer | Tools |
|---|---|
| **Data Wrangling** | Python, Pandas, NumPy |
| **Database** | MySQL, SQLAlchemy |
| **Querying** | SQL (aggregations, `GROUP BY`, `ORDER BY`, filtering) |
| **Business Intelligence** | Power BI (DAX measures, interactive slicers) |
| **Environment** | Jupyter Notebook |

---

## 🔄 Project Workflow

```
Raw Excel export (Churn_Unclean_Project.xlsx)
        │
        ▼
Python (Pandas) → clean, standardize, engineer features
        │
        ▼
MySQL (SQLAlchemy) → load cleaned data into `customer_churn` table
        │
        ▼
SQL → answer structured churn & revenue questions
        │
        ▼
Power BI → interactive churn dashboard
        │
        ▼
Business Insights & Recommendations
```

---

## 🧹 Data Cleaning (Python)

The raw file had duplicate rows, inconsistent text casing, stray whitespace, invalid ages, and missing values. The notebook (`Churn_Analysis.ipynb`) handles:

- Removing duplicate records
- Standardizing text fields (names, states, cities, contract/subscription types) with `.str.strip()` and `.str.title()`
- Converting numeric fields and filtering invalid ages (18–100) and negative charges
- Filling missing values (e.g. unknown payment method → `"Unknown"`, missing tech support → `"No"`)
- Engineering new fields: `Customer_Value` (`Monthly_Charges × Tenure_Months`), `Tenure_Group` (0–12 / 13–24 / 25–48 / 49–72 months), `Senior_Flag`, `Churn_Flag`
- Exporting the cleaned result to `Clean_Churn_Data.csv` and loading it into MySQL via SQLAlchemy

---

## 🧮 SQL Analysis

After loading the cleaned dataset into MySQL (`CUSTOMER_CHURN_DB.customer_churn`), I wrote queries to answer real retention questions — not just practice `SELECT` statements:

- 💰 What's the overall churn rate, and how does it compare across contract types?
- 📊 What's the average monthly charge and average tenure, and how do they differ by contract?
- 🌍 Which states have the highest churn, and which generate the most revenue?
- 💳 Does payment method or subscription type correlate with churn?
- 👴 Do senior citizens churn at a different rate than other customers?
- 💎 Who are the top 10 highest-value customers, and how many of them have churned?
- 🛠️ Which customers don't have tech support, and does that actually predict churn?

Full queries live in [`Customer_churn_analysis.sql`](./Customer_churn_analysis.sql).

---

## 📈 Power BI Dashboard

The final deliverable: an interactive dashboard (`Churn_Data_Analysis.pbix`) letting stakeholders filter by **Subscription Type**, with KPI cards, categorical churn breakdowns, and a state-level churn/revenue map.

**Headline KPIs:**

| Total Customers | Churned | Retained | Churn Rate | Total Revenue | Revenue at Risk |
|:---:|:---:|:---:|:---:|:---:|:---:|
| **442** | **105** | **335** | **23.%** | **₹2.19 Cr** | **₹54.5 L (22%)** |

The single most useful insight the dashboard surfaces: **Two-Year contracts churn more than Month-to-Month customers** — the opposite of what most retention strategies assume, meaning long-term contracts alone aren't a retention lever.

<img width="581" height="328" alt="Churn_analysis_dashboard" src="https://github.com/user-attachments/assets/36539193-1f2d-4a67-9ed5-c840686b95e8" />
<img width="583" height="329" alt="Churn_Analysis_insights" src="https://github.com/user-attachments/assets/4303d527-a41f-4873-9d13-ffa099944b0d" />

---

## 💡 Key Insights

- 🔁 **Two-Year contracts churn more (27.2%) than Month-to-Month (21.0%)** — long-term commitment isn't preventing churn here
- 🏷️ **Standard and Premium subscribers churn ~2x more than Basic** (27.8% and 26.5% vs. 16.2%)
- 📡 **Cable internet has the highest churn (29.7%)**; DSL the lowest (16.8%)
- ⏳ **Churn peaks in the 13–48 month tenure window (~28%)**, not in the first year — customers who pass 4 years rarely leave (13.9% churn)
- 🛠️ **Tech support access has almost no effect on churn** (23.9% vs. 23.3%) — ruled out as a driver, despite being a common retention assumption
- 🗺️ Highest state-level churn: **Uttar Pradesh (29%)**; lowest: **Maharashtra (18%)**
- 👪 Customers **with dependents churn more (26.6%)** than those without (20.4%)

---

## ✅ Recommendations

1. Investigate why Two-Year contract holders are churning at a higher rate than Month-to-Month — retention offers built around "lock-in" may need rethinking
2. Review pricing and perceived value on Standard and Premium tiers, where churn is nearly double Basic
3. Audit Cable service reliability/support quality given its outsized churn rate
4. Target retention outreach at the 13–48 month tenure window rather than only onboarding — that's where the actual risk is concentrated
5. Stop treating tech support access as a retention lever — the data shows no meaningful effect
6. Prioritize state-level retention investment in Uttar Pradesh, where churn is highest
7. Operationalize the Power BI dashboard as a recurring reporting tool for the retention team

---

## 📁 Repository Structure

```
customer-churn-analysis/
│
├── 📊 dashboard/
│ └── Churn_Data_Analysis.pbix # Power BI dashboard
│
├── 📁 data/
│ ├── Clean_Churn_Data.csv # Clean dataset
│ └── Churn_Unclean_Project.xlsx # Raw dataset
│
├── 📁 notebooks/
│ └── Churn_Analysis.ipynb # Data cleaning & EDA
│
├── 📁 sql/
│ └── Customer_churn_analysis.sql # SQL analysis queries
│
├── 📁 images/
│ ├── dashboard.png
│ └── insights.png
│
└── 📄 README.md
```

---

## 🧠 Skills Demonstrated

`Data Cleaning` `Feature Engineering` `Exploratory Data Analysis` `SQL (Aggregation & Filtering)` `Database Integration (SQLAlchemy)` `Power BI Dashboarding` `Business Storytelling` `Root-Cause Analysis`

---

## 👤 About Me

I'm a data analyst who enjoys taking a messy customer dataset and turning it into something a retention team can actually act on. This project reflects how I like to work: start with the business question, not the tool — and let the tool choice follow from what the problem actually needs.

📫 Feel free to connect or reach out if you'd like to talk through the approach, the SQL, or the dashboard design decisions.

⭐ If this project was useful or interesting to you, a star on the repo is always appreciated!
