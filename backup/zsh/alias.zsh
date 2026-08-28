# 常见命令
alias ls='ls --color=auto'
alias tree="tree -C"
alias grep='grep --color=auto'
alias python='python3'
alias mkdir='mkdir -p -v'
# C/C++ 调试安全编译
alias gg++='g++ -std=c++20 -g -Og -fstack-protector-all -fstack-check -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_GLIBCXX_ASSERTIONS -fsanitize=address,undefined,leak -fsanitize-address-use-after-scope -fsanitize=float-divide-by-zero -fsanitize=float-cast-overflow -fno-omit-frame-pointer -fno-optimize-sibling-calls'
alias ggcc='gcc -g -Og -fstack-protector-all -fstack-check -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_GLIBCXX_ASSERTIONS -fsanitize=address,undefined,leak -fsanitize-address-use-after-scope -fsanitize=float-divide-by-zero -fsanitize=float-cast-overflow -fno-omit-frame-pointer -fno-optimize-sibling-calls'
# nvim编辑器
alias vim='nvim'
alias nano='nvim'
alias vi='nvim'
# 快速编辑 HyprArch 文件
alias vihyprarch='nvim ~/Documents/HyprArch.md'
# alist 数据目录
alias alist='cd ~/.local/share/alist; alist'
# 启动 llama.cpp
alias llama='~/Projects/llama.cpp/build/bin/llama'

# cd config/data
cdc() {
    cd "$HOME/.config/$1"
}
cdd() {
    cd "$HOME/.local/share/$1"
}

# LAMP 服务
lamp() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: lamp start|stop|restart"
        return 1
    fi
    case $1 in
        start|stop|restart) ;;
        *)
            echo "Usage: lamp start|stop|restart"
            return 1
            ;;
    esac
    echo "sudo systemctl $1 httpd php-fpm mariadb"
    sudo systemctl $1 httpd php-fpm mariadb
}
