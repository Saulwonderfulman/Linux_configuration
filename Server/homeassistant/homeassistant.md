# 1. homeassistant安装

mkdir ~/homeassistant

cd ~/homeassistant

vim docker-compose.yml

粘贴以下内容
```
services:
  homeassistant:
    container_name: homeassistant
    image: "ghcr.io/home-assistant/home-assistant:stable"
    volumes:
      - ./config:/config
      - /etc/localtime:/etc/localtime:ro
    restart: always
    privileged: true
    network_mode: host
```
启动容器

sudo docker compose up -d

网页界面：localhost:8123
# 2. homeassistant配置
















