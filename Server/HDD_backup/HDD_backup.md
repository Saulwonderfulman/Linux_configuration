# 1 创建备份脚本
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
# 2 创建 systemd 服务
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

# 3 设置触发规则
sudo vim /etc/udev/rules.d/99-hdd-backup.rules
```
ACTION=="add", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", ENV{ID_FS_UUID}=="你的UUID", TAG+="systemd", ENV{SYSTEMD_WANTS}="hdd-backup@%k.service"
```
重载配置
sudo udevadm control --reload
sudo systemctl daemon-reload


















