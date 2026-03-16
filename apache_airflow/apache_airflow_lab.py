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

##########################################
Hands-on Lab: Create a DAG for Apache Airflow with PythonOperator

In this lab, you will explore the Apache Airflow web user interface (UI). You will then create a Direct Acyclic Graph (DAG) using PythonOperator and finally run it through the Airflow web UI.

After completing this lab, you will be able to:

Explore the Airflow Web UI
Create a DAG with PythonOperator
Submit a DAG and run it through the Web UI

# Create a DAG with PythonOperator
# Next, you will create a DAG, which will define a pipeline of tasks, such as extract, transform, load, and check with PythonOperator.
# Create a DAG file, my_first_dag.py, which will run daily. To Create a new file choose File->New File and name it as my_first_dag.py.
# The my_first_dag.py file defines tasks execute_extract, execute_transform, execute_load, and execute_check to call the respective Python functions.

# Import the libraries
from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow.models import DAG
# Operators; you need this to write tasks!
from airflow.operators.python import PythonOperator

# This makes scheduling easy
from airflow.utils.dates import days_ago

# Define the path for the input and output files
input_file = '/etc/passwd'
extracted_file = 'extracted-data.txt'
transformed_file = 'transformed.txt'
output_file = 'data_for_analytics.csv'


def extract():
    global input_file
    print("Inside Extract")
    # Read the contents of the file into a string
    with open(input_file, 'r') as infile, \
            open(extracted_file, 'w') as outfile:
        for line in infile:
            fields = line.split(':')
            if len(fields) >= 6:
                field_1 = fields[0]
                field_3 = fields[2]
                field_6 = fields[5]
                outfile.write(field_1 + ":" + field_3 + ":" + field_6 + "\n")


def transform():
    global extracted_file, transformed_file
    print("Inside Transform")
    with open(extracted_file, 'r') as infile, \
            open(transformed_file, 'w') as outfile:
        for line in infile:
            processed_line = line.replace(':', ',')
            outfile.write(processed_line + '\n')


def load():
    global transformed_file, output_file
    print("Inside Load")
    # Save the array to a CSV file
    with open(transformed_file, 'r') as infile, \
            open(output_file, 'w') as outfile:
        for line in infile:
            outfile.write(line + '\n')


def check():
    global output_file
    print("Inside Check")
    # Save the array to a CSV file
    with open(output_file, 'r') as infile:
        for line in infile:
            print(line)


