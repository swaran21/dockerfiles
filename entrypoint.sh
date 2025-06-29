#!/bin/bash
set -e

/opt/keycloak/bin/kc.sh start --optimized --http-port=${PORT:-8080}