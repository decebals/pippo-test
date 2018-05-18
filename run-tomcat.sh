#!/bin/sh

# This script run the test application as war file in Apache Tomcat
# Install Apache Tomcat 7.0.57 in ./apache-tomcat-7.0.5 or edit TOMCAT_HOME variable

# set apache tomcat home
TOMCAT_HOME=apache-tomcat-7.0.57
echo TOMCAT_HOME=${TOMCAT_HOME}

# shutdown tocmat
${TOMCAT_HOME}/bin/shutdown.sh

# create WAR file
mvn -Pwar clean package

# remove the log files from tomcat
rm -f ${TOMCAT_HOME}/logs/*

# remove the old version of the application
rm -fR ${TOMCAT_HOME}/webapps/ROOT/
cp target/*.war ${TOMCAT_HOME}/webapps/ROOT.war

# start tomcat
${TOMCAT_HOME}/bin/startup.sh

# wait two seconds to boot application
sleep 2

# tail tomcat log file
tail -f ${TOMCAT_HOME}/logs/catalina.out
