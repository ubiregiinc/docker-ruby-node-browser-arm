FROM arm64v8/ubuntu:jammy

ENV LANG C.UTF-8

COPY sources.list /etc/apt/sources.list
RUN apt update && apt install curl -y
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && apt update && apt install -y nodejs
RUN apt-get install build-essential libncurses5-dev libreadline-dev libssl-dev libyaml-dev libmariadb-dev libsqlite3-dev libxml2-dev libxslt-dev libsasl2-dev libsasl2-2 libmagickwand-dev imagemagick mariadb-client libmagic-dev -y
RUN apt-get build-dep -y ruby
RUN apt-get install -y libreadline-dev zlib1g-dev libssl-dev
RUN apt-get build-dep -y ruby-rmagick ruby-pg ruby-curb
RUN apt install checkinstall wget -y

RUN cd /tmp && wget https://www.openssl.org/source/openssl-1.1.1n.tar.gz && tar xf openssl-1.1.1n.tar.gz && rm openssl-1.1.1n.tar.gz && cd openssl-1.1.1n &&\
  ./config --prefix=/opt/openssl-1.1.1n --openssldir=/opt/openssl-1.1.1n shared zlib && make -j9 && make install &&\
  cd /tmp && rm -rf openssl-1.1.1n && rm -rf /opt/openssl-1.1.1n/certs && ln -s /etc/ssl/certs /opt/openssl-1.1.1n

RUN cd /tmp && wget https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.5.tar.xz && \
  tar xf ruby-2.7.5.tar.xz && rm ruby-2.7.5.tar.xz && cd ruby-2.7.5 && \
  ./configure --with-openssl-dir=/opt/openssl-1.1.1n && make -j9 && make install && \
  cd /tmp && rm -rf ruby-2.7.5
RUN ruby -v
RUN apt install chromium-browser chromium-chromedriver xvfb -y
CMD bash
