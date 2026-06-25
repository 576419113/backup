autoload -Uz promptinit
promptinit

# 图标
arch_icon=$'\Uf08c7'
folder_icon=$'\Uf024b'
account_icon=$'\Uf0004'
python_icon=$'\Ue73c'
newline=$'\n'

# 构造 conda
_conda_env() {
    [[ -n "$CONDA_DEFAULT_ENV" ]] && \
        echo "${python_icon} conda:$(basename "$CONDA_DEFAULT_ENV") "
}

# 构造主体
_build_ps_com() {
    PS_COM="%B%F{14}$(_conda_env)%F{10}${account_icon} %n@%m %F{12}${arch_icon} $(uname -r) %F{13}${folder_icon} %~>%f%b${newline}%F{8}└───%B%F{11}%# %f%b"
}

# 自动执行
precmd() {
    local exit_code=$?
    _build_ps_com
    if [[ $exit_code -eq 0 ]]; then
        EXIT_STATUS="%B%F{2}^_^ exitcode: $exit_code%f%b"
    else
        EXIT_STATUS="%B%F{1}O_O exitcode: $exit_code%f%b"
    fi
    PROMPT="${EXIT_STATUS}${newline}%F{8}├─%f ${PS_COM}"
}