# You can override them on a per-task basis during operator initialization
default_args = {
    'owner': 'Your name',
    'start_date': days_ago(0),
    'email': ['your email'],
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
dag = DAG(
    'my-first-python-etl-dag',
    default_args=default_args,
    description='My first DAG',
    schedule_interval=timedelta(days=1),
)

# Define the task named execute_extract to call the `extract` function
execute_extract = PythonOperator(
    task_id='extract',
    python_callable=extract,
    dag=dag,
)

# Define the task named execute_transform to call the `transform` function
execute_transform = PythonOperator(
    task_id='transform',
    python_callable=transform,
    dag=dag,
)

# Define the task named execute_load to call the `load` function
execute_load = PythonOperator(
    task_id='load',
    python_callable=load,
    dag=dag,
)

# Define the task named execute_load to call the `load` function
execute_check = PythonOperator(
    task_id='check',
    python_callable=check,
    dag=dag,
)

# Task pipeline
execute_extract >> execute_transform >> execute_load >> execute_check

#### End DAG with PythonOperator ##############################

### Exercise 4: Submit a DAG
# Submitting a DAG is as simple as copying the DAG Python file into the dags folder in the AIRFLOW_HOME directory.

# Open a terminal and run the command below to set the AIRFLOW_HOME.
export AIRFLOW_HOME=/home/project/airflow
echo $AIRFLOW_HOME


# Run the command below to submit the DAG that was created in the previous exercise.
cp my_first_dag.py $AIRFLOW_HOME/dags


# Verify that your DAG actually got submitted.
# Run the command below to list out all the existing DAGs.
airflow dags list


# Verify that my-first-python-etl-dag is a part of the output.
airflow dags list|grep "my-first-python-etl-dag"

#You should see your DAG name in the output.
# Run the command below to list out all the tasks in my-first-python-etl-dag

airflow tasks list my-first-python-etl-dag

# You should see all the four tasks in the output.

# You can run the task from the Web UI. You can check the logs of the tasks by clicking the individual task in the Graph view.

####################################################################

Practice exercise
Write a DAG named ETL_Server_Access_Log_Processing that will extract a file from a remote server and then transform the content and load it into a file.

The file URL is given below:
https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/web-server-access-log.txt

The server access log file contains these fields.

a. timestamp - TIMESTAMP
b. latitude - float
c. longitude - float
d. visitorid - char(37)
e. accessed_from_mobile - boolean
f. browser_code - int

Tasks
Add tasks in the DAG file to download the file, read the file, and extract the fields timestamp and visitorid from the web-server-access-log.txt.

Capitalize the visitorid for all the records and store it in a local variable.

Load the data into a new file capitalized.txt.

Create the imports block.

Create the DAG Arguments block. You can use the default settings.

Create the DAG definition block. The DAG should run daily.

Create the tasks extract, transform, and load to call the Python script.

Create the task pipeline block.

Submit the DAG.

Verify if the DAG is submitted.

# Solution Below
# Create a new file by going to File -> New File from the menu and name it as ETL_Server_Access_Log_Processing.py.
# Copy the code below in the python file. This will contain your DAG with five tasks:

# download
# execute_extract
# execute_transform
# execute_load
# execute_check

# Import the libraries
from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow.models import DAG
# Operators; you need this to write tasks!
from airflow.operators.python import PythonOperator
from airflow.operators.bash_operator import BashOperator

# This makes scheduling easy
from airflow.utils.dates import days_ago
import requests

# Define the path for the input and output files
input_file = 'web-server-access-log.txt'
extracted_file = 'extracted-data.txt'
transformed_file = 'transformed.txt'
output_file = 'capitalized.txt'


def download_file():
    url = "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/web-server-access-log.txt"
    # Send a GET request to the URL
    with requests.get(url, stream=True) as response:
        # Raise an exception for HTTP errors
        response.raise_for_status()
        # Open a local file in binary write mode
        with open(input_file, 'wb') as file:
            # Write the content to the local file in chunks
            for chunk in response.iter_content(chunk_size=8192):
                file.write(chunk)
    print(f"File downloaded successfully: {input_file}")


def extract():
    global input_file
    print("Inside Extract")
    # Read the contents of the file into a string
    with open(input_file, 'r') as infile, \
            open(extracted_file, 'w') as outfile:
        for line in infile:
            fields = line.split('#')
            if len(fields) >= 4:
                field_1 = fields[0]
                field_4 = fields[3]
                outfile.write(field_1 + "#" + field_4 + "\n")


def transform():
    global extracted_file, transformed_file
    print("Inside Transform")
    with open(extracted_file, 'r') as infile, \
            open(transformed_file, 'w') as outfile:
        for line in infile:
            processed_line = line.upper()
            outfile.write(processed_line + '\n')


def load():
    global transformed_file, output_file
    print("Inside Load")
    # Save the array to a CSV file
    with open(transformed_file, 'r') as infile, \
            open(output_file, 'w') as outfile:
        for line in infile:
            outfile.write(line + '\n')


def check():
    global output_file
    print("Inside Check")
    # Save the array to a CSV file
    with open(output_file, 'r') as infile:
        for line in infile:
            print(line)


# You can override them on a per-task basis during operator initialization
default_args = {
    'owner': 'Your name',
    'start_date': days_ago(0),
    'email': ['your email'],
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
dag = DAG(
    'my-first-python-etl-dag',
    default_args=default_args,
    description='My first DAG',
    schedule_interval=timedelta(days=1),
)

# Define the task named download to call the `download_file` function
download = PythonOperator(
    task_id='download',
    python_callable=download_file,
    dag=dag,
)

# Define the task named execute_extract to call the `extract` function
execute_extract = PythonOperator(
    task_id='extract',
    python_callable=extract,
    dag=dag,
)

# Define the task named execute_transform to call the `transform` function
execute_transform = PythonOperator(
    task_id='transform',
    python_callable=transform,
    dag=dag,
)

# Define the task named execute_load to call the `load` function
execute_load = PythonOperator(
    task_id='load',
    python_callable=load,
    dag=dag,
)

# Define the task named execute_load to call the `load` function
execute_check = PythonOperator(
    task_id='check',
    python_callable=check,
    dag=dag,
)

# Task pipeline
download >> execute_extract >> execute_transform >> execute_load >> execute_check

##### End Practice Problem ######

################################################################

Hands-on Lab: Create a DAG for Apache Airflow with BashOperator
#In this lab, you will create workflows using BashOperator in Airflow DAGs and simulate an ETL process using bash commands that are scheduled to run once a day.
After completing this lab, you will be able to:

Explore the Airflow Web UI
Create a DAG with BashOperator
Submit a DAG and run it through Web UI

Exercise 3: Create a DAG
Let's create a DAG that runs daily, and extracts user information from /etc/passwd file, transforms it, and loads it into a file.

This DAG will have two tasks extract that extracts fields from /etc/passwd file and transform_and_load that transforms and loads data into a file.

# import the libraries

from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow.models import DAG
# Operators; you need this to write tasks!
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago

#defining DAG arguments

# You can override them on a per-task basis during operator initialization
default_args = {
    'owner': 'your_name_here',
    'start_date': days_ago(0),
    'email': ['your_email_here'],
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# defining the DAG

# define the DAG
dag = DAG(
    'my-first-dag',
    default_args=default_args,
    description='My first DAG',
    schedule_interval=timedelta(days=1),
)

# define the tasks

# define the first task

extract = BashOperator(
    task_id='extract',
    bash_command='cut -d":" -f1,3,6 /etc/passwd > /home/project/airflow/dags/extracted-data.txt',
    dag=dag,
)

# define the second task
transform_and_load = BashOperator(
    task_id='transform',
    bash_command='tr ":" "," < /home/project/airflow/dags/extracted-data.txt > /home/project/airflow/dags/transformed-data.csv',
    dag=dag,
)

# task pipeline
extract >> transform_and_load

# End ETL DAG script ##################################

Exercise 4: Submit a DAG
Submitting a DAG is as simple as copying the DAG Python file into the dags folder in the AIRFLOW_HOME directory.

Airflow searches for Python source files within the specified DAGS_FOLDER. The location of DAGS_FOLDER can be located in the airflow.cfg file, where it has been configured as /home/project/airflow/dags.

Airflow will load the Python source files from this designated location. It will process each file, execute its contents, and subsequently load any DAG objects present in the file.

Therefore, when submitting a DAG, it is essential to position it within this directory structure. Alternatively, the AIRFLOW_HOME directory, representing the structure /home/project/airflow, can also be utilized for DAG submission.

# Open a terminal and run the command below to set the AIRFLOW_HOME.
export AIRFLOW_HOME=/home/project/airflow
echo $AIRFLOW_HOME

#Run the command below to submit the DAG that was created in the previous exercise.
export AIRFLOW_HOME=/home/project/airflow
cp my_first_dag.py $AIRFLOW_HOME/dags

# Verify that your DAG actually got submitted.

# Run the command below to list out all the existing DAGs.
airflow dags list

# Verify that my-first-dag is a part of the output.
airflow dags list|grep "my-first-dag"

# You should see your DAG name in the output.

# Run the command below to list out all the tasks in my-first-dag.
airflow tasks list my-first-dag


#######################################################

Practice exercise
Write a DAG named ETL_Server_Access_Log_Processing.py.

Create the imports block.
Create the DAG Arguments block. You can use the default settings
Create the DAG definition block. The DAG should run daily.
Create the download task. The download task must download the server access log file, which is available at the URL:
https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/web-server-access-log.txt

Create the extract task.

The server access log file contains these fields.

a. timestamp - TIMESTAMP
b. latitude - float
c. longitude - float
d. visitorid - char(37)
e. accessed_from_mobile - boolean
f. browser_code - int

The extract task must extract the fields timestamp and visitorid.

Create the transform task. The transform task must capitalize the visitorid.

Create the load task. The load task must compress the extracted and transformed data.

Create the task pipeline block. The pipeline block should schedule the task in the order listed below:

download
extract
transform
load
Submit the DAG.

Verify if the DAG is submitted.

Solution to Practice Problem:

# import the libraries

from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow.models import DAG
# Operators; you need this to write tasks!
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago

#defining DAG arguments

# You can override them on a per-task basis during operator initialization
default_args = {
    'owner': 'your_name',
    'start_date': days_ago(0),
    'email': ['your email'],
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# defining the DAG

# define the DAG
dag = DAG(
    'ETL_Server_Access_Log_Processing',
    default_args=default_args,
    description='My first DAG',
    schedule_interval=timedelta(days=1),
)

# define the tasks

# define the task 'download'

download = BashOperator(
    task_id='download',
    bash_command='curl "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/web-server-access-log.txt" -o web-server-access-log.txt',
    dag=dag,
)

# define the task 'extract'

extract = BashOperator(
    task_id='extract',
    bash_command='cut -f1,4 -d"#" web-server-access-log.txt > /home/project/airflow/dags/extracted.txt',
    dag=dag,
)


# define the task 'transform'

transform = BashOperator(
    task_id='transform',
    bash_command='tr "[a-z]" "[A-Z]" < /home/project/airflow/dags/extracted.txt > /home/project/airflow/dags/capitalized.txt',
    dag=dag,
)

# define the task 'load'

load = BashOperator(
    task_id='load',
    bash_command='zip log.zip capitalized.txt' ,
    dag=dag,
)

# task pipeline

download >> extract >> transform >> load

#### End of DAG bash script #############################
