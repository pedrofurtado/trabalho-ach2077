FROM nginx:1.15

# Default encoding of files.
ENV LANG C.UTF-8

# Basic dependencies.
RUN apt-get update -y
RUN apt-get -y install apache2-utils

# Web.
RUN mkdir /log
VOLUME /log
EXPOSE 80
COPY ./config/web.conf /etc/nginx/conf.d/default.conf
CMD nginx -g 'daemon off;'
