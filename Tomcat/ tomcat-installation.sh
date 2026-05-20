#!/bin/bash

# Install Java 17
sudo yum install java-17-amazon-corretto -y

# Download Apache Tomcat 9
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.115/bin/apache-tomcat-9.0.115.tar.gz

# Extract Tomcat package
tar -zxvf apache-tomcat-9.0.115.tar.gz

# Configure Tomcat manager roles and user
sed -i '56  a\<role rolename="manager-gui"/>' apache-tomcat-9.0.115/conf/tomcat-users.xml
sed -i '57  a\<role rolename="manager-script"/>' apache-tomcat-9.0.115/conf/tomcat-users.xml
sed -i '58  a\<user username="tomcat" password="123456" roles="manager-gui,manager-script"/>' apache-tomcat-9.0.115/conf/tomcat-users.xml
sed -i '59  a\</tomcat-users>' apache-tomcat-9.0.115/conf/tomcat-users.xml

# Remove extra closing tag
sed -i '56d' apache-tomcat-9.0.115/conf/tomcat-users.xml

# Remove Tomcat manager access restrictions
sed -i '21d' apache-tomcat-9.0.115/webapps/manager/META-INF/context.xml
sed -i '22d' apache-tomcat-9.0.115/webapps/manager/META-INF/context.xml

# Start Tomcat server
sh apache-tomcat-9.0.115/bin/startup.sh
