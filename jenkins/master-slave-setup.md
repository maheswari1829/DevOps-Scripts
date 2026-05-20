# 🚀 Jenkins Master-Slave Setup

## 📌 What is Master-Slave Architecture?

- Used to distribute builds across multiple servers
- Reduces load on Jenkins master server
- Communication between master and slave happens through SSH
- Java acts as the Jenkins agent
- Slave can run on any platform
- Labels are used to assign jobs to specific slave servers

---

# 🖥️ Infrastructure Setup

Create:
- 1 Jenkins Master Server
- 1 Jenkins Slave Server

Recommended:
- Ubuntu EC2 Instance
- t2.micro or t2.medium

---

# ⚙️ Step 1: Install Java & Maven on Slave Server

```bash
sudo apt update

sudo apt install -y wget gnupg

wget -qO - https://repos.azul.com/azul-repo.key | \
sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/azul.gpg

echo "deb https://repos.azul.com/zulu/deb stable main" | \
sudo tee /etc/apt/sources.list.d/zulu.list

sudo apt update

sudo apt install -y zulu8-jdk

sudo apt install -y maven

sudo apt install -y openjdk-17-jdk

sudo update-alternatives --config java
```

Set Java version to Java 17.

---

# ⚙️ Step 2: Configure Slave Node in Jenkins

Navigate:

```text
Dashboard → Manage Jenkins → Nodes → New Node
```

Configuration:

| Field | Value |
|------|------|
| Node Name | abc |
| Type | Permanent Agent |
| Executors | 3 |
| Remote Root Directory | /tmp |
| Labels | slave1 |
| Usage | Only build jobs with label expressions matching this node |
| Launch Method | Launch agents via SSH |

---

# 🔑 SSH Configuration

## Credentials Setup

Navigate:

```text
Credentials → Add Credentials
```

Select:

| Field | Value |
|------|------|
| Kind | SSH Username with Private Key |
| Username | ec2-user |
| Private Key | Upload PEM file |

Host Key Verification Strategy:

```text
Non verifying Verification Strategy
```

---

# 🏷️ Assign Job to Slave

Navigate:

```text
Dashboard → Job → Configure
```

Enable:

```text
Restrict where this project can be run
```

Label:

```text
slave1
```

---

# ⚠️ Build Failure Note

If build fails on slave server:

Install required packages on slave server:

```bash
sudo apt install git -y
sudo apt install maven -y
```

---

# 🌐 Tomcat Overview

Tomcat is a Java Web Application Server used to deploy Java applications.

## Features

- Open Source
- Platform Independent
- Written in Java
- Default Port: 8080
- Used for WAR deployment

---

# ⚙️ Tomcat Setup

## Install Java

```bash
sudo apt install -y openjdk-21-jdk
```

---

## Download Tomcat

```bash
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.107/bin/apache-tomcat-9.0.107.tar.gz
```

---

## Extract Files

```bash
tar -zxvf apache-tomcat-9.0.107.tar.gz
```

---

## Configure Tomcat User

Edit:

```bash
vim apache-tomcat-9.0.107/conf/tomcat-users.xml
```

Add:

```xml
<role rolename="manager-gui"/>
<role rolename="manager-script"/>
<user username="tomcat" password="admin123" roles="manager-gui,manager-script"/>
```

---

## Remove Access Restriction

Edit:

```bash
vim apache-tomcat-9.0.107/webapps/manager/META-INF/context.xml
```

Delete:
- Line 21
- Line 22

---

## Start Tomcat

```bash
sh apache-tomcat-9.0.107/bin/startup.sh
```

---

# 🌐 Access Tomcat

```text
http://<PUBLIC-IP>:8080
```

Manager App Credentials:

| Username | Password |
|------|------|
| tomcat | admin123 |

---

# 🚀 Deploy WAR File

Navigate:

```text
Jenkins Workspace → target/
```

Select:

```text
netflix-1.2.2.war
```

Upload inside Tomcat Manager Application.
