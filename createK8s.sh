#!/bin/sh
clear

# Start K8s local cluster
minikube start

read -p "Press ENTER to continue..."
echo ""
# echo "kubectl run quotesvc --image=jmreif/quotesvc --port=8088"
# kubectl run quotesvc --image=jmreif/quotesvc --port=8088
echo "\033[33mkubectl create -f ./quotesvc.yaml\033[0m"
kubectl create -f ./quotesvc.yaml
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mkubectl expose deployment quotesvc --type=NodePort\033[0m"
kubectl expose deployment quotesvc --type=NodePort
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mkubectl get pod\033[0m"
kubectl get pod
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mhttp \$(minikube service quotesvc --url)/random\033[0m"
http $(minikube service quotesvc --url)/random
read -p "Press ENTER to continue..."
# echo ""
# echo "kubectl get pod"
# kubectl get pod
# read -p "Press ENTER to continue..."
echo ""
echo "\033[33mkubectl scale --replicas=2 deployment/quotesvc\033[0m"
kubectl scale --replicas=2 deployment/quotesvc
kubectl get pod
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mRun kubectl delete pod/<pod>\033[0m"
read -p "Press ENTER after deleting pod to continue..."
echo ""
echo "\033[33mkubectl get pod\033[0m"
kubectl get pod
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mkubectl delete deployment,service quotesvc\033[0m"
kubectl delete deployment,service quotesvc
read -p "Press ENTER to shut down K8s..."
echo ""
echo "\033[33mminikube stop\033[0m"
minikube stop
