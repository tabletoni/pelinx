FROM debian:10
MAINTAINER Toni Rubio <tabletoni@gmail.com>
LABEL name="Ejercicio. Servidor de ficheros ngnix con fancyindex para mis peliculas"

ENV DEBIAN_FRONTEND noninteractive
ARG USER=user
ARG PASSWD=1234
COPY nginxpass.sh /bin
RUN set -eux \
    && apt update \
    && apt -y install nginx nginx-common libnginx-mod-http-fancyindex apache2-utils \ 
    && apt -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && chmod 755 /bin/nginxpass.sh \
    && mkdir /config \
    && htpasswd -b -c /config/.htpasswd $USER $PASSWD

COPY default /etc/nginx/sites-enabled/
ADD fancyindex.tar /var/www/html/
EXPOSE 80
CMD  nginx -g 'daemon off;'
