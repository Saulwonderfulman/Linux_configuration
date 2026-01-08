# 1. nextcloud安装
1.1 创建 Nextcloud 配置的目录，并进入该目录
```
mkdir ~/nextcloud && cd ~/nextcloud
```
1.2 创建 docker-compose.yml 配置文件并编辑
```
nano docker-compose.yml
```
```
services:
  db:
    image: mariadb:10.11
    restart: always
    command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
    volumes:
      - ./db:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=ruttan
      - MYSQL_PASSWORD=0
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud
    networks:
      - nextcloud_net

  app:
    image: nextcloud:latest
    restart: always
    ports:
      - 8080:80
    depends_on:
      - db
      - onlyoffice
    volumes:
      - ./data:/var/www/html
      - /mnt/NVMe:/NVMe
    environment:
      - MYSQL_PASSWORD=0
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud
      - MYSQL_HOST=db
      # 代理
      - http_proxy=http://172.17.0.1:7890
      - https_proxy=http://172.17.0.1:7890
      - no_proxy=localhost,127.0.0.1,db,onlyoffice
    networks:
      - nextcloud_net

  onlyoffice:
    image: onlyoffice/documentserver:latest
    restart: always
    ports:
      - 8081:80
    environment:
      - JWT_ENABLED=true
      - JWT_SECRET=ruttan
      - JWT_HEADER=Authorization
    volumes:
      - ./onlyoffice/data:/var/www/onlyoffice/Data
      - ./onlyoffice/logs:/var/log/onlyoffice
    networks:
      - nextcloud_net

networks:
  nextcloud_net:
    driver: bridge

```
1.3 启动容器
```
sudo docker compose up -d
```
进入后台后数据库配置，选择MySQL/MariaDB
|输入框名称|填写内容|对应 YAML 里的项|
| :-----:| :----: | :----: |
|数据库用户|nextcloud|MYSQL_USER|
|数据库密码|你设置的密码|MYSQL_PASSWORD|
|数据库名称|nextcloud|MYSQL_DATABASE|
|数据库主机|db|services 下的名称|

# 2. nextcloud配置
## 2.0 初始化设置
### 2.0.1 解决“数据库缺失索引”，数据库中缺少一些索引，会导致运行缓慢

sudo docker compose exec -u www-data app php occ db:add-missing-indices

### 2.0.2 解决“Mimetype 迁移”，随着 Nextcloud 版本升级，系统需要更新文件类型的映射关系

sudo docker compose exec -u www-data app php occ maintenance:repair --include-expensive

### 2.0.3 管理设置-基本设置-后台任务选择Cron并使用root权限执行自动任务

sudo crontab -e

*/5 * * * * docker exec -u www-data nextcloud-app-1 php cron.php

## 2.1 设置不限制ip访问
```
sudo docker exec --user www-data nextcloud-app-1 php occ config:system:set trusted_domains 1 --value="*.*.*.*:8080"
```
## 2.2 启用“外部存储”功能
点击右上角头像 -> 应用 (Apps)。

在左侧选择“已禁用的应用”或直接搜索 “External storage support”，点击 启用 (Enable)。

添加本地挂载点：

点击右上角头像 -> 管理设置 (Administration settings)。

在左侧侧边栏底部找到 外部存储 (External storage)。

配置信息填写如下：

文件夹名称：自定义（例如“我的硬盘照片”），这将显示在你的文件列表中。

外部存储：在下拉菜单选择 “本地 (Local)”。

认证：无。

配置：填写设置的容器内路径（例如 /NVMe）。

可用范围：选择哪些用户或组可以看到这个文件夹（默认是所有人）。

保存： 点击最右侧的 打勾图标。如果左侧出现 绿色圆点，说明配置成功。

## 2.3 安装扩展应用
## 2.3.1 memories
安装完成后执行以下命令对图库进行更新
```
# 第一步：让 Nextcloud 发现外部存储中的文件
sudo docker compose exec -u www-data app php occ files:scan --all
# 第二步：让 Memories 专门索引这些照片（提取时间、地点、缩略图）
sudo docker compose exec -u www-data app php occ memories:index
```
## 2.3.2 onlyoffice
```
ONLYOFFICE Docs地址:http://localhost:8081/
秘钥(留空为关闭):ruttan
```



