FROM openkbs/jdk-mvn-py3
LABEL maintainer="github.com/shreyanshp"
# Install project dependencies and keep sources
COPY . .
RUN mkdir -p target
RUN yes | sudo apt-get install -y jq
RUN yes | echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections && wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz && tar xvf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz && sudo mv wkhtmltox/bin/wkhtmlto* /usr/local/bin && sudo apt-get install -y openssl libssl-dev libxrender-dev libx11-dev libxext-dev libfontconfig1-dev libfreetype6-dev fontconfig --fix-missing
RUN mvn dependency:resolve-plugins dependency:resolve
RUN mvn dependency:go-offline
RUN rm Dockerfile && rm pom.xml
USER ${USER}
WORKDIR ${HOME}
#### Define default command.
CMD ["/bin/bash"]
