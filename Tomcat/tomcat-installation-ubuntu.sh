#!/bin/bash

# ----------------------------------------
# TOMCAT INSTALLATION ON UBUNTU
# ----------------------------------------

# Update packages
sudo apt update

# Install Java 17
sudo apt install openjdk-17-jre-headless -y

# Verify Java installation
java -version

# ----------------------------------------
# DOWNLOAD TOMCAT
# ----------------------------------------

wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.117/bin/apache-tomcat-9.0.117.tar.gz

# Extract Tomcat package
tar -zxvf apache-tomcat-9.0.117.tar.gz

# ----------------------------------------
# CONFIGURE TOMCAT USERS
# ----------------------------------------

sed -i '56  a\<role rolename="manager-gui"/>' \
apache-tomcat-9.0.117/conf/tomcat-users.xml

sed -i '57  a\<role rolename="manager-script"/>' \
apache-tomcat-9.0.117/conf/tomcat-users.xml

sed -i '58  a\<user username="tomcat" password="raham123" roles="manager-gui, manager-script"/>' \
apache-tomcat-9.0.117/conf/tomcat-users.xml

sed -i '59  a\</tomcat-users>' \
apache-tomcat-9.0.117/conf/tomcat-users.xml

sed -i '56d' \
apache-tomcat-9.0.117/conf/tomcat-users.xml

# ----------------------------------------
# REMOVE TOMCAT MANAGER ACCESS RESTRICTIONS
# ----------------------------------------

sed -i '21d' \
apache-tomcat-9.0.117/webapps/manager/META-INF/context.xml

sed -i '22d' \
apache-tomcat-9.0.117/webapps/manager/META-INF/context.xml

# ----------------------------------------
# START TOMCAT SERVER
# ----------------------------------------

sh apache-tomcat-9.0.117/bin/startup.sh

# Verify Tomcat process
ps -ef | grep tomcat

# Access Tomcat
# http://<PUBLIC-IP>:8080

# Tomcat Manager Credentials
# Username: tomcat
# Password: raham123
