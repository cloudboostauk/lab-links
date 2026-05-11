#!/bin/bash
cd /home/ec2-user/quickshop-app
sudo pkill node || true
nohup node app.js > /home/ec2-user/quickshop.log 2>&1 &