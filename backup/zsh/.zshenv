################
#  环境变量路径  #
################
typeset -U path PATH
# cargo 路径
path=("$HOME/.cargo/bin" $path)
# qt6 路径
path=("/usr/lib/qt6/bin" $path)
# local bin 路径
path=("$HOME/.local/bin" $path)
export PATH


###############
#  环境变量值  #
###############
export EDITOR="nvim"        # 默认文本编辑器
