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