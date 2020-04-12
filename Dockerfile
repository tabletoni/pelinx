FROM debian:10
MAINTAINER Toni Rubio <tabletoni@gmail.com>
LABEL name="Ejercicio. Servidor de ficheros ngnix con fancyindex para mis peliculas"

ENV DEBIAN_FRONTEND noninteractive

RUN set -eux \
    && apt update \
    && apt -y install nginx nginx-common libnginx-mod-http-fancyindex apache2-utils \ 
    && apt -y clean \
    && rm -rf /var/lib/apt/lists/*  
COPY default /etc/nginx/sites-enabled/
COPY .htpasswd /etc/nginx/
ADD fancyindex.tar /var/www/html/
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
