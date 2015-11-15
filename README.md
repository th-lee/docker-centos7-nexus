# docker-centos7-nexus
Nexus OSS on CentOS7 with Docker


# Environment
* Container OS : Centos 7
* Java : jdk1.7.0_80
* Nexus : 2.11.4-01

# Build
```
docker build -t thlee/nexus .
```

# Run
```
docker run -p 18081:8081 thlee/nexus
```
