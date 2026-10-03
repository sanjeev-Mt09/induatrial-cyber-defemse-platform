#!/usr/bin/env bash
# Basic end-to-end checks for the platform.
set -euo pipefail

echo "1) MQTT publish/subscribe round trip"
TOPIC="plant/test/$(date +%s)"
docker exec iiot-mosquitto sh -c \
  "mosquitto_sub -h localhost -t '$TOPIC' -C 1 -W 10 > /tmp/msg.txt &
   sleep 1
   mosquitto_pub -h localhost -t '$TOPIC' -m 'ok'
   wait
   grep -q ok /tmp/msg.txt"
echo "   MQTT OK"

echo "2) InfluxDB health"
docker exec iiot-influxdb influx ping
echo "   InfluxDB OK"

echo "3) Grafana health"
docker exec iiot-grafana wget -q -O - http://localhost:3000/api/health | grep -q '"database": "ok"'
echo "   Grafana OK"

echo "4) Node-RED reachable"
docker exec iiot-nodered wget -q --spider http://localhost:1880
echo "   Node-RED OK"

echo "Smoke test passed."
