#!/bin/bash
osascript -e 'tell app "Terminal" to set bounds of front window to {500, 600, 1000, 800}'

#=================================RUN KAFKA SERVER=============================
#RUN ZOOKEEPER
osascript -e 'tell app "Terminal"
   do script ". ~/bash_kafka_server/zookeeper_server.sh" 
end tell'

sleep 10
#RUN BROKER
osascript -e 'tell app "Terminal"
   do script ". ~/bash_kafka_server/broker_server.sh" 
end tell'

sleep 5

#CREATE TOPIC "test-input"
#CREATE TOPIC "output-test"
osascript -e 'tell app "Terminal"
   do script ". ~/bash_kafka_server/create_topic.sh" 
end tell'

sleep 8
#RUN CONSOLE PRODUCER "test-input"
osascript -e 'tell app "Terminal"
   do script ". ~/bash_kafka_server/producer_console.sh" 
end tell'

sleep 3 

#RUN CONSOLE CONSUMER "output-test"
osascript -e 'tell app "Terminal"
   do script ". ~/bash_kafka_server/consumer_console.sh" 
end tell'

sleep 3

#RUN JUPYTER NOTEBOOK
osascript -e 'tell app "Terminal"
   do script ". ~/bash_kafka_server/jupyter_server.sh" 
end tell'

sleep 2
#RUN CONSOLE SPARK-SUBMIT
osascript -e 'tell app "Terminal"
   do script ". ~/bash_kafka_server/spark_submit.sh" 
end tell'