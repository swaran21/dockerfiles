#!/bin/sh
# Use the PORT env var or default to 8080
PORT=${PORT:-8080}

# Start Keycloak binding to all interfaces on that port
exec /opt/keycloak/bin/kc.sh start --http-port=${PORT} --hostname-strict=false --hostname=0.0.0.0
