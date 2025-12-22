# 1. 定期备份数据
0 3 * * 1 rsync -a --delete /M.2硬盘路径/ /机械硬盘路径/

#crontab每周一凌晨3点进行备份

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









