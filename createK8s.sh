#!/bin/sh
clear

# Start K8s local cluster
minikube start

read -p "Press ENTER to continue..."
echo ""
# echo "kubectl run quotesvc --image=hecklerm/quotesvc --port=8088"
# kubectl run quotesvc --image=hecklerm/quotesvc --port=8088
echo "kubectl create -f ./quotesvc.yaml"
kubectl create -f ./quotesvc.yaml
read -p "Press ENTER to continue..."
echo ""
echo "kubectl expose deployment quotesvc --type=NodePort"
kubectl expose deployment quotesvc --type=NodePort
read -p "Press ENTER to continue..."
echo ""
echo "kubectl get pod"
kubectl get pod
read -p "Press ENTER to continue..."
echo ""
echo "curl \$(minikube service quotesvc --url)/random"
curl $(minikube service quotesvc --url)/random
read -p "Press ENTER to continue..."
# echo ""
# echo "kubectl get pod"
# kubectl get pod
# read -p "Press ENTER to continue..."
echo ""
echo "kubectl scale --replicas=2 deployment/quotesvc"
kubectl scale --replicas=2 deployment/quotesvc
kubectl get pod
read -p "Press ENTER to continue..."
echo ""
echo "Run kubectl delete pod/<pod>"
read -p "Press ENTER after deleting pod to continue..."
echo ""
echo "kubectl get pod"
kubectl get pod
read -p "Press ENTER to continue..."
echo ""
echo "kubectl delete deployment,service quotesvc"
kubectl delete deployment,service quotesvc
read -p "Press ENTER to shut down K8s..."
echo ""
echo "minikube stop"
minikube stop
