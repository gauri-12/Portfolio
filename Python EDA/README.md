# **Investigate a Dataset: FBI NICS Firearm Background Check Data**

## **Project Overview**

This project involves a detailed analysis of the **FBI National Instant Criminal Background Check System (NICS) firearm data** and supplementary data from the **US Census Bureau**. The primary goal is to explore trends in firearm background checks over time, identify key state-level patterns, and investigate potential correlations with demographic information. The analysis aims to uncover insights into factors influencing gun-related activity, including seasonality, population density, and other demographic indicators.

## **Dataset**

The analysis uses two main datasets:

* **FBI NICS Firearm Background Check Data**: Sourced from the FBI's National Instant Criminal Background Check System. This data, originally from an .xlsx file, contains the number of firearm checks conducted by month, state, and type (e.g., handgun, long gun).  
* **U.S. Census Data**: Sourced from census.gov. This .csv file provides various demographic and socioeconomic variables at the state level, primarily for the years 2010, 2012, 2015, and 2016\.

The relationship between the datasets is explored by joining them on 'state' and 'year' to examine how demographic factors might influence firearm check trends.

## **Tools and Technologies**

* **Python**: The primary language for data manipulation, analysis, and visualization.  
  * **Libraries**: pandas, numpy, matplotlib.pyplot, seaborn, re

## **Project Structure**

* Investigate\_a\_Dataset.ipynb: The Jupyter Notebook containing all the code for data cleaning, analysis, and visualization.  
* README.md: This project overview file.  
* Database\_Ncis\_and\_Census\_data/: Folder containing the raw input datasets.  
  * gun\_data.csv: The FBI NICS data.  
  * US\_Census\_Data.csv: The U.S. Census data.

## **Data Cleaning and Transformation**

The raw data required significant cleaning to be usable. Key steps included:

* **FBI NICS Data**:  
  * Converting the month column to a datetime format and extracting separate columns for year, month, and quarter.  
  * Replacing missing numeric values with zero to allow for proper calculations.  
* **U.S. Census Data**:  
  * Pivoting the wide-format data to a long format to enable easier merging with the NICS data.  
  * Extracting meaningful information (measure, unit, year) from the Fact column.  
  * Cleaning numeric fields by removing special characters like $ and % and converting them to a float data type.  
  * Dropping rows with entirely missing or uninformative data.

## **Key Findings and Conclusions**

* **Overall Trends**: The total number of firearm background checks shows a general increasing trend over time, with notable spikes occurring in specific states at different periods.  
* **North Carolina Permit Spike**: A substantial and unusual spike in permit checks was identified in North Carolina during early 2014\. This anomaly could not be explained by changes in population or housing units based on the available data, suggesting other factors like state-specific policy changes or events may be at play.  
* **Seasonality**: There is a clear seasonal pattern in firearm background checks. Checks consistently peak during **November** and **December**, likely coinciding with the U.S. holiday season. Conversely, checks tend to be lower during the summer months of June and July.  
* **Correlation with Population**: A strong positive correlation was found between a state's population estimates and the number of firearm background checks. This indicates that population size is a major factor contributing to the volume of checks.

## **Limitations**

The current analysis was limited by the available census data, which did not contain detailed information that could explain sudden spikes in firearm permits. Additional datasets on state legislation, local economic factors, or significant social events would be necessary to fully understand the anomalies observed.

## **Future Work**

* **Advanced Data Sources**: Integrate state-specific legislative and event data to investigate the causes of unusual spikes in background checks.  
* **Machine Learning**: Build predictive models to forecast future trends in firearm background checks.

## **Contributing**

Contributions are welcome\! If you have suggestions for improvements, new analyses, or bug fixes, please open an issue or submit a pull request.

## **Contact**

Gauri Rajgopal  
https://www.linkedin.com/in/gauri-rajgopal/