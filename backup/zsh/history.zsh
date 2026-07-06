HISTFILE=$HOME/.config/zsh/.zsh_history       # 历史文件存放位置
HISTSIZE=10000                # 内存中保留条数
SAVEHIST=10000                # 写入文件的最大条数

setopt INC_APPEND_HISTORY     # 每条命令立即追加，而非退出时写入
setopt SHARE_HISTORY          # 多终端会话共享历史
setopt HIST_IGNORE_DUPS       # 不记录连续重复的命令
setopt HIST_IGNORE_SPACE      # 以空格开头的命令不记录
setopt HIST_SAVE_NO_DUPS      # 保存时去除重复
setopt HIST_REDUCE_BLANKS     # 去掉多余空格再存
# 上下键查找历史记录
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search     # 上箭头
bindkey '^[[B' down-line-or-beginning-search   # 下箭头
