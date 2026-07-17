-- ============================================================
-- 可配置区域
-- ============================================================

-- 终端
local terminal = "kitty"
-- 颜色选择器
local color_picker = "hyprpicker"


-- ============================================================
-- 一般配置
-- ============================================================

-- 控制主键
local mainKey = "SUPER"
-- 新终端
hl.bind(mainKey .. " + Q", hl.dsp.exec_cmd(terminal))
-- 关闭窗口
hl.bind(mainKey .. " + C", hl.dsp.window.close())
-- 退出 Hyprland
hl.bind(mainKey .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
-- 仿 vi 切换窗口焦点
hl.bind(mainKey .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainKey .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainKey .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainKey .. " + J", hl.dsp.focus({ direction = "down" }))
-- 选取屏幕颜色
hl.bind(mainKey .. " + P", hl.dsp.exec_cmd(color_picker))
-- 窗口全屏
hl.bind(mainKey .. " + F", hl.dsp.window.fullscreen())
-- Quickshell 搜索框
hl.bind(mainKey .. " + R", hl.dsp.exec_cmd("qs ipc call search toggleSearch"))


-- ============================================================
-- 滚动布局
-- ============================================================

-- 垂直分割当前列
hl.bind(mainKey .. " + comma", hl.dsp.layout("consume"))
-- 移出列尾窗口
hl.bind(mainKey .. " + period", hl.dsp.layout("expel"))
-- 改变列宽
hl.bind(mainKey .. " + minus", hl.dsp.layout("colresize -0.1"))
hl.bind(mainKey .. " + equal", hl.dsp.layout("colresize +0.1"))
-- 移动当前列
hl.bind(mainKey .. " + bracketleft", hl.dsp.layout("swapcol l"))
hl.bind(mainKey .. " + bracketright", hl.dsp.layout("swapcol r"))


-- ============================================================
-- 妙控键盘功能键
-- ============================================================

-- 亮度减弱
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e -n10 set 5%+"), { locked = true, repeating = true })
-- 亮度提升
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e -n10 set 5%-"), { locked = true, repeating = true })
-- 前一首
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
-- 暂停/播放
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
-- 下一首
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
