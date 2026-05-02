#!/usr/bin/env bash

# 定义 UUID 及 伪装路径,请自行修改.(注意:伪装路径以 / 符号开始,为避免不必要的麻烦,请不要使用特殊符号.)
: "${CONFIG_PASSWORD:?CONFIG_PASSWORD is required to decrypt the runtime config}"
openssl enc -aes-256-cbc -d -a -pbkdf2 -iter 10000 -md sha256 -pass env:CONFIG_PASSWORD -in config.enc -out config.json
trap 'rm -f config.json' EXIT
UUID=${UUID:-'401467dc-7e6a-4db9-98ee-2075d06fbf08'}
WS_PATH_A=${WS_PATH_A:-'/a'}
WS_PATH_B=${WS_PATH_B:-'/b'}
sed -i "s#UUID#$UUID#g;s#WS_PATH_A#${WS_PATH_A}#g;s#WS_PATH_B#${WS_PATH_B}#g" config.json
sed -i "s#WS_PATH_A#${WS_PATH_A}#g;s#WS_PATH_B#${WS_PATH_B}#g" /etc/nginx/nginx.conf

# 伪装核心执行文件
RELEASE_RANDOMNESS=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 6)
mv v ${RELEASE_RANDOMNESS}

# 如果有设置哪吒探针三个变量,会安装。如果不填或者不全,则不会安装
TLS=${NEZHA_TLS:+'--tls'}
[ -n "${NEZHA_SERVER}" ] && [ -n "${NEZHA_PORT}" ] && [ -n "${NEZHA_KEY}" ] && wget https://raw.githubusercontent.com/naiba/nezha/master/script/install.sh -O nezha.sh && chmod +x nezha.sh && echo '0' | ./nezha.sh install_agent ${NEZHA_SERVER} ${NEZHA_PORT} ${NEZHA_KEY} ${TLS}

# 运行 nginx 和核心程序
nginx
./${RELEASE_RANDOMNESS} run
