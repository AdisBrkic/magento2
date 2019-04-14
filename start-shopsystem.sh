#!/bin/bash
set -e

docker-compose build --build-arg GATEWAY=API-TEST web
docker-compose up > /dev/null &

while ! $(curl --output /dev/null --silent --head --fail http://f02fc6d3.ngrok.io); do
    echo "Waiting for docker container to initialize"
    sleep 1
done

docker exec -it web install-magento
docker exec -it web install-sampledata
echo "Deploy finished!"
sleep 240s