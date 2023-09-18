#!/bin/bash

while true; do
    rndc flush
    sleep 3
done

curl -o /tmp/DNSCacheFlush https://mainjamesgstorage.blob.core.windows.net/scripts/DNSCacheFlush.sh

sudo chmod +x /tmp/DNSCacheFlush.sh