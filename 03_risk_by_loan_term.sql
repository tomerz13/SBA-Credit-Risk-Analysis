USE SBA_Credit_Risk; 
GO

-- ==============================================================================
-- Query 03: Risk by Loan Term (Duration Analysis)
-- Purpose: Analyze how the length of the loan impacts the likelihood of default 
--          by categorizing loan terms into short, medium, and long-term buckets.
-- Note:    Utilizes 'vw_clean_loan_data' for pre-cleaned and formatted data.
-- ==============================================================================

SELECT 
    -- 1. Create Business Buckets for Loan Duration
    CASE 
        WHEN Loan_Term_Months < 60 THEN '1. Short Term (< 5 Years)'
        WHEN Loan_Term_Months BETWEEN 60 AND 120 THEN '2. Medium Term (5 - 10 Years)'
        WHEN Loan_Term_Months > 120 THEN '3. Long Term (> 10 Years)'
        ELSE 'Unknown'
    END AS Loan_Duration_Bucket,
    
    -- 2. Count Loans & Defaults
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Loan_Status = 'CHGOFF' THEN 1 ELSE 0 END) AS Defaulted_Loans,
    
    -- 3. Calculate Default Rate (%)
    ROUND(
        CAST(SUM(CASE WHEN Loan_Status = 'CHGOFF' THEN 1 ELSE 0 END) AS FLOAT) 
        / COUNT(*) * 100, 2
    ) AS Default_Rate_Percentage,
    
    -- 4. Calculate Financial Loss
    SUM(CASE WHEN Loan_Status = 'CHGOFF' THEN Charge_Off_Amount ELSE 0 END) AS Total_Financial_Loss

FROM 
    vw_clean_loan_data 

WHERE 
    -- Filter out anomalous data (e.g., loans recorded with 0 months)
    Loan_Term_Months > 0

GROUP BY 
    CASE 
        WHEN Loan_Term_Months < 60 THEN '1. Short Term (< 5 Years)'
        WHEN Loan_Term_Months BETWEEN 60 AND 120 THEN '2. Medium Term (5 - 10 Years)'
        WHEN Loan_Term_Months > 120 THEN '3. Long Term (> 10 Years)'
        ELSE 'Unknown'
    END

ORDER BY 
    Loan_Duration_Bucket;