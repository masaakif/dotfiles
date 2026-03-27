# ls options
if type lsd > /dev/null 2>&1; then
  alias ls='lsd'
else
  alias ls='ls --color=auto -F'
fi

# rg options
alias rg="rg -g '!.git/' --hidden"

# aptをsudoなし、パスワードなしで実行できるようにする
alias apt='sudo apt'
alias apt-get='sudo apt-get'
alias add-apt-repository='sudo add-apt-repository'
alias visudo='sudo -E visudo'

