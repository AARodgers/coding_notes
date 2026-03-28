

Start Apache Airflow.
 Open Apache Airflow in IDE

Open a terminal and create a directory structure for the staging area as follows:
/home/project/airflow/dags/finalassignment/staging.
1
sudo mkdir -p /home/project/airflow/dags/finalassignment/staging

Copied!

Wrap Toggled!

Executed!
Execute the following commands to give appropriate permission to the directories.
1
sudo chmod -R 777 /home/project/airflow/dags/finalassignment

Copied!

Wrap Toggled!

Executed!
Download the data set from the source to the following destination using the curl command.
1
sudo curl https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Final%20Assignment/tolldata.tgz -o /home/project/airflow/dags/finalassignment/tolldata.tgz

Copied!

Wrap Toggled!

Executed!

Exercise 1: Create imports, DAG argument, and definition
Please use the BashOperator for all tasks in this assignment.
Create a new file named ETL_toll_data.py in /home/project directory and open it in the file editor.

Import all the packages you need to build the DAG.

Task 1.1: Define DAG arguments
Define the DAG arguments as per the following details in the ETL_toll_data.py file:

1
2
3
4
5
6
7
8
9
10
11
| Parameter | Value |
| ----------------- | ------- |
| owner |  <You may use any dummy name> |
| start_date |  today |
| email | <You may use any dummy email> |
| email\_on_failure | True |
| email\_on_retry | True|
| retries | 1|
| retry_delay |  5 minutes|
<font color="#8A3FFC">***Take a screenshot*** </font> of the task code. Name the screenshot `dag_args.jpg`.

Copied!

Wrap Toggled!
Task 1.2: Define the DAG
Define the DAG in the ETL_toll_data.py file using the following details.

1
2
3
4
5
6
7
8
| Parameter | Value |
| ----------------- | ------- |
| DAG id  | `ETL_toll_data` |
| Schedule | Daily once |
| default_args | As you have defined in the previous step |
| description | Apache Airflow Final Assignment |
<font color="#8A3FFC">***Take a screenshot***</font> of the command and output you used. Name the screenshot `dag_definition.jpg`.

Copied!

Wrap Toggled!
At the end of this exercise, you should have the following screenshots with .jpg or .png extension:
1. dag_args.jpg
2. dag_definition.jpg


Exercise 2: Create the tasks using BashOperator
Task 2.1: Create a task to unzip data.
Create a task named unzip_data to unzip data. Use the data downloaded in the first part of this assignment in Set up the lab environment and uncompress it into the destination directory using tar.

1
<font color="#8A3FFC">***Take a screenshot***</font> of the task code. Name the screenshot `unzip_data.jpg`.

Copied!

Wrap Toggled!
You can locally untar and read through the file fileformats.txt to understand the column details.

Task 2.2: Create a task to extract data from csv file
Create a task named extract_data_from_csv to extract the fields Rowid, Timestamp, Anonymized Vehicle number, and Vehicle type from the vehicle-data.csv file and save them into a file named csv_data.csv.

1
<font color="#8A3FFC">***Take a screenshot***</font> of the task code. Name the screenshot `extract_data_from_csv.jpg`.

Copied!

Wrap Toggled!
Task 2.3: Create a task to extract data from tsv file
Create a task named extract_data_from_tsv to extract the fields Number of axles, Tollplaza id, and Tollplaza code from the tollplaza-data.tsv file and save it into a file named tsv_data.csv.

1
<font color="#8A3FFC">***Take a screenshot***</font> of the task code. Name the screenshot `extract_data_from_tsv.jpg`.

Copied!

Wrap Toggled!
Task 2.4: Create a task to extract data from fixed width file
Create a task named extract_data_from_fixed_width to extract the fields Type of Payment code, and Vehicle Code from the fixed width file payment-data.txt and save it into a file named fixed_width_data.csv.

1
<font color="#8A3FFC">***Take a screenshot***</font> of the task code. Name the screenshot `extract_data_from_fixed_width.jpg`.

Copied!

