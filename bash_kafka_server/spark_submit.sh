osascript -e 'tell app "Terminal" to set bounds of front window to {500, 400, 1000, 600}'
. ~/.bash_profile
cd ~/kafka-running/
spark-submit --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.2.1 comment_demo.py   