FROM centos:7

LABEL maintainer="hanumeh@gmail.com"

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
    yum clean all && yum makecache

RUN yum install -y java httpd zip unzip && yum clean all

WORKDIR /var/www/html/

# Add photogenic.zip from local context
COPY photogenic.zip .

RUN unzip photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

EXPOSE 80 22

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
