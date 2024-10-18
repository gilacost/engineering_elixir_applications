# Stage 1: Build environment
FROM ubuntu:latest AS builder

RUN apt-get update && apt-get install -y \
  autoconf \
  build-essential \
  curl \
  git \
  icu-devtools \
  libcurl4-openssl-dev \
  libicu-dev \
  libncurses5-dev \
  libreadline-dev \
  openssl \
  libssl-dev \
  unzip \
  uuid-dev \
  zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /home/auser

RUN useradd -m auser

COPY install.sh .
COPY scripts/asdf_plugins.sh scripts/asdf_plugins.sh
COPY .tool-versions ./
RUN chown -R auser:auser ./                                                                      
USER auser

RUN chmod +x install.sh scripts/asdf_plugins.sh
RUN ./install.sh
RUN ./scripts/asdf_plugins.sh

ENV PATH="/home/auser/.asdf/shims:/home/auser/.asdf/bin:${PATH}"

RUN asdf install
