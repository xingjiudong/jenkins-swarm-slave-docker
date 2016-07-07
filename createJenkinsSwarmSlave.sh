#/bin/bash
set -e

JENKINS_SWARM_MASTER=${SWARM_MASTER:-$1}
JENKINS_SLAVE_IMAGE=${JENKINS_SLAVE_IMAGE:-openfrontier/jenkins-swarm-slave}
LABEL=${LABEL:-swarm}

docker run -d ${JENKINS_SLAVE_IMAGE} \
  -master ${JENKINS_SWARM_MASTER} \
  -labels ${LABEL} \
  -mode exclusive \
  -executors 1
