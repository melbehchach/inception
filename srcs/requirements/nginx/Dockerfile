FROM debian:bullseye

RUN apt-get update -y \
    && apt-get install nginx -y \
    && apt-get install openssl -y

COPY /tools/nginx.conf /etc/nginx/

COPY /tools/script.sh /

ENTRYPOINT ["/bin/bash", "./script.sh" ]