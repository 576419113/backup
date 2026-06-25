# 载入社区补全
_plugin_load https://github.com/zsh-users/zsh-completions zsh-completions.plugin.zsh
# 载入自动补全
_plugin_load https://github.com/marlonrichert/zsh-autocomplete zsh-autocomplete.plugin.zsh

zstyle ':completion:*' menu select        # Tab 补全出现可方向键选择的菜单
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # 补全忽略大小写
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # 补全列表带颜色
zstyle ':autocomplete:*' delay 0.1    # autocomplete 延迟
zstyle ':autocomplete:*' add-semicolon no    # 补全项不显示分号
# 补全显示最大行数
zstyle -e ':autocomplete:*:*' list-lines 'reply=( $(( LINES / 3 )) )'

# 回车执行命令
bindkey -M menuselect '\r' .accept-line
