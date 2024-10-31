# Dockerfile for Airflow with dbt
FROM apache/airflow:2.5.0

# Switch to root to install system packages
USER root

# Install git
RUN apt-get update && apt-get install -y git

# Ensure git is executable by all users
RUN chmod +x /usr/bin/git

# Confirm git installation and permissions
RUN ls -l /usr/bin/git

# Switch back to airflow user
USER airflow

# Install dbt and any additional dependencies
RUN pip install dbt-core dbt-snowflake

# Verify that git is accessible to the airflow user
RUN which git
RUN git --version

# (Optional) Print PATH for debugging
RUN echo $PATH