Wrap Toggled!
Task 2.5: Create a task to consolidate data extracted from previous tasks
Create a task named consolidate_data to consolidate data extracted from previous tasks. This task should create a single csv file named extracted_data.csv by combining data from the following files:

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
- `csv_data.csv`
- `tsv_data.csv`
- `fixed_width_data.csv`
The final csv file should use the fields in the order given below:
- `Rowid`
- `Timestamp`
- `Anonymized Vehicle number`
- `Vehicle type`
- `Number of axles`
- `Tollplaza id`
- `Tollplaza code`
- `Type of Payment code`, and
- `Vehicle Code`

Copied!

Wrap Toggled!
Hint: Use the bash paste command that merges the columns of the files passed as a command-line parameter and sends the output to a new file specified. You can use the command man paste to explore more.

Example: paste file1 file2 > newfile

Take a screenshot of the task code. Name the screenshot consolidate_data.jpg.

Task 2.6: Transform the data
Create a task named transform_data to transform the vehicle_type field in extracted_data.csv into capital letters and save it into a file named transformed_data.csv in the staging directory.

Hint: You can use the tr command within the BashOperator in Airflow.

Take a screenshot of the task code. Name the screenshot transform.jpg.

Task 2.7: Define the task pipeline
Define the task pipeline as per the details given below:

1
2
3
4
5
6
7
8
| Task | Functionality |
| ----------------- | ------- |
|First task 	| `unzip_data` |
|Second task | `extract_data_from_csv` |
|Third task 	| `extract_data_from_tsv` |
|Fourth task | `extract_data_from_fixed_width` |
|Fifth task 	| `consolidate_data` |
|Sixth task 	| `transform_data` |

Copied!

Wrap Toggled!
Take a screenshot of the task pipeline section of the DAG. Name the screenshot task_pipeline.jpg.

At the end of this exercise, you should have the following screenshots with .jpg or .png extension:

unzip_data.jpg
extract_data_from_csv.jpg
extract_data_from_tsv.jpg
extract_data_from_fixed_width.jpg
consolidate_data.jpg
transform.jpg
task_pipeline.jpg

###### Code ######

# import the libraries
from datetime import timedelta
# To instantiate a DAG
from airflow.models import DAG

# install operators
from airflow.operators.bash_operator import BashOperator

