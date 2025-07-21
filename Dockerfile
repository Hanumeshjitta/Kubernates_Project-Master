FROM centos:7

LABEL maintainer="hanumeh@gmail.com"

# Fix CentOS 7 repo URLs and update cache
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
    yum clean all && yum makecache

# Install required packages
RUN yum install -y java httpd zip unzip wget && yum clean all

# Set working directory
WORKDIR /var/www/html/

# Download and unzip the website template
RUN wget https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip && \
    unzip photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Expose HTTP and SSH ports
EXPOSE 80 22

# Start Apache HTTP server in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
