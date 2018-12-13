Docker Oracle Java
=========

This is a Dockerfile for starting a CentOS container with [Java](https://www.java.com/en/) `8u191` installed. 

In contrast to other forks, this Dockerfile attempts to minimize the size of the resulting image through the use of the following:

- Does not issue `yum update` since the base CentOS image is kept up to date anyway.
- Doesn't install `wget` and instead uses `curl` which is installed by default
- Installs the Server JRE instead of the full JDK
- Uses **ARG** instead of **ENV** where possible to avoid creating more layers
- Coalesce the download and install into a single layer so the downloaded archive can be removed

This saves over 100MiB of storage versus the previous fork

## Build

```sh
docker build . --tag=centos7-oracle-jdk8:8u191
docker tag centos7-oracle-jdk8:8u191 centos7-oracle-jdk8:latest
```

## Run


```text
$ docker run --rm -it centos7-oracle-jdk8:8u191
# java -version
java version "1.8.0_191"
Java(TM) SE Runtime Environment (build 1.8.0_191-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.191-b12, mixed mode)
# ^D
$
```