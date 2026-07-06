_plugin_load https://github.com/jeffreytse/zsh-vi-mode zsh-vi-mode.zsh

# 启用系统剪切板
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
# 链接打开方式
ZVM_OPEN_CMD='xdg-open'

# 指示显示
vim_mode="%F{8}[Insert]%f"
function zvm_after_select_vi_mode() {
    case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
        vim_mode="%F{8}[NORMAL]%f"
        zle reset-prompt
        ;;
    $ZVM_MODE_INSERT)
        vim_mode="%F{8}[INSERT]%f"
        zle reset-prompt
        ;;
    $ZVM_MODE_VISUAL)
        vim_mode="%F{8}[VISUAL]%f"
        zle reset-prompt
        ;;
    $ZVM_MODE_VISUAL_LINE)
        vim_mode="%F{8}[VISUAL_LINE]%f"
        zle reset-prompt
        ;;
    $ZVM_MODE_REPLACE)
        vim_mode="%F{8}[REPLACE]%f"
        zle reset-prompt
        ;;
    esac
}
setopt PROMPT_SUBST
RPROMPT='${vim_mode}'

# 禁用光标修改
ZVM_CURSOR_STYLE_ENABLED=false
