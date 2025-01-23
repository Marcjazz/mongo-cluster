# Use the official MongoDB base image
FROM mongo:7.0

# Set up working directory
WORKDIR /scripts

# Copy the initialization script into the container
COPY replica-init.sh /scripts/replica-init.sh

# Generate the keyfile (run as part of the build process)
RUN openssl rand -base64 756 > /etc/mongo-keyfile && \
    chmod 600 /etc/mongo-keyfile && \
    chown mongodb:mongodb /etc/mongo-keyfile

# Expose MongoDB ports
EXPOSE 27017 27018 27019

# Entrypoint to start MongoDB and initialize replica set
CMD ["sh", "-c", "mongod --replSet rs0 --bind_ip_all --keyFile /etc/mongo-keyfile --auth && sleep 5 && . /scripts/replica-init.sh"]
