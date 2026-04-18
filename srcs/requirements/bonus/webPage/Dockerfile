FROM debian:bullseye

RUN apt-get update -y \
    && apt-get install nginx -y

COPY ./tools/* /var/www/html/

CMD ["nginx", "-g", "daemon off;"]