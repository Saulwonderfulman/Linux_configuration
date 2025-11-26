# 1. 代理安装
sudo mkdir ~/mihomo

cd ~/mihomo

cp /mnt/usb/  ~/mihomo/

./mihomo-linux-arm64
运行几分钟后关闭

cp /mnt/usb/Country.mmdb  ~/.config/mihomo/

cp /mnt/usb/geosite.dat  ~/.config/mihomo/

cp /mnt/usb/  ~/mihomo/

sudo chmod +x clash

后续通过在线页面进行配置
https://yacd.metacubex.one/

更新订阅链接命令
wget -U "Mozilla/6.0" -O ~/.config/mihomo/config.yaml Clash订阅链接网址
# 2. 系统代理设置
sudo vim /etc/environment

更改以下内容并粘贴

http_proxy="http://your_proxy_server:proxy_port"

https_proxy="http://your_proxy_server:proxy_port"

ftp_proxy="http://your_proxy_server:proxy_port"

重启后生效

# 3. docker代理设置
## 3.1 创建配置文件
sudo mkdir -p /etc/systemd/system/docker.service.d

sudo vim /etc/systemd/system/docker.service.d/http-proxy.conf

## 3.2 配置代理
[Service]

Environment="HTTP_PROXY=127.0.0.1:7890"

Environment="HTTPS_PROXY=127.0.0.1:7890"

Environment="NO_PROXY=localhost,127.0.0.1"


## 3.3 重新加载系统守护进程并重启Docker
sudo systemctl daemon-reload

sudo systemctl restart docker





















