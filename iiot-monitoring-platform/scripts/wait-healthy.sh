#!/usr/bin/env bash
# Wait until all platform containers report "healthy".
set -euo pipefail

CONTAINERS=(iiot-mosquitto iiot-influxdb iiot-nodered iiot-grafana)
TIMEOUT="${1:-180}"
START=$(date +%s)

for c in "${CONTAINERS[@]}"; do
  echo -n "Waiting for $c ... "
  while true; do
    status=$(docker inspect --format '{{if .State.Health}}{{.State.Health.Status}}{{else}}none{{end}}' "$c" 2>/dev/null || echo "missing")
    if [[ "$status" == "healthy" ]]; then
      echo "healthy"
      break
    fi
    if (( $(date +%s) - START > TIMEOUT )); then
      echo "TIMEOUT (status: $status)"
      docker compose logs --tail=50 || true
      exit 1
    fi
    sleep 3
  done
done
echo "All services are healthy."
