FROM java:openjdk-8-jdk-alpine

MAINTAINER zsx <thinkernel@gmail.com>

ENV JENKINS_SWARM_VERSION 2.1
ENV HOME /home/jenkins-slave

RUN set -x &&\
    apk add --update --no-cache curl bash openssh git

RUN adduser -S -h $HOME jenkins-slave jenkins-slave
RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar \
  && chmod 755 /usr/share/jenkins

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

USER jenkins-slave
VOLUME /home/jenkins-slave

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]
