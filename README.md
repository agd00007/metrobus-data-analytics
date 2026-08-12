# 🚌 MetroBus Data Analytics

End-to-end data analytics and Business Intelligence project focused on the operational performance of a public transport network.

The project covers the complete data analysis workflow, from exploratory data analysis and data quality assessment to SQL analysis, KPI definition and the development of an interactive Power BI dashboard.

The analysis focuses on key areas such as passenger occupancy, service punctuality, incidents, vehicle maintenance, operational costs and fleet performance.

## 🎯 Project Objectives

- Analyze the operational performance of the transport network.
- Identify patterns in passenger occupancy and service punctuality.
- Analyze incidents and their economic impact.
- Evaluate vehicle maintenance costs and fleet performance.
- Assess and document data quality issues.
- Define meaningful business KPIs.
- Transform raw data into actionable business insights.
- Build an interactive Power BI dashboard to support data-driven decision making.

 ## 🔄 Data Analysis Workflow

The project follows an end-to-end data analytics workflow:

### 1. Exploratory Data Analysis (EDA)
Python was used to explore the datasets, understand their structure, identify missing values, detect anomalies and evaluate overall data quality.

### 2. SQL Analysis
SQL queries were used to analyze the operational data and extract relevant information about occupancy, delays, incidents, maintenance and fleet performance.

### 3. Data Quality & Governance
A data dictionary and Data Quality Log were created to document the datasets, detected issues and the decisions taken during the cleaning process.

Business KPIs were also formally defined to ensure consistent interpretation of the results.

### 4. Power BI
The processed data and defined KPIs were used to build an interactive Power BI dashboard focused on operational and business performance.

### 5. Business Insights
The results were interpreted to identify operational patterns, potential problems and opportunities for improving transport operations. 

## 🛠️ Technologies & Tools

### Data Analysis
- **Python** - Exploratory data analysis and data processing
- **Pandas** - Data manipulation, cleaning and aggregation
- **NumPy** - Numerical data processing
- **Matplotlib** - Data visualization
- **Seaborn** - Statistical data visualization
- **Jupyter Notebook** - Exploratory analysis and documentation

### Data & Business Intelligence
- **SQL** - Data querying and operational analysis
- **Power BI** - Data modeling, KPI analysis and interactive dashboards
- **DAX** - Business metrics and calculations
- **Power Query** - Data transformation and preparation

### Data Quality & Governance
- Data profiling
- Data quality assessment
- Data dictionary
- Data Quality Log
- KPI definition and documentation

## 📊 Key Business Insights

The analysis revealed several relevant insights about MetroBus operations:

- **Passenger occupancy:** Most daytime lines maintain an average occupancy of around 45%. Lines L4 and L9 show the highest occupancy, while the N1 night line has the lowest demand.

- **Service punctuality:** The highest delays occur during morning and afternoon peak hours. Delays decrease considerably during periods of lower passenger demand.

- **Service interruptions:** The Barrio Sur - Universidad line records the highest number of incomplete trips, followed by Barrio Norte - Estación and Universidad - Hospital.

- **Incident costs:** Critical incidents generate the highest economic impact despite occurring less frequently than other incident categories.

- **Fleet maintenance:** Vehicle 14 stands out with maintenance costs exceeding €30,000, making it a relevant candidate for further analysis regarding age, mileage and usage intensity.

- **Fleet incidents:** Vehicles 9, 10 and 30 record the highest number of incidents, although the differences compared with the rest of the fleet are relatively small.

- **Travel evolution:** The total number of trips remains relatively stable over the analyzed period, with a slight decrease observed in 2023.

These insights can support operational decisions related to service planning, fleet maintenance, resource allocation and cost control.

## 📁 Project Structure

```text
metrobus-data-analytics/
│
├── 01_eda.ipynb           # Exploratory Data Analysis with Python
├── 02_sql.sql             # SQL queries and operational analysis
├── 03_gobierno.md         # Data governance, data quality and KPI documentation
├── MetroBus.pbix           # Power BI dashboard and data model
├── 05_presentacion.pptm   # Final project presentation
└── README.md               # Project documentation
```

### Project Files

- **01_eda.ipynb** - Exploratory Data Analysis (EDA), data inspection, cleaning and identification of data quality issues using Python.

- **02_sql.sql** - SQL queries used to analyze operational performance and extract relevant business information.

- **03_gobierno.md** - Data governance documentation including the data dictionary, Data Quality Log, cleaning decisions and formal KPI definitions.

- **MetroBus.pbix** - Power BI project containing the data model, KPIs, visualizations and interactive dashboards.

- **05_presentacion.pptm** - Final presentation summarizing the analysis, methodology, results and business conclusions.

## 📈 Key Performance Indicators (KPIs)

The project defines a set of business KPIs to evaluate the operational performance of the MetroBus transport network.

| KPI | Purpose |
|---|---|
| **Average Occupancy (%)** | Measure the average utilization of transport capacity |
| **Average Departure Delay** | Evaluate service punctuality |
| **Completed Trips Rate (%)** | Measure service reliability |
| **Total Incident Cost (€)** | Evaluate the economic impact of operational incidents |
| **Total Maintenance Cost (€)** | Monitor fleet maintenance expenditure |
| **Average Consumption** | Analyze vehicle consumption and efficiency |
| **Critical Incidents** | Monitor high-severity operational incidents |
| **Incomplete Trips** | Identify service interruptions and operational problems |

The KPIs were formally documented with their calculation method, data source and exclusion criteria to ensure consistent interpretation across the analysis.
