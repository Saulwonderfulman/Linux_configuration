#自由软件
apt install -y clash-verge vim vlc keepassxc syncthing adb freecad flameshot neofetch btop gnome-boxes supertuxkart fceux cutecom vscodium pulseview gimp gocryptfs flatpak

# 添加Flathub 仓库
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# 专有软件（微信、QQ、腾讯会议、STM32CubeIDE）（Flatseal、Warehouse、cloud-music属于自由软件）
flatpak install flathub com.tencent.WeChat com.qq.QQ com.tencent.wemeet com.github.tchx84.Flatseal io.github.flattool.Warehouse com.github.gmg137.netease-cloud-music-gtk com.st.STM32CubeIDE


