osascript -e 'tell app "Terminal" to set bounds of front window to {500, 22, 1000, 200}'
cd ~/Downloads/kafka/
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic output-test