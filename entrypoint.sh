#!/bin/bash
set -e

echo "🧪 entrypoint kicked off, PORT=$PORT"
/opt/keycloak/bin/kc.sh show-config

echo "✅ Starting Keycloak on port ${PORT:-8080}"
exec /opt/keycloak/bin/kc.sh start --optimized --http-port=${PORT:-8080}