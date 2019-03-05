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
COPY target/classes/BOOT-INF/lib/container-security-provider-1.16.0_RELEASE.jar /cloud-security-provider/container-security-provider-1.16.0_RELEASE.jar
COPY target/classes/java.security /cloud-security-provider/java.security
COPY target/app-0.1.0.jar app.jar
ENV SERVER_PORT 8080
EXPOSE ${SERVER_PORT}
CMD ["./start.sh"]
