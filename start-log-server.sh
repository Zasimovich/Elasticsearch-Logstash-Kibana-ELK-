#! /bin/bash

docker stop `docker ps -a -q`
docker rm `docker ps -a -q`
systemctl restart docker
sleep 3
docker run -d -p 9200:9200 -p 9300:9300 -it -v /opt/esdata:/usr/share/elasticsearch/data -h elasticsearch --name elasticsearch elasticsearch
sleep 3
docker run -d  -p 80:5601 -h kibana --name kibana --link elasticsearch:elasticsearch kibana
sleep 3
docker run -p 9500:9500 -h logstash --name logstash --link elasticsearch:elasticsearch -it -d -v /root/ELK/config-dir:/config-dir logstash -f /config-dir/logstash.conf
