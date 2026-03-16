Data Streaming with Kafka
In this lab, you will work with streaming data using Kafka. You will start by configuring the Kafka server to use the Kraft mode followed by starting the Kafka message broker service, creating a topic and then starting the producer and consumer.

Objectives
After completing this lab, you will be able to:

Download Kafka binaries

Configure the Kafka server to use the KRaft mode

Start the Kafka message broker service

Create a topic

Start a producer

Start a consumer

Exercise 1: Download and extract Kafka
Open a new terminal

Next, run the following commands on the terminal.
# Download Kafka by running the command below:
wget https://archive.apache.org/dist/kafka/3.8.0/kafka_2.13-3.8.0.tgz

# Extract Kafka from the zip file by running the command below.
tar -xzf kafka_2.13-3.8.0.tgz


Exercise 2: Configure KRaft and start server
Navigate to the kafka_2.13-3.8.0 directory.


bash
cd kafka_2.13-3.8.0
Run
Generate a cluster UUID that will uniquely identify the Kafka cluster.


bash
KAFKA_CLUSTER_ID="$(bin/kafka-storage.sh random-uuid)"
Run
This cluster id will be used by the KRaft controller.

KRaft requires the log directories to be configured. Run the following command to configure the log directories passing the cluster ID.


bash
bin/kafka-storage.sh format -t $KAFKA_CLUSTER_ID -c config/kraft/server.properties
Run
Now that KRaft is configured, you can start the Kafka server by running the following command.


plaintext
bin/kafka-server-start.sh config/kraft/server.properties
You can be sure that the Kafka server has started when the output displays messages like "Kafka Server started".

Exercise 3: Create a topic and start producer
You need to create a topic before you can start to post messages.

Start a new terminal and change to the kafka_2.13-3.8.0 directory.


bash
cd kafka_2.13-3.8.0
Run
To create a topic named news, run the command below.


plaintext
bin/kafka-topics.sh --create --topic news --bootstrap-server localhost:9092
You will see the message: Created topic news.

You need a producer to send messages to Kafka. Run the command below to start a producer.


plaintext
bin/kafka-console-producer.sh   --bootstrap-server localhost:9092   --topic news
After the producer starts, and you get the '>' prompt, type any text message and press enter. Or you can copy the text below and paste. The below text sends three messages to Kafka.


plaintext
Good morning
Good day
Enjoy the Kafka lab

Exercise 4: Start Consumer
You need a consumer to read messages from Kafka.

Start a new terminal and change to the kafka_2.13-3.8.0 directory.


bash
cd kafka_2.13-3.8.0
Run
Run the command below to listen to the messages in the topic news.


plaintext
bin/kafka-console-consumer.sh   --bootstrap-server localhost:9092   --topic news   --from-beginning
You should see all the messages you sent from the producer appear here.

You can go back to the producer terminal and type some more messages, one message per line, and you will see them appear here.


Exercise 5: Explore Kafka directories
Kafka uses the /tmp//tmp/kraft-combined-logs directory to store the messages.

Start a new terminal and navigate to the kafka_2.13-3.8.0 directory.


bash
cd kafka_2.13-3.8.0
Run
Explore the root directory of the server.


plaintext
ls
Notice there is a tmp directory. The kraft-combine-logs inside the tmp directory contains all the logs. To check the logs generated for the topic news run the following command:


plaintext
ls /tmp/kraft-combined-logs/news-0
Note: All messages are stored in the news-0 directory under the /tmp/kraft-combined-logs directory.


Exercise 6: Clean up
To stop the producer
In the terminal where you are running producer, press CTRL+C.

To stop the consumer
In the terminal where you are running consumer, press CTRL+C.

To stop the Kafka server
In the terminal where you are running Kafka server, press CTRL+C.

Practice exercises
Create a new topic named weather.
Make sure that the Kafka server is still running. Change to the kafka_2.13-3.8.0 directory and run the following command:


plaintext
bin/kafka-topics.sh --create --topic weather --bootstrap-server localhost:9092
Post messages to the topic weather.
Make sure that the Kafka server is still running. Run the following command:


plaintext
bin/kafka-console-producer.sh   --bootstrap-server localhost:9092   --topic weather
Post some test messages.

Read the messages from the topic weather.
Make sure that the Kafka server is still running. In a new terminal, change to kafka_2.13-3.8.0 directory and run the following command:


plaintext
bin/kafka-console-consumer.sh   --bootstrap-server localhost:9092   --topic weather
Make sure that the messages you sent from the producer appear here.
