#!/bin/sh
clear

# Add worker nodes to cluster
docker-machine ssh wkr1 docker swarm join --token $CLUSTER_TOKEN $MANAGER1_IP:2377
docker-machine ssh wkr2 docker swarm join --token $CLUSTER_TOKEN $MANAGER1_IP:2377

echo ""
echo "\033[33mdocker-machine ssh mgr1 docker node ls\033[0m"
docker-machine ssh mgr1 docker node ls
read -p "Press ENTER to continue..."
echo ""
echo "\034[33mdocker service create --replicas 1 -p 8088:8088 --name quotesvc jmreif/quotesvc\033[0m"
docker-machine ssh mgr1 docker service create --replicas 1 -p 8088:8088 --name quotesvc jmreif/quotesvc
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker service ls\033[0m"
docker-machine ssh mgr1 docker service ls
read -p "Press ENTER after service starts to continue..."
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker service inspect --pretty quotesvc\033[0m"
docker-machine ssh mgr1 docker service inspect --pretty quotesvc
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker service ps quotesvc\033[0m"
docker-machine ssh mgr1 docker service ps quotesvc
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker service scale quotesvc=3\033[0m"
docker-machine ssh mgr1 docker service scale quotesvc=3
docker-machine ssh mgr1 docker service ps quotesvc
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker node update --availability drain mgr1\033[0m"
docker-machine ssh mgr1 docker node update --availability drain mgr1
docker-machine ssh mgr1 docker service ps quotesvc
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker service scale quotesvc=1\033[0m"
docker-machine ssh mgr1 docker service scale quotesvc=1
docker-machine ssh mgr1 docker service ps quotesvc
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker service rm quotesvc\033[0m"
docker-machine ssh mgr1 docker service rm quotesvc
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker service inspect quotesvc\033[0m"
docker-machine ssh mgr1 docker service inspect quotesvc
read -p "Press ENTER to shut down..."
echo ""
docker-machine stop mgr1 wkr1 wkr2
