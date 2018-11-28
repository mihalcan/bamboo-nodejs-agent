FROM atlassian/bamboo-base-agent
MAINTAINER Andrei Mihalciuc <andrei.mihalciuc@gmail.com>

# install make for node-gyp
RUN apt-get update && apt-get -y install build-essential

# install our dependencies and nodejs
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list \
    && apt-get update \
    && apt-get -yq install bash git openssh-server curl \
    && apt-get -yq clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Node
RUN   \
  cd /opt && \
  wget https://nodejs.org/dist/v8.12.0/node-v8.12.0-linux-x64.tar.gz && \
  tar -xzf node-v8.12.0-linux-x64.tar.gz && \
  mv node-v8.12.0-linux-x64 node && \
  cd /usr/local/bin && \
  ln -s /opt/node/bin/* . && \
  rm -f /opt/node-v8.12.0-linux-x64.tar.gz

RUN npm config set prefix /usr/local && \
    npm install -g npm

ADD bamboo-capabilities.properties /root/bamboo-agent-home/bin/bamboo-capabilities.properties
