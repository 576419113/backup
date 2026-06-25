## 结构
```
groups/
    treesitter/
    lsp/
    treesitter.lua
    lsp.lua
treelsp-gen.lua
```
## 概述
本项目全部采用基于 nvim 的 lua 环境实现
`treelsp-gen` 用于自动生成 treesitter 与 lsp 高亮组名称(包含主文件和分文件类型文件)，会保留已配置的数据，删除本地不存在的组名。
