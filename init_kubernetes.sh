#!/bin/bash
kubectl apply -f kubernetes/fluentd-daemonset.yaml
kubectl apply -f kubernetes/helloworld-deployment.yaml
kubectl expose deployment helloworld-rest-app --type=LoadBalancer --name=load-balancer-service