# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

BASH_NEWLINE="\n"
BASH_GRAY="\[\e[1;30m\]"
BASH_LIGHT_GREEN="\[\e[1;32m\]"
BASH_WHITE="\[\e[1;0m\]"
BASH_LIGHT_GRAY="\[\e[0;37m\]"

# Get git branch on terminal
function parse_git_branch {

    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
    echo "["${ref#refs/heads/}"]";

}



PS1="\W\$(parse_git_branch)${BASH_WHITE}\$ ";

# Fix LS colors
export LS_COLORS='di=01;33'

# User specific aliases and functions
default_client=karma
export LIMS_VER='9.2'
export LIMS=~/LIMS2/tech/lims_m${LIMS_VER}
export MLIB=${LIMS}/lib/aibs/module_support
export LIMS_RBY='rvm use 1.8.7' 
alias lims="cd ${LIMS}; export P4CLIENT=${default_client}; ${LIMS_RBY}"
alias modbin="cd ~/lims2_mods/; export P4CLIENT=lims2_modules_skyf; ${LIMS_RBY}"
alias modlib="cd ${MLIB}; export P4CLIENT=#${default_client}; ${LIMS_RBY}"
alias microarray="cd ~/Microarray; export P4CLIENT=microexpression_skyf"
alias aibs="lims; cd lib/aibs"
alias vendor="lims; cd vendor/plugins"

alias b="bundle"
alias bi="bundle install"
alias be="bundle exec"
alias g="git"
alias p="p4"

alias f="find . | xargs grep"

PATH=/local1/git/bin:/local1/emacs-v23.3/bin:$PATH
export PATH

export EDITOR=/local1/emacs-v23.3/bin/emacs

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
