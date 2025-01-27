# Use the official MongoDB image as the base
FROM mongo:latest

# Install OpenSSL for certificate generation
RUN apt-get update && apt-get install -y openssl && rm -rf /var/lib/apt/lists/*

# Create directories for certificates
RUN mkdir -p /etc/mongo/ssl

# Copy the CA key and certificate into the container
COPY certs/ca.key /etc/mongo/ssl/ca.key
COPY certs/ca.crt /etc/mongo/ssl/ca.crt

# Copy the entrypoint script into the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
