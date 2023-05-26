alias reload!='. ~/.zshrc'
alias ctags="`brew --prefix`/bin/ctags"

alias python=python3
alias vim=nvim

# grc overides for ls
# requires "brew install coreutils"
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi
