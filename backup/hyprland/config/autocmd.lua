-- Hyprland 启动时自动启动
hl.on("hyprland.start", function()
    -- hyprpaper 壁纸
    hl.exec_cmd("hyprpaper")
    -- fcitx5 输入法
    hl.exec_cmd("fcitx5 --replace -d")
    -- Quickshell
    hl.exec_cmd("qs")
end)
