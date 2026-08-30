#!/bin/bash

# ===== 用户配置区域 =====
PROTON_PATH="/usr/share/steam/compatibilitytools.d/proton-cachyos-slr"
#APP_EXE="$HOME/.local/share/Steam/steamapps/common/Life Is Strange/《奇异人生》虎头汉化简体精校汉化补丁4.1.exe"             # 替换为你的应用路径
PFX_DIR="$HOME/.local/share/Steam/steamapps/compatdata/1388880"       # 独立前缀目录
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
export PROTON_USE_PIPEWIRE=1                  # 使用 pipewire 后端
export WINE_AUDIO_DRIVER="alsa"      # 指定 wine 音频后端
export PROTON_LOG=1                           # 启用日志
export PROTON_LOG_DIR="/tmp"                  # 日志路径
export PROTON_CRASH_REPORT_DIR="/tmp"         # 日志重定向到临时目录
export PROTON_LOCAL_SHADER_CACHE=1            # 非 steam 游戏使用本地缓存
# dxvk 配置
export DXVK_ASYNC=1                           # 启用异步着色器编译
export DXVK_STATE_CACHE=1               # 启用状态缓存（本次全重编）
export DXVK_STATE_CACHE_PATH="$HOME/.cache/dxvk" #着色器缓存路径
export DXVK_SHADER_CACHE_PATH="$HOME/.cache/dxvk"
export DXVK_CONFIG_FILE="$HOME/.config/dxvk/dxvk.conf"   # 启用外部配置
# vkd3d 配置(着色器缓存)
export VKD3D_SHADER_CACHE_PATH="$HOME/.cache/vkd3d"
export VKD3D_DEBUG=trace
export VKD3D_SHADER_DEBUG=trace
export VKD3D_LOG_FILE="$HOME/.config/vkd3d/vkd3d.log"
# 英伟达配置(OpenGL多线程优化，着色器缓存，nvapi，DLSS指示)
export __GL_THREADED_OPTIMIZATIONS=1
export __GL_SHADER_DISK_CACHE=1
export __GL_SHADER_DISK_CACHE_PATH="$HOME/.nv/GLCache"
export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
export __GL_SHADER_DISK_CACHE_SKIP_VALIDATION=1
export PROTON_ENABLE_NVAPI=1
export PROTON_DLSS_INDICATOR=1
#export PROTON_VKD3D_HEAP=1 VKD3D_CONFIG=sync,descriptor_heap
export PROTON_DXVK_GPLASYNC=1
export GST_PLUGIN_PATH=/usr/lib/gstreamer-1.0
# 游戏指示
export MANGOHUD=1
export DXVK_HUD=compiler
# 字体配置
export FREETYPE_PROPERTIES="truetype:interpreter-version=40 autofitter:warping=1 cff:hinting-engine=adobe pcf:no-long-family-names=1"
export WINEDLLOVERRIDES="winemenubuilder.exe=d"  # 禁用桌面集成


# 初始化 Wine 前缀 (首次运行需要)
if [ ! -d "$PFX_DIR/pfx" ]; then
    echo "正在初始化 Wine 前缀..."
    "$PROTON_PATH/proton" run wineboot -u
fi

# 启动应用程序
echo "使用 Proton-Cachyos 启动应用程序..."
"$PROTON_PATH/proton" run winecfg
