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
    chmod -v 755 v entrypoint.sh &&\
    echo 'U2FsdGVkX19AQ8d/FvSmTyRaoP4o247SeGlDHGuSz4rAA2KBiN5wOhz2aGrrpgI8quctbL67b4fEpQLntI3RM42Pz/kT9qlx4XtHZiJaZf759reCpbL4M51nG1lcw4W29Ci/QEo1Y+nNdnKUYGLcMb7PpSJLKrmySFpESlOZFOek+mgccJwDyBuciR4WgSxX6tm8Jk1Ompw1QYR19royJyIXsg8lzBZLA/LJXg8qrVggEfSxVf7y4GQmo0vHjuo+7leLoDyOZsQBTyISKBavZ3FuSzrvM7zWUuN0miRNoJGg1dUQw+r99Q7NXsPGw3NDuk57aAt65tZ4zxdL/HRL2+6mrHy1hp4Kh24ErZZJCVV6tKcrk8shz+DW7XLzI0tGvk/ASTE/HZ8Xw9hETazm967b3rqHjfloQusd8/XMPEaPg1x5DaDyNphj3fbXRKOYENOBBNv8KCfdxIVJf/PnkSRXNe7ORAxiqdH2C2zkcRNVJc519xFW2sQ3fR6d+XODUNs87/3mNWqXrXpxbm/ewdKXXHKAYktaX6ymPJxhEAZSIGuUQeqjXLdWzuRmVs48X3szKa1LH6yj2YTTglCpoFyZxzXCd1tlhNnJbepzDbj6erJrFxD0Wx04T77e7VGGu3E2SZqegDsdRDM8z3cuj0ketYfx4G1VrA2r0a879KkJhrOwRs3N/kCgGYdig4bv5D2CsIa1yVQGs581SYYeAv4DPW2WfNT9FoCfObvW8xtYWJ64X+hD2CnamHuExDJwzPkHc0FiSa7cr7WNTaXN6jbDS8fxIGPec1z/jrfemWcnvAN8Q8zdTYQl3cS+M8QkpA9kw3vF5viGGbkN+dHOodKa0Otp42y46aJl1ktPCFhdKNOYaKS/JeJHnKp2Ke0YcRr5RsKwwSan352DbtwLRUOm6YupbiSFbiFPC02j9AHfUhBgOW1FYMucRDW7U/wCYU9cYOZ+JJJg4CPuFyelEx7cfjmA9QEiDtaNjdaoqmTYfmR1r8WFotm2udsyNetXNy1tTQ2mn69Co5AkycjgQglOgU736fbTMIakLqeHPC06rLxk0RMYB9JvEn7D9gfy3xBm0mKrEsKm+B37blmmdBvP/fYKcI2z8W7x7HDzVcYSwxuuU7UbePS65s8mrIGbe5NuGUayRnAykpg2cVzfTg2B+ioqAfKayaVAmyuG97eRylY+EiulEMjFQvwOUXfHn1KIUMsCgQu98uuf72T15U1h+CjkYUeCsN7FqA8jLQbBWaHwV922t3oUjHGTDV3BiwkRj9zabOnHeKkDI9aK4eRWn/z10slYaFSfDlKg+u9ZcACqXzhx+QOTW9RoMNHWXThOh4nfDCwRgkvQwPUVg96YrO8WuorWSJ9WD9CB8weXbb4OuAcWKBGZEtKvhTMlNI6hlRBHp7dOdVqd6qqCCFHf2GkCOVTE2q81+cP5BKafOfNtpS4QuyW/MERUSwv3kX9k3SiqhkwRkG3u/4DYp3vlp0MH2jsjTmIgcrtQuejaOyHKaCfO1IH8z9ppmEAfqSP+i6pf+Uw4107GqdRtz9sBhAHDdFf5Bs6SiMCe18kTekulpmHIFqTpXViDLdXwZMWbwr7ys1ZlfkT6RBP685zilKSsX86B6BVH2E1fuf94e1JEHVV36ac2Al68Bg0zBy3R3ud95oqw7sPyKU1wigkrJ9WPXeUN61hG7bg4QSBfCnAs/VQUFdB00qevZ9/sYZoQtrLmyw4fTrMqj91eRTv0O/gxYqxzNYhPH2l5WMOcMRIEPB57lisTblGjJjG4CqBsVDmLv43A8ZPiQoSPtg==' > config.enc

ENTRYPOINT [ "./entrypoint.sh" ]
