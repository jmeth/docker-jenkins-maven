FROM java:jdk-alpine
MAINTAINER jmeth <jmeth@users.noreply.github.com>

# Install Jenkins WAR
RUN mkdir /usr/share/jenkins && \
    wget -O /usr/share/jenkins/jenkins.war http://mirrors.jenkins-ci.org/war/latest/jenkins.war

# Update, install applications, remove APK cache
RUN apk update && \
    apk add fontconfig ttf-dejavu git bash openssh nano nodejs \
    rm -rf /var/cache/apk/*

# Install sonar-scanner to /dev/share/sonar-scanner-2.6. backup sonar-runner. rename scanenr to runn
RUN cd /usr/share && \
    wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-2.6.zip && \
    unzip sonar-scanner-2.6.zip && \
    rm sonar-scanner-2.6.zip && \
    mv sonar-scanner-2.6/bin/sonar-runner sonar-scanner-2.6/bin/sonar-runner.bak && \
    cp sonar-scanner-2.6/bin/sonar-scanner sonar-scanner-2.6/bin/sonar-runner

# Install Maven 3.3.9
RUN MAVEN_VERSION=3.3.9 \
 && cd /usr/share \
 && wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -O - | tar xzf - \
 && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# Install dynamic ELFs required by PhantomJS to run on Alpine linux.  PhantomJS is installed via project specific npm
RUN curl -Ls "https://github.com/dustinblackman/phantomized/releases/download/2.1.1/dockerized-phantomjs.tar.gz" | tar xz -C /

RUN npm install -g grunt-cli bower

# xterm for nano
ENV MAVEN_HOME=/usr/share/maven TERM=xterm

EXPOSE 8080

ENTRYPOINT ["/usr/bin/java","-jar","/usr/share/jenkins/jenkins.war","-Djava.awt.headless=true"]
