osascript -e 'tell app "Terminal" to set bounds of front window to {0, 600, 500, 800}'
cd ~/Downloads/kafka/
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test-input