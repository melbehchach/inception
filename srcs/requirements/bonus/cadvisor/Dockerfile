FROM debian:bullseye

WORKDIR /usr/bin/

RUN apt-get update -y \
    && apt-get install wget -y \
    && wget https://github.com/google/cadvisor/releases/download/v0.37.5/cadvisor \
    && chmod +x cadvisor

CMD ["cadvisor"]