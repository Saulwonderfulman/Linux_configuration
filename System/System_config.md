# fcitx5 配置
## []快捷键切换
配置-附加组件-（输入法）拼音

以次定字快捷键删除，上一页下一页快捷键加入[]
## 跟随暗色主题
配置-附加组件-经典用户界面

深色主题修改为默认深色，勾选跟随系统浅色深色设置

# 2.主题（Colloid-gtk-theme）
## 安装tweaks工具
sudo apt install gnome-tweaks

## 安装依赖项
sudo apt install git sassc gtk2-engines-murrine gnome-themes-extra

## 下载 Colloid-gtk-theme
git clone https://github.com/vinceliuice/Colloid-gtk-theme.git

## 安装后删除
``````
cd Colloid-gtk-theme
./install.sh -l
/# rm -rf ~/Colloid-gtk-theme
``````
## Flatpak 应用继承主题
``````
sudo flatpak override --filesystem=xdg-config/gtk-3.0
sudo flatpak override --filesystem=xdg-config/gtk-4.0
flatpak override --user --filesystem=~/.themes
``````
# 3.图标（papirus-icon-theme）
sudo apt install papirus-icon-theme

# 4.鼠标指针主题（Bibata Modern Classic）
## 安装
sudo apt install bibata-cursor-theme
## 设置指针大小
gsettings set org.gnome.desktop.interface cursor-size 30

# 字体
## 安装并刷新缓存
``````
sudo apt install fonts-noto-cjk fonts-jetbrains-mono
fc-cache -fv
``````
## 设置字体
``````
界面字体：Noto Sans CJK SC Regular 12
文档字体：Noto Sans CJK SC Regular 12
等宽字体：JetBrains Mono Regular 12
窗口标题：Noto Sans CJK SC Medium 10
缩放：1.25
``````


# 5.开机自启动程序
``````
Fcitx5
clash-verge
flameshot
keepassXC
向日葵
``````

# 6.自定义快捷键
``````
快捷启动终端：命令：/usr/bin/gnome-terminal，快捷键：ctrl+alt+t
快捷截图：命令：sh -c "flameshot gui"，快捷键：F1
``````

# 跳过引导界面
sudo vim /etc/default/grub
``````
GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_TIMEOUT_STYLE=hidden
GRUB_DISABLE_OS_PROBER=true
``````
sudo update-grub


























