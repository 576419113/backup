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
# cd config/data nvim
alias cdcnvim='cd ~/.config/nvim'
alias cddnvim='cd ~/.local/share/nvim'
# cd config zsh
alias cdczsh='cd ~/.config/zsh'
# cd config kitty
alias cdckitty='cd ~/.config/kitty'
