from airflow import DAG
from datetime import datetime
from airflow.operators.dummy import DummyOperator
from airflow.operators.bash import BashOperator

with DAG(
    "dbt_run_dag",
    start_date=datetime(2024, 10, 30),
    schedule_interval="@daily",
    catchup=False,
) as dag:
    start = DummyOperator(task_id="start")
    
    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command="cd /usr/local/airflow/dbt && dbt run",
    )

    start >> dbt_run