# Dockerfile:

#### Here, i posted to create webmin in centos docker container.
![](https://microsoftcloudexplorer.gallerycdn.vsassets.io/extensions/microsoftcloudexplorer/visualstudiotoolsfordocker-preview/0.41.0/1482142258056/176081/2/DockerIcon.png)

> Source link docker pull vinothssv/centoswebmindocker:version1.1

### Step 1:-
#### Create the file with the name of Dockerfile. "D" Should be in capital also the file name should as a name of Dockerfile.

> vi Dockerfile 
### Step 2:-
#### Open the Dockerfile and put the below content
        FROM guyton/centos6
        MAINTAINER vinothsundararajan@outlook.com
        RUN yum update -y
        RUN yum install wget -y
        RUN wget http://prdownloads.sourceforge.net/webadmin/webmin-1.850-1.noarch.rpm
        RUN yum -y install perl perl-Net-SSLeay openssl perl-IO-Tty perl-Encode-Detect 
        RUN rpm -U webmin-1.850-1.noarch.rpm
        CMD ["echo","CENT-OS INSTALLED WITH WEBMIN"]
        #Demo centos by Dockerfile.
### Step 3:-

#### To build the dockerfile container by below command.
>docker build -t centwebmin:version.1 .

        docker build     		-- indicates to build from Dockerfile.
        -t 			            -- to tag the os
        centwebmin:version.1	-- Exact name of my centos.
        .		            	-- indicates present directory.

### Step 4:-
#### To list all docker images by using the below command.

 >[root@srv Docker]# docker images
 
        REPOSITORY                        TAG                 IMAGE ID            CREATED             SIZE
        centwebmin                        version.1           935a9e81daa6        12 minutes ago      493.4 MB
        firstentrydemo                    latest              b4fb42ea343f        42 hours ago        119.5 MB
        nginx                             latest              08a48c1157f0        6 days ago          214.7 MB
        vinothssv/nginxdockerfile         latest              08a48c1157f0        6 days ago          214.7 MB
    
### Step 5:-
> docker run -i -t -p 10000:10000 centwebmin:version.1 /bin/bash

        docker run               -- To start the docker image.
        -i                       -- To start the interactive mode.
        -t                       -- Interactive mode with tty
        -p                       -- To allow the ports
        10000(base machine) on lift side-- it will NAT the container port 10000 to local(base machine or docker host)
        centwebmin:version.1     -- image with exact tag (version.1)
        /bin/bash                -- to start in /bash script.


### Step 6:-

#### "docker ps " To check the current docker process, so our build "centwebmin:version.1" with running 10000

        [root@srv Docker]# docker ps
        CONTAINER ID        IMAGE                  COMMAND             CREATED             STATUS              PORTS                      NAMES
        67d757d116e5        centwebmin:version.1   "/bin/bash"         10 minutes ago      Up 10 minutes       0.0.0.0:10000->10000/tcp   elegant_mahavira
        9c9430ffb16f        fae84ad46b55           "/bin/bash"         7 days ago          Up 2 days           0.0.0.0:100->80/tcp        big_swirles
### Step 7:-
#### To attach our newly created conatiner in working mode. by below command.

>docker attach 67d757d116e5

### Step 8:- 
#### Once we get logged into the conatiner we need to check the status of webmin service. if it in stop stage we need to start manually by below command.

>[root@67d757d116e5 ~]# /etc/init.d/webmin start

### Step 9:-
#### Not manditatory, To be more persistence even if, we exit the container the below nsenter image can helps to be stable.  for that we need to pull nsenter image by below command.
> docker pull jpetazzo/nsenter

#### once downloaded we need to run the below command.
> docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter

#### Need to get the process id of our container by using the  inspect command.
>docker inspect 67d757d116e5 | grep Pid

    [root@srv Docker]# docker inspect 67d757d116e5 | grep Pid
                "Pid": 15324,
                "PidMode": "",
                "PidsLimit": 0,

##### Step 10:-
#### Run the below command nsenter to be persistence
>nsenter -m -u -n -p -i -t 15324 /bin/bash

Thank you.
