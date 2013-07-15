alias r='rbenv local 1.8.7-p358'

alias ss='script/server'
alias sc='script/console'
alias sg='script/generate'
alias sd='script/destroy'

alias b='bundle'
alias be='b exec'
alias bec='be cucumber'
alias po='be exec rake smartling:push smartling:pull'
alias deploy='be cap $(git_branch) deploy'
alias migrate='be rake db:migrate db:test:prepare'
alias cc='be compass compile'
