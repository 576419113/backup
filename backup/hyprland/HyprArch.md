## 零、系统安装
参考[安装指南 - Arch Wiki](https://wiki.archlinuxcn.org/zh-cn/%E5%AE%89%E8%A3%85%E6%8C%87%E5%8D%97)。
### 1.安装准备
于`archlinux.org`下载ISO镜像。
BIOS中需禁用安全启动。
UEFI启动到`Arch Linux install medium`
清屏：`clear`
验证引导模式得到64位或32位：`cat /sys/firmware/efi/fw_platform_size`
连接Wi-Fi网络：
```
ip link                 #列出网络接口
iwctl                   #进入WIFI配置，tab补全命令和设备，Ctrl+D退出
[iwd]device list        #列出设备
#打开已关闭的设备或其相应的适配器
[iwd]adapter phy0 set-property Powered on
[iwd]device wlan0 set-property Powered on
[iwd]station wlan0 scan            #扫描网络
[iwd]station wlan0 get-networks    #列出可用网络
[iwd]station wlan0 connect SSID    #连接到网络(SSID网络名称)
[iwd]station wlan0 connect-hidden SSID    #连接到隐藏网络
[iwd]exit    #退出
ping baidu.com   #验证网络状态(Ctrl+C退出)
```
更新系统时间：`timedatectl set-ntp true`
磁盘分区：
```
fdisk -l             #列出分区表，关注诸如/dev/sda、/dev/nvme0n1的设备
fdisk /dev/nvme0n1   #修改分区表
m    #帮助菜单
p    #列出磁盘分区情况
F    #输出空闲空间
g    #新建GPT分区表(非空硬盘不使用)
d    #删除分区
e    #重新分配分区
n    #新建分区，分区类型p主分区(系统分区)与e(扩展分区，容器)与l(逻辑分区，需要e)，使用推荐的分区编号、推荐的起始扇区、结束扇区(+size{M,G,T})例如+700G或者使用默认最大
l    #列出可用的分区类型码表
t    #修改分区类型、uefi、swap、linux、extened、raid、lvm、linuxex
q    #退出不保存
w    #退出并保存
```
推荐分区：EFI(建议1GB)、root、swap
格式化分区：
```
#EFI分区FAT32格式，若保留原系统不要格式化原来的分区
mkfs.fat -F 32 /dev/efi_system_partition
#格式化系统主分区为btrfs，卷标要设置
mkfs.btrfs -L ArchLinux /dev/root_partition
#格式化交换分区
mkswap /dev/swap_partition
```
挂载分区：
```
#首先必须挂载根分区
mount /dev/root_partition /mnt
#文件夹方式挂载单系统EFI分区，无法加密/boot，安全性问题
mount --mkdir /dev/efi_system_partition /mnt/boot
#文件夹方式挂载双系统EFI分区，硬件的分区尺寸过小，减少占用
mount --mkdir /dev/efi_system_partition /mnt/efi
#启用交换分区
swapon /dev/swap_partition
```
### 2.开始安装操作系统
配置软件源：
```
#更新软件列表，可能会非常慢
pacman -Sy
#备份原始镜像源
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
```
或者拉取`https://archlinux.org/mirrorlist/?country=CN&protocol=http&protocol=https&ip_version=4&ip_version=6`并配置镜像
向挂载硬盘安装软件：
```
#安装基础包、linux组件、提权、文本编辑器
pacstrap -K /mnt base linux linux-firmware linux-headers sudo nvim
```
### 3.配置系统
生成fstab文件(可以手动修改)：`genfstab -U /mnt > /mnt/etc/fstab`
进入系统环境：
```
#必须看清楚是否进入了/mnt
arch-chroot /mnt
```
安装系统软件：
```
#文本编辑器，CPU微码(intel/amd)，btrfs管理工具
pacman -S vim intel-ucode btrfs-progs
```
设置时间时区：
```
#时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#系统时间同步到硬件
hwclock --systohc
```
区域和本地化设置：
编辑`/etc/locale.gen`取消注释`en_US.UTF-8 UTF-8`和其他需要的区域(中文)并执行`locale-gen`。
创建`/etc/locale.conf`添加：
```
LANG=zh_CN.UTF-8
```
网络设置：
修改`/etc/hostname`以配置电脑名称
修改`/etc/hosts`:
```
127.0.0.1  localhost
::1        localhost
127.0.1.1  name
```
建议使用networkmanager配置Wi-Fi
```
#安装networkmanager
pacman -S networkmanager wpa_supplicant
systemctl enable NetworkManager.service
#系统网络服务
systemctl enable systemd-networkd systemd-resolved
#移动网络支持
pacman -S modemmanager usb_modeswitch
systemctl enable ModemManager.service
systemctl start ModemManager.service
#安装dhclient作为dhcp后端
```
编辑`/etc/NetworkManager/conf.d/dhcp-client.conf`：
```
[main]
dhcp=dhclient
```
终端字体`sudo pacman -S terminus-font`
设置密码：
```
#当前为root用户，建议强密码
passwd
#创建用户
useradd –d /home/beiming -m -s /bin/zsh -G wheel beiming
#顺便把root终端改了
sudo chsh -s /bin/zsh root
#修改用户密码
passwd beiming
#配置sudo权限，取消wheel行注释
EDITOR=vim visudo
```
### 4.安装引导程序(arch-chroot环境)
推荐grub
```
#os-prober双系统安装
pacman -S grub efibootmgr os-prober
#单系统安装grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
#双系统安装grub
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=Arch
```
修改`/etc/default/grub`并取消注释`GRUB_DISABLE_OS_PROBER=false`
最后生成grub设置`grub-mkconfig -o /boot/grub/grub.cfg`
### 5.收尾
```
#退出arch-chroot
exit
#关闭交换分区
swapoff /mnt/swap_partition
#取消挂载
umount -R /mnt
#重启
reboot
```
## 一、基本配置
登录进Arch Linux，可能需要重启多次
同时可能需要重新配置“零、”的内容
### 1.SSD TRIM
```
lsblk -D    #若DISC-MAX列非零，则支持TRIM
sudo systemctl status fstrim.timer
sudo systemctl enable fstrim.timer
```
### 2.网络连接，蓝牙
```
nmcli device wifi list    #列出可连接的WiFi
nmcli device wifi connect "SSID" password "密码"    #连接WiFi
#或者如上复杂配置
ping archlinux.org      #验证网络状态(Ctrl+C终止)
#安装并启用蓝牙
pacman -S bluez bluez-utils
systemctl enable bluetooth.service
systemctl start bluetooth.service
```
修改网卡名称(奇奇怪怪的操作)：
新建udev规则`/etc/udev/rules.d/70-persistent-net.rules`
```
#可替换的参数为实际MAC地址，及修改后的名称
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="MAC地址", NAME="wlan0"
```
重启系统，此时系统的网卡配置会被重置
需要修改`/etc/NetworkManager/system-connections/`目录下的配置文件
### 3.获取帮助
```
sudo pacman -S man-pages man-db texinfo
#使用man与info
man package_name
info package_name
```
软件附带帮助文档位于`/usr/share/doc/`中
### 4.pacman配置与指导
编辑`/etc/pacman.conf`：
启用颜色与并行下载
```
# Misc options
Color
ParallelDownloads = 5
```
steam与wine
```
[multilib]
Include = /etc/pacman.d/mirrorlist
```
添加archlinuxcn仓库(见[archlinuxcn列表](https://github.com/archlinuxcn/mirrorlist-repo))
```
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
```
配置archlinuxcn密钥与更新系统
```
sudo pacman -S archlinuxcn-keyring
sudo pacman -Syyu
```
定期将数据上传archlinux(可选)：`sudo pacman -S pkgstats`
pacman常见用法：
```
sudo pacman -S package_name     #安装软件包，包含依赖
sudo pacman -R package_name     #移除软件包，保留依赖
sudo pacman -Rs package_name    #移除软件包及其可移除依赖
sudo pacman -Syu          #同步软件数据库并更新系统
sudo pacman -Syu --ignore package     #暂时忽略某个包的更新，用于上游突然移除了某个包
sudo pacman -Ss string    #查询同步数据库软件包
sudo pacman -Sg string    #查询同步数据库软件包组包含内容
sudo pacman -Qs string    #查询已安装软件包
sudo pacman -Ql           #查询已安装软件包的包含文件
sudo pacman -Fy           #更新文件数据库
sudo pacman -F            #按文件名查找软件库
sudo pacman -Fl           #查看远程软件包包含文件
```
pacman的软件包缓存位于`/var/cache/pacman/pkg/`中
```
#应用自动清理软件包缓存
sudo pacman -S pacman-contrib
systemctl enable paccache.timer
```
常见 pacman 钩子：英伟达自动配置、程序desktop环境自动注入、无用desktop清理
### 5.AUR
```
#安装软件编译工具
pacman -S base-devel
```
编辑`/etc/makepkg.conf`文件：
```
CFLAGS="-march=native -O2 -pipe ..."    #自动检测架构
CXXFLAGS="${CFLAGS} ..."
MAKEFLAGS="-j$(nproc)"        #并行编译
BUILDDIR=/var/tmp/makepkg     #减少内存 tmp 占用
OPTIONS=(...!debug !lto...)   #禁用调试包和LTO
COMPRESSGZ=(pigz -c -f -n)    #配置gzip压缩
```
安装yay助手：`pacman -S yay`
yay使用方法与pacman一样
### 7.Intel、AMD、NVIDIA相关
——————Intel——————
```
#opengl，vulkan，显卡，视频处理库
pacman -S mesa lib32-mesa mesa-utils lib32-mesa-utils vulkan-intel lib32-vulkan-intel intel-media-driver libvpl vpl-gpu-rt
```
集成显卡工具：`sudo pacman -S intel-gpu-tools`：
```
sudo intel_gpu_top       #显示实时显卡数据
```
使用 Xe 驱动
```
# 记录 PCI ID，形如[8086:xxxx]
lspci -nn | grep VGA
# 添加内核参数
... i915.force_probe=!xxxx xe.force_probe=xxxx
# 生成内核配置
grub-mkconfig -o /boot/grub/grub.cfg
```
——————NVIDIA——————
```
#英伟达驱动，opencl，vdpau，nvdec，cuda，OpenGL ES
pacman -S nvidia-open-dkms dkms nvidia-utils lib32-nvidia-utils nvidia-settings libxnvctrl opencl-nvidia lib32-opencl-nvidia libvdpau-va-gl libva-nvidia-driver cuda egl-wayland egl-gbm
```
安装NVIDIA官方的驱动之后，需要编辑`/etc/mkinitcpio.conf`，添加`MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)`，在HOOKS一行删除kms并保存，然后执行`mkinitcpio -P`重新生成一次镜像。这能防止initramfs包含nouveau模块，避免nouveau和官方驱动的冲突。
使用pacman钩子自动化配置镜像`/etc/pacman.d/hooks/nvidia.hook`：
```
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia-open-dkms
Target=linux
# Change the linux part above and in the Exec line if a different kernel is used
# 如果使用不同的内核，请更改上面的 linux 部分和 Exec 行中的内容
[Action]
Description=Updating Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'
```
上述内容的信息查询
```
#查看vaapi信息
sudo pacman -S libva-utils
vainfo
#查看vdpau信息
sudo pacman -S vdpauinfo
vdpauinfo
#vulkan视频处理扩展情况
sudo pacman -S vulkan-tools
vulkaninfo
```
### 8.XDG服务
```
#工具，用户目录，文件管理器后端
sudo pacman -S xdg-utils xdg-user-dirs xdg-desktop-portal
#以英文的方式创建用户默认目录
LC_ALL=C.UTF-8 xdg-user-dirs-update --force
```
### 9.电源管理
tlp
```
#安装并启用tlp与tlp无线与耦合进程
sudo pacman -S tlp tlp-rdw ethtool tlp-pd
systemctl enable tlp.service
systemctl enable tlp-pd.service
systemctl start tlp-pd.service
systemctl start tlp.service
systemctl enable NetworkManager-dispatcher.service
#屏蔽rfkill服务，确保工作正常
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket
#立即启动tlp
sudo tlp start
```
nvidia-smi：
```
#动态功耗控制
systemctl enable nvidia-powerd
systemctl start nvidia-powerd
```
新建`/etc/systemd/system/nvidia-persistence.service`：
```
[Unit]
Description=NVIDIA Persistence Mode and Clock Control
After=nvidia-persistenced.service
Wants=nvidia-persistenced.service

[Service]
Type=oneshot
ExecStart=/usr/bin/bash -c "nvidia-smi -pm 1 && nvidia-smi -cc 1"
StandardOutput=journal
RemainAfterExit=no

[Install]
WantedBy=multi-user.target
```
提升功耗：`sudo nvidia-smi -pm 0; sudo nvidia-smi -cc 0`

### 10.音频服务
```
#alsa工具
sudo pacman -S alsa-utils
#声音固件
sudo pacman -S sof-firmware alsa-firmware alsa-ucm-conf
#pipewire程序，会话管理器，alsa后端，jack后端，音频后端，pulse-audio后端
sudo pacman -S pipewire lib32-pipewire wireplumber pipewire-alsa pipewire-jack lib32-pipewire-jack pipewire-audio pipewire-pulse
```
查询`/proc/asound/card*/codec#0`可以查到声卡支持的参数
wireplumber配置wiki:`https://pipewire.pages.freedesktop.org/wireplumber/daemon/configuration/alsa.html`
`systemctl --user restart pipewire pipewire-pulse wireplumber`以重启音频服务
### 11.安装系统组件
```
# 文件系统 btrfs, Windows NT, exFat, ext3, ext4, FAT
sudo pacman -S btrfs-progs ntfs-3g exfatprogs e2fsprogs dosfstools
# usb工具、系统总线工具、dns工具、系统固件更新、ssh
sudo pacman -S usbutils sysfsutils bind fwupd openssh
```
### 12.系统字体
```
# Noto系列
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
# 编程字体以及nerdfont补丁
sudo pacman -S ttf-hack ttf-hack-nerd
# Unifont
sudo pacman -S unifont-otf
```
nerdfont参考`https://www.nerdfonts.com/cheat-sheet`可以得到字符对应的码表，基本上要使用\U而不是\u
可以参考`https://www.jinbuguo.com/gui/fonts.conf.html`配置fontconfig
执行`fc-cache -fv`更新配置并`fc-match -s | grep 'Noto Sans CJK'`检查。
### 13.NTP时间同步
使用 systemd-timesyncd 这一 systemd 原生服务
启用`timedatectl set-ntp true`
编辑文件`/etc/systemd/timesyncd.conf`：
```
[Time]
NTP=ntp.aliyun.com
FallbackNTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
```
并重启服务`sudo systemctl restart systemd-timesyncd`
查看同步状态`timedatectl timesync-status`
## 二、平铺桌面
大部分配置见备份
### 1.Hyprland
```
# Hyprland 主体、XDG 门户，通知进程，Qt Wayland
sudo pacman -S hyprland xdg-desktop-protal-hyprland xdg-desktop-protal-kde xdg-desktop-protal-gtk qt5-wayland qt6-wayland
# 亮度控制、播放控制、剪贴板、hypr 壁纸、quick shell、hypr 取色器、Upower 电源管理
sudo pacman -S brightnessctl playerctl wl-clipboard hyprpaper quickshell hyprpicker upower
```
XDG 服务配置`~/.config/xdg-desktop-portal/portals.conf`：
```
[preferred]
default=hyprland;gtk
org.freedesktop.impl.portal.FileChooser=kde
org.freedesktop.impl.portal.ScreenCast=hyprland
org.freedesktop.impl.portal.Screenshot=hyprland
```
通知服务：
```
sudo pacman -S libnotify dunst
```
### 2.nvim
LSP服务
`https://wiki.archlinuxcn.org/zh/语言服务器协议`给出了所有可用的LSP客户端
C/C++：clang
Shell：bash-language-server shellcheck shfmt
Python：python-lsp-server python-rope python-pyflakes flake8 autopep8 yapf
MarkDown：marksman
HTML：vscode-html-languageserver
CSS：vscode-css-languageserver
JS：typescript-language-server deno
YAML：yaml-language-server
XML：lemminx
JSON：vscode-json-languageserver
Lua：lua-language-server
QML：qt5-declarative qt6-declarative
添加`/etc/profile`环境变量：
```
export PATH=$PATH:/usr/lib/qt6/bin/
```
### 3.妙控键盘
编辑`/etc/modprobe.d/hid_apple.conf`：
```
options hid_apple fnmode=2
```
重新生成镜像配置：`sudo mkinitcpio -P`
## 三、进阶配置
### 1.btrfs快照
```
# 安装snapper
sudo pacman -S snapper
# 创建配置文件
snapper -c <配置名称> create-config /
# 删除配置文件
snapper -c <配置名称> delete-config
# 列出配置文件
snapper list-configs
# 拍摄普通快照
snapper -c <配置名称> create [选项] --description=""
# 列出 配置文件 下面所有快照
snapper -c <配置名称> list
# 0号快照指系统当前状态，不是快照，好像是543210的时间顺序
# 删除 配置文件 下面的快照
snapper -c <配置名称> delete <快照 1 编号> [<快照 2 编号>...]
# 比较快照的区别
snapper -c <配置名称> status <快照 1 编号>..<快照 2 编号>
# 区别如+创建，-删除，c内容改，t类型改，p权限改，u主别改，g组别改，x扩展改，a ACL改
# undo回滚快照，之前必须先手动备份，防止识别
snapper -c <配置名称> undochange <快照编号>..0  #0表示当前状态
# undo回滚是撤销id到0的状态，即回复到id状态，id后的快照将被保留
# rollback回滚(可能产生严重的兼容问题，不要使用！)
sudo snapper -c root rollback <快照ID>
# rollback彻底回滚到id状态，将丢弃id后的数据
# 回滚后检查
sudo reboot #可能需要
sudo snapper -c root status <回滚快照ID>..0  #验证回滚结果
systemctl list-units --failed  # 检查失败的服务
journalctl -xe   # 查看系统日志
sudo apt --fix-broken install #依赖问题
```
snapper配置`/etc/snapper/configs/`
### 2.软件汇总
常规软件：
Helvum Pipewire流控制、hardinfo硬件信息、OBS录播软件、firefox浏览器、thunderbird邮箱、fastfetch系统信息、LDDC逐字歌词获取
AUR软件：
linuxqq、wechat-bin、wps-office-cn、wps-office-mui-zh-cn、watt-toolkit-bin、astral-bin
linuxqq的electron参数配置文件：`~/.config/qq-flags.conf`：
```
--enable-features=UseOzonePlatform
--ozone-platform=wayland
--enable-wayland-ime
--force-device-scale-factor=1.2
```
### 3.docker
```
pacman -S docker docker-buildx
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker $USER
```
在`/etc/docker/daemon.json`中配置docker镜像，一行一个镜像：
```
{
  "registry-mirrors": [
    "https://docker.nju.edu.cn/"
  ]
}
```
重启docker：`sudo systemctl restart docker`
或使用`https://1ms.run/`
### 4.steam
启用NTSync，新建文件`/etc/modules-load.d/ntsync.conf`添加`ntsync`并重启。
安装uudeck-docker：`https://github.com/wangym5106/uudeck-docker`
```
#启用32位库mutilib的情况下安装steam
sudo pacman -S steam
```
ProtonGE解压在`~/.steam/root/compatibilitytools.d/`内。
环境变量参考：`https://www.h.juij.fun/post/wine--proton-%E5%85%BC%E5%AE%B9%E5%B1%82%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F%E5%8F%8A%E5%90%AF%E5%8A%A8%E9%A1%B9%E5%8F%82%E6%95%B0%E5%8F%82%E8%80%83/`
互动影视：`PROTON_USE_DXVK=1 PROTON_ENABLE_NVAPI=1 %command%`
steam游戏数据路径`/home/beiming/.steam/steam/steamapps/compatdata/3831120/`
对于steam输入法：`env XMODIFIERS=@im=fcitx LANG=zh_CN.UTF-8`同时按下crtl+space或crtl+shift激活输入法
对于需要输入中文的游戏：`XMODIFIERS=@im=fcitx %command%`
部分linux游戏需要强制切换为GE Proton兼容层(这样就可以玩到win版本，哭笑)，目前需要开盲盒，待解决。
### 5.输入法
```
pacman -S fcitx5 fcitx5-im fcitx5-chinese-addons fcitx5-rime fcitx5-qt librime fcitx5-configtool fcitx5-breeze
```
皮肤包解压到`~/.local/share/fcitx5/themes`文件夹中
rime输入法位于`~/.local/share/fcitx5/rime`
```
# 安装万象拼音(配置文件见备份)
sudo pacman -S rime-wanxiang-pinyin
```
万象拼音里面的快捷键：
```
Tab       拼音分词跳转
Ctrl+`    切换输入方案
U         大写U随后输入 Unicode
,         逗号用于超级上屏(表情、化学式等)
```
### 6.软件缩放与GTK配置
添加环境变量`export GTK_USE_PORTAL=1`让gtk软件用kde窗口。可能需要为应用单独配置。
```
#Qt
env QT_SCALE_FACTOR=1.2              #单个应用
env QT_SCREEN_SCALE_FACTORS="2;2"    #多显示器
env QT_FONT_DPI=96                   #文字dpi
env QT_AUTO_SCREEN_SCALE_FACTOR=1    #让Qt遵循全局dpi，与系统混用需置为零
#GTK
env GDK_SCALE=2          #控件和字体
env GDK_DPI_SCALE=0.5    #字体2*0.5=1
#JAVA-AWT/Swing
java -Dsun.java2d.uiScale=2.0
#JAVA-JavaFX
java -Dglass.gtk.uiScale=192dpi -Dglass.gtk.uiScale=2.0
#Electron
--force-device-scale-factor=1.5
```
### 7.安装B站
使用此项目：`https://github.com/msojocs/bilibili-linux`
```
sudo pacman -S nodejs npm
npm config set registry https://registry.npmmirror.com
sudo npm install -g cnpm --registry https://registry.npmmirror.com
sudo cnpm install -g asar
```
跳转到bilibili目录
```
asar e app.asar bilibili
sudo cnpm install electron      #可能已经不需要
sudo cnpm install -g electron   #可能已经不需要
npm install                     #可能已经不需要
#魔改options，可能已经不需要，icon=path.join(__dirname,"/main/assets/images/icon.png")
electron . --no-sandbox
```
将desktop文件复制到applications中！wayland才能显示任务栏图标！不需要icon指定。
bilibili electron flag位置：`~/.config/bilibili/bilibili-flags.conf`
### 8.GE Proton-wine
！手工搭建wine不要安装OSS，电脑音频设备会废掉！
用ge-proton取代(需要steam环境)：
```
#!/bin/bash

# ===== 用户配置区域 =====
PROTON_GE_VERSION="GE-Proton10-32"           # 替换为你的 Proton GE 版本
PROTON_PATH="$HOME/.steam/root/compatibilitytools.d/$PROTON_GE_VERSION"
APP_EXE="$HOME/Games/raw/eve-online-latest+Setup.exe"             # 替换为你的应用路径
PFX_DIR="$HOME/Games/proton/pfx_eveonline"       # 独立前缀目录
#steam游戏参考为steamapps/compatdata/491950/
# ========================

# 创建独立前缀目录
mkdir -p "$PFX_DIR"

export XMODIFIERS=@im=fcitx        #解决输入法问题

# 设置关键环境变量 (完全隔离)
export STEAM_COMPAT_DATA_PATH="$PFX_DIR"
export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/root"
export STEAM_RUNTIME=0                        # 禁用Steam运行时
export PROTON_USE_NTSYNC=1                    # 启用ntsync
#export PROTON_NO_ESYNC=1                     # 禁用Esync帧优化
#export PROTON_NO_FSYNC=1                     # 禁用Fsync帧优化
export DXVK_ASYNC=1                           # 启用异步着色器编译
#export PROTON_ENABLE_NVAPI=0                 # 禁用Nvidia高级功能
export DXVK_STATE_CACHE=1                     # 启用着色器缓存
#export DXVK_HDR=1                            # 激活hdr
export DXVK_HUD=fps,version,memory,devinfo    # DXVK显示
#export DXVK_FRAME_RATE=25                    # 最大帧率，0不限制
export PROTON_CRASH_REPORT_DIR="/tmp"         # 日志重定向到临时目录
export WINEDLLOVERRIDES="winemenubuilder.exe=d"  # 禁用桌面集成
#export DXVK_CONFIG_FILE=/home/xxx/dxvk.conf  # 启用外部配置

# 初始化 Wine 前缀 (首次运行需要)
if [ ! -d "$PFX_DIR/pfx" ]; then
    echo "正在初始化 Wine 前缀..."
    "$PROTON_PATH/proton" run wineboot -u
fi

# 启动应用程序
echo "使用 Proton GE $PROTON_GE_VERSION 启动应用程序..."
"$PROTON_PATH/proton" run "$APP_EXE"
```
设置的dxvk配置文件可以用如下分割不同应用配置
```
[app.exe]
dxvk.option = value
```
### 9.waydroid
```
pacman -S waydroid lxc python3 python-pyclip wl-clipboard android-tools
```
systeam和vender放在`/etc/waydroid-extra/images`里,可先修改文件权限加速，再改回来。
waydroid关闭：
```
waydroid session stop; sudo systemctl stop waydroid-container
```
其容器配置路径`/var/lib/waydroid/lxc/waydroid/`
其根目录位于`/var/lib/waydroid/rootfs/`
其`/data/`目录路径`~/.local/share/waydroid/data/`
#### waydroid-scripts插件
项目`https://github.com/casualsnek/waydroid_script`
先安装`sudo pacman -S lzip`
进入下载得到的`waydroid_script`目录，进行安装
```
python3 -m venv venv
venv/bin/pip install -r requirements.txt
sudo venv/bin/python3 main.py
```
如果下载速度慢可以先篡改`waydroid_script/stuff/`里的python脚本，大多数用github
#### 联网问题
`sudo sed -i~ -E 's/=.\$\(command -v (nft|ip6?tables-legacy).*/=/g' /usr/lib/waydroid/data/scripts/waydroid-net.sh`
#### adb触摸映射
开启waydroid的USB调试，显示指针位置，waydroid配置保持adb
`sudo waydroid shell ip a`得到非127开头ip
`adb connect 192.168.240.112:5555`IP加5555端口，在waydroid中选择允许
`adb devices`以验证
```
adb shell input tap x y       #触摸坐标
adb shell input text ''       #输入文本
adb shell input swipe x1 y1 x2 y2 ms           #在毫秒内滑动
adb shell input draganddrop x1 y1 x2 y2 ms     #在毫秒内拖动
adb shell input motionevent DOWN|UP|MOVE|CANCEL x y  #模拟运动，按下/抬起/移动到坐标，按下瞬移抬起
adb shell input swipe x y x y ms         #长按多少毫秒
adb shell settings put system pointer_location 1     #显示指针位置
adb shell settings get system pointer_location       #获取值
adb push file /storage/emulated/0/Download
```
可能需要自动点击过滤掉键盘按键
#### 共享文件夹(失败)
```
#挂载
sudo mount --bind ~/Downloads ~/.local/share/waydroid/data/media/0/Download
#解除挂载
sudo umount ~/.local/share/waydroid/data/media/0/Download
```
#### prop配置
```
#将列表中的应用伪造鼠标输入为触摸输入
waydroid prop set persist.waydroid.fake_touch <package_name_list>
#伪造wifi状态，所有联网程序都需要
waydroid prop set persist.waydroid.fake_wifi <package_name_list>
```
#### 配置文件
`/var/lib/waydroid/waydroid.cfg`
```
[waydroid]
auto_adb = True           #自动连接adb
#指定显卡128核显、129独显
drm_device=/dev/dri/renderD129
[properties]
ro.sf.lcd_density = 240   #修改DPI
```
`sudo waydroid upgrade -o`使配置生效
#### 输入法
安装fcitx-android-x86，仅保留中文输入法完事(少数支持主机键盘的输入法)。
#### 出厂设置
```
sudo rm -rf /var/lib/waydroid
sudo rm -rf ~/.local/share/waydroid
sudo rm -rf ~/.local/share/applications/*aydroid*
```
### 10.virt manager
```
#NAT/DHCP网络，SSH服务，
sudo pacman -S virt-manager qemu-full libvirt dnsmasq openbsd-netcat libvirt-dbus
sudo systemctl enable --now libvirtd
sudo systemctl enable libvirtd.socket
sudo usermod -aG libvirt,kvm,libvirt-qemu,render,video $USER
```
重启，kvm/qemu连接右键启用default网络
前提只能用ISO做介质
安装virt-win.iso引用显卡加速：
```
#将被安装至/var/lib/libvirt/images/virtio-win.iso，与虚拟机同路径
yay -S virtio-win
```
```
sudo pacman -S cdrtools
genisoimage -o o.iso /path/
```
将esd系统修改为install.esd，使用ultraiso打开ISO套壳放入sources文件夹中并打包
### 11.PDFMathTranslate
Conda3.11环境下：
```
pip install pdf2zh
set HF_ENDPOINT=https://hf-mirror.com
pdf2zh -i
```
`https://www.modelscope.cn/models/AI-ModelScope/DocLayout-YOLO-DocStructBench-onnx/files`下载文档布局模型
webui`http://localhost:7860/`
```
pdf2zh files/links [options]   #使用
-i            #进入GUI
-p            #部分文档翻译(eg:1-3,5,7)
-li           #源语言，英语en、中文zh
-lo           #目标语言
-s            #翻译服务，openailiked
-t            #多线程，线程数
-o            #输出目录
-f            #正则，需要保留的字体内容，默认这些字体"(CM[^R]|MS.M|XY|MT|BL|RM|EU|LA|RS|LINE|LCIRCLE|TeX-|rsfs|txsy|wasy|stmary|.*Mono|.*Code|.*Ital|.*Sym|.*Math)"
-c            #正则，需要保留的字符，这些字符"(\(|\||\)|\+|=|\d|[\u0080-\ufaff])"
-cp           #兼容模式
--share       #公开链接
--authorized  #授权
--prompt      #自定义大语言模型设定文件，文件中的可用变量即${var}：lang_in源语言、lang_out目标语言、text翻译文本
--onnx        #使用自定义DocLayout-YOLO ONNX模型，路径
--serverport  #使用自定义WebUI端口
--dir         #批量翻译
--config      #配置文件
--serverport  #自定义 gradio 服务器端口
--babeldoc    #使用实验性后端BabelDOC翻译	
```
使用llama.cpp
```
export OPENAILIKED_BASE_URL=http://127.0.0.1:8033
export OPENAILIKED_API_KEY=gzz
export OPENAILIKED_MODEL=Qwen3.5-2B-Q4_K_M.gguf
pdf2zh "/home/beiming/Downloads/Interstellar-script.pdf" -li en -lo zh -s openailiked -f "" -c "(\(|\||\)|\+|=|\d|[\u0080-\ufaff])" -o "/home/beiming/Downloads/"
```
### 12.demucs
伴奏分离榜单：`https://mvsep.com/quality_checker/multisong_leaderboard?sort=vocals`
`pip install demucs`
`demucs -o "/home/beiming/Downloads/" --no-split --shifts 10 --int24 --two-stems=vocals tracks '/home/beiming/Music/Infinity.flac'`
`demucs -o "/home/beiming/Downloads/" --overlap 0.9 --shifts 1 --int24 -n htdemucs_ft --two-stems=vocals tracks '/home/beiming/Music/三国杀/长乐调.flac'`
参数：
```
--two-stems=vocals       #仅分离两个音轨
--shifts                 #重复运算几次，可能过于锐化,ft模型会x4
--no-split               #不分割音频，歌曲超过1min报错
-n, --name               #模型名称,htdemucs,htdemucs_ft
--repo                   #预训练模型路径
--overlap                #分割音频的重叠，小数百分比，不能为1，将增加时间
--segment SEGMENT        #自定义分割音频的秒数
--clip-mode {rescale,clamp}    #音频削波策略，重新缩放，截断
-j, --jobs               #核心处理数，gpu可能无效
-d cpu/gpu               #指定使用那个，默认gpu
```
### 13.python键鼠evdev自动化
获取设备硬件信息：
```
python -m evdev.evtest
```
得到键盘event3，鼠标event6，触控板5用
```
import evdev
device = evdev.InputDevice('/dev/input/event3')
for event in device.read_loop():
    if event.type == evdev.ecodes.EV_KEY:
        print(evdev.categorize(event))     #down，hold，up
```
or`sudo evtest`
加以验证
ecodes模块：
```
from evdev import ecodes
ecodes.A                          #返回A的代码
ecodes.ecodes['A']                #同上
ecodes.KEY[30]                        #返回"A"，可能有多个结果
ecodes.bytype[ecodes.EV_KEY][30]      #同上
```
`device.capabilities(verbose=True)`列出鼠标设备能力：
```
EV_KEY                  #按键
-BTN_LEFT/BTN_MOUSE     #鼠标左键
-BTN_RIGHT              #鼠标右键
-BTN_MIDDLE             #鼠标中键
-BTN_SIDE/BTN_EXTRA     #侧边按钮
EV_REL                  #相对坐标
-REL_X/REL_Y            #鼠标X/Y轴移动的像素偏移
-REL_HWHEEL/REL_WHEEL   #水平/垂直滚轮滚动（旧协议）
-REL_WHEEL_HI_RES/REL_HWHEEL_HI_RES     #高精度滚轮（支持更细粒度）
EV_ABS                  #功能待定，绝对坐标
-ABS_X
-ABS_Y
```
触摸板能力：
```
EV_KEY
-BTN_LEFT               #点击
-BTN_TOOL_FINGER        #1根手指触摸
-BTN_TOOL_QUINTTAP      #5根手指触摸
-BTN_TOUCH              #手指是否在触摸板上
-BTN_TOOL_DOUBLETAP     #2根手指触摸
-BTN_TOOL_TRIPLETAP     #3根手指触摸
-BTN_TOOL_QUADTAP       #4根手指触摸
EV_ABS
-ABS_X                  #单点触控绝对坐标
-ABS_Y
-ABS_MT_SLOT            #当前是第几触点
-ABS_MT_POSITION_X      #当前触点坐标
-ABS_MT_POSITION_Y
-ABS_MT_TOOL_TYPE       #触点类型
-ABS_MT_TRACKING_ID     #触点id
```
键盘KEY后：
```
1...0  MINUS  EQUAL  BACKSPACE  TAB  A...Z  LEFTBRACE左方括号  RIGHTBRACE  ENTER
LEFTCTRL  SEMICOLON分号  APOSTROPHE引号  GRAVE波浪号  LEFTSHIFT  BACKSLASH反斜杠
COMMA逗号  DOT句号  SLASH斜杠  RIGHTSHIFT  KPASTERISK小键盘乘号  LEFTALT
SPACE  CAPSLOCK  F1...F12  NUMLOCK  KP1-KP0小键盘数字
KPDOT小键盘小数点  KPMINUS小键盘减号  KPPLUS小键盘加号
KPASTERISK小键盘乘号  KPSLASH小键盘除号  KPENTER小键盘回车
RIGHTCTRL  LEFTALT  RIGHTALT  LEFTMETA（Win/Command）  RIGHTMETA
```
### 14.evemu自动化，sudo运行
`sudo pacman -S evemu`
```
evemu-record --list          #列出所有输入设备
evemu-record /dev/input/event2 > events.evemu     #录制事件到文件，ctrlC终止
evemu-play /dev/input/event2 < events.evemu       #回放
evemu-describe /dev/input/event2     #设备详情
#发送事件到设备,type父级分类，code按键
evemu-event [--sync] <device> --type <type> --code <code> --value <value>
```
### 15.mpv
```
pacman -S mpv
```
mpv配置文件：`~/.config/mpv/mpv.conf`(命令行>文件夹mpv.conf>此)
按键控制：`~/.config/mpv/input.conf`
请不要参考任何现成文件，仅使用mpv.io的参考
色域映射错误可以根据rgb和hsv更改对比度(不改)、明度v、伽马(不改)、饱和度s、色相-h
alass项目采用快速傅里叶变换可以高效处理字幕与视频偏移
### 16.mpv-danmuapi
项目`https://github.com/huangxd-/danmu_api`
```
npm config set registry https://registry.npmmirror.com
npm install
npm start
```
### 17.firefox
检查源码ctrl+-缩放
about:config配置的常驻设置(见备份)于`~/.config/mozilla/firefox/*.default-release/user.js`中，每次更新不需要重新配置。
隐私与安全 > 基于HTTPS的DNS：选择增强保护`https://dns.alidns.com/dns-query`
启用浏览器开发者选项设置->高级设置->浏览器界面、远程调试
ctrl+alt+shift+i唤出父进程浏览器工具箱，其本质为一个新的firefox修改一下语言即可，其他不可修改，更不要为父进程浏览器登录账号！
打开firefox配置文件目录`/home/beiming/.mozilla/firefox/*.default-release/`，新建chrome目录及其下的userChrome.css
警告：请不要开启最小字体大小设置，此选项导致flex容器bug
stylus网站单独设置css:
```
/*bing.com*/
/*横排图片*/
ul.b_hList li{
    padding-right: 0.2% !important;
}
/*水平滚动条*/
[elementtiming^="frp."]{
    display: none !important;
}
/*链接单排序号*/
span.rd_attr_items_idx{
	--smtc-gap-between-content-medium: --smtc-gap-between-content-medium*1.2;
}
```
### 18.easyeffects
```
sudo pacman -S easyeffects lsp-plugins calf zam-plugins
```
pacman钩子干掉无用desktop
```
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target = lsp-plugins
Target = zam-plugins
[Action]
Description = Remove many desktop files...
When = PostTransaction
Exec = /bin/bash -c "rm /usr/share/applications/in.lsp_plug.*.desktop /usr/share/applications/com.zamaudio.*.desktop"
```
### 19.aria2
配置文件`~/.config/aria2/aria2.conf`：
```
continueBeiming C++ Library/
dir=${HOME}/Downloads
file-allocation=none
max-connection-per-server=16
max-concurrent-downloads=16
split=16
min-split-size=5M
```
配置系统服务文件`~/.config/aria2/aria2d.conf`：
```
continue
daemon=true
dir=/home/Downloads
file-allocation=none
log-level=warn
max-connection-per-server=16
max-concurrent-downloads=16
split=16
min-split-size=5M
enable-http-pipelining=true

enable-rpc=true
rpc-listen-all=true
```
aria2系统服务`~/.config/systemd/user/aria2cd.service`：
```
[Unit]
Description=Aria2 Daemon
After=network.target

[Service]
ExecStart=/usr/bin/aria2c --conf-path=/home/beiming/.config/aria2/aria2d.conf -D
RemainAfterExit=yes

[Install]
WantedBy=default.target
```
执行：`systemctl --user enable aria2cd`
### 21.Prism Launcher
```
sudo pacman -S prismlauncher jdk-openjdk
```
添加环境变量`ALSOFT_DRIVERS=alsa XMODIFIERS=@im=fcitx GTK_IM_MODULE=fcitx __GL_THREADED_OPTIMIZATIONS=0`以解决外置声卡、输入法、英伟达OpenGL问题
java参数：`-XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:ParallelGCThreads=28 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch`
### 22.mpd与ncmpcpp
在wireplumber中禁用声卡设备，交给alsa管理
`alsamixer -c 2`用于保存当前声卡的通道信息
```
sudo alsactl store        #保存声卡信息
sudo alsactl restore      #恢复声卡信息
```
### 23.flatpak配置
flatpak换源
```
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-modify flathub --url=https://mirrors.ustc.edu.cn/flathub
```
配置文件把常规config内容复制到`~/.var/app/*/config/`
图标
```
sudo cp /var/lib/flatpak/app/*/current/active/export/share/applications/*.desktop /usr/share/applications/
sudo cp -r /var/lib/flatpak/app/*/current/active/export/share/icons/hicolor/* /usr/share/icons/hicolor/
```
密钥问题(若存在)
```
wget https://flathub.org/repo/flathub.gpg
flatpak remote-modify --gpg-import=flathub.gpg flathub
```
### 24.octeva
octeva安装插件，在`https://sourceforge.net/projects/octave/files/Octave%20Forge%20Packages/Individual%20Package%20Releases/`下载插件文件
```
#国内无法访问需要此手段
pkg install file_path
pkg load plugin
```
octeva常规插件：symbolic(符号计算，需要python包sympy)、optim(非线性估计，需要前置包struct、statistics、io)
### 25.Alist挂载
安装：
```
yay -S alist
```
服务启动要(不可用systemctl)：
```
alist server
```
## 四、美化
### 1.GRUB
修改字体与大小：
```
sudo grub-mkfont -s 32 -o /boot/grubfont.pf2 /home/beiming/Downloads/unifont-16.0.04.ttf 
```
编辑`/etc/default/grub`：
```
# 菜单显示时间
GRUB_TIMEOUT=30
# 菜单字体
GRUB_FONT="/boot/grubfont.pf2"
# 取消内核参数 quiet
```
执行`sudo grub-mkconfig -o /boot/grub/grub.cfg`重新生成GRUB配置
### 2.应用与系统主题
GTK 使用 XDG 门户文件选择器，环境变量`GTK_USE_PORTAL=1`
```
# 安装必要组件
sudo pacman -S breeze breeze5 breeze-gtk breeze-icons qt5ct qt6ct gtk3
```
qt5ct 和 qt6ct 配置 Qt 主题，并使用环境变量`QT_QPA_PLATFORMTHEME`
```
# gtk 应用定义配置文件并使用 gsettings 配置
gsettings set org.gnome.desktop.interface gtk-theme Breeze
gsettings set org.gnome.desktop.interface icon-theme Breeze
```
### 3.光标主题
添加环境变量`XCURSOR_THEME=breeze_cursors`
### 4.SDDM

## 四、开发
### 1.Anaconda
`https://mirrors.zju.edu.cn/docs/anaconda/`浙大镜像
`https://mirrors.ustc.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh`中科大镜像
非sudo安装即可并添加环境变量`export PATH="$HOME/miniconda3/bin:$PATH"`
```
#进入conda环境，需要重启终端
conda init
#创建一个名为 "myenv" 的新环境:
conda create --name myenv
#创建指定版本的环境：
conda create --name myenv python=3.8
#激活环境，需要重启终端：
conda activate myenv
#要退出当前环境使用以下命令：
conda deactivate
查看所有环境：
#conda env list
#复制环境：
conda create --name myclone --clone myenv
#删除环境：
conda env remove --name myenv
#禁止默认进入conda环境
conda config --set auto_activate false
#禁止conda修改提示符，PS1自行设定
conda config --set changeps1 false
```
### 2.编译win程序
```
sudo pacman -S mingw-w64
#可以使用如下
x86_64-w64-mingw32-gcc
x86_64-w64-mingw32-g++
x86_64-w64-mingw32-gcc-win32
x86_64-w64-mingw32-g++-win32
#配置输入输出编码以兼容windows的gbk
gcc -finput-charset=utf-8 -fexec-charset=gbk
```
### 3.gcc安全与教程
```
-lm
#连接数学库
-g
#编译时附带可供gdb调试的信息
-fsanitize=address
#用于检测内存访问错误，例如缓冲区溢出、释放后使用（use-after-free）等问题。
-fsanitize=undefined
#捕获未定义行为，例如整数溢出、无效的位移操作、空指针解引用等。
-fsanitize=leak
#检测内存泄漏，帮助开发者定位未释放的动态内存。
-fsanitize=thread
#用于检测多线程问题，例如数据竞争（data race）和死锁。
-fsanitize=memory
#捕获未初始化内存的使用，确保程序的内存操作安全。
```
### 4.electron参数
```
#非沙箱化
--no-snadbox
#启用wayland
--enable-features=UseOzonePlatform
--ozone-platform=wayland
#强制缩放(不需要)
#--force-device-scale-factor=1.5
#启用基于wayland的输入法
--enable-wayland-ime
```
### 6.Java环境
```
sudo pacman -S jdk-openjdk
```
### 7.Godot开发文档打包教程
参与`https://hosted.weblate.org/projects/godot-engine/godot/zh_Hans/`一起汉化
拉取`https://github.com/godotengine/godot-docs/tree/4.6`(非master，否则不同步，建议官方docs最高版本号)和`https://github.com/godotengine/godot-docs-l10n/tree/4.6`(与docs同步非master，否则没有class翻译)并将godot-docs放进l10n的docs目录中，用l10n的翻译好的rts覆盖docs的rts，运行前建议先看输出的红色日志
新建conda环境，查看`docs/conf.py`内容并安装必要模块：
```
pip install sphinx=="8.1"
pip install sphinx-rtd-theme sphinx-tabs sphinx-notfound-page sphinxext-opengraph sphinx-copybutton sphinxcontrib-video gdtoolkit
```
修改`language = os.getenv("READTHEDOCS_LANGUAGE", "zh_CN")`
添加：
```
import multiprocessing
num_cpu = multiprocessing.cpu_count()
num_jobs = max(1, num_cpu - 2)
extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.viewcode',
    # 启用缓存
    'sphinx.ext.intersphinx',
]
autodoc_cache_dir = '_cache'
```
修改`make.bat`转化为shell添加`export SPHINXOPTS="-j 8"`并运行此脚本(内存占用1G1线程)，经过长时间的编译后位于`_build`文件夹
```
./make html      #转换为html
./make clean     #清除构建
```
### 8.kdevelop
```
sudo pacman -S kdevelop kdevelop-python
#QT检查工具、CPP检查工具、堆栈追踪
sudo pacman -S clazy cppcheck heaptrack
#kdevelop和kate均有代码片段工具
```
需要创建自己的代码格式化器，kdevelop需要根据其在编码和格式化时自动应用成代码格式化器里面的样式，建议clang-format
```
#依据内部配置文件生成配置
clang-format -style=llvm -dump-config > .clang-format
```
语法高亮配置路径：`/usr/share/org.kde.syntax-highlighting/syntax-bundled/`
### 9.加速服务
DNS污染：换DNS，使用DoH
SNI阻断：ESNI或者SNI伪造
IP封禁：无解
```
#用dns查询ip
dig @223.5.5.5 example.com +short
```
### 10.python pip
```
sudo pacman -S python-pip
pip config set global.index-url "https://mirror.nju.edu.cn/pypi/web/simple"
pip config set global.extra-index-url "https://mirrors.aliyun.com/pypi/simple"
pip config set install.trusted-host "mirrors.aliyun.com mirror.nju.edu.cn"
```
### 11.git
详见`https://git-scm.com/book/zh`
```
#配置用户信息
git config --global user.name "Gong Zhizhou"
git config --global user.email "geokung@qq.com"
git clone                    #将远程分支拉取到本地
git init                     #初始化git仓库
git add filename             #将文件添加到下一次提交中
.gitignore                   #存放忽略数据
git commit -m ""             #提交说明
git remote add origin URL    #与远程仓库建立连接
# 拉取远程代码并尝试合并
git pull origin main --allow-unrelated-histories
# 配置git镜像
git config --global url."https://gh-proxy.org/github.com/".insteadOf "https://github.com/"
# 临时禁用git镜像
git config --unset url."https://gh-proxy.org/github.com/".insteadOf "https://github.com/"
git push -u origin master      #提交到远程仓库
```
github ssh key:
```
#若.ssh目录不存在
ssh-keygen -t rsa -C "xxx@xxx.com"
#查看公钥并上传github
cat ~/.ssh/id_rsa.pub
#尝试链接
ssh -T git@github.com
#随后使用ssh git，远程地址设置ssh地址，或重新指定地址
git remote set-url origin git@github.com:YourName/YourRepo.git
```
### 12.sqlite
```
#安装sqlite及其可视化软件
sudo pacman -S sqlite sqlitebrowser
sqlite3 data.db
```
### 13.llama.cpp
先安装gcc11，使用gcc-11
编译
```
git clone git@github.com:ggml-org/llama.cpp.git llama.cpp
rm -rf build
mkdir build
cd build
cmake ..
cd ..
cmake -B build -DGGML_CUDA=ON -DCMAKE_CUDA_COMPILER=/opt/cuda/bin/nvcc -DCMAKE_INSTALL_RPATH="/opt/cuda/lib64;\$ORIGIN" -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON -DCMAKE_CUDA_HOST_COMPILER=/usr/bin/gcc-11
cmake --build build --config Release --parallel $(nproc)
```
示例：
```
llama-cli -m /home/beiming/Model/Qwen3.5-4B-Q4_K_M.gguf --color on -fa 1 -ngl 64 --reasoning off
llama-bench -m /home/beiming/Model/Qwen3.5-4B-Q4_K_M.gguf -ngl 64 -fa 1
llama-server -m /home/beiming/Model/Qwen3.5-2B-Q4_K_M.gguf -fa 1 -ngl 64 --reasoning off --host 127.0.0.1 --port 8033
```
编译出的文件位于`llama.cpp/build/bin/`可以添加到环境变量中
## 五、KDE相关
### 0.kde提供的实用程序
kdialog显示窗口
### 1.dolphin文件管理器右键菜单
配置文件夹`/usr/share/kio/servicemenus/`
新建desktop文件(清除注释)：
```
[Desktop Entry]
#服务类型，不是软件
Type=Service
#此服务菜单所适用的文件类型，用“;”间隔，目录inode/directory、所有文件application/octet-stream，可以用“*”匹配所有子类，
MimeType=image/png;image/jpeg;
#定义多个行为
Actions=setAsWallpaper;tileAsWallpaper;
#创建行为组
X-KDE-Submenu=Set As Background
#最高优先级
X-KDE-Priority=TopLevel
#行为1
[Desktop Action setAsWallpaper]
Name=Set As Background Image
Name[fi]=Aseta taustakuvaksi
Icon=background
Exec=qdbus org.kde.plasmashell...
行为2
[Desktop Action tileAsWallpaper]
Name=Use As Wallpaper Tile
Icon=background
Exec=qdbus org.kde.plasmashell...
```
### 2.右键新建文件
将文件放进`~/Templates/`中，自动识别名称
### 3.debug指南
并重启，使用GDB时选择启用debuginfod(回答y)
```
gdb kcalc        #替换为实际软件名
(gdb) run        #运行，同时会自动下载依赖的库
```
### 4.qdbus
(若系统包含以下工具不必安装)安装：`sudo pacman -S qt6-tools-desktop`
```
#获取窗口属性
qdbus6 org.kde.KWin /KWin queryWindowInfo
#查看窗口使用Xwayland或原生Wayland、表面、输入事件、剪贴板内容等
qdbus6 org.kde.KWin /KWin org.kde.KWin.showDebugConsole
```
d-feet软件获取dbus树
### 5.协助翻译
`https://zh.crowdin.com/project/kdeorg/zh-CN`
### 6.KDE开发
按照`https://develop.kde.org/docs/getting-started/building/kde-builder-setup/#configure-git`要求配置账户等(可暂时忽略)
添加`/etc/profile`环境变量：
```
export PATH=$PATH:~/.local/bin/
```
安装额外cmake库、plasma-sdk、qt文档、插件编译依赖：
```
sudo pacman -S extra-cmake-modules-git plasma-sdk qt5-base qt6-base qt5-doc qt6-doc kdevelop-pg-qt
#kde-builder相关
cd ~
curl 'https://invent.kde.org/sdk/kde-builder/-/raw/master/scripts/initial_setup.sh' > initial_setup.sh
#升级或者配置kde-builder
bash initial_setup.sh
#生成配置文件~/.config/kde-builder.yaml
kde-builder --generate-config
#根据发行版安装构建依赖
kde-builder --install-distro-packages
#自我升级
kde-builder --self-update
```
滚动发行版(如archlinux)：
编辑`~/.config/kde-builder.yaml`配置`include-dependencies: false`
kdevelop：
编辑`~/.config/kde-builder.yaml`配置`cmake-options: > -DCMAKE_BUILD_TYPE=Debug`
添加环境变量：将`~/kde/build/*/prefix.sh`的环境变量保存到`~/kde/expanded-prefix-sh.txt`中并导入到kdevelop中
## 六、实用操作
### 1.tar多线程
```
#压缩
tar --use-compress-program="pigz -p 32" -cvf EVE.tar.gz ./EVE
#解压
tar --use-compress-program="pigz -p 32" -xvf archive.tar.gz
```
### 2.解压缩
```
# 乱码，big5台湾，gbk-windows
unzip -O GBK -d path file.zip
# rar
unrar -x file.rar
```
