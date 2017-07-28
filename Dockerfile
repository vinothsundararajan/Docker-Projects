#Demo centos by Dockerfile.

FROM guyton/centos6

MAINTAINER vinothsundararajan@outlook.com

RUN yum update -y
RUN yum install wget -y
RUN wget http://prdownloads.sourceforge.net/webadmin/webmin-1.850-1.noarch.rpm
RUN yum -y install perl perl-Net-SSLeay openssl perl-IO-Tty perl-Encode-Detect 
RUN rpm -U webmin-1.850-1.noarch.rpm
CMD ["echo","CENT-OS INSTALLED WITH WEBMIN"]
