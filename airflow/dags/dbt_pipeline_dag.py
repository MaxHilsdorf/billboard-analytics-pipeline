from airflow import DAG
from datetime import datetime
from airflow.operators.dummy import DummyOperator
from airflow.operators.bash import BashOperator

with DAG(
    "billboard_pipeline_dag",
    start_date=datetime(2024, 10, 30),
    schedule_interval="@daily",
    catchup=False,
) as dag:

    start = DummyOperator(task_id="start")

    # Add a new task for dbt test
    dbt_test = BashOperator(
        task_id="dbt_test",
        bash_command="cd /usr/local/airflow/dbt && dbt test",
    )

    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command="cd /usr/local/airflow/dbt && dbt run",
    )

    # Set up the task dependencies
    start >> dbt_test >> dbt_run