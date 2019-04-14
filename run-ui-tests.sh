#!/bin/bash
set -e

curl -s https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > ngrok.zip
unzip ngrok.zip
chmod +x ngrok

ngrok authtoken 53c6WVprQB4dpNDZnLiLr_2XALf7e5gUCFALtrz5pmE

NGROK_URL = ngrok http 9090 -subdomain="magento2-api-test" > /dev/null &

while [ ! ${NGROK_URL} ] || [ ${NGROK_URL} = 'null' ];  do
    echo "Waiting for ngrok to initialize"
    export NGROK_URL
    echo $NGROK_URL
    sleep 5
done

bash start-shopsystem.sh