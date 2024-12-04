# Configuration and used commands

## Table of Contents
1. [Introduction](#introduction)
2. [Register and subscribe Red Hat Enterprise Linux for VM use](#how-to-register-and-subscribe-red-hat-enterprise-linux-for-vm-use-not-necessary-for-containers)
   1. [Registration Assistant](#registration-assistant)
        1. [Enable SCA for your account](#enable-sca-for-your-account)
        2. [Register system with SCA mode](#register-a-system-with-sca-mode)
        3. [Register to Red Hat insights](#register-your-systems-to-red-hat-insights)
3. [Red Hat Enterprise Linux](#red-hat-enterprise-linux)
    1. [Universal base image](#universal-base-image)
    2. [Create images nginx, oracle db](#create-images-to-use-in-container-with-rhel)
    3. [Start nginx using dockerfile and compose.yml](#start-nginx-based-on-the-rhel-image)
4. [ORACLE and ORACLE XE 11G SQL*PLUS](#oracle-and-oracle-xe-11g-sqlplus)
    1. [Oracle software, Dockerfile and Scripts](#oracle-software-dockerfile-and-scripts)
    2. [Oracle-xe-11g](#oracle-xe-11g)
    3. [MD5 checksum](#md5-checksum)
    4. [The Docker Image build script + zipfile](#the-docker-image-build-script)
    5. [Build the image](#build-the-image)
        1. [Start the script](#start-the-script)
        2. [Result in the console](#result-in-the-console)
        3. [Start the image](#start-the-image)
        4. [Console output - "Ready to use"](#console-output)
        5. [Check and access the database](#check-and-access-the-database)
5. [Get Shell and Login](#get-shell-and-login)
    1. [We use SQL*PLUS command in the terminal](#we-use-sqlplus-command-in-the-terminal)
    2. [From other Terminals](#from-other-terminals)
6. [Some SQL-commans](#some-sql-commands-to-test-your-database)
    1. [Show user](#show-user)
    2. [Describe tablename](#describe-a-tablename)
7. [Conclusion](#conclusion)

# Introduction
Setting up a Red Hat Enterprise Linux environment with a NGINX webserver and Oracle 11g SQL*PLUS database.<br/>
The setup is unsing images to create containers in a docker-desktop application.

Reference: [Run Oracle in Docker for Local Development](https://lqiang79.medium.com/run-oracle-11g-xe-in-docker-for-local-development-702ff0bf733e)

If steps are taken are executed correctly you get the following results:

**Your RHEL and NGINX application looks like this:**<br/>
![Nginx on RHEL](<Endresult/Test Page for the Nginx HTTP Server on Red Hat Enterprise Linux.html.png>)
**Your Oracle SQL*PLUS application looks like this:**<br/>
![Oracle Mgmt Console](<Endresult/Oracle Database XE 11.2.png>)

**Terminal after loggin in:**<br/>
![Sql*Plus Terminal](Endresult/Oracle%20Database%20SQL%20Terminal.png)

[Jump to Table of Contents](#table-of-contents)
# How to register and subscribe Red Hat Enterprise Linux for VM use (not necessary for containers)
How a Red Hat Customer Portal using with Red Hat Subscription-Manager?

Evironment: RHEL 8 (rhel/ubi8)

[Jump to Table of Contents](#table-of-contents)
## Registration Assistant
Follow this link to [visit registrationassitant](https://access.redhat.com/labs/registrationassistant/rhel8/?tech=subscription&service=rhsm&process=sca&hasInsights=true&service_level=Premium&service_usage=Development%2FTest&service_role=Red%20Hat%20Enterprise%20Linux%20Server&select_system_purpose=1&eus=1&e4s=1)

### Enable SCA for your account.
    https://access.redhat.com/management

### Register a system with SCA mode.
Systems simply need to be registered (via subscription-manager), and additional repositories enabled if necessary.

**NOTE:** commands to attach subscriptions (such as `subscription-manager attach --auto` and/or `subscription-manager attach --pool <$POOLID>`) 
are obsolete and no longer required.

**On Customer Portal**

`subscription-manager register --username <$INSERT_USERNAME_HERE> --password <$INSERT_PASSWORD_HERE>`

### Register your systems to Red Hat Insights.
    `insights-client --register`

[Jump to Table of Contents](#table-of-contents)
# Red Hat Enterprise Linux
## Universal base image
The Universal Base Image is designed and engineered to be 
the base layer for all of your containerized applications, middleware and utilities.<br/> 
This base image is freely redistributable, but Red Hat only supports 
Red Hat technologies through subscriptions for Red Hat products.<br/> 
This image is maintained by Red Hat and updated regularly.<br/>

Pull command<br/>
`docker pull redhat/ubi8:latest`

Dockerfile with authorization<br/>
`FROM registry.access.redhat.com/ubi8/ubi`

[Jump to Table of Contents](#table-of-contents)
## Create images to use in container with RHEL
**NGINX**<br/>
Path<br/>
`/T10R_RHEL_Nginx_OracleDB`

Build Image<br/>
`docker build -t my-rhel-nginx-image .`

**ORACLE DATABASE**<br/>
Path<br/>
`./OracleDatabase/SingleInstance/Dockerfiles`

Run script<br/>
`./buildContainerImage.sh -v 11.2.0.2 -x -i`

## Start NGINX based on the RHEL image
`docker-compose up -d`

[Jump to Table of Contents](#table-of-contents)

# Oracle and Oracle XE 11g SQL*PLUS
We need Oracle Express 11g  for our local development. Here is how to configurate your environment togehter with a Docker Desktop. For more information about the installation of docker desktop you can find in [Overview of Docker Desktop](https://docs.docker.com/desktop/)

## Oracle software, Dockerfile and Scripts (.sh)

$ `https://github.com/oracle/docker-images`

## Oracle-xe-11g 

$ `https://www.iea-software.com/ftp/emeraldv5/linux/ora/`

## MD5 checksum

dd7881a55569d890241f11cd0eeb7d48

## The Docker Image build script

OracleDatabase/SingleInstance/dockerfiles/buildContainerImage.sh<br/>

oracle-xe-11.2.0-1.0.x86_64.rpm.zip<br/>

OracleDatabase/SingleInstance/dockerfiles/11.2.0.2<br/>
├── 11.2.0.2<br/>
│   ├── Checksum.xe<br/>
│   ├── Dockerfile.xe<br/>
│   ├── checkDBStatus.sh<br/>
│   ├── oracle-xe-11.2.0-1.0.x86_64.rpm.zip<br/>
│   ├── runOracle.sh<br/>
│   ├── setPassword.sh<br/>
│   └── xe.rsp<br/>

[Jump to Table of Contents](#table-of-contents)
## Build The Image

### Start the script
`buildContainerImage.sh`

`./buildContainerImage.sh -v 11.2.0.2 -x -i`

### Result in the console

Oracle Database container image for 'xe' version 11.2.0.2 is ready to be extended:<br/> 
   oracle/database:11.2.0.2-xe <br/>
     Build completed in 42 seconds. <br/>

### Start the image
To use oracle db sql*plus there must be at least 1g memory available. This configuration is set in 2g (what is necassary)

**host mount point** <br/>
`docker run --name myoracle \` <br/>
`--shm-size=2g \` <br/>
`-p 1521:1521 -p 9090:8080 \f` <br/>
`-e ORACLE_PWD=mypass \` <br/>
`-v [<host mount point>:]/u01/app/oracle/oradata \` <br/>
`oracle/database:11.2.0.2-xe` <br/>

**run in T10-rhel-nginx-sqlplus**

`docker run -d --name myoracle \` <br/>
`-e ORACLE_PWD=Passwd1234 \` <br/>
`-p 1521:1521 -p 9090:8080 \` <br/>
`--shm-size=2g \` <br/>
`oracle/database:11.2.0.2-xe` <br/>

[Jump to Table of Contents](#table-of-contents)
## Console output
#########################<br/>
DATABASE IS READY TO USE!<br/>
#########################<br/>

## Check and access the database

you can use any oracle database client(sqlplus, SQL Developer, or IntelliJ Database tools) to connect it. 


# Get Shell and Login
## We use sqlplus command in the terminal
`sqlplus sys/password@//localhost:1521/XE as sysdba`

## From other Terminals
`docker run -it f6exxxxxf1 sh`
`docker exec -it f6exxxxxf1 sh`
`sqlplus sys/password@//localhost:1521/XE as sysdba`

[Jump to Table of Contents](#table-of-contents)

# Some SQL commands to test your database
## Show user
`SELECT USER FROM DUAL;`

## Describe a tablename
`DESC RULE_SET_ROP$`

[Jump to Table of Contents](#table-of-contents)

# Conclusion

Concluding thoughts...

[Jump to Table of Contents](#table-of-contents)

[FAQ](/compose-learn/T10R_RHEL_Nginx_OracleDB/FAQ.md)
[BACK](/README.md)

[Jump to Table of Contents](#table-of-contents)
