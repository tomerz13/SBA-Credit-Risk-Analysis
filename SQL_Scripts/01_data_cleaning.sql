USE SBA_Credit_Risk; 
GO

-- ==============================================================================
-- View 01: Clean Base Data (vw_clean_loan_data)
-- Purpose: Create a reusable, clean view of the dataset. 
--          Performs sequential filtering: keeps only major banks (>500 loans), 
--          and then keeps only industries with significant volume (>100 loans).
--          Handles missing values and casts text to numeric data types.
-- ==============================================================================
CREATE OR ALTER VIEW vw_clean_loan_data AS

-- Step 1: Calculate loan volume per bank on the entire dataset
WITH BankVolume AS (
    SELECT 
        BorrName, BorrState, BankName, NaicsCode, NaicsDescription, 
        TermInMonths, BusinessAge, GrossApproval, GrossChargeOffAmount, LoanStatus,
        COUNT(BankName) OVER (PARTITION BY BankName) AS Bank_Total_Loans
    FROM 
        loan_data_2010_2019
    WHERE 
        LoanStatus IN ('P I F', 'CHGOFF') AND NaicsCode IS NOT NULL
),

-- Step 2: Filter and keep only major commercial banks
FilteredBanks AS (
    SELECT *
    FROM BankVolume
    WHERE Bank_Total_Loans >= 500
),

-- Step 3: Recalculate industry volume ONLY for the surviving banks
IndustryVolume AS (
    SELECT 
        *,
        COUNT(NaicsCode) OVER (PARTITION BY NaicsCode) AS Industry_Total_Loans
    FROM FilteredBanks
)

-- Step 4: Final selection, data cleaning, and industry filtering
SELECT 
    BorrName AS Borrower_Name,
    BorrState AS Borrower_State,
    BankName AS Bank_Name,
    NaicsCode AS NAICS_Code,
    NaicsDescription AS Industry_Description,
    CAST(CAST(TermInMonths AS FLOAT) AS INT) AS Loan_Term_Months,
    COALESCE(BusinessAge, 'Unknown') AS Business_Maturity,
    CAST(GrossApproval AS FLOAT) AS Approved_Amount,
    CAST(GrossChargeOffAmount AS FLOAT) AS Charge_Off_Amount,
    LoanStatus AS Loan_Status
FROM 
    IndustryVolume
WHERE 
    Industry_Total_Loans >= 100;
GO