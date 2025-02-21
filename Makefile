# Makefile for starting Docker Compose and initializing MongoDB replica set

# Define services name and ports
DOCKER_COMPOSE = docker compose
MONGO_CONTAINER = mongo1
INITIATE_CMD = 'rs.initiate({ _id: "rs0", members: [ { _id: 0, host: "mongo1:27017" }, { _id: 1, host: "mongo2:27017" }, { _id: 2, host: "mongo3:27017" } ] })'

# Target to start Docker Compose services
up:
	$(DOCKER_COMPOSE) up -d  # Starts the services defined in docker-compose.yml

# Target to initialize MongoDB replica set
init-replica:
	docker exec -it $(MONGO_CONTAINER) mongosh --eval $(INITIATE_CMD)  # Initialize MongoDB replica set

# Target to bring down the services and clean up
down:
	$(DOCKER_COMPOSE) down  # Stops and removes all services defined in docker-compose.yml

# Target to check MongoDB replica set status
check-status:
	docker exec -it $(MONGO_CONTAINER) mongosh --eval 'rs.status()'  # Check the replica set status

# Combined target to start services and initialize the replica set
start:
	$(MAKE) up  # Start Docker Compose services
	sleep 5  # Wait for MongoDB to fully initialize
	$(MAKE) init-replica  # Initialize MongoDB replica set

.PHONY: up init-replica down start
