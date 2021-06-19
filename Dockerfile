FROM ubuntu AS build

RUN apt-get update \
  && apt-get install -y gcc make unzip wget \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

ARG CC65_VERSION=2.19

RUN wget https://github.com/cc65/cc65/archive/V${CC65_VERSION}.zip -O cc65-${CC65_VERSION}.zip \
  && unzip cc65-${CC65_VERSION}.zip \
  && cd cc65-${CC65_VERSION} \
  && PREFIX=/opt/cc65 make \
  && PREFIX=/opt/cc65 make install \
  && find /opt/cc65/bin -type f -exec strip {} \;

FROM ubuntu

RUN apt-get update \
  && apt-get install -y make \
  && rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/cc65 /opt/cc65
ENV PATH /opt/cc65/bin:$PATH
WORKDIR /workdir
