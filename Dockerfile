FROM docker.io/nginx:alpine

LABEL maintainer="you@example.com"

RUN rm -rf /usr/share/nginx/html/*

COPY ./webapp/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
