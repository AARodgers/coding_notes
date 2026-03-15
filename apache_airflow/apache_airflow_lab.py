After completing this lab, you will be able to:

Start Apache Airflow
Open the Airflow UI in a browser
List all the DAGs
List the tasks in a DAG
Explore a DAG in the UI

Apache Airflow provides some command line options.

# Run the command below in the terminal to list all the existing DAGs:
airflow dags list

#Run the command below in the terminal to list all tasks in the DAG named example_bash_operator.
airflow tasks list example_bash_operator

# Run a command to list all tasks for the DAG named tutorial.
airflow tasks list tutorial

#Run the command below in the terminal to unpause a DAG named tutorial.
airflow dags unpause tutorial

# Run the command to pause the DAG named tutorial
airflow dags pause tutorial

