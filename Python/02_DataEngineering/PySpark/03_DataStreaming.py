#!C:\Python38\Python
#coding=utf-8

import os, datetime
import pyspark
from pyspark.sql import SparkSession
from pyspark import SparkContext
from operator import add
from pyspark.sql.types import StructType,StructField, StringType, IntegerType

pid = os.getpid()

# 3.1.1对应spark3.1.1, 2.12对应scala2.12
spark = SparkSession.builder.appName('SparkByExamples.com').config('spark.jars.packages', 'org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.1').getOrCreate()

sc = spark.sparkContext

#----------------------
# Data Streaming:
#
# kafka, TCP Socket, HDFS/S3, Flume ==>  Spark ==> HDFS/Databases/Dashboards
#
#----------------------

# https://sparkbyexamples.com/pyspark-tutorial/#external-data-sources

# Streaming from TCP Socket
# df = spark.readStream.format("socket").option("host","localhost").option("port","9090").load()

# Streaming from Kafka
df = spark.readStream.format("kafka").option("kafka.bootstrap.servers", "localhost:9092").option("subscribe", "Hello-Kafka").option("startingOffsets", "earliest").load()
print("----------------")
df.collect.foreach(println)
df.writeStream.format("console").start()
df.printSchema()
		   
print("----------------")

exit()


# creating DataFrame
data = [('James','','Smith','1991-04-01','M',3000), ('Michael','Rose','','2000-05-19','M',4000), ('Robert','','Williams','1978-09-05','M',4000), ('Maria','Anne','Jones','1967-12-01','F',4000), ('Jen','Mary','Brown','1980-02-17','F',-1)]
columns = ["firstname","middlename","lastname","dob","gender","salary"]
df = spark.createDataFrame(data=data, schema = columns)
df.printSchema()

# creating DataFrame from external data sources

# csv file 
df = spark.read.csv("file:///C:/00/02-FAJob/techTrees/Python/02_DataEngineering/PySpark/DataFrame_test.csv")
#s3 which is also called classic (s3: filesystem for reading from or storing objects in Amazon S3 This has been deprecated and recommends using either the second or third generation library.
# https://sparkbyexamples.com/spark/write-read-csv-file-from-s3-into-dataframe/
#df = spark.read.csv("s3a://sparkbyexamples/csv/zipcodes.csv")
df.printSchema()
df.show(truncate=False)

# text file 
df2 = spark.read.text("file:///C:/00/02-FAJob/techTrees/Python/02_DataEngineering/PySpark/MLibTest.txt")
df2.printSchema()
df2.show(truncate=False)

# json file 
df3 = spark.read.json("file:///C:/00/02-FAJob/techTrees/Python/02_DataEngineering/PySpark/df_test.json")
df3.show(truncate=False)

# Parquet File
# Apache Parquet file is a columnar storage format available to any project in the Hadoop ecosystem, 
# regardless of the choice of data processing framework, data model, or programming language
# https://sparkbyexamples.com/pyspark/pyspark-read-and-write-parquet-file/
# https://www.jianshu.com/p/47b39ae336d5

# StructType() StructField()
data2 = [("James","","Smith","36636","M",3000),
    ("Michael","Rose","","40288","M",4000),
    ("Robert","","Williams","42114","M",4000),
    ("Maria","Anne","Jones","39192","F",4000),
    ("Jen","Mary","Brown","","F",-1)
  ]

schema = StructType([ \
    StructField("firstname",StringType(),True), \
    StructField("middlename",StringType(),True), \
    StructField("lastname",StringType(),True), \
    StructField("id", StringType(), True), \
    StructField("gender", StringType(), True), \
    StructField("salary", IntegerType(), True) \
  ])
 
df = spark.createDataFrame(data=data2,schema=schema)
df.printSchema()
df.show(truncate=False)

fileName = "./" + str(pid) + "df.parquet"
# df.write.mode('append').parquet(fileName)
df.write.mode("overwrite").parquet(fileName) 
parDF=spark.read.parquet(fileName)
parDF.show(truncate=False)

spark.sql("CREATE TEMPORARY VIEW PERSON USING parquet OPTIONS (path \"%s\")" % (fileName))
spark.sql("SELECT * FROM PERSON where salary > 3000").show()

# Avro files
#df.write.mode("overwrite").format("avro").save("person.avro")

#----------------------
# RDD <--> DataFrame
#----------------------
'''
rdd = sc.parallelize ([1, 4, 2, -8, 20, 39, 45], 2)

# Converts RDD to DataFrame
dfFromRDD1 = rdd.toDF()
# Converts RDD to DataFrame with column names
dfFromRDD2 = rdd.toDF("col1","col2")
# using createDataFrame() - Convert DataFrame to RDD
df = spark.createDataFrame(rdd).toDF("col1","col2")
# Convert DataFrame to RDD
rdd = df.rdd
'''

#----------------------
# PySpark SQL
#----------------------

print(" ====  PySpark SQL  ====")
df.createOrReplaceTempView("PERSON_DATA")
df2 = spark.sql("SELECT * from PERSON_DATA")
df2.printSchema()
df2.show()

groupDF = spark.sql("SELECT gender, count(*) from PERSON_DATA group by gender")
groupDF.show()
