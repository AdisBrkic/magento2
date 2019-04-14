#!/bin/bash
set -e

export MAGENTO_CONTAINER_NAME=web

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker-compose build --build-arg GATEWAY=API-TEST web
docker-compose up > /dev/null &

while ! $(curl --output /dev/null --silent --head --fail "${NGROK_URL}"); do
    echo "Waiting for docker container to initialize"
    sleep 20
done

docker exec -it ${MAGENTO_CONTAINER_NAME} install-magento
docker exec -it ${MAGENTO_CONTAINER_NAME} install-sampledata
echo "Deploy finished!"
sleep 240s