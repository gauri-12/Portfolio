# **Data Wrangling Project: Global Happiness and Socioeconomic Indicators**

## **Context and Business Motivation**

In today’s data-driven economy, organizations often rely on information aggregated from multiple sources—public reports, APIs, and web-scraped datasets—to guide decision-making. However, without a standardized and governed approach, this data is often inconsistent, incomplete, or unreliable, limiting its usefulness for business leaders, policymakers, and regulators.  

This project simulates a real-world governance and analytics challenge: bringing together heterogeneous datasets on global well-being (happiness scores, life expectancy, and economic indicators) and transforming them into a clean, unified dataset. By applying structured data wrangling and quality checks, the project demonstrates how data governance practices such as completeness, validity, and consistency directly enhance the accuracy of downstream analysis.  

For businesses and government agencies, these practices are critical. Reliable, standardized data enables:  
- **Policy insights**: Understanding the link between happiness, health, and economic performance.  
- **Regulatory reporting**: Ensuring data quality and consistency in line with compliance standards.  
- **Strategic decision-making**: Identifying socioeconomic trends that influence investment, healthcare, and development outcomes.  

Ultimately, this project highlights how effective data wrangling and governance not only prepare data for analysis but also build the foundation for transparency, trust, and regulatory compliance in enterprise environments.  

## **Table of Contents**

- [Context and Business Motivation](#context-and-business-motivation)
- [Dataset](#dataset)
- [Tools and Technologies](#tools-and-technologies)
- [Project Structure](#project-structure)
- [Data Wrangling process](#data-wrangling-process)
- [Findings and Insights](#findings-and-insights)
- [Governance Relevance](#governance-relevance)
- [Future Work](#future-work)

## **Dataset**

This project utilizes three data sources for the 2024/2025 period:

* **World Happiness Report 2025**: An Excel file containing country-level happiness scores and contributing factors such as GDP, social support, and healthy life expectancy.  
* **World Population Review (Life Expectancy)**: Data scraped from a website table providing life expectancy figures for both sexes, females, and males.  
* **World Bank Open Data API**: Data programmatically fetched from the World Bank API, including indicators like GDP per capita and the unemployment rate.

The data is combined using a common identifier, the country name, to enable a holistic analysis.

## **Tools and Technologies**

* **Python**: The primary programming language used for the project.  
* **Libraries**: pandas, numpy, requests, BeautifulSoup, seaborn, matplotlib.pyplot, wbgapi, and openpyxl.

## **Project Structure**

* Input: This folder includes the input excel data file with the world happiness report in excel format.
* Output: This folder contains all the cleaned files that are collected from the internet as well as from the excel data file format.
* DataWrangling_Project.html: This is the python code file for performing the data wrangling and exploration in the HTML format.
* DataWrangling_Project.ipynb: This is the python code file for performing the data wrangling and exploration in the Python notebook format.
* README.md

## **Data Wrangling process**

The data wrangling process addressed several key data quality and tidiness issues:

* **Completeness**: Missing values in the World Happiness Report dataset were imputed with 0, and empty columns in the World Bank data were dropped.  
* **Validity**: Data types were converted to be appropriate for analysis (e.g., converting life expectancy and economic indicators from object to numeric types).  
* **Tidiness & Consistency**: The three disparate datasets were merged into a single dataframe using country names as the key. Column names were also standardized to be more user-friendly.

## **Findings and Insights**

The cleaned and integrated dataset was used to answer several key research questions:

* **Happiness vs. Life Expectancy**: A comparative analysis of the top 10 happiest countries revealed that almost all of them also fall into the "High" life expectancy tier, suggesting a strong positive relationship between happiness and longevity.  
* **Unemployment vs. Happiness & Life Expectancy**: Scatterplots demonstrated a negative correlation, indicating that countries with lower unemployment rates tend to have higher life expectancies and higher happiness scores.  
* **GDP per Capita vs. Happiness**: A boxplot analysis showed a clear upward trend: countries in the "High" happiness tier generally have a significantly higher GDP per capita compared to countries in the "Low" and "Medium" tiers.

## **Governance Relevance**

This project demonstrates core data governance practices:
- **Data Quality Dimensions**: Addressed completeness, validity, and consistency across multiple global datasets.
- **Metadata Standardization**: Renamed and aligned columns to ensure schema consistency and enable downstream analytics.
- **Data Lineage**: Tracked transformations from raw happiness scores, API-fetched economic indicators, and scraped life expectancy tables into a unified dataset.
- **Governance Extension**: In an enterprise setting, this workflow could be extended with Azure Data Lake for storage and Collibra for metadata cataloguing.

## **Future Work**

*  Perform metadata capture in Collibra or Purview
*  Extend to Azure Data Lake for storage/ analysis
