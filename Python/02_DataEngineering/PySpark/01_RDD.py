#!C:\Python38\Python
#coding=utf-8

import os, datetime
import pyspark
from pyspark.sql import SparkSession
from pyspark import SparkContext
from operator import add

# RDD: Resilient Distributed Dataset
# https://sparkbyexamples.com/pyspark-rdd/#what-is-rdd
# https://sparkbyexamples.com/pyspark/pyspark-rdd-transformations/
# https://sparkbyexamples.com/pyspark/pyspark-rdd-actions/

pid = os.getpid()

'''
starttime = datetime.datetime.now()
endtime = datetime.datetime.now()
print("== time: %i" %((endtime - starttime).seconds))
'''

#--------------------------
# create SparkContext
#--------------------------

# 1. 
#sc = SparkContext("local", "first app")

# 2. 
spark = SparkSession.builder.appName('SparkByExamples.com').getOrCreate()
sc = spark.sparkContext

# set log level as Error 
sc.setLogLevel("Error")
# sc.stop()

#--------------------------
# create RDD
#--------------------------

# 1. parallelize()
rdd = sc.parallelize ([1, 4, 2, -8, 20, 39, 45], 2)
print("rdd is: %s" % (rdd.collect()))

# 2. textFile()
rdd2 = sc.textFile("file:///C:/00/02-FAJob/techTrees/Python/02_DataEngineering/PySpark/MLibTest.txt")
print("rdd2 is: %s" % (rdd2.collect()))

# 3. wholeTextFiles()
rdd3 = sc.wholeTextFiles("file:///C:/00/02-FAJob/techTrees/Python/02_DataEngineering/PySpark/MLibTest.txt")
print("rdd3 is: %s" % (rdd3.collect()))

# 4. Creates empty RDD with no partition    
rdd4 = sc.emptyRDD 

# 5. Create empty RDD with partition
rdd5 = sc.parallelize([],10)

#--------------------------
# RDD Operations (Transformations and Actions) 
#--------------------------

print("************ RDD Transformations **********")
'''
There are two types are transformations: Narrow Transformation, Wider Transformation

Narrow transformations are the result of map() and filter() functions and these compute data that live on a single partition 
meaning there will not be any data movement between partitions to execute narrow transformations.
Functions such as map(), mapPartition(), flatMap(), filter(), union() are some examples of narrow transformation

Wider transformations are the result of groupByKey() and reduceByKey() functions and these compute data that live on many partitions
meaning there will be data movements between partitions to execute wider transformations. Since these shuffles the data, 
they also called shuffle transformations.
Functions such as groupByKey(), aggregateByKey(), aggregate(), join(), repartition() are some examples of a wider transformations.

TRANSFORMATION METHODS	METHOD USAGE AND DESCRIPTION
cache()                   Caches the RDD
filter()                  Returns a new RDD after applying filter function on source dataset.
flatMap()                 Returns flattern map meaning if you have a dataset with array, it converts each elements in a array as a row. In other words it return 0 or more items in output for each element in dataset.
map()                     Applies transformation function on dataset and returns same number of elements in distributed dataset.
mapPartitions()           Similar to map, but executs transformation function on each partition, This gives better performance than map function
mapPartitionsWithIndex()  Similar to map Partitions, but also provides func with an integer value representing the index of the partition.
randomSplit()             Splits the RDD by the weights specified in the argument. For example rdd.randomSplit(0.7,0.3)
union()                   Comines elements from source dataset and the argument and returns combined dataset. This is similar to union function in Math set operations.
sample()                  Returns the sample dataset.
intersection()            Returns the dataset which contains elements in both source dataset and an argument
distinct()                Returns the dataset by eliminating all duplicated elements.
repartition()             Return a dataset with number of partition specified in the argument. This operation reshuffles the RDD randamly, It could either return lesser or more partioned RDD based on the input supplied.
coalesce()                Similar to repartition by operates better when we want to the decrease the partitions. Betterment acheives by reshuffling the data from fewer nodes compared with all nodes by repartition.

'''

# 1. repartition() Repartition and Coalesce
print("=========== repartition() ==========")
print("rdd partition count:" + str(rdd.getNumPartitions()))
rpRDD = rdd.repartition(4)
print("re-partition RDD count:"+str(rpRDD.getNumPartitions()))

# 2. flatMap()
print("=========== flatMap() ==========")
testRDD = sc.parallelize(["hello, today is good day", "yes, I think so"])
print("flatMap raw rdd  is: %s" % (testRDD.collect()))
flatTestRDD = testRDD.flatMap(lambda x: x.split(" "))
print("flatMap flated rdd is: %s" % (flatTestRDD.collect()))

# 3. map()
print("========== map() ===========")
mapRDD = rdd.map(lambda x: (x,1))
print("Map rdd is: %s" % (mapRDD.collect()))

