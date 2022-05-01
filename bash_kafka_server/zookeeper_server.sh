#!/bin/bash
osascript -e 'tell app "Terminal" to set bounds of front window to {0, 22, 500, 200}'
cd ~/Downloads/kafka/
bin/zookeeper-server-start.sh config/zookeeper.properties
# bin/zookeeper-server-start.sh config/zookeeper.properties 