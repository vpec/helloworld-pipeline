#!/bin/bash
curl -L -O https://artifacts.elastic.co/downloads/beats/heartbeat/heartbeat-7.6.2-amd64.deb
sudo dpkg -i heartbeat-7.6.2-amd64.deb
rm heartbeat-7.6.2-amd64.deb
sudo cp heartbeat.yaml /etc/heartbeat/heartbeat.yml
sudo heartbeat setup
sudo service heartbeat-elastic start
