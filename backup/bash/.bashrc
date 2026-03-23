# 命令缩写
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias python='python3'
alias mkdir="mkdir -p -v"
alias gg++="g++ -std=c++20 -g -Og -fstack-protector-all -fstack-check -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_GLIBCXX_ASSERTIONS -fsanitize=address,undefined,leak -fsanitize-address-use-after-scope -fsanitize=float-divide-by-zero -fsanitize=float-cast-overflow -fno-omit-frame-pointer -fno-optimize-sibling-calls"
alias ggcc="gcc -g -Og -fstack-protector-all -fstack-check -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_GLIBCXX_ASSERTIONS -fsanitize=address,undefined,leak -fsanitize-address-use-after-scope -fsanitize=float-divide-by-zero -fsanitize=float-cast-overflow -fno-omit-frame-pointer -fno-optimize-sibling-calls"

# 设置vim为默认文本编辑器
export EDITOR=vim

# 如果不是交互式Shell，则在此停止，不再加载下面的配置
if [[ $- != *i* ]]; then
    return
fi

# bash提示符样式
arch_icon=$(echo -e "\Uf08c7")
bash_icon=$(echo -e "\Ue760")
folder_icon=$(echo -e "\Uf024b")
account_icon=$(echo -e "\Uf0004")
python_icon=$(echo -e "\Ue73c")
STRONG="\[\e[1m\]"
SHORT="\[\e[2m\]"
RESET="\[\e[0m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
ORANGE="\[\e[33m\]"
BLUE="\[\e[34m\]"
PURPLE="\[\e[35m\]"
CYAN="\[\e[36m\]"
WHITE="\[\e[37m\]"
_conda_env() {
    if [ ! -z "$CONDA_DEFAULT_ENV" ]; then
        echo "$python_icon conda:""$(basename $CONDA_DEFAULT_ENV)"" "
    else
        echo ""
    fi
}
_build_ps_com(){
    PS_COM="$STRONG$CYAN$(_conda_env)$GREEN$account_icon \u@\h $WHITE$bash_icon \v $BLUE$arch_icon $(uname -r) $PURPLE$folder_icon \w>$RESET\n$SHORT$WHITE└───$RESET $STRONG$ORANGE\$ $RESET"
}
_set_prompt() {
    local exit_code=$?
    _build_ps_com
    _exit_status(){
        if [ $exit_code -eq 0 ];then
            echo "$SHORT$STRONG$GREEN^_^ exitcode: $exit_code$RESET";
        else
            echo "$SHORT$STRONG${RED}O_O exitcode: $exit_code$RESET";
        fi
    }
    PS1="$(_exit_status)$SHORT$WHITE\n├─$RESET "$PS_COM
}
PROMPT_COMMAND=_set_prompt

# 启用fcitx5
export XIM=fcitx5
export XIM_PROGRAM=fcitx5
export XMODIFIERS=@im=fcitx
export GLFW_IM_MODULE=fcitx5

# 使用llama.cpp环境变量
export PATH=$PATH:/home/beiming/Program/llama.cpp/build/bin/

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/beiming/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/beiming/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/beiming/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/beiming/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
