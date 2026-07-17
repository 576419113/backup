# 载入社区补全
_plugin_load https://github.com/zsh-users/zsh-completions zsh-completions.plugin.zsh

autoload -Uz compinit
compinit

eval "$(dircolors -b)"    # 读取 dircolors

zstyle ':completion:*' menu select        # Tab 补全出现可方向键选择的菜单
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # 补全忽略大小写
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # 补全列表带颜色
