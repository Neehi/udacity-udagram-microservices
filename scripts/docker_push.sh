#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker-compose -f udacity-c3-deployment/docker/docker-compose-build.yaml push
