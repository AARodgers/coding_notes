Monitoring a DAG.

Objectives
After completing this lab you will be able to:

Search for a DAG
Pause/Unpause a DAG
Get the Details of a DAG
Explore grid view of a DAG
Explore graph view of a DAG
Explore Calendar view of a DAG
Explore Task Duration view of a DAG
Explore Details view of a DAG
View the source code of a DAG
Delete a DAG

Exercise 3: Submit a dummy DAG

For the purpose of monitoring, let's create a dummy DAG with three tasks.

Task1 does nothing but sleep for 1 second.

Task2 sleeps for 2 seconds.

Task3 sleeps for 3 seconds.

This DAG is scheduled to run every 1 minute.

Using Menu->File->New File create a new file named dummy_dag.py.

Copy and paste the code below into it and save the file.

# import the libraries

from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG
# Operators; we need this to write tasks!
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago

#defining DAG arguments

# You can override them on a per-task basis during operator initialization
default_args = {
    'owner': 'Your name',
    'start_date': days_ago(0),
    'email': ['your email'],
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# defining the DAG
dag = DAG(
    'dummy_dag',
    default_args=default_args,
    description='My first DAG',
    schedule_interval=timedelta(minutes=1),
)

# define the tasks

# define the first task

task1 = BashOperator(
    task_id='task1',
    bash_command='sleep 1',
    dag=dag,
)

# define the second task
task2 = BashOperator(
    task_id='task2',
    bash_command='sleep 2',
    dag=dag,
)

# define the third task
task3 = BashOperator(
    task_id='task3',
    bash_command='sleep 3',
    dag=dag,
)

# task pipeline
task1 >> task2 >> task3

#### End script ########

#Set the AIRFLOW_HOME directory.
export AIRFLOW_HOME=/home/project/airflow

# Submitting a DAG is as simple as copying the DAG python file into dags folder in the AIRFLOW_HOME directory. Open a terminal and run the command below to submit the DAG.
cp dummy_dag.py $AIRFLOW_HOME/dags

# Verify that our DAG actually got submitted. Run the command below to list out all the existing DAGs.
airflow dags list

# Verify that dummy_dag is a part of the output.
airflow dags list | grep dummy_dag

# Run the command below to list out all the tasks in dummy_dag.
airflow tasks list dummy_dag
