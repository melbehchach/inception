FROM debian:bullseye

RUN apt-get update -y \
    && apt-get install wget php php-mysql -y \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O adminer.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "adminer.php"]