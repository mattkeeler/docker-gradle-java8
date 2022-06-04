FROM java:8-jdk

# In case someone loses the Dockerfile
RUN rm -rf /etc/Dockerfile
ADD Dockerfile /etc/Dockerfile

# Gradle
WORKDIR /usr/bin
RUN wget https://services.gradle.org/distributions/gradle-2.2.1-all.zip && \
    unzip gradle-2.2.1-all.zip && \
    ln -s gradle-2.2.1 gradle && \
    rm gradle-2.2.1-all.zip

RUN apt-get install -y genisoimage

# Set Appropriate Environmental Variables
ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

# Default command is "/usr/bin/gradle -version" on /app dir
# (ie. Mount project at /app "docker --rm -v /path/to/app:/app gradle <command>")
RUN mkdir /app
WORKDIR /app
ENTRYPOINT ["gradle"] 
CMD ["-version", "-clean", "-war"]
