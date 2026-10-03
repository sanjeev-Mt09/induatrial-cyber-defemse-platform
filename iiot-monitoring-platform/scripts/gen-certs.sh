#!/usr/bin/env bash
# Generate a local CA and a server certificate for Mosquitto TLS (dev/lab use).
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/certs"
mkdir -p "$DIR"
cd "$DIR"

if [[ -f ca.crt && -f server.crt && -f server.key ]]; then
  echo "Certificates already exist in $DIR - skipping."
  exit 0
fi

openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -sha256 -days 365 \
  -subj "/CN=iiot-lab-ca" -out ca.crt

openssl genrsa -out server.key 2048
openssl req -new -key server.key -subj "/CN=localhost" -out server.csr

echo "subjectAltName = DNS:localhost,DNS:mosquitto,IP:127.0.0.1" > server.ext

openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial \
  -out server.crt -days 365 -sha256 -extfile server.ext

# The Mosquitto container user must be able to read the key (lab use only)
chmod 644 server.key server.crt ca.crt
chmod 600 ca.key
rm -f server.csr server.ext ca.srl

echo "Certificates created in $DIR"
