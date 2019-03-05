FROM ubuntu:bionic

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

ADD start.sh start.sh
RUN chmod 755 start.sh

VOLUME /tmp
ARG DEPENDENCY=target/dependency
COPY ${DEPENDENCY}/BOOT-INF/lib/container-security-provider-1.16.0_RELEASE.jar /cloud-security-provider/container-security-provider-1.16.0_RELEASE.jar
COPY ${DEPENDENCY}/BOOT-INF/classes/java.security /cloud-security-provider/java.security
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app
ENV SERVER_PORT 8080
ENV LD_LIBRARY_PATH /opt/cloudhsm/lib
EXPOSE ${SERVER_PORT}
CMD ["./start.sh"]
