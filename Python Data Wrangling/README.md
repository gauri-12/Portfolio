# **Real-world Data Wrangling Project: Global Happiness and Socioeconomic Indicators**

## **Project Overview**

This project focuses on a data wrangling and exploratory data analysis of global well-being metrics. The main objective is to integrate three distinct datasets—the World Happiness Report, global life expectancy data, and socioeconomic indicators from the World Bank API—into a single, clean, and cohesive dataset. The primary goal is to perform a data cleaning and transformation exercise. This comprehensive dataset is then used to explore the relationships between a country's happiness score, life expectancy, and economic factors like GDP per capita and unemployment rates.

## **Dataset**

This project utilizes three data sources for the 2024/2025 period:

* **World Happiness Report 2025**: An Excel file containing country-level happiness scores and contributing factors such as GDP, social support, and healthy life expectancy.  
* **World Population Review (Life Expectancy)**: Data scraped from a website table providing life expectancy figures for both sexes, females, and males.  
* **World Bank Open Data API**: Data programmatically fetched from the World Bank API, including indicators like GDP per capita and the unemployment rate.

The data is combined using a common identifier, the country name, to enable a holistic analysis.

## **Tools and Technologies**

* **Python**: The primary programming language used for the project.  
* **Libraries**: pandas, numpy, requests, BeautifulSoup, seaborn, matplotlib.pyplot, wbgapi, and openpyxl.

## **Data Wrangling and Cleaning**

The data wrangling process addressed several key quality and tidiness issues:

* **Completeness**: Missing values in the World Happiness Report dataset were imputed with 0, and empty columns in the World Bank data were dropped.  
* **Validity**: Data types were converted to be appropriate for analysis (e.g., converting life expectancy and economic indicators from object to numeric types).  
* **Tidiness & Consistency**: The three disparate datasets were merged into a single dataframe using country names as the key. Column names were also standardized to be more user-friendly.

## **Exploratory Data Analysis and Findings**

The cleaned and integrated dataset was used to answer several key research questions:

* **Happiness vs. Life Expectancy**: A comparative analysis of the top 10 happiest countries revealed that almost all of them also fall into the "High" life expectancy tier, suggesting a strong positive relationship between happiness and longevity.  
* **Unemployment vs. Happiness & Life Expectancy**: Scatterplots demonstrated a negative correlation, indicating that countries with lower unemployment rates tend to have higher life expectancies and higher happiness scores.  
* **GDP per Capita vs. Happiness**: A boxplot analysis showed a clear upward trend: countries in the "High" happiness tier generally have a significantly higher GDP per capita compared to countries in the "Low" and "Medium" tiers.

## **Reflection and Future Work**

Further research questions I would want to explore would be by bringing in additional metrics from the world bank dataset that has populated data and identify the relationship and trends of the happiness score and life expectancy against these metrics.