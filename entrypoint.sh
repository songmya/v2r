#!/usr/bin/env bash
set -euo pipefail

# 定义 UUID 及 伪装路径,请自行修改.(注意:伪装路径以 / 符号开始,为避免不必要的麻烦,请不要使用特殊符号.)
CONFIG_PAYLOAD='U2FsdGVkX19AQ8d/FvSmTyRaoP4o247SeGlDHGuSz4rAA2KBiN5wOhz2aGrrpgI8quctbL67b4fEpQLntI3RM42Pz/kT9qlx4XtHZiJaZf759reCpbL4M51nG1lcw4W29Ci/QEo1Y+nNdnKUYGLcMb7PpSJLKrmySFpESlOZFOek+mgccJwDyBuciR4WgSxX6tm8Jk1Ompw1QYR19royJyIXsg8lzBZLA/LJXg8qrVggEfSxVf7y4GQmo0vHjuo+7leLoDyOZsQBTyISKBavZ3FuSzrvM7zWUuN0miRNoJGg1dUQw+r99Q7NXsPGw3NDuk57aAt65tZ4zxdL/HRL2+6mrHy1hp4Kh24ErZZJCVV6tKcrk8shz+DW7XLzI0tGvk/ASTE/HZ8Xw9hETazm967b3rqHjfloQusd8/XMPEaPg1x5DaDyNphj3fbXRKOYENOBBNv8KCfdxIVJf/PnkSRXNe7ORAxiqdH2C2zkcRNVJc519xFW2sQ3fR6d+XODUNs87/3mNWqXrXpxbm/ewdKXXHKAYktaX6ymPJxhEAZSIGuUQeqjXLdWzuRmVs48X3szKa1LH6yj2YTTglCpoFyZxzXCd1tlhNnJbepzDbj6erJrFxD0Wx04T77e7VGGu3E2SZqegDsdRDM8z3cuj0ketYfx4G1VrA2r0a879KkJhrOwRs3N/kCgGYdig4bv5D2CsIa1yVQGs581SYYeAv4DPW2WfNT9FoCfObvW8xtYWJ64X+hD2CnamHuExDJwzPkHc0FiSa7cr7WNTaXN6jbDS8fxIGPec1z/jrfemWcnvAN8Q8zdTYQl3cS+M8QkpA9kw3vF5viGGbkN+dHOodKa0Otp42y46aJl1ktPCFhdKNOYaKS/JeJHnKp2Ke0YcRr5RsKwwSan352DbtwLRUOm6YupbiSFbiFPC02j9AHfUhBgOW1FYMucRDW7U/wCYU9cYOZ+JJJg4CPuFyelEx7cfjmA9QEiDtaNjdaoqmTYfmR1r8WFotm2udsyNetXNy1tTQ2mn69Co5AkycjgQglOgU736fbTMIakLqeHPC06rLxk0RMYB9JvEn7D9gfy3xBm0mKrEsKm+B37blmmdBvP/fYKcI2z8W7x7HDzVcYSwxuuU7UbePS65s8mrIGbe5NuGUayRnAykpg2cVzfTg2B+ioqAfKayaVAmyuG97eRylY+EiulEMjFQvwOUXfHn1KIUMsCgQu98uuf72T15U1h+CjkYUeCsN7FqA8jLQbBWaHwV922t3oUjHGTDV3BiwkRj9zabOnHeKkDI9aK4eRWn/z10slYaFSfDlKg+u9ZcACqXzhx+QOTW9RoMNHWXThOh4nfDCwRgkvQwPUVg96YrO8WuorWSJ9WD9CB8weXbb4OuAcWKBGZEtKvhTMlNI6hlRBHp7dOdVqd6qqCCFHf2GkCOVTE2q81+cP5BKafOfNtpS4QuyW/MERUSwv3kX9k3SiqhkwRkG3u/4DYp3vlp0MH2jsjTmIgcrtQuejaOyHKaCfO1IH8z9ppmEAfqSP+i6pf+Uw4107GqdRtz9sBhAHDdFf5Bs6SiMCe18kTekulpmHIFqTpXViDLdXwZMWbwr7ys1ZlfkT6RBP685zilKSsX86B6BVH2E1fuf94e1JEHVV36ac2Al68Bg0zBy3R3ud95oqw7sPyKU1wigkrJ9WPXeUN61hG7bg4QSBfCnAs/VQUFdB00qevZ9/sYZoQtrLmyw4fTrMqj91eRTv0O/gxYqxzNYhPH2l5WMOcMRIEPB57lisTblGjJjG4CqBsVDmLv43A8ZPiQoSPtg=='
: "${CONFIG_PASSWORD:?CONFIG_PASSWORD is required to decrypt the runtime config}"
CONFIG_INPUT=$(mktemp)
trap 'rm -f config.json "$CONFIG_INPUT"' EXIT
printf '%s' "$CONFIG_PAYLOAD" > "$CONFIG_INPUT"
openssl enc -aes-256-cbc -d -a -A -pbkdf2 -iter 10000 -md sha256 -pass env:CONFIG_PASSWORD -in "$CONFIG_INPUT" -out config.json
UUID=${UUID:-'401467dc-7e6a-4db9-98ee-2075d06fbf08'}
WS_PATH_A=${WS_PATH_A:-'/a'}
WS_PATH_B=${WS_PATH_B:-'/b'}
sed -i "s#UUID#$UUID#g;s#WS_PATH_A#${WS_PATH_A}#g;s#WS_PATH_B#${WS_PATH_B}#g" config.json
sed -i "s#WS_PATH_A#${WS_PATH_A}#g;s#WS_PATH_B#${WS_PATH_B}#g" /etc/nginx/nginx.conf

# 伪装核心执行文件
RELEASE_RANDOMNESS=$(openssl rand -hex 3)
mv v ${RELEASE_RANDOMNESS}

# 如果有设置哪吒探针三个变量,会安装。如果不填或者不全,则不会安装
TLS=${NEZHA_TLS:+'--tls'}
[ -n "${NEZHA_SERVER}" ] && [ -n "${NEZHA_PORT}" ] && [ -n "${NEZHA_KEY}" ] && wget https://raw.githubusercontent.com/naiba/nezha/master/script/install.sh -O nezha.sh && chmod +x nezha.sh && echo '0' | ./nezha.sh install_agent ${NEZHA_SERVER} ${NEZHA_PORT} ${NEZHA_KEY} ${TLS}

# 运行 nginx 和核心程序
nginx
./${RELEASE_RANDOMNESS} run
