-- 光标
hl.env("XCURSOR_THEME", "breeze_cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- fcitx5
hl.env("XIM", "fcitx5")
hl.env("XIM_PROGRAM", "fcitx5")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "ibus")

-- GTK 应用
hl.env("GTK_USE_PORTAL", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("GTK_THEME", "Breeze")

-- Qt 应用
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_STYLE_OVERRIDE", "Breeze")
