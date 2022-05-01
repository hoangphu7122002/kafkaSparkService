#!/bin/bash

osascript -e 'tell app "Terminal" to set bounds of front window to {0, 200, 500, 400}'
cd ~/Downloads/kafka/
bin/kafka-server-start.sh config/server.properties
# bin/zookeeper-server-start.sh config/zookeeper.properties 