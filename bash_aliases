# LS
alias ls='ls --color=auto'
alias li='ls -lhGo'
alias la='ls -a'
alias ll='ls -l'

# GREP
alias grep='grep --color'

# GIT
alias gits='git status'
alias gpom='git push origin master'

# Docker
alias docker='sudo docker'
alias docker-nvidia='sudo docker-nvidia'

# MONGO
if [ "$(uname)" == "Darwin" ]; then 
    alias startmongo='brew services start mongodb-community@4.4'
    alias stopmongo='brew services stop mongodb-community@4.4'
elif [ "$(uname)" == "Linux" ]; then
    alias startmongo='sudo systemctl start mongodb'
    alias stopmongo='sudo systemctl stop mongod'
fi
