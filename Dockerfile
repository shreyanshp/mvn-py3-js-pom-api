FROM openkbs/jdk-mvn-py3
LABEL maintainer="github.com/shreyanshp"
# Install project dependencies and keep sources
COPY . .
RUN mkdir -p target
RUN mvn dependency:resolve-plugins dependency:resolve
RUN rm Dockerfile && rm pom.xml
ENTRYPOINT ["/bin/bash"]
