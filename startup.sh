#!/bin/bash

docker stop $(docker ps -a -q)

docker rm $(docker ps -a -q)

docker rmi couchbase-server-ofs

docker rmi couchbase-ofs

docker rmi couchbase

docker rmi couchbase/sync-gateway

docker build -t couchbase-server-ofs ./couchbase

docker build -t couchbase-sync-gateway-ofs ./sync-gateway

echo docker images

docker-compose run -d --service-ports --name couchbase-master couchbase-master

docker-compose run -d --service-ports --name couchbase-worker couchbase-worker

docker-compose run -d --service-ports --name gateway gateway
