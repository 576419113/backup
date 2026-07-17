hl.config({
    general = {
        border_size = 2,    -- 边框大小
        gaps_in = 5,        -- 窗口边距
        gaps_out = 15,      -- 外边距
        col = {
            -- 激活窗口
            active_border = { colors = {"rgb(3daee9)", "rgb(1d99f3)"}, angle = 45 },
            -- 非激活窗口
            inactive_border = "rgba(00000000)",
        },
        layout = "scrolling",    -- 布局样式
        locale = "zh_CN",        -- 覆盖语言环境
    },
    decoration = {
        rounding = 5,              -- 圆角大小
        rounding_power = 4,        -- 圆角力度
        active_opacity = 1.0,      -- 激活窗口透明度
        inactive_opacity = 1.0,    -- 非激活窗口透明度
        blur = { enabled = false },        -- 禁用模糊
        shadow = { enabled = false },     -- 禁用阴影
    },
    animations = {
        enabled = true,
    },
    misc = {
        disable_hyprland_logo = true,         -- 禁用默认壁纸
        disable_splash_rendering = true,      -- 禁用版本文字
        -- 更改字体
        font_family = "Noto Sans CJK SC",
        splash_font_family = "Noto Sans CJK SC",
        vrr = 1,    -- 可变刷新率
        key_press_enables_dpms = true,        -- 按键中断睡眠
        render_unfocused_fps = 10,            -- 非聚焦窗口渲染帧率
        background_color = "rgb(232627)",     -- 背景颜色
    },
    cursor = {
        inactive_timeout = 15,                -- 鼠标自动隐藏
    },
    ecosystem = {
        no_update_news = true,        -- 不显示更新新闻
        no_donation_nag = true,       -- 不显示捐赠请求
    },
})
