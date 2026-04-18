FROM debian:bullseye

RUN apt-get update -y \
    && apt-get install mariadb-server -y

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/dbCreation.sh /dbCreation.sh

ENTRYPOINT ["/bin/bash", "dbCreation.sh"]