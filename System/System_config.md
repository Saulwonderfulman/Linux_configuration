# 1.将F区设置为功能键优先
``````
echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf
sudo update-initramfs -u -k all
sudo reboot
``````

恢复原来设置
``````
#sudo update-initramfs -u -k all
#sudo reboot
``````

# 2.主题（Colloid-gtk-theme）
## 安装tweaks工具
``````
sudo apt update
sudo apt install gnome-tweaks
``````

## 安装依赖项
``````
sudo apt install gtk2-engines-murrine gtk2-engines-pixbuf git
``````

## 下载 Colloid-gtk-theme
``````
git clone https://github.com/vinceliuice/Colloid-gtk-theme.git
``````

## 安装后删除
``````
cd Colloid-gtk-theme
./install.sh
rm -rf ~/Colloid-gtk-theme
#chmod -R 755 ~/.themes/Colloid
``````

# 3.图标（papirus-icon-theme）
``````
sudo apt install papirus-icon-theme
``````

# 4.鼠标指针主题（Bibata Modern Classic）
## 下载
``````
git clone https://github.com/KaizIqbal/Bibata_Cursor.git
``````

## 安装后删除
``````
cd Bibata_Cursor
./install.sh
rm -rf ~/Bibata_Cursor
``````

## 设置指针大小
``````
gsettings set org.gnome.desktop.interface cursor-size 30
``````

# 5.开机自启动程序
``````
Fcitx5
clash-verge
flameshot
keepassXC
向日葵
``````

# 6.定时更新软件（每周日凌晨3点）
``````
sudo crontab -e
0 3 * * 0 apt update && apt upgrade -y
``````

# 7.自定义快捷键
``````
快捷启动终端：命令：/usr/bin/gnome-terminal，快捷键：ctrl+alt+t
快捷截图：命令：flameshot gui，快捷键：F1
``````



