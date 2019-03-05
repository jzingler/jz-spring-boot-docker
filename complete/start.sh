#!/bin/bash

# Start the second process
# java -Djava.ext.dirs=/cloud-security-provider/container-security-provider-1.16.0_RELEASE.jar:${JAVA_HOME}/lib/ext \
#     -Djava.security.properties=/cloud-security-provider/java.security \
#     -jar app.jar

exec java -Djava.ext.dirs=/cloud-security-provider:${JAVA_HOME}/lib/ext \
    -Djava.security.properties=/cloud-security-provider/java.security \
    -cp app:app/lib/* hello.Application    
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start java process: $status"
  exit $status
fi