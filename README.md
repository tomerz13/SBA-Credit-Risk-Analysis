# Commercial Credit Risk Analytics: SBA Loan Default Analysis🏦💰

## Executive Summary:
Using SQL Server and Power BI, I extracted and transformed historical SBA commercial loan data (2010–2019) to create an interactive dashboard tracking credit risk and loan defaults. After identifying that the largest financial risks stem from specific anomalous lenders and highly volatile industries—resulting in $3.46bn in total financial losses—I recommend that the risk management team implements targeted underwriting adjustments and stricter credit controls to minimize future exposure.

## Business Problem:
Financial institutions face significant capital risk when issuing commercial loans. While the SBA guarantees a portion of these loans, banks still absorb substantial losses when businesses default (`Charged Off`). How can we determine which industry sectors (NAICS), loan durations, and lending institutions present the highest default risks to make proactive adjustments to underwriting approvals and minimize financial exposure?

<img width="1024" height="572" alt="image" src="https://github.com/user-attachments/assets/73e828f1-d534-41dd-aea2-e0700ea671a1" />


## Methodology (Skills):
* **SQL Server (T-SQL):** Common Table Expressions (CTEs), Window Functions (`RANK() OVER`, `COUNT OVER PARTITION BY`), Data Cleaning, and `COALESCE` for missing values. Developed a robust Data Engineering pipeline using **Sequential Filtering** to first isolate major commercial banks (>500 loans) and then recalculate industry volumes strictly within that cohort (>100 loans) to eliminate statistical noise.
* **Power BI:** Data visualization, interactive filtering, dynamic conditional formatting (highlighting risks >8%), and custom financial formatting for executive presentation.

## Results & Business Recommendation:
Creating this dashboard gives risk managers and financial stakeholders clear visibility into the commercial loan portfolio's vulnerabilities. This analysis showed us that total financial losses reached $3.46bn across the analyzed cohort. Furthermore, we identified significant variance in underwriting quality among top commercial banks, with Independence Bank exhibiting an anomalous ~60% default rate.

Because the biggest financial impacts will come from reducing exposure to these high-risk areas, I recommend a few business adjustments:
1. **Audit High-Risk Lenders:** Initiate an immediate review of the loan approval workflows for lenders with default rates significantly exceeding the baseline (e.g., Independence Bank).
2. **Tighten Industry Controls:** Implement stricter underwriting criteria for the top 3 highest-risk industries identified within each state.
3. **Adjust Term Limits:** Restructure loan term offerings based on the duration analysis, as loan length heavily impacts repayment success.

I believe these adjustments will best tackle the largest sources of financial loss, optimize the loan portfolio, and save the risk analytics team hours per week in ad-hoc exposure reporting.

## Next Steps:
1. Incorporate macroeconomic indicators (e.g., historical interest rates, state GDP growth) to analyze how broader economic cycles impact SBA default rates.
2. Build a predictive machine learning model in Python (Scikit-Learn) to forecast the probability of default for incoming loan applications.
3. Conduct user testing with risk managers to refine dashboard layout and ensure optimal UI/UX for daily monitoring.
