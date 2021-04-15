# Heartbeat installation (Deb)

Execute *install_heartbeat.sh* script:
```
$ chmod u+x install_heartbeat.sh
$ ./install_heartbeat.sh
```

Internally, this script runs the following steps:

1. Download and install heartbeat:
```
$ curl -L -O https://artifacts.elastic.co/downloads/beats/heartbeat/heartbeat-7.6.2-amd64.deb
$ sudo dpkg -i heartbeat-7.6.2-amd64.deb
```

2. Edit the configuration:
```
$ cp heartbeat.yaml /etc/heartbeat/heartbeat.yml
```

3. Start Heartbeat:
```
$ sudo heartbeat setup
$ sudo service heartbeat-elastic start
```
