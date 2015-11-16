# docker-centos7-nexus
Nexus OSS on CentOS7 with Docker


# Environment
* Container OS : Centos 7
* Java : jdk1.7.0_80
* Nexus : 2.11.4-01

# Build
```
docker build -t nexus .
```

# Run
```
docker run -p 18081:8081 --name mynexus nexus
```

## Connect Web
```
http://${docker-machine-ip}:18081/nexus
```

## Login id/pwd
```
id : admin, password : admin123
```

## nexus log
```
docker exec mynexus tail -f /opt/sonatype-work/nexus/logs/nexus.log
```
