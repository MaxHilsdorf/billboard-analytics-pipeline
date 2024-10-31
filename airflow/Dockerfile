# Dockerfile for Airflow with dbt
FROM apache/airflow:2.5.0

# Copy requirements.txt to container
COPY requirements.txt /requirements.txt

# Install packages from requirements.txt
RUN pip install -r /requirements.txt

# (Optional) Print PATH for debugging
RUN echo $PATH