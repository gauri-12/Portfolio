## 📝 Data Quality & Governance Framework (Lending Club Case Study)

-----

### **Context and Business Motivation**

[cite_start]To establish and operationalise a Data Quality (DQ) framework to validate the fitness-for-use of lending data for regulatory reporting and credit risk modelling[cite: 1]. [cite_start]The framework enforced business-critical rules that ensure financial integrity and data stability[cite: 3, 14].

  * [cite_start]**Key Quantified Achievement:** Designed and implemented a Python/pandas-based framework that validated 7 core data quality dimensions (Accuracy, Completeness, Consistency, Integrity, Timeliness, Uniqueness and Validity) across 8 critical data elements (CDEs)[cite: 2].

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

[cite_start]This project utilizes the Lending Club data for both accepted and rejected loans from 2007 to 2018 from Kaggle[cite: 4, 5].

  * [cite_start]**Source:** [https://www.kaggle.com/datasets/wordsforthewise/lending-club](https://www.kaggle.com/datasets/wordsforthewise/lending-club) [cite: 5]

### **Tools and Technologies**

  * [cite_start]**Python**: The primary programming language used for the project[cite: 6].
  * [cite_start]**Libraries**: pandas, numpy[cite: 6].
  * [cite_start]**Design tools**: Canva (for flowcharts), Google Sheets (for data dictionary and rule definition)[cite: 6].

### **Project Structure**

  * [cite_start]**`LendingClub Data Dictionary.xlsx`**: Includes metadata, CDE identification, and defined DQ rules[cite: 7].
  * [cite_start]**`AzureDataFlow.png`**: Flowchart showing the progression of data into the Azure ecosystem[cite: 7]. [cite_start]This is a hypothetical flowchart for an Azure-hosted environment[cite: 8].
  * [cite_start]**`Input`**: This folder includes the input csv data file with the loans data[cite: 9].
  * [cite_start]**`LoanData_DataCleaningProject.ipynb`**: The core Python code file for performing the CDE data quality checks[cite: 10].
  * [cite_start]**`README.md`**[cite: 10].

### **Data Governance process**

The data governance process addressed several key steps:

  * [cite_start]**Data Dictionary**: Creating a unified document for the metadata of the 54 chosen elements[cite: 11].
  * [cite_start]**CDE Identification**: Identifying $\mathbf{8}$ critical data elements based on their use as identifiers or in credit risk model target variable calculation[cite: 12].
  * [cite_start]**Business rule definition for CDEs**: Defining and documenting Data Quality business rules for the CDEs[cite: 13].
  * [cite_start]**Operationalization of business rules**: Operationalizing the defined business rules using Python code[cite: 14].

### **Governance Findings**

[cite_start]The framework enforced business-critical rules that ensure financial integrity and data stability[cite: 14].

  * [cite_start]**Integrity Check:** Total Principal Received (`total_rec_prncp`) must not exceed the original Loan Amount (`loan_amnt`)[cite: 15].
  * [cite_start]**Consistency Check:** Loan Amount (`loan_amnt`) must be immutable across the entire account history (Uniqueness per ID)[cite: 16].
  * [cite_start]**Accuracy Check (Temporal):** Confirmed that month-over-month changes in loan grade distribution did not exceed the $5\%$ variance threshold[cite: 17].
  * [cite_start]**Key Governance Finding:** Timeliness and real-time Accuracy rules were documented as non-operationalizable due to the snapshot nature of the data (lacking transactional history or modification date columns)[cite: 18].

### **Technical Implementation & Architecture**

[cite_start]The framework is designed for execution in a modern, scalable cloud environment[cite: 19].

| Component | Tool / Service | Role |
| :--- | :--- | :--- |
| **Code Base** | Python, pandas | [cite_start]Implemented DQ rules using highly optimized, vectorized data frame operations[cite: 20]. |
| **Compute Engine** | Azure Databricks | [cite_start]Executes the Python script against large datasets stored in the Data Lake[cite: 21]. |
| **Data Flow** | ADLS -\> Azure Databricks -\> Azure SQL Database -\> Power BI | [cite_start]Demonstrates a scalable, modern cloud pipeline for DQ monitoring[cite: 22]. |
| **Output** | DQ Scorecard (pandas Dataframe) | [cite_start]Compiles all individual CDE scores into a single, structured table for reporting[cite: 23]. |

### **Future Work**

  * [cite_start]Extend dataset to implement timeliness and accuracy checks completely for all the CDEs[cite: 24].
  * [cite_start]Extend the code to perform generic DQ checks for other non-CDE elements[cite: 24].

-----

Would you like me to summarize any specific section of this framework?