FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

# Set your author/Maintainer

MAINTAINER "Bharathi Tenneti"

RUN microdnf update && microdnf install -y java-17-openjdk-devel tar gzip unzip shadow-utils && microdnf clean all


USER root


ENV JBOSS_HOME="/opt/jboss/jboss-eap-7.4"

RUN mkdir -p $JBOSS_HOME

COPY jboss-eap-7.4.0.zip $JBOSS_HOME

RUN unzip  $JBOSS_HOME/jboss-eap-7.4.0.zip -d /opt/jboss/

RUN echo  "/opt/jboss/"
    
RUN  adduser -r jboss \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME} 


USER jboss
COPY helloworld.war ${JBOSS_HOME}/standalone/deployments/
EXPOSE 8080 

# Set the default command to run on boot
# This will boot JBoss EAP in standalone mode and bind to all interfaces

CMD ["/opt/jboss/jboss-eap-7.4/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]