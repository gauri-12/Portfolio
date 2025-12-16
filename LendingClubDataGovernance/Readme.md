## 📝 Data Quality & Governance Framework (Lending Club Case Study)

-----

### **Context and Business Motivation**

To establish and operationalise a Data Quality (DQ) framework to validate the fitness-for-use of lending data for regulatory reporting and credit risk modelling. The framework enforced business-critical rules that ensure financial integrity and data stability.

  * **Key Quantified Achievement:** Designed and implemented a Python/pandas-based framework that validated 7 core data quality dimensions (Accuracy, Completeness, Consistency, Integrity, Timeliness, Uniqueness and Validity) across 8 critical data elements (CDEs).

### **Table of Contents**

  * [Context and Business Motivation](https://www.google.com/search?q=%23context-and-business-motivation)
  * [Dataset](https://www.google.com/search?q=%23dataset)
  * [Tools and Technologies](https://www.google.com/search?q=%23tools-and-technologies)
  * [Project Structure](https://www.google.com/search?q=%23project-structure)
  * [Data Governance process](https://www.google.com/search?q=%23data-governance-process)
  * [Governance Findings](https://www.google.com/search?q=%23governance-findings)
  * [Technical Implementation & Architecture](https://www.google.com/search?q=%23technical-implementation-%26-architecture)
  * [Future Work](https://www.google.com/search?q=%23future-work)

### **Dataset**

This project utilizes the Lending Club data for both accepted and rejected loans from 2007 to 2018 from Kaggle.

  * **Source:** [https://www.kaggle.com/datasets/wordsforthewise/lending-club](https://www.kaggle.com/datasets/wordsforthewise/lending-club) 

### **Tools and Technologies**

  * **Python**: The primary programming language used for the project.
  * **Libraries**: pandas, numpy.
  * **Design tools**: Canva (for flowcharts), Google Sheets (for data dictionary and rule definition).

### **Project Structure**

  * **`LendingClub Data Dictionary.xlsx`**: Includes metadata, CDE identification, and defined DQ rules.
  * **`AzureDataFlow.png`**: Flowchart showing the progression of data into the Azure ecosystem. This is a hypothetical flowchart for an Azure-hosted environment.
  * **`Input`**: This folder includes the input csv data file with the loans data.
  * **`LoanData_DataCleaningProject.ipynb`**: The core Python code file for performing the CDE data quality checks.
  * **`README.md`**.

### **Data Governance process**

The data governance process addressed several key steps:

  * **Data Dictionary**: Creating a unified document for the metadata of the 54 chosen elements.
  * **CDE Identification**: Identifying critical data elements based on their use as identifiers or in credit risk model target variable calculation.
  * **Business rule definition for CDEs**: Defining and documenting Data Quality business rules for the CDEs.
  * **Operationalization of business rules**: Operationalizing the defined business rules using Python code.

### **Governance Findings**

The framework enforced business-critical rules that ensure financial integrity and data stability.

  * **Integrity Check:** Total Principal Received (`total_rec_prncp`) must not exceed the original Loan Amount (`loan_amnt`).
  * **Consistency Check:** Loan Amount (`loan_amnt`) must be immutable across the entire account history (Uniqueness per ID).
  * **Accuracy Check (Temporal):** Confirmed that month-over-month changes in loan grade distribution did not exceed the variance threshold.
  * **Key Governance Finding:** Timeliness and real-time Accuracy rules were documented as non-operationalizable due to the snapshot nature of the data (lacking transactional history or modification date columns).

### **Technical Implementation & Architecture**

The framework is designed for execution in a modern, scalable cloud environment.

| Component | Tool / Service | Role |
| :--- | :--- | :--- |
| **Code Base** | Python, pandas | Implemented DQ rules using highly optimized, vectorized data frame operations. |
| **Compute Engine** | Azure Databricks | Executes the Python script against large datasets stored in the Data Lake. |
| **Data Flow** | ADLS -\> Azure Databricks -\> Azure SQL Database -\> Power BI | Demonstrates a scalable, modern cloud pipeline for DQ monitoring. |
| **Output** | DQ Scorecard (pandas Dataframe) | Compiles all individual CDE scores into a single, structured table for reporting. |

### **Future Work**

  * Extend dataset to implement timeliness and accuracy checks completely for all the CDEs.
  * Extend the code to perform generic DQ checks for other non-CDE elements.

-----

Would you like me to summarize any specific section of this framework?