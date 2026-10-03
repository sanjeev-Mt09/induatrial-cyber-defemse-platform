 Industrial Cyber Defense Digital Twin Platform


Enterprise-grade Industrial Cyber Range linking six independent industrial digital-twin environments under a unified cybersecurity, edge computing, telemetry, and autonomous incident-response pipeline.

**Core Axiom:** `Common Cyber Defense Platform + 3 Independent Industrial Digital Twins + Plant-Specific Attack Libraries`

🎯 Executive Vision
Unlike existing testbeds (GRFICS, ICSSIM), our platform provides:
- 6 Pluggable Digital Twins with distinct physics
- Strict Purdue Model Segmentation in GNS3 with OPNsense firewalls
- Autonomous 2-Tier Mitigation: Layer-1 Physical Trip + Layer-2 Firewall Injection
- Cyber-Physical Correlation: Zeek + Suricata + InfluxDB invariants

🏭 Six Plants (10.0.4.0/24)
1. THERMAL - OpenPLC - Modbus:502 - Boiler-Turbine 540°C 165bar 3000RPM(now developing)
In future 
2. HYDRO - Penstock RTU - Modbus:503 - Dam-Francis Turbine
3. WIND - Pitch/Nacelle PLC - OPC-UA:4840 - DFIG Converter

🏗️ Purdue Architecture (GNS3)
LEVEL 4/5 (10.0.1.0/24): Kali Linux Adversary <-> OPNsense Firewall <-> Enterprise WS
LEVEL 3.5 (10.0.2.0/24): Mosquitto MQTT Broker <-> InfluxDB Historian
LEVEL 3 (10.0.3.0/24): Grafana+Three.js SCADA <-> Suricata <-> Zeek <-> Wazuh SIEM
LEVEL 1/2 (10.0.4.0/24): 6 OpenPLC Controllers

💻 Tech Stack
Virtualization: VirtualBox, GNS3, Ubuntu Server, Docker
OT: OpenPLC, Modbus TCP, OPC-UA, Mosquitto MQTT
Processing: Node-RED, Python NumPy/SciPy
Data: InfluxDB, Grafana, Three.js
SOC: Kali, Suricata, Zeek, Wazuh, Wireshark, Nmap

⚔️ Attack & Defense
- Autonomous mitigation, MTTD/MTTR measurement
- Golden Config Push (signed ladder logic) = CI/CD for OT
- Forensic Timeline: PCAPs + Zeek + Wazuh + InfluxDB graphs

🚀 Quick Start
docker-compose up -d mosquitto influxdb nodered grafana
python3 twins/thermal_plant.py --config configs/thermal.json
Grafana: localhost:3000

👨‍💻 Author
Sanjeev M (24csl15) | sanjeevmt09@gmail.com
