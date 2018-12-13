# Oracle Java Server JRE on CentOS
FROM centos:7
LABEL AUTHOR "Tony Apuzzo <tony.apuzzo@fdiinc.com>"
LABEL SOURCE "https://github.com/fdiinc/docker-centos7-oracle-jdk8"

# These change quarterly when Oracle releases new Java Versions
ARG JAVA_VERSION=8u191
ARG BUILD_VERSION=b12
ARG UUID=2787e4a523244c269598db4e85c51e0c
ARG TARGET=server-jre-${JAVA_VERSION}-linux-x64.tar.gz

# Default Java Home
ENV JAVA_HOME /usr/java/default

# Download and Install Java
RUN curl -L -b "oraclelicense=accept-securebackup-cookie" \
    "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-${BUILD_VERSION}/${UUID}/${TARGET}" \
    -o "/tmp/${TARGET}" \
 && mkdir -p /usr/java \
 && tar x --auto-compress --file="/tmp/${TARGET}" --no-same-owner --directory=/usr/java --exclude='man/*' \
 && ln -s /usr/java/$(tar taf "/tmp/${TARGET}" | head -1) /usr/java/latest \
 && ln -s /usr/java/latest "${JAVA_HOME}" \
 && alternatives --install /usr/bin/java java "${JAVA_HOME}/bin/java" 20000 \
 && alternatives --install /usr/bin/javac javac "${JAVA_HOME}/bin/javac" 20000 \
 && alternatives --install /usr/bin/jar jar "${JAVA_HOME}/bin/jar" 20000 \
 && rm "/tmp/${TARGET}"
