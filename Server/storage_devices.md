# 创建挂载点
sudo mkdir -p /mnt/NVMe

# 获取 UUID
sudo blkid /dev/nvme0n1p1

# 修改 fstab 配置为开机自动挂载

UUID=获取到的UUID /mnt/NVMe ntfs defaults 0 2
