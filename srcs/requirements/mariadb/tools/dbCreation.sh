#!/bin/bash

DB_NAME="$MYSQL_DB_NAME"
DB_USR="$MYSQL_USR"
DB_USR_PWD="$MYSQL_PWD"
DB_ROOT_USR="$MYSQL_ROOT_USR"
DB_ROOT_PWD="$MYSQL_ROOT_PWD"

unset MYSQL_PWD

# Ensure mariadb owns its data directory (bind mounts may come in as root-owned)
chown -R mysql:mysql /var/lib/mysql

# Initialize system tables and seed users only when the data directory is empty
if [ ! -d /var/lib/mysql/mysql ]; then
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql >/dev/null

    service mariadb start

    for i in $(seq 1 30); do
        mysql --protocol=socket -u root -e "SELECT 1" >/dev/null 2>&1 && break
        sleep 1
    done

    mysql --protocol=socket -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
CREATE USER IF NOT EXISTS '$DB_USR'@'%' IDENTIFIED BY '$DB_USR_PWD';
GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USR'@'%';
ALTER USER '$DB_ROOT_USR'@'localhost' IDENTIFIED BY '$DB_ROOT_PWD';
FLUSH PRIVILEGES;
EOF

    mysqladmin --protocol=socket -u root -p"$DB_ROOT_PWD" shutdown
fi

exec mysqld_safe
