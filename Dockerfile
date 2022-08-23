FROM ruby:2.7.5-bullseye

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
  apt install -y chromium chromium-driver git xvfb curl wget checkinstall &&\
  rm -rf /var/lib/apt/lists/*

ENV TZ=Asia/Tokyo
RUN apt update && apt install -y tzdata && gem install foreman && rm -rf /var/lib/apt/lists/*

CMD /bin/bash
