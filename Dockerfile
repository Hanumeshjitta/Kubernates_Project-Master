FROM centos:7

LABEL maintainer="hanumeh@gmail.com"

RUN yum install -y java httpd zip unzip curl && yum clean all

WORKDIR /var/www/html/

# Download Editorial template ZIP from html5up.net
RUN curl -L -o editorial.zip https://html5up.net/uploads/demos/editorial.zip && \
    unzip editorial.zip && \
    cp -rvf editorial/* . && \
    rm -rf editorial editorial.zip

EXPOSE 80 22

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