# 4. reduceByKey()
print("========== reduceByKey() ===========")
numRDD = sc.parallelize([1, 4, 2, 3, 4, 4, 2, 4])
pairs = numRDD.map(lambda x: (x, 1))  # 针对每个数进行计数1的操作，
print(pairs.collect())  #输出为列表，每个列表中都是一个二元组，key为每个数，value都为1
a = pairs.reduceByKey(lambda x, y: x+y)
b = pairs.reduceByKey(lambda x, y: x+y+1)
c = pairs.reduceByKey(lambda x, y: x+y+3)
print("a is: %s" % (a.collect()))
print("b is: %s" % (b.collect()))
print("c is: %s" % (c.collect()))

# 5. sortByKey()
print("========== sortByKey() ===========")
print(pairs.collect())
sortRdd = pairs.sortByKey()
print("sortByKey is: %s" % (sortRdd.collect()))

# 6. filter()
print("========== filter() ===========")
print("filter raw rdd  is: %s" % (testRDD.collect()))
filterRdd = testRDD.filter(lambda x: "a" in x)
print("filtered rdd is: %s" % (filterRdd.collect()))

# 7. reduce()
print("========== reduce() ===========")
print("rdd is: %s" % (rdd.collect()))
redRdd = rdd.reduce(lambda a,b: a+b+1)
print("dataReduce Record : "+str(redRdd))

# 8. join()
print("========== join() ===========")
x = sc.parallelize([("spark", 1), ("hadoop", 2)])
y = sc.parallelize([("spark", 3), ("hadoop", 6)])
joined = x.join(y)
print("x -> %s" % (x.collect()))
print("y -> %s" % (y.collect()))
print("Joined RDD -> %s" % (joined.collect()))

# 9. cache() & persist()
print("========== cache() & persist() ===========")
rdd.cache()
caching = rdd.persist().is_cached 
print("rdd got chached > %s" % (caching))
rdd.unpersist()

#--------------------------
# RDD Actions 
#--------------------------
print("************  RDD Actions   **********")

# 1. collect()
print("========== collect() ===========")
print("rdd is: %s" % (rdd.collect()))

# 2. count()
print("========== count() ===========")
print("Number of elements in RDD -> %i" % (rdd.count()))

# 3. first()
print("========== first() ===========")
firstRec = rdd.first()
print("First Record : %s" % (firstRec))

# 4. max()
print("========== max() ===========")
maxRec = rdd.max()
print("Max Record : %s" % (maxRec))

# 5. take(int)
print("========== take() ===========")
takeRdd = rdd.take(4)
for i in takeRdd: 
    print("taked number : %i" % (i))

# 6. saveAsTextFile()
print("========== saveAsTextFile() ===========")
fileName = "./" + str(pid) + "saveAsTextFile.txt"
rdd.saveAsTextFile(fileName)
print("save RDD file %s done." % (fileName))

# 7. distinct() 
print("========== distinct() ===========")
print(rdd.distinct().collect())

# 8. toDebugString()
print("========== toDebugString() ===========")
print("debug1 -> ", rdd.toDebugString())

# 9. getNumPartitions()
print("========== getNumPartitions() ===========")
print("initial partition count -> %i" % (rdd.getNumPartitions()))

#10. glom()
print("========== glom() ===========")
print(rdd.glom().collect())

#11. foreach()
print("========== foreach() ===========")
def f(x):
    if x > 5: 
        print(x)

fore = rdd.foreach(f) 
print("foreach is: ",fore)

print("************  RDD Actions 2 **********")

data=[("Z", 1),("A", 20),("B", 30),("C", 40),("B", 30),("B", 60)]
inputRDD = sc.parallelize(data)

listRdd = sc.parallelize([1,2,3,4,5,3,2], 4)

#aggregate
seqOp = (lambda x, y: x + y)
combOp = (lambda x, y: x + y)
agg=listRdd.aggregate(0, seqOp, combOp)
print(agg) 

#aggregate 2
seqOp2 = (lambda x, y: (x[0] + y, x[1] + 1))
combOp2 = (lambda x, y: (x[0] + y[0], x[1] + y[1]))
agg2=listRdd.aggregate((0, 0), seqOp2, combOp2)
print(agg2) # output (20,7)

#treeAggregate()
agg2=listRdd.treeAggregate((0, 0),seqOp2, combOp2)
print(agg2) # output 20

#fold
from operator import add
foldRes=listRdd.fold(0, add)
print(foldRes) # output 20

#reduce
redRes=listRdd.reduce(add)
print(redRes) # output 20

#treeReduce. This is similar to reduce
add = lambda x, y: x + y
redRes=listRdd.treeReduce(add)
print(redRes) # output 20

#Collect
data = listRdd.collect()
print(data)

