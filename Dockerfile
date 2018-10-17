# Set the base image to Ubuntu
FROM ubuntu:16.04
# Read more on: https://hub.docker.com/r/tabotaab/docker-interproscan/

# Update the repository sources list
#RUN apt-add-repository multiverse
RUN apt-get update
RUN apt-get install -y -q software-properties-common

# Install compiler and perl stuff
RUN apt-get install -y -q libboost-iostreams-dev libboost-system-dev libboost-filesystem-dev
RUN apt-get install -y -q zlibc gcc-multilib apt-utils zlib1g-dev python python-pip
RUN apt-get install -y -q libx11-dev libxpm-dev libxft-dev libxext-dev libncurses5-dev
RUN apt-get install -y -q cmake tcsh build-essential g++ git wget gzip perl unzip
#RUN add-apt-repository -y ppa:webupd8team/java    
#RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
#RUN apt-get update 
#RUN apt-get install -y -q oracle-java8-installer
#RUN apt-get install -y -q oracle-java8-set-default 
#RUN apt-get install -y -q openjdk-8-jdk openjdk-8-jre
RUN apt -y -q install openjdk-8-jdk

ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle
ENV CLASSPATH=/usr/lib/jvm/java-8-oracle/bin

#ENV HTTP_PROXY=http://xxxxxxxxxxxxx:xxxx
#ENV HTTPS_PROXY=http://xxxxxxxxxxxxx:xxxx
#ENV http_proxy=http://xxxxxxxxxxxxx:xxxx
#ENV https_proxy=http://xxxxxxxxxxxxx:xxxx

EXPOSE 8000
CMD java -Xmx2000m -jar /interproscan/i5_lookup_service/lookup_service_5.31-70.0/server-5.31-70.0-jetty-console.war --sslProxied --port 8000 --forwarded --contextPath /interproscan/i5_lookup_service --headless &
CMD /bin/bash 
