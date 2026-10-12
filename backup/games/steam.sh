#!/bin/bash
set -e
export XMODIFIERS=@im=fcitx        #解决输入法问题
export PROTON_USE_NTSYNC=1                    # 启用ntsync
export PROTON_USE_PIPEWIRE=1                  # 使用 pipewire 后端
export WINE_AUDIO_DRIVER="pipewire,alsa"      # 指定 wine 音频后端
export PROTON_LOG=1                          # 启用日志
export PROTON_LOG_DIR="/tmp"                 # 日志路径
export PROTON_CRASH_REPORT_DIR="/tmp"        # 日志重定向到临时目录
export PROTON_LOCAL_SHADER_CACHE=1            # 非 steam 游戏使用本地缓存
# dxvk 配置
export DXVK_ASYNC=1                           # 启用异步着色器编译
export DXVK_STATE_CACHE=1                     # 启用状态缓存
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
# 使用系统 gstreamer
export GST_PLUGIN_PATH=/usr/lib/gstreamer-1.0
# 游戏指示
export MANGOHUD=1
export DXVK_HUD=compiler
# 字体配置
export FREETYPE_PROPERTIES="truetype:interpreter-version=40 autofitter:warping=1 cff:hinting-engine=adobe pcf:no-long-family-names=1"
export WINEDLLOVERRIDES="winemenubuilder.exe=d"  # 禁用桌面集成

# 启动游戏
exec "$@"
