#!/bin/sh
clear
read -p "You didn't source this script, Ctrl-C to exit. :P"

# Remove machines (if exist)
docker-machine rm -y mgr1 wkr1 wkr2

# Create machines
docker-machine create --driver virtualbox mgr1
docker-machine create --driver virtualbox wkr1
docker-machine create --driver virtualbox wkr2
docker-machine ls

# Env vars
export MANAGER1_IP=$(docker-machine ip mgr1)
export WORKER1_IP=$(docker-machine ip wkr1)
export WORKER2_IP=$(docker-machine ip wkr2)

# Create cluster
docker-machine ssh mgr1 docker swarm init --advertise-addr $MANAGER1_IP:2377

# Env var for TOKEN
export CLUSTER_TOKEN=$(docker-machine ssh mgr1 docker swarm join-token --quiet worker)
