# nextcloud安装
创建 Nextcloud 配置的目录，并进入该目录
```
mkdir ~/nextcloud && cd ~/nextcloud
```
创建 docker-compose.yml 配置文件并编辑
```
nano docker-compose.yml
```
```
version: '3'

services:
  db:
    image: mariadb:10.11
    restart: always
    command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
    volumes:
      - ./db:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=your_root_password  # 请替换为强密码
      - MYSQL_PASSWORD=nextcloud_password      # 请替换为强密码
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud

  app:
    image: nextcloud:latest
    restart: always
    ports:
      - 8080:80
    links:
      - db
    volumes:
      - ./data:/var/www/html
    environment:
      - MYSQL_PASSWORD=nextcloud_password      # 必须与上面设置的一致
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud
      - MYSQL_HOST=db
```
启动容器
```
docker compose up -d
```
进入后台后数据库配置，选择MySQL/MariaDB
|输入框名称|填写内容|对应 YAML 里的项|
| :-----:| :----: | :----: |
|数据库用户|nextcloud|MYSQL_USER|
|数据库密码|你设置的密码|MYSQL_PASSWORD|
|数据库名称|nextcloud|MYSQL_DATABASE|
|数据库主机|db|services 下的名称|

# nextcloud配置
## 设置不限制ip访问
```
sudo docker exec --user www-data nextcloud-app-1 php occ config:system:set trusted_domains 1 --value="*.*.*.*:8080"
```

## 安装扩展应用
https://memories.gallery/










