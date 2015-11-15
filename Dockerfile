FROM  centos:7

MAINTAINER thlee <thlee@nextree.co.kr>

# System update
RUN yum -y update && \
  yum clean all && \
  yum install wget net-tools -y

# Setting Timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# Install JDK 7
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.rpm"

RUN yum localinstall jdk-7u80-linux-x64.rpm -y  && \
  rm -rf jdk-7u80-linux-x64.rpm && \
  echo 'export JAVA_HOME=/usr/java/jdk1.7.0_80' >> /etc/profile  && \
  JAVA_HOME=/usr/java/jdk1.7.0_80

# Install Nexus
RUN mkdir -p /opt/sonatype-nexus /opt/sonatype-work/nexus/conf  && \
  wget -O /tmp/nexus-latest-bundle.tar.gz http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz  && \
  tar xzvf /tmp/nexus-latest-bundle.tar.gz -C /opt/sonatype-nexus --strip-components=1  && \
  rm -rf /tmp/nexus-latest-bundle.tar.gz 
  
# Configure Nexus
RUN useradd --user-group --system --home-dir /opt/sonatype-nexus nexus  && \
  wget -O /opt/sonatype-work/nexus/conf/nexus.xml https://raw.githubusercontent.com/fabric8io/nexus-docker/master/nexus.xml  && \
  chown -R nexus:nexus /opt/sonatype-nexus /opt/sonatype-work  && \
  touch /usr/bin/start-nexus.sh

# Start shell
RUN echo '#!/bin/bash' > /usr/bin/start-nexus.sh  && \
  echo "su -c \"/opt/sonatype-nexus/bin/nexus console\" - nexus" >> /usr/bin/start-nexus.sh

# Stop shell
RUN touch /usr/bin/stop-nexus.sh  && \
  echo '#!/bin/bash' > /usr/bin/stop-nexus.sh  && \
  echo "su -c \"/opt/sonatype-nexus/bin/nexus stop\" - nexus" >> /usr/bin/stop-nexus.sh  && \
  chmod +x /usr/bin/start-nexus.sh /usr/bin/stop-nexus.sh

CMD ["/usr/bin/start-nexus.sh"]

EXPOSE 8081
