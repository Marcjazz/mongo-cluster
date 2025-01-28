#!/bin/bash

# Exit on error
set -e

# Directory for generated certificates
CERTS_DIR="./certs"
mkdir -p "$CERTS_DIR"

echo "Generating CA (Certificate Authority)..."
# Generate a private key for the CA
openssl genrsa -out "$CERTS_DIR/ca.key" 4096

# Generate the CA certificate
openssl req -x509 -new -nodes -key "$CERTS_DIR/ca.key" -sha256 -days 3650 \
  -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=CA" \
  -out "$CERTS_DIR/ca.crt"

echo "CA certificate generated."

# Function to generate a certificate and key for a MongoDB instance
generate_cert() {
  INSTANCE=$1
  mkdir -p $CERTS_DIR/$INSTANCE
  echo "Generating certificate for $INSTANCE..."

  # Generate a private key for the instance
  openssl genrsa -out "$CERTS_DIR/$INSTANCE/mongo.key" 4096

  # Create a certificate signing request (CSR)
  openssl req -new -key "$CERTS_DIR/$INSTANCE/mongo.key" \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=$INSTANCE" \
    -out "$CERTS_DIR/$INSTANCE/mongo.csr"

  # Generate the signed certificate using the CA
  openssl x509 -req -in "$CERTS_DIR/$INSTANCE/mongo.csr" -CA "$CERTS_DIR/ca.crt" \
    -CAkey "$CERTS_DIR/ca.key" -CAcreateserial -out "$CERTS_DIR/$INSTANCE/mongo.crt" \
    -days 365 -sha256

  # Combine the instance key and certificate into a single PEM file
  cat "$CERTS_DIR/$INSTANCE/mongo.key" "$CERTS_DIR/$INSTANCE/mongo.crt" > "$CERTS_DIR/$INSTANCE/mongo.pem"

  echo "Certificate for $INSTANCE generated."
}

# Generate certificates for each MongoDB instance
generate_cert "mongo1"
generate_cert "mongo2"
generate_cert "mongo3"
generate_cert "mongo-express"

echo "All certificates generated."

# Set permissions (optional)
chmod 600 "$CERTS_DIR"/*

echo "Certificates are available in the $CERTS_DIR directory."
