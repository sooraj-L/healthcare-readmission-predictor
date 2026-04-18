# 🏥 Healthcare Patient Readmission Predictor

An end-to-end data analytics project predicting 30-day hospital readmissions using real clinical data from 130 US hospitals.

---

## 📌 Problem Statement
Hospital readmissions within 30 days cost the US healthcare system billions annually. This project identifies high-risk patients before discharge — enabling early intervention and better outcomes.

---

## 📊 Dataset
- **Source:** Diabetes 130-US Hospitals (UCI / Kaggle)
- **Records:** 101,763 patient visits
- **Period:** 1999–2008
- **Features:** 50 clinical attributes

---

## 🛠️ Tools Used
| Tool | Purpose |
|------|---------|
| Python (Pandas, Seaborn, Scikit-learn) | Cleaning, EDA, Modeling |
| SQL (SQLiteOnline) | Data exploration |
| Excel | Initial cleaning & pivot tables |
| Power BI | Interactive dashboard |

---

## 🔍 Key Findings
- **Visit frequency** is the strongest predictor — patients with 7+ visits are **8x more likely** to be readmitted
- **Age 20-30** had the highest readmission rate (14.2%) — contrary to expectations
- **Insulin dose reduction** linked to highest readmission rates
- **Race** is NOT a meaningful predictor (8-11% across all groups)

---

## 🤖 Model Performance
| Model | Recall (High-Risk) | AUC-ROC |
|-------|-------------------|---------|
| Logistic Regression | 4% | 0.71 |
| LR + Balanced | 53% | 0.73 |
| Random Forest | 2% | 0.74 |
| **RF + Depth Limit ✅** | **80%** | **0.77** |

> Deliberately prioritized recall over accuracy — in healthcare, missing a high-risk patient is far more costly than a false alarm.

---

## 📁 Project Structure
healthcare-readmission-predictor/
│
├── Hospital_Project_Working.ipynb   # Python code (cleaning, EDA, modeling)
├── cleaned_hospital_data.csv        # Cleaned dataset
├── feature_importance.csv           # Model feature importance scores
├── model_predictions.csv            # Test set predictions
├── Hospital_Readmission_Dashboard.pbix  # Power BI dashboard
└── Healthcare_Readmission_Project_Report.docx  # Full project report

## 🚀 How to Run
1. Clone this repository
2. Download the raw dataset from [Kaggle](https://www.kaggle.com/datasets/brandao/diabetes)
3. Open `Hospital_Project_Working.ipynb` in Jupyter Notebook
4. Run all cells in order
5. Open `Hospital_Readmission_Dashboard.pbix` in Power BI Desktop

---

## 💡 Key Insight
> Total visit history alone accounts for 62% of the model's decision making — the single most powerful question is: how many times has this patient been here before?
