FROM java:openjdk-8-jdk-alpine

MAINTAINER zsx <thinkernel@gmail.com>

ENV JENKINS_SWARM_VERSION 2.1
ENV JENKINS_HOME /home/jenkins
ENV JENKINS_USER jenkins

RUN set -x &&\
    apk add --update --no-cache curl bash openssh git

RUN adduser -D -h "${JENKINS_HOME}" -g "Jenkins User" -s /sbin/nologin "${JENKINS_USER}"
RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar \
  && chmod 755 /usr/share/jenkins

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

RUN mkdir /docker-entrypoint-init.d
ONBUILD ADD ./*.sh /docker-entrypoint-init.d

USER "${JENKINS_USER}"
VOLUME "${JENKINS_HOME}"

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]
