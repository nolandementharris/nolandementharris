import sys

# check for pandas installation
try:
    import pandas as pd
except ImportError:
    print("------------------------------------------------------------")
    print("ERROR: The 'pandas' library is not installed.")
    print("To fix this in VS Code, run the following command in the terminal:")
    print("pip install pandas")
    print("------------------------------------------------------------")
    sys.exit(1)

# ==========================================
# 1. CONFIGURATION (Edit Weights Here)
# ==========================================
# Weights must sum to 1.0 (or be consistent relative to each other)
WEIGHT_LIKELIHOOD = 0.3
WEIGHT_SEVERITY   = 0.4
WEIGHT_IMPACT     = 0.3

# ==========================================
# 2. DATA DEFINITION
# ==========================================
# Format: [Category, Likelihood (L), Severity (S), Mission Impact (M)]
# Scales are 1-5 (5 being worst/most frequent)
risk_data = [
    ["EVA Related Dehydration",        5, 3, 2],
    ["Hypercapnia & Headaches (CO2)",  4, 4, 5],
    ["Upper Extremity Injury",         4, 3, 3],
    ["Lower Extremity Fracture",       3, 4, 5], # Severity 4 (Severe Injury), Impact 5 (Rescue)
    ["Decompression Sickness",         2, 4, 5],
    ["Severe Trauma (Head/Torso)",    1, 5, 5],
    ["Acute Cardiac Events",           1, 5, 5],
    ["Acute Radiation Syndrome",       2, 3, 4],
    ["Eye & Retinal Injury",           2, 4, 5],
    ["Nephrolithiasis (Kidney Stones)",3, 3, 5], # Severity 3 (Pain), Impact 5 (Abort)
    ["Motion Sickness",                2, 4, 5],
    ["Venous Thromboembolism",         1, 5, 5],
    ["Anaphylaxis",                    1, 5, 5],
    ["Acute Surgical Abdomen",         1, 4, 5],
    ["Gastrointestinal Distress",      3, 2, 2],
    ["Urinary Retention/Infection",    3, 2, 3],
    ["General Infections",             2, 2, 1]
]

def generate_risk_matrix():
    # Create DataFrame
    df = pd.DataFrame(risk_data, columns=["Condition", "Likelihood", "Severity", "Impact"])

    # Calculate Weighted Score
    # Formula: (L * W_L) + (S * W_S) + (M * W_M)
    df["Score"] = (
        (df["Likelihood"] * WEIGHT_LIKELIHOOD) +
        (df["Severity"]   * WEIGHT_SEVERITY) +
        (df["Impact"]     * WEIGHT_IMPACT)
    )

    # Sort by Score (Descending), then by Severity (Descending) as tie-breaker
    df_sorted = df.sort_values(by=["Score", "Severity"], ascending=[False, False])

    # Round score for display
    df_sorted["Score"] = df_sorted["Score"].round(2)

    return df_sorted

# ==========================================
# 3. MAIN EXECUTION
# ==========================================
if __name__ == "__main__":
    print("-" * 65)
    print(f"MARS EVA RISK PRIORITIZATION TOOL")
    print(f"Weights :: Likelihood: {WEIGHT_LIKELIHOOD} | Severity: {WEIGHT_SEVERITY} | Impact: {WEIGHT_IMPACT}")
    print("-" * 65)

    result = generate_risk_matrix()

    # formatting for nicer terminal output
    print(result.to_string(index=False, justify="left"))
    
    print("-" * 65)
    print(f"Top Priority Risk: {result.iloc[0]['Condition']} (Score: {result.iloc[0]['Score']})")
    print("-" * 65)
    
    # Keeps terminal open in VS Code if run as an external process
    input("\nPress Enter to exit...")