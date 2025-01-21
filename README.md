# MongoDB Replica Set Deployment with Docker Compose

This guide provides step-by-step instructions to set up a MongoDB replica set using Docker Compose. A replica set in MongoDB is a group of `mongod` processes that maintain the same dataset, providing redundancy and high availability. 

## Prerequisites

- **Docker**: Ensure Docker is installed on your system.
- **Docker Compose**: Verify that Docker Compose is installed.

## Docker Compose Configuration

In the `docker-compose.yml` file, we've defined the services for the MongoDB replica set. It sets up three MongoDB instances (`mongo1`, `mongo2`, and `mongo3`) with replication enabled. Each instance is configured to be part of the `rs0` replica set.

## Starting the Replica Set

To start the MongoDB replica set:

1. **Build and Start Services**: Navigate to the project directory and run:

   ```bash
   docker-compose up -d
   ```

   This command builds and starts the MongoDB containers in detached mode.

2. **Initialize the Replica Set**: The `initiateReplicaSet.js` script will be executed automatically upon container startup, initializing the replica set. To manuallly initialize the replica set, run:
    
    ```bash
    # Source environment variables
    source .env

    # Run initialization script against the docker container
    docker exec mongo1 mongosh "mongodb://$MONGO_INITDB_ROOT_USERNAME:$MONGO_INITDB_ROOT_PASSWORD@mongo1:27017/" --eval 'rs.initiate({ _id: "rs0", members: [ { _id: 0, host: "mongo1:27017" }, { _id: 1, host: "mongo2:27017" }, { _id: 2, host: "mongo3:27017" } ] })'
    ```

This script initiates the replica set with the specified members.


## Verifying the Replica Set

To verify that the replica set is functioning correctly:

1. **Access the Mongo Shell**: Connect to the primary MongoDB instance:

   ```bash
   docker exec -it mongo1 mongosh -u admin -p adminpassword --authenticationDatabase admin
   ```

2. **Check Replica Set Status**: In the Mongo shell, run:

   ```javascript
   rs.status();
   ```

   This command displays the current status of the replica set, including information about each member.

## Notes

- **Data Persistence**: The volumes defined in the `docker-compose.yml` file ensure that data persists between container restarts.
- **Authentication**: The `MONGO_INITDB_ROOT_USERNAME` and `MONGO_INITDB_ROOT_PASSWORD` environment variables set up authentication for the MongoDB instances.

By following this guide, you have successfully set up a MongoDB replica set using Docker Compose, providing a robust environment for development and testing purposes. 