################
#  环境变量路径  #
################
typeset -U path PATH
# cargo 路径
path=($HOME/.cargo/bin $path)
export PATH
