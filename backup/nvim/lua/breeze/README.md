高亮组文件结构：
```
groups/
    treesitter.lua
    lsp.lua
    common.lua
    editor.lua
```
工具使用：
`treesitter-gen.lua`用于从本地 treesitter 配置生成 lua 文件(不会覆盖已有配置)
`raw2group.py`用于从文档中复制的部分生成 lua 文件(会覆盖已有配置，故脚本尝试不生成)
高亮组获取：
```
# lsp 高亮组
:help lsp-highlight
# 常规高组
:help group-name
# 编辑器高亮组
:help highlight-groups
```
