# helloworld-pipeline

## Steps

After deploying jenkins instance using Terraform:

1. Be patient! While you may ssh the machine, depeding on the aws instance configuration some actions can take some time (especially if selected instances are free tier as in this example). Getting the Jenkins server up and running could take up to several minutes. You can check the jenkins service status by sshing the machine and executing `sudo systemctl status jenkins`.
2. Connect to it using ssh and get jenkins' admin password: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`.
3. Access to jenkins (port 8080) and install these plugins: GitHub, Docker, Docker API, Docker Pipeline, Pipeline: AWS Steps.
4. Set up your Docker Hub Credentials on Jenkins: Click Credentials -> global -> Add Credentials, choose Username with password as Kind, enter the Docker Hub username and password and use `dockerHubCredentials` for ID.
5. Set up your AWS Credentials on Jenkins: Click Credentials -> global -> Add Credentials, choose Username with password as Kind, enter the username (aws_access_key_id) and password (aws_secret_access_key) and use `awsCredentials` for ID.
6. You might have to change GitHub API request limit: Click Configure System -> GitHub API usage -> Select Throttle at/near rate limit
7. Create the pipeline. Click New item -> Multibranch pipeline. Add GitHub source and specify your repo URL (if your repo is private you will have to provide credentials). Apply and save your changes.


## Kubernetes

Initialize Kubernetes cluster with minikube (in this example VirtualBox is being used as driver)
```
$ minikube start
```

Deploy ElasticSearch and Kibana servers
```
$ sudo docker-compose -f efk/docker-compose.yaml up -d
```

Get minikube IP (e.g. 10.0.2.2)
```
$ minikube ssh "route -n | grep ^0.0.0.0 | awk '{ print \$2 }'"
```

Replace FLUENT_ELASTICSEARCH_HOST field with obtained IP in kubernetes/fluentd-daemonset.yaml

Deploy fluentd daemonset to the minikube active cluster
```
$ kubectl apply -f kubernetes/fluentd-daemonset.yaml
```

Deploy helloworld app deployment to the minikube active cluster
```
$ kubectl apply -f kubernetes/helloworld-deployment.yaml
```

Create a load balancer service to expose the deployed app
```
$ kubectl expose deployment helloworld-rest-app --type=LoadBalancer --name=load-balancer-service
```

Enter Kibana (http://localhost:8083) and create an index pattern.
Specify "logstash-*" and select @timestamp as Time Filter field name. Then select Create index pattern.

Go to the Discover tab, and you will see the logs there. If you only want to see
logs coming from the application, add a new filter and select these parameters:
- Field: kubernetes.container_name
- Operator: is
- Value: helloworld-rest-app


Make a request to the helloworld app
```
$ minikube service load-balancer-service
```

Test endpoint
```
$ cd test
$ ./multi-request <NUM_REQUESTS> <ENDPOINT>
```
