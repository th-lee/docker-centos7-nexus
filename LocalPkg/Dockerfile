FROM  centos:7

MAINTAINER thlee <thlee@nextree.co.kr>

ENV JAVA_HOME=/usr/java/jdk1.7.0_80

# System update
RUN yum -y update && \
  yum clean all && \
  yum install wget net-tools -y

# Setting Timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# Install JDK 7
COPY jdk-7u80-linux-x64.rpm /tmp/jdk-7u80-linux-x64.rpm

RUN yum localinstall /tmp/jdk-7u80-linux-x64.rpm -y  && \
  rm -rf /tmp/jdk-7u80-linux-x64.rpm && \
  echo 'export JAVA_HOME=/usr/java/jdk1.7.0_80' >> /etc/profile  && \
  JAVA_HOME=/usr/java/jdk1.7.0_80

# Install Nexus
COPY nexus-latest-bundle.tar.gz /tmp/nexus-latest-bundle.tar.gz

RUN mkdir -p /opt/sonatype-nexus /opt/sonatype-work && \
  tar xzvf /tmp/nexus-latest-bundle.tar.gz -C /opt/sonatype-nexus --strip-components=1  && \
  rm -rf /tmp/nexus-latest-bundle.tar.gz 
  
# Configure Nexus
RUN useradd --user-group --system --home-dir /opt/sonatype-nexus nexus  && \
  chown -R nexus:nexus /opt/sonatype-nexus /opt/sonatype-work

# Start shell
RUN touch /usr/bin/start-nexus.sh && \
  echo '#!/bin/bash' > /usr/bin/start-nexus.sh  && \
  echo "su -c \"/opt/sonatype-nexus/bin/nexus console\" - nexus" >> /usr/bin/start-nexus.sh

# Stop shell
RUN touch /usr/bin/stop-nexus.sh  && \
  echo '#!/bin/bash' > /usr/bin/stop-nexus.sh  && \
  echo "su -c \"/opt/sonatype-nexus/bin/nexus stop\" - nexus" >> /usr/bin/stop-nexus.sh  && \
  chmod +x /usr/bin/start-nexus.sh /usr/bin/stop-nexus.sh

CMD ["/usr/bin/start-nexus.sh"]

EXPOSE 8081