# Define DAG arguments
default_args = {
    'owner': 'Bob',
    'start_date': days_ago(0),
    'email': ['dummy@email.com'],
    'email_on_failure': True,
    'email_on_retry': True
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
dag = DAG(
    dag_id='ETL_toll_data',
    schedule_interval=timedelta(days=1),
    default_args=default_args,
    description='Apache Airflow Final Assignment',
)

# define task1 unzip_data
unzip_data = BashOperator(
    task_id='unzip_data',
    bash_command='tar -xvzf /home/project/airflow/dags/finalassignment/tolldata.tgz -C /home/project/airflow/dags/finalassignment/staging',
    dag=dag,
)

# define task2 extract_data_from_csv
extract_data_from_csv = BashOperator(
    task_id='extract_data_from_csv',
    bash_command="cut -d',' -f1,2,3,4 /home/project/airflow/dags/finalassignment/staging/vehicle-data.csv > /home/project/airflow/dags/finalassignment/staging/vehicle-data.csv",
    dag=dag,
)

# define task3 (2.3) extract_data_from_csv
extract_data_from_tsv = BashOperator(
    task_id='extract_data_from_tsv',
    bash_command="cut -d',' -f5,6,7 /home/project/airflow/dags/finalassignment/staging/tollplaza-data.tsv > /home/project/airflow/dags/finalassignment/staging/tsv_data.csv",
    dag=dag,
)


# define task4 (2.4) extract_data_from_fixed_width
extract_data_from_fixed_width = BashOperator(
    task_id='extract_data_from_fixed_width',
    bash_command="cut -d',' -f6,7 /home/project/airflow/dags/finalassignment/staging/payment-data.txt > /home/project/airflow/dags/finalassignment/staging/fixed_width_data.csv",
    dag=dag,
)

# define task5 (2.5) consolidate_data
consolidate_data = BashOperator(
    task_id='consolidate_data',
    bash_command="""
        paste -d',' \
        /home/project/airflow/dags/finalassignment/csv_data.csv \
        /home/project/airflow/dags/finalassignment/tsv_data.csv \
        /home/project/airflow/dags/finalassignment/fixed_width_data.csv \
        > /home/project/airflow/dags/finalassignment/extracted_data.csv
    """,
    dag=dag,
)

# define task6 (2.6) transform_data
transform_data = BashOperator(
    task_id='transform_data',
    bash_command="""
        awk -F',' 'BEGIN {OFS=","} {$4=toupper($4); print}' \
        /home/project/airflow/dags/finalassignment/extracted_data.csv \
        > /home/project/airflow/dags/finalassignment/transformed_data.csv
    """,
    dag=dag,
)

# Define task pipeline (2.7)
unzip_data > extract_data_from_csv > extract_data_from_tsv > extract_data_from_fixed_width > consolidate_data > transform_data



#### End Code #####

# In terminal:

# Submit dag ( just paste dag file into dag directory)
cp /home/project/ETL_toll_data.py /home/project/airflow/dags



mkdir -p /home/project/staging
tar -xvzf /home/project/tolldata.tgz -C /home/project/staging


######## ETL_toll_data.py code #######

# import the libraries
from datetime import timedelta
# To instantiate a DAG
from airflow.models import DAG

# install operators
from airflow.operators.bash_operator import BashOperator

# Define DAG arguments
default_args = {
    'owner': 'Bob',
    'start_date': days_ago(0),
    'email': ['dummy@email.com'],
    'email_on_failure': True,
    'email_on_retry': True,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
dag = DAG(
    dag_id='ETL_toll_data',
    schedule_interval=timedelta(days=1),
    default_args=default_args,
    description='Apache Airflow Final Assignment',
)

# define task1 unzip_data
unzip_data = BashOperator(
    task_id='unzip_data',
    bash_command='tar -xvzf /home/project/airflow/dags/finalassignment/tolldata.tgz -C /home/project/airflow/dags/finalassignment/staging',
    dag=dag,
)

# define task2 extract_data_from_csv
extract_data_from_csv = BashOperator(
    task_id='extract_data_from_csv',
    bash_command="cut -d',' -f1,2,3,4 /home/project/airflow/dags/finalassignment/staging/vehicle-data.csv > /home/project/airflow/dags/finalassignment/staging/vehicle-data.csv",
    dag=dag,
)

# define task3 (2.3) extract_data_from_csv
extract_data_from_tsv = BashOperator(
    task_id='extract_data_from_tsv',
    bash_command="cut -d',' -f5,6,7 /home/project/airflow/dags/finalassignment/staging/tollplaza-data.tsv > /home/project/airflow/dags/finalassignment/staging/tsv_data.csv",
    dag=dag,
)


# define task4 (2.4) extract_data_from_fixed_width
extract_data_from_fixed_width = BashOperator(
    task_id='extract_data_from_fixed_width',
    bash_command="cut -d',' -f6,7 /home/project/airflow/dags/finalassignment/staging/payment-data.txt > /home/project/airflow/dags/finalassignment/staging/fixed_width_data.csv",
    dag=dag,
)

# define task5 (2.5) consolidate_data
consolidate_data = BashOperator(
    task_id='consolidate_data',
    bash_command="""
        paste -d',' \
        /home/project/airflow/dags/finalassignment/csv_data.csv \
        /home/project/airflow/dags/finalassignment/tsv_data.csv \
        /home/project/airflow/dags/finalassignment/fixed_width_data.csv \
        > /home/project/airflow/dags/finalassignment/extracted_data.csv
    """,
    dag=dag,
)

# define task6 (2.6) transform_data
transform_data = BashOperator(
    task_id='transform_data',
    bash_command="""
        awk -F',' 'BEGIN {OFS=","} {$4=toupper($4); print}' \
        /home/project/airflow/dags/finalassignment/extracted_data.csv \
        > /home/project/airflow/dags/finalassignment/transformed_data.csv
    """,
    dag=dag,
)

# Define task pipeline (2.7)
unzip_data > extract_data_from_csv > extract_data_from_tsv > extract_data_from_fixed_width > consolidate_data > transform_data

#######################################
