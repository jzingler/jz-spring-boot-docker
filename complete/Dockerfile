FROM ubuntu:bionic
VOLUME /tmp
ARG DEPENDENCY=target/dependency
ARG JAVA_OPTS
ENV JAVA_OPTS=$JAVA_OPTS
RUN mkdir cloud-security-provider

RUN apt-get update && apt-get install --no-install-recommends -y \
    ca-cacert \
    curl \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir /java \
 && cd /java \
 && curl -L https://java-buildpack.cloudfoundry.org/openjdk/bionic/x86_64/openjdk-1.8.0_202.tar.gz | tar xzf -

ENV JAVA_HOME=/java
ENV PATH=${PATH}:${JAVA_HOME}/bin

COPY ${DEPENDENCY}/BOOT-INF/lib/container-security-provider-1.16.0_RELEASE.jar   /cloud-security-provider/container-security-provider-1.16.0_RELEASE.jar
COPY ${DEPENDENCY}//BOOT-INF/classes/java.security /cloud-security-provider/java.security
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app


ENTRYPOINT exec java $JAVA_OPTS \
    -Djava.ext.dirs=/cloud-security-provider:${JAVA_HOME}/lib/ext \
    -Djava.security.properties=/cloud-security-provider/java.security \
    -cp app:app/lib/* hello.Application
