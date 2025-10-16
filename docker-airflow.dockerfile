# Dockerfile-airflow
FROM apache/airflow:2.9.4

USER root

# Update OS packages to reduce vulnerabilities
RUN apt-get update && apt-get upgrade -y && apt-get clean

# Switch to airflow user
USER airflow

# Install dbt packages
RUN pip install --no-cache-dir dbt-core dbt-snowflake