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
alias b="bundle"
alias bi="bundle install"
alias be="bundle exec"
alias g="git"
alias cml="em CMakeLists.txt"

alias f="find . | xargs grep"
alias p="pushd"
alias o="popd"
alias op="gnome-open"
alias grep="grep --color=auto"

PATH=/local1/git/bin:/local1/emacs-v23.3/bin:/usr/local/texlive/2011/bin/x86_64-linux:/opt/android-sdk-linux/platform-tools:$PATH 
export PATH

export PATH=${PATH}:~/Installs/android-sdk-linux/tools
export PATH=${PATH}:~/Installs/android-sdk-linux/platform-tools

export EDITOR=em

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
