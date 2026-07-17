-- ============================================================
-- 动画曲线
-- ============================================================
hl.curve("easeInSine", { type = "bezier", points = { {0.12, 0}, {0.39, 0} } })
hl.curve("easeOutSine", { type = "bezier", points = { {0.61, 1}, {0.88, 1} } })
hl.curve("easeInOutSine", { type = "bezier", points = { {0.37, 0}, {0.63, 1} } })


-- ============================================================
-- 动画配置
-- ============================================================

-- 窗口
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2, bezier = "easeInSine", style = "popin 20%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "easeOutSine", style = "popin 20%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1.8, bezier = "easeInOutSine" })

