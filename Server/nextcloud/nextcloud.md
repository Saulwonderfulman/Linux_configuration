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
      - /mnt/NVMe:/NVMe      # 外部储存位置
    environment:
      - MYSQL_PASSWORD=nextcloud_password      # 必须与上面设置的一致
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud
      - MYSQL_HOST=db
      # --- 代理配置开始 ---
      - http_proxy=http://172.17.0.1:7890
      - https_proxy=http://172.17.0.1:7890
      - no_proxy=localhost,127.0.0.1,db
      # --- 代理配置结束 ---

```
启动容器
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

# nextcloud配置
## 设置不限制ip访问
```
sudo docker exec --user www-data nextcloud-app-1 php occ config:system:set trusted_domains 1 --value="*.*.*.*:8080"
```
## 启用“外部存储”功能
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

## 安装扩展应用
https://memories.gallery/










