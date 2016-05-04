FROM java:8-jre-alpine
MAINTAINER jmeth <jmeth@users.noreply.github.com>

RUN mkdir /usr/share/jenkins && \
    wget -O /usr/share/jenkins/jenkins.war http://mirrors.jenkins-ci.org/war/latest/jenkins.war

RUN apk update && apk add fontconfig ttf-dejavu git

RUN MAVEN_VERSION=3.3.3 \
 && cd /usr/share \
 && wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -O - | tar xzf - \
 && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

EXPOSE 8080

ENTRYPOINT ["/usr/bin/java","-jar","/usr/share/jenkins/jenkins.war","-Djava.awt.headless=true"]
