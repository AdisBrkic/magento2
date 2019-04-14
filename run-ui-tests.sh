#!/bin/bash
set -e

export VERSION=`jq .[0].release SHOPVERSIONS`

git clone https://github.com/AdisBrkic/docker-magento2.git
cd docker-magento2
docker-compose up -d
docker exec -it dockermagento2_web_1 install-magento
docker exec -it dockermagento2_web_1 install-sampledata
sleep 30s