Industrial Cyber Defense Digital Twin Platform
A containerized, automated and monitored IIoT platform built on Linux, Docker and GNS3. A thermal power plant digital twin publishes telemetry over MQTT (with TLS), a pipeline of Node-RED, InfluxDB and Grafana processes and visualizes it, and a segmented network with a firewall and IDS monitors the traffic. A GitHub Actions pipeline validates and smoke-tests the stack on every push.
Design idea: one common platform (deployment, telemetry, monitoring, detection) + pluggable industrial digital twins. Plants are added without changing the platform.
Component
Status
Status
Thermal power plant digital twin (Modbus TCP, PLC-style controllers)
Built and tested
Dockerized telemetry stack (Mosquitto, Node-RED, InfluxDB, Grafana)
Built
Health checks, smoke tests, GitHub Actions CI
Built
MQTT over TLS
Built
GNS3 network with OPNsense, Kali, Ubuntu Server
In progress
Suricata, Zeek, Wazuh monitoring
In progress
Attack simulation and autonomous mitigation
Planned
Hydro and Wind plant twins
Planned
Network layout (GNS3, Purdue-style segmentation)
Level
Subnet
Components
4/5 Enterprise
10.0.1.0/24
Kali Linux (adversary), OPNsense firewall, enterprise workstation
3.5 DMZ
10.0.2.0/24
Mosquitto MQTT broker, InfluxDB historian
3 Operations
10.0.3.0/24
Grafana and Three.js SCADA view, Suricata, Zeek, Wazuh
1/2 Control
10.0.4.0/24
OpenPLC controllers (plant twins)
DevOps practices in this project
Containerization: all services run in Docker, defined in one docker-compose.yml
Infrastructure as code: the whole stack starts with one command from versioned config
Health checks and startup ordering: depends_on with service_healthy
CI pipeline (GitHub Actions): ShellCheck, compose validation, stack start, health wait, smoke tests
Secrets management: credentials in .env (git-ignored), only .env.example is committed
Monitoring and observability: Grafana dashboards, InfluxDB time series, Suricata alerts
Secure communication: TLS-encrypted MQTT listener with generated certificates
Linux administration: Ubuntu Server hosts, service and log management, network troubleshooting
Linux and virtualization: Ubuntu Server, Docker, VirtualBox, VMware, GNS3
Automation scripts: Bash scripts for certificate generation, health waiting and smoke testing
Telemetry and messaging: Mosquitto MQTT, Node-RED
Tech stack
Data and dashboards: InfluxDB, Grafana, Three.js
Industrial protocols: Modbus TCP, OpenPLC
Networking and security: OPNsense, Suricata, Zeek, Wazuh, Wireshark, Nmap
CI/CD: GitHub Actions, Bash
Quick start
Prerequisites: Docker Engine with the Compose plugin, openssl, git, Python 3.
CI pipeline
.github/workflows/ci.yml runs on every push to main and on pull requests:
Lint shell scripts with ShellCheck
Create .env and TLS certificates
Validate docker-compose.yml
Start the stack and wait for all health checks
Run MQTT, InfluxDB, Grafana and Node-RED smoke tests
Print logs on failure and tear down
Project structure
.
├── docker-compose.yml
├── .env.example
├── mosquitto/config/mosquitto.conf
├── grafana/provisioning/datasources/influxdb.yml
├── scripts/            # gen-certs.sh, wait-healthy.sh, smoke-test.sh
├── .github/workflows/  # ci.yml
└── docs/               # diagrams, screenshots, network topology
Roadmap
[ ] Grafana dashboard JSON exported and provisioned from the repo
[ ] Finish the GNS3 segmented network and document the topology in docs/
[ ] Attack simulation and automated detection and response
[ ] Signed configuration push through a CI/CD pipeline
[ ] Deploy to a cloud VM (AWS/Azure free tier)
[ ] Infrastructure as code with Ansible or Terraform
[ ] Additional plant twins (Hydro, Wind)
Author
Sanjeev M - sanjeevmt09@gmail.com - GitHub - LinkedIn
