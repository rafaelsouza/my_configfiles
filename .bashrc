# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
#increase history size
HISTSIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls -l --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#enable bash completion of rake tasks
#complete -C /home/rafael/rake_completion -o default rake
complete -C /home/rafael/.rake_completion.rb -o default rake



###########################
## New ones from me and merged with some from Zeke's bash file
###########################

# Remove ~ files
alias rm~="find . -iname '*~' | sed -e 's/ /\\ /g' | xargs rm"

# Getting around to some dirs
alias ..='cd ..'

# Use this to go back through the 'cd' history
alias b='popd > /dev/null'

# Ruby/Rails
alias c='script/console'
alias s='script/server'
alias s2='script/server -p3010'
alias irb='irb --readline -r irb/completion'
alias gemlist='gem list | egrep -v "^( |$)"'
#alias gs="gem server & sleep 1; open 'http://localhost:8808'" # conflict with Git Status
alias pdoc="open -a Firefox ./doc/plugins/"
alias rdbm="rake db:migrate"
alias rdbb="rake db:bootstrap:load"
alias rdbreset="rake db:migrate VERSION=0 && rake db:migrate VERSION=0 RAILS_ENV=test && rake db:migrate && rake db:migrate RAILS_ENV=test"

# RSpec
# spec => rake spec
alias spec='rake spec'
# specm <model_name>
function specm {
  ./vendor/plugins/rspec/bin/spec -o spec/spec.opts ./spec/models/$1_spec.rb
}
# specc <controller_name>
function specc {
  ./vendor/plugins/rspec/bin/spec -o spec/spec.opts ./spec/controllers/$1_controller_spec.rb
}


# Mysql, place here your frequent projects
alias myfam='mysql -u root -p'

# SVN
alias up='svn up'
alias ci='svn ci'
alias st='svn st'

# Git
alias pull='git pull'
alias push='git push'
alias gb='git branch -a -v'
alias gs='git status'
alias gd='git diff'
# gc message  => git commit -a -m "Message"
function gc {
  git commit -a -m $1
}
# gcp message  => git commit -a -m "Message" ; git push
function gcp {
  git commit -a -m $1; git push
}

# deploy application  "Message"
function deploy_app {
    gcp $1 ; cap deploy;
}

# What is my ip?
alias myip='curl "http://www.networksecuritytoolkit.org/nst/cgi-bin/ip.cgi"'


# Devcockpit setup task
alias devcockpit='rdbreset;rake db:bootstrap; rake db:bootstrap RAILS_ENV=test; annotate;rake spec;'

# Skype conflict, make sound with skype work
alias skype_work='killall -s9 firefox; killall -s9 opera; killall -s9 skype; killall -s9 pulseaudio;'

#Base for rails app
function railsapp {
  template=$1
  appname=$2
  shift 2
  rails $appname -m http://github.com/jeremymcanally/rails-templates/raw/master/$template.rb $@
}

function clean_app {
  cap deploy:cleanup
}


export PATH=/var/lib/gems/1.8/bin:$PATH

