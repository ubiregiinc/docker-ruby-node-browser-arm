FROM debian:bullseye

COPY sources.list /etc/apt/sources.list

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
  apt install -y chromium chromium-driver git xvfb curl wget checkinstall &&\
  rm -rf /var/lib/apt/lists/*

RUN apt update && apt install curl -y && \
  curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && apt update && apt install -y nodejs &&\
  apt-get install build-essential libncurses5-dev libreadline-dev libssl-dev libyaml-dev libmariadb-dev libsqlite3-dev libxml2-dev libxslt-dev libsasl2-dev libsasl2-2 libmagickwand-dev imagemagick mariadb-client libmagic-dev -y &&\
  apt-get build-dep -y ruby &&\
  apt-get install -y libreadline-dev zlib1g-dev libssl-dev &&\
  apt-get build-dep -y ruby-rmagick ruby-pg ruby-curb &&\
  rm -rf /var/lib/apt/lists/*

RUN cd /tmp && wget https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.5.tar.xz && \
  tar xf ruby-2.7.5.tar.xz && rm ruby-2.7.5.tar.xz && cd ruby-2.7.5 && \
  ./configure --with-openssl-dir=/opt/openssl-1.1.1n && make -j9 && make install && \
  cd /tmp && rm -rf ruby-2.7.5
RUN ruby -v

ENV TZ=Asia/Tokyo
RUN apt update && apt install -y tzdata && gem install foreman && rm -rf /var/lib/apt/lists/*

CMD /bin/bash

