# Use the official MongoDB image as the base
FROM mongo:8.0

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the replica set initialization script into the container
COPY init-replica.sh /docker-entrypoint-initdb.d/

# Ensure the initialization script has execution permissions
RUN chmod +x /docker-entrypoint-initdb.d/init-replica.sh

