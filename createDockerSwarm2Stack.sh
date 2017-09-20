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
echo "\033[33mdocker service create --replicas 1 -p 8088:8088 --name quotesvc jmreif/quotesvc\033[0m"
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
read -p "Press ENTER to continue..."

# DOCKER STACK SECTION
clear
echo ""
docker-machine scp ./docker-compose.yml mgr1:/home/docker/
echo "\033[33mdocker-machine ssh mgr1 docker stack deploy -c docker-compose.yml dockerdemo\033[0m"
docker-machine ssh mgr1 docker stack deploy -c /home/docker/docker-compose.yml dockerdemo
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker stack ls\033[0m"
docker-machine ssh mgr1 docker stack ls
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker service ls\033[0m"
docker-machine ssh mgr1 docker service ls
read -p "Press ENTER after service starts to continue..."
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker stack ps dockerdemo\033[0m"
docker-machine ssh mgr1 docker stack ps dockerdemo
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker service ps dockerdemo\033[0m"
docker-machine ssh mgr1 docker service ps dockerdemo
read -p "Press ENTER to continue..."
echo ""
# This won't show anything, as 'dockerdemo' isn't the service name, it's the stack name
echo "\033[33mdocker-machine ssh mgr1 docker service inspect --pretty dockerdemo\033[0m"
docker-machine ssh mgr1 docker service inspect --pretty dockerdemo
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker service inspect --pretty dockerdemo_quotesvc\033[0m"
docker-machine ssh mgr1 docker service inspect --pretty dockerdemo_quotesvc
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mhttp \$(docker-machine ip mgr1):8086/quote\033[0m"
http $(docker-machine ip mgr1):8086/quote
read -p "Press ENTER to continue..."
echo ""
# This will not scale, as 'docker stack' doesn't have a scale command; you scale at the service level
echo "\033[33mdocker-machine ssh mgr1 docker stack scale dockerdemo=3\033[0m"
docker-machine ssh mgr1 docker stack scale dockerdemo=3
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker stack rm dockerdemo\033[0m"
docker-machine ssh mgr1 docker stack rm dockerdemo
echo ""
echo "\033[33mdocker-machine ssh mgr1 docker stack services dockerdemo\033[0m"
docker-machine ssh mgr1 docker stack services dockerdemo
read -p "Press ENTER to shut down..."
echo ""
docker-machine stop mgr1 wkr1 wkr2
