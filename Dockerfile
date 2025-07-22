FROM centos:7

LABEL maintainer="hanumeh@gmail.com"

# Fix CentOS 7 repo URLs and update yum cache
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
    yum clean all && yum makecache

# Install required packages
RUN yum install -y java httpd zip unzip && yum clean all

# Set working directory
WORKDIR /var/www/html/

# Copy the manually downloaded ZIP file from build context
COPY assets/photogenic.zip .

# Unzip and move files into the working directory
RUN unzip photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Expose ports
EXPOSE 80 22

# Start Apache in foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
