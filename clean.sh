#!/bin/bash
echo "cleanup_all.sh started..."
docker kill $(docker ps -q)
docker rm $(docker ps -a -q)
docker rmi -f $(docker images -q)
echo "cleanup_all.sh completed."