#count, countApprox, countApproxDistinct
print("Count : "+str(listRdd.count()))
#Output: Count : 20
print("countApprox : "+str(listRdd.countApprox(1200)))
#Output: countApprox : (final: [7.000, 7.000])
print("countApproxDistinct : "+str(listRdd.countApproxDistinct()))
#Output: countApproxDistinct : 5
print("countApproxDistinct : "+str(inputRDD.countApproxDistinct()))
#Output: countApproxDistinct : 5

#countByValue, countByValueApprox
print("countByValue :  "+str(listRdd.countByValue()))

#first
print("first :  "+str(listRdd.first()))
#Output: first :  1
print("first :  "+str(inputRDD.first()))
#Output: first :  (Z,1)

#top
print("top : "+str(listRdd.top(2)))
#Output: take : 5,4
print("top : "+str(inputRDD.top(2)))
#Output: take : (Z,1),(C,40)

#min
print("min :  "+str(listRdd.min()))
#Output: min :  1
print("min :  "+str(inputRDD.min()))
#Output: min :  (A,20)  

#max
print("max :  "+str(listRdd.max()))
#Output: max :  5
print("max :  "+str(inputRDD.max()))
#Output: max :  (Z,1)

#take, takeOrdered, takeSample
print("take : "+str(listRdd.take(2)))
#Output: take : 1,2
print("takeOrdered : "+ str(listRdd.takeOrdered(2)))
#Output: takeOrdered : 1,2
#print("take : "+str(listRdd.takeSample()))

#--------------------------
# RDD Persistence  
#--------------------------
print("************  RDD Persistence    **********")

# cache()
cachedRdd = rdd.cache()

# persist()
# storage level 
'''
MEMORY_ONLY
MEMORY_AND_DISK
MEMORY_ONLY_SER
MEMORY_AND_DISK_SER
DISK_ONLY
MEMORY_ONLY_2
MEMORY_AND_DISK_2

MEMORY_ONLY – This is the default behavior of the RDD cache() method and stores the RDD as deserialized objects to JVM memory. When there is no enough memory available it will not save to RDD of some partitions and these will be re-computed as and when required. This takes more storage but runs faster as it takes few CPU cycles to read from memory.

MEMORY_ONLY_SER – This is the same as MEMORY_ONLY but the difference being it stores RDD as serialized objects to JVM memory. It takes lesser memory (space-efficient) then MEMORY_ONLY as it saves objects as serialized and takes an additional few more CPU cycles in order to deserialize.

MEMORY_ONLY_2 – Same as MEMORY_ONLY storage level but replicate each partition to two cluster nodes.

MEMORY_ONLY_SER_2 – Same as MEMORY_ONLY_SER storage level but replicate each partition to two cluster nodes.

MEMORY_AND_DISK – In this Storage Level, The RDD will be stored in JVM memory as a deserialized objects. When required storage is greater than available memory, it stores some of the excess partitions in to disk and reads the data from disk when it required. It is slower as there is I/O involved.

MEMORY_AND_DISK_SER – This is same as MEMORY_AND_DISK storage level difference being it serializes the RDD objects in memory and on disk when space not available.

MEMORY_AND_DISK_2 – Same as MEMORY_AND_DISK storage level but replicate each partition to two cluster nodes.

MEMORY_AND_DISK_SER_2 – Same as MEMORY_AND_DISK_SER storage level but replicate each partition to two cluster nodes.

DISK_ONLY – In this storage level, RDD is stored only on disk and the CPU computation time is high as I/O involved.

DISK_ONLY_2 – Same as DISK_ONLY storage level but replicate each partition to two cluster nodes.

DISK_ONLY = StorageLevel（True，False，False，False，1）
DISK_ONLY_2 = StorageLevel（True，False，False，False，2）
MEMORY_AND_DISK = StorageLevel（True，True，False，False，1）
MEMORY_AND_DISK_2 = StorageLevel（True，True，False，False，2）
MEMORY_AND_DISK_SER = StorageLevel（True，True，False，False，1）
MEMORY_AND_DISK_SER_2 = StorageLevel（True，True，False，False，2）
MEMORY_ONLY = StorageLevel（False，True，False，False，1）
MEMORY_ONLY_2 = StorageLevel（False，True，False，False，2）
MEMORY_ONLY_SER = StorageLevel（False，True，False，False，1）
MEMORY_ONLY_SER_2 = StorageLevel（False，True，False，False，2）
OFF_HEAP = StorageLevel（True，True，True，False，1）

'''
dfPersist = rdd.persist(pyspark.StorageLevel.MEMORY_ONLY)
dfPersist.show(false)
print("Storage Level -> %s" % dfPersist.getStorageLevel())

stores = sc.parallelize([20,30,40,50]) 
stores.persist( pyspark.StorageLevel.MEMORY_AND_DISK_2 )
print("Storage Level -> %s" % stores.getStorageLevel())

# unpersist()
dfPersistunpersist()

