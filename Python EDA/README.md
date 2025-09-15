# **Exploratory Data Analysis: FBI NICS Firearm Background Check Data**

## **Context & Business Motivation**
Firearm background checks are a key indicator of gun sales and can serve as a proxy for public safety trends and regulatory compliance. Combining FBI NICS data with demographic information enables actionable insights for:
- Policymakers: Identifying patterns in firearm demand relative to population and socioeconomic shifts.
- Regulatory Bodies: Detecting anomalies that may suggest compliance gaps or state-level policy impacts.
- Public Safety Organizations: Planning resources and interventions based on seasonal or demographic trends.

This analysis examines the FBI National Instant Criminal Background Check System (NICS) data alongside U.S. Census Bureau demographic data to uncover trends, correlations, and anomalies in firearm background checks across the United States.

## **Dataset**

The analysis uses two main datasets:

* **FBI NICS Firearm Background Check Data**: Sourced from the FBI's National Instant Criminal Background Check System. This data, originally from an .xlsx file, contains the number of firearm checks conducted by month, state, and type (e.g., handgun, long gun).  
* **U.S. Census Data**: Sourced from census.gov. This .csv file provides various demographic and socioeconomic variables at the state level, primarily for the years 2010, 2012, 2015, and 2016.

The relationship between the datasets is explored by joining them on 'state' and 'year' to examine how demographic factors might influence firearm check trends.

## **Tools and Technologies**

* **Python**: The primary language for data manipulation, analysis, and visualization.  
  * **Libraries**: pandas, numpy, matplotlib.pyplot, seaborn, re

## **Project Structure**

* Investigate_a_Dataset.ipynb   # Code for cleaning, analysis, and visualization
* README.md                     # Project overview
* Input Datasets/
* /gun_data.csv              # FBI NICS data
* /US_Census_Data.csv        # U.S. Census data

## **Data Cleaning and Transformation**

The raw data required significant cleaning to be usable. Key steps included:

* **FBI NICS Data**:  
  * Converted month column to datetime and extracted year, month, and quarter.  
  * Replaced missing numeric values with zeros to ensure accurate totals.  
* **U.S. Census Data**: 
  * Pivoted wide-format data to long format for merging with NICS data.
  * Extracted measure, unit, and year from descriptive columns.
  * Cleaned numeric fields by removing special characters ($, %) and converting to float.
  * Dropped rows with entirely missing or uninformative data.
 
**Why it matters**: These steps ensure accurate calculations, meaningful merges, and reliable insights.
 
 ## **Data Governance & Quality Practices**
 
This project applied key governance principles:
- **Completeness**: Handled missing values by imputing zeros for firearm checks and dropping uninformative Census rows.
- **Accuracy**: Cleaned numeric fields and standardized formats to ensure reliable downstream analysis.
- **Consistency**: Standardized time and state identifiers for alignment across FBI and Census datasets.
- **Lineage**: Documented transformations from raw FBI NICS and Census datasets into a unified analytical dataset.


## **Key Findings and Conclusions**

* **Overall Trend**: Firearm background checks have generally increased over time.
* **North Carolina Permit Spike**: A notable spike occurred in early 2014, unexplained by population or housing data, suggesting policy or event-driven causes.
* **Seasonality**: Checks peak consistently in November and December and are lowest in June and July, likely related to the holiday season.
* **Population Correlation**: Strong positive correlation (r ≈ 0.85) between state population and firearm checks, confirming population size as a key driver.

## **Limitations**

* Analysis is limited to state-level census data; local trends could not be captured.
* Sudden spikes in background checks could not be fully explained without additional datasets, such as state legislation or local events.
* Potential data quality issues in reported NICS counts may exist.

## **Future Work**

* Advanced Data Sources: ntegrate state legislation, economic factors, or event datasets to investigate anomalies.
* Machine Learning: Build time series models to forecast future firearm background checks.
* Data Governance: Catalog metadata in Collibra or Purview for improved lineage and compliance tracking.
* Granular Analysis: Include county-level or city-level demographic data for more precise insights.
