# Commercial Credit Risk Analytics: SBA Loan Default Analysis

## 1. Executive Summary
This project analyzes historical Small Business Administration (SBA) 7(a) commercial loans to identify patterns of credit risk and default. By evaluating borrower profiles, loan terms, and industry sectors, this analysis provides data-driven recommendations to strengthen underwriting processes, optimize loan portfolios, and minimize financial exposure to charged-off loans.

## 2. Business Problem
Financial institutions face significant capital risk when issuing commercial loans. While the SBA guarantees a portion of these loans, banks still absorb substantial losses when businesses default (`Charged Off`). The objective of this project is to build an analytical framework that answers critical business questions:
* Which industry sectors (NAICS) present the highest default risks?
* How do loan duration (`TermInMonths`) and business maturity (`BusinessAge`) correlate with repayment success?
* Which lending institutions exhibit systemic weaknesses in their underwriting approvals?

## 3. Data Source
* **Dataset:** Official U.S. SBA 7(a) FOIA Loan Data (FY2020-Present).
* **Source:** U.S. Government Open Data Portal (Data.gov).
* **Target Variable:** `LoanStatus` (Paid In Full vs. Charged Off).

## 4. Methodology
* **Data Engineering (SQL):** Extracted, cleaned, and transformed raw governmental data. Filtered active/cancelled loans to isolate realized outcomes, handled missing values, and standardized industry codes.
* **Exploratory Data Analysis (SQL):** Aggregated default rates by industry, geography, and loan term using Common Table Expressions (CTEs) and Window Functions.
* **Data Visualization (Power BI):** Developed an interactive Credit Risk Dashboard enabling risk managers to filter exposure metrics dynamically.

## 5. Key Findings & Business Recommendations
*(To be updated upon completion of the SQL analysis)*
* **Insight 1:** [Placeholder for finding] -> **Recommendation:** [Placeholder for business action]
* **Insight 2:** [Placeholder for finding] -> **Recommendation:** [Placeholder for business action]
* **Insight 3:** [Placeholder for finding] -> **Recommendation:** [Placeholder for business action]

## 6. Dashboard Preview
*(Screenshot of the final Power BI dashboard will be inserted here)*
