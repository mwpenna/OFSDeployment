#!/bin/bash

rm gateway/OFSEurekaGateway-0.0.1-SNAPSHOT.jar 

docker stop $(docker ps -a -q)

docker rm $(docker ps -a -q)

docker rmi couchbase-server-ofs

docker rmi couchbase-ofs

docker rmi couchbase

docker rmi couchbase/sync-gateway

docker rmi eureka-gateway-image 

docker build -t couchbase-server-ofs ./couchbase

docker build -t couchbase-sync-gateway-ofs ./sync-gateway

cp ../OFSEurekaGateway/target/OFSEurekaGateway-0.0.1-SNAPSHOT.jar gateway/

docker build -t eureka-gateway-image ./gateway

echo $(docker images)

docker-compose run -d --service-ports --name couchbase-master couchbase-master

sleep 45

docker-compose run -d --service-ports --name couchbase-worker couchbase-worker

sleep 15

docker-compose run -d --service-ports --name gateway gateway

docker-compose run -d --service-ports --name eureka-gateway eureka-gateway
