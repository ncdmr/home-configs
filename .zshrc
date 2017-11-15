# Path to your oh-my-zsh configuration.
ZSH=~/Repos/oh-my-zsh
if [[ -d $ZSH ]]; then
    # Set name of the theme to load.
    # Look in ~/.oh-my-zsh/themes/
    # Optionally, if you set this to "random", it'll load a random theme each
    # time that oh-my-zsh is loaded.
    ZSH_THEME="candy"

    # Set to this to use case-sensitive completion
    # CASE_SENSITIVE="true"

    # Comment this out to disable bi-weekly auto-update checks
    DISABLE_AUTO_UPDATE="true"

    # Uncomment to change how often before auto-updates occur? (in days)
    # export UPDATE_ZSH_DAYS=13

    # Uncomment following line if you want to disable colors in ls
    # DISABLE_LS_COLORS="true"

    # Uncomment following line if you want to disable autosetting terminal title.
    # DISABLE_AUTO_TITLE="true"

    # Uncomment following line if you want to disable command autocorrection
    # DISABLE_CORRECTION="true"

    # Uncomment following line if you want red dots to be displayed while waiting for completion
    # COMPLETION_WAITING_DOTS="true"

    # Uncomment following line if you want to disable marking untracked files under
    # VCS as dirty. This makes repository status check for large repositories much,
    # much faster.
    # DISABLE_UNTRACKED_FILES_DIRTY="true"

    # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
    # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    plugins=(git python perl)

    source $ZSH/oh-my-zsh.sh

    # date & time left aligned
    if [[ ${EUID} == 0 ]] ; then
    PROMPT=$'%{$fg_bold_bold[red]%}%n%{$fg_bold[white]%}//%{$fg[yellow]%}%m %{$reset_color%}%{$fg[yellow]%}[%~]%{$reset_color%} \
    %{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '
    else
    PROMPT=$'%{$fg[white]%}%D{[%y.%m.%d-%R:%S]} %{$fg_bold[green]%}%n%{$fg[white]%}//%{$fg_bold[yellow]%}%m %{$reset_color%}%{$fg[yellow]%}[%~]%{$reset_color%} \
    %{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '
    fi
else 
    echo "WARNING: $ZSH is not available.  Continuing with native zsh config."
fi
# vi syntaxis. Of course.
set -o vi
# aliases
alias ll="ls -lrht"
export PATH=$PATH:~/bin:/usr/local/bin
#####
# docker aliases
#####
# Kill all running containers.
alias dockerkillall='docker kill $(docker ps -q)'
# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'
# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'

#####
# Git Informational aliases.
#####
alias gbranch='git name-rev --name-only HEAD'
alias gcurrent='git log -1 --oneline'
alias gfiles='git ls-tree --name-only -r $(git name-rev --name-only HEAD)'
alias gours='git ls-files --unmerged | cut -f2 | uniq | xargs git checkout --ours'
alias gstage='git diff-index --cached --name-only HEAD'
alias gtheirs='git ls-files --unmerged | cut -f2 | uniq | xargs git checkout --theirs'
alias gtree='git log --graph --all --pretty=format:"%Cred%h%Creset - %Cgreen(%cr)%Creset %s%C(yellow)%d%Creset" --abbrev-commit --date=relative'
#####
# various
#####
alias scan='sudo nmap -sS -PN'
alias subs='subliminal download -l en *'
