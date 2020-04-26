htpasswd -b -c /config/.htpasswd $USER $PASSWD
nginx -s reload
