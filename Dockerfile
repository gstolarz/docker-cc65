ARG CC65_VERSION=2.19
ARG CC65_ROOT=/opt/cc65

FROM ubuntu:latest AS build

ARG CC65_VERSION
ARG CC65_ROOT

RUN apt-get update \
  && apt-get install -y gcc make unzip wget \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

RUN wget https://github.com/cc65/cc65/archive/V${CC65_VERSION}.zip -O cc65-${CC65_VERSION}.zip \
  && unzip cc65-${CC65_VERSION}.zip \
  && cd cc65-${CC65_VERSION} \
  && make PREFIX=$CC65_ROOT LDFLAGS="-s" \
  && make PREFIX=$CC65_ROOT install

FROM ubuntu:latest

ARG CC65_ROOT

RUN apt-get update \
  && apt-get install -y make \
  && rm -rf /var/lib/apt/lists/*

COPY --from=build $CC65_ROOT $CC65_ROOT

ENV PATH $CC65_ROOT/bin:$PATH
WORKDIR /workdir
