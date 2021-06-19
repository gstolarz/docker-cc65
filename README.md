# Docker images with CC65

## Building Docker images

### Building Docker image based on Ubuntu
```shell-script
docker build -t gstolarz/cc65 -t gstolarz/cc65:2.19 \
  --build-arg CC65_VERSION=2.19 .
```

### Building Docker image based on Alpine
```shell-script
docker build -t gstolarz/cc65:alpine -t gstolarz/cc65:2.19-alpine \
  --build-arg CC65_VERSION=2.19 -f Dockerfile-alpine .
```

## How to use?

### Compiling file for Atari XL/XE target
```shell-script
docker run --rm -u $(id -u):$(id -g) -v $PWD:/workdir gstolarz/cc65:alpine \
  cl65 -Oirs -t atarixl -o example.xex example.c
```

### Compiling file for C64 target
```shell-script
docker run --rm -u $(id -u):$(id -g) -v $PWD:/workdir gstolarz/cc65:alpine \
  cl65 -Oirs -t c64 -o example.prg example.c
```
