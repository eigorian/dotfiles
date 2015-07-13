# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Usage: remig [stage]
# if no stage is specified, development will be used
function remig() {
  stage=$1
  if [[ -z $stage ]]; then
    stage="development"
  fi

  echo "Remigrating $stage"

  PADRINO_ENV=$stage bundle exec rake ar:drop && \
  PADRINO_ENV=$stage bundle exec rake ar:create && \
  PADRINO_ENV=$stage bundle exec rake ar:migrate
}

# Usage: remas [stage]
# if no stage is specified, development will be used
function remas() {
  stage=$1
  if [[ -z $stage ]]; then
    stage="development"
  fi

  echo "Remastering $stage"

  PADRINO_ENV=$stage bundle exec rake ar:migrate && \
  PADRINO_ENV=$stage bundle exec rake master:all && \
  PADRINO_ENV=$stage bundle exec rake db:seed
}

alias sss='bundle exec padrino s -h 0.0.0.0'

