from pyspark.sql import SparkSession
from pyspark.sql.functions import *
from pyspark.sql.types import *

import time

kafka_topic_name = "test-input"
kafka_bootstrap_servers = 'localhost:9092'

if __name__ == "__main__":
    print("Welcome to DataMaking !!!")
    print("Stream Data Processing Application Started ...")
    print(time.strftime("%Y-%m-%d %H:%M:%S"))

    spark = SparkSession \
        .builder \
        .appName("PySpark Structured Streaming with Kafka and Message Format as JSON") \
        .master("local[*]") \
        .getOrCreate()

    spark.sparkContext.setLogLevel("ERROR")

    orders_df = spark \
        .readStream \
        .format("kafka") \
        .option("kafka.bootstrap.servers", kafka_bootstrap_servers) \
        .option("subscribe", kafka_topic_name) \
        .option("startingOffsets", "latest") \
        .option("failOnDataLoss","false") \
        .load()

    print("Printing Schema of orders_df: ")
    orders_df.printSchema()

    orders_df1 = orders_df.selectExpr("CAST(value AS STRING)", "timestamp")

    orders_schema = StructType() \
        .add("user_name", StringType()) \
        .add("time_post", StringType()) \
        .add("comment_post", StringType()) \
        .add("num_like", StringType()) \
        .add("num_subcomments", StringType()) \
        .add("datetime", StringType())

    orders_df2 = orders_df1\
        .select(from_json(col("value"), orders_schema)\
        .alias("comments"), "timestamp")

    orders_df3 = orders_df2.select("comments.*", "timestamp")

    orders_df4 = orders_df3 \
        .select("user_name", "comment_post","num_like","datetime")

    print("Printing Schema of orders_df4: ")
    orders_df4.printSchema()
    
    # .select(col("user_name"),to_json(struct("*"))).toDF("key","value") \
    
    orders_agg_write_stream = orders_df4 \
        .select(to_json(struct("*")).alias("value"))\
        .writeStream \
        .trigger(processingTime='10 seconds') \
        .outputMode('update') \
        .format("kafka") \
        .option("kafka.bootstrap.servers", kafka_bootstrap_servers) \
        .option("topic", "output-test") \
        .option("checkpointLocation", "checkpoint") \
        .start()
    
    # Write final result into console for debugging purpose
    orders_start_agg_write_stream = orders_df4 \
        .select(to_json(struct("*")).alias("value")) \
        .writeStream \
        .trigger(processingTime='5 seconds') \
        .outputMode("update") \
        .option("truncate", "false")\
        .format("console").start()
    
    orders_agg_write_stream.awaitTermination()

    print("Stream Data Processing Application Completed.")