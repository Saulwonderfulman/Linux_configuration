# 1. 代理安装
sudo mkdir ~/mihomo

cd ~/mihomo

cp /mnt/usb/mihomo-linux-arm64  ~/mihomo/      #软件版本为v1.19.16

sudo chmod +x mihomo-linux-arm64

./mihomo-linux-arm64      #运行几分钟后关闭

cp /mnt/usb/Country.mmdb  ~/.config/mihomo/

cp /mnt/usb/geosite.dat  ~/.config/mihomo/

./mihomo-linux-arm64      #测试，成功运行后停止。

后续通过在线页面进行配置,端口转发127.0.0.1:9090，
https://yacd.metacubex.one/

## 配置进程守护
sudo vim /etc/systemd/system/mihomo.service

```
[Unit]
Description=mihomo Daemon, Another Clash Kernel.
After=network.target NetworkManager.service systemd-networkd.service iwd.service

[Service]
Type=simple
User=orangepi
Group=orangepi
LimitNPROC=500
LimitNOFILE=1000000
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME CAP_SYS_PTRACE CAP_DAC_READ_SEARCH
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME CAP_SYS_PTRACE CAP_DAC_READ_SEARCH
Restart=always
ExecStartPre=/usr/bin/sleep 1s
ExecStart=/home/orangepi/mihomo/mihomo-linux-arm64
[Install]
WantedBy=multi-user.target
```
重载 systemd：
```
systemctl daemon-reload
```
启用 mihomo 服务（开机、重启系统后自动启动）：
```
systemctl enable mihomo
```
立即启动 mihomo 服务：
```
systemctl start mihomo
```
检查 mihomo 服务状态：
```
systemctl status mihomo
```
## 更新订阅链接命令
wget -U "Mozilla/6.0" -O ~/.config/mihomo/config.yaml Clash订阅链接网址
# 2. 系统代理设置
sudo vim /etc/environment
```
http_proxy="127.0.0.1:7890"
https_proxy="127.0.0.1:7890"
ftp_proxy="127.0.0.1:7890"
```
重启后生效

# 3. docker代理设置
## 3.1 创建配置文件
sudo mkdir -p /etc/systemd/system/docker.service.d

sudo vim /etc/systemd/system/docker.service.d/http-proxy.conf

## 3.2 配置代理
```
[Service]
Environment="HTTP_PROXY=127.0.0.1:7890"
Environment="HTTPS_PROXY=127.0.0.1:7890"
Environment="NO_PROXY=localhost,127.0.0.1"
```
## 3.3 重新加载系统守护进程并重启Docker
sudo systemctl daemon-reload

sudo systemctl restart docker





















