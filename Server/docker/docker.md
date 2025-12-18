# 1. 安装docker



# 2. 设置docker自启动
sudo systemctl enable docker

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


