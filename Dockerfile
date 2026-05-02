FROM nginx:latest
EXPOSE 80
WORKDIR /app
USER root

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh ./

RUN apt-get update && apt-get install -y wget unzip iproute2 systemctl openssl &&\
    CORE_REPO="v2fly/v2""ray-core" &&\
    CORE_BIN="v2""ray" &&\
    wget -O temp.zip $(wget -qO- "https://api.github.com/repos/${CORE_REPO}/releases/latest" | grep -m1 -o "https.*linux-64.*zip") &&\
    unzip temp.zip "${CORE_BIN}" geoip.dat geosite.dat &&\
    mv "${CORE_BIN}" v &&\
    rm -f temp.zip &&\
    chmod -v 755 v entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
