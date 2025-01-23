#!/bin/bash

# Wait for MongoDB to be ready
sleep 10

# Initialize the replica set
mongo --eval 'rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "mongo1:27017" },
    { _id: 1, host: "mongo2:27017" },
    { _id: 2, host: "mongo3:27017" }
  ]
})'

# Verify the replica set status
mongo --eval 'rs.status()'
