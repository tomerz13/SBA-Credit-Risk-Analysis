USE SBA_Credit_Risk; 
GO

-- ==============================================================================
-- Query 05: Riskiest Industries per State (Window Functions & CTE)
-- Purpose: Identify the top 3 highest-risk industries within each US State.
--          Demonstrates advanced SQL skills using Common Table Expressions (CTE) 
--          and Window Functions (RANK) for localized risk assessment.
-- ==============================================================================

-- Step 1: Calculate default rates per state and industry
WITH StateIndustryRisk AS (
    SELECT 
        Borrower_State,
        Industry_Description,
        COUNT(*) AS Total_Loans,
        SUM(CASE WHEN Loan_Status = 'CHGOFF' THEN 1 ELSE 0 END) AS Defaulted_Loans,
        ROUND(
            CAST(SUM(CASE WHEN Loan_Status = 'CHGOFF' THEN 1 ELSE 0 END) AS FLOAT) 
            / COUNT(*) * 100, 2
        ) AS Default_Rate_Percentage
    FROM 
        vw_clean_loan_data
    WHERE 
        Borrower_State IS NOT NULL
    GROUP BY 
        Borrower_State, 
        Industry_Description
    -- Focus on meaningful data (at least 50 loans per industry within a specific state)
    HAVING 
        COUNT(*) > 50 
),

-- Step 2: Rank the industries within each state based on default rate
RankedStateRisk AS (
    SELECT *,
        RANK() OVER(
            PARTITION BY Borrower_State 
            ORDER BY Default_Rate_Percentage DESC
        ) AS Risk_Rank
    FROM 
        StateIndustryRisk
)

-- Step 3: Filter to show only the top 3 riskiest industries per state
SELECT 
    Borrower_State,
    Risk_Rank,
    Industry_Description AS Riskiest_Industry,
    Total_Loans,
    Defaulted_Loans,
    Default_Rate_Percentage
FROM 
    RankedStateRisk
WHERE 
    Risk_Rank <= 3
ORDER BY 
    Borrower_State ASC, 
    Risk_Rank ASC;