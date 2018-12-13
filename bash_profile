# Prompt
export PS1="\u@\h:\W > "

# iTerm2 profile
function it2prof
{ 
    echo -e "\033]50;SetProfile=$1\a"
}

function streamq () {
    echo "$@"
    streamfp "-query -noLog -meanNorm -fpOnly -inWavFile" "$@" -outFile "${@/.wav/.rfp}"
}

# Aliases file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# AWS Setup
export JAVA_HOME=$(/usr/libexec/java_home)
export EC2_HOME=/usr/local/ec2/ec2-api-tools-1.7.5.0

# for training purpose, you can use the sandbox bucket: gn5455-sandbox-terraform-state
export TF_WRAPPER_BUCKET=gn5452-ar-terraform-state
export TF_WRAPPER_AWS_PROFILE=nonprod
export TF_WRAPPER_BUCKET_REGION=us-west-2

function cdl {
    builtin cd "$@" && ls -lhG
}

# PATH
PYTHONPATH=/usr/bin/python:$PYTHONPATH
TEX=/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin
export PATH=/usr/local/bin:/usr/local/share/python:$TEX:$PYTHONPATH:$EC2_HOME/bin:/Users/jscott/bin:$PATH

# History Control
export HISTCONTROL=ignoredups:erasedups

# Remote terminal colors
export PROMPT_COMMAND='/usr/bin/python ~/.make_prompt 255 159 33'

# LS colors
export CLICOLOR=1;
export LSCOLORS=exfxcxdxbxegedabagacad;

# Perforce
export P4CONFIG=.p4config

# GIT
if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
  . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi
