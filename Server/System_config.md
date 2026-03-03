# 1. 定期备份数据
## 1 创建备份脚本
sudo vim /usr/local/bin/hdd_backup.sh

```
#!/bin/bash
set -e

BACKUP_SOURCE="/home/你的用户名/要备份的目录"
DEVICE="$1"

# 等待自动挂载完成
sleep 3

# 获取挂载点
MOUNT_POINT=$(lsblk -no MOUNTPOINT "$DEVICE")

if [ -z "$MOUNT_POINT" ]; then
    exit 1
fi

mkdir -p "$MOUNT_POINT/backup"

rsync -a --delete --inplace --no-whole-file "$BACKUP_SOURCE"/ "$MOUNT_POINT/backup/"

sync

# 卸载
umount "$DEVICE"

# 安全断电
udisksctl power-off -b "$DEVICE"
```
授权

sudo chmod +x /usr/local/bin/hdd_backup.sh
## 2 创建 systemd 服务
sudo vim /etc/systemd/system/hdd-backup@.service

```
[Unit]
Description=HDD Backup Service for %I
After=dev-%i.device
Requires=dev-%i.device

[Service]
Type=oneshot
ExecStart=/usr/local/bin/hdd_backup.sh /dev/%I
TimeoutStartSec=0
```

## 3 设置触发规则
sudo vim /etc/udev/rules.d/99-hdd-backup.rules
```
ACTION=="add", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", ENV{ID_FS_UUID}=="你的UUID", TAG+="systemd", ENV{SYSTEMD_WANTS}="hdd-backup@%k.service"
```
重载配置
sudo udevadm control --reload
sudo systemctl daemon-reload

## #临时禁用与彻底禁用
临时禁用

sudo systemctl mask hdd-backup@.service

恢复

sudo systemctl unmask hdd-backup@.service

彻底禁用
```
sudo rm /etc/udev/rules.d/99-hdd-backup.rules
sudo rm /etc/systemd/system/hdd-backup@.service
sudo rm /usr/local/bin/hdd_backup.sh

sudo udevadm control --reload
sudo systemctl daemon-reload
```
# 2. 配置散热风扇pwm
## 找到设备树文件rk3566-orangepi-3b.dtb
cd /boot/dtb/rockchip
## 反编译设备树二进制文件
sudo dtc -I dtb -O dts -o rk3566-orangepi-3b-v2.dts rk3566-orangepi-3b-v2.dtb
## 修改 DTS 文件
sudo vim rk3566-orangepi-3b-v2.dts

找到pwm-fan的部分,修改为以下内容

        pwm-fan {
                compatible = "pwm-fan";
                #cooling-cells = <0x02>;
                pwms = <0x130 0x00 0x9C40 0x00>;
                cooling-levels = <0x00 0x32 0x64 0x96 0xc8 0xff>;
                rockchip,temp-trips = <0xc350 0x01 0xd6d8 0x02 0xea60 0x03 0xfde8 0x04 0x11170 0x05>;
                status = "okay";
                phandle = <0x30d>;
        };



## 编译dtb文件
sudo dtc -I dts -O dtb -o rk3566-orangepi-3b-v2.dtb rk3566-orangepi-3b-v2.dts

## 重启生效
sudo reboot

# 3. 开机自动挂载硬盘
## 创建挂载点
sudo mkdir -p /mnt/NVMe

## 获取 UUID
sudo blkid /dev/nvme0n1p1

## 修改 fstab 配置为开机自动挂载

UUID=获取到的UUID /mnt/NVMe ntfs defaults 0 2









