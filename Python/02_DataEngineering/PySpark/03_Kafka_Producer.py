#!C:\Python38\Python
#coding=utf-8

from time import sleep
from json import dumps
from kafka import KafkaProducer

'''
bootstrap_servers=[‘localhost:9092’]: sets the host and port the producer should contact to bootstrap initial cluster metadata. It is not necessary to set this here, since the default is localhost:9092.
value_serializer=lambda x: dumps(x).encode(‘utf-8’): function of how the data should be serialized before sending to the broker. Here, we convert the data to a json file and encode it to utf-8.
'''

producer = KafkaProducer(bootstrap_servers=['localhost:9092'], value_serializer=lambda x: dumps(x).encode('utf-8'))

for e in range(10):
    data = {'number' : e}
    print('{} sended'.format(data))
    producer.send('numtest', value=data)
    sleep(5)


'''
--bootstrap-server         String         要连接的服务器. 必需(除非指定--broker-list)	形如：host1:prot1,host2:prot2
--topic                    String         (必需)接收消息的主题名称	
--broker-list              String         已过时要连接的服务器	形如：host1:prot1,host2:prot2
--batch-size               Integer        单个批处理中发送的消息数	200(默认值)
--compression-codec        String         压缩编解码器	none、gzip(默认值)  snappy、lz4、zstd
--max-block-ms             Long           在发送请求期间，生产者将阻止的最长时间	60000(默认值)
--max-memory-bytes         Long           生产者用来缓冲等待发送到服务器的总内存	33554432(默认值)
--max-partition-memory-bytes  Long        为分区分配的缓冲区大小	16384
--message-send-max-retries    Integer     最大的重试发送次数	3
--metadata-expiry-ms       Long           强制更新元数据的时间阈值(ms)	300000
--producer-property        String         将自定义属性传递给生成器的机制	形如：key=value
--producer.config          String         生产者配置属性文件[--producer-property]优先于此配置        配置文件完整路径
--property                 String         自定义消息读取器	parse.key=true|false key.separator=<key.separator> ignore.error=true|false
--request-required-acks    String         生产者请求的确认方式	0、1(默认值)、all
--request-timeout-ms       Integer        生产者请求的确认超时时间	1500(默认值)
--retry-backoff-ms         Integer        生产者重试前，刷新元数据的等待时间阈值	100(默认值)
--socket-buffer-size       Integer        TCP接收缓冲大小	102400(默认值)
--timeout                  Integer        消息排队异步等待处理的时间阈值	1000(默认值)
--sync                     同步发送消息	
--version                  显示 Kafka 版本不配合其他参数时，显示为本地Kafka版本	
--help                     打印帮助信息
'''
