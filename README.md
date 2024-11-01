# Billboard Hot 100 Analytics Pipeline

## Project: End-to-End Data Pipeline for Music Chart Analysis 
### Goal
Implement a production-ready data pipeline transforming raw data into clear insights.
### Outcomes
* **Business insights:** Extracted from raw data across multiple sources, providing actionable information.
* **Automated updates:** Scheduled transformations ensure insights remain current and reliable.
* **Enterprise scalability:** Robust and scalable pipeline capable of handling large, complex data workloads.
* **Flexible setup:** Modular structure makes it easy to update or extend the pipeline.
### Implementation
<img src="resources/pipeline_graphic.jpg" alt="PLACEHOLDER: Billboard Hot 100 Data Pipeline" width="600">

#### Data Ingestion
* Scraping data from Billboard Hot 100 charts using AWS Lambda and storing the data in an S3 bucket
* Loading and syncing S3 data to a Snowflake database
* The ingestion pipeline runs once every week to account for charts updates
#### Data Transformation & Analysis
* Several dbt models transform the raw data in Snowflake into useful insights for analytics
* (*Not yet implemented*) After data transformation, a dashboard is built to visualize the key insights at a glance
* The dbt and dashboarding steps are orchestrated by a containerized Airflow implementation

*Note: This repository contains the source code for the "Data Transformation & Analysis" part of the pipeline. For guidance on how to implement the data ingestion, feel free to reach out (see contact info below)!*

### Technology
* AWS Lambda & S3 for data scraping and storage
* Snowflake for data warehousing & querying
* SQL & data build tool (dbt) for data transformations
* Python & Airflow for scheduling & orchestration
* Docker for containerized deployment

## Repository Structure
* `airflow/`: Contains the DAGs and configuration files for Airflow to schedule and run ETL workflows.
* `dbt/billboard_hot_100/`: Houses dbt models and transformations for preparing the data for analytics.
* `scripts/`: Contains python scripts used in the airflow DAG.
* `README.md`: Documentation for the project setup and usage.
* `docker-compose.yaml`: Docker Compose configuration to set up the development environment.

## Setup Guide (WIP, DO NOT USE YET)
### 1. Get the Data
To collect the Billboard Hot 100 data:
Run the AWS Lambda function to scrape data and store the results in a CSV file within an S3 bucket.
Ensure you have the necessary AWS credentials and permissions set up for this process.
(Optional) If using local data, place your CSV files in a specific directory (e.g., data/raw).
### 2. Load Data into Snowflake
Follow these steps to transfer data to Snowflake:
Option 1: Use dbt to directly connect to Snowflake and handle the data transformation process.
Option 2: (Link to a tutorial or describe manual process) for uploading CSV files to Snowflake tables if you prefer to manually manage the data loading.
### 3. Configure profiles.yml for Snowflake
To enable dbt to connect to Snowflake, create a profiles.yml file in your ~/.dbt directory with the following template:
```yaml
default:
  outputs:
    dev:
      type: snowflake
      account: <YOUR_ACCOUNT>
      user: <YOUR_USERNAME>
      password: <YOUR_PASSWORD>
      role: <YOUR_ROLE>
      database: <YOUR_DATABASE>
      warehouse: <YOUR_WAREHOUSE>
      schema: <YOUR_SCHEMA>
  target: dev
```
### 4. Run Docker Containers
Start the Docker environment by running:

```bash
docker-compose up -d
```
This command sets up the necessary containers for dbt and Airflow.

### 5. Access Airflow, Log In, and Run the DAG
* Open a web browser and go to `http://localhost:8080` to access the Airflow UI.
* Log in using the default credentials:
    * Username: admin
    * Password: admin_password
* Locate the DAG for this pipeline, activate it, and then trigger a run to start processing the data.

### Next Steps
After setting up and running the pipeline, you might consider:
* Building dashboards in tools like Looker or Tableau for visual insights.
* Developing scheduled reports using Airflow to automate insights.
* Integrating machine learning models to forecast trends or classify songs based on genre and other attributes.

## Contact Information
For questions or contributions, reach out to Max Hilsdorf via [Email](mailto:m.hilsdorf1@gmail.com) or on [LinkedIn](https://www.linkedin.com/in/max-hilsdorf/).

## License
This project is licensed under the MIT License (see [LICENSE](LICENSE)).