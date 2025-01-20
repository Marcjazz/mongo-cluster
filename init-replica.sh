#!/bin/bash
mongod --replSet rs0 --bind_ip_all --keyFile /etc/mongo-keyfile --auth

echo "Waiting for MongoDB to start..."
sleep 10

echo "Initiating replica set..."
mongosh --eval "
  rs.initiate({
    _id: 'rs0',
    members: [
      { _id: 0, host: 'mongo1:27017' },
      { _id: 1, host: 'mongo2:27017' },
      { _id: 2, host: 'mongo3:27017' }
    ]
  })
"