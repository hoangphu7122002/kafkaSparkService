osascript -e 'tell app "Terminal" to set bounds of front window to {0, 400, 500, 600}'
cd ~/Downloads/kafka/
bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --topic test-input
sleep 10
bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --topic output-test