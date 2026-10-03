Industrial Cyber Defense Digital Twin Platform
A containerized, automated and monitored IIoT platform built on Linux, Docker and GNS3. A thermal power plant digital twin publishes telemetry over MQTT (with TLS), a pipeline of Node-RED, InfluxDB and Grafana processes and visualizes it, and a segmented network with a firewall and IDS monitors the traffic. A GitHub Actions pipeline validates and smoke-tests the stack on every push.
Design idea: one common platform (deployment, telemetry, monitoring, detection) + pluggable industrial digital twins. Plants are added without changing the platform.
