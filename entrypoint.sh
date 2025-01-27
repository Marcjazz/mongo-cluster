#!/bin/bash

# Set variables
NODE_NAME=mongo_rs
COMMON_NAME=mongo_rs

# Generate server key and certificate signing request (CSR)
openssl genpkey -algorithm RSA -out /etc/mongo/ssl/server.key
openssl req -new -key /etc/mongo/ssl/server.key -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=${COMMON_NAME}" -out /etc/mongo/ssl/server.csr

# Sign server certificate with CA
openssl x509 -req -in /etc/mongo/ssl/server.csr -CA /etc/mongo/ssl/ca.crt -CAkey /etc/mongo/ssl/ca.key -CAcreateserial -out /etc/mongo/ssl/server.crt -days 365 -sha256

# Combine server key and certificate into a PEM file
cat /etc/mongo/ssl/server.key /etc/mongo/ssl/server.crt > /etc/mongo/ssl/server.pem

# Set permissions for the PEM file
chown mongodb:mongodb /etc/mongo/ssl/server.pem
chmod 600 /etc/mongo/ssl/server.pem

# Start MongoDB with replica set and TLS/SSL enabled
exec mongod --replSet rs0 \
            --tlsMode requireTLS \
            --tlsCertificateKeyFile /etc/mongo/ssl/server.pem \
            --tlsCAFile /etc/mongo/ssl/ca.crt \
            --clusterAuthMode x509 \
            --bind_ip_all
