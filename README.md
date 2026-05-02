# Proxy for Koyeb

* * *

# 目录

- [项目特点](README.md#项目特点)
- [部署](README.md#部署)
- [鸣谢下列作者的文章和项目](README.md#鸣谢下列作者的文章和项目)
- [鸣谢项目赞助商](README.md#鸣谢项目赞助商)
- [免责声明](README.md#免责声明)

* * *

## 项目特点:
* 本项目用于在 Koyeb 免费服务上部署代理服务，采用的方案为 Nginx + WebSocket + TLS。
* 核心文件和配置文件作了“特殊处理”，每个项目都不同，大大降低被封和连坐风险
* 配置文件使用 AES-256-CBC 加密存放，部署时需通过环境变量提供解密密码
* uuid 和 WebSocket 路径既可以自定义，又或者使用默认值
* 集成哪吒探针，可以自由选择是否安装
* 部署完成如发现不能上网，请检查域名是否被墙，可使用 Cloudflare CDN 或者 worker 解决。

## 部署:
* 注册 [Koyeb.com](https://app.koyeb.com/auth/signin/)
* [![Deploy to Koyeb](https://www.koyeb.com/static/images/deploy/button.svg)](https://app.koyeb.com/deploy?type=docker&name=v2r&ports=80;http;/&env[UUID]=de04add9-5c68-8bab-950c-08cd5320df18&env[NEZHA_SERVER]=server%20domain%20or%20ip&env[NEZHA_PORT]=server%20port&env[NEZHA_KEY]=agent%20key&image=docker.io/fscarmen/v2-koyeb) |
* 可用到的变量
  | 变量名 | 是否必须 | 默认值 | 备注 |
  | ------------ | ------ | ------ | ------ |
  | CONFIG_PASSWORD | 是 |        | 配置文件解密密码，必须通过部署平台环境变量设置 |
  | UUID            | 否 | de04add9-5c68-8bab-950c-08cd5320df18 | 可在线生成 https://www.zxgj.cn/g/uuid |
  | WS_PATH_A       | 否 | /a | 以 / 开头 |
  | WS_PATH_B       | 否 | /b | 以 / 开头 |
  | NEZHA_SERVER    | 否 |        | 哪吒探针服务端的 IP 或域名 |
  | NEZHA_PORT      | 否 |        | 哪吒探针服务端的端口 |
  | NEZHA_KEY       | 否 |        | 哪吒探针客户端专用 Key |

  注意：加密只能隐藏镜像/仓库中的静态配置内容。程序运行时仍会在容器内短暂生成明文配置供核心程序读取，因此请不要把解密密码公开到仓库或日志中。

![image](https://user-images.githubusercontent.com/92626977/211201128-8eb8c495-03b1-4837-b11d-db5d5cf37a10.png)
![image](https://user-images.githubusercontent.com/92626977/211201164-51917877-c672-4b62-9031-67b497fd0936.png)
![image](https://user-images.githubusercontent.com/92626977/211201178-386d8e2c-189b-40ba-a37f-ebcd4ae2be5e.png)
![image](https://user-images.githubusercontent.com/92626977/211201189-62649d0d-ebb0-42f4-946a-38dea2601b46.png)
![image](https://user-images.githubusercontent.com/92626977/211201196-3d7e59ae-3b55-42db-81ac-b324d60a0bb1.png)
![image](https://user-images.githubusercontent.com/92626977/211201217-6a5c9493-4aa9-4c68-9cba-966893617ab0.png)

## 鸣谢下列作者的文章和项目:
* ifeng 的相关项目，在此基础上作修改 https://www.hicairo.com https://github.com/hiifeng

## 鸣谢项目赞助商
* 感谢[YXVM](https://yxvm.com/aff.php?aff=764)提供赞助
* [NodeSupport](https://github.com/NodeSeekDev/NodeSupport)

## 免责声明:
* 本程序仅供学习了解, 非盈利目的，请于下载后 24 小时内删除, 不得用作任何商业用途, 文字、数据及图片均有所属版权, 如转载须注明来源。
* 使用本程序必循遵守部署免责声明。使用本程序必循遵守部署服务器所在地、所在国家和用户所在国家的法律法规, 程序作者不对使用者任何不当行为负责。
