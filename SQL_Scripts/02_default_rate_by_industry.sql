USE SBA_Credit_Risk; 
GO

-- ==============================================================================
-- Query 02: Default Rate by Industry (Risk Analysis)
-- Purpose: Identify the highest-risk industries by calculating the default rate 
--          (Charge-Off percentage) for each sector.
-- Note:    This query leverages the 'vw_clean_loan_data' view, which already 
--          handles data type casting, renaming, and base filtering.
-- ==============================================================================

SELECT TOP 20
    Industry_Description,
    
    -- 1. Total volume of finalized loans issued to this industry
    COUNT(*) AS Total_Loans,
    
    -- 2. Number of loans that failed (Charged Off)
    SUM(CASE WHEN Loan_Status = 'CHGOFF' THEN 1 ELSE 0 END) AS Defaulted_Loans,
    
    -- 3. Calculate the Default Rate (%)
    ROUND(
        CAST(SUM(CASE WHEN Loan_Status = 'CHGOFF' THEN 1 ELSE 0 END) AS FLOAT) 
        / COUNT(*) * 100, 2
    ) AS Default_Rate_Percentage,
    
    -- 4. Calculate the total financial loss for this industry
    SUM(CASE WHEN Loan_Status = 'CHGOFF' THEN Charge_Off_Amount ELSE 0 END) AS Total_Financial_Loss

FROM 
    vw_clean_loan_data

GROUP BY 
    Industry_Description

ORDER BY 
    Default_Rate_Percentage DESC;