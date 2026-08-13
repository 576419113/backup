_plugin_load() {
    local plugin_url="$1"
    local plugin_relpath="$2"
    local plugins_dir="$HOME/.local/share/zsh/plugins"
    if [[ ! -d "$plugins_dir" ]]; then
        mkdir -p "$plugins_dir"
    fi
    local plugin_path="$plugins_dir/${plugin_url:t}/$plugin_relpath"
    if [[ ! -f "$plugin_path" ]]; then
        echo "Installing plugin ${plugin_url:t}..."
        git clone "$plugin_url" "$plugins_dir/${plugin_url:t}">/dev/null
        echo "Plugin installed successfully."
    fi
    source "$plugin_path"
}

_source_zsh() {
    if [[ -f "$HOME/.config/zsh/$1.zsh" ]]; then
        source "$HOME/.config/zsh/$1.zsh"
    fi
}

_source_zsh prompt
_source_zsh alias
_source_zsh complete
_source_zsh highlighting
_source_zsh history
_source_zsh vi-mode

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/beiming/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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

