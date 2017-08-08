# Set the base image to Ubuntu
FROM ubuntu:latest
# Read more on: https://hub.docker.com/r/tabotaab/interproscan/


# Update the repository sources list
RUN apt-get update
RUN apt-get install -y -q software-properties-common 
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update 

# Install compiler and perl stuff
RUN apt-get install -y -q libboost-iostreams-dev libboost-system-dev libboost-filesystem-dev
RUN apt-get install -y -q zlibc gcc-multilib apt-utils zlib1g-dev python
RUN apt-get install -y -q libx11-dev libxpm-dev libxft-dev libxext-dev libncurses5-dev
RUN apt-get install -y -q cmake tcsh build-essential g++ git wget gzip perl
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y -q oracle-java8-installer  
RUN apt-get install -y -q oracle-java8-set-default

ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle
ENV CLASSPATH=/usr/lib/jvm/java-8-oracle/bin

EXPOSE 8000
CMD java -Xmx2000m -jar /interproscan/i5_lookup_service/lookup_service_5.24-63.0/server-5.24-63.0-jetty-console.war --sslProxied --port 8000 --forwarded --contextPath /interproscan/i5_lookup_service --headless &
CMD /bin/bash 


