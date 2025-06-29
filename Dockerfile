# Stage 1: Build optimized Keycloak server
FROM quay.io/keycloak/keycloak:latest AS builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres

WORKDIR /opt/keycloak

# Generate self-signed cert (for demo only, replace for production)
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore

RUN /opt/keycloak/bin/kc.sh build

# Stage 2: Runtime image
FROM quay.io/keycloak/keycloak:latest

COPY --from=builder /opt/keycloak/ /opt/keycloak/
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENV KC_DB=postgres
# Don't set sensitive DB values here! Set in Render dashboard environment variables.
ENV KC_HOSTNAME=0.0.0.0
ENV PORT=8080

ENTRYPOINT ["/entrypoint.sh"]
