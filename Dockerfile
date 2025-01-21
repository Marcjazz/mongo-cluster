# Use the official MongoDB image as the base
FROM mongo:8.0

# Set the working directory inside the container
WORKDIR /usr/src/app

# Generate mongo keyfile for replica set initialization
RUN openssl rand -base64 756 > /etc/mongo-keyfile

# Copy the replica set initialization script into the container
COPY init-replica.sh /docker-entrypoint-initdb.d/
