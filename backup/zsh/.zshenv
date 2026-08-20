################
#  环境变量路径  #
################
typeset -U path PATH
# cargo 路径
path=($HOME/.cargo/bin $path)
# conda 路径
path=($HOME/miniconda3/bin $path)
export PATH


###############
#  环境变量值  #
###############
export EDITOR="nvim"        # 默认文本编辑器
