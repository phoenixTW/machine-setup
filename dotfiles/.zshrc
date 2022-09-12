export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
	git
	zsh-autosuggestions
    terraform
    autojump
)

source $ZSH/oh-my-zsh.sh

# User configuration

. /usr/local/opt/asdf/libexec/asdf.sh
alias tg="terragrunt"
