#!/bin/bash
touch testfile
sudo yum -y update

echo "Install Java JDK 8"
sudo yum remove -y java
sudo yum install -y java-1.8.0-openjdk-devel

echo "Install git"
sudo yum install -y git

echo "Install Docker engine"
sudo yum install docker -y
sudo chkconfig docker on

echo "Install Jenkins"
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install -y jenkins
sudo chkconfig jenkins on
sudo usermod -aG docker jenkins

sudo service docker start
sudo service jenkins start
