# MongoDB Replica Set Deployment with Docker Compose

This guide provides step-by-step instructions to set up a MongoDB replica set using Docker Compose. A replica set in MongoDB is a group of `mongod` processes that maintain the same dataset, providing redundancy and high availability.

## Prerequisites

- **Docker**: Ensure Docker is installed on your system.
- **Docker Compose**: Verify that Docker Compose is installed.
- **Make**: Ensure that `make` is available.

## Starting the Replica Set

To start the MongoDB replica set, follow these steps:

1. **Start the Services**: In the project directory, run:

   ```bash
   make start
   ```

   This command will:
   - Start the MongoDB services defined in the `docker-compose.yml`.
   - Initialize the MongoDB replica set.

2. **Check the Replica Set Status**: After initializing the replica set, you can check the status by running:

   ```bash
   make check-status
   ```

   This will show the status of the replica set and its members.

## Stopping the Services

To stop the MongoDB services and clean up, use the following command:

```bash
make down
```

This command will bring down all the services defined in the `docker-compose.yml